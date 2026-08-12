Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979171C8FB1
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518446; cv=none; b=gG8SIEkSSq14n9P2QoBSu1YBmZ2NB2nPZVuMdjnrpyKH3JQ7YZz9gGjxwL3p0ELQwb0/YTP/khJYMuTdqe+L3WQWrdSf6E/xyFUVXdgdrcTjxd88vjGX/edDcvg/JP2B0hUkMzJmSbvju+FzfrGqjrqoRyF7p2e2HKdejYMneAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518446; c=relaxed/simple;
	bh=2+kk6WS6jgQz9R84ax6rkUNie/kDOoWUobEuRLbuH00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T9IgeQwuUZfZSSMm+ACq8V7erszQklewCBxGEDVmw9nq5Gn2oeVakzvXpzPpPh+/T7YSRA26WlMsvgew5dl09M8Q0l+MNfbb/Y2n4f0d1uVT685L0xg+tL/jqgI6zKZkK5qHO2q6wRm47hDPccETbCPT35RewA0J1P9V9oNGrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh/0hXLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh/0hXLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C20B1F000E9;
	Wed, 12 Aug 2026 07:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518445;
	bh=9YWW3Ne+CMJY5fWWB+zjFf2MVf+Kq+jmagut8jg5wpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gh/0hXLdFuDnArvns0S764jjKv7j7sRZe2Y/rCF95zMWxlpP/8YFzsnI5pcxoay7i
	 7+8MrZLourXScAooQZzhMb/vXnfnrnyTBOU9covgXC8K7nPRnqLL09A61enKRJk7Ab
	 xCDVVTJACHlH8rJ/EkoF+W2iGxQTOax65YzLR9d8kUJBWW6XkM1p1ezqGPs5/SrhBh
	 QQsJsdhOe+r+OlxgNjlhWTnm4hloaP+Vv4f8maWugpNE4rz0F0Kv4JMgGZm5ByTZ07
	 NHgDpl2gB7j45nP/UAvVpXBHsLojxDF6uIh98i0PhsYbpY/VowDQb8QU5neOzqM/o/
	 bHBUi7NNE6rpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] docs/zh_CN: update DAMON start translation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812065914.3071433-5-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
 <20260812065914.3071433-5-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:07:24 +0000
Message-Id: <20260812070725.1C20B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The translation removes a valid cross-reference link to the sysfs d=
ocumentation that is still present in the English original.
- [Low] The translation introduces a command-line flag (`--target_pid`) not=
 present in the corresponding English documentation.
--

--- Patch [4]: [PATCH v7 4/7] docs/zh_CN: update DAMON start translation ---
commit bbfe3c26ebbdef4a642261a8f53c94379a221924
Author: Doehyun Baek <doehyunbaek@gmail.com>

docs/zh_CN: update DAMON start translation

This commit updates the Chinese translation of the DAMON start documentation
to align with recent upstream changes through commit c9380cdd949d.

> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/start.=
rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
> index cff7b6f98c594..1a7f3382dd158 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/start.rst
> @@ -35,18 +35,63 @@ https://github.com/damonitor/damo=E6=89=BE=E5=88=B0=
=E3=80=82=E4=B8=8B=E9=9D=A2=E7=9A=84=E4=BE=8B=E5=AD=90=E5=81=87=E8=AE=BEDAM=
O=E5=9C=A8=E4=BD=A0=E7=9A=84$PAT
>  =E8=BF=99=E5=B9=B6=E4=B8=8D=E6=98=AF=E5=BC=BA=E5=88=B6=E6=80=A7=E7=9A=84=
=E3=80=82
> =20
>  =E5=9B=A0=E4=B8=BADAMO=E4=BD=BF=E7=94=A8=E4=BA=86DAMON=E7=9A=84sysfs=E6=
=8E=A5=E5=8F=A3=EF=BC=88=E8=AF=A6=E6=83=85=E8=AF=B7=E5=8F=82=E8=80=83:doc:`=
usage`=EF=BC=89=EF=BC=8C=E4=BD=A0=E5=BA=94=E8=AF=A5=E7=A1=AE=E4=BF=9D
> -:doc:`sysfs </filesystems/sysfs>` =E8=A2=AB=E6=8C=82=E8=BD=BD=E3=80=82
> +``sysfs`` =E8=A2=AB=E6=8C=82=E8=BD=BD=E3=80=82

[Severity: Low]
Does this change break the documentation cross-reference? The English
original still maintains the functional cross-reference to the sysfs
documentation, so replacing it with a plain code literal here creates an
inconsistency and removes the link in the rendered Chinese document.

[ ... ]

> @@ -117,8 +162,8 @@ https://github.com/damonitor/damo=E6=89=BE=E5=88=B0=
=E3=80=82=E4=B8=8B=E9=9D=A2=E7=9A=84=E4=BE=8B=E5=AD=90=E5=81=87=E8=AE=BEDAM=
O=E5=9C=A8=E4=BD=A0=E7=9A=84$PAT
>  =E6=95=B0=E6=8D=AE=E8=AE=BF=E9=97=AE=E6=A8=A1=E5=BC=8F=E6=84=9F=E7=9F=A5=
=E7=9A=84=E5=86=85=E5=AD=98=E7=AE=A1=E7=90=86
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> =20
> -=E4=BB=A5=E4=B8=8B=E4=B8=89=E4=B8=AA=E5=91=BD=E4=BB=A4=E4=BD=BF=E6=AF=8F=
=E4=B8=80=E4=B8=AA=E5=A4=A7=E5=B0=8F>=3D4K=E7=9A=84=E5=86=85=E5=AD=98=E5=8C=
=BA=E5=9F=9F=E5=9C=A8=E4=BD=A0=E7=9A=84=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=
=E4=B8=AD=E6=B2=A1=E6=9C=89=E8=A2=AB=E8=AE=BF=E9=97=AE>=3D60=E7=A7=92=EF=BC=
=8C=E5=B0=B1=E4=BC=9A=E8=A2=AB=E6=8D=A2=E6=8E=89=E3=80=82 ::
> +=E4=BB=A5=E4=B8=8B=E5=91=BD=E4=BB=A4=E4=BD=BF=E6=AF=8F=E4=B8=80=E4=B8=AA=
=E5=A4=A7=E5=B0=8F>=3D4K=E7=9A=84=E5=86=85=E5=AD=98=E5=8C=BA=E5=9F=9F=E5=9C=
=A8=E4=BD=A0=E7=9A=84=E5=B7=A5=E4=BD=9C=E8=B4=9F=E8=BD=BD=E4=B8=AD=E6=B2=A1=
=E6=9C=89=E8=A2=AB=E8=AE=BF=E9=97=AE>=3D60=E7=A7=92=EF=BC=8C=E5=B0=B1=E4=BC=
=9A=E8=A2=AB=E6=8D=A2=E6=8E=89=E3=80=82 ::
> =20
> -    $ echo "#min-size max-size min-acc max-acc min-age max-age action" >=
 test_scheme
> -    $ echo "4K        max      0       0       60s     max     pageout" =
>> test_scheme
> -    $ damo schemes -c test_scheme <pid of your workload>
> +    $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
> +                      --damos_age 60s max --damos_action pageout \
> +                      --target_pid <pid of your workload>

[Severity: Low]
Is the --target_pid flag supposed to be added here? The original English
documentation for this section does not include the --target_pid argument
in the command snippet.

If this flag is now required, shouldn't the English original be updated
first rather than introducing it only in the translation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812065914.3071=
433-1-doehyunbaek@gmail.com?part=3D4
