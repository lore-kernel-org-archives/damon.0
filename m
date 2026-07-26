Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD33C13F1
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088066; cv=none; b=Qe9LYKh2N5S4YT2G2PtRXVCS+dKQPIhLSiSeHiub4b4ega7t9uj0/pUmGDTuUvOYQYh66v+lidQWrOmQoIS4S1DfZK99XoKPLDHcVEKwYZzLIZt+dlPGSXw2sCsVnHVVH/p+S2PF3DNoDcYkifOfGE9QYZL8wbobDHKNoj7yzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088066; c=relaxed/simple;
	bh=0DJyXYR28I4DPu0MsZlSt6Uu7LDmgogke1tsxDci5EE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lg9VRavNbFhZVLl0+JckVKY2SPe0vq0cvlWrLk72lCf8rqFv2y4k1o3vhvWXnGYGf5AAhGw684gbWwwBHKV0zyzG772X6U8Au86PRhjn4ceJ8JhPRmnpsboHm3a9USXCcs86Jvb+Rj40zGqUVkrxoZZ8NhzuTiSyxHd0tO5zBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceYhswLF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceYhswLF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A211F000E9;
	Sun, 26 Jul 2026 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785088064;
	bh=VYX5Xz8QWuePiel4oa4KPyzFDSb7Pk2T9iBfu8aDA/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceYhswLF9Qzvnombzey3eQkQon1JyN2dBY68jJQOElUTUknlWANpI5oYukomdNFcT
	 CB9kWzmUmYK0MYMR8ZVSJsoUWfe3m1D5iUM3KW/ZdKAHn5TrC9rRISzzW2MGlS8T8t
	 fthooSDIIWlVRdHJy1xcSYhP/kxO9xWxqcH0tIYOPjiXNnyjFoW/r1mBC5uB9ZeTxo
	 NA1MrLZ3+VY0ZHRperLr/UR1jgYILRDAlrs9o7ILF1KHmDPKRK5gNsPiNhpAyUSXq0
	 yNGVGIgfV/F7FwbkSYbrtuz9laD263Ec9IW62n1/E6KTiDRTw2y1xN0h3l2yoWME1G
	 Y1nrM1yI3PiRw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-12-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:47:43 +0000
Message-Id: <20260726174744.66A211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing `static` qualifier for `damon_sysfs_prep_ktype`.
- [Low] The `name` field in `struct damon_sysfs_prep_action_name` is declar=
ed as a non-const `char *` but initialized with read-only string literals.
--

--- Patch [11]: [RFC PATCH v2 11/17] mm/damon/sysfs: implement probe prep d=
irectory ---
commit ec46e0d8618f958d1edbf7e0edacd883d4e30bde
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: implement probe prep directory

This commit implements the DAMON sysfs directory and files for specifying e=
ach
probe prep action. It introduces the preparatory data structures and functi=
ons,
though the files are not yet created under sysfs.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 38affef08d0fb..a33423d997f59 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -750,6 +750,89 @@ static const struct kobj_type damon_sysfs_intervals_=
ktype =3D {

[ ... ]

> +struct damon_sysfs_prep_action_name {
> +	enum damon_prep_action action;
> +	char *name;

[Severity: Low]
This isn't a bug, but should this field be a const char * instead of
char *? The damon_sysfs_prep_action_names array initializes it with
read-only string literals like "set_pgidle".

> +};
> +
> +static const struct damon_sysfs_prep_action_name
> +damon_sysfs_prep_action_names[] =3D {
> +	{
> +		.action =3D DAMON_PREP_SET_PGIDLE,
> +		.name =3D "set_pgidle",
> +	},
> +};

[ ... ]

> +static struct attribute *damon_sysfs_prep_attrs[] =3D {
> +	&damon_sysfs_prep_prep_action_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_prep);
> +
> +const struct kobj_type damon_sysfs_prep_ktype =3D {

[Severity: Low]
This isn't a bug, but is the static qualifier missing here? Without it,
damon_sysfs_prep_ktype is exported globally which might trigger build
warnings like -Wmissing-prototypes when compiling with W=3D1.

> +	.release =3D damon_sysfs_prep_release,
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.default_groups =3D damon_sysfs_prep_groups,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D11
