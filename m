Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0354C1F03D9
	for <damon@lists.linux.dev>; Thu, 14 May 2026 01:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723781; cv=none; b=ZywQHrqCv+YmUQD7j3k4+t3AfzdSasaD0s0zsl2EGkMGXexLWhQh6weW4j9AlBZcijv0qnTUh/T3SwNvcC1WDAm5Vv1XlYeA4xReBS9XwUOd13CBb+B4B0kNmIcLWslZXnzBRShaY70JmbneOuwHjKDUjC0b7xlRru+DaXhp2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723781; c=relaxed/simple;
	bh=vp53Y2wZtkeXzmpD/R5GyUpDYYT4lk+f7b4w37LNqTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9l968HP1l0ZyhM/Mq0Y/kGWqLcxt7bqWT8kFo3YcgTuDuaVmo95kvzb84NgFmyCwVM7EOu8EYSbFykZE60PCz2rm7/uD8eRcZFRlhrFSEht4bFKkD9nyAmNPsu8R3XKMXanMprJH03J8tMfyHnSrASTEGh6+EmzFkwFMntVCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcMcHhzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcMcHhzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD3FC19425;
	Thu, 14 May 2026 01:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723780;
	bh=vp53Y2wZtkeXzmpD/R5GyUpDYYT4lk+f7b4w37LNqTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JcMcHhzP/aK161Il0ljNanmYnXYvRNgTq+3zJ6ohUDPe/i1ZYm7y52fQmrKF4GGHV
	 H50GBvWOwX9ArEHatSxNWm/s/gzeC5pTOBZep4Voc4CQbenPTMnDcrlLpw7cVbB+Fs
	 bADZMREZ8JlHisBr9aCVtKXhh8JEkzG8gHxNyCx9wrpz5cuKubeE3GcLwbWt2Ryg55
	 mjEBXX84W6UFc4UETxHy4Aoqz7TKYAraa8e7u3iv9Cs6XYwquL2Q3nj4BDmGVZDs+S
	 0lGvaFGFySH8/gA1SaSpJAvj6xdzlFvlSRCanqjBsLWtBF/QJn2N7NsJBv6Td2UioS
	 vTz1SxarwKo3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 2/2] mm/damon/lru_sort: detect and use fresh
 enabled and kdamond_pid values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260513034229.131258-2-sj@kernel.org>
References: <20260513034229.131258-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:56:20 +0000
Message-Id: <20260514015620.BBD3FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NULL pointer dereference in damon_lru_sort_enabled_store if module=
 initialization fails.
--

commit 1c4b8a292830197d1c3c21bb2ed871fd37b99120
Author: SeongJae Park <sj@kernel.org>

mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values

This patch updates DAMON_LRU_SORT to dynamically detect and use the fresh
status for the enabled and kdamond_pid parameters when requested. This
avoids stale parameter values if kdamond is stopped unintentionally.

Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 42b9a656f9ded..0c2274fefd763 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -330,42 +316,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &a=
ddr_unit, 0600);
>  MODULE_PARM_DESC(addr_unit,
>  	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)=
");
> =20
> +static bool damon_lru_sort_enabled(void)
> +{
> +	if (!ctx)
> +		return false;
> +	return damon_is_running(ctx);
> +}
> +
>  static int damon_lru_sort_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	bool is_enabled =3D enabled;
> -	bool enable;
>  	int err;
> =20
> -	err =3D kstrtobool(val, &enable);
> +	err =3D kstrtobool(val, &enabled);
>  	if (err)
>  		return err;
> =20
> -	if (is_enabled =3D=3D enable)
> +	if (damon_lru_sort_enabled() =3D=3D enabled)
>  		return 0;
> =20
>  	/* Called before init function.  The function will handle this. */
>  	if (!damon_initialized())
> -		goto set_param_out;
> +		return 0;
> =20
> -	err =3D damon_lru_sort_turn(enable);
> -	if (err)
> -		return err;
> +	return damon_lru_sort_turn(enabled);

Can this result in a NULL pointer dereference if the module initialization
fails?

If damon_lru_sort_init() fails during boot (for instance, due to memory
allocation failure), ctx remains NULL. Since CONFIG_DAMON_LRU_SORT
parameters are registered as built-in module parameters, writing 'Y' to
/sys/module/damon_lru_sort/parameters/enabled will invoke
damon_lru_sort_enabled_store().

In this scenario:
- damon_lru_sort_enabled() safely returns false (due to !ctx).
- The damon_lru_sort_enabled() =3D=3D enabled check is bypassed (false !=3D=
 true).
- damon_initialized() returns true (since the DAMON core initialized).
- damon_lru_sort_turn(true) is executed.

This leads to damon_lru_sort_apply_parameters() calling
damon_commit_ctx(ctx, param_ctx), which unconditionally dereferences the
NULL ctx, leading to a kernel panic.

Should there be an explicit if (!ctx) check in
damon_lru_sort_enabled_store() to prevent this, similar to how it was
added to the read paths?

While this vulnerability is not strictly introduced by this patch, the patch
misses the opportunity to fix it while addressing ctx nullability in the
read paths. The same vulnerability also appears to be present in sibling
modules mm/damon/reclaim.c and mm/damon/stat.c.

> +}
> =20
> -set_param_out:
> -	enabled =3D enable;
> -	return err;
> -}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026051240-quickly-=
effective-c901@gregkh?part=3D2
