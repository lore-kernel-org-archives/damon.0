Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383C3128B8
	for <damon@lists.linux.dev>; Mon, 20 Apr 2026 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685985; cv=none; b=nz+DbE62YljZj1YnblYdXBylH9YEXrsf2h56xC6D5CVmZ0ex6zPamfrRe3mniPd4ikU8UnBZ4rfZno6d+9UsK3MLYDo/S/ZoVgnfeYPLOXlOTv6Ffpl4+f4H53gSUA+P727FUx6j5wy9c7lzCq6e2aX4gAyh4J/LF/43b5nLndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685985; c=relaxed/simple;
	bh=+ONdzAYfhJddmlk+5Bd7V6KFKakVHiQ0PWuLgmgy1ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sKtX8qx85clnamhO1Icm+qtCL37HB3hNT07jsVwukxrTo14zxnAo+HeV2Y1mKHfrKWkaCUluVtNwtbl6UnpYEwqvChmzmXLKj9OG32OCp6MWV00/0MsCOHIjWKTs1ZUMmMvsGDmru/HXNOl2RIsajevUVGX5BO+BOtFnabYEZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8ghjvTf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8ghjvTf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21A4C19425;
	Mon, 20 Apr 2026 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776685985;
	bh=+ONdzAYfhJddmlk+5Bd7V6KFKakVHiQ0PWuLgmgy1ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R8ghjvTfMyDKU6VTxba6sS8HBMS6e3xE+DatUsRvSnNpYM+mXn/FSCR8YOIy8BGBt
	 GOVxWJrK4TAzHsYBcGQeeiN+ls/SC+3wu/dJ0plWfo8wP892Y84NfCTCpCMeDsr4eA
	 lVmNcwO7HnBk8XXYMYJHy+up9tVEUOgrwzY5SbwcefEg/FmYgbVCtQZ3NcrKID05fi
	 4UwgoQpLVncwVD8f2OBioQdpnVQMH5UKQzUpdtrgnbY6SwqsmahEbmWuyoQYS4RKTh
	 WSW92eFOXW+6Ciq8UJME5QWabIGTkMyS0GNG0j4lNsCSTol1+kwrmQiLO7otJVxmuR
	 vBr/fRb+PbvGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix use-after-free on
 memcg_path and goal path
Reply-To: sashiko@lists.linux.dev
To: "Junxi Qian" <qjx1298677004@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260420085332.178473-1-qjx1298677004@gmail.com>
References: <20260420085332.178473-1-qjx1298677004@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 11:53:04 +0000
Message-Id: <20260420115304.D21A4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] The sysfs show functions `memcg_path_show()` and `path_show()` rea=
d string pointers without holding `damon_sysfs_lock`, leaving a Use-After-F=
ree vulnerability.
--

commit a381c30634b7e486fce5448c7aae9e23da7aecf9
Author: Junxi Qian <qjx1298677004@gmail.com>

mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path

This commit fixes a use-after-free race between the kdamond thread and
sysfs store operations. It does this by acquiring damon_sysfs_lock while
swapping the memcg_path and path string pointers, and freeing the old
pointers outside the lock.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 5186966dafb35..005cfecb11c5d 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -543,15 +543,20 @@ static ssize_t memcg_path_store(struct kobject *kob=
j,
[ ... ]
>  	strscpy(path, buf, count + 1);
> -	kfree(filter->memcg_path);
> +
> +	mutex_lock(&damon_sysfs_lock);
> +	old =3D filter->memcg_path;
>  	filter->memcg_path =3D path;
> +	mutex_unlock(&damon_sysfs_lock);
> +
> +	kfree(old);

Could this explicit free race with the lockless read in memcg_path_show()?

The VFS and sysfs core layers do not serialize concurrent show and store
operations for the same attribute. If one thread calls memcg_path_show(),
it evaluates the pointer without holding damon_sysfs_lock:

static ssize_t memcg_path_show(...)
{
        ...
        return sysfs_emit(buf, "%s\n",
                          filter->memcg_path ? filter->memcg_path : "");
}

Can a concurrent store operation swap the pointer and kfree() the old one
just before sysfs_emit() dereferences it? Does memcg_path_show() also need
to acquire damon_sysfs_lock?

[ ... ]
> @@ -1196,15 +1201,20 @@ static ssize_t path_store(struct kobject *kobj,
[ ... ]
>  	strscpy(path, buf, count + 1);
> -	kfree(goal->path);
> +
> +	mutex_lock(&damon_sysfs_lock);
> +	old =3D goal->path;
>  	goal->path =3D path;
> +	mutex_unlock(&damon_sysfs_lock);
> +
> +	kfree(old);

Similarly, does path_show() have the same vulnerability?

static ssize_t path_show(...)
{
        ...
        return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
}

Since goal->path is accessed locklessly here, can a concurrent path_store()
free the string right before path_show() reads it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420085332.1784=
73-1-qjx1298677004@gmail.com?part=3D1
