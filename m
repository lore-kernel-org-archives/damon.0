Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DAD4968FA
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338376; cv=none; b=AyAkkgvaa8tICPs25Ijl+YWXUUUxSquCJ9LvrfDRNNVRB+YqspNQvvHW7YQqZcakzK97G+BnxXtNJQ0g5Gy5BsGd+QI+MMDr8j+wDr6WeasTN2pKwn41C+yDhKsAj9JpFeVovJKsKVe/yPjiGc3uUDZOBB5mzFDkFagzFsUsano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338376; c=relaxed/simple;
	bh=JBDmOW5L5D7ChdEAzujvUpxsEeFHspY3EixA3wYS4TI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jcV6yGlW/gIVyKxUPL0FjhAVdEXYZWZi4gy5OvVOTpZ95UcK62+xXBi1gGuhIiFa29BrClJZ0hUpt2IpWirl1PMka3Qj9kxvO44OegIfM2iG2OtK0OieOp/7vYQzwbKOAGvUwZRgGuESv1SF8k4aJbaTt6X8E/GyW+D03+fVgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvPqsg99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvPqsg99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8481F000E9;
	Wed, 29 Jul 2026 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785338374;
	bh=pFBClgk+NMfDLUv2JKePyg2cdwqx0+fmyFuzpaEBE54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvPqsg99eiunfHgHoW9v9H67pXKsIEtTV52mqYeX5UjbFM0Vm/XpZ2ABWHsuaXE38
	 vAHap+Gs6jZ5A5PtJCk9KKqGdrKmRsIs0aKXu6tFSO7Sn/+uXIHbjOTuDj0ygL6a1V
	 h363gTpd8LyRbA2MWVCgHxR8kt30kzDAg93wQCxmF4plKt3pYPOYITcV3Ba3GuOz/b
	 sZLRU/jnBmcL1ZotA37w3HBOR4vA5hs0hGgSqhbt42J8zR4BFTb2/PsCQy3yf5zwK6
	 Nc32ip57hPem/C4BcGZPKoVKv3IkY6WYD376yDr4ZJG+7o9eKMGKJgBuquJo71AClD
	 WT8bck2K7pdTQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] selftests/damon/sysfs.py: test damon probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729144738.90895-7-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
 <20260729144738.90895-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:19:33 +0000
Message-Id: <20260729151934.3B8481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] DamonProbe.stage() completely ignores the error returned when wr=
iting to the 'weight' sysfs file, masking potential write failures.
--

--- Patch [6]: [RFC PATCH 6/6] selftests/damon/sysfs.py: test damon probes =
---
commit e47c18c7c1e4b19237b2738bc5c072c3c570dcc9
Author: SJ Park <sj@kernel.org>

selftests/damon/sysfs.py: test damon probes

This commit extends sysfs.py to test DAMON probes by committing them via
sysfs and checking the in-kernel status using drgn.

> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selft=
ests/damon/sysfs.py
> index 8c2dfc5ed8e04..852b6887a75ce 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -319,7 +319,21 @@ def main():
>                  intervals_goal=3D_damon_sysfs.IntervalsGoal(
>                      access_bp=3D400, aggrs=3D3, min_sample_us=3D5000,
>                      max_sample_us=3D10000000),
> -                update_us=3D2000000),
> +                update_us=3D2000000,
> +                probes=3D_damon_sysfs.DamonProbes(
> +                    probes=3D[_damon_sysfs.DamonProbe(
> +                        weight=3D42,

[Severity: Medium]
Will this properly catch setup failures when setting the probe weight?

When testing DamonProbes, DamonProbe.stage() writes the weight to sysfs
but overwrites the returned error status without checking it:

tools/testing/selftests/damon/_damon_sysfs.py:DamonProbe.stage()

    def stage(self):
        err =3D write_file(
                os.path.join(self.sysfs_dir(), 'weight'), '%d' % self.weigh=
t)
        return self.filters.stage()

If the sysfs write fails, such as the kernel rejecting the weight value
or the sysfs node being absent, the error is silently ignored. Could this
cause the test suite to proceed as if setup succeeded, leading to false
positive passes or confusing downstream errors?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144738.9089=
5-1-sj@kernel.org?part=3D6
