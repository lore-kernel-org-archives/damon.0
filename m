Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199723;
	b=qwxLZdLnIpxodelFuH1qyYZez6NnSjWWoTmGTSHt4DrtrApp43NLu+BitJ9+rsKjo9x/
	 gbXqiH9se3hflB6i/p7dAY5MD+5HIUIoJ3AfGqhJ6irNzAXE0zVTy5ge/o10Z9bfuVmuc
	 cMHqSa1zPzMXyZg9yfTgGY8xikqrO5iApURHngGua4WQi8rsEA7RBeYJeD/dYB6xwiwKC
	 tEodUMws2GVtociWG3C0GrX6LZqw5Uhv5IUMJfWCQcOybQyhJr1duTWwahny5s6pN/os+
	 ANbnu6QWaCa6clS96B5JoB6LT+QcFIASeZAdPoWskBFKBv5yLG3IOCq0YxV67tW+wHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199723;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wAoBLoXXSamm/b/wOmsDKw6noG9bcCas0wZlmUf2Iuo=;
	b=SCSS0yfrIs7DkwU2/+sVzkWjGpoYuYdrJCxpIj69nI3W54sjtrHA1M1mFcM9hOVVInZZ
	 SPsMOx52tSFd8xFmoHNnN3amGOwgoAUScOPlMeYkUyg6Wb4NAIZ/h18COyxqaZIcyEYR9
	 HufGjAW8WVkQwjSN61Ca1+N4+klKwP2LI5lsRioTCQPhAAOWk6yZkT/g1dx3xE0YstbUY
	 gu/hRGGYeS/6IeHkq4RieqI9U70PT8QdOeow2vOfgYvjP4D45OzOq+++6Ze8igOcNlWgm
	 Yw4bK3kxmT7V2lbYuoPga0yJ8vPcq4iI1NM6fJofBJpDQjkRzz8Ga8jwZznmbi5qxGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRIJ1vxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9760A260B
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRIJ1vxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA01F000C4;
	Fri, 20 Nov 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199722;
	bh=wAoBLoXXSamm/b/wOmsDKw6noG9bcCas0wZlmUf2Iuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRIJ1vxinEcaXB4vIFS/vMl45/bhlTMTJOCZ84Vd3o2ULvTzQ2TaeBvFm22GUKb63
	 NupAi4UqaaHzg8yruSYmMxnYUE4HYgkGz3JS1+ZuRbZYIe9FuQlbBWO0yTw3ylIh10
	 LT28lvIvXqEdNs1KEWu9i1P6K6UBxozlAuYckUlxSe8b5FjG/7cUL1m5tD5GsLzIjT
	 1O17+990djOkPvhRdhsYRCQKWeR01vLALdjFoOul2y3Ino5AkQib1KOnBKyEK0Xkj2
	 9m2l2w0dYlQeWrEAyag/h4SN6Am73K3hVglaytC8rHONamchLJkx/TAFySBWY8o+yP
	 5KvbnixWXOoDw==
Message-ID: <sashiko-outbox-225849@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/60] PM: hibernate: size the image from common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-17-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-17-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:35:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> hibernate_preallocate_memory(), enough_free_mem() and
> count_free_highmem_pages() count the free pages of every populated zone
> as room for the hibernation image, but the pages used to store the image
> can only come from common memory.
>=20
> Count free pages only in zones on N_MEMORY_COMMON nodes.
>=20
> The image metadata estimate is a separate sum.  The bitmaps track the
> page frames, and every zone's frames are tracked (regardless of node),
> so that sum still needs to be calculated for all populated zones.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D17

