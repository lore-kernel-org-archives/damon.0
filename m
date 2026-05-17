Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C09134F275
	for <damon@lists.linux.dev>; Sun, 17 May 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042471; cv=none; b=g91o+XG/RrPQWhcbF9br+L420ymlJy6x0aT4sAjaKRIjOwMNiMi8xGcrONwCUti83Ud9OkicHkgcL00MA5ULIO/UexuxzNC5zqJeVVrDSANZaliIojTMDCde3CwjcH4kriZEJWY/gOkcmm+UkoLYBEZ8wrs6kLOx5WVWvocqeMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042471; c=relaxed/simple;
	bh=O0cJqHav74hnGaZnyWRzv5dbWKVAnDFIt3OXKauWGyU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L/CHfWUYXFwZps56OhU/mGdJBjQokk3/G4Eey9pGWf0GfIXQCn9MWFbIe+rWJcYhI0itfCpoaJIbeRNrFGzUeU2fdC5k18UTkLAedVM2VcLAt7SK4I006XCKZqzmpHonUMFi50Y+ALjGOOSvd2VQBklDEOGSfN5k9FdABQwMieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4VVPHxs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4VVPHxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F52FC2BCB8;
	Sun, 17 May 2026 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042470;
	bh=O0cJqHav74hnGaZnyWRzv5dbWKVAnDFIt3OXKauWGyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V4VVPHxsnwFzI+JFR93qUVXNhhldyt+3Fv/yL9W+RN8LoevWuXPtOM5BgrAMLQCFu
	 atXGjvzh5Wmt2nmizgK39oAY9GvDNfT/O1UbqU6bkaJVl2onPGPQw2nhxuEb9Ib4HM
	 QNmgK4F9iSEavyZAko1MIg9eq80T4UbqZR/2XkbeJAXrsDYzGERW4bqnGl4i2w1lc7
	 w59TJMekHvQORFPagggX0/HnBuAGp7Bo88m12MrC4TQdTR4c4OnOhGg0fFQOWSTwA/
	 IgQYf6NmaMAUbmIged4FZOCFs9CZ8pCb2NMkxFMs7PUdyP+281z0OsAX84kw9w0ReL
	 py0BRTSRSvszw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1] mm/damon/sysfs-schemes: delete tried region in
 regions_rmdirs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260517175915.3352-1-sj@kernel.org>
References: <20260517175915.3352-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:27:49 +0000
Message-Id: <20260517182750.8F52FC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Moving the `sz_filter_passed` assignment to after `kobject_init_an=
d_add()` exposes uninitialized kernel heap memory to user space.
- [High] Relying solely on `kobject_put()` to remove directories from sysfs=
 leaves directories visible if references are held.
--

commit eda0f7269f695739057cee7bd02d81742d566163
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()

This commit updates DAMON sysfs to remove region objects from the linked li=
st
immediately before decrementing the kobject reference count to prevent
use-after-free races. It also modifies region population to only add the
region to the list after a successful kobject initialization.

Link: https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -163,7 +163,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
>  	struct damon_sysfs_scheme_region *r, *next;
> =20
>  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
> -		/* release function deletes it from the list */
> +		list_del(&r->list);
>  		kobject_put(&r->kobj);

This is not a new regression, but does relying solely on kobject_put() to
remove directories from sysfs leave them visible if references are still
held?

If an elevated reference count exists, such as a process having an open file
descriptor to a sysfs attribute, the kobject is not immediately released and
kobject_del() is delayed.

Could this leave the old region directory accessible in sysfs indefinitely,
causing stale directories to accumulate alongside new ones? Should
kobject_del(&r->kobj) be called explicitly before kobject_put() to cleanly
and synchronously remove the directory?

>  		regions->nr_regions--;
>  	}

[ ... ]

> @@ -2925,15 +2925,16 @@ void damos_sysfs_populate_region_dir(struct damon=
_sysfs_schemes *sysfs_schemes,
>  	region =3D damon_sysfs_scheme_region_alloc(r);
>  	if (!region)
>  		return;
> -	region->sz_filter_passed =3D sz_filter_passed;
> -	list_add_tail(&region->list, &sysfs_regions->regions_list);
> -	sysfs_regions->nr_regions++;
>  	if (kobject_init_and_add(&region->kobj,
>  				&damon_sysfs_scheme_region_ktype,
>  				&sysfs_regions->kobj, "%d",
>  				sysfs_regions->nr_regions++)) {
>  		kobject_put(&region->kobj);
> +		return;
>  	}
> +	region->sz_filter_passed =3D sz_filter_passed;

Could moving the sz_filter_passed assignment after kobject_init_and_add()
expose uninitialized memory to user space?

If the region object is allocated without zeroing the memory, calling
kobject_init_and_add() makes the region's kobject immediately visible in
sysfs.

If a concurrent read to the sz_filter_passed sysfs attribute occurs during
this window, could it read the field without locking and leak uninitialized
kernel heap memory to user space? Should the assignment occur before the
kobject is registered?

> +	list_add_tail(&region->list, &sysfs_regions->regions_list);
> +	sysfs_regions->nr_regions++;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517175915.3352=
-1-sj@kernel.org?part=3D1
