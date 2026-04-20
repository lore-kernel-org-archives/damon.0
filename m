Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AA3A16A9
	for <damon@lists.linux.dev>; Mon, 20 Apr 2026 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776709906; cv=none; b=dXUW0pJCqaFRtZaJIbGC50lTvLUe5sBw+IUDfJ2b6gF1vfl0q2ASpUU1uKqOgUXYU+uPP6hNlbPiR1AptLuYJmVW9PifbCuu5Qmm2P6hylnVV4yZosuw/S7Hi6c2Ua1le+EfL0bsTJ8jm42o6aXIHcOr0+rxzq+P+mR4XQYfXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776709906; c=relaxed/simple;
	bh=zfCBQ6+z745p9odlNPzzi8bZ4QQ+RdgS/k56q4m6Hwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROtFIEfWPTmqVetbD0jtEXRtB3I8VAJD+FfvL7dI6C3jvtagzSfXMK9w3zyO3ZIhx3+1J8+zNeYDwDGlE/zqe6ypHG/ENnJeh1PPO67vKWFZV075rWtSdg3C77Ko+mIEburXQE3h4bQU6PxcgGEXp2i6OVpF5/lwnVCWIitmqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBfzOzqP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBfzOzqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA7AC2BCB0;
	Mon, 20 Apr 2026 18:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776709906;
	bh=zfCBQ6+z745p9odlNPzzi8bZ4QQ+RdgS/k56q4m6Hwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KBfzOzqPS0oPma1Fp8DRqHU4SPhw5CI8kZaR402GeZxPowYUy40dSds5MeYtu5K/a
	 GNSivQ3eXoQPHBNERcGHw1W6GFvj4wc5NS5/OP8wcBDXH28DLu6+3dz5kvSIHRBVZf
	 DDx4D5Go8daV0hp7pZHaXMPYGoMQYuy/K9FItdcJ36baQQUlRbcXubrDJ9ylGH2pPA
	 3caltwq5xTXULPh+SMYfL7+W1zd7rZZJIc+yOsMoAKMrzmcDytpNHyCx41kRhjSvpF
	 6w7WGalYCH0Re4aOtynVXLhaYD/Ezl2NdpVS9vFopwyeKMelDvq+hNtYKZ1IMiqB51
	 dflqOOHcm7oeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/sysfs-schemes: fix use-after-free on
 memcg_path and goal path
Reply-To: sashiko@lists.linux.dev
To: "Junxi Qian" <qjx1298677004@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260420125405.362137-1-qjx1298677004@gmail.com>
References: <20260420125405.362137-1-qjx1298677004@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 18:31:45 +0000
Message-Id: <20260420183146.0DA7AC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [High] Using `mutex_lock(&damon_sysfs_lock)` in sysfs `.show` and `.store=
` callbacks introduces a classic ABBA deadlock against concurrent directory=
 removal.
--

commit 01b23742d072b6f9a33d05db48195e9adf5cf0a9
Author: Junxi Qian <qjx1298677004@gmail.com>

mm/damon/sysfs-schemes: fix use-after-free on memcg_path and goal path

This commit wraps the string pointer reads and writes in memcg_path_show(),
memcg_path_store(), path_show(), and path_store() with damon_sysfs_lock
to prevent use-after-free bugs when racing with the kdamond thread.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 5186966dafb35..1a890e2a4eb9c 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -533,9 +533,14 @@ static ssize_t memcg_path_show(struct kobject *kobj,
>  {
>  	struct damon_sysfs_scheme_filter *filter =3D container_of(kobj,
>  			struct damon_sysfs_scheme_filter, kobj);
> +	ssize_t len;
> =20
> -	return sysfs_emit(buf, "%s\n",
> +	mutex_lock(&damon_sysfs_lock);

Could this introduce an ABBA deadlock against concurrent directory removal?

When a user reads a sysfs file, kernfs acquires an active reference
(s_active) before executing the show callback, which now blocks
unconditionally on damon_sysfs_lock.

If another thread simultaneously writes to a file that removes directories
(like nr_filters_store), it will acquire damon_sysfs_lock and call
kobject_put(). The teardown path then invokes kernfs_drain(), which
synchronously waits for s_active to drop.

This leaves the teardown thread holding the lock and waiting for s_active,
while the read thread holds s_active and waits for the lock.

Should this use mutex_trylock(&damon_sysfs_lock) and return -EBUSY on
failure, similar to other sysfs callbacks in this subsystem?

> +	len =3D sysfs_emit(buf, "%s\n",
>  			filter->memcg_path ? filter->memcg_path : "");
> +	mutex_unlock(&damon_sysfs_lock);
> +
> +	return len;
>  }
> =20
>  static ssize_t memcg_path_store(struct kobject *kobj,
> @@ -543,15 +548,20 @@ static ssize_t memcg_path_store(struct kobject *kob=
j,
>  {
>  	struct damon_sysfs_scheme_filter *filter =3D container_of(kobj,
>  			struct damon_sysfs_scheme_filter, kobj);
> -	char *path =3D kmalloc_array(size_add(count, 1), sizeof(*path),
> -				   GFP_KERNEL);
> +	char *path, *old;
> =20
> +	path =3D kmalloc_array(size_add(count, 1), sizeof(*path), GFP_KERNEL);
>  	if (!path)
>  		return -ENOMEM;
> =20
>  	strscpy(path, buf, count + 1);
> -	kfree(filter->memcg_path);
> +
> +	mutex_lock(&damon_sysfs_lock);

Does this face the same deadlock risk as the show function?=20

If converted to mutex_trylock(), would we need to free the newly allocated
path buffer before returning -EBUSY?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420125405.3621=
37-1-qjx1298677004@gmail.com?part=3D1
