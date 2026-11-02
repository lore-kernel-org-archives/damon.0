Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632938;
	b=UDydRKMeh7ZUPyyZarS4jSJW/QX7SwFkyOXRfGhIJQdUL1Es52/51MDicLSfZk6kYJ6t
	 Z3mlSwHSk+ein7PESWXxOpTu2RileemxZlVvRyUy2nsf5Je8K9VUUF3jAHzR2DSYc+2Db
	 gF1l7AhhiQY3xB3CqWprSiwaHgRy/qSLuhywP6QmIEbQhgx4hoDBYZp6ghsvpVNFSN8M/
	 KK8xcRS7QOjjFO9jywIcTwmGxl1ciNcetkepJ2V0xReF0nTeBzeJacQwpSzxD0QMTABRu
	 iidOf3nMF0/uGkQk/HcRaG/ZuCMKRvivzNES52tATNG6IKDmsppLECEOlbhOKT0+Hyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hpheugCcUEO/5DSpsv8WVE+mauo40FdCSRc0eLrlYjY=;
	b=lcT0cIMxVS/sqiHqs3qi29cFL3R4unY68mzrnTEmHfw/zX3rh/2c5LAId0QDzCqQ0uqe
	 kC8uYkr3lCFYYwfNQkPmo2pcJ+pxHph5X7XtGVzHhNC9NXNqq9l4ZcV1eBq8Yoohu7ojj
	 zZ083S1dXLD/n/b83pzYsUvqKXDZJo1YXLYxMvKyq+CG2FppYAmjVLY2+hF6SsdVccuZo
	 R+87LZM4I2yxYIagmtHMDXX5yUv+mRcx2tXcdFaP2eaUr5REdlj1aYga2It9yJ6Q5wWwR
	 nrdhRvvW2nZJIHcPFsGTaz1IaUyNOc1d1o6OCy/AAhF9qGnEhe7bWUslUlll7onDNqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmELlMpa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C16081CC1
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmELlMpa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A951F00A16;
	Mon,  2 Nov 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632938;
	bh=hpheugCcUEO/5DSpsv8WVE+mauo40FdCSRc0eLrlYjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cmELlMpa7vHiiOUhyWYe3CO+6bENcK6c05ldgqbNtBH6cuUvMqDlRF9MpIHL8tptm
	 foC5lT/SP1kUoF/hkGDkjzeH98QH1Sjb2kjDAelQf1shXrTnOZRRDLzjFoW9gq58wR
	 nolvN5qHElXFBw5SyvEYuKi6o51Lfvm2cyQ56fIkKADPgivie55L/DD2iLmBosVqsB
	 xckcj0DCTi9UVJwm3J3dDL1X+pbevKJWYmweTBJo+5Xh1HCjEY7A3iKykrGFmvNdfv
	 Xa9H3s2ZIppwNcvB9Ku0wyA5Sqqi9bkYbBYUtTqhF3Q67SGiWD9+JHWSknuUsxjMtD
	 RYvZ0CV2ml9Vg==
Message-ID: <sashiko-outbox-193653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] mm/damon/ops-common: align MMU notifier range when
 clearing PTE young bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-3-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:22:17 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
>=20
> DAMON selects a byte-granular sampling address.  damon_ptep_mkold()
> clears the young bit of the PTE covering that address, but passes the
> unaligned range [addr, addr + PAGE_SIZE) to MMU notifiers.
>=20
> For an unaligned address, that range extends into the following page.
> KVM ages every guest page intersecting the notifier range, so it can age
> a secondary mapping for the following page although DAMON cleared only
> the sampled page's primary PTE.
>=20
> Align the address before both the primary PTE operation and the
> MMU notifier call so that they cover the same page.
>=20
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Tested-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D2

