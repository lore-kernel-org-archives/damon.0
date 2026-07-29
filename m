Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84330388E66
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337481; cv=none; b=SNSm3EtSUNAet3s3HnhjIrfaaLysh9L+OuOx5PNUn4h73CzSepYAh1/xYFAwoxZyyTb2vEHTlsk2Gxwh8Tsmnv7i6Oxodt+aZfs68lC/r/OgeI6jhW4QOCYx4fZzNTFNRIMde6i12Og6igxHHgwNMSiQVklR5VG4HE55+DOeaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337481; c=relaxed/simple;
	bh=lZjlrbOyHGyMAP2YL+z/Jio7cSL81oJuco7fuIZ/Stg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CipYDN+4FYPmwAM3+YaHPd6Xe/YPJaVNXOsfdndbLfbANBCJ0mB7D+Xx2zzG5wg7LczNopF/nEAdcDep+g9NbO9Q4nDAjCJ2Xb/fL1Zzgd9dCDL/A7j7kfTq91XQew87TCeSP9lt+DwCrdKctg8+4A27ZV2gjHSw+aQnZ6cg3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBdmrfUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBdmrfUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E021F000E9;
	Wed, 29 Jul 2026 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337480;
	bh=cvONDTwS89AbUrM5zw/BJO0qGsi/7eVQiQ5153q5COM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBdmrfUUX0ZI5kaAF8qz3+LrWBWV4jZsuPMysSns7L5sA9cHwMDpGStRi9IjE0EZu
	 K5tFO6VzOdPYrpsWuFnBLHAX6gTYCtDJzI9KDNVZwpZi7b3M5f0nSSDRgY1hanhW1k
	 +/X7GjCV51qBX6bVw77muGlNQkfafOGZ6w74nXq5RCMFaaRagG7aCw1wlKkASM+q21
	 70B0eO6Fqc6N2Cntc9vcrhavFq12o79oMZ5Rf0nfirCSO+xo7iIc6/X1uaeAJu4L7s
	 bSccuZUwARONJmlqu+A9ZaWewTO6lBTGYjALQ0afG5XjV87nNuXcmr4PScpj0UqIA7
	 4T6Z0pW/lyjow==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] selftests/damon/_damon_sysfs: implement
 DamonProbes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729144738.90895-4-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
 <20260729144738.90895-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:04:39 +0000
Message-Id: <20260729150439.93E021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The error result of `write_file()` for setting the probe weight =
is silently discarded.
--

--- Patch [3]: [RFC PATCH 3/6] selftests/damon/_damon_sysfs: implement Damo=
nProbes ---
commit 12ef2c079bfc3ec5e9f25fc085e18c6bca931488
Author: SJ Park <sj@kernel.org>

selftests/damon/_damon_sysfs: implement DamonProbes

Extend _damon_sysfs.py to support staging and committing DAMON probes.
It will be used for setting DAMON probes via sysfs changes for testing
purposes.

> diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testin=
g/selftests/damon/_damon_sysfs.py
> --- a/tools/testing/selftests/damon/_damon_sysfs.py
> +++ b/tools/testing/selftests/damon/_damon_sysfs.py

[ ... ]

> +class DamonProbe:
> +    weight =3D None
> +    filters =3D None
> +    probes =3D None
> +    idx =3D None
> +
> +    def __init__(self, weight=3D0, filters=3DNone):
> +        self.weight =3D weight
> +        if filters is None:
> +            filters =3D DamonFilters()
> +        self.filters =3D filters
> +        self.filters.probe =3D self
> +
> +    def sysfs_dir(self):
> +        return os.path.join(self.probes.sysfs_dir(), '%d' % self.idx)
> +
> +    def stage(self):
> +        err =3D write_file(
> +                os.path.join(self.sysfs_dir(), 'weight'), '%d' % self.we=
ight)
> +        return self.filters.stage()

[Severity: Medium]
Is err intentionally ignored here? If write_file() fails to write the weight
to sysfs, it returns an error string. Returning self.filters.stage() direct=
ly
without checking err will swallow the error and might cause tests to proceed
with incorrect assumptions about the probe configuration.

Should this check err before returning, similar to how it is handled in oth=
er
stage() methods?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144738.9089=
5-1-sj@kernel.org?part=3D3
