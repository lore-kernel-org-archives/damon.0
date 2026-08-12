Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8D315D58
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518425; cv=none; b=rYWwqz6Pgg2rTlBKVrOwJbT3K54lUkTyjkf7aZSoHURmXbdW+t4sokPDGpMdcbCLkMXAKrDczT0Jj6XStE6LftnmhiLHNpJ2nd1XT3Cz9AlI38pmOMtWB5f7JCUFp9+HbWMKJg7jdYUH7C1fB1kCOsemfs+HDSLO0aWWtTMSxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518425; c=relaxed/simple;
	bh=0vpZhCrKktUyrmrGaBHHxbEHFUOScK94VZHspYnP3kI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G0HYoVWblfwRlyzQ1A28o79sWhNqW4/LWNLvOgVkD22glfDOxgMgcqg+TIoYzUIQnbSbcwZPqDYdat58H30kF2ABuvUw6Mm5RbMnSnNx8+n9A9Ga3M8ZqPtKoLK5oTvrYymnAwqbc4l8k9JvDd9iqIlkIWGRce2augbvplzDXsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAcSf4k1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAcSf4k1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC71F000E9;
	Wed, 12 Aug 2026 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518424;
	bh=0vpZhCrKktUyrmrGaBHHxbEHFUOScK94VZHspYnP3kI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eAcSf4k1ftSm4830imlkYBE+GTm64WWhUrdmkHkMFXiuEEm7XDyKnkf5iDJg5J3Ht
	 WWA5Mpf9ZyMSlBuEyS2ILllSNSvy6v9wtJ1rWYrRmmkKuMlN1HI539pNv0bJLBkakN
	 qrPEMaF8TOnPeiCsPCDXbAQR0WHDQfjeBwMeAYjfR4HhiqbFCRv9z1U8ZguQGAT46v
	 PwGQpbgJ17ST+eiZxiPv0daapwFcZM3M2N/YlQUnoTJ0FIukSIRBoFcvTL9w31H0RM
	 mISZbxFqnDMqfLF2Ir1L9ugJCNuUS+UkN7eJ98M/ex3TspVNX9YDavqYs4nL8NTnOt
	 R5Fw0+BZFGzug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] docs/zh_CN: add DAMON_STAT usage translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812065914.3071433-3-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
 <20260812065914.3071433-3-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:07:03 +0000
Message-Id: <20260812070704.33AC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The newly added translation file `stat.rst` is not included in any =
`toctree`, which will result in a Sphinx build warning and make it undiscov=
erable.
- [Low] The patch adds a translation for `DAMON_STAT` (`stat.rst`) and its =
kernel feature configuration (`CONFIG_DAMON_STAT`), but neither the origina=
l English documentation (`Documentation/admin-guide/mm/damon/stat.rst`) nor=
 the kernel feature exist in the source tree.
--

--- Patch [2]: [PATCH v7 2/7] docs/zh_CN: add DAMON_STAT usage translation =
---
commit a87967677ba5385276c4f77cf4f3e6a1d32e5754
Author: Doehyun Baek <doehyunbaek@gmail.com>

docs/zh_CN: add DAMON_STAT usage translation

This commit adds a Chinese translation for the DAMON_STAT documentation
and updates it through commit c9380cdd949d.

> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.r=
st b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> new file mode 100644
> index 0000000000000..129748a5ea1f0
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0

[Severity: Low]
Since this newly added translation file does not appear to be included in
the toctree in Documentation/translations/zh_CN/admin-guide/mm/damon/index.=
rst,
will this cause a Sphinx build warning and make the page undiscoverable in
the generated HTML documentation?

> +.. include:: ../../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/admin-guide/mm/damon/stat.rst

[Severity: Low]
Is the original English documentation present in the source tree? It looks
like Documentation/admin-guide/mm/damon/stat.rst does not exist.

[ ... ]

> +=E6=8E=A5=E5=8F=A3=EF=BC=9A=E6=A8=A1=E5=9D=97=E5=8F=82=E6=95=B0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E8=A6=81=E4=BD=BF=E7=94=A8=E8=BF=99=E4=B8=AA=E5=8A=9F=E8=83=BD=EF=BC=8C=
=E9=A6=96=E5=85=88=E5=BA=94=E7=A1=AE=E4=BF=9D=E4=BD=A0=E7=9A=84=E7=B3=BB=E7=
=BB=9F=E8=BF=90=E8=A1=8C=E5=9C=A8=E6=9E=84=E5=BB=BA=E6=97=B6=E5=90=AF=E7=94=
=A8=E4=BA=86
> +``CONFIG_DAMON_STAT=3Dy`` =E7=9A=84=E5=86=85=E6=A0=B8=E4=B8=8A=E3=80=82=
=E9=80=9A=E8=BF=87=E5=B0=86

[Severity: Low]
Does the CONFIG_DAMON_STAT configuration option exist in the kernel? It
seems this translation documents a feature that is absent from the current
kernel source tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812065914.3071=
433-1-doehyunbaek@gmail.com?part=3D2
