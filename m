Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093D33C19E
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787037078; cv=none; b=XRY1YqfjbI6mlU30/ccKFS7XhVUm1oXWRVabTSvRp4u6m6lBlQfg1/pcKYkjJQ37H1mgO85PuuPWRP1FGH6mYHjVe4jFs/65U/AHxvmDS0KrV6LdtFWco+itMhX7lJZgRXkGDA789LWXkV2DXHMnT35kpyyY53E+3FfAP9cpc/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787037078; c=relaxed/simple;
	bh=SfbqsWfhdHQILpWzjWdeMaX5TX0AcsU7+gr7zs8592w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfQI69UJpsowdaayeVIRNntDskLyRfy2OQxIAb7CDOpn2VcKWOQ+U4Bo/VXjjBB8Qc8wE1KCs1jGTrc1sMoLS1P7p099K7iC9yqul9YRhgnhmgNmPgQmcWfupesnaRmOMSUsPsK5PNHntFmSIioET8yTcNIMjKSWtj6kAda8qfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8D41F000E9;
	Tue, 18 Aug 2026 07:11:16 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] docs/zh_CN: add DAMON_STAT usage translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818070358.455768-3-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
 <20260818070358.455768-3-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:11:16 +0000
Message-Id: <20260818071116.EC8D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit adds a Chinese translation for `Documentation/admin-g=
uide/mm/damon/stat.rst` and references a kernel module `DAMON_STAT`, neithe=
r of which exist in the current kernel tree.
- [Low] The newly added documentation file `stat.rst` is not included in an=
y Sphinx `toctree`, which will cause a Sphinx build warning.
--

--- Patch [2]: [PATCH v8 2/7] docs/zh_CN: add DAMON_STAT usage translation =
---
commit 8a13916a309d2c1647aa6b3bd59550626a208631
Author: Doehyun Baek <doehyunbaek@gmail.com>

docs/zh_CN: add DAMON_STAT usage translation

This commit adds a Chinese translation for the DAMON_STAT documentation in
the mm admin-guide.

> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.r=
st b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> new file mode 100644
> index 0000000000000..129748a5ea1f0
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
> @@ -0,0 +1,94 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/admin-guide/mm/damon/stat.rst
> +
> +:=E7=BF=BB=E8=AF=91:
> +
> + Doehyun Baek <doehyunbaek@gmail.com>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E6=95=B0=E6=8D=AE=E8=AE=BF=E9=97=AE=E7=9B=91=E6=B5=8B=E7=BB=93=E6=9E=9C=
=E7=BB=9F=E8=AE=A1
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=95=B0=E6=8D=AE=E8=AE=BF=E9=97=AE=E7=9B=91=E6=B5=8B=E7=BB=93=E6=9E=9C=
=E7=BB=9F=E8=AE=A1=EF=BC=88DAMON_STAT=EF=BC=89=E6=98=AF=E4=B8=80=E4=B8=AA=
=E9=9D=99=E6=80=81=E5=86=85=E6=A0=B8=E6=A8=A1=E5=9D=97=EF=BC=8C=E6=97=A8=E5=
=9C=A8=E7=94=A8=E4=BA=8E=E7=AE=80=E5=8D=95=E7=9A=84
> +=E8=AE=BF=E9=97=AE=E6=A8=A1=E5=BC=8F=E7=9B=91=E6=B5=8B=E3=80=82=E5=AE=83=
=E4=BD=BF=E7=94=A8 DAMON =E7=9B=91=E6=B5=8B=E7=B3=BB=E7=BB=9F=E6=95=B4=E4=
=B8=AA=E7=89=A9=E7=90=86=E5=86=85=E5=AD=98=E4=B8=8A=E7=9A=84=E8=AE=BF=E9=97=
=AE=EF=BC=8C=E5=B9=B6=E6=8F=90=E4=BE=9B=E7=AE=80=E5=8C=96=E7=9A=84
> +=E8=AE=BF=E9=97=AE=E7=9B=91=E6=B5=8B=E7=BB=93=E6=9E=9C=E7=BB=9F=E8=AE=A1=
=EF=BC=8C=E5=8D=B3=E7=A9=BA=E9=97=B2=E6=97=B6=E9=97=B4=E7=99=BE=E5=88=86=E4=
=BD=8D=E6=95=B0=E5=92=8C=E4=BC=B0=E8=AE=A1=E7=9A=84=E5=86=85=E5=AD=98=E5=B8=
=A6=E5=AE=BD=E3=80=82

[Severity: Medium]
Is this patch based on an out-of-tree or unmerged series?

The original English document Documentation/admin-guide/mm/damon/stat.rst
and the CONFIG_DAMON_STAT kernel feature it describes do not appear to exist
in the current kernel tree.

[Severity: Low]
Is this new file missing from a toctree?

The newly added stat.rst file is not included in any Sphinx toctree (such as
Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst), which will
result in a Sphinx build warning when building the documentation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818070358.4557=
68-1-doehyunbaek@gmail.com?part=3D2
