Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6033D47D9
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087951; cv=none; b=lnnCnCk8AJe+sLTI/toqdL95yQbYQXNoTwl4FzivWVtlDd1wJZH+EfceXREf9jag5on+Z0+0+zEF+VjUHUKGtflhRsU3p4uZ1Og9TfVSfZTVjoaCEptHLqCdokhYXyxpNK3Qr3X2B73U1akpt33RHV6GgCZ33BOq0nt5rdhSGMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087951; c=relaxed/simple;
	bh=YpwMye2w2shrDuuwpVeNF8NHBKK99DnUXVBiOr10uZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IXKCR926ho55upyBY4qWXzIC+eYAgPYw6rAuy7RgpARck8vqaCiawTGorKvTSfj5mOOV9Yk24S5KYegOLHpquuN9Mt6b5xLyIxrfit9fSxQxUnVLH2ST2WIZPx+nJ8YVys3CEfFvfUuFkH8ndfMkvu8ToG1J/t1hsOS3cgNwb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkACDM7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkACDM7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAD01F00A3A;
	Sun, 26 Jul 2026 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087948;
	bh=UBF9kfFuvWPZKdEpFFNXmMxFhKBiquG/ONRgUEpx2i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkACDM7byynG+pECeHCngbHFmeJ6XVanjSsKYc4CYiOx5kKnzioLoL7JadTbJvy+F
	 TL0c6s3Hm1W3i60L7M8V72aMN02S62PHyo39aX2FfJdNb6RAeFwsR4nRh/Je8E/wkw
	 R7VCZ4cD/I5RXebzxSu1fqiaOOK8dAblcS5fgTOeCSHVpKv0PABmN4SUwCWqCajDqN
	 dJyGp7njc++xr36E7cHRKSfTscurNbPZBjEubsBUqYkAcFm/VxCybQilpnCEBbqHjD
	 isb0JZvrQf46mr5Um/NVTgcKL5WpDqEkJHZGAPKoJPvWrkRzyEErev2RSg3SXYvtiS
	 IXVDsMox+Fvqw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 16/17] Docs/admin-guide/mm/damon/usage: document
 probe preps sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-17-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:45:47 +0000
Message-Id: <20260726174547.DAAD01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Typo in documentation: 'names' used instead of 'named'.
- [Low] Subject-verb agreement error in updated documentation sentence.
--

--- Patch [16]: [RFC PATCH v2 16/17] Docs/admin-guide/mm/damon/usage: docum=
ent probe preps sysfs files ---
commit a784c34ebf2a666ab86343b9b4f5290f8391e1b3
Author: SJ Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: document probe preps sysfs files

Update DAMON usage document for the newly added DAMON probe preps sysfs fil=
es.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index da5f9afd08aef..e4fdec3fa5059 100644
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
t.  The
> +directories contain files for installing probing preparation actions and
> +filters for the probe, that is used to determine the data attribute for =
the
                              ^^^^^^^

[Severity: Low]
This isn't a bug, but since the sentence refers to plural subjects
("preparation actions and filters" or "files"), should "that is used" be=20
updated to "that are used"?

> +probe.
> +
> +In the beginning, ``preps`` directory has only one file, ``nr_preps``.
> +Writing a number (``N``) to the file creates the number of child directo=
ries
> +names ``0`` to ``N-1``.  Each directory represents each preparation acti=
on.
   ^^^^^

[Severity: Low]
This isn't a bug, but there appears to be a typo. Should "names" be "named"
to match the intended meaning ("child directories named 0 to N-1")?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D16
