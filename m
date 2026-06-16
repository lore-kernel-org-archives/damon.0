Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6D3A8746
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623314; cv=none; b=O+5myK2/fiHIjMAWa1B7dG7nwAAnwZ/bYhGCDPrUNeXLHRmgDfOk0aqbWCJfUmzeTNKprtBa4/EFaQMJY9ucHZijgSTv3tVTiKy7BDeWYxrko2KE4a/Q20m49g7cOJLfarj9c45dhvZheKYWtVK3abki6pUGipfynydCeBZOR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623314; c=relaxed/simple;
	bh=3iFsRaoTa5ye5VWDkugyDGWUWvKg1HsVBUjNcv5zd+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kfxjKFK689p3+tKZnHCaGC71TLE4DKh4k9isaYf7NHA/NF3CNtSrU//EZoSL1IA0Z3WD/52nhopumkNVmIuMjWK23hpJvxrXKpHuhyGa2vKVnS920uR6zrCm6wt+1Dh/2m4kFKrsiJxa5dxmKxuBkSxaAM9bnTEmlA40K/JvFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5sKcC6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5sKcC6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F75F1F000E9;
	Tue, 16 Jun 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623313;
	bh=Ds83DToaV4DfdqU2BlhLx1iZGcjqyYpQGzXVXCiJskM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5sKcC6Yv+Jy8DRSCC1L21ggViaYpBj/o0rZjiyaj2OxZvWUOcEg0oBeDaJA3daDa
	 mX6Qt3ewwNxZzOsv8+UQIs08dXz0d3abCc6onYzW4kalNNhctQi3dAN1iWm88zClZo
	 MAiWYWIiF5Ret4q+vmGfs4MjaVNf6gQsAGBCOtBQf3sbtuRn5PkcBZlQ9xuWpSdmsa
	 aiv2GA+/jQKLcukRU6OngbEwo8PmyPY2Nw478+jzhY+Fa8e+VEZN4b18X3YdAV30AI
	 8jDcti1l46VX5an4GsbgXdcwfKbBEbe8lyig5crdcw2TnS7f1nvKolm0ZlFoR9eGWS
	 TOp43cwgG7y4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] mm/damon/sysfs: support hugepage_mem_bp quota
 goal metric
Reply-To: sashiko-reviews@lists.linux.dev
To: gutierrez.asier@huawei-partners.com
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150316.580819-4-gutierrez.asier@huawei-partners.com>
References: <20260616150316.580819-4-gutierrez.asier@huawei-partners.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:21:53 +0000
Message-Id: <20260616152153.6F75F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The new `DAMOS_QUOTA_HUGEPAGE_MEM_BP` metric is exposed via sysfs b=
ut lacks required documentation updates.

Pre-existing issues:
- [Critical] Potential divide-by-zero in `damos_hugepage_mem_bp()` and `dam=
os_get_in_active_mem_bp()` due to an unhandled zero denominator.
- [High] 32-bit integer overflow in `damos_hugepage_mem_bp()` and `damos_ge=
t_in_active_mem_bp()` when calculating memory ratios.
--

commit be304699fb94d4d73bd979237fb4d7b08b7216f7
Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

mm/damon/sysfs: support hugepage_mem_bp quota goal metric

DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..4b5429a5b4158 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1267,6 +1267,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_q=
goal_metric_names[] =3D {
>  		.metric =3D DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
>  		.name =3D "node_eligible_mem_bp",
>  	},
> +	{
> +		.metric =3D DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +		.name =3D "hugepage_mem_bp",
> +	},

[Severity: Critical]
This isn't a bug introduced by this patch, but exposing this metric directly
to userspace makes a potential divide-by-zero triggerable by users
configuring DAMON quotas.

In mm/damon/core.c:damos_hugepage_mem_bp(), the denominator is computed as:

    total =3D totalram_pages() - global_zone_page_state(NR_FREE_PAGES);

Due to per-CPU vmstat lag or an idle system, the free pages counter can equ=
al
totalram_pages(), resulting in total being 0. This is then passed to
mult_frac():

    return mult_frac(thp, 10000, total);

This inherently computes thp / total, causing a strict division by zero and=
 a
kernel panic. The same issue exists in damos_get_in_active_mem_bp() where
total =3D active + inactive, which can be 0 if the LRU lists are empty.

Should a zero-check on total be added before performing the division?

[Severity: High]
This is a pre-existing issue, but exposing this metric also surfaces a 32-b=
it
integer overflow in mm/damon/core.c:damos_hugepage_mem_bp().

The mult_frac(x, n, d) macro performs the multiplication (x % d) * n. Here x
is thp, which is an unsigned long.

On 32-bit systems, if thp exceeds ~429,496 pages (around 1.75 GB),
(thp % total) * 10000 will silently overflow the 32-bit unsigned long type.

This wrap-around yields an erroneously low ratio instead of the correct val=
ue.
The same overflow applies to damos_get_in_active_mem_bp() if the active or
inactive pages exceed 1.75 GB.

Could this be fixed by casting the first argument to u64 to prevent the
overflow?

[Severity: Low]
Does this patch also require an update to the authoritative DAMON sysfs
documentation?

Documentation/mm/damon/design.rst explicitly lists all valid string values
for the target_metric sysfs file, but does not include hugepage_mem_bp.
Without documenting the new metric, it may remain undiscoverable for users.

>  };
> =20
>  static ssize_t target_metric_show(struct kobject *kobj,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150316.5808=
19-1-gutierrez.asier@huawei-partners.com?part=3D3
