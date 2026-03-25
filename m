Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB13EFD31;
	Wed, 25 Mar 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449829; cv=none; b=D1cZ3zDodHVcxljKBKU9yMvFZ6clVPRpqm+n04ZXY0uUslg1zrS0m2FZB5gnXGDX0ZM0yGT1wkxNRmHp2HsX6uzP5UBaHZD2wne4h6gaqg+A6SjrrI+QzU0qLOgdNfCc110AoMOJBhRPik7ejSrtNBiMrlwJaPN5Alk6qpQXCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449829; c=relaxed/simple;
	bh=fz0PH7iPdSPVhHcrWudA4xa1kfyWU1uxxd4GADXVVEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7YvNznYlA8G0xl1F6Dm2hz1w6BmY3BqDGkiuWTik1bVsE4X8j+dJ9ZQziGp62kStlCfoTBrdIx+kD6HMQ5HSXhMSb375twZE8T2EEwhRjIUalK/xs2CGHLD8oS85YPWPLQeDAFbrV/HU5b5yUgp33a8/yNFcvGG5fYR6AQK3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIw5e6wM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIw5e6wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D0C116C6;
	Wed, 25 Mar 2026 14:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449828;
	bh=fz0PH7iPdSPVhHcrWudA4xa1kfyWU1uxxd4GADXVVEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIw5e6wMpwqsBArxqgPqW29Eovlha+8sP/PTHAchI25czpN3OXsjCVgW7EgERL1c8
	 My3d17ab8a5zHMYQi8ouEaakQaf6sDq3Ru+E1qoq4aC81KWIntcvpBpN3ENlheg260
	 AzshRMXkeoyW75MWosBPPsriMsm2jUiS5Sk17GoyP6i9hd/HkSgtpMKUEqjtr6eRNi
	 PGYIwJHRPwdcbNYQykyQVOdpfPVQmHvgC5yYmUdK7xem6OIjfT5InA6UuSc92vudMU
	 +4fi066thhTqs6JDxPzKJ/zyFkzAAyaGzoz8mZW0V5PNOhQhXG0nBmo8C/awYzhZ8u
	 Zgb6fYSxrKMPg==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Wed, 25 Mar 2026 07:43:46 -0700
Message-ID: <20260325144347.87818-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <E4E214DB-E7C0-4B69-8DC2-2A9640BF5CC6@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 07:36:20 +0000 Josh Law <objecting@objecting.org> wrote:

> 
> 
> On 25 March 2026 01:16:52 GMT, SeongJae Park <sj@kernel.org> wrote:
> >Forwarding Sashiko review for doing discussions via mails.
> >
> ># review url: https://sashiko.dev/#/patchset/20260324154005.83651-1-objecting@objecting.org
> ># start of sashiko.dev inline review
> >commit ff5e227a18cd69435749b0aae0dc2c762c4f0a47
> >Author: Josh Law <objecting@objecting.org>
> >
> >mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
> >    
> >Hardware integer division is slow. The function damon_max_nr_accesses(),
> >which is called very frequently, performs an integer division.
> >However, the struct damon_attrs already caches this exact ratio in the
> >internal field aggr_samples. We can eliminate the hardware division in
> >the hot path by simply returning aggr_samples.
> >
> >> diff --git a/include/linux/damon.h b/include/linux/damon.h
> >> index d9a3babbafc1..04c8a052fcfb 100644
> >> --- a/include/linux/damon.h
> >> +++ b/include/linux/damon.h
> >> @@ -978,8 +978,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >>  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> >>  {
> >>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> >> -	return min(attrs->aggr_interval / attrs->sample_interval,
> >> -			(unsigned long)UINT_MAX);
> >> +	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
> >>  }
> >
> >If an administrator dynamically updates aggr_interval via sysfs and commits
> >the inputs, will attrs->aggr_samples be correctly recalculated?
> >
> >If aggr_samples becomes stale, kdamond_fn() will compute the real aggregation
> >loop count and allow r->nr_accesses to increment up to the new bounds (for
> >example, 80 loops). Meanwhile, damon_max_nr_accesses() will return the
> >stale aggr_samples cache (for example, 20).
> >
> >When evaluating schemes, damon_hot_score() normalizes r->nr_accesses against
> >this stale maximum, producing a freq_subscore that severely exceeds
> >DAMON_MAX_SUBSCORE. This causes the calculated hotness to exceed
> >DAMOS_MAX_SCORE.
> >
> >For DAMOS_PAGEOUT actions used by damon_reclaim, damon_cold_score() returns
> >DAMOS_MAX_SCORE - hotness, yielding a highly negative score.
> >
> >Could this negative score cause an out-of-bounds write on the
> >kernel heap when used as an array index?
> >
> >mm/damon/core.c:damos_walk() {
> >    ...
> >    c->regions_score_histogram[score] += damon_sz_region(r);
> >    ...
> >}
> >
> >> diff --git a/mm/damon/core.c b/mm/damon/core.c
> >> index db6c67e52d2b..afb058f7da5c 100644
> >> --- a/mm/damon/core.c
> >> +++ b/mm/damon/core.c
> >> @@ -587,6 +587,7 @@ struct damon_ctx *damon_new_ctx(void)
> >>  	ctx->attrs.sample_interval = 5 * 1000;
> >>  	ctx->attrs.aggr_interval = 100 * 1000;
> >>  	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
> >> +	ctx->attrs.aggr_samples = 20;
> >
> >Since this value is cached here, but not updated when intervals change, does
> >it remain permanently stale during dynamic updates?
> >
> >
> ># end of sashiko.dev inline review
> ># review url: https://sashiko.dev/#/patchset/20260324154005.83651-1-objecting@objecting.org
> >#
> ># hkml [1] generated a draft of this mail.  It can be regenerated
> ># using below command:
> >#
> >#     hkml patch sashiko_dev --for_forwarding \
> >#             20260324154005.83651-1-objecting@objecting.org
> >#
> ># [1] https://github.com/sjp38/hackermail
> >
> >Sent using hkml (https://github.com/sjp38/hackermail)
> 
> 
> 
> So it's nacked? Or is it just a review

Just a review from an AI :)

I treat sashiko review as just another review comments.  I'm forwarding these
in this way for a case that someone is interested in the comments and want to
share some findings from those in a way easy for mailing list based
communication.


Thanks,
SJ

[...]
