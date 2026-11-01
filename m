Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553528;
	b=UaqrHd+/kPijgbBEqRvop96VOh+0BJUmd4s0F6TmChjABo4x7mmDIiI1yZbIEMR2hvNG
	 bxntzmGTJa1miFWYwQ/Nvb/FM7jqZwxhoIBARa0J36FEYXWmlIbLdPYChPQDkur9nREe+
	 DwLcpP0OvjAk2IzEhWBkNT6+mZxbxcsqx48sQhETyIZ5LrJzMtdwjRO2+67KhlUkEJDbF
	 CCn7QFd2kZIVnDPoxEIp/2cPvm+E57QiCEbHksjJ7y/4rEXhVWnR4TuJAYLc1thtIpCne
	 h/BYdq2XN3LZ/r0LuRpgVFR8gR8G0rDABuFXWmqw35DlR50JJeH0XnRQDFmKykex72g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hFq2JlypRdY/YjkW0Uvui4RgCayoIZBinlM+DbqMCX0=;
	b=MHaWGRKR60oT94GnK2WdF70AhzaMknzbCxykYHnjTsRI3xOtnEJmLysPP12CjiNTukNh
	 dKYl8TGz/7DoP/3c14DaiopYXLtNHIpW+myuzhdH/aCeCS4wL/xshcLXfpPC0+ShxeEH2
	 IIl+cOk2a06oLrW94nLTPzIRSeRaZ5bHmjBiQQSutfCFDyexImRh+ws1EhbEUWR9cf+c7
	 TEjWx9ER9jtiJpxcDmDA9//+qHMhO4Qbehg/7FPp0rTcDpIWSPaIaQ0TZ3VpMdHpquli9
	 UPjP8T0sS9S89RKIso4lPquGy8c1tFTqYUROXPUfZcRRwD1ehISCKNbxoMfYDOxlFMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr7xin5l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D0606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xr7xin5l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0845F1F000C1;
	Sun,  1 Nov 2026 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553528;
	bh=hFq2JlypRdY/YjkW0Uvui4RgCayoIZBinlM+DbqMCX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xr7xin5l/USduDUTOHKY9EP03PCq0xZe7y50lyYPCjVUG7FTOxhxH2AgdnFXlm3dM
	 PXWYnNsp8e3rrkc3tYGtOMOibpOBZDxF5Sb0qjlaRv45sCrIakN9VjORdKkbUcyKPV
	 KRSc+MX1ocz8nWshSntf6bJieAeTN+NTrgVjgqOm2BcWrbRnsjRTt14h0HZSnyDxzA
	 yjembYPnyWazconAHCxO+XpjGLsswyLynTq4ziHMb8fmYsCz8naZFlQBCq24T7211k
	 ruua13HPKDOxfCOP8EaG4BlVPNq2Afp71jNfQI3P0s5pHfU3RptIcxu73rO25aaWDf
	 W9aS5a3hWxYBA==
Message-ID: <sashiko-outbox-192520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/6] selftests/damon/damos_apply_interval: remove
 unused variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261101171630.81477-6-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
 <20261101171630.81477-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:18:47 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> wss_collected and nr_quota_exceeds in damos_apply_interval.py are
> assigned to but never used.  Remove.
>=20
> The issue is found using flake8.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101171630.8147=
7-1-sj@kernel.org?part=3D5

