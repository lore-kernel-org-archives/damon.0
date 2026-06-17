Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8047ECDB
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708623; cv=none; b=NQ2af/gHysbUnULOyq7AXr9AFiVOdNDNu0/sAn+A6noUSN9OBKjLsy2At9jQ5KYpFLo9E/bnbxLTn9lCHtKRZpWnRteJhpBBouBffmSgUWKk52aq6VlexhHmKj+cm62VmmHnc+R+K9Bht5cbGxsRo8FCyK9Y+wkyO1+TmN4OM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708623; c=relaxed/simple;
	bh=TtI9nKuAMBJj5KaNml+It+EmC/xx8nVBfoq4cidHFq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JuxaULRBPba+xG4vCBTFnoDZxIyz+KRcGC1jXKh4Qju14XW98GkBKGCGesKJ8wodHUUtlOWPr6lrRcf8y0g0gzukt1rZFlax/HLHL19vcdfh0dlYnZkFlRqcPWytvG5xVGH7kn6z6LMdpTuf47xVH3XcAfU298F9xv+usikAPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TImgbd2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TImgbd2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D8D1F00A3D;
	Wed, 17 Jun 2026 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708622;
	bh=h/uV8chL9UtXhv5XAyqRRz9MY0fsGWjeDgMN4HLdqVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TImgbd2OlJRy32zyfvjlkyDbdg41Hlz8bOuI2IQRCrOtjkmXl943Dz7XMz4TZWa/+
	 fPohh/9SypcUQ/4+H1BI/w73kmRWhI8leNvWL73O4MnXrYUc+xLthTTL5gs/Z6f6xx
	 p5BiutepxEENrXB9hj1zYiPtvgDNow3Nw/Q4HzP2gDdCXPV380JAHoFNXJxkO2b96f
	 QqIURTe3c56vfBi/UbYMes4EIDuUdc+/9PQkFcVDTR5hsdvx4Qr4vBKS0pFsUy9dzK
	 Alh9B7BW8Z1JkXvmKNt6PJsCHr4gaPFkD/JPCu8etNOkDAJBzykdZo7Ris8+IVimvj
	 m0gQUNPgN2ljA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 05/11] mm/damon/sysfs-schemes: kobject_del()
 scheme filter dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-6-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:03:41 +0000
Message-Id: <20260617150342.59D8D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete bug fix: missing kobject_del() in damos_sysfs_probes_rm=
_dirs() and damon_sysfs_schemes_add_dirs() error path.
--

commit ada3b579d341495d80858ab88063949ce50e3fd8
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme filter dirs

This commit fixes directory creation failures caused by name conflicts by
adding kobject_del() calls for scheme filter directories when
CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index bf08e6e1f1635..300930c2c5b3f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -914,8 +914,10 @@ static void damon_sysfs_scheme_filters_rm_dirs(
>  	struct damon_sysfs_scheme_filter **filters_arr =3D filters->filters_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < filters->nr; i++)
> +	for (i =3D 0; i < filters->nr; i++) {
> +		kobject_del(&filters_arr[i]->kobj);
>  		kobject_put(&filters_arr[i]->kobj);
> +	}

[Severity: High]
This is a pre-existing issue, but while we are adding kobject_del() here to=
=20
prevent name conflicts, are there other locations that need the same fix?

For instance, in damos_sysfs_probes_rm_dirs(), the code iterates over=20
probes_arr and calls kobject_put() without a preceding kobject_del():

	for (i =3D 0; i < probes->nr; i++)
		kobject_put(&probes_arr[i]->kobj);

Additionally, in the error path of damon_sysfs_schemes_add_dirs(), if=20
damon_sysfs_scheme_add_dirs() fails after a successful kobject_init_and_add=
(),=20
the cleanup jumps to the out label:

out:
	damon_sysfs_schemes_rm_dirs(schemes);
	kobject_put(&scheme->kobj);
	return err;

Could these missing kobject_del() calls leave sysfs directories pending
delayed release, allowing the same name conflict crashes to occur?

>  	filters->nr =3D 0;
>  	kfree(filters_arr);
>  	filters->filters_arr =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D5
