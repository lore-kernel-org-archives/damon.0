Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A5357D14
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624051; cv=none; b=V+/krGCR/Gwqa5+/hhQPMDHejr+mYCf1Qf76RkisW1sop6YxHC/d2Us65enjZVk8MQs2bZ3CJEHWH7zSMHNAWAXtaRNQWt0FhuDYM0009SUpABbEKUpNG06Fktm83KFP8N32Te4cKRcki5fYu198/u3yx4XnsL2hYAYgGlEBwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624051; c=relaxed/simple;
	bh=kJ8HAEBNxzeW5fqpPdC9bn0n2ksSXSKkqENU5LQd8Fc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5r4o5R6rD01CjcY9oEn6gG/Wmt1VgwC80jaNa+yX2GQEp6tLd/zQTePcMTL61X/eug9Jpz4wTU+AT7OEMYKDwhqqRXXzwMoQ/nQVaM8e2toq4r6ty5HhHFBuDTb0Mr6/ROmF/NMxjn3c1f0ybEBGhgTunfZelo7slRl2EdtVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MprXokif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MprXokif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDD31F000E9;
	Tue, 16 Jun 2026 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624050;
	bh=jWWlqxFwFnB8FLStFa4TBniCbKKEozzs3QCye3cqzls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MprXokif7YaQloNlMckiuzaSLpRP151uok/NcPpgi6/q2MgtaHdu97cnOIkf/6dhO
	 cDroQHlAt1Szh0tQxQedq8lax6dDfxlMdOx01k0J4cuJiFSO7WQRPqZym7mQb1R1Yj
	 30OiAtUco89f5/Y0MrJBqcSdgUzy8u3uGZF5FCRK/7s5K90WrgYDZ/ECQQUt1mizqG
	 SD+BWs75Y3pKcjcL8IlACjwv3ab4I/TtWII+yMlu9JBSNIeak4u2I6j7EO2rnJe25v
	 wSmM6cNYMNUZs7sckfF+3/ruOkVFcw+H9W0z5TBG2WbO///L8d/VEUWWupGYwT6tCH
	 if8D8dWcMKF2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] mm/damon/sysfs-schemes: kobject_del() scheme
 action destination dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-8-sj@kernel.org>
References: <20260616150844.88305-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:34:09 +0000
Message-Id: <20260616153409.CCDD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kobject_del()` calls on the error paths of numerous `_add=
_dirs` initialization loops, leading to delayed-release name conflicts.
--

commit 635dc3a5238027dd7ff5a0100c509a12408d26da
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs

This commit adds kobject_del() calls to the scheme action destination
directories cleanup routine. This prevents directory creation failures
due to name conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

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

[Severity: High]
This is a pre-existing issue, but should the error paths in the various
_add_dirs() functions also be updated to call kobject_del() to prevent the
same name conflicts?

When kobject_init_and_add() succeeds, the kobject is added to sysfs. If a
subsequent initialization step fails, the error paths call kobject_put()
without calling kobject_del() first. Under CONFIG_DEBUG_KOBJECT_RELEASE,
kobject_put() schedules delayed cleanup, so the sysfs directory remains
visible until the delayed release completes. If the user immediately retrie=
s,
kobject_init_and_add() will fail with an -EEXIST name collision.

For example, in mm/damon/sysfs.c:damon_sysfs_targets_add_dirs():

        err =3D kobject_init_and_add(&target->kobj, ...);
        if (err)
                goto out;

        err =3D damon_sysfs_target_add_dirs(target);
        if (err)
                goto out;

        ...

out:
        damon_sysfs_targets_rm_dirs(targets);
        kobject_put(&target->kobj);
        return err;

Does this series also need to add kobject_del() calls to the error paths
of these functions:
- damon_sysfs_targets_add_dirs() in mm/damon/sysfs.c
- damon_sysfs_probes_add_dirs() in mm/damon/sysfs.c
- damon_sysfs_contexts_add_dirs() in mm/damon/sysfs.c
- damon_sysfs_kdamonds_add_dirs() in mm/damon/sysfs.c
- damon_sysfs_schemes_add_dirs() in mm/damon/sysfs-schemes.c
- damos_sysfs_populate_region_dir() in mm/damon/sysfs-schemes.c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D7
