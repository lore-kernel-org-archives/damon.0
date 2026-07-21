Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630FB3845D8
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642838; cv=none; b=Jx8ncMwHpmvXsAaL98sl7v08JfmKoGzCmbQ1OwIzq78ubAvhJGLMiPT5ZEsD54JDpYhGpGbDPMgmltOBczAv3HAHQ9MiFDMM2oL1xEDTc504D8h+lztClbnFhrgF+DjDLkwqBFjil7vH06heUHoGuu/h7S3GDc8UrLvAkoJCF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642838; c=relaxed/simple;
	bh=4BZAF8O24sosVFPNiDoBUdTYflZ3A3quWTvG/eeCyeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XpFgsnIKYNOyVNDkmmUD+m3sH5uhSKs1clQuVj/VSiDahrs0+6JpOwo/hFEcsUdghWvDoQieXeiNT96v1whyrvBzf6JvnWvKRHn/UJYrnxYotFFG1mOzs512GQi8iE2qgUWrEVJE2umzg5+eg6cbpIVHERxqTaTG2nODpumQiJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLmDd/ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLmDd/ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39B01F00A3A;
	Tue, 21 Jul 2026 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642837;
	bh=yZnf65TqUe/tXLwAabeUlC8l1TZFn1mizb9HYFS+Pwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JLmDd/ngKnsQq+OHMgImD5HyOB+cwhrK/JMbqKiskfu83xkgMDKJXFOJGLVrNm01J
	 c51fW1RluvaM0tHwXRJ/qRjbUKncu+L+tkUucq38bdgI2yJzZ6xfxy30TCP2m/4Q8U
	 YNuZ2M2tUYd5g/F6W6fzg84a1NGZlYflzJVMEQ7SoYc03IPRUP3o7WxMJNY4P08SBE
	 GHmDegxDChZ86MkbFhsaRm1IcpymzeNX3m0mQpArQCuBX1tY9HpcorX3ecH8iaRXTe
	 CFagKVC/giQzwLBVdLrtJq4moByafhJn4LUBh8OMhx66JMJXLRGRGC2DZfIfCs+ux9
	 OhQrZaseoP+7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] mm/damon/ops-common: prevent migration fallback to
 non-target nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260721135607.251869-1-sj@kernel.org>
References: <20260721135607.251869-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:07:16 +0000
Message-Id: <20260721140716.C39B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] alloc_migration_target() overrides non-blocking gfp flags for larg=
e folios, causing kdamond to stall in synchronous direct reclaim.
--

--- Patch [1]: [PATCH v3] mm/damon/ops-common: prevent migration fallback t=
o non-target nodes ---
commit 18e8e5ad17abc759ddf7302875cde768864ba912
Author: Jiahui Zhang <jiahuitry@outlook.com>

mm/damon/ops-common: prevent migration fallback to non-target nodes

This commit modifies DAMON's migration target allocation to use __GFP_THISN=
ODE.
This prevents the allocator from silently falling back to other nodes when =
the
target node is full, which previously caused misleading migration statistic=
s.

> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d7d7f100389b0..e59f77eca83b2 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -312,7 +312,7 @@ static unsigned int __damon_migrate_folio_list(
>  		 * instead of migrated.
>  		 */
>  		.gfp_mask =3D (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> -			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +			__GFP_NOMEMALLOC | GFP_NOWAIT | __GFP_THISNODE,

[Severity: High]
This is a pre-existing issue, but does adding __GFP_THISNODE here cause kda=
mond
to unexpectedly stall in synchronous direct reclaim when migrating large fo=
lios?

When migrate_pages() is called, it uses alloc_migration_target() in
mm/migrate.c. For large folios, alloc_migration_target() unconditionally
overrides the non-blocking GFP flags requested by DAMON:

mm/migrate.c:alloc_migration_target() {
	...
	if (folio_test_large(src)) {
		/*
		 * clear __GFP_RECLAIM to make the migration callback
		 * consistent with regular THP allocations.
		 */
		gfp_mask &=3D ~__GFP_RECLAIM;
		gfp_mask |=3D GFP_TRANSHUGE;
		order =3D folio_order(src);
	}
	...
}

Because GFP_TRANSHUGE includes __GFP_DIRECT_RECLAIM, the allocation can blo=
ck.
Previously, without __GFP_THISNODE, the allocator could fall back to another
node. By enforcing __GFP_THISNODE on a full target node, this forced direct
reclaim will trigger, stalling the kdamond thread and preventing kswapd wak=
eups.

Could alloc_migration_target() be updated to respect the caller's intent to
not block?

>  		.nid =3D target_nid,
>  	};
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721135607.2518=
69-1-sj@kernel.org?part=3D1
