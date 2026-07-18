Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84B8462
	for <damon@lists.linux.dev>; Sat, 18 Jul 2026 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334742; cv=none; b=mOZ9MhmpMy8cdvtvaDBJdS0YcTmPjf6Nhsl8p5NBvy1dxYhwmiKdF+4lOnpb3RnqiDFnmNF4bG/elDqc/WehGlRGHhdYS4mx5MzClSjssLurI0KO60XvYccET3P4qBL67d9Icv6W9NsaIyTtTUFTV6jXlchJAaxMwiT/e5RAmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334742; c=relaxed/simple;
	bh=trMWglSLcgt4Ht2R4Swy5bxos2KJbnzY85WKKiq2CXA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D4E17HVoWCa1imunl3dhqctf6TtLfsuiYYAAxeCKMIKZ33qjg/FIinIfeukAxail/TvzRfQ6H3UyWnfhu6xJmXp2Ssd/rP5h1XJ52vE0RJerLtot7u02cwETy2EdWzBRCqK7QvVfERuuzbXhrCg39MHmGZTdAEYjI/IZXu/2rDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQJGAZ9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQJGAZ9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDC31F000E9;
	Sat, 18 Jul 2026 00:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334741;
	bh=/sYJhmfYc/M40rbuhbVI6S6lZfSC/4mID+Lp/77pYrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQJGAZ9XKFrUolQCFbUwtHHg/2XE/CV/ME14Z/tXsKIK20NYuO1Nx+A3dxTnZLgWo
	 Yr6wsZbuswttlHteBIanuvSW6sj/5mS5UBOZp2MkYoVsYuvDEHncgfX77cXdhbXQxi
	 LleRD1ymJrW4hL9eiGrWQovH1Bc+vdQTRr4wXB4ewPSOxpGbPqZtRRF+hOgbp+CeXH
	 Om3vB+ufgB3mtoLuklrAwWSkyWlbSFdEFF0G9pkaispa7N9CxK/r+ufObc/vXP6fVK
	 MebbaBH9kGaVh8nolxgF81gZS3CqCLACwvyGfgoKY0jIa/2JCpK5/0KaVt1K7fvL9z
	 cYrgeCjbz7ZlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] mm/damon/core: initialize damos->last_applied
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260718001442.87129-2-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
 <20260718001442.87129-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 00:32:20 +0000
Message-Id: <20260718003220.DEDC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized memory use in DAMOS quota goals allocation (last_psi=
_total and nid).
- [High] damos_quota_init() modifies the passed quota struct, unintentional=
ly resetting runtime quota statistics of actively running schemes.
--

--- Patch [1]: [PATCH 1/7] mm/damon/core: initialize damos->last_applied ---
commit 316d27ac2ea17607b5c9df656020658fa1b425df
Author: SJ Park <sj@kernel.org>

mm/damon/core: initialize damos->last_applied

This commit initializes the last_applied field of the damos scheme struct to
NULL in damon_new_scheme(). This prevents an uninitialized value from causi=
ng
a DAMON scheme to unexpectedly skip applying an action to a folio the very
first time.

Link: https://lore.kernel.org/20260714055436.120034-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 603b102ff80f9..20d267c615faf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -705,6 +705,7 @@ struct damos *damon_new_scheme(struct damos_access_pa=
ttern *pattern,
>  	INIT_LIST_HEAD(&scheme->ops_filters);
>  	scheme->stat =3D (struct damos_stat){};
>  	scheme->max_nr_snapshots =3D 0;
> +	scheme->last_applied =3D NULL;
>  	INIT_LIST_HEAD(&scheme->list);
> =20
>  	scheme->quota =3D *(damos_quota_init(quota));

[Severity: High]
This is a pre-existing issue, but does damos_quota_init() unintentionally r=
eset=20
the runtime statistics of actively running schemes?

When updating a DAMON context via sysfs, damon_commit_ctx() calls=20
damon_new_test_ctx() which iterates over running schemes and calls=20
damon_new_scheme(), passing the active &src_scheme->quota pointer.

Inside damon_new_scheme(), it executes:
scheme->quota =3D *(damos_quota_init(quota));

If damos_quota_init() directly modifies the passed pointer:

mm/damon/core.c:damos_quota_init() {
    quota->esz =3D 0;
    quota->total_charged_sz =3D 0;
    quota->total_charged_ns =3D 0;
    quota->charged_sz =3D 0;
    ...
}

It appears this silently clears the tracking variables of the actively runn=
ing=20
scheme, potentially breaking the ability to track memory usage limits.

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing initializati=
on,
I noticed a potential issue with quota goals. Are the metric-specific field=
s in
damos_new_quota_goal() left uninitialized?

When allocating a new goal via sysfs or damon_commit_ctx():

mm/damon/core.c:damos_new_quota_goal() {
    ...
    goal =3D kmalloc_obj(*goal);
    ...
}

It seems fields like last_psi_total and nid are not zero-initialized.

Later, damos_commit_quota_goal_union() misses the switch case for=20
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, leaving dst->nid uninitialized.

This can result in using garbage values when calculating current_value:

mm/damon/core.c:damos_set_quota_goal_current_value() {
    ...
    goal->current_value =3D damos_get_node_eligible_mem_bp(c, s, goal->nid);
    ...
}

And for PSI goals:

mm/damon/core.c:damos_set_quota_goal_current_value() {
    ...
    goal->current_value =3D now_psi_total - goal->last_psi_total;
    goal->last_psi_total =3D now_psi_total;
    ...
}

Could subtracting an uninitialized last_psi_total underflow and cause the=20
quota tuner to aggressively zero out the quota?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718001442.8712=
9-1-sj@kernel.org?part=3D1
