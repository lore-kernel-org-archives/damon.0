Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607793F23B6
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496311; cv=none; b=qKf9EKzHsesfL6s5hhrODI+gD7ONxaQ20hzRUtjA1nGAWqrk0DeyBpZxOu1xlsAhcxHvZ2AXfsEcjnfnBO6+OsiTaZ+o19288i5+h4YnZptBytCBmRd4bF/HDXG3lq91cjvkjni3ZyQZYkJhGkaBth/Y+x7Kvr09Sw0WIDZrC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496311; c=relaxed/simple;
	bh=m+WTlz6q2247+T5zKp6CLYHDGte4QoA5FRsi+ehNOsk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SRKDWbsD4is1+s2Ge1ypdCPZgha5zTW4/iopT9Xo9gVM4rbM/guSVVyd5+dQPqc7ethVmAyD6TpZmgOLl4nBctwd+2vNvXfvOQfVLJA+2vXSkelyaMtgHd2NEKH0RwyJMW6qN7fPjzHjIaTdwm8sCHfCO3ZR8tOzmRFlXVGdD+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAmU9E+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAmU9E+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48341F00A3A;
	Wed,  8 Jul 2026 07:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496296;
	bh=9U4ctrEZGflSVj3ALA5gYiaFZn1LJKXK05fJU1GnqnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hAmU9E+qm/MyImFHZvaA1ShbbqypYZYimOPfDI/P05VTc7OX0qp191wKGty4sGHJc
	 jnZUUfg/d/aJedMycwhZVsttr5ZL97qawWd/QF+JYUTrkcSxJL83KninJ4jrSCAYKp
	 +A4wGEhhQ/p7ESN2C8eoFchfcIT1XOJyNjHz/EjSpKW1Foe/FVJtd1qkORFxgBPXZf
	 Q9UBwXwX3DrQs3S5f1FWt/5K3lxI4FcVD6YAC6Hb+BmpTqtNzjcjQ/Cqteorc1jE7d
	 SPg4AhNBRYHYAPBzzQC0D+oB10u/NBokrRJGl4MVCgBlEPKEVH9grde1zG7KxWTwsY
	 JqghoViAfHHfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/7] docs/zh_CN: add DAMON_STAT usage translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260708073246.1652828-3-doehyunbaek@gmail.com>
References: <20260708073246.1652828-1-doehyunbaek@gmail.com>
 <20260708073246.1652828-3-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 07:38:16 +0000
Message-Id: <20260708073816.C48341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added translation file `stat.rst` is not included in the =
`toctree` of the subsystem's corresponding index file, which will result in=
 a Sphinx build warning.
--

--- Patch [2]: [PATCH v6 2/7] docs/zh_CN: add DAMON_STAT usage translation =
---
commit 13f1c819e6520a41dcd7c6bb3035887d18f621e8
Author: Doehyun Baek <doehyunbaek@gmail.com>

docs/zh_CN: add DAMON_STAT usage translation
   =20
This commit translates the admin-guide/mm/damon/stat.rst documentation into
Chinese. It also updates the translation to include recent changes from the
English documentation.

> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.r=
st b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> new file mode 100644
> index 0000000000000..129748a5ea1f0
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../../disclaimer-zh_CN.rst

[ ... ]

> +kdamond_pid
> +-----------
> +
> +DAMON =E7=BA=BF=E7=A8=8B=E7=9A=84 PID=E3=80=82
> +
> +=E5=A6=82=E6=9E=9C DAMON_STAT =E5=B7=B2=E5=90=AF=E7=94=A8=EF=BC=8C=E8=BF=
=99=E5=B0=86=E6=88=90=E4=B8=BA=E5=B7=A5=E4=BD=9C=E7=BA=BF=E7=A8=8B=E7=9A=84=
 PID=E3=80=82=E5=90=A6=E5=88=99=E4=B8=BA -1=E3=80=82

[Severity: Low]
Is a toctree entry for this new file missing from the index?

Because the newly added documentation file stat.rst is not linked from any
index, Sphinx will emit a "document isn't included in any toctree" warning
during documentation builds.

It appears stat.rst should be added to the toctree block in
Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst:

.. toctree::
   :maxdepth: 2

   start
   usage
   reclaim
   lru_sort

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708073246.1652=
828-1-doehyunbaek@gmail.com?part=3D2
