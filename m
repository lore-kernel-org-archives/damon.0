Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036100;
	b=hxe3wNzmKXW7houV333Q40KrCISwfCfxUpMbJVJFRFpLdnMMH8p5dQmBU5J2+lSGWhWK
	 vJK8pWkTdiOm+yVzGOviMV//DMJvrbQIuZNVdWuTkOApO1403dalMfODj+TpkzrT7V7D6
	 JUGyY9pKetnW1iSWUG9znbQcNf7HMQ2Hh2UXzMtaeaS5hl5Bg6v+JkwLj0LK/4tE5KwJt
	 1swgqLAZIcKyPidxRoEdE6LhzIk7+mz1f+2yqffBs+gUm23T7UoWc5P6wub2u+VIVWZ0b
	 ZVLHjS7Xg9UreItZr2zEQKX8+bY1Zf/jWwGkhKGdfhuXFddqlVGkxSsVEiJPO7k6SPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jKyuywUrKWGMz7Kml8iZNkWdQ2bNRgx6Znbb8VTLVHk=;
	b=3dxxp9y+bgWEoSALsQSsCgSwm9VWRXd7VuLW4wt0rAWDJbc8mKiVwcXzVbxJ/EvXRl13
	 zyt9LYYoqrk3qExqaTg5vzd/oo5OdVxcgiMHTivN6F4v3gsx+0Ip3HCXWfvYa3vZ3p8HC
	 hRJyng6s3TUO1MwUNn8ZDSED6oXk6ivd40gD/TbMJYvFjUiKOfCqs0iPNa8dIoUrkc/3E
	 dotRkgjKAOfSp+jmnSkC0Xtme/VTZNIttbsr/cAMB+MbC4EXEVpZAwhZSa4See47womnr
	 kRfcakJAg/vjc1BkXaj8wgm9SV24OpfuHiUrfeMmA2aCjutnrYqbqbBwv3dwWZGGR3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEzrA2Me;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5479606A325
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEzrA2Me
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FED1F000C8;
	Wed, 18 Nov 2026 21:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036100;
	bh=jKyuywUrKWGMz7Kml8iZNkWdQ2bNRgx6Znbb8VTLVHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GEzrA2MeSMgPEqs9jwpyV3enhx3EuTImwgtEHvPWBEzTrzNB5UTKtWZBp6aRnxf0W
	 jW6huwl6BJ9NnGuqNrLvtNeCJQmzP5baP/9ziWsd3plsJfqjEgJ92CKWghMhR+BYae
	 7hW19X9bYU6byElX4zF3q2RhAfKYQPMtRoF5oKcuZwA9CDWC3urDIjvtE1ICfn1dxl
	 7VGMFZ0eC2YbAUQVPwU2KZabMaoP9pn4dP4kUfy/RRNFTtRyX3uKePu9jGad4Uq7nt
	 vAltgNutxBrHhZVnC1gDa8nbHtxTOXdydlmAWHzlkpx3CD6AeznyQnEVUYF2stEEcV
	 9h4odaog0pbow==
Message-ID: <sashiko-outbox-221970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/17] mm/damon: convert to LRU refs based operations
 for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-11-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-11-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:08:20 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> damon_pa_pageout() cleared PG_referenced directly, which under MGLRU
> corrupts the folio's refs count. That flag is now
> bit 0 of the count (LRU_REFS_FLAGS).
>=20
> Reset the count instead under MGLRU.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D11

