Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3389F374E79
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780547877; cv=none; b=ZeakNEdEad71IZOIoSaEzSKzwhIYIi47Ptbf1vsVZjwrdu3lS93HuiwpwqvJZ7mtDJJ9uG6QIDd5alQmkqybJCg7j2sxpADaKOIgwMC/WA4KdJ6fDsPU8W38uSAWv+xjF9vCUGL4YBhoqFtEg6t5zHiOF0dxxBeTFvuPvl0Ad3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780547877; c=relaxed/simple;
	bh=BWqwFhXydF7GDgsYojKEK+43aj5rJv5+i6XM2VpsfOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6ILqFanViCOEi4UnLfoxGzLKseqFH9/a80E3pAVm+gaFniAFdgoiGUCzdawWNLt/lCDK+TGz/DFdDzqWNX42sIuJWiAY2ntB++X/U31QbEeYzhPDhI2cEm78EIAYpRu1JQL0jXGd5iPMEBy9ok2qrMIfsXCIy8zMyZRwGXVBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkqCgxIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkqCgxIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB08E1F00893;
	Thu,  4 Jun 2026 04:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780547875;
	bh=jDRRTzKOktNsor6yqtZvYoTn55oNbwEEzWoqWzYCsy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PkqCgxIcop5eBKCiMji0EZJ+cckVA1vd9zxIuZwxdF/FzIJ4OIoISW3oT/dRZPGv/
	 TyAVRrLmfRlaO3WlnJ+XWVLeJX1tiAEqU0bnSKXqu9txy5BwCJcbymud2GYVws9NC6
	 +IJGMoevgBdO7DCS+AUkvwRpS8u2T8fDFKaWRTj86YPkcPb/+/SWliOxBFD+Xnplh0
	 DqHdz8wtIBPSTddkAtXRMi4jZmCY58I3mryG/LjojZUN4gzbI+kI74cUvBTa4JjvDZ
	 n4AfjAKsOQlbqU6V96Ev1jnOTXhmSu6uHMOXL2HDqvYzBBVvtxIOBqGeKsCeBzO8hC
	 FmUfqP7TAOKew==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: always put commit-failed target's
 pids
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260604042349.67720-1-sj@kernel.org>
References: <20260604042349.67720-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 04:37:55 +0000
Message-Id: <20260604043755.AB08E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] `damon_commit_target_fail()` incorrectly skips PID cleanup for sys=
fs test contexts due to uninitialized callbacks.

Pre-existing issues:
- [High] PID reference leak on multiple error paths during context conversi=
on from paddr to vaddr bypasses the newly added cleanup logic.
--

commit 9659672aa95ce46b9511dd7216240c3314476900
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/core: always put commit-failed target's pids

This commit fixes a PID leak that occurs when damon_commit_target() fails.
It adds damon_commit_target_fail() to handle putting the already-committed
PIDs when cleaning up after a failed commit.

Link: https://lore.kernel.org/20260320020056.835-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1387,6 +1387,31 @@ static int damon_commit_target(
>  	return 0;
>  }
> =20
> +/*
> + * damon_commit_target_fail() - handle damon_commit_target() failure.
> + * @dst:	Commit destination context
> + * @failed:	Commit failed destination target
> + * @src:	Commit source context
> + *
> + * This function is called by damon_commit_targets() for dammon_commit_t=
arget()
> + * failure for immediate states cleanups.
> + */
> +static void damon_commit_target_fail(struct damon_ctx *dst,
> +		struct damon_target *failed, struct damon_ctx *src)
> +{
> +	struct damon_target *target;
> +
> +	if (!damon_target_has_pid(src))
> +		return;
> +	if (damon_target_has_pid(dst))
> +		return;

[Severity: High]
Does this early return handle sysfs test contexts correctly?

When damon_sysfs_new_test_ctx() creates a context using damon_new_ctx(),
the ops structure is zero-initialized. Since DAMON_OPS_VADDR evaluates
to 0, damon_target_has_pid() will return true for this test context,
but its cleanup_target callback is still NULL.

If damon_commit_target() fails while copying to this test context,
will this return early and skip PID cleanup, trusting a NULL callback
to handle it later during destruction?

> +	damon_for_each_target(target, dst) {
> +		if (target =3D=3D failed)
> +			return;
> +		put_pid(target->pid);
> +	}
> +}

[ ... ]

> @@ -1432,6 +1459,7 @@ static int damon_commit_targets(
>  				src_target, damon_target_has_pid(src),
>  				src->min_region_sz);
>  		if (err) {
> +			damon_commit_target_fail(dst, NULL, src);
>  			damon_destroy_target(new_target, NULL);
>  			return err;
>  		}

[Severity: High]
This is a pre-existing issue, but does this cleanup logic miss other
error paths during a paddr to vaddr conversion?

When converting a DAMON context from paddr to vaddr, damon_commit_targets()
copies PIDs and increments their reference count in the first loop.
If an error occurs before this point in the second loop:

    damon_for_each_target_safe(src_target, next, src) {
        ...
        if (src_target->obsolete)
            return -EINVAL;
        new_target =3D damon_new_target();
        if (!new_target)
            return -ENOMEM;
        ...

These paths return directly without calling damon_commit_target_fail()
to clean up the already committed PIDs.

Additionally, if damon_commit_targets() succeeds but damon_set_attrs()
fails later in damon_commit_ctx(), it returns before the dst operations
are updated.

In all these cases, the destination context is left with paddr
operations where cleanup_target is NULL. When damon_destroy_ctx() is
called, will it skip dropping these PID references and leak them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604042349.6772=
0-1-sj@kernel.org?part=3D1
