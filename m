Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED63A8746
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623754; cv=none; b=AznVvzLLZ40PbBYrdkAU+8vbzbGo+WkXly4kcRCQkDehm2qu6ZFi15Yjid/SSfPnlaxx6gtLSc2XBtHS6C8HR+++W+5O2wP75EUCoCfLbob1MLZhHjV680nZfk1bgBp3a0VpK/VpnOYENej8ww2LlmfW+cbzo6g/rmL2WiVo/XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623754; c=relaxed/simple;
	bh=pFirBtR0n7fPfWcEnSvw3IWvIERUUmFFpzXaHD2x0N4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlZIA2U6SiEZtQ8v0c+NojyrEOGIgsHbt+Dyezv+0oiiWvCxEo4jIK2I2WLqNB0j0hM5pjJl53hi8g0IkNW+5rTjIze3T3buOlxIR0h6IW9JkUdlWjCjm3ZbwuldpWeVIWNfSmBbbl9cW5mmmQwlp9NjkLOs6nPfEd2XKOenpog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMd+Xb4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMd+Xb4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF261F00A3A;
	Tue, 16 Jun 2026 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623751;
	bh=h8pNi3MBZBDpiZKQTjR3EMsW2BgHEGChaxk/ToFIPoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMd+Xb4AP730tKgfZZXx8wQemj1/YBAwx2Rxia4dE355r0gHrdM7ssbX6wD6mxiz9
	 frPElnq0MgOnsZ3Zm5V3YvbHgc1T0wQGaJapbVTi8AGH35uvDr4/acNmJL5uI1AY5H
	 oKnaJou6JsbZSMo0clwzoG5MIW08vjDWehy/SiQDVAB3pULp0i3yFThdnUW+TSQT49
	 iBPYk4M0JpsgdTO/gVN6b5K/ZZXwWSo8gfhMyKfyO2jYoRY5A9Z7bLoNwxqIyoUOwU
	 ACkxuSe65nOF/Uuovr4zkxXaIy8QwUyet+rmmYIwG8ooO35qgkV00NXpzTpv7DUsZ/
	 QO4GPTIPd5iMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/9] mm/damon/sysfs: kobject_del() region dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-3-sj@kernel.org>
References: <20260616150844.88305-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:29:11 +0000
Message-Id: <20260616152911.9CF261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing explicit kobject_del() on error paths in _add_dirs loops (=
Incomplete Fix).
- [High] Memory leak of stats and scheme structures on the error path of da=
mon_sysfs_scheme_add_dirs().
--

commit ba4dfdbea398b3306e96fd3662e872e97251fbe9
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() region dirs

This commit fixes directory creation failures caused by name conflicts
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It achieves this by adding
missing kobject_del() calls to the region directories removal function.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index d93f7919c3ca1..f72e1e37df9d8 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -107,8 +107,10 @@ static void damon_sysfs_regions_rm_dirs(struct damon=
_sysfs_regions *regions)
>  	struct damon_sysfs_region **regions_arr =3D regions->regions_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < regions->nr; i++)
> +	for (i =3D 0; i < regions->nr; i++) {
> +		kobject_del(&regions_arr[i]->kobj);
>  		kobject_put(&regions_arr[i]->kobj);
> +	}
>  	regions->nr =3D 0;
>  	kfree(regions_arr);
>  	regions->regions_arr =3D NULL;

[Severity: High]
This is a pre-existing issue, but the fix for this specific bug class seems
incomplete as it misses initialization error paths. If a nested initializat=
ion
fails after kobject_init_and_add() succeeds, the code jumps to an error path
and calls kobject_put() without first calling kobject_del().

For example, in mm/damon/sysfs.c:damon_sysfs_targets_add_dirs():

out:
        damon_sysfs_targets_rm_dirs(targets);
        kobject_put(&target->kobj);
        return err;

This same pattern occurs in damon_sysfs_contexts_add_dirs(),
damon_sysfs_kdamonds_add_dirs(), damon_sysfs_probes_add_dirs(), and
damon_sysfs_schemes_add_dirs().

Does this cause the directory removal to be delayed asynchronously, meaning
if userspace immediately retries the operation, it fails with an -EEXIST
conflict?

[Severity: High]
This is also a pre-existing issue, but there appears to be a memory leak
in the error path of damon_sysfs_scheme_add_dirs() in
mm/damon/sysfs-schemes.c:

        err =3D damon_sysfs_scheme_set_tried_regions(scheme);
        if (err)
                goto put_tried_regions_out;
        return 0;

put_tried_regions_out:
        kobject_put(&scheme->tried_regions->kobj);
        scheme->tried_regions =3D NULL;
put_filters_watermarks_quotas_access_pattern_out:
        kobject_put(&scheme->ops_filters->kobj);

If damon_sysfs_scheme_set_tried_regions() fails, the code jumps to
put_tried_regions_out and bypasses releasing the successfully created
scheme->stats kobject. Since damon_sysfs_scheme_release() only frees the
scheme struct and does not explicitly clean up lingering children, both the
stats memory and the parent scheme memory are kept referenced.

Could this permanently leak both the stats and its parent scheme when
triggered from userspace via sysfs configuration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D2
