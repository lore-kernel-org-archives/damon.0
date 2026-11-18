Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035993;
	b=d1wyx66HbPnC2yP8RZ1CJqtY+RR3GGLt/3sFDuq6hjxfL7PNnqnUMLgSIJwwpCcay5Id
	 VX/w4PgLReQIRLuXNCH+RRY7808O7CzjRWj6PPH1j7vHRataHWu3EwwvRQNqY2u9jY9vP
	 9Gvr0dHHLCg1yi0OoheAA+H0MNMm881tfAVeVq0apHmyC+XcoAOGIUdHnjZacEXJuhwwL
	 CxW6rKP/LmaYDbPVfr8E12XiVPZX/CKyTTXS1gFm3tBKSbFniHWf1XpiaAqJlNdoBnuYK
	 bJ3vBKHjeEobRoR8JSYKUrk+jmygPz4a3kb85MtK4sIB1heETvg2OzVvIO/yyn4Sy0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jR2FCUy4aWCJ9JGNlcNKO03y19RXZ+GoRwhWuVrHlIw=;
	b=AOIbBYAbLji68bcXrELT9smGspfbigFONMh/wYLPkexh23lx+qzsnE9NjIz91srC9BdR
	 cW5TI5yhvjBTMwV36nJRxkHXIwRAjA6xlvdej+mH3aH23yQjkHDuWAVFfmRVQ+BJmKBz5
	 YnSNmKFZIM1Qz2+WWZUewmb6or170jG6myAYJq57UWQMDEorZOQeR+fWCKqLrdDTrtBui
	 OVYfqCY1cfi2qcMTWKmV3fyGP1jjr/9xZXZgxtb/SwzoRViMkBmx2xOlhf/2dbAccEeaK
	 XlG5Bm6UTji9OEcBVClMtL1II5E+bVaDpCdpmi2fgTzzC8xGhBllfUM+p0myyNr38dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHr+QtdX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF48606A338
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHr+QtdX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2361F000C5;
	Wed, 18 Nov 2026 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795035993;
	bh=jR2FCUy4aWCJ9JGNlcNKO03y19RXZ+GoRwhWuVrHlIw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHr+QtdX2ka2YfKUyw3nt7rKlKTV+ubBhy+6+uLwPFMpKxZ9D7WamvY/46SRO22WK
	 j7bFfZzTOqtXCIcI1I9Hm77KwKwnxQAqsxTwRyKnQEiIcLmguue4+NVqMVAVS32Ovx
	 6gQFfT52F29owpR3/vEyvZtwGEXfUJxy/amPRRghf1SJ5mznpxqoO0c99+xMNXSutw
	 kiNbcCL5WeJnDaxOV91f1j1mT96+T5gI23EyJDWJ1hSHD/EPQLHM+ezBs/qHUa7AoJ
	 oYB0EfAfwct81XXm2nwCjvMjpyvUpSDgIVhuwrNcMC0yefRHPTR2OJRBXjxAP+aZUN
	 xcXUMbNvzudeA==
Message-ID: <sashiko-outbox-221968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/17] mm/mglru: rename the generation offset in
 lru_gen_folio_seq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-1-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:06:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Ridong Chen <chenridong@xiaomi.com>
>=20
> lru_gen_folio_seq() computes how many generations below max_seq a folio
> should be added to, but stores it in a variable named "gen". Elsewhere in
> MGLRU "gen" means an index into lrugen->folios[], i.e. seq % MAX_NR_GENS,
> so reusing the name for a relative offset is confusing.
>=20
> Rename it to "age", which matches what the value means: the newest
> generation is age 1, and a larger age is an older generation.
>=20
> No functional change.
>=20
> [kasong: dropped the comment table part, the series rewrites it]
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D1

