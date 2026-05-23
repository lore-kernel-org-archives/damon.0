Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EA32860F
	for <damon@lists.linux.dev>; Sat, 23 May 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529851; cv=none; b=NmiHqdS1wxPn86iTPOIQBFvQpegeprjzod/BWWCFJ0/mV30yW/6jUNd6D3haSvLCuL0/RrrNMORInvb4dsDVYy4SmitSIpOWRAy/U6fcx1Vkkn6x/4rdqNw3hS3J/gdolqoWP5IOyNeIr27gjbyOx1zpwxe97tatWTw4OAq9VDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529851; c=relaxed/simple;
	bh=NQM+Bs2+zHQEIG+8QXajwnDMcnjTVL3hRvX/8TP3Hvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fTtLW/JDfpJE6CRQPTXP83MJcyH5VAWDJlzC0YU+Z/YnelNwNGJfiyNIpSZ2SiApEGt0YFl6YjMvVZH6zz1De8hcMeyrT87bdQtgwwjSoNY0BnzW2iIJ0wwLQMcIpgiWbcfmlzBnSP42bK/DCyY0xiU+m/X1mg55+3n9oNYjEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZWXgySn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZWXgySn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966281F000E9;
	Sat, 23 May 2026 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779529849;
	bh=nhXBG+sK3xbvNWlCUXmnaAihJhxZUUDyGYNzQuUgsD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZWXgySn0DdE5p3TmLQbxIEuaLNRVW9+D9JZ36TkQIBVLhFuUU5oKgqkpMqEEVflT
	 yXwT7lXVj5J5F/QuZ5OPI3U5ier8bRtNW1qSCQk5HtUu4fmGAdNefudxfczysynbnY
	 3lAnZ8sliEFk8J6sEehD5hBJPCeRqasLJ7T+7vWZgcqhj2or4UKAJ8iq8fcm9u/lOr
	 uIoo+ECtuOzhgyTIYoNr6izHkiBHvDyoy9aQDjYOTC/mCNrc4Jlb7h79Dk4M5EJqsn
	 KHejHnW9GY0jrF6B3VvUhPRjn9gQI7wJKqjMOXVkN2Bwaumy6p3k7Wu+L15OvCqKgZ
	 1mjkN2+dTXNEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] docs/zh_CN: update DAMON usage sysfs documentation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doehyun Baek" <doehyunbaek@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260523094420.741003-2-doehyunbaek@gmail.com>
References: <20260523094420.741003-2-doehyunbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 09:50:49 +0000
Message-Id: <20260523095049.966281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch adds a translation section for 'Special-purpose DAMON mod=
ules' which is not documented in the commit message.
--

commit 9721bed3b5f9230f306895ba2eeed6bb6f13a05f
Author: Doehyun Baek <doehyunbaek@gmail.com>

docs/zh_CN: update DAMON usage sysfs documentation

This commit updates the Simplified Chinese translation of the DAMON usage
sysfs documentation to include recent additions like refresh_ms, addr_unit,
and goal_tuner.

> diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.=
rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> index 9d7cb51be4931..3fbfa9df99350 100644
> --- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
> @@ -15,6 +15,10 @@
> =20
>  DAMON =E4=B8=BA=E4=B8=8D=E5=90=8C=E7=9A=84=E7=94=A8=E6=88=B7=E6=8F=90=E4=
=BE=9B=E4=BA=86=E4=B8=8B=E9=9D=A2=E8=BF=99=E4=BA=9B=E6=8E=A5=E5=8F=A3=E3=80=
=82
> =20
> +- *=E4=B8=93=E7=94=A8DAMON=E6=A8=A1=E5=9D=97=E3=80=82*
> +  :ref:`=E8=BF=99 <damon_modules_special_purpose>` =E6=98=AF=E4=B8=BA=E6=
=9E=84=E5=BB=BA=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E7=AE=A1=E7=90=86=E5=B8=
=A6=E6=9C=89=E4=B8=93=E7=94=A8DAMON=E7=94=A8=E6=B3=95=E7=9A=84=E5=86=85
> +  =E6=A0=B8=E7=9A=84=E7=94=A8=E6=88=B7=E5=87=86=E5=A4=87=E7=9A=84=E3=80=
=82=E4=BD=BF=E7=94=A8=E5=AE=83=EF=BC=8C=E7=94=A8=E6=88=B7=E5=8F=AF=E4=BB=A5=
=E5=9C=A8=E6=9E=84=E5=BB=BA=E3=80=81=E5=90=AF=E5=8A=A8=E6=88=96=E8=BF=90=E8=
=A1=8C=E6=97=B6=E4=BB=A5=E7=AE=80=E5=8D=95=E7=9A=84=E6=96=B9=E5=BC=8F=E4=B8=
=BA=E7=BB=99=E5=AE=9A=E7=9B=AE=E7=9A=84=E4=BD=BF=E7=94=A8DAMON=E7=9A=84=E4=
=B8=BB=E8=A6=81
> +  =E5=8A=9F=E8=83=BD=E3=80=82

[Severity: Low]
This isn't a bug, but the commit message states the patch only updates
stale sysfs entries, yet it also includes this new translation section
for "Special-purpose DAMON modules". Could the commit message be updated
to reflect that this introductory section is also being translated?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523094420.7410=
03-1-doehyunbaek@gmail.com?part=3D1
