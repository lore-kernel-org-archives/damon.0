Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AE1EB5E3
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926751; cv=none; b=fPw0CBUFV/XN1TsnvM7kJpEqahoZhWVMKYDdUcKFX19tdStn5dFNFlMzSrh96LIM+k34ttky9K+d/9hNxWuCUEMtUw6IdW1Fqd0bkEOf7GCwnmdjLAozjvdQKOHfXLUjMiXcv/ucq90AF3Fj9A+2H6iPcSV0d4gVqk8zBU6krLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926751; c=relaxed/simple;
	bh=JoPpm+FMKlPF/adWSFXfNHNM1WSoV1qmLpgmmrLJ5IU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVSmsy6fdfYzhraMlZnQtf+DjNH9OTfDN5VBkwHJksINWjCWT9QaP0U7vPMxlRK4IwcKWzziOMIjK343MPKjFBtG8UeLVANDXDJXMCqG+OY5L//x+8jr7ypDJVpczdf4vqat47rqSxEfuH7JLdy53ou+Vg6a+SRiSavGg6Awc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SilKJB29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SilKJB29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50701F00A3A;
	Wed,  9 Sep 2026 04:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926750;
	bh=NojPrNk4bBs9B35U+fVNJFQtsnuAydvLm+gHADa4U9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SilKJB29DN7HhvgbPu2lNxviprFcXD5nnG4Y0Vt8v4IWd9ZDqK9avfJOzd7IdrcxX
	 M+YoGVpRydFY4LepPegUlOoAY05IcEKstGAuEOPXZThCGmeXFloQUT9ay0vfopFIG4
	 N81vKl2T/4aZ452cEU5xKiMkZ43mqb/Evo5SSqkZ1S4PLdrleM+J7HXDXP+h57Uxc/
	 ZJm4pkUFozh1HDaRJoVFmEJGZKg7A9DNb5YqdakfaIFiuWzHwhLfXg6zKsIo6ef1nz
	 6+QuarvYIS9mrbBYxCrnlLsHLbA5C4aIIUzw3yh3c21klfJCautTE3NkWxtPjDO506
	 IVnhi2GcEF9jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/sysfs-schemes: kobject_del() scheme dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909035529.159422-1-sj@kernel.org>
References: <2026090817-livable-sturdily-4c48@gregkh>
 <20260909035529.159422-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:05:49 +0000
Message-Id: <20260909040549.D50701F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: Missing `kobject_del()` for dynamically sized sysf=
s array directories (kdamonds, contexts, targets, regions) causes name conf=
licts on recreation.
--

commit 313d3e99fc72ef8df36e0924dc61e045a278961d
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.  Fix
those issues for scheme directories by adding kobject_del() calls.

Link: https://lore.kernel.org/20260628220121.97360-4-sj@kernel.org

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index bb2f4650741fa..7e4fb112d1154 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -954,6 +954,7 @@ static void damon_sysfs_schemes_rm_dirs(struct damon_=
sysfs_schemes *schemes)
> =20
>  	for (i =3D 0; i < schemes->nr; i++) {
>  		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
> +		kobject_del(&schemes_arr[i]->kobj);
>  		kobject_put(&schemes_arr[i]->kobj);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this fix for
the schemes directories, it appears the exact same omission of kobject_del()
is still present for other dynamically sized sysfs arrays (kdamonds,
contexts, targets, and regions).

For instance, in damon_sysfs_kdamonds_rm_dirs():

static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamo=
nds)
{
	...
	for (i =3D 0; i < kdamonds->nr; i++) {
		damon_sysfs_kdamond_rm_dirs(kdamonds_arr[i]);
		kobject_put(&kdamonds_arr[i]->kobj);
	}
	...
}

When updating these directories, the old directories are dropped using only
kobject_put() and new ones are immediately added with kobject_init_and_add()
using the same names. If CONFIG_DEBUG_KOBJECT_RELEASE is enabled or a
reference is held, won't this deferred removal leave the old directory
active and cause the recreation to fail with -EEXIST?

Should kobject_del() also be added to damon_sysfs_kdamonds_rm_dirs(),
damon_sysfs_contexts_rm_dirs(), damon_sysfs_targets_rm_dirs(), and
damon_sysfs_regions_rm_dirs() to prevent these same name conflicts?

> @@ -991,13 +992,15 @@ static int damon_sysfs_schemes_add_dirs(struct damo=
n_sysfs_schemes *schemes,
>  			goto out;
>  		err =3D damon_sysfs_scheme_add_dirs(scheme);
>  		if (err)
> -			goto out;
> +			goto del_out;
> =20
>  		schemes_arr[i] =3D scheme;
>  		schemes->nr++;
>  	}
>  	return 0;
> =20
> +del_out:
> +	kobject_del(&scheme->kobj);
>  out:
>  	damon_sysfs_schemes_rm_dirs(schemes);
>  	kobject_put(&scheme->kobj);

[Severity: High]
This is also a pre-existing issue, but similar to the rm_dirs() paths, the
error paths for adding other array elements appear to be missing
kobject_del().

For example, in damon_sysfs_kdamonds_add_dirs():

	for (i =3D 0; i < nr_kdamonds; i++) {
		...
		err =3D kobject_init_and_add(&kdamond->kobj,
				&damon_sysfs_kdamond_ktype, &kdamonds->kobj,
				"%d", i);
		if (err)
			goto out;

		err =3D damon_sysfs_kdamond_add_dirs(kdamond);
		if (err)
			goto out;
		...
out:
	damon_sysfs_kdamonds_rm_dirs(kdamonds);
	kobject_put(&kdamond->kobj);
	return err;

If adding the child directories via damon_sysfs_kdamond_add_dirs() fails,
the parent kdamond->kobj has already been added to sysfs. Doesn't branching
directly to 'out' leave a lingering sysfs node without calling kobject_del(=
)?

Should a similar 'del_out' error path be added to
damon_sysfs_kdamonds_add_dirs(), damon_sysfs_contexts_add_dirs(), and
damon_sysfs_targets_add_dirs()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909035529.1594=
22-1-sj@kernel.org?part=3D1
