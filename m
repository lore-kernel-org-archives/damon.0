Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340D43E9FD
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623537; cv=none; b=TD33+temJUwDukVTWVl8iaceuoLfwBgniBnwPsEKQZsuYBREax86xrsLm0MNedbpI8GJMilTZm6y1grpGwxUxLuBxgHOssvGhD7C3w7fg9VU/sRvTOl0WsyIqUkbhBNDKkYusf7psd0JAnSmj9V4Wn8v3fPuTWgA0SYq/Tg6YCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623537; c=relaxed/simple;
	bh=BjbyS8Kpc6cLCI5Kzj8IufxXuV7Eok27NhwpAnk5u/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NXObNrTsx96aWe1ExANHaHjdX38abyYMgXHZmORF/J1JWINgqmxFSKOGlws3h+NGOyzjc9aJO52qqUMwGmqGrc8YNcuV/AVCOD2lWLuJ1jLhlX8jI0MY0CKBLyfry3W7RAvy/v+zaH29KIjdyQXWh39oME6JQQ1t67GPXzc5d6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7C6OJbI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7C6OJbI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2481C1F00A3F;
	Tue, 16 Jun 2026 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623536;
	bh=wWIBZxpBWxejyR06+u/sZgx+FYuoOVTfL3ZgMU0z4M4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7C6OJbIHsOlhCmnoNbNSyVfWUeTKD1DdKMn+RVgnDuNdOj/uS8zFNhq6qc/XB6rX
	 b1y51Ib64n/gaPc/J/WaJK2blnNUCXoBSpjY4zwRumyw5Nj9PZyLRyfyL8sllxMOTx
	 u1SukYP0aNZ64TdI3GB3jym7Y9wUXNt2EQ9o1RD7shiCJgovh/V9Qx6V0ZH8uIb2nG
	 LutxhqvUBHQGAxVOoyBGUodNxwyTFLx2MLcf7EXJPdY6E6pSOEyvCr83rBe0f2iitK
	 eSbeF1/jdEYZP2Gy+ExRvyUpfX6uzjTn4Zun351b2gYQxuSRkm1MqfNF4q8iHXLg79
	 Bm+m1I5C0QoNg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/9] mm/damon/sysfs-schemes: kobject_del() scheme
 region dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-5-sj@kernel.org>
References: <20260616150844.88305-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:25:35 +0000
Message-Id: <20260616152536.2481C1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Missing kobject_del() in sysfs directory array te=
ardown and error paths.
- [High] Memory leak of `stats` object in `damon_sysfs_scheme_add_dirs()` e=
rror path.
--

commit 30488832bf0bcf915d5cbb6c2727b7cdedd8440e
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: kobject_del() scheme region dirs

This commit addresses directory creation failures due to name conflicts
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It fixes the issue by adding
missing kobject_del() calls before kobject_put() for scheme region
directories during removal.

Link: https://lore.kernel.org/20260517205828.6204-1-sj@kernel.org

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 37cf6edb54f17..bf08e6e1f1635 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -334,6 +334,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
>  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
>  		damos_sysfs_region_rm_dirs(r);
>  		list_del(&r->list);
> +		kobject_del(&r->kobj);

[Severity: High]
This is a pre-existing issue, but since we are adding kobject_del() here to
fix the name collision bug, could there be similar omissions in other array
teardown and error paths?

For instance, looking at damos_sysfs_probes_rm_dirs() which is called
just above via damos_sysfs_region_rm_dirs():

mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs() {
    ...
    for (i =3D 0; i < probes->nr; i++)
        kobject_put(&probes_arr[i]->kobj);
    ...
}

Does this code also omit kobject_del() during probes array teardown,
potentially leaving directories in sysfs during array resizing?

Similarly, in several initialization loop error paths, such as in
damos_sysfs_populate_region_dir():

mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir() {
    ...
out:
    kobject_put(&region->kobj);
}

If aborting region population, does this path fail to call kobject_del(),
breaking subsequent retries by leaving the directory name occupied?

Other functions like damon_sysfs_schemes_add_dirs(),
damon_sysfs_targets_add_dirs(), and damon_sysfs_contexts_add_dirs()
appear to have the same out path pattern omitting kobject_del() for
partially added objects. Would it make sense to update those paths as well?

>  		kobject_put(&r->kobj);

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory leak in
an error path nearby.

In damon_sysfs_scheme_add_dirs(), the error cleanup sequence handles
dropping the tried_regions and then ops_filters:

mm/damon/sysfs-schemes.c:damon_sysfs_scheme_add_dirs() {
    ...
put_tried_regions_out:
    kobject_put(&scheme->tried_regions->kobj);
    scheme->tried_regions =3D NULL;
put_filters_watermarks_quotas_access_pattern_out:
    kobject_put(&scheme->ops_filters->kobj);
    ...
}

Does this error path completely omit dropping the stats kobject?

The stats kobject is initialized prior to the failed call, so
wouldn't skipping kobject_put(&scheme->stats->kobj) leak it permanently?

>  		regions->nr_regions--;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D4
