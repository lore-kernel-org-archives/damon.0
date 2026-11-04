Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807618;
	b=zaMKq9cwRNhf6yhCshmty1M1T1QtdITmVpQjdZoQElzrsrD5N8EWZBNV1cuO6Ca5dtGZ
	 6pyenIEVnf1lv/KFtDkWt6zPrKGqX6KYGrAUnnYQi84K/mdro0nruo1MOd3dPbCnxGBfL
	 2XxNMI5tIJl4DMkMrULICxz5A8s5Mr/yy+iJDMDsnUm+rGcgKaTilFvNK6b4h2TMXECa5
	 8TLMnf7uqqMJGyBALnNvz/9t2gfhmzt3EktEoiIac24iIA+78SraSsJxJ+5z0akAG7UlY
	 E+JfCuFJ1HUimqnVc4nHJSIBJ2hAH8bJ253PdgaF2e9lostgMUcKrQC/W0KewLMva9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4fSMYNFjXPHglqMfUbfBXoDkNaavDdJ9iHvOsTnuNDI=;
	b=xwqdzj/L4KPkPZwVoBhz3Boehr0FdIpYLXuJoESKO+USxDxR+e9LUZOmg/v01QtfwEg3
	 DLdC7N5pQVJqmwIth/Bf7/MTngfDT2C38D2iZaHXY2LUQyE/eUTz6rY0LHIEMyq3FBQb6
	 SzyiIFMDsnuDBdc3mCWnhh0+DXOgfPqqlBLdlgmO1zKvOIVsmNkWodW+R0g4bq4KX4q0l
	 UrXuuLKRWH22XS+2lHrHQVMPlEAnphqH9h/lAUA3EHUUumEzPJVh7pY0f0jpoR4Dcb2HI
	 lJd3x2vD9CF8EzpeRglTMEl4RoTl/pPbJorMTUAgc+mHHYiTFLfKzibwHgcp8ZEspxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXgiIllP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7107606A31B
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXgiIllP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AC1F000C1;
	Wed,  4 Nov 2026 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807617;
	bh=4fSMYNFjXPHglqMfUbfBXoDkNaavDdJ9iHvOsTnuNDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DXgiIllPVuNBsXEF3MFtyQZns0qxkUoh+50XIlKFloKQjTvaY4WWxhpHtbuQ6sPAs
	 GOOkt/eHQ/rit+asp8wg94LSJTlZCTPohSdiw6GO4j5AZ2qTK7z8sz7botWZ4CRgL9
	 QxygtAhpIZzs1Otb3eP/QyZ/n3Dq1q5eF2MiKgN3m8kkK00/ejxuXg1/w6gRF8pToC
	 rRPbkaWVx/J4a/Ed+wl9axaCqBSLJ74WCp9jEkUzBb7pa05oSzY11x6DIN6cYNnQUK
	 yblDCTUjZmceaalp3Znz5zaouEw+5YxRIw4fP1Iqmnid9iMEDNl0lSlA9f921R9Cvl
	 BIr6JSeSnr9jw==
Message-ID: <sashiko-outbox-197550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] Docs/mm/damon/design: update for age_ms damos
 core filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261104153645.82945-4-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
 <20261104153645.82945-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:53:36 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly added age_ms DAMOS core
> filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104153645.8294=
5-1-sj@kernel.org?part=3D3

