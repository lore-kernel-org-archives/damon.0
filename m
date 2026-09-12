Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0537B030
	for <damon@lists.linux.dev>; Sat, 12 Sep 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244120; cv=none; b=juGHoy657Gy/4AQeWGYZjY2jdySQP2GBgJ3utEJKyla9eGJ2mb73lESCDXUFc8dejnZ/q8Wpl32Un51FMrPLRWE9pPPSjoDM2xmR/ejpH/1xK8SkzD+EH3LuhSJpb2QEO15DIt15/ll/BdTf4Zjg6rfJJU4WQ6GLA0jLZJED/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244120; c=relaxed/simple;
	bh=sKIDK7S4xyjiuXDmp52/QVbc/a+pg1nsMVDECbQ+t1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kmYzWY+WIN0ahqOq5KhhVhglzuZdC0dDuaCDYSk22pBuzRl04a1Egb8ob40OUORj7Ub3ecsSpP/AbXbQLBmSN34Jk2IXW1RdoTgNqqHs/k1fMX0NHO0CtqkqHpNf+nOhbZoaU3chF+3+KpMQlP7rf8L7dKI0biAV3kPXeNHm8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyuxdb0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyuxdb0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700171F000FF;
	Sat, 12 Sep 2026 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244118;
	bh=g9GTRfUJ5UwKgZWxgfu8ZiN+4iI5QqypNgeSYpdUHnw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xyuxdb0H6RVAaRZVGEL7BCyM9LgcEG19WzWpFaCYqF+vgmDIjgtAUEYAZL498kSe6
	 j5skR3IUw5Qcy04JkJxCKzgsZ29dPqyh9ORSvAHaz4KSAh5sxrKjeHLxSAiYrKjwRc
	 0s2JEy663Y9ZhGrqXOikVPagp7otiLX2hNbCzKLQeuFLQP3j/qJ3fs2PooisA4P21T
	 fDis1RLHQCPk25hUuPcmxIePvjm5DocJaFbgI5MyDLT9viRfKUMiZRE2/JjwivV89j
	 MycK0sWCu9056iOQIg7HAcToDWjJQxUrTUSn7ctshMojzNeFEXkdr0N5p6TtCZ5Lzy
	 X+6wbHNlLOPKQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] selftests/damon/sysfs_memcg_path_leak: fail
 only for real DAMON leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260912200814.145612-8-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
 <20260912200814.145612-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:15:18 +0000
Message-Id: <20260912201518.700171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Use of the non-standard `--quiet` flag in `grep` can cause the t=
est to silently mask real memory leaks on systems with strict POSIX grep im=
plementations.
- [Low] Typo in the warning message: 'apparenty' instead of 'apparently'.
--

commit afc83fe4758b4c2e76cc3da97cb99e2a990b6b83
Author: SJ Park <sj@kernel.org>

selftests/damon/sysfs_memcg_path_leak: fail only for real DAMON leak

The selftest can fail for any leak if it happens while the test is running.
Remove the false positive test failures by further checking if the expected
leaking function is called out on the report.

> diff --git a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh b/too=
ls/testing/selftests/damon/sysfs_memcg_path_leak.sh
> index 33a7ff43ed6cc..6c2d8bb3fe570 100755
> --- a/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> +++ b/tools/testing/selftests/damon/sysfs_memcg_path_leak.sh
> @@ -41,5 +41,12 @@ if [ "$kmemleak_report" =3D "" ]
>  then
>  	exit 0
>  fi
> +if ! echo "$kmemleak_report" | grep "memcg_path_store" --quiet

[Severity: Medium]
Could the --quiet flag cause the test to accidentally mask real memory leak=
s?

If the test runs in an environment with a strict POSIX grep implementation
that does not support the GNU extension --quiet, grep will fail with an
unrecognized option error.

Because of the negated condition, a non-zero exit code from grep causes the
script to evaluate to true, print a warning, and exit 0. Should the standard
POSIX -q flag be used instead to ensure compatibility?

> +then
> +	echo "[WARN] memleak found; apparenty not from DAMON, though"

[Severity: Low]
This isn't a bug, but there is a typo in the warning message (apparenty
instead of apparently).

> +	echo "$kmemleak_report"
> +	exit 0
> +fi
> +
>  echo "$kmemleak_report"
>  exit 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912200814.1456=
12-1-sj@kernel.org?part=3D7
