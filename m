Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF417745
	for <damon@lists.linux.dev>; Sat, 16 May 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778959746; cv=none; b=T7pgUXOZYB+W5l0BuD/jF/Bk1vZ4bcZxkNO/3xOTrBlT0IZA/Zb4+qFRLF+AyYty8FZX4P3GeABRETO/kHK1NDaXhYu+RIyfWsjtLmOHLINHHO5YpS9JeFq20SzAl9H1U3ET3hSlEO451I9so3UCoT0eKZ0d8OLS60imkXHP8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778959746; c=relaxed/simple;
	bh=N05waab7ZQ4qZjJWUkL+ZWTDXl+4Xjrs4Kszo7bGJWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FkFBGkr8hS9B5t7mbkJJTIjiJJ+RroTT/5va6vsEWczg0cqpkUfRarcYrb6maNxULBwvNvsiRDlf4FVMVeGIDwwF8U53gPp/LjGD8n9RLlCkhqE8OMvgKEN4ySKqxgrXIjybylzKt7dHxGZKI0liNgmdW8BurF/jDljLD2KFnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI7YJYoO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI7YJYoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5297EC19425;
	Sat, 16 May 2026 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778959745;
	bh=N05waab7ZQ4qZjJWUkL+ZWTDXl+4Xjrs4Kszo7bGJWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=gI7YJYoOnLtzGukgB6I2ySbDgMT/ImPYoCw2vy6kb5mfv9CMTSaJc+SOOUnnfYNJx
	 xKAjeVEG2KpJ6D5+Vz2G+6QwROVfIVqgrpXnD1r2/TpXEr3HXajCs2kgD6R+p01XFu
	 t3M56QdhOlYCJadFgti/Ziq4t/qtwMNvncnh4fM9xfpG8LqCPi/hOCzMctv3Ww5EN6
	 HDhJ0EAhMxkZrTap2pdXlurx09B0poeRlipvxOfdxnmmuDLnkb0vmEQ28WAK2LodPa
	 Aa/9zI40W3iId0dwIaDkeLoDX7KyQ8PqxUBtWIX7v4lwMX86nhkjW8ymq61fLe9/T1
	 HQWtH/EvbjTgw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 24/28] mm/damon/sysfs: add filters/<F>/path file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516183712.81393-25-sj@kernel.org>
References: <20260516183712.81393-25-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 19:29:04 +0000
Message-Id: <20260516192905.5297EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing string trimming in `path_store()` causes double newlines in=
 `path_show()` output.
--

commit 355d50ee619dc1c941ec5aef02eb71147957c977
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: add filters/<F>/path file

Introduce a new DAMON sysfs file for letting users setup the target
memory cgroup of the belonging memory cgroup attribute monitoring.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index f1b7d79386866..2df1d670ee77d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -862,11 +867,46 @@ static ssize_t allow_store(struct kobject *kobj,
>  	return count;
>  }
> =20
> +static ssize_t path_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_filter *filter =3D container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +	int len;
> +
> +	if (!mutex_trylock(&damon_sysfs_lock))
> +		return -EBUSY;
> +	len =3D sysfs_emit(buf, "%s\n", filter->path ? filter->path : "");
> +	mutex_unlock(&damon_sysfs_lock);
> +	return len;
> +}
> +
> +static ssize_t path_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_filter *filter =3D container_of(kobj,
> +			struct damon_sysfs_filter, kobj);
> +	char *path =3D kmalloc_objs(*path, size_add(count, 1));
> +
> +	if (!path)
> +		return -ENOMEM;
> +	strscpy(path, buf, size_add(count, 1));

Will this strscpy() result in a double newline in the output of path_show()?

When users write to the path sysfs file using standard tools like echo, the
input typically includes a trailing newline character. This copy operation
will store that newline directly into filter->path.

When read back, path_show() uses sysfs_emit() with "%s\n", which will append
a second newline.

While a subsequent commit ("mm/damon/sysfs: setup damon_filter->memcg_id
from path") uses sysfs_streq() which safely ignores trailing newlines for
path matching, could we strip the trailing newline here to avoid the
formatting anomaly in the sysfs output?

> +	if (!mutex_trylock(&damon_sysfs_lock)) {
> +		kfree(path);
> +		return -EBUSY;
> +	}
> +	kfree(filter->path);
> +	filter->path =3D path;
> +	mutex_unlock(&damon_sysfs_lock);
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516183712.8139=
3-1-sj@kernel.org?part=3D24
