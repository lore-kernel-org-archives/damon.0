Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9BC2FF
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951320; cv=none; b=ICpTpN56lvKm6FKFPXZPBX2c49yzN31H+iBII/33O62/jhXghuFxnlawJthuiA6fCLnNpRyUQNQK71cpF0R1Ptopk/S3Omsc+slUFsqWz+Faf4QLDKwR9NPNjBbbguDFY2FyBYcn0SkUrLt43Qwnv+QPh7up1tARoLq7u3/qbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951320; c=relaxed/simple;
	bh=pCJF9vRIBSJi2fsDb/INKqkiopeBoP/whCnNUNNlypc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyq4IvR85m+owjU/rNzlygRC03fblYK5v4wgsy58gwezPA0pFEDvTZdduaZose4pmotHFHRly8KRxWpu4LhLH9O+9DfpcFcRph2jSyseQrpZVU0Sf9vXWkU743lwhs3b4B99L2FlnNWBS1XuvDyoZSByNF0LVJ/FVRmlea86/uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ell1PANg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ell1PANg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53721F000E9;
	Thu,  2 Jul 2026 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951319;
	bh=9roTWaG2lMK2Ftj0F4mXcTpzQvRs2N0r6oHPnV2FLOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ell1PANg2j55DTlUGEJob3CwEMmSxsGma05+Sqx5NrDMrfeAfu0r31JHDU1PqXaGX
	 73AUTdYw7DU19JR7kl23UVnmONVsRGbT75aH8JODxx9j96O0zXqV8LHOoLeOkE3tcU
	 PsjhYUi5vokWPnFZmaqqn0+BdyLQ5zk5EJ7RtRu5uWMj1KCuvdso9GHNed3HkEj2mN
	 1vqDmoVltEgiuOF5jlijn+cWXNzVYoshKiMQAzHKlxAYliOzWUP/GcZkdNwGG+53fj
	 3FAYniAw9DHvag0zW/aKBb4D9Nw4Ba+0cauI7nvHCLw/f2cUIW/S2TTJyAWnbKaN3x
	 8A6NvlcXizR1Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/8] mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
Date: Wed,  1 Jul 2026 17:15:10 -0700
Message-ID: <20260702001511.86717-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701155623.E4DD61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 15:56:23 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `is_power_of_2()` validation exposes the system to undefined behavior via `ALIGN` macros and silently kills the `kdamond` thread (Denial of Service).
> --
> 
> commit da14a5f653fa82832f40f8b6d0be4ad4c3036287
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/lru_sort: remove duplicated min_region_sz power_of_2() check
> 
> DAMON_LRU_SORT validates the user input for min_region_sz.  The same
> validation is done inside damon_start() and damon_commit_ctx().  Remove
> the unnecessary duplicate.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 32f41491b726b..2dd0cd0d26273 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -284,11 +284,6 @@ static int damon_lru_sort_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > -	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > -		err = -EINVAL;
> > -		goto out;
> > -	}
> > -
> 
> [Severity: High]
> Does removing this early validation expose the rest of the DAMON subsystem to
> a non-power-of-two min_region_sz?
> 
> If a user writes a non-power-of-two module parameter (for example,
> addr_unit = 3), damon_lru_sort_apply_parameters() will calculate
> min_region_sz as 349525.
> 
> This invalid size is then passed to damon_set_region_system_rams_default(),
> and eventually to damon_set_regions(), where it is passed into the ALIGN()
> and ALIGN_DOWN() macros:
> 
> mm/damon/core.c:damon_set_regions() {
>     ...
>     r = damon_new_region(
>         ALIGN_DOWN(ranges[i].start, min_region_sz),
>         ALIGN(ranges[i].end, min_region_sz));
>     ...
> }
> 
> These macros strictly require power-of-two alignment values to form bitwise
> masks.
> 
> Can this result in meaningless garbage boundaries?
> 
> Furthermore, the invalid size propagates to damon_commit_ctx(). Due to a bug
> in a prior patch in the series ('mm/damon/core: safely validate src on
> damon_commit_ctx()'), the safe validation dry-run incorrectly validates dst
> instead of src,

Yes, I will fix the bug in the next revision.

> leading directly to a call to __damon_commit_ctx():
> 
> mm/damon/core.c:__damon_commit_ctx() {
>     ...
>     dst->maybe_corrupted = true;
>     if (!is_power_of_2(src->min_region_sz))
>         return -EINVAL;
>     ...
> }
> 
> This function immediately sets dst->maybe_corrupted = true, evaluates
> !is_power_of_2(src->min_region_sz), and returns -EINVAL early.
> 
> This leaves the running context's maybe_corrupted flag permanently set to
> true, which causes the kdamond background thread to abruptly terminate itself
> on its next iteration.
> 
> Could this lead to a denial of service by silently killing the kdamond thread?

So no issue should happen in the next revision.


Thanks,
SJ

[...]
