Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE6302767
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013695; cv=none; b=BvtTZpEyDpZKEesv+UJWHqTI1uDwoqwl9OIaow6VTRMI3dBBdyPUXgJ+VlKRrKwuSFeZC+2vjxKHurCaHKLOZHvx6lqhX3lLh/3ERjRpqQNejRPuuC4pzIXGVgy9cI/IIX289ZsL0gKpvt6g4LEbKyP0dbS7kymDa3DoRw4K7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013695; c=relaxed/simple;
	bh=zEH/ToopfLSL9CC99Cp/wLCsMr22VHnI87FYXSJhftU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CTiDrJ82H6w+GVDKPwmDtzp6Bvs5UNMxmRAupTHV2Su4IS7QW8nr5XZRC+7TFmsda73qDIvkoJPPmOesDv8ShTbQzhRVNL5Pj7jgiRsCpo+t2iBotU9+9IlbLjXxdi300BvFMPsUmnzo1l1fKsTMMBhQ5UI5DOtTahoYeKxku7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZ9Vx24h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZ9Vx24h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD701F000E9;
	Sat, 25 Jul 2026 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013694;
	bh=4nXvntamcNVcneFBZdJXJfvvnDZIhuxIznrXzrNjaJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZ9Vx24h+jh+Jn3Yhsdz3ZhelIjl/jyKx4nGNihjp3/4lvYdDqD6yXLKVFPh/yaoi
	 IM/v5BGWPvbMRxNtOi5Vn2IIOv9CFXWk5rWwgxYlQM93wuXnDGQY7Eo/LuNJyjNKL9
	 Iy4KBvH11X+4QXGXDzKXsMrLM0eRn6a0SmODRateK635fBeAlvAZ/zLbDCqiiCyjGq
	 xr6TMa4/CyNKU+6uRyZ/p8UjOkjMIoMvhaG1DdldBAfI6naiKsQDCKGFtVqHfz/5j5
	 k0gwi6HqX+R6a/YzD/iralQTtWlpeR7U/PNiSmHYWH/0t3wvplxYmANM9DWZ9ucPnE
	 4YqCSnVoWCrYQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 16/17] Docs/admin-guide/mm/damon/usage: document
 probe preps sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-17-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:08:13 +0000
Message-Id: <20260725210813.DFD701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multiple typographical and grammatical errors in the newly added do=
cumentation.
--

--- Patch [16]: [RFC PATCH 16/17] Docs/admin-guide/mm/damon/usage: document=
 probe preps sysfs files ---
commit b237c3e5209fc4981028c7362f98db1f8e443546
Author: SJ Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: document probe preps sysfs files

Update DAMON usage document for the newly added DAMON probe preps sysfs
files.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index da5f9afd08aef..1f5a39e1fc38d 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst

[ ... ]

> @@ -283,9 +286,18 @@ In the beginning, this directory has only one file, =
``nr_probes``.  Writing a
>  number (``N``) to the file creates the number of child directories named=
 ``0``
>  to ``N-1``.  Each directory represents each monitoring probe.
> =20
> -In each probe directory, one directory, ``filters`` exists.  The directo=
ry
> -contains files for installing filters for the probe, that is used to det=
ermine
> -the data attribute for the probe.
> +In each probe directory, two directories, ``preps`` and ``filters`` exis=
ts.
> +The directories contains files for installing probing preparation action=
s and

[Severity: Low]
This isn't a bug, but there are grammatical errors here with "exists" and
"contains".

> +filters for the probe, that is used to determine the data attribute for =
the
> +probe.
> +
> +In the beginning, ``preps`` directory has only one file, ``nr_preps``.
> +Writiing a number (``N``) to the file creates the number of child direct=
ories
> +names ``0`` to ``N-1``.  Each directory represents each preparation acti=
on.

[Severity: Low]
This isn't a bug, but there are typos here with "Writiing" and "names".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D16
