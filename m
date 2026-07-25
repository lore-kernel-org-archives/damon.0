Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E136A36B
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013842; cv=none; b=BWR/J/qynUQPQGfgm/BYGwD9yNi+roSSV5KVrRnZ8xGUOIY1f/Gc6vYV9osL1XVKl287kzdBheGB7909HJw5sThxz1yPIgxZqnkhi6bX1ab9EsxXl1EzSSxJ4fdiKDJh4iKz3omkjMXCHmCYtVKTuxrOB/FlFIBdD1EOUq3hzBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013842; c=relaxed/simple;
	bh=UZVjRJNHNVto6OFqGNro2HXKPWPC9XAlDIWyXj3zsPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tsU4WXK6vo1OvVzqLgdX75heAMRu2nPCSBRdF7ZJ2jnkcNQJzE5/PN0t/8/2ZedoigZDB23yc/CA+6V2NTVzYnYRyUEzPtQgM6vHTuZ52GbbaFGzcasRWmpZV3dgNA/ug1cImoN5MzL3P5r+4FmTCQbQHlyXOiOjjYJMY7OXLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjPZvBQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjPZvBQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294C11F000E9;
	Sat, 25 Jul 2026 21:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013841;
	bh=QqmdGN4pzS4i+CurlkbpQi0jjWSZrIp2mUScdIJF200=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cjPZvBQTnJBcz+IsNJ143XIouWtKlJNb8TEFMvyn3oex3IqAkd9h+ydRRs5WVBgCU
	 2kl2XcF7z9vZkunF5Sc33KuK9RbwCM4zINHqzqDXpARY0DnAZxJBQj8oRmJWzYd2zE
	 tKGqIhfaiWYjL1kzB7zdalaqYV4MOxw1oOX4ZRPdZByKcFMd+enUhiXhEZXAY3A6kx
	 pTAj0w9MWvl1d3cRvbHyeNHlDxFUUQRdvd+uiEsLmtBuXg/V8pu4sTC/nPTDFE1YDS
	 gvDGAllMb7lKeaK12pasfI4h8SRiCOoE3yWSgewAd52mH9J6KzWoFccxWJMvWgoKyU
	 b6oViJS1p4PiQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/17] mm/damon/sysfs: implement probe prep
 directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260725210225.129944-12-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
 <20260725210225.129944-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 21:10:40 +0000
Message-Id: <20260725211041.294C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The static constant `damon_sysfs_prep_ktype` is defined but not use=
d anywhere in the file.
--

--- Patch [11]: [RFC PATCH 11/17] mm/damon/sysfs: implement probe prep dire=
ctory ---
commit a150eac865fe6562090f70dc8b3909c07dadeb09
Author: SJ Park <sj@kernel.org>

    mm/damon/sysfs: implement probe prep directory
   =20
    Implement DAMON sysfs directory and files for specifying each probe prep
    action. Introduce only preparatory data structure and functions, without
    wiring them up yet.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 38affef08d0fb..8f9a5df598c51 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> +static struct attribute *damon_sysfs_prep_attrs[] =3D {
> +	&damon_sysfs_prep_prep_action_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_prep);
> +
> +static const struct kobj_type damon_sysfs_prep_ktype =3D {
> +	.release =3D damon_sysfs_prep_release,
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.default_groups =3D damon_sysfs_prep_groups,
> +};

[Severity: Low]
Since this patch introduces preparatory data structures that are not yet
wired up, the static constant damon_sysfs_prep_ktype is defined but not
used anywhere in mm/damon/sysfs.c.

Could this trigger a -Wunused-const-variable warning when building the
kernel with W=3D1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725210225.1299=
44-1-sj@kernel.org?part=3D11
