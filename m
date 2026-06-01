Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC393890F9
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301002; cv=none; b=SB62wloJeEPy+qSH4bKbqs/CtELIKnl+oC8/DgrFOAN4gAMwTcTIEfyDZhlWmPUvp/F9eQB8grfeQcExnKESSv+FxfFooDKna/JW8Q1s0+D/0atvfrIVzvz1q9dFJEnHRJNheh5lp9VcdXrdYnkG/DeDFUnb2xw5/PvW19Sgr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301002; c=relaxed/simple;
	bh=B6Ej/UUusZOqts85aUEVqKFu0dm+wkceLxvPmYr5p8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkLvn6ef59W7/uodlk2UI3Qh5t7/Y7/J128ji0aPYjmLDv+QFR+WE9k89ZnbDfp0IejIeiJDLGSGcXn1ZK7KjnBFIH2a0Wg++FiU5OXQJwnXFUFm3A8h3uFyQVpxCUlKac4auYMDnQENWATfr9e1qjWkttMf7K6Rjq1A/ISm2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8TrQLTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8TrQLTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F121F00893;
	Mon,  1 Jun 2026 08:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780300997;
	bh=Jm5UghuyVUki8jBZwNm6K1yjj6HobSiWasdSGL6oonk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8TrQLTnCwEDlZNokYjbYQUTKwkJZMvKwNex76WY9puEYpTS/VCngTK03UNuIyVvz
	 gvZiRcUY252oUujxWCk6f5Qb89zIuW91dAryAoPAr3Nvvy5f+xfMWoPjCAlJV+Fn6K
	 tSw48pAc3sFN4QFKlzQ81IWSjK7E6N6xfb/CmfMo9WHMPsyqVysA696KjCzsqka9xr
	 T2P75njDkVUqlFRP+7jv27c1Fki3u4pO58M7a5B6gD+Qg5jHDJ/fJN/NlmzNtEUVwi
	 F2rnXx03oJdjpIlFqCCNz8sGDBZk1WfJWK4AcVtObRmm/GCdFhFP3RcW/08E48HwKS
	 GUCaoZRvDGrGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] selftests/damon/sysfs.py: validate memcg_path
 staging readback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cheng Nie" <niecheng1@uniontech.com>
Cc: damon@lists.linux.dev
In-Reply-To: <87B39E0F19A29319+20260601074533.205616-1-niecheng1@uniontech.com>
References: <87B39E0F19A29319+20260601074533.205616-1-niecheng1@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 08:03:17 +0000
Message-Id: <20260601080317.A0F121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test fails on teardown when `start()` fails, defeating the state=
d intent of decoupling the test from `CONFIG_MEMCG`.
--

commit 995afe8f607b12ca4f4469ac19ac53b1340cae11
Author: Cheng Nie <niecheng1@uniontech.com>

selftests/damon/sysfs.py: validate memcg_path staging readback

This commit adds a dedicated test to write memcg_path to sysfs and verify
the readback path. It intentionally ignores kdamonds.start() failures so
the test operates independently of CONFIG_MEMCG or cgroup layout.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selft=
ests/damon/sysfs.py
> index aa03a1187489f..7a17ab88361bc 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -250,6 +250,38 @@ def assert_ctxs_committed(kdamonds):
[ ... ]
> +def test_memcg_filter_memcg_path_staging():
[ ... ]
> +    kdamonds.start()
> +
> +    shown, rd_err =3D _damon_sysfs.read_file(
> +            os.path.join(memcg_filter.sysfs_dir(), 'memcg_path'))
> +    if rd_err is not None:
> +        print('memcg_path staging: sysfs read (%s)' % rd_err)
> +        kdamonds.stop()
> +        exit(1)
> +    if shown.rstrip('\n') !=3D memcg_filter.memcg_path:
> +        print('memcg_path staging: memcg_path readback '
> +              '(shown=3D%s, expected=3D%s)' %
> +              (shown.rstrip('\n'), memcg_filter.memcg_path))
> +        kdamonds.stop()
> +        exit(1)
> +
> +    err =3D kdamonds.stop()
> +    if err is not None:
> +        print('memcg_path staging: kdamond stop (%s)' % err)
> +        exit(1)

[Severity: Medium]
If start() fails as expected when CONFIG_MEMCG is disabled, won't this
subsequent call to kdamonds.stop() return an error?

Writing 'off' to the 'state' sysfs file of an unstarted kdamond causes
damon_sysfs_turn_damon_off() to unconditionally return -EINVAL. This error
propagates back to the Python script via write_file(), causing the script
to exit with status 1.

Does checking this error and exiting with a failure defeat the stated intent
of ignoring the start() failure in the first place?

> +    kdamonds =3D None
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601073635.2000=
15-1-niecheng1@uniontech.com?part=3D2
