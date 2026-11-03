Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667702;
	b=BjNGDd/lAej6YU1GczHhNSnk9Huj8iOk+2INDPewLOuUZN2JsXh/L1jLKaHsjIuHpGxf
	 rLp8qwbw8qx9kncbqBlWdkI5e9Mrd+/Nevda0H8Pk6yrC56bB00s60En563rUBjUAQDEn
	 v9PECEmWCVgNQGsRdxefnH6uSTIbyQvidFzRnrRMot/Viuseom53vS1HqFn06csZ3+vke
	 ksSG6TWPmDxFoMUoNRqmN3Q5OsjQ4tNHOXRS2ZHZZ+UGNGkojwAR8Tm19/NGvC4ZYvtKl
	 KlX5hd0P0dsTdj2Xv4vU+1gKeJe6oAYwfBIsEyEBfFr5BU4JasXJcIKFiudUiQuJhng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MP2Mnz31IJSius3aNj0r+Vl1TZ/YY6VAd9LFVNeoaFw=;
	b=I0bVgza/Zy6xDPmpvO12aiCj4wEDpuzDiWTGYPFFw6YgSkwGna/MLLv30xQtf4xQ6Wuh
	 iZoTm4KH3na3B1NVKCbFlZI/P3df+6rbnR9kXfxrSx3Mlt3a6F+Q9rQi5effaQzhffF+w
	 wq4T03dRY1B7hq3/rXBZD1qef6aSKBdlqLI2U6vYq97cUG5Hh+wPKPNxG0tOMSKNaZtxZ
	 0RTzuGWp/f/2UQ6cBD8ms/Qlma0Sl6MeOVOtOej/LBHchtpReBUjXxd345CzMR+Xwgmrj
	 jmLcAZrFlUvYGdCmpQGPahxE+5tAHubcfGkKJaQpHp1OpOwsi7rdpEt4aBVLO+zrWBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl9A8+7p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74710606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zl9A8+7p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AB31F000C1;
	Tue,  3 Nov 2026 01:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667702;
	bh=MP2Mnz31IJSius3aNj0r+Vl1TZ/YY6VAd9LFVNeoaFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zl9A8+7prn4fZVBHROfvgoQ6pjUCVSxxLZHYLdVpGonATVH6N+jOjMyFg6kawDYnE
	 g2SC6wdjcDMbIM6wz2vSkVG1KSCwQGmTUsN+CQm3P0P8NuuY1D64s4gXOMtN9EmAeY
	 aNcdBJ3dUZy8VavcnSRhl2kI2YatOaJCRKVvgVPa+vg9roW/mDx8DCc8crd2Mmwlyk
	 fjtUAlJDCNtlcmd7AM7S2E+2Wojg2wGyB1Vm+NGMOGKfkhXK5srWBd99FuJBhuOxPi
	 NKRLZUVYFRFZMq0CiU9D1NZJhZZNGkqE87e5qG/K1hl8X4ysIQ9aeoYJFqItoCMX+C
	 a+iGpgXcF8MgA==
Message-ID: <sashiko-outbox-194412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8]
 Docs/mm/damon/monitoring_intervals_tuning_example: fix grammar and typos
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-9-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> Fix a few typos, including "Moniting" in the title, and some grammar in
> the interval tuning example.
>=20
> "starts looking degrading" should be "start looking degraded for", as I
> think the sentence means the cold region detection starts to look worse.
> Rewrap where the lines got too long.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D8

