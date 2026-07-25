Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3693655DD
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014020; cv=none; b=O/0SVjm2iREJm8fmS9RUVJhrTGVVb6rFn692l1jFcW0Cj409nZPnhSbNXdVoo7lcPogFhqo+HPwBuogJpSpfR67mHQB28uW3fApI0yLZUhk2RH+WtJawqnJZHpa829FABhlAg0NEr3CsdGHbdK1Tuxt7JtDVVwfIy5GIXzKUh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014020; c=relaxed/simple;
	bh=+X2v4XoToTGHh9tVza2C7TGataY1kESdCKwYEnKN6Xg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jK/F2ynz/2BvwYU/XEC9s80v6eRTITAQycBGkhuU2vgjQEj/+FT8NFFikId8dNBGuXhP22NZByBmbGiIm39bAo60UBvOyarZ0t6p0WEASANRrVvn1otPTo3UAIg0e/9Sxzz92abkhhg/Fw/5L/KNHTyftOksPGRylfOi7W9xMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NesHGXH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NesHGXH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65B91F000E9;
	Sat, 25 Jul 2026 21:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785014019;
	bh=bfu1EKzqwFXCBzkL9+XuvKyc8PwuL2Z8GgKp/40/GWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NesHGXH4bvDFYh+b94sOkuLMouYS0CokqhmK0FLdcb9ZQ4lspWyesPTYKRP8LLx6p
	 pt4k7LubO8Z9P9kE1C54OPebxfAF8Mg3d24WN2XpLseLCr7+vfS6dxHDwIsaY8/RLH
	 DVaqpbTqQq0jFCL11sIAUgNiCAcSwTrldgQ2of2xF0oXzk+MxkEZS6lyFi677TWAg/
	 dtq2ELVsKPQL8s5L3Ntmf8Uc2M/46LogSoMz6AUvuryZI5dfnO7+Vcvo1sVMEZ4ecX
	 cWxOWx3iTpT+3cfWmIEe7WgOd+p1J761NHboKIQwa5Jzbagu8ncAuJjtRBVjGf6phO
	 bCWfb+dmyaG7Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/17] mm/damon/sysfs: implement preps directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-10-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:13:38 +0000
Message-Id: <20260725211338.D65B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `damon_sysfs_preps_ktype` static constant is defined but never =
referenced or attached to the sysfs hierarchy, resulting in an unused varia=
ble.
--

--- Patch [9]: [RFC PATCH 09/17] mm/damon/sysfs: implement preps directory =
---
commit b804c7747bd623e2ca58a340a5342097faad4841
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: implement preps directory

This commit implements a sysfs directory and a file for setting DAMON probe
preps. It implements only the preparatory data structures and functions wit=
hout
generating the directories at the moment.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 50ff1c172d746..6910a0f31697a 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> +static struct attribute *damon_sysfs_preps_attrs[] =3D {
> +	&damon_sysfs_preps_nr_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_preps);
> +
> +static const struct kobj_type damon_sysfs_preps_ktype =3D {
> +	.release =3D damon_sysfs_preps_release,
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.default_groups =3D damon_sysfs_preps_groups,
> +};

[Severity: Low]
This isn't a bug, but since damon_sysfs_preps_ktype is defined here without
being referenced or attached to the sysfs hierarchy, will this cause unused
variable compiler warnings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D9
