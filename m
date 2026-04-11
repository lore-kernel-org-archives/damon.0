Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC47386456;
	Sat, 11 Apr 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930162; cv=none; b=DTS6RsoWQQ+3aGsIGDQ7m+VZmnE8GzqCQ5Ap4iUwhhLDmVinRBCsXHTTTQq9FsoN+aKz9ElpgdIvywZE764WjKMbX8jQ8cQX5wnKhoSe/fkjYMC7Sj8mdjta94769ijeRB1Oer1MDzufyu6/PPn9qP37m3utSnCGIO8VfNePljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930162; c=relaxed/simple;
	bh=Ob5MmNNfLMwvmEBeU1tkxBH6cg05is6h9z9uqPS/UOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQOesYaXhxmt3lh9zOH5AQH6anPzGA49+VadwV8yK6IRGDjO1G9Q8ZpnlpUQO6kA17zJqoXAkvhe30QSRgfvSA3/QPPXo8DvCYnG/F9psZwRQAtBaXcAZlWNUtUxGD8RX05eB94pIRWot1bDqzFpcBpZrLyQ5737IAOkuW5gE1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMYYvYRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMYYvYRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D43C4CEF7;
	Sat, 11 Apr 2026 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775930161;
	bh=Ob5MmNNfLMwvmEBeU1tkxBH6cg05is6h9z9uqPS/UOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMYYvYRaX0oan2/dq1WNCKiOt9pZLbjFf5PmP3Z1DJkXUmGF13NBIBqaOSRFwUJhD
	 lWVsXRRmOukNNZ58qJ43Nd4F2YBbxRuqPVhA/vuWOBdXGB2vIqvhbP2VicWjiTnz6S
	 6nq3aA/UDV9FQt0eAFXS5ZKzcF7PuNUc6kEDlRwvVLWHfS0BMSA3i+ZNT+3Dk8crZA
	 Lks7+mar8gHkE4Thy8YzLgiHbBdw2nLUWNDRph9T5Op0bKGtz7ItJYMNicl5AQ5Ley
	 6NC6Up66L0uiOlf3W+IV4yY7tAchl1sKKtKIMkz6Pu9C53sEMJAHUonoYJehUIflyA
	 BV/uCUHSFs8Tg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5.1 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Sat, 11 Apr 2026 10:55:53 -0700
Message-ID: <20260411175554.79572-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: no blocker of this patch from sashiko review.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260411164908.77189-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit 2f0a2c02b528b6c75ac3074d06b729bc93bd8589
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle <min_region_sz remaining quota as empty
> 
> This commit updates DAMON quota handling to treat a remaining quota of
> less than min_region_sz as effectively fully charged. This ensures that
> charge_target_from and charge_addr_from of the quota are updated properly,
> avoiding applying DAMOS actions too frequently to specific memory areas.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 12544c60531d3..8dbc365bb8e97 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2127,8 +2140,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  			continue;
> >  
> >  		/* Check the quota */
> > -		if (damos_quota_is_set(quota) &&
> > -				quota->charged_sz >= quota->esz)
> > +		if (damos_quota_is_full(quota, c->min_region_sz))
> >  			continue;
> 
> With this change, damon_do_apply_schemes() ensures that we only proceed
> to call damos_apply_scheme() when the remaining quota is at least
> c->min_region_sz.
> 
> Does this make the if (!sz) check inside damos_apply_scheme() unreachable?
> 
> mm/damon/core.c:damos_apply_scheme() {
> 	...
> 	if (c->ops.apply_scheme) {
> 		if (damos_quota_is_set(quota) &&
> 				quota->charged_sz + sz > quota->esz) {
> 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
> 					c->min_region_sz);
> 			if (!sz)
> 				goto update_stat;
> 	...
> }
> 
> Since the remaining quota (quota->esz - quota->charged_sz) is guaranteed to
> be >= c->min_region_sz when reaching this point, ALIGN_DOWN will always
> result in sz >= c->min_region_sz.
> 
> Could this check and the goto be removed to clean up the dead code?

Same question was asked on the previous version of this patch.  My answer is
also same.  This makes sense but better to be done as a separate cleanup work.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260411164908.77189-2-sj@kernel.org


Thanks,
SJ

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260411164908.77189-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail
