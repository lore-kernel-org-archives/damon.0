Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6B25B09D
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782064745; cv=none; b=UmFUHUl049FrwIh4xS9lbgVame7Oooije4fOO0x2nMQ44J5qRnMZGhOFkuhwVUicmUIEoR0tGZt5lroV4IdEOsE8EYqRimAJav2eCpn/m79smcyBbJYhlqXBnfHxAjrJVUcCuPy2uaf6DLBLvhYK4UygbNo94a+87w/G8Vk2V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782064745; c=relaxed/simple;
	bh=quac2cA3Mgc6cgMTXiCmjfNY8Ta1rnNZ0PgwemtNZs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksk78UZvyxY0paAIgEEgNe5DzH4FCGzwRWkintC6Cu5wZ+s22dAU3sW5CQyVSANjMB2qMFbbRmHnHfhyAoLmco14GbA2/Y2O0UZPlGHZkkvdWad46queH5ftTpcseXKz8wSQnE6ojZnNrmf3YXgHMmWIryy80QU5X4CMU7C9t3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPc7tTPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPc7tTPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED6B1F000E9;
	Sun, 21 Jun 2026 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782064743;
	bh=Av8t9bjDxcFId8Kxu2b3wAU213RWhgchomvKQVArUNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QPc7tTPJ0eX4dI9+q4HyaVpnKE4OuE5x/jNv2wwG788hHUE3sDt6XLWIaGOqrfiiy
	 /HMffQbk2b9t4re/2o88K83OJZ1Yv29pVx7BUXCqkEZxEQLSXrLX9PC1Ky+rsC8C5S
	 cewicvyuqK6f/CzKaZlnDGmuuCaxfZRfuuHbu3cEg6XSEg68jKyNGbZqQnv+IfWKqc
	 MWX2QzshfNBJ7Cd5ujLxKhHWm4N1HDY2Ny7lxGbMP9zWhiDlNG+eMl35hZAVuxNOq/
	 tQfqEHg6a7QJL+AaJH3/RDbtKh191ixwDkCwhaZBTL82VSnFSm5rn9QaxrTI2pc+kZ
	 dPXqQQ+8s4cGw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Sun, 21 Jun 2026 10:58:48 -0700
Message-ID: <20260621175849.91990-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621160300.EBD861F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 16:03:00 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] The patch resolves a divide-by-zero crash but inadvertently introduces a critical out-of-bounds heap array read and write when updating the region score histogram.
> --
> 
> commit ba1da1a76126be43fbfd5ff0c59d54a52b8cddf8
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle zero intervals in damon_max_nr_accesses()
> 
> This patch modifies damon_max_nr_accesses() to avoid a divide-by-zero
> when the user sets the sampling or aggregation interval to zero. It
> ensures the denominator and return value are at least 1.
> 
> Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 6f7edb3590ef9..888570f55b416 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  
> >  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> >  {
> > -	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> > -	return min(attrs->aggr_interval / attrs->sample_interval,
> > +	unsigned long sample_interval;
> > +	unsigned long max_nr_accesses;
> > +
> > +	sample_interval = attrs->sample_interval ? : 1;
> > +	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
> >  			(unsigned long)UINT_MAX);
> > +	return max_nr_accesses ? : 1;
> 
> [Severity: Critical]
> If sample_interval and aggr_interval are set to 0 via sysfs,
> damon_max_nr_accesses() now safely returns 1 instead of panicking.
> 
> However, damon_set_attrs() validation succeeds because
> attrs->sample_interval > attrs->aggr_interval evaluates to false (0 > 0).
> Because damon_update_monitoring_results() then skips resetting
> r->nr_accesses, it can retain a previous large value.
> 
> In mm/damon/ops-common.c:damon_hot_score(), the frequency subscore is
> calculated using the return value of damon_max_nr_accesses():
> 
> freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
> 
> Since max_nr_accesses is 1, a large r->nr_accesses will result in
> a hotness score that exceeds DAMOS_MAX_SCORE and is never explicitly
> clamped.
> 
> Later in mm/damon/core.c:damos_adjust_quota(), this score is used
> directly as an array index:
> 
> c->regions_score_histogram[score] += damon_sz_region(r);
> 
> Does this allow an out-of-bounds heap write when the histogram array
> is indexed by the unbounded score?

Good finding!  Nonetheless, this is introduced by another commit: commit
2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring
attributes").

I will post this patch again as a seris having the fix of newly found bug,
together.


Thanks,
SJ

[...]
