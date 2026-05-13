Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E31C68F
	for <damon@lists.linux.dev>; Wed, 13 May 2026 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778630919; cv=none; b=ioUXs0J1a9pnyTmYfR0btdswo+6OomoNgh5a5wwKI3D1gOP/evgAR4Mwz+sgFKzEFpZ204f5jbDiHnj79x8x5UTcdvw3LtUkC7AjMeRINrqgeeLznE4jD2NETbeQ5hNcJIXsA3UzNscnrIuN5XDBRZMVpWpOIy3I5dTuJdnDLcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778630919; c=relaxed/simple;
	bh=nrSkNPMWq0pkaJWvhzVWv2wddLHviZpAS7H/C0PsIVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sMPVoYG/Zl6xPV0wi4qLWKLUrIbHDdeHnBjyc0V97zRVTv6gSpf3VQlwoHj/QLT89LsIk55Fzvua5hAPQTP2isn9tk7c93j/kGZnoid14tntDirE+tvCgfACQoEUBCuKnaZYC/NwHaEWwmXu6GmfOxS5/crlRc8SGuvDCwPJoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpZGZVS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpZGZVS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CFFC2BCB0;
	Wed, 13 May 2026 00:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778630919;
	bh=nrSkNPMWq0pkaJWvhzVWv2wddLHviZpAS7H/C0PsIVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qpZGZVS/cSuQcupjyf7n4vrpQwf+vQMVN1VkTAlXASkQGJdKTTqaSwDdHVb4v8iKS
	 o61rBK34NFrK37E+p1sE50gDFxI9niI0/pIZcUpOCFhlVTn+vvvb8JEtOHjnz+YoA8
	 eW+1wqpdzO+SJTBshPZ0uwonN6V89YDKEatWgcykO8Ez8HvtMmJJAKhe97EJnuLQo7
	 YDP6v2pOWVb2O1OighppVxC6iSlIiAxCS9UDEKtqk5AzgSkz3Q6MHNzE10PjOL2zau
	 xRpK6mVKjCJ7I7kFnI8xZj0vMt4aQs7eevkBnhjo/O31He8yxm0LJ4ZO7PWy08vYcV
	 3ktE7Gs+DFiIQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: fix double increment of
 nr_regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Agarwal" <agarwal.vineet2006@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260511191218.98881-1-agarwal.vineet2006@gmail.com>
References: <20260511191218.98881-1-agarwal.vineet2006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:08:38 +0000
Message-Id: <20260513000838.D0CFFC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The patch fails to restore the documented 0-indexed ABI, leavi=
ng region directory names 1-indexed.
- [Critical] Pre-existing: Use-After-Free and list corruption due to synchr=
onous `kobject_put()` assumption.
- [Medium] Unbalanced `nr_regions` increment on `kobject_init_and_add()` fa=
ilure causes a permanent state leak.
--

commit 66d182db7d03e02c982ddd51e0ba311b2642559b
Author: Vineet Agarwal <agarwal.vineet2006@gmail.com>

mm/damon/sysfs-schemes: fix double increment of nr_regions

This commit changes damos_sysfs_populate_region_dir() to use the already
incremented value of nr_regions for naming new region directories,
preventing the skipping of directory numbers.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 622c3799db87b..5d966ac864193 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2998,7 +2998,7 @@ void damos_sysfs_populate_region_dir(struct damon_s=
ysfs_schemes *sysfs_schemes,
>  	if (kobject_init_and_add(&region->kobj,
>  				&damon_sysfs_scheme_region_ktype,
>  				&sysfs_regions->kobj, "%d",
> -				sysfs_regions->nr_regions++)) {
> +				sysfs_regions->nr_regions)) {

Does this change the ABI from 0-indexed to 1-indexed? Since nr_regions is
incremented just before kobject_init_and_add(), the first directory will be
formatted with the value "1". The kernel documentation indicates these
directories should start from 0.

>  		kobject_put(&region->kobj);

If kobject_init_and_add() fails here, we call kobject_put(&region->kobj) but
do not decrement sysfs_regions->nr_regions. Will this permanently inflate t=
he
counter and cause subsequent directory names to skip numbers, since
damon_sysfs_scheme_regions_rm_dirs() decrements the counter based on the
remaining successfully added elements in the list?

There might also be a pre-existing issue with the region list lifecycle. If
damon_sysfs_scheme_regions_rm_dirs() iterates regions_list and calls
kobject_put() on each region's kobj, does it assume the kobject release
function will synchronously remove the region from the list?

If the release is delayed, for instance by external sysfs references or
CONFIG_DEBUG_KOBJECT_RELEASE, the object could remain on regions_list. If
damos_sysfs_populate_region_dir() then concurrently adds to regions_list
with list_add_tail(), could the delayed release race and cause list
corruption?

Could a subsequent call to damon_sysfs_scheme_regions_rm_dirs() traverse
freed list nodes and call kobject_put() on zero-refcount objects if the
release hasn't completed?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511191218.9888=
1-1-agarwal.vineet2006@gmail.com?part=3D1
