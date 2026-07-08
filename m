Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A963FCB2C
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498811; cv=none; b=sE/ODCpDSNDkAakLFOUUvUBtOZuhLHzef9tICAWEEVw9Zr3hT3a3yb3EsCN03JVDRYQblKwJ70b9x3ULNpRgVvaA9/18fkGs4E/20QXRRREtm7qnM84E5CBc46bzYa1j4ijb9/1X144QHCZoGtExHeF1c6oa2q6iScLqECZhVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498811; c=relaxed/simple;
	bh=9M4vYaYPs1E2mJu7hhrazxJq42toNe1zEu9GG7/taww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ftCMHzXHjbahj5bWvRiihf8fS05ld5WObM3DtKfoNbj2+HejFwOjyno8TNZjjVFv/Uf4nj8b5nTA8Vwf98bktLZVBarhChthltuurViI2nWTlKdRftDlc8CMt5/yRz4EVOdRDvHnGxwKniBMaWnElyEBcAdiGVYxJuwXrohHSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by6175WK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by6175WK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E441F000E9;
	Wed,  8 Jul 2026 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783498810;
	bh=omflEm69Q3A9TCiZnXDsnSKHwQcCY58VNqDvYu6SB8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=by6175WKrBkaFyiPVFGZ/pp82lja1q4W+MTgg5frQhwfQclYsKDeSXIIG1LEY5fEE
	 eZ4PFQYxZK6Hcmz65mjM2pYJF94/Wlhlh0RXy/9wo6JJ7ClVLR5WTjPHZPk10GEx+M
	 /ZbyR6dEPAq2i86D4gZU4dVP6XI3egFT86RcHaDt1lFoZemYrdNd0N+9+q0AgbFJOT
	 kguxSvjuk+7BigAfnS7HJWditaNCx8I4a7y+7Oj2O6cEyc+xy+gTeyuIwkH+gg9kzH
	 N5cJNunpEEcRq1CjKVNvTk/Av9X1isG8Hc/C1rqcPK5/OK4yg93QZ8FUlZy/SjzpjA
	 Cp7KZrLRhVF7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/sysfs-schemes: fix tried_regions setup failure
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708080107.727043-1-lgs201920130244@gmail.com>
References: <20260708080107.727043-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:20:09 +0000
Message-Id: <20260708082010.10E441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized pointer dereference in error path of damon_sysfs_acc=
ess_pattern_add_dirs()
--

--- Patch [1]: [PATCH] mm/damon/sysfs-schemes: fix tried_regions setup fail=
ure cleanup ---
commit b97caf8d3b939c01dca3a53c5340d70ede6714d2
Author: Guangshuo Li <lgs201920130244@gmail.com>

mm/damon/sysfs-schemes: fix tried_regions setup failure cleanup

This commit fixes an uninitialized pointer dereference in the error cleanup
path of damon_sysfs_scheme_add_dirs(). It changes the failure jump target=20
for damon_sysfs_scheme_set_tried_regions() to avoid calling kobject_put()
on the uninitialized tried_regions pointer.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..0668a0e539713 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2516,12 +2516,12 @@ static int damon_sysfs_scheme_add_dirs(struct dam=
on_sysfs_scheme *scheme)
>  		goto put_filters_watermarks_quotas_access_pattern_out;
>  	err =3D damon_sysfs_scheme_set_tried_regions(scheme);
>  	if (err)
> -		goto put_tried_regions_out;
> +		goto put_stats_out;
>  	return 0;
> =20
> -put_tried_regions_out:
> -	kobject_put(&scheme->tried_regions->kobj);
> -	scheme->tried_regions =3D NULL;
> +put_stats_out:
> +	kobject_put(&scheme->stats->kobj);
> +	scheme->stats =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this cleanup,
I noticed the exact same uninitialized pointer dereference exists earlier in
the same file.

If damon_sysfs_access_pattern_add_range_dir() fails during the setup of "sz=
",
does the error path dereference an uninitialized pointer?

mm/damon/sysfs-schemes.c:damon_sysfs_access_pattern_add_dirs() {
    ...
	err =3D damon_sysfs_access_pattern_add_range_dir(access_pattern,
			&access_pattern->sz, "sz");
	if (err)
		goto put_sz_out;
    ...
put_sz_out:
	kobject_put(&access_pattern->sz->kobj);
	access_pattern->sz =3D NULL;
	return err;
}

Since damon_sysfs_access_pattern is allocated with kmalloc_obj(), its fields
are uninitialized. If the directory creation fails, the function returns an
error without writing to the pointer. The error path then jumps to put_sz_o=
ut
and calls kobject_put() on the garbage pointer access_pattern->sz, identical
to the bug fixed by this patch.

Could this be addressed with a similar fix?

>  put_filters_watermarks_quotas_access_pattern_out:
>  	kobject_put(&scheme->ops_filters->kobj);
>  	scheme->ops_filters =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708080107.7270=
43-1-lgs201920130244@gmail.com?part=3D1
