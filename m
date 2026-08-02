Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B23AE18A
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688367; cv=none; b=M8AZyfJu/zBpyhdUamyry0wbaTb4lBTVeHJymOsV7ly+rIWbD57lJdnX+Qkw+K3Qtgp8vVn5qpMmXPI2gclhKQeuigJN/EhHOw+wdOQSN5AonkXgatZpPYcYBu5XdIJcyocVxU3FDsEpf18+EIQvFVPof/GrtbGafrqA4/8x4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688367; c=relaxed/simple;
	bh=H5VeJ20oKyS7E/uMh+Ol05joAWN+MbR/Ob9Rq8dLlhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQEl4aGtyjvTfOdTA/8Sr/O6hCAnQVNAEKDkSQsQKxlf+KatM2PWz/7pDILhmbfg7DwYzxkDkCegc55D8Hz1FXxWg1Byb59Mz2FPZhssF4EcH1ATq4fsqyY1jKEdaq8wLEkzKA20V6YbL7dseHfd5F5C+3POYLU1k3fQ1/oDkxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk8gSXue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk8gSXue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FFA1F000E9;
	Sun,  2 Aug 2026 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688359;
	bh=OFUXOUZUwm+xOYqKcVuP8kFDnDLSwgOld3IEO/q7Km8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yk8gSXueGccgkUMcoYs9wpo55BBW5PusG9o/l9rghheJzvbcd4lw9YIaEWhwy1Y/v
	 mlGySGebZlw64VEz+gcoaUuIwaQYCN2RUxSy+vne5v8XoOOP3g9vnYX0MrKKtx+7Ow
	 Xj6t6xhbOg4q+pglHNKK9WJHFEJ5XEMG6tJnDdnUEHPc9vhrLy2f/nB3PseT3LgY3r
	 er20zMrRPnPmyk7TCtQJ5fnZJ9F9J5ZEZ2grkrW3aVGBVkVaOsHwPHnefj5AOfAb0P
	 NaQIDBw9UtyTGcdsUO0ScVpsyJJbFm/Cg9ViZk0HnJwACKEP8L5EJfh1FB88Z61xhB
	 tFu/I2zqldonQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] samples/damon/mtier: error out for zero
 quota goal target values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260802162050.89477-2-sj@kernel.org>
References: <20260802162050.89477-1-sj@kernel.org>
 <20260802162050.89477-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:32:38 +0000
Message-Id: <20260802163239.A7FFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly added comment incorrectly refers to `damos_quota_store()`=
 instead of `damos_quota_score()`.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the division-by-=
zero vulnerability is only patched at the module boundary in `mtier.c`. The=
 unvalidated core API (`damos_new_quota_goal` and `damos_quota_score`) rema=
ins vulnerable and is still exploitable via other DAMON components. For ins=
tance, in `mm/damon/lru_sort.c`, an unchecked `active_mem_bp` module parame=
ter can be set via sysfs such that it evaluates to 0, causing a kernel pani=
c.
--

--- Patch [1]: [RFC PATCH v2 1/2] samples/damon/mtier: error out for zero q=
uota goal target values ---
commit a29006e1d33ea981b557928c622fb8487e53dbc8
Author: SJ Park <sj@kernel.org>
samples/damon/mtier: error out for zero quota goal target values

This commit prevents a division-by-zero exception in damos_quota_score() by
returning an error when users try to start DAMON with zero values for the
node0_mem_used_bp or node0_mem_free_bp parameters.

Link: https://lore.kernel.org/20260801202657.117135-1-sj@kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index ac9c24b92ead8..d1123ebbfab90 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -156,6 +156,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  	if (!scheme)
>  		goto free_out;
>  	damon_set_schemes(ctx, &scheme, 1);
> +	/* zero target value causes division by zero in damos_quota_store() */

[Severity: Low]
This isn't a bug, but should this refer to damos_quota_score() instead of
damos_quota_store()?

> +	if (!node0_mem_used_bp || !node0_mem_free_bp)
> +		goto free_out;
>  	quota_goal =3D damos_new_quota_goal(

[Severity: High]
This isn't a bug introduced by this patch, but while this change handles the
zero target value at the module boundary in mtier.c, does the unvalidated
core API leave other DAMON components vulnerable?

For example, looking at damon_lru_sort_add_quota_goals() in
mm/damon/lru_sort.c:

    goal =3D damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
                                10000 - active_mem_bp + 2);

If active_mem_bp is set to 10002 via sysfs, this evaluates to 0.

Because damos_new_quota_goal() in mm/damon/core.c accepts the target_value
without validation, this zero value propagates to damos_quota_score() where
mult_frac() performs a division by goal->target_value.

Could this cause a division by zero exception leading to a kernel panic?
Would it be safer to add validation directly inside damos_new_quota_goal()
or damos_quota_score() to protect all consumers?

>  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
>  			DAMOS_QUOTA_NODE_MEM_FREE_BP,
>  			promote ? node0_mem_used_bp : node0_mem_free_bp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802162050.8947=
7-1-sj@kernel.org?part=3D1
