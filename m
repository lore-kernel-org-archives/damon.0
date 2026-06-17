Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC045BD41
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708883; cv=none; b=u+mNvezte/690FN/pgRnEJNV3H8mhzgKJWqwYQhzW2/lpxAvVRepWmwXmJUGsvRztMH1cgqgC/sB90MaYHrKJ4tc/8wnNcpGBwryBiYsiUpJONtPEwF7DzdUe7itojdddsDJQ+gdmxsCxaxh2I4zwBF4zd7FvXOQSYK9yWTHsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708883; c=relaxed/simple;
	bh=DyBPZOXDmjv8t88wE3ROHuc1cJmaRad02R8bHXV9uoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rP4Fva/VYhrRT6gWgivbcieenrncpFVJR/aileJ0IERLFNfpxTTwQKrNnj60FVnFd0iNe3Gg8GX+3ryqmMCX+qD/g3A+lyvHaUQKxljq7CG9DP9HXe0rlMditJImCcv5/yvmZ8oBXy0fQMpWeLIbZY9vf11QwCDcsdC2mh+1MNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm+TCSsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm+TCSsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550EC1F000E9;
	Wed, 17 Jun 2026 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708882;
	bh=tdVLMhMkpsaOHm6z72rRMeoG27o8owUYhH6TstjKvdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wm+TCSsG6ybligBFC6+MLIizNz6qWxCimNT+NqPscrMErg1dNY7gPWPMKOYfiu1ZL
	 jCsKWmUeRFASluc5JDnHnrIWR0CK4dFKxmE1KBgkxN+aL1l7sBGObTwDC5TuZ/FkYK
	 n52Pjf30McRWqeN6v1VLesp/+OFmKMjirZ9VddfTV7RAjlKIJ8SFd5FQuv7ozd9uos
	 sOh8oIqgCaJ17xea8rfZkVIaRzuW1lCTpLc950cBs6s66dmgMSRhCI0PmGBIQIs4sb
	 h3kF9IE1HyXAoVleLalNpswySpHXo3GqmWyETI2yOVSEOdjpGiTyWAXBT7u6BcIhun
	 gnb2WVN+iCo4w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 08/11] mm/damon/sysfs: kobject_del() probe dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-9-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:08:01 +0000
Message-Id: <20260617150802.550EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing `kobject_del()` in the error path of `damon_sysfs_scheme=
s_add_dirs()` leads to deferred sysfs deletion and potential name conflicts.
--

commit 59e78cde42822b1eaae59f38d966ef1a15a1a9b6
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() probe dirs
   =20
This commit adds missing kobject_del() calls in the cleanup path for data
attribute probe directories. It prevents directory creation failures caused
by name conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 3c349f0fe80f0..5ca45654cdd39 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1139,6 +1139,7 @@ static void damon_sysfs_probes_rm_dirs(
> =20
>  	for (i =3D 0; i < probes->nr; i++) {
>  		damon_sysfs_probe_rm_dirs(probes_arr[i]);
> +		kobject_del(&probes_arr[i]->kobj);
>  		kobject_put(&probes_arr[i]->kobj);

[Severity: Medium]
This is a pre-existing issue, but does damon_sysfs_schemes_add_dirs()
in mm/damon/sysfs-schemes.c need a similar fix?

If kobject_init_and_add(&scheme->kobj) succeeds but the subsequent
damon_sysfs_scheme_add_dirs(scheme) fails, the error path drops the
reference without synchronously unregistering the kobject:

mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs() {
        ...
out:
        damon_sysfs_schemes_rm_dirs(schemes);
        kobject_put(&scheme->kobj);
        return err;
}

Without an explicit kobject_del() here, the cleanup is deferred. If
CONFIG_DEBUG_KOBJECT_RELEASE is enabled, could retrying the operation
fail with -EEXIST due to a name collision?

>  	}
>  	probes->nr =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D8
