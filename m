Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48C3290C3
	for <damon@lists.linux.dev>; Thu,  7 May 2026 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141527; cv=none; b=rw5WWAHt3v+Cj8P9E9lsExdI+6q4DT4MlAK7E6mjsXtMQxOHt6QP2PYNwPHA8ZmML1qZ+wGOcnNjtGEIG8frV3Hr3URZlq+aHe1fyu0rWO2nAbsXcJXo7knxqxUJPhu2iW2l0CsDmrRs1Y4PemX9hRzpKWzUjEETAX2VkIjDx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141527; c=relaxed/simple;
	bh=gaKQvJqox00dOkW34bSlircv/Eumfp1//0SDIQ4FrZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OakEnozik8YOJsZAJqd+B4gPE+ylxfqiLClFcPuolsevQYRJiwbCqzmdBlL7dmsHCTtpArXt/WPlsjhRFXPlZ89NQCb04sFwtoAZ8pjYBH9AfQZv7o4bJJ4zKxeySs3xsdupr+xtZVhSu1ACKWszcymnzO0dqMXpj1h2mRv1B8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7oAd4NQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7oAd4NQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D75C2BCB8;
	Thu,  7 May 2026 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778141526;
	bh=gaKQvJqox00dOkW34bSlircv/Eumfp1//0SDIQ4FrZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7oAd4NQKQhEKuGgjLTcMONJd07wFHq+5gmv+weADNhqG5WNJ/ELvgtf4Lert5kbg
	 5Vle/wEKSSwuMcSe0tfIB+ZcGm9GeZPIeuaOwXMCynBo7GkrvlGyCL0WfdCXLMs8uE
	 oh2MC1yS5hFDjXwu35UL2x922qznTX9u3Ec+A8GVhWj6rtyK98l6FoLTGlAhlRQs7Q
	 Tyr5cD+fw/ye8874q6oxXict7sr+NfiOb8qf1b9XUThauH1MAIHVqv0FLnfpiQ2E1U
	 lVz191qQrxx5JgvLEdeOo63XPwSuqv0ieCqjfrHTrs6/jZrvFiqAmI0fpYjha/fPXj
	 q0o7L3YQVJayg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.18.y v2] mm/damon/core: disallow time-quota setting zero esz
Date: Thu,  7 May 2026 01:12:02 -0700
Message-ID: <20260507081202.11547-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506204045.F0C53C2BCB0@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 06 May 2026 20:40:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incomplete fix: DAMOS scheme can still unexpectedly deactivate if using quota goals without a time quota.

No valid issue.  Read below for details, please.

> --
> 
> commit ce7d104c8087fff14fb782b89848659312c204fa
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/core: disallow time-quota setting zero esz
> 
> This commit addresses an issue where DAMOS time quota can reduce the
> effective size quota below the minimum region size. This causes no actions
> to be applied, unexpectedly deactivating the scheme. The fix enforces a
> lower bound of min_sz_region on the effective size quota when a time quota
> is used.
> 
> Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
> Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 87b6c9c2d6471..feec1b0c2babe 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2150,6 +2151,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> >  		esz = min(throughput * quota->ms, esz);
> > +		esz = max(ctx->min_sz_region, esz);
> >  	}
> >  
> >  	if (quota->sz && quota->sz < esz)
> 
> Could this still leave a case where the scheme is unexpectedly deactivated
> if quota goals are used without a time quota?
> 
> If a scheme is configured with quota goals (!list_empty(&quota->goals)) but
> no time quota (quota->ms == 0), the bounds check added here inside the
> if (quota->ms) block is bypassed.
> 
> When the system metric over-achieves, the feedback loop in
> damon_feed_loop_next_input() can limit quota->esz_bp to its minimum of
> 10000, which evaluates to an esz of 1:
> 
> 	if (!list_empty(&quota->goals)) {
> 		unsigned long score = damos_quota_score(quota);
> 
> 		quota->esz_bp = damon_feed_loop_next_input(
> 				max(quota->esz_bp, 10000UL),
> 				score);
> 		esz = quota->esz_bp / 10000;
> 	}
> 
> During scheme application, damos_apply_scheme() calculates the size using
> ALIGN_DOWN(1 - 0, ctx->min_sz_region). Since min_sz_region is typically
> PAGE_SIZE, this evaluates to 0 and the action is skipped entirely.
> 
> Because the feedback loop increases esz_bp multiplicatively, it would take
> multiple charge windows for esz to grow from 1 back to min_sz_region after
> the score drops. During this period, the scheme applies 0 actions despite
> the score indicating they are needed.

Yes, and this is the intended behavior.

> 
> Should the max(ctx->min_sz_region, esz) bound be applied outside the
> if (quota->ms) block to ensure any auto-tuned esz is properly bounded?

Because it is an intended behavior, no.


Thanks,
SJ

[...]
