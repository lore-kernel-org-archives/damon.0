Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F62C21C4
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098703; cv=none; b=LW5AjgYVmBbjTj6IaWY5knfjJO222xIqd3F/eXWf7/SnnbMYFrlb6oKgw2vDfdN101PtENPDg+DvNxM/SsC7Bwy9OqHCKrd6PZOTmtUm9sRx5q3ztW3bHRTb6CRJlS6J8YoISL3t0SIisj9C0mg4Fup8tQ9YdC2GbwVQAVvkWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098703; c=relaxed/simple;
	bh=FoheF2PObLOBMf0gEkhinsUI9/CCi3rvcatTGbnVrOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dLd2sQQ2RJahoSW/Ncv2XMiBYPSMXT6aA3JgM3/AlhfCRIpzpl5orkq0pY00zxWaFIbBWT2WLh9ioete+IMl7/vixduGvO1V/Fkiu2/+nzAP/Byuw2xN4TnYQhwkjRTiZpbsT6J3iMkfmsmGEZm8dYijBoHUqqjiAjIkBXqNRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM75Hws+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM75Hws+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37E31F000E9;
	Fri,  3 Jul 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783098702;
	bh=KBOHBBAvfGKppcCwclzVaU6jT4JZ5gJc1slomhZtFB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hM75Hws+MYD28aX1XW7Gh8GucRH9q5dyW/Tp2Rk4igbFnXrdwndfDgZn+FSe7X2wh
	 55Sf14PrIAl/0oIF+UHh8ICq+NugAG11EPfLaJPZ4HKrkeg2nwFzO6MC43KCFPVuAJ
	 cQz4RRXYLASMVNo9HyML6njUUYk3AelxCcoBO8uc4M2GMIXxxM3QYTs81eJEKJu4TV
	 es5000qzGTZ0nRDx3vMseDfHQPDWxqkTRIynzT/pg193NFICWxiTcvRMHtMnjRsdpl
	 KqOToFfZ1T39G6LwjX6vaGO6tybMzqsHfYMawMCIJiL5mFHZiiAAdLGHUBGPhTCGm8
	 FHq0z5zn4RUew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: disallow overlapping input ranges for
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260703165610.92894-1-sj@kernel.org>
References: <20260703165610.92894-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 17:11:41 +0000
Message-Id: <20260703171141.F37E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Execution of ALIGN() and ALIGN_DOWN() macros with a non-power-of-t=
wo `min_region_sz`, violating alignment subsystem guidelines.
- [High] TOCTOU race due to lockless concurrent reads of `sys_ctx->ops_id` =
and `sys_ctx->addr_unit`.
--

commit b68f48fc29d6aa945e1dd1ef0c694913e40d3854
Author: SJ Park <sj@kernel.org>

mm/damon/core: disallow overlapping input ranges for damon_set_regions()

This commit reinstates validation in damon_set_regions() to ensure that inp=
ut
ranges are sorted and do not overlap. It checks the boundaries and returns =
an
error if they are invalid, preventing unintended DAMON behavior.

Link: https://lore.kernel.org/20260630041806.151124-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c6fc35be633b3..b2fc15a3804ff 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -418,12 +418,19 @@ int damon_set_regions(struct damon_target *t, struc=
t damon_addr_range *ranges,
>  {
>  	struct damon_region *r, *next;
>  	unsigned int i;
> +	unsigned long last_end;
>  	int err;
> =20
>  	for (i =3D 0; i < nr_ranges; i++) {
> -		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=3D
> -				ALIGN(ranges[i].end, min_region_sz))
> +		unsigned long start, end;
> +
> +		start =3D ALIGN_DOWN(ranges[i].start, min_region_sz);
> +		end =3D ALIGN(ranges[i].end, min_region_sz);

[Severity: High]
This is a pre-existing issue, but does this safely handle a non-power-of-two
min_region_sz?

The ALIGN macros rely on bitwise operations that produce incorrect
boundaries if the alignment argument isn't a power of two. A user can
write a non-power-of-two value to addr_unit via sysfs, which sets
min_region_sz to a non-power-of-two in damon_sysfs_apply_inputs():

mm/damon/sysfs.c:damon_sysfs_apply_inputs() {
    ...
    ctx->min_region_sz =3D max(
        DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
    ...
}

Even though damon_commit_ctx() eventually validates and rejects the
configuration, these unaligned boundaries are actively used here to
allocate and merge regions during setup. Could this lead to overlapping
regions or division by zero before the rejection occurs?


[Severity: High]
This isn't a bug introduced by this patch, but can a time-of-check to
time-of-use (TOCTOU) race occur with sys_ctx->ops_id?

damon_sysfs_apply_inputs() locklessly reads sys_ctx->ops_id multiple
times:

mm/damon/sysfs.c:damon_sysfs_apply_inputs() {
    ...
    err =3D damon_select_ops(ctx, sys_ctx->ops_id);
    ...
    if (sys_ctx->ops_id =3D=3D DAMON_OPS_PADDR) {
    ...
}

Meanwhile, a concurrent sysfs write can update ops_id without acquiring
damon_sysfs_lock:

mm/damon/sysfs.c:operations_store() {
    ...
    context->ops_id =3D ops_name->ops_id;
    ...
}

If ops_id is changed between the damon_select_ops() call and the
subsequent check, could it result in a torn configuration where the
context operates in one mode (e.g., DAMON_OPS_VADDR) but the region size
scaling logic is applied using rules for another mode (DAMON_OPS_PADDR)?

> +		if (start >=3D end)
> +			return -EINVAL;
> +		if (i > 0 && last_end > start)
>  			return -EINVAL;
> +		last_end =3D end;
>  	}
> =20
>  	/* Remove regions which are not in the new ranges */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703165610.9289=
4-1-sj@kernel.org?part=3D1
