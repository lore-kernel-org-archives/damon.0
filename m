Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9E370ADB
	for <damon@lists.linux.dev>; Mon,  3 Aug 2026 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766015; cv=none; b=TKS04TYVB17oeXfbS+u3fuLhcIIHaRU6Fzj4hcxT3eHcoAxSemjyWqpnmUcoALehHHH7FflJmq/n56EY9Js2sAPdR1TngqQdIJVKxepXPArTR4af0Ieh9FqoA9Izfb2QMdz25efQwPCR0K7i9lhG8/5Kcy72pagt2mTrfTINVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766015; c=relaxed/simple;
	bh=rX2qiU9Jh9a6XB6WIEy6wbOJeN9OJ/ZycYmznUamPc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KK0goJwzdgeHSKcEBJR0omV8aKVMzcYlxXbuij0z7vpDV7/H+QnYYBJ8v+5+0FWQyXHQ4Dtc1ekdzFjgVjoJOL+Lgw1hG2gkGte65nTD05WLGnQ8fo5ghMSoT7g+E4ZLaIFRbsay02v8SC5hoZf2IGhJqbxbFrhnwBazA59cKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpJD7gkC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpJD7gkC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604A01F00A3A;
	Mon,  3 Aug 2026 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766013;
	bh=MrNUx/W9iu8oLSShWQeg64gEme09gl/G0OyHoB0JQRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RpJD7gkCpVgPugnTTIMkb6uo+i20EsaIQkDUdM40uzwWM3bQxUNyZ+uS+1f2j+E8J
	 zCLtxLk9pgPXH1zFhHateMWsd/Bqw/vF7+nwzZLM8sM+I9h7jFLTFmt/Oq+wQvOeao
	 qPk3ng5IXh8Hk4FIYNL4TflT+rnBbXt3wz9GF+eJKBTL1Nmq3XkmcTEORGjSW6gknm
	 2X0g5jR0mz4SY8c5BNbCHJvRVlgCmAL8O8t3PPkm+WaOxjy45VrEAgj0sFTaf5kT/L
	 b6ijbU2PgwBDvB3OVvztPoj65WKl9cPBk9cSbZCgsVTInuvEN6nSVMwQZEkFMkzCy6
	 vUF9TQTawyLwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] samples/damon/mtier: error out for zero quota goal
 target values
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260803134034.15217-2-sj@kernel.org>
References: <20260803134034.15217-1-sj@kernel.org>
 <20260803134034.15217-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:06:52 +0000
Message-Id: <20260803140653.604A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The safety check for zero values evaluates global module parameter=
s without `READ_ONCE()`, introducing a TOCTOU race window that bypasses the=
 patch's defense.
- [Low] The newly added comment references a non-existent function `damos_q=
uota_store()` instead of `damos_quota_score()`.

Pre-existing issues:
- [High] The core API `damos_new_quota_goal()` fails to validate `target_va=
lue !=3D 0`, forcing ad-hoc checks in caller modules and leaving the subsys=
tem vulnerable to division by zero.
- [High] The DAMON LRU sort module computes a quota goal target value from =
an unvalidated module parameter, allowing users to trigger a division by ze=
ro crash.
--

--- Patch [1]: [PATCH 1/2] samples/damon/mtier: error out for zero quota go=
al target values ---
commit 8e87b5068bfcd9e35bdbd23dadaa97f649431adb
Author: SJ Park <sj@kernel.org>

samples/damon/mtier: error out for zero quota goal target values

This patch prevents a division by zero in damos_quota_score() by returning
an error when a user configures DAMON with zero target values for the
node0_mem_used_bp or node0_mem_free_bp module parameters.

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
This isn't a bug, but there is a typo in the comment. Should
damos_quota_store() be damos_quota_score()?

> +	if (!node0_mem_used_bp || !node0_mem_free_bp)
> +		goto free_out;
>  	quota_goal =3D damos_new_quota_goal(
>  			promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
>  			DAMOS_QUOTA_NODE_MEM_FREE_BP,
>  			promote ? node0_mem_used_bp : node0_mem_free_bp);

[Severity: High]
Can a concurrent sysfs write bypass this safety check?

The module parameters node0_mem_used_bp and node0_mem_free_bp are read
multiple times without READ_ONCE().=20

A concurrent thread could set a non-zero value to pass the check, and then
overwrite it with zero before damos_new_quota_goal() reads the parameter
again.

Would this re-introduce the division by zero crash?

This same double-read pattern appears to be present in other DAMON modules:

mm/damon/lru_sort.c:damon_lru_sort_add_quota_goals() {
        if (!active_mem_bp)
                return 0;
        goal =3D damos_new_quota_goal(DAMOS_QUOTA_ACTIVE_MEM_BP, active_mem=
_bp);
...
}

mm/damon/reclaim.c:damon_reclaim_apply_parameters() {
        if (quota_mem_pressure_us) {
                goal =3D damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
                                quota_mem_pressure_us);
...
}

Should these parameters be cached in local variables or read with READ_ONCE=
()
to prevent a Time-of-Check to Time-of-Use race?


[Severity: High]
This is a pre-existing issue, but does the core API damos_new_quota_goal()
need a check for a zero target_value?

Currently, callers are responsible for validating the target value to avoid
a division by zero in damos_quota_score(). If damos_new_quota_goal()
validated this and returned NULL when target_value is 0, it would protect
the entire DAMON subsystem systematically without relying on ad-hoc checks
in caller modules:

mm/damon/core.c:damos_new_quota_goal() {
        struct damos_quota_goal *goal;

        goal =3D kmalloc_obj(*goal);
        if (!goal)
                return NULL;
        goal->metric =3D metric;
        goal->target_value =3D target_value;
        ...
}


[Severity: High]
This is a pre-existing issue, but can the LRU sort module trigger a division
by zero despite parameter validation?

In damon_lru_sort_add_quota_goals(), the cold scheme's quota goal is
computed dynamically:

mm/damon/lru_sort.c:damon_lru_sort_add_quota_goals() {
...
        goal =3D damos_new_quota_goal(DAMOS_QUOTA_INACTIVE_MEM_BP,
                        10000 - active_mem_bp + 2);
...
}

If a user configures the active_mem_bp module parameter to exactly 10002
via sysfs, the resulting target_value evaluates to 0.=20

Since this value is passed directly to damos_new_quota_goal(), wouldn't this
crash the kernel in damos_quota_score()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134034.1521=
7-1-sj@kernel.org?part=3D1
