Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F4466B7B
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709070; cv=none; b=ngDTAxPsyIxHta+sQTfZFJveN76pvk+jIwrJyHKhnkVQ8jQxoK4PQvx13dkdr9VwjM4KWyroit0oSst0vmhXHRpRPRd0FaSdMWzKoK63dp9Jx+rSjOD4pzOwKX8WWMnDGLnPUTnse1mZM8xzIHeRH7BlHYcOM2dItew54x88RRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709070; c=relaxed/simple;
	bh=srDvC9Kv4iH2xxCBZVpxnTxslpymMWiP0PGPDjUR6fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X77q0p4W+vtRd8xHAK8upwiX8/e/P3AjUz7EwGuvkKaT0N4xrv4BSMTyBRcDyZZzURkytp9J5ImWru0k8PSHcfZetk726swgpyiAEFQkFYia737fUWOjdQ0Dg9EZJ1b9rlHhD0j6PwLB3RvzCjp5a9F2Ml8pgFfdOBWx9rXqpes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhLeY81X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhLeY81X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693BA1F000E9;
	Wed, 17 Jun 2026 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709069;
	bh=TSf+EVXbsERwTqHb59yodOCyqddK1Hc6A8Qz7MC0R48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhLeY81XnqNKI7Fp1PWAy7ZYTGVHkRQAmfQ09dIgKOtUWI1OyK/0wYdVEnWt0PN1t
	 7dBExYA+hMX5S4YtcDs+BNLbjPtrvBojJe1DJD6WGuvPvrIko+FJdIwvErBPhb4pYM
	 C/XuvqwlDcTYoF7BKMQjrd3690lH9GBPRMfUoThZqPD1ifSthCLg6q4rKmysSdcW3F
	 TU44P0OHG0RL5enyFT8pOD6MixgAb1W7wu/s+zXfdVNnYmZNEM72CnSINZZwTjRaKs
	 Rj87gEScIYZeheEEMfFJkUqbjTGkHmk4og+DBVEAew9qsvJy8qwUB5cfaZq2HRC3es
	 RG+IGSZsCWp4g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 04/11] mm/damon/sysfs-schemes: kobject_del()
 scheme region dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-5-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:11:08 +0000
Message-Id: <20260617151108.693BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: `damos_sysfs_probes_rm_dirs()` lacks `kobject_del(=
)` during array updates.
- [High] Missing `kobject_del()` in error paths after successful `kobject_i=
nit_and_add()`.
--

commit 092044609406a531b0aee50bbd25500efab8e006
Author: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs-schemes: kobject_del() scheme region dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme region directories by adding kobject_del()
calls.

Link: https://lore.kernel.org/20260517205828.6204-1-sj@kernel.org

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 37cf6edb54f17..bf08e6e1f1635 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -334,6 +334,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
>  	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
>  		damos_sysfs_region_rm_dirs(r);

[Severity: High]
This is a pre-existing issue, but since damos_sysfs_region_rm_dirs()
calls damos_sysfs_probes_rm_dirs(), does damos_sysfs_probes_rm_dirs()
also need to explicitly call kobject_del() to avoid the same name
conflict regressions?

Looking at damos_sysfs_probes_rm_dirs():

mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs() {
	...
	for (i =3D 0; i < probes->nr; i++)
		kobject_put(&probes_arr[i]->kobj);
	...
}

If kobject_del() isn't called here prior to kobject_put(), won't delayed
releases under CONFIG_DEBUG_KOBJECT_RELEASE collide with immediate
recreations, leading to -EEXIST failures when retrying probe creation?


[Severity: High]
This isn't a bug introduced by this patch, but does this code also miss
kobject_del() in the error paths after successful kobject_init_and_add()
calls?

In the error paths for directory creation, if kobject_init_and_add()
succeeds but subsequent setup steps fail, should the error rollback
explicitly call kobject_del() before kobject_put() to unlink the
directory?

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

If kobject_del() is omitted in these error paths, could the directory
remain anchored in sysfs, causing -EEXIST name conflicts on retry
because the array count was not incremented?

>  		list_del(&r->list);
> +		kobject_del(&r->kobj);
>  		kobject_put(&r->kobj);
>  		regions->nr_regions--;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D4
