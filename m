Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6E347FC4
	for <damon@lists.linux.dev>; Sat, 16 May 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968327; cv=none; b=M1Aqu12kXJ5XRzTzxw1sPYD383hWAo6rYWFt2Pv/67mJenYICWRViftMbO7RuHIaOrsCQH7+O7ceZkitr4MCvMJvXKTlna3dEZ/VplX9dlGeY2uWHog+UDhbFsE6B9ZUlYmsYzIXS9NCjYjNffeSysDuEbiNJ3TEyVlZKLxHNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968327; c=relaxed/simple;
	bh=MIptBZ9dBHtkFftfU2VjaqI+Aavdb4eQVCRT6NjOaCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBcOz/xbQBe2uuyeRSOeQvdsFKcoMTFFIXlV4oXcCDwKK5YEm3AAY4wp47luqeS3wR8H+7220OqZSGodtLDZWiNIqR4BcmINhqomD+xAAlIYUGtXUDzNgekuGUVnfHi6Gz8n/mYnDmgiJgrJ7gggZ8aOOtDUFCLVQnksNlHPKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHgzMbuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHgzMbuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8F6C19425;
	Sat, 16 May 2026 21:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778968327;
	bh=MIptBZ9dBHtkFftfU2VjaqI+Aavdb4eQVCRT6NjOaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHgzMbuf14KlDrjnHMTe1sog5KKLmM0wyvnPXm5/DQ633b8S3xX6Cj2LxGePhZ+9t
	 Gpx0oCSbPAq7ZpyQ0u9xc+0UwwkkHDxU8C7J73NpTmfGf8By6gdEWToqRsJ5kpANdA
	 FQGod5693/jeOhHHbrE8N9i4xG4xC9EY65eDvW2GQ0/8K5Hhx79IR4jgEUmqncJ0ws
	 JnoF/zokbOhU1cgzPtkgoVQDhD1R7JIW6mVOW/denDz0hxfoK3KhFYlovvKJ8zW0cc
	 5oqMaA5F+UeGDIRKf7PGA668bb7yKMQTAp1vP1iFHSxqLn8/US2qASSlQnYZCD7qfd
	 QN+Tzbdvp3OkQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 24/28] mm/damon/sysfs: add filters/<F>/path file
Date: Sat, 16 May 2026 14:51:24 -0700
Message-ID: <20260516215126.3377-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516192905.5297EC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 19:29:04 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing string trimming in `path_store()` causes double newlines in `path_show()` output.
> --
> 
> commit 355d50ee619dc1c941ec5aef02eb71147957c977
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: add filters/<F>/path file
> 
> Introduce a new DAMON sysfs file for letting users setup the target
> memory cgroup of the belonging memory cgroup attribute monitoring.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index f1b7d79386866..2df1d670ee77d 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > @@ -862,11 +867,46 @@ static ssize_t allow_store(struct kobject *kobj,
> >  	return count;
> >  }
> >  
> > +static ssize_t path_show(struct kobject *kobj,
> > +		struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct damon_sysfs_filter *filter = container_of(kobj,
> > +			struct damon_sysfs_filter, kobj);
> > +	int len;
> > +
> > +	if (!mutex_trylock(&damon_sysfs_lock))
> > +		return -EBUSY;
> > +	len = sysfs_emit(buf, "%s\n", filter->path ? filter->path : "");
> > +	mutex_unlock(&damon_sysfs_lock);
> > +	return len;
> > +}
> > +
> > +static ssize_t path_store(struct kobject *kobj,
> > +		struct kobj_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct damon_sysfs_filter *filter = container_of(kobj,
> > +			struct damon_sysfs_filter, kobj);
> > +	char *path = kmalloc_objs(*path, size_add(count, 1));
> > +
> > +	if (!path)
> > +		return -ENOMEM;
> > +	strscpy(path, buf, size_add(count, 1));
> 
> Will this strscpy() result in a double newline in the output of path_show()?
> 
> When users write to the path sysfs file using standard tools like echo, the
> input typically includes a trailing newline character. This copy operation
> will store that newline directly into filter->path.
> 
> When read back, path_show() uses sysfs_emit() with "%s\n", which will append
> a second newline.
> 
> While a subsequent commit ("mm/damon/sysfs: setup damon_filter->memcg_id
> from path") uses sysfs_streq() which safely ignores trailing newlines for
> path matching, could we strip the trailing newline here to avoid the
> formatting anomaly in the sysfs output?

Good catch, but quite trivial.  And other similar arbitrary string parameters
work in the same way.  Let's keep this as is for now.

> 
> > +	if (!mutex_trylock(&damon_sysfs_lock)) {
> > +		kfree(path);
> > +		return -EBUSY;
> > +	}
> > +	kfree(filter->path);
> > +	filter->path = path;
> > +	mutex_unlock(&damon_sysfs_lock);
> > +	return count;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516183712.81393-1-sj@kernel.org?part=24


Thanks,
SJ
