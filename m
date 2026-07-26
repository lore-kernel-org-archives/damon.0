Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFE340409
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087970; cv=none; b=VnN9v+/HQ+L9IBO7Taqlqu9Toqx7zkYoWFLHgSeyko/MoYim6f65uajJCEs5/Dhm23cYZ1D9tMWY/RDvBM8qe1Ri6M6j2TbPswZcdqu2Wpumo4yBzc2/FEafDkVY9JUru7X7fP/DuCaqeahVKWFE1trDpDaRkS9KXbf74fArBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087970; c=relaxed/simple;
	bh=I7B/rhT5AVMwXZotbWPyk+uIcfajpBzcWZOeHw4b3ag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g74iH+YpIWQXG90qAH++x4kQbj52UqEwfC24rSk24F9HWDTU0SvLkeTJeoxbeAEoqJJPVRSqJrdi90Kky9/MZibmGLawZptK2rdwobTTJnySVHM+l6bWd7F1imaOrzzh9d6Mik/d7p8jC+PVosPSq33iJpRbkLTKJWYc7yhlZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON94AC07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON94AC07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C20E1F000E9;
	Sun, 26 Jul 2026 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087968;
	bh=cjydXN71F9sFQ1NVgDE06KkoKMw154o0s931mNTA5iA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ON94AC07TbL7Wycv5pOh8qBWIqHMs92elyk1phaQp4Wxrkt+2AUXeNEeDlJgAWvdB
	 GOqkDW8lQao9XXBtPn4JvOBhPa//JfnbsI9PSxOC85PqVXjvJ43TwNwRhIxhUQgs9B
	 Tyu+i5AUpi8HbJWN3N8gMka72JzF/5sqjwYUIQDyAT7pylzylnV5xHoPAPi7RMIo6N
	 dbTIGXfe+yiOooQQuSIebRkTVl3VMvHaqNvOHVl+FgGgI8FrtxaYBpqQZsGC6nNW96
	 ZeCzt72of+NzHxk+ZR+6z1Wyxan0orrVjtRwxoXJF+udwaZlPTcO8PcZ7OOwDA7JYb
	 VpAE012xbJdCw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-10-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:46:08 +0000
Message-Id: <20260726174608.9C20E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kobj_type structure `damon_sysfs_preps_ktype` is missing the `s=
tatic` keyword.
--

--- Patch [9]: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directo=
ry ---
commit 8155aac7530c47520c4a221fb588dbd6e53e3875
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: implement preps directory
   =20
This commit implements a sysfs directory and a file for setting DAMON probe
preps. It introduces the preparatory data structures and functions without
actually generating the directories yet.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 50ff1c172d746..bf65e87fcb521 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> @@ -750,6 +750,74 @@ static const struct kobj_type damon_sysfs_intervals_=
ktype =3D {
>  	.default_groups =3D damon_sysfs_intervals_groups,
>  };
> =20

[ ... ]

> +static struct attribute *damon_sysfs_preps_attrs[] =3D {
> +	&damon_sysfs_preps_nr_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_preps);
> +
> +const struct kobj_type damon_sysfs_preps_ktype =3D {
[Severity: Low]
Does this inadvertently expose damon_sysfs_preps_ktype to the global
namespace?

It looks like the static keyword is missing on the definition of
damon_sysfs_preps_ktype, which will cause it to be globally visible and may
trigger static analysis warnings.

> +	.release =3D damon_sysfs_preps_release,
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.default_groups =3D damon_sysfs_preps_groups,
> +};
> +
>  /*
>   * filter directory
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D9
