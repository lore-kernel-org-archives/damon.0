Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDB48A2C2
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709836; cv=none; b=ZBDWDzMmzXRnl2QrGo1a+4b06hiy0FAFnLt3lrgVlpUjtOHHcv8pXrBwOo7Iwt9bi/NkDUMYZ78RjNCQBvZW5IUacBGG7wYxhhaG8xnXjXx0uidWF9XcoZ+0Drpd+fy7uRNdq+/VspsdVtEnfsLyHv5r6AirRU+P+RI0bzKMgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709836; c=relaxed/simple;
	bh=ykw1bdwi3EJVyhcfuvnUcAhKJh26PBJADutLoDkUtqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oh15oAjIWlg7T+Pn0I6KzIXnDjnBeiLUADTvsZmAD8VSr0r9w74Wo7rcprcXR/asDsqzxigcVaZPNoIFgZi5CWEi6MhKyrazXvEipwP8Eex+f+VVl1LXdQ8ju+CAQkIeDHthxOInbuMevYNIT2DFijkTPv1+YpYM1VcMCkbXFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qopn8qbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qopn8qbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1818C1F000E9;
	Wed, 17 Jun 2026 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709834;
	bh=mXLoOtnfA6vQ3Luh3cu22W3NrRj9U2FY49I1Pulfv3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qopn8qbGvew1b5cZHcca+DAM/tK8UOk/NhZhiM4Mc8j9yryN4pgQDAXj4U20xfCpF
	 aVou0pKoSyOkbETpoKbDVmBnIUNgTH4ae0OIyvMwgulTTDaPHhkVqcju+XN79twt6j
	 CG0g+bbpSm/WmGWaZymXPlhGk37NafORmhADtzI5GZUEsWEYwW0G3rufdbIqCl1ti7
	 HTV+YOlxmdvV2jAhd2VLjMaMfCKn66a5amdvDU976H+98U9nwYhWYbyTg5UNmfCFZA
	 nBfEc0kTtxZ5K/5gUZy/VyPAljzzJIFPuYzdmMch8nH7MMt736J8l2pSH+tPcsPIZd
	 CYxImWUpJzRvA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 11/11] mm/damon/sysfs-schemes: kobject_del()
 region for populate_region error
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-12-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:23:53 +0000
Message-Id: <20260617152354.1818C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kobject_del()` in the error path of `damon_sysfs_schemes_=
add_dirs()` leads to a directory name conflict.
--

commit 49e94fa00bb0dc5e89c773883517ea2c4db5c66b
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() region for populate_region error

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.
Fix the issue for tried region directories in the error handling path of
damon_sysfs_populate_region_dir() by adding a kobject_del() call.

Fixes: b574a82d10de ("mm/damon/sysfs-schemes: implement tried_regions/<r>/p=
robes/")
Signed-off-by: SeongJae Park <sj@kernel.org>

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 108f6de32f8c1..084700e422cd5 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -3135,12 +3135,14 @@ void damos_sysfs_populate_region_dir(struct damon=
_sysfs_schemes *sysfs_schemes,
>  				sysfs_regions->nr_regions))
>  		goto out;
>  	if (damos_sysfs_region_add_dirs(region, ctx, r))
> -		goto out;
> +		goto del_out;
> =20
>  	list_add_tail(&region->list, &sysfs_regions->regions_list);
>  	sysfs_regions->nr_regions++;
>  	return;
> =20
> +del_out:
> +	kobject_del(&region->kobj);
>  out:
>  	kobject_put(&region->kobj);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the exact same problem
exist in damon_sysfs_schemes_add_dirs() when damon_sysfs_scheme_add_dirs()
fails?

mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs():

	for (i =3D 0; i < nr_schemes; i++) {
		...
		err =3D kobject_init_and_add(&scheme->kobj,
				&damon_sysfs_scheme_ktype, &schemes->kobj,
				"%d", i);
		if (err)
			goto out;
		err =3D damon_sysfs_scheme_add_dirs(scheme);
		if (err)
			goto out;

		schemes_arr[i] =3D scheme;
		schemes->nr++;
	}
	return 0;

out:
	damon_sysfs_schemes_rm_dirs(schemes);
	kobject_put(&scheme->kobj);
	return err;

If damon_sysfs_scheme_add_dirs() fails, the code jumps to the out: label
and skips calling kobject_del(&scheme->kobj) for the scheme that successful=
ly
ran kobject_init_and_add().

Under CONFIG_DEBUG_KOBJECT_RELEASE, this delayed kobject_release() could le=
ad
to a directory name conflict (e.g. "0") if userspace retries writing to
nr_schemes immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D11
