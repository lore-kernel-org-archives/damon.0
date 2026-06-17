Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2246AEE5
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708951; cv=none; b=tUfZnttota0OD9LWSBJ7s0WKM9E40r4NtEYrNs6sxN57gzZYrunH19Z55sdZWcy483fru/V5HXEfJhKM9gYcgRhX6wLjSdvOt/k0ztwfz5e8so925SNkGBXcN6d4oQiBwPszCdHXfYFbMBCsr/LHS943dEuTO9DiN+BMwDilFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708951; c=relaxed/simple;
	bh=LRCxKGKGmx/CrThvmIQHKVdGatEvfN6m/vyQbKQW8CA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kTSnvtENpGYHxU/Jb/ZWEvYKS2zDpNQZ8R8+dO6glJjzHiqFzBxNVLFOKOT1u/+vvYnSSjPppyg7FdRnd2xT4Q2U/172/XcnbGQAO9Svbb38IQHhi8sTNcxCIqa/JhAKm6AB/wo1gHDg8fI5YhH6bk3hD+hrAsbK776Z56YopW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfe3kU1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfe3kU1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB11F000E9;
	Wed, 17 Jun 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708950;
	bh=0J9OqOLKD4aRW3d0qt5DXIItQFnI9aRHxdXRuldnh38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cfe3kU1gapuDy1vsjPzvUsuMDdrzxK8GUBr8AZxLV/OVcUwiX1LpvFn8XzJtVD/0O
	 dAYCNDl7zuvcEOdbJbQ4M6khaqinoOzW4+Su59MCSqv3qogzemIEtPnFFwzT30lUdH
	 tQX553OeDa6c+O6nJ78gWe0VpC2uJ/YNbhaGCKNjg4AHs6lR2oH+mU3YIaWhEOyzb4
	 wxQu0RRu3TkO99LfW1mWFaPzfL6UWZVB7Zm03+xK9YtoJJDBAaChtZRtkJ7hGAT2A2
	 xkGpIcSABjjJ9XOgIr9XgBBgGeXAONSUTKQovavs306Xikd7LRBgkrp4oM0Dv7WSAF
	 LevOxCxg9HYfg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 01/11] mm/damon/sysfs: kobject_del() target
 (normal), context and kdamond dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-2-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:09:09 +0000
Message-Id: <20260617150910.1CDB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak and uninitialized pointer dereference in `damon_sysfs_=
scheme_add_dirs()` error path due to shifted labels.
- [Medium] Missing `kobject_del()` in `damos_sysfs_probes_rm_dirs()` causes=
 sysfs name conflicts under `CONFIG_DEBUG_KOBJECT_RELEASE`.
- [Medium] Missing `kobject_del()` in `damon_sysfs_schemes_add_dirs()` erro=
r path causes sysfs name conflicts.
--

commit ca062d775b58ea3ec065a28f4400047399c0f380
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() target (normal), context and kdamond dirs
   =20
On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for normal creation paths of target, context and kdamond
directories, and error paths of context and kdamond directories by
adding kobject_del() calls.

Cc: <stable@vger.kernel.org> # 5.18.x

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 2e95e3bac774d..dba1c67fc188f 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -1642,6 +1643,7 @@ static void damon_sysfs_contexts_rm_dirs(struct dam=
on_sysfs_contexts *contexts)
> =20
>  	for (i =3D 0; i < contexts->nr; i++) {
>  		damon_sysfs_context_rm_dirs(contexts_arr[i]);
> +		kobject_del(&contexts_arr[i]->kobj);
>  		kobject_put(&contexts_arr[i]->kobj);
>  	}
>  	contexts->nr =3D 0;

[Severity: Medium]
This isn't a bug introduced by this patch, but does damos_sysfs_probes_rm_d=
irs()
need a similar kobject_del() fix to avoid sysfs name conflicts?

mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs() {
...
	for (i =3D 0; i < probes->nr; i++)
		kobject_put(&probes_arr[i]->kobj);
	probes->nr =3D 0;
...
}

[ ... ]

> @@ -1680,13 +1682,15 @@ static int damon_sysfs_contexts_add_dirs(struct d=
amon_sysfs_contexts *contexts,
> =20
>  		err =3D damon_sysfs_context_add_dirs(context);
>  		if (err)
> -			goto out;
> +			goto del_out;
> =20
>  		contexts_arr[i] =3D context;
>  		contexts->nr++;
>  	}
>  	return 0;
> =20
> +del_out:
> +	kobject_del(&context->kobj);
>  out:
>  	damon_sysfs_contexts_rm_dirs(contexts);
>  	kobject_put(&context->kobj);

[Severity: Medium]
This is a pre-existing issue, but does damon_sysfs_schemes_add_dirs() need a
similar kobject_del() fix in its error path?

mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs() {
...
		err =3D kobject_init_and_add(&scheme->kobj, ...);
		if (err)
			goto out;
		err =3D damon_sysfs_scheme_add_dirs(scheme);
		if (err)
			goto out;
...
out:
	damon_sysfs_schemes_rm_dirs(schemes);
	kobject_put(&scheme->kobj);
	return err;
}

If damon_sysfs_scheme_add_dirs() fails after kobject_init_and_add() succeed=
s,
the out label puts the reference without unlinking it.

Could this cause a directory creation failure on retry under delayed releas=
e?

[Severity: High]
This isn't a bug introduced by this patch, but while looking at error paths,
does damon_sysfs_scheme_add_dirs() have an uninitialized pointer dereference
and a resource leak?

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
...
}

If damon_sysfs_scheme_set_tried_regions() fails, the code jumps to
put_tried_regions_out and dereferences scheme->tried_regions.=20

Since damon_sysfs_scheme_alloc() allocates memory without zeroing it, won't
this dereference an uninitialized pointer?

Additionally, this jump entirely skips cleaning up the successfully
initialized stats object.

Should there be a put_stats_out cleanup label to avoid leaking it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D1
