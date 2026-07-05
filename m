Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBE348445
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285629; cv=none; b=Q1uoK1ycz4IFgJ3o58LF3iiVl2doICNEQcSq1/QTMn/s/m7MPvFrR1/eoKAF38encn+DiXN0F9KM1hWJjSgYS89pm29T9VEeOHpaS9uI/JHzCgiEWu9NKRs9/gbmjEfOJg3RC7cUXZAI6cWXnFV5GrDkCWpVJeAhAqRLm9S4r0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285629; c=relaxed/simple;
	bh=lgJcmmtaLR24L+2wQJW3Lb6LaK/ekOsFpJDtMAVMDUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AwdtUkv77XRa10VYR1QpNfXCRD6SmjBK+hJScFPwvP0LL9c7w8jtS7W6eQk5k4ob7HVu91gXl4tQH3WsctbRASYXvB/wSapeT+yjI3w2PIfjzhwembAcbB85pS51O2VHswL2IQf2Zhb3GiTz+Oel73JVqsVssCiV1AQlNXYgVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCj1rYhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCj1rYhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09271F000E9;
	Sun,  5 Jul 2026 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285626;
	bh=u1AHy0P8oUB+4vpiOnlErDUg3jykcMjAh33U6x13czY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCj1rYhMhU6vxxfT55GrYE0/54+7F/P/OVXQxarLBDSLSj4OmtJJzs1YTyzbLpDwe
	 DXk8WFs4Dw1T0ImWHIT9XvolgaBDchoLFSoif/YJPvzDY30Zh6erMRqhI97NUp6/lD
	 bLBYm1r2qn0MdjHQV2zc0m+6CMoaqGqIHrWrU4Lr/2n3RLWIynSCoALn6EmF0unlL9
	 T/3a07Fj82J5Z8YU/17qm4Q2zvczBuKb2g/GGvDeqnB3nICIWILylQg4U6ttl7LsyJ
	 YIDYQU9A/AIeK5XcWn0cFCbx7i2xUQfvRJj238NcuCC/Jn7D+SlJJXG8NWmaNapLR4
	 MacoY9nPD1dnw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/16] Docs/admin-guide/mm/damon/usage: document
 weight sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-16-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:07:06 +0000
Message-Id: <20260705210706.C09271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Misspelled word 'atttributes' with three 't's in the added document=
ation.
--

commit 0678cc4de62904aa4e60ad181dd2e6c07336bf2d
Author: SJ Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: document weight sysfs file

This commit updates the DAMON usage document to include the newly added
probe weight file.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index b2649ea011f93..4515088eba968 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst

[ ... ]

> @@ -286,6 +287,10 @@ In each probe directory, one directory, ``filters`` =
exists.  The directory
>  contains files for installing filters for the probe, that is used to det=
ermine
>  the data attribute for the probe.
> =20
> +Each probe directory also contains ``weight`` file.  Reading from and wr=
iting
> +to the file gets and sets the :ref:`atttributes-only monitoring

[Severity: Low]
This isn't a bug, but there is a typo here. The word attributes is misspell=
ed
with three ts.

> +<damon_design_attrs_only_monitoring>` weight for the attribute of the pr=
obe.
> +
>  In the beginning, ``filters`` directory has only one file, ``nr_filters`=
`.
>  Writing a number (``N``) to the file creates the number of child directo=
ries

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D15
