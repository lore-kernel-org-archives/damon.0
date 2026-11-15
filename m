Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774737;
	b=YvlteDtRWIYh3XUS6k2VnD6sNjYOnGcHHKfCpgRHIff0F96mTZV2sr7x7eOCOLePw7EY
	 brJRxA1sTQ0Wy9Wkiha2ECzHXVoStbmGSWFDvF2r0XMJsGZv4ETA7QKrxOGnK/07HIETL
	 yUdUQ92IQMOAZi4iMtSb3VgGk34+ZsBg0y+kFIsN4WLFpQNnVB1vSJBfX8ozbNnWA4XsZ
	 S4qyrYRUexwqMQHeMrBpMFYAaj5rAdBms7e9JcGY2V2x4ZhgSFD5l/mjJd/Il2Kk+DfUu
	 9isLlQNAHuDybL5eBaLudnoXljpdUuwwK12qiVT+kmuhR4i7fxIb+xOV24H4exgMz6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4DX4xze48NM2O3yXWyhHs8u8vohs+9Qnxn4kU86c18I=;
	b=nid1V9nxh8bWQbN0Js9j4XIIXsTAe11Ed65v5yGa64Fe5CjL41SPeeXbdHSMjB54Tazx
	 IIgDduI/xwOMTfvX/XtrfjIZjC25e1pgWo/5hRW9yhzVvMpUEiagBv6Pdc+Xno2jTh5yB
	 UvOPmEyiNnA/d0SAeA0P+g0rXrwkWX0HuYgAlBYXbAaC0s24YeiZKXo2nz9+8OS/64p0v
	 LjPxb2MBH8SUE4ActSoAern5GN9f3YgGM5Krms3FTENXgBtPLw5xmdLkaQct68UvRZk4k
	 ziI1sPFL5yxaOni/yPUykA2E+aLX8s7DDBn8lfILlWhS3RKM+EwIqa9HVeKY/41IOHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVrfccqJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A3606A329
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVrfccqJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A791F000C4;
	Sun, 15 Nov 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774737;
	bh=4DX4xze48NM2O3yXWyhHs8u8vohs+9Qnxn4kU86c18I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVrfccqJEgrYySuOAxUe4wOYwdMvOX5dfJ9q4xRDnaOeLEmiFitMHOcSE2ma/DhT1
	 Nby6ullCHwR5a5gG5KOzf45godo5MuPGwDPheci215iCgn0rbPiDwHiZ4QSy1PEe0o
	 8bzg49om8ynrp5LqcZueRhdjV41WY1lISwZy8PO/yn8orzoa6ohP0XMvVIXFdLjH4O
	 wZB4GKuTdE2lDMovn6bq8UblsND4bNMUjBnJQqVD3zzGXE+bIM3iezpW8SiLnIyuL/
	 wgocepPmnKeKT+8uIJuyf45AdvuVxATYYg+V31krl258eGLOC5awJEI9XLsQ8Mxv67
	 JoYSTplzI82/A==
Message-ID: <sashiko-outbox-215824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 15/27] mm/damon/sysfs: add filter_report_type file
 under probe filter directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-16-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:16 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a sysfs file, filter_report_type, under probe filter directory.  It
> receives damon_report_type from the user.  Reuse
> damon_sysfs_report_type_name struct for user keyword matching.  Move the
> definition instead of forward declaration, as the code change is small
> enough at this stage.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D15

