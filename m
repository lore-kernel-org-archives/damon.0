Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD946AEE1
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708832; cv=none; b=ArnoulgxveZKs4cNc+69IKtXxmXDBJf3jb10TFFVPQSfygvX8t4ptFabFFMjeydBtfydeGVwtf2Q7ND8G/D8sKlFsBrNEKZZFplZquASu1AJDxWlT1BC5EGTbR1tm9UnKAps0Gb1wZqmyclkdQGAuM4zkQcHLcQ6fj9SQd9c4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708832; c=relaxed/simple;
	bh=GIXdyHBUyivE/hie2MKqnH9cmvfEfgGD7vFMMe/h0vQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L7DcBJLd8RpfhUAyMlKBOocEyU1IDtSmP5ZbiFOwCdLhZNxO78htZGeCLZUW9eJ9KImkMNcnhTsJ8Z4YQge5fhi36GjfH0wFxbqJY0p2PMRygzd04te2Naiypjj0+4UDHVAUamiC/jS+M/HhBU1HcVXSMMa1QpdrNEvolSTrzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVtMk31d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVtMk31d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EDB1F000E9;
	Wed, 17 Jun 2026 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781708831;
	bh=7kprv5bccY80jmMU91VgpcQBP3cqvZh0KlqkBXcQbmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AVtMk31dlUvcHpeb+jNnQ8ZS81sHEM2NBso7Gr9x17FcxCBd95re4X/CszSWrf01w
	 plCGubMs/1ETrEOBJoTkoogIXI/DCebJ2cAXCIRa4ZBDC4XvNZ7n/aSYnolDe59bS8
	 LUIPHK/qCHCNdT5jNJkOJgm68ygCA3nr0RTsnoO9qjlmKRwShduY9wVZjbBTMEQwWJ
	 1LXRGQ8RLrOAnDHnSx0YfAzywgL/YbPff0GEYCTRKLN5jcjTz6LxB+1DXJ49eT+3xh
	 jbjzFkHveBfw26ln5ihfw2x2ky4Cinih34b3dfb8675ukUIL/fv3Uil3IqjNxD7gbh
	 sWHLwmt+vIxng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 03/11] mm/damon/sysfs-schemes: kobject_del()
 scheme dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-4-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:07:10 +0000
Message-Id: <20260617150710.E9EDB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kobject_del()` on error path in `damon_sysfs_schemes_add_=
dirs()` leads to `-EEXIST` sysfs directory creation failures
--

commit 9080a7ab1bab654c1e6a9f081551a9609de62cbf
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for scheme directories by adding kobject_del() calls.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f3..37cf6edb54f17 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2686,6 +2686,7 @@ void damon_sysfs_schemes_rm_dirs(struct damon_sysfs=
_schemes *schemes)
> =20
>  	for (i =3D 0; i < schemes->nr; i++) {
>  		damon_sysfs_scheme_rm_dirs(schemes_arr[i]);
> +		kobject_del(&schemes_arr[i]->kobj);
>  		kobject_put(&schemes_arr[i]->kobj);
>  	}
>  	schemes->nr =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but it appears a similar issue
might still exist in damon_sysfs_schemes_add_dirs() on the error path.

While subsequent patches in this series successfully fixed this exact patte=
rn
for other arrays, it seems damon_sysfs_schemes_add_dirs() might have been
missed.

If kobject_init_and_add() succeeds for a new scheme, but child directory
creation via damon_sysfs_scheme_add_dirs() fails, the code branches to the
out label:

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

Can this lead to the scheme directory lingering in sysfs because kobject_de=
l()
is missing before kobject_put()?

If CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_cleanup() is delayed.
Since the parent persistent schemes directory survives, could a subsequent =
user
write to resize the array attempt to recreate a directory with the same
numerical ID and result in an -EEXIST conflict?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D3
