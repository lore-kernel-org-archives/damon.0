Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261613BE15E
	for <damon@lists.linux.dev>; Fri, 29 May 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047811; cv=none; b=gc3rIZ0a5xjzYIqdC40bdIurYM7qqQlRCoa0moQELUgS41z/qg8IQHaNbMrRIzrFCXGLgCZa2yq86+K0FACp7e/LGxyZJ4QF8urweYYtsbTh1/2oIDjh7+n3E8RYxIwVElh7UleKNnLA7vXAB2RIqNqJJBH7/cpKNSiBl4jzwD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047811; c=relaxed/simple;
	bh=OfhXLou49FXQ2kvqxzTlCf3SfCGwoszvSItAGjH68Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H9Lk4vF83R+F98fiKg3X05pCAKUUgGKTApVFxZzOMWKBEaQpI4BxAx11fOubqHpzVQoc+oQ0/rkH1EbAZYGrXkM9WWtxbfBUYpRZJbr0VnSEW3Mfy+/4FYpOL1UcRpifAhJpqAfXRTfeBC+0v8y8vFxxlQszkptGVwOH9ztl6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcXOCPAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcXOCPAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5031F00893;
	Fri, 29 May 2026 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780047807;
	bh=wocgXFNCFl5PCne2Jwt/cF/fVTCoy1zFDiKqm7P2w3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FcXOCPAo/hGVSlAN1QSZUXCk5cctslagF+mWA0+U2siek1cir8VbQ7WnetjonHrFj
	 X5YSNBHfRrgWhEAtXWYi5zzaisR0yPYHPW8Btt5UCgaPxR891yRS8QDeHNenhKHWWj
	 TLVx3sESMVtU4sY7yy7WV+OD3VS/kzD151VJXL3vBqwpXCePwrPxfKuE2BL5+TExJa
	 8bd2gjeelREUHZPgTxVfnwMgM+p9Fh9e+WCFLmgxB2E9PQC/Cm7l1usFvHId/t0b5Z
	 ImS5QCPuBuSf3vGQUj3FaoDWGj3r/F8yVvt8bQjUwqPOfWBGFabDsyG0GJ6mw+XvT1
	 DcR2CBxqrCldQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/damon/sysfs.py: validate memcg_path
 staging readback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng Nie" <niecheng1@uniontech.com>
Cc: damon@lists.linux.dev
In-Reply-To: <FF9A1552C03B7C88+20260529092131.1703337-1-niecheng1@uniontech.com>
References: <FF9A1552C03B7C88+20260529092131.1703337-1-niecheng1@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 09:43:26 +0000
Message-Id: <20260529094327.6D5031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `test_memcg_filter_memcg_path_staging` test inad=
vertently depends on `CONFIG_MEMCG` and active cgroup configurations due to=
 a call to `commit()`, causing the test to fail inappropriately on environm=
ents lacking them.
--

commit 45ed1607d8ff8754a1a322fb6da3631cdc56f283
Author: Cheng Nie <niecheng1@uniontech.com>

selftests/damon/sysfs.py: validate memcg_path staging readback

This commit adds a dedicated test to selftests/damon/sysfs.py that writes
memcg_path to sysfs and verifies its readback. It aims to test the sysfs
behavior independently of the local userspace cgroup mount layout.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selft=
ests/damon/sysfs.py
> index aa03a1187489f..0f20bc9c46b78 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -250,6 +250,43 @@ def assert_ctxs_committed(kdamonds):
[ ... ]
> +    context =3D _damon_sysfs.DamonCtx(
> +            targets=3D[_damon_sysfs.DamonTarget(pid=3D-1)],
> +            schemes=3D[_damon_sysfs.Damos(ops_filters=3D[memcg_filter])])
> +    context.idx =3D 0
> +    context.kdamond =3D kdamonds.kdamonds[0]
> +    kdamonds.kdamonds[0].contexts =3D [context]
> +
> +    err =3D kdamonds.kdamonds[0].commit()

[Severity: Medium]
Could this cause a regression where the test fails on environments lacking
memcg support or active cgroups?

The stated goal of this test is to validate the sysfs staging readback
without depending on local userspace cgroup mount layouts. However, when
commit() is called, it instructs the kernel to apply the configuration.

This triggers damon_sysfs_memcg_path_to_id(), which traverses online memory
cgroups and will return -EINVAL if memcg support is disabled or the root
cgroup '/' cannot be resolved to an active memcg. This causes the commit()
operation to fail, which makes the entire selftest report a regression.

Would it be better to only stage the values (e.g., via context.stage())
and then verify the readback, without triggering the operational commit
step?

> +    if err is not None:
> +        fail('memcg_path staging: kdamond commit', {'error': err})

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4CDA28DC581FDCF8+20=
260529090845.1696845-1-niecheng1@uniontech.com?part=3D2
