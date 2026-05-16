Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA551F30A4
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778967599; cv=none; b=rMuWHZLP+fgry+i2PRcaQgXED8AOSXm3a171gmrr3F9AB9jKDprrRe04Ed3IyXgMatoPBlar2lpXGFMLWNltyPi/uRHAHu5FAXetD3TSChY7yFFB3jrT4wsj9C0d/SuamX7vYV5kvypwRmfZoH+xlCkkPsUdsP4hHYtcjJwub6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778967599; c=relaxed/simple;
	bh=8M7FBkzeEvVGrdZboACcChb/w9/kbmU3nPn8A5RPRuU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SoW2hC96zoxYzQOu9Ur3wexgIdTMrxFg56G38oCZrH9aKNJk/Zeu93ETUBXuEC7eRVka2r2wGNdVQi5Ui9dXkjQvHqSrZoheefil8So5/r1u4C8YCpf+dnoFd7jTRTXe/KOxXfIO0HpmoML6A571Kf3HDZQNDfGgqyYi1Dj/I2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3NuzT0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3NuzT0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28859C19425;
	Sat, 16 May 2026 21:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778967599;
	bh=8M7FBkzeEvVGrdZboACcChb/w9/kbmU3nPn8A5RPRuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=b3NuzT0NwRE+L3/Zh8+boh/eVky8jqsg1f3YmfHzpMRFH37uA18ZmHOHgZsSVeWWL
	 oX6seqwMc65MPYb8zCjo5KvvLQt4BChM696k7Gx/v/JkX7Pqxc69KGW6y8mNOeDTwy
	 dpn9edwie5+VKL4Dc2uGBcM6VwfItbZyo4O0cV9LBMkkgX2tznmEC3Km9Ub0wyI7gA
	 54B8lLBFRlL/wHCdeHJ8MO8y1noBYtJIi8XGaoxxmkQuu+RP5/qBys0P4iAaq6lwCZ
	 4LYDpGb6m18wlCMvtmtnbgEy9xwSdaEyNW59qL28/PXR3baK/TlnLf2GbqBnL2zDim
	 qFw56rTgSElMQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: delete tried region in
 regions_rmdirs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516211436.1883-1-sj@kernel.org>
References: <20260516211436.1883-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 21:39:58 +0000
Message-Id: <20260516213959.28859C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving `list_del()` out of the kobject release callback causes a U=
se-After-Free when `kobject_init_and_add()` fails in `damos_sysfs_populate_=
region_dir()`.
--

commit 97136b36d31f71cb6972114db84fe86abd95246f
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()

DAMON sysfs maintains the DAMOS tried region directory objects via a
linked list. When the user requests refresh of the directories, DAMON
sysfs removes all the region directories first, and then generate
updated regions directory on the empty space. Deletion of the container
region object from the linked list is now done inside the removal function
instead of the kobj release callback.

[1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 622c3799db87b..aefeb5d22fb7d 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -88,7 +88,6 @@ static void damon_sysfs_scheme_region_release(struct ko=
bject *kobj)
>  	struct damon_sysfs_scheme_region *region =3D container_of(kobj,
>  			struct damon_sysfs_scheme_region, kobj);
> =20
> -	list_del(&region->list);
>  	kfree(region);
>  }

Does removing list_del() here cause a use-after-free if kobject_init_and_ad=
d()
fails in damos_sysfs_populate_region_dir()?

If kobject_init_and_add() fails, the error path drops the reference:

mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir() {
    ...
	list_add_tail(&region->list, &sysfs_regions->regions_list);
	sysfs_regions->nr_regions++;
	if (kobject_init_and_add(&region->kobj,
				&damon_sysfs_scheme_region_ktype,
				&sysfs_regions->kobj, "%d",
				sysfs_regions->nr_regions++)) {
		kobject_put(&region->kobj);
	}
    ...
}

Because region is added to the list before kobject_init_and_add(), dropping
the reference will free the region, but it remains in regions_list since
the release callback no longer unlinks it.

Should we add an explicit list_del(&region->list) in the error path of
damos_sysfs_populate_region_dir() to prevent list corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516211436.1883=
-1-sj@kernel.org?part=3D1
