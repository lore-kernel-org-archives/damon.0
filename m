Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875A47CC99
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709353; cv=none; b=Dsx+OzBl1ohF8sfrNNRqRcRFiw9k59k52ZH6gL32y7MsLaIwfx4OrXAE1dyWqonuEsNWaob4biEKBfs6qZg48wA2Uyyrwr9cw2Kd6UOWknUX9MErlIinVwtnJe2FW+M3kzdiGWqV/GhQ/bZ75KuM/QVevd3+DSF1p1O/YiJsfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709353; c=relaxed/simple;
	bh=0LcnSJThiJ0aOQnWjxru4SxED/oeyb3aQv9Yp6tSZeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Widdg2nAy7OgyewtRfCGzvN5zm9gzQfrxeX+RGI6+L2rL9QA0kKvYwbsdS/AShL+OkTPEt1C/wyo5DV3Mp1Nv9Ahj5z/v5Yhp5iCC1RsbAMz2tgGE4aCe80c4fqdLLsKFL5+WDZTWDT0pjX01e9GOGC5ramWI59Stzvgr6QkmWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En09T8lC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En09T8lC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28B01F000E9;
	Wed, 17 Jun 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709351;
	bh=COlNkjiF1c9Mcpxa0r9jZOeZ0ah2e2EwSsqBj9o/vso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=En09T8lCQcLzB37YDEjeJnfqnUG/WA9H7LHii371HqcmPXcvstfH4eWXsua9E6b82
	 VlSo0Gk10lOVbM37iCkzURG0KrwsggMwXoeQXYSEpvWGAgaaAqnxZjGOisB4dqab2P
	 x34paCJunwHFKml+53UFPxn4RhY/D+TL5QMavVGQksyRE0t3eCwK3QWIX02NcFIWDf
	 L0wusekhaAbXMvpFuGJwVB8MAb9JjbkaRF/kNjCjl//FTWwf+HMpw1dym+iDeIDME0
	 hNFjitqSkp4n3GtZ4uINd313mi0o2gY1+BgL5xbYPeLFYyrQGBf4tewYkTfMFpBhSC
	 d+lRjgfKFKUhA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 07/11] mm/damon/sysfs-schemes: kobject_del()
 scheme action destination dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-8-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:15:50 +0000
Message-Id: <20260617151550.E28B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing kobject_del() in damon_sysfs_schemes_add_dirs() error path=
 causes sysfs name collision
--

commit 34de5330acff239aa85773dbe06b9dce6ee27d61
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme action destination directories by adding
kobject_del() calls.

Cc: <stable@vger.kernel.org> # 6.17.x

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 737638be84f15..108f6de32f8c1 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2148,8 +2148,10 @@ static void damos_sysfs_dests_rm_dirs(
>  	struct damos_sysfs_dest **dests_arr =3D dests->dests_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < dests->nr; i++)
> +	for (i =3D 0; i < dests->nr; i++) {
> +		kobject_del(&dests_arr[i]->kobj);
>  		kobject_put(&dests_arr[i]->kobj);
> +	}
>  	dests->nr =3D 0;
>  	kfree(dests_arr);
>  	dests->dests_arr =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does the out: error path in
damon_sysfs_schemes_add_dirs() have a similar issue?

If kobject_init_and_add() succeeds for a new scheme but the subsequent
damon_sysfs_scheme_add_dirs() call fails, it jumps to the out: label:

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

Since the failed scheme hasn't been added to schemes_arr yet,
damon_sysfs_schemes_rm_dirs() only cleans up the previously added schemes.
Then kobject_put() is called on the current scheme without a prior
kobject_del().

With CONFIG_DEBUG_KOBJECT_RELEASE enabled, could this omission leave the
newly created sysfs directory intact and cause a name collision (-EEXIST)
if userspace retries creating the schemes shortly after?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D7
