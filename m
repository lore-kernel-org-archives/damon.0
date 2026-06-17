Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC58258EF9
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709167; cv=none; b=IS2rLIVad8aIKjws6O69NyoFngWLk9NLSGnwb1CoXnrv4a4+Hv7ze66wdm4SFKNF2FL2XVJ2NCLrxb8rYLl6VGQA3MRZFwGoOsq8O5JKec2F/3UZcu3bFoW6bnwqWaHHRx9NtYQbjW2+6YjecGU+RsYkj/E6P700vCZDoE/XgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709167; c=relaxed/simple;
	bh=9z78GlFXGtddzoLe5Ryk9wF6dQiia+4vcTm7i4mOhns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=irK+jmWbkWKuVcxC/wnRDu53gvWxPqGldhbZNVN8WBf4m1gyTyutCqap6kuOxCf4WCHY/XboBslmylri/wlsItyr+sn4tWpBqGmbrCAgjckyVXfxNRXMI2sH0WuI155feEeCmHxSd4UGbfcfK61GUY/cxYGTPkL0WnEI7X6j4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfVL/rBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfVL/rBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC151F000E9;
	Wed, 17 Jun 2026 15:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709165;
	bh=aKa7s2X3b9T3vt+GvzAttaABKqsGqJ+E2tw4pIH9bh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QfVL/rBZ5UvnPFDaWMnrzYVPNM00U4rRPOu8OH89wAdFDlq9g7k+enQdDXXq35ySS
	 M4vwBFn3gBtVkbJ3asJjJPWLnrj/aIcnKuFDiIz4NVbkUWTfSp22kmCInrbZy/ralA
	 dLKqAxsv/CLsYjJx/465YJzxeCzcT9e1aFsFaZe9v59f+oX3baUsAT300YJXD2p3El
	 rCdbvhqrMHXa7tLKLoTWMfO7g6OzFpHCZpKFlX89t/qJ+qQjwlENpzNhIosTuAaOIU
	 5/bFtKh/L54Etvw+aoE2c16Ec5U7Fl/GZRRXWhDTRyEOfClRLnaqk/HNJnViwPJWHz
	 Z5xpQO8UpGbfA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 06/11] mm/damon/sysfs-schemes: kobject_del()
 scheme quota goal dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-7-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:12:44 +0000
Message-Id: <20260617151245.8FC151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kobject_del()` in the error path of `damon_sysfs_schemes_=
add_dirs()`, leading to sysfs directory name conflicts.
--

commit 58717b37ac0466e3caf0f4f4b66fbd823b1faaab
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme quota goal directories by adding kobject_del()
calls.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 300930c2c5b3f..737638be84f15 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1465,8 +1465,10 @@ static void damos_sysfs_quota_goals_rm_dirs(
>  	struct damos_sysfs_quota_goal **goals_arr =3D goals->goals_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < goals->nr; i++)
> +	for (i =3D 0; i < goals->nr; i++) {
> +		kobject_del(&goals_arr[i]->kobj);
>  		kobject_put(&goals_arr[i]->kobj);
> +	}
>  	goals->nr =3D 0;
>  	kfree(goals_arr);
>  	goals->goals_arr =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but it appears the same missing
kobject_del() issue exists in damon_sysfs_schemes_add_dirs().

When damon_sysfs_schemes_add_dirs() fails after successfully calling
kobject_init_and_add() for a new scheme, the error path drops the kobject
reference using kobject_put(), but fails to call kobject_del():

mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs() {
    ...
		err =3D kobject_init_and_add(&scheme->kobj,
				&damon_sysfs_scheme_ktype, &schemes->kobj,
				"%d", i);
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

Under CONFIG_DEBUG_KOBJECT_RELEASE, the release of the kobject is delayed.
Because the parent kobject is persistent, the scheme directory remains
linked in the sysfs tree until the delay expires.

If a user subsequently retries writing to nr_schemes, could the kernel
attempt to create a new scheme kobject with the same name under the same
parent, triggering a -EEXIST name collision?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D6
