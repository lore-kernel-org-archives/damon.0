Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A878382F33
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300988; cv=none; b=EQsi9Zrnls9ivdMiXSEK9LwbXHpceCwD3zn68TKar7Zs2XzwNM8cMooB6yHAb5Nl9sde9RaasA9/giZW5Ma+5dO3UCitn+egqou95fVyZhRcBS/gRfgO+Wb6cczEZMIrpgeqxdfcgD6IdVuMQ/FOydcU2W96KXCvCHhvLYK3RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300988; c=relaxed/simple;
	bh=LY1mIGwxKWj7/PJkgoiwUbC7umGPA32dnAnTXMQzI64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d2D6s7vsEBs0gtwUQqhFvv/hUxtgslMWabuE710gk5aKh5TWgyceW+H/0itEJD86ZIxgHKPGrgssRWE5y9RKw/41tfAnw6LEoR2LRDVOBe/SIumqusEreJw2kwJcK6otSbRBKxaNkwn1amWItbAf4hEa0fO9Vuuspz12FOnaNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdDcIL+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdDcIL+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0532A1F00893;
	Mon,  1 Jun 2026 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780300987;
	bh=W+C87tKT5pskUyik2zzy06wCJmPxiMj3CFClwbimf24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WdDcIL+TEzNEKuWcUz0nKfawnYeGosCiBvI5v8Inp1QZ1fLXtPYkjmI9D+Vv7+d3p
	 QLA0bRtduE99l80Xd/9N4hHWqNklVyvdwZJxOLbCFPSaU201fSPUChlw3n9P1RWawM
	 MaGG5+9aNB89Il81k6mqGbMjqA7/uWzRR2iOLAIIV9jhi6U5+pBDWcx/EGOdhDzmrU
	 AtLIgJ4C0A+3bPhDRac3ltCQjBAwrIhb0+p3b7K8gxsCi4gQ7u/M9yggh1G3Wz5D9C
	 uO6T+kzvZFX9IBX7RyNmv+ZExo0BTE1hxrVOd4kGFgfbDgSihRvzxOIduw7uctSwMI
	 7MjYrpxlvZO/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path
 staging readback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng Nie" <niecheng1@uniontech.com>
Cc: damon@lists.linux.dev
In-Reply-To: <9FAF3DC4DEDDA72F+20260601074922.209222-1-niecheng1@uniontech.com>
References: <9FAF3DC4DEDDA72F+20260601074922.209222-1-niecheng1@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 08:03:06 +0000
Message-Id: <20260601080307.0532A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test fails if CONFIG_MEMCG is disabled because stopping an u=
nstarted kdamond returns an error, defeating the intent of ignoring start f=
ailures.
--

commit 82e2d2dc23cd1bb3cb389943f0bf754e63c68c96
Author: Cheng Nie <niecheng1@uniontech.com>

selftests/damon/sysfs.py: validate memcg_path staging readback

This commit adds a test to validate the staging readback of memcg_path in
DAMON sysfs without committing it. It configures the memcg filter, verifies
the readback, and attempts to ignore start() failures to avoid depending on
CONFIG_MEMCG or cgroup layout.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selft=
ests/damon/sysfs.py
> index aa03a1187489f..7a17ab88361bc 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -250,6 +250,38 @@ def assert_ctxs_committed(kdamonds):
[ ... ]
> +def test_memcg_filter_memcg_path_staging():
> +    global kdamonds
> +    memcg_filter =3D _damon_sysfs.DamosFilter(
> +            type_=3D'memcg', matching=3DTrue, allow=3DTrue, memcg_path=
=3D'/')
> +    kdamonds =3D _damon_sysfs.Kdamonds(
> +            [_damon_sysfs.Kdamond(
> +                contexts=3D[_damon_sysfs.DamonCtx(
> +                    targets=3D[_damon_sysfs.DamonTarget(pid=3D-1)],
> +                    schemes=3D[_damon_sysfs.Damos(
> +                        ops_filters=3D[memcg_filter])],
> +                    )])])
> +    kdamonds.start()
[ ... ]
> +    err =3D kdamonds.stop()
> +    if err is not None:
> +        print('memcg_path staging: kdamond stop (%s)' % err)
> +        exit(1)

[Severity: Medium]
The commit message mentions ignoring start() failures so the test does not
depend on CONFIG_MEMCG or cgroup layout. However, if start() fails,
kdamonds.stop() will return an error because the kernel's
damon_sysfs_turn_damon_off() returns -EINVAL when kdamond->damon_ctx is
NULL.

Does this cause the test to exit(1) and fail anyway on environments without
CONFIG_MEMCG when checking the return value of stop() here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/D4787203018006D6+20=
260601073635.200015-1-niecheng1@uniontech.com?part=3D2
