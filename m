Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F26233942
	for <damon@lists.linux.dev>; Thu, 18 Jun 2026 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796892; cv=none; b=BiMqrKZVU0EtFraYJulUVwGqDeXOZOiC1nQisNV2EHiFc6UCvVou2HRPqQiVjudYG4rT4Z1brKE97Dwxnr8QAtxKibYcdGLu5ZQVo5IGwAgkgnPsaRfnD3mFxPRMcM2v0pA6dTALxyWR3+QCkD2v+LA/SA2iNs3rQsxu5wwHbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796892; c=relaxed/simple;
	bh=6cRnXFAX7Mc4O1wwRZeB/hYqC7+3UhIy1cdzcnFg7Cg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q8l158KeTLoXAglOpjZqRBNvaqVLQlLYg4MeIIGXp2VaqlGc+wd+899jby8afLD6ixKt1X5QDMYDfjmQTRSn76AZ0Q+QzesB5V0Pbuq54KiP6ug64T0/Q7uW5d09O6rv0T12rAm9FTO2DURsUNwNH3SJ4i/tz3Te7uvZl6W1PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILvpUiA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILvpUiA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7171F000E9;
	Thu, 18 Jun 2026 15:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796891;
	bh=EYCDRw4yMvVgZwetbB2A0jhkZWUMXvvwmmz9zpCGQsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ILvpUiA8JKbrKJEnaPE0R3tgfalKuoY9XHwcJ8xu+3aM0DIqIdezFp8+yq7D0TGpV
	 miGl4pU0yh8Od4S1B27l+A29pSkiEDuG32AfallvWi7mmwsEnpCB47N+l8nRlgHoFd
	 SsBkHaMOYebVJWOiGTiylPPKXaK48ke7Lyxhrs1zubauNb6msX2pGzfbs/R5LEKmGU
	 ObF7JNcepqYJfjyS7HIHZBxXX+Th6AR4gYXbrNE3sxnxCn287kHlK8blXCMC33OsQW
	 BY0mhxJMjNxzEcFFnROJXZlo+5kTg6vnyfQaG/me111PSLVKwnrGR0juphmE0XQkzi
	 dl7keVqJRk2pQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 09/11] mm/damon/sysfs: kobject_del() probe
 filter dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260618151517.5366-10-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
 <20260618151517.5366-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:34:50 +0000
Message-Id: <20260618153451.1E7171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing `kobject_del()` call in `damos_sysfs_region_add_dirs()` =
error path causes delayed sysfs directory removal and subsequent `-EEXIST` =
name conflicts.
- [Medium] Missing `kobject_del()` in `damos_sysfs_probes_rm_dirs()` leaves=
 child probe directories lingering in sysfs on error paths.
--

commit 6a62b56c2acdfd514de2a6e4cd36c3839e0c6db5
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs: kobject_del() probe filter dirs

This commit fixes directory creation failures due to name conflicts on kern=
els
with CONFIG_DEBUG_KOBJECT_RELEASE. It does so by adding missing kobject_del=
()
calls before kobject_put() in the data attribute probe filter directories'
teardown path.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 5ca45654cdd39..36a0e82601697 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -962,8 +962,10 @@ static void damon_sysfs_filters_rm_dirs(struct damon=
_sysfs_filters *filters)
>  	struct damon_sysfs_filter **filters_arr =3D filters->filters_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < filters->nr; i++)
> +	for (i =3D 0; i < filters->nr; i++) {
> +		kobject_del(&filters_arr[i]->kobj);
>  		kobject_put(&filters_arr[i]->kobj);
> +	}
>  	filters->nr =3D 0;
>  	kfree(filters_arr);
>  	filters->filters_arr =3D NULL;

[Severity: Medium]
This is a pre-existing issue, but since we are fixing missing kobject_del()
calls here, should we also update damos_sysfs_probes_rm_dirs() in
mm/damon/sysfs-schemes.c?

When tearing down probe directories, the loop iterates over child probes and
calls kobject_put(), but omitting kobject_del() might leave the successfully
added child directories in sysfs pending delayed release:

mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs() {
    ...
	for (i =3D 0; i < probes->nr; i++)
		kobject_put(&probes_arr[i]->kobj);
    ...
}

Would this also result in -EEXIST name collisions on subsequent retry attem=
pts?

[Severity: Medium]
This isn't a bug introduced by this patch, but does the error path in
damos_sysfs_region_add_dirs() need similar handling?

If kobject_init_and_add() succeeds but the subsequent call to
damos_sysfs_probes_add_dirs() fails, we jump to the fail path:

mm/damon/sysfs-schemes.c:damos_sysfs_region_add_dirs() {
    ...
	err =3D kobject_init_and_add(&probes->kobj, &damos_sysfs_probes_ktype,
			&region->kobj, "probes");
	if (err)
		goto fail;

	err =3D damos_sysfs_probes_add_dirs(probes, ctx, dregion);
	if (err)
		goto fail;
    ...
fail:
	kobject_put(&probes->kobj);
	return err;
}

Could the lack of kobject_del(&probes->kobj) here delay the removal of the
sysfs directory and cause an unexpected -EEXIST conflict if userspace
attempts to recreate the region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618151517.5366=
-1-sj@kernel.org?part=3D9
