Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DF1B4138
	for <damon@lists.linux.dev>; Sun, 24 May 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779615427; cv=none; b=gcOJoiryvTY/+erDiDJa3jgJ99Uivxil66PuyVYvESwMMdatArMUu8De6lgYf3tnoHq8y14w7t0oGRs89v+/Db/H/Im2XGG2t2nyqXBXJEuiamHJFfwXa/SqUDwyjNgQVcIeBFSL8SINc89x0IzrHL29G5/fk+caT5RP6Ef0WAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779615427; c=relaxed/simple;
	bh=zR2gG2kAN+P75LCoMIoi7mUeub9m/DorXPhmEAEqL/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sE9FoPo9xmUyi01l5LZENNiTB/9fbVMnkYlNrudTGEPkGs+yPxGMWEmju2BGbm4tU31soqG0uuVhCRd6pCWuytCmgNvedOOGd2y4VlPy+ejMDvWEX1XkJsbOHOwWZbhhU4Veulgyl6AOz19TVx6c1QmZtd6ZxTAnx4M3ygSn8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPYVPBDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPYVPBDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCCE1F000E9;
	Sun, 24 May 2026 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779615426;
	bh=lEL0EoPWntYhW6ikF1eKDcixWHm7cLQfAGCS3pU4M1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPYVPBDQy6uxilByyrUo3MUssuuoHRBz5GOEHMmpki3HraOMRJYcOamp5REJqH2jG
	 YMONwUxjhfGYAbEhjQLfwuPTSBPyt/hGaSrTxtVLZelIadeP63sqRA+YeO69RA//Ju
	 J0NVwCE3ESiGFuSRRVt8oL8fnaYJrDYGpqZicSOF6GzV0Ebhf1h6R01OqhexF8M/uM
	 X/bmpjLi9baE01ZKs+K41KjkhJDlLjZGhEs+sqlbrl+TA7NmLPx4atK4fpunDNsRvj
	 AuZo02EN4SwCK9w81fCdlA7FFCZA7sryD8+oT+MpPB6jYR60uL2LcUMq/q3G9Koa59
	 kvtis0SjR/ZtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/damon: add regression test for damos_walk()
 vs kdamond exit race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sailesh Nandanavanam" <saileshnandanavanam@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260524091812.35283-1-saileshnandanavanam@gmail.com>
References: <20260524091812.35283-1-saileshnandanavanam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 09:37:05 +0000
Message-Id: <20260524093706.0FCCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The script hardcodes the sysfs state path and suppresses excepti=
ons with a bare `except` block, yielding a false pass if path resolution fa=
ils.
- [Medium] The script's custom timeout logic is incapable of detecting the =
kernel deadlock because it blocks synchronously on the system call.
- [Low] The new test script `sysfs_damos_walk_kdamond_exit_race.py` lacks e=
xecute permissions.
--

commit c1a389c100306b9715b021c992e2707ecc7ffc39
Author: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

selftests/damon: add regression test for damos_walk() vs kdamond exit race
   =20
This commit adds a regression test to verify that damos_walk() does not
deadlock when racing with the kdamond_fn() exit path. It starts kdamond
monitoring a short-lived process, waits for termination, and then rapidly
calls update_schemes_tried_regions to hit the race window.

> diff --git a/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_=
race.py b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.=
py
> new file mode 100644
> index 0000000000000..9b9d66a23f512
> --- /dev/null
> +++ b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py

[Severity: Low]
Should this file be created with executable permissions (100755)? Since the
script is added to TEST_PROGS in the Makefile, the kselftest framework expe=
cts
it to be directly executable. Without the execute bit, it can cause warnings
during test execution.

> @@ -0,0 +1,47 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0

[ ... ]

> +    proc.wait()
> +    completed =3D False
> +    timeout =3D time.time() + 5
> +    while time.time() < timeout:
> +        err =3D kdamonds.kdamonds[0].update_schemes_tried_regions()

[Severity: Medium]
If the kernel deadlock bug occurs, update_schemes_tried_regions() will
trigger an uninterruptible wait in the kernel. Doesn't this mean the Python
script will block indefinitely on the system call in the D state?

Since the script is single-threaded, the while loop condition would never be
re-evaluated, making the internal timeout and failure message unreachable.
Instead, the test would just hang until the global kselftest timeout kills =
it.

> +        if err is not None:
> +            completed =3D True
> +            break
> +        try:
> +            with open('/sys/kernel/mm/damon/admin/kdamonds/0/state') as =
f:
> +                state =3D f.read().strip()
> +            if state =3D=3D 'off':
> +                completed =3D True
> +                break
> +        except:
> +            completed =3D True
> +            break

[Severity: Medium]
Is it safe to hardcode the sysfs state path and use a bare except block her=
e?

If sysfs is mounted at a non-standard location or another file error occurs,
open() will raise an exception. The bare except block will catch this,
incorrectly set completed to True, and exit the loop immediately. This resu=
lts
in a false pass on the very first iteration, completely missing the race
window it is intended to test.=20

Could the script dynamically resolve the path using the kdamonds object
instead of suppressing all exceptions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524091812.3528=
3-1-saileshnandanavanam@gmail.com?part=3D1
