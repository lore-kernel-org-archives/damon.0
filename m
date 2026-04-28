Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B234D4CE
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777358924; cv=none; b=ueLZPD6l5LPtgk4uaoF4CXBTRKBAt/RAQshTTJuOeHYtM+drjys0CV+g6+pRh1kQBYSB1UpNEokMn/UGYQm7cM6tfWniCi9NqLJKiZMjI5EJQt2nTjb6zmGa8XLbsX9bWXlyLXq7+UORNjYhYITEzU+0waeVHLer+D5b/z+6LCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777358924; c=relaxed/simple;
	bh=x4/GIcuVJGUVW3WT+/1xUjOio5Gf81uYy3gV/7qGJ4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf1nWUutW5gimABLiS3P0T8ai24tHfO6MrxDAZHdjA8+row26/YQZ7Pk+ElzCv5+Ok10CCL99KQseW2ZVDVdTE3943+dNta010/ls5weLY8J1N51i3Wmo/fBDE+qhc0nyWw14fF6Dg9aupHNptuXUI9Y9Bxod8OZFUgZ8OaTnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQqLu9SN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQqLu9SN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC59C2BCAF;
	Tue, 28 Apr 2026 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777358923;
	bh=x4/GIcuVJGUVW3WT+/1xUjOio5Gf81uYy3gV/7qGJ4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQqLu9SNYkKrSG1NxWvTW2ZoMZXt9G8j+/32DkbAp7W1Q87/6znwzVtyQdjLqdieG
	 3XWkbZGGizccHYR+TroaA5XgfIfppLTwrgzpDFe+tzhi5VjIN4A1KiDgX12oPJ6SBk
	 nqpH3fTpVLhS3h8idYoGd29+Lk434LeFKjiuNK7t6UvGFi9tDe31Utv/dYfwN8nTOV
	 avPMv5TbSDgYSowafYtf4+bor5pSveL61pH+RHv36cLJQ8ZNI45HgF5Sr+SDHoR+Ll
	 xv/JHHLcwH76bUY+cXYoGbdhkXR/iJ41gVlqClPyBFvtHFIyH7CdNGgQ14M+HzVc51
	 wDV0S46NouMMQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: make charge_addr_from aware of end-address exclusivity
Date: Mon, 27 Apr 2026 23:48:34 -0700
Message-ID: <20260428064835.123160-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428054903.A6110C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 05:49:03 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 3 potential issue(s):
> - [High] The remainder of the last region of a target is unconditionally skipped during quota resumption.
> - [High] Quota state is not saved when the remaining quota is less than `min_region_sz`, breaking round-robin fairness.
> - [Medium] Setting `charge_addr_from = r->ar.end` causes resumption failure when a region covers the end of the address space.

No blocker of this patch.  Please read below for details.

> --
> 
> commit 50bbd8d578080e27beac4fe1ad0cecbb013a8fd7
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: make charge_addr_from aware of end-address exclusivity
> 
> This commit updates the DAMOS quota charge assignment to use the exclusive
> region end address rather than assuming it is inclusive. This addresses a
> bug where the action might skip the next memory block up to min_region_sz.
> 
> Link: https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3dbbbfdeff71..901ffdaefb7f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2106,7 +2106,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		if (damos_quota_is_set(quota) &&
> >  				quota->charged_sz >= quota->esz) {
> >  			quota->charge_target_from = t;
> > -			quota->charge_addr_from = r->ar.end + 1;
> > +			quota->charge_addr_from = r->ar.end;
> 
> Does this cause a resumption failure if the region covers the absolute end of
> the address space?
> 
> If r->ar.end wraps to 0 (e.g., ULONG_MAX + 1), charge_addr_from is assigned
> 0. Since DAMON uses 0 as a sentinel value for an uninitialized state, the
> checks for quota->charge_addr_from in damos_skip_charged_region() will
> evaluate to false.

There is no execution path that sets r->ar.end as the absolute end of the
address space, to my best knowledge.  If there is a path to make it happen, it
is already an issue.

> 
> Will this completely fail to identify the resumption point, prematurely clear
> the state, and restart from the first region instead of resuming?

So this cannot happen to my best knowledge.

> 
> Additionally, this isn't a bug introduced by this patch, but does the
> resuming logic unconditionally skip the remainder of the last region of
> a target?
> 
> In damos_skip_charged_region(), the damon_last_region() check executes before
> evaluating charge_addr_from:
> 
> mm/damon/core.c:damos_skip_charged_region() {
>     ...
> 	if (quota->charge_target_from) {
> 		if (t != quota->charge_target_from)
> 			return true;
> 		if (r == damon_last_region(t)) {
> 			quota->charge_target_from = NULL;
> 			quota->charge_addr_from = 0;
> 			return true;
> 		}
>         ...
> }
> 
> If a target's last region is partially charged and split during a window, the
> uncharged remainder becomes the new damon_last_region. In the next quota
> window, when the loop reaches this remainder, will it immediately match the
> last region check, clear the state, and permanently starve the end of targets
> by returning true (skip)?

Good finding.  The user impact is quite negligible and anyway this is not
introduced by this patch.

I will separtely work on this.

> 
> Finally, this isn't a bug introduced by this patch, but is the quota state
> lost when the remaining quota is less than min_region_sz?
> 
> Earlier in damos_apply_scheme(), if the remaining quota is small:
> 
> mm/damon/core.c:damos_apply_scheme() {
>     ...
> 		if (damos_quota_is_set(quota) &&
> 				quota->charged_sz + sz > quota->esz) {
> 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
> 					c->min_region_sz);
> 			if (!sz)
> 				goto update_stat;
>     ...
> }
> 
> Does the goto update_stat bypass incrementing quota->charged_sz and saving
> charge_target_from and charge_addr_from?
> 
> Because charged_sz never reaches esz, the loop will uselessly evaluate all
> remaining regions. Because the resume state is never saved, will the next
> interval incorrectly restart from the very first target and region, breaking
> round-robin fairness and starving later regions whenever the dynamically
> calculated quota is not perfectly aligned?

Quota is charged in min_region_sz granularity, so the problem shouldn't happen.

FYI, this scenario can happen once failed region charge ratio feature is
applied.  Hence the failed region charge ratio patch series [1] contains a fix
of this.

So, the issue is unreal now, and neither will be real in future.

[1] https://lore.kernel.org/20260428013402.115171-1-sj@kernel.org


Thanks,
SJ

[...]
