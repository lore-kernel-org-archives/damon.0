Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478FA32B134
	for <damon@lists.linux.dev>; Thu, 18 Jun 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797120; cv=none; b=SFj8tv5DFndJXf1IAuD7uwMB09Yf9GvkI6UsWqs8Z3cRa5zn8GgYPjWkT36SBdYcJGL6lZcjyS2dQTlxdE7VmpzV+9/Q2Wp/3S/YtbkLs+jrHwAh5Oiknps92m1r090n2yr4BuEJUR7fD50VeHrn66MHlZ/zsLXplRmLCZw5Tk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797120; c=relaxed/simple;
	bh=EtpJWq62gqX0LyqbzHBaiGkz7hQqMyb1IhIit70oiCQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IamkeXYp77ORjU0H11AxgzzJn52T/rTMMGhLXc69ekrAmBnIuk8fyl06NxT24zgy8eJsB0l+YI5Mb4oouky+4Ju7V8uXYhRcqoa9UNVd9tJYezOhDkvGaHfSxR20vNgBQbr4MO0UlcDNhBVKT2rwNtLUEihcR05NaD7N4CeynR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNWzQmEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNWzQmEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6251F000E9;
	Thu, 18 Jun 2026 15:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781797118;
	bh=zHqYcNq01aVqSby7LmXeu6CBRURmc/GXEzX0/mcR75Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lNWzQmElcJnsMLF6uNpLH9HX3XCFxF59ZDNdHfT1sFQaSYq1O/RtAx8uq8YRrdSJt
	 R9x8GF80aSMI6xL7Ra3FnfvR51uLvPPzed9GM2W6QtVXN4Wia9YImm9eKvSig84oEk
	 QnimnqShNB0rJIW2Y3iAhhakaCWRuO5Iwdk4Sg80ulgYitSlWAtTKPO1Bm+aMrsIeE
	 p3eVcKFspF3jDRA33rpv5k1BJXvA6f5/egG4IkLs062mbAksQ+PJgyZjIs8AipgsX6
	 FgeTxGaDAWA6brgBKA9kK6MZ3+c1iEFPzyblCBgA3KKYF4pgMEF8xN7qJVBvqDkTPk
	 z4W6ZvujkbFwQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 11/11] mm/damon/sysfs-schemes: kobject_del()
 region for populate_region error
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260618151517.5366-12-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
 <20260618151517.5366-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:38:37 +0000
Message-Id: <20260618153838.5A6251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak in the error path of damon_sysfs_scheme_add_dirs() due=
 to skipped cleanup of the 'stats' kobject.
--

commit 73251d9a8366deae80fbc88ff7d3d42f79676704
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() region for populate_region error

This patch fixes directory creation failures due to name conflicts when
CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It adds a missing kobject_del()
call to properly clean up tried region directories in the error path of
damos_sysfs_populate_region_dir().

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index ebc692682481d..0b8a6f1f6b9fc 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the kobject
cleanup in this file, I noticed a memory leak in the error path of
damon_sysfs_scheme_add_dirs():

mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
    ...
	err =3D damon_sysfs_scheme_set_stats(scheme);
	if (err)
		goto put_filters_watermarks_quotas_access_pattern_out;
	err =3D damon_sysfs_scheme_set_tried_regions(scheme);
	if (err)
		goto put_tried_regions_out;
	return 0;

put_tried_regions_out:
	kobject_put(&scheme->tried_regions->kobj);
	scheme->tried_regions =3D NULL;
put_filters_watermarks_quotas_access_pattern_out:
	kobject_put(&scheme->ops_filters->kobj);
    ...
}

If damon_sysfs_scheme_set_tried_regions() fails, it jumps to
put_tried_regions_out. This attempts to clean up the failed tried_regions
allocation, but then falls through to the next label.

Does this completely skip cleaning up the successfully allocated
scheme->stats->kobj? Missing a call to kobject_put(&scheme->stats->kobj)
here appears to permanently leak the stats kobject and its associated
sysfs state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618151517.5366=
-1-sj@kernel.org?part=3D11
