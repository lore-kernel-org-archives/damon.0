Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8B298CB2
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708776; cv=none; b=CSrLVtK+ePRFXXanFSno3iKOZ4SspEUbsnqOT3s6fJAgnXvkkTDEs3r/7aBtgQHQlDGTUENgCJifDWf4exa9DO74IBWrGR2ZS6idq1C7OgKDJp/Hx1SyE2uvh11xLbzrROmaM+VxZXkxhGxDxIoWZoreU0k6JyI/T8P5zqbQtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708776; c=relaxed/simple;
	bh=1QmDNZ+YCLX5v1bktJd0v2ODuDFuo9/lhBkBLb7MFGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iRcLKvrAzvzUsFCAJpJe+6PIm5aiJH5gpdrDUZNsCYMQqvuMz8Z7cBRTkkS9pIzGtGHyYniFHQU95LvdgDQf04rnpuTpN6AT4Wo7OBv760Q/rq7ioDUH7nUoY2m1D5r8RtW0ddoKJd8av+TTHtbkQ84aEVfyZ6sAKuyoxgekt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjO/NFrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjO/NFrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983EC1F00A3A;
	Wed, 17 Jun 2026 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708774;
	bh=nrvmuBgzMSOgkFhdc7IOTbljMrf6W09pgirwoG69AMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KjO/NFrZpz4aDqG64+C4lFe8xZVfA2LkiZeCptbPTnm5WE43nCxEaPQkTvMVut2zJ
	 DDe3n/XCPoS4yK9vIH0pry9eTwxKO07ok6tL79uANrViDHdOpe+pqYV6lw3Ql3pYhs
	 VEWKSYYeS4OvwstqsJFls/PO43ENhfn3ImKHH2iD0BkcVvcyrZMa/GV8RVt0nnrmmJ
	 YejH0d7wu462mr4PoovyAtk0oJzIB2Z4TttRoct6qmwP0oL2MYFzgfPC1D2gsKfTyF
	 FfJ9KoM0E/jSlMJsG3OQpNv+AL0WgEO33f6KNXqogcoNY17y3k/b2OtezmwofscanE
	 5mgFZckpP5E7Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 02/11] mm/damon/sysfs: kobject_del() region and
 target (error) dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-3-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:06:13 +0000
Message-Id: <20260617150614.983EC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch series missed adding `kobject_del()` in the error path=
 of `damon_sysfs_schemes_add_dirs()`. If `kobject_init_and_add()` succeeds =
but the subsequent `damon_sysfs_scheme_add_dirs()` fails, the code jumps to=
 the `out:` label and calls `kobject_put(&scheme->kobj)` without first call=
ing `kobject_del()`. Because the parent `schemes` directory persists, the f=
ailed scheme directory (e.g., '1') remains visible in sysfs until `CONFIG_D=
EBUG_KOBJECT_RELEASE` finally frees it. If userspace retries updating `nr_s=
chemes`, it will fail with `-EEXIST`.
--

commit 58b8f68e38892e33bea755abf310672a0f0bb285
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() region and target (error) dirs

This commit fixes directory name conflicts caused by missing kobject_del() =
calls.
It ensures kobject_del() is called in the region directories removal path a=
nd
the target directories error path. This resolves failures when creating
directories with CONFIG_DEBUG_KOBJECT_RELEASE enabled.

Cc: <stable@vger.kernel.org> # 5.18.x

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index dba1c67fc188f..3c349f0fe80f0 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -372,13 +374,15 @@ static int damon_sysfs_targets_add_dirs(struct damo=
n_sysfs_targets *targets,
> =20
>  		err =3D damon_sysfs_target_add_dirs(target);
>  		if (err)
> -			goto out;
> +			goto del_out;
> =20
>  		targets_arr[i] =3D target;
>  		targets->nr++;
>  	}
>  	return 0;
> =20
> +del_out:
> +	kobject_del(&target->kobj);
>  out:
>  	damon_sysfs_targets_rm_dirs(targets);
>  	kobject_put(&target->kobj);

[Severity: Medium]
This is a pre-existing issue, but I noticed a similar pattern in
mm/damon/sysfs-schemes.c that seems to be missing a kobject_del() call.

In mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs():

	err =3D kobject_init_and_add(&scheme->kobj,
			&damon_sysfs_scheme_ktype, &schemes->kobj,
			"%d", i);
	if (err)
		goto out;
	err =3D damon_sysfs_scheme_add_dirs(scheme);
	if (err)
		goto out;

	schemes_arr[i] =3D scheme;
	schemes->nr++;
}
return 0;

out:
	damon_sysfs_schemes_rm_dirs(schemes);
	kobject_put(&scheme->kobj);
	return err;

If damon_sysfs_scheme_add_dirs() fails after a successful
kobject_init_and_add(), we jump to out and call kobject_put() without first
calling kobject_del().

With CONFIG_DEBUG_KOBJECT_RELEASE enabled, could the persisting parent sche=
mes
directory cause an -EEXIST conflict if userspace retries updating nr_scheme=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D2
