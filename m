Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036101;
	b=1Xq7Bixcs+BQmx6fa0APSyqEam6kkh6PCM4ypdnU6mnHL22AG6HcUZGXirQmAXEremlo
	 Z63WTBPiuH6hWvBxlG5EaUm5ednsBqxiaA55KHKVg9XXm0JwUSkPjfV6XsfzQBTp/G9cD
	 lOtTP6FCsaQ8Wy17AEkF2a+GnrkwsZQdyHDI202URXMqWATNp+zmP/uMDfwgbKo2LBvIo
	 v7A18HibCNk1UMzRBJMAYFJEv4v45DHLON78hfrFOMAFCZPaBUbwrqDDYW40YBJyGMWOt
	 HoXR/Qgp/scKNz+hqgvAdxJfOTnTYzVDU55qC+d+ha7x4ZtYmO7hR/SmQfOyBL5gjdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/CunEKhNFVpg/wvoORFgMhHUrWUHC3l6ukgPw5DD2AQ=;
	b=FmXo6xNBaRTfl6X0GkCjXI7CLGzFTTs1Mg7/Hp7BmsjIjFrMP4xhjJ0vswp42ueKj5oB
	 GUemvffU1MZOg/90k5DAwwvRzMhH4Z1MzkEhJ/W1wTfbTOyZcmfXY6jVqKfI1pQ/Ps7r4
	 FLJrUIR9P821yPuwImP4oWnM7ucFZRwvepVZhZU2GZQfqn6OtlIVydtX6jXb4Bjp8/BN+
	 bxP8IHrBpbB90559XaQz5TzoWPHgRWoIdQrULppSAL7leLgDoj278zp1wtnKk00TjsB6y
	 BOaKGn70nxV3e9K/HP+SN18CWQj4Lee9rwzir8Nw/+7CWDYFvymkb7uuJuYYvkyzw+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKEEhlip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64725606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKEEhlip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523B1F000C8;
	Wed, 18 Nov 2026 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036101;
	bh=/CunEKhNFVpg/wvoORFgMhHUrWUHC3l6ukgPw5DD2AQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKEEhlipGCHZeqehUrf52rh8QGxeHAaJ7AYjgJKTD8qe8gyTsyYeKbot5ugU4O3ek
	 W/UCprxwTpr4HnaG/o8aFhMQ+S71UnrsO5x5tnPcFBqmqSFnySbhzVWnfdStuRdyxT
	 YfrUCrBrc2GMsdrGNwt91MUiSpUCU1i1eLLak/CFKmg79bgs3ny1h0TgdWl6gBo56e
	 nxg1j9d6O4mO0WtyrgEI3h0hOkvEJx8LcadrDWtwFM1kx+qfkfA/KA25Q08aLDBqrc
	 OgGLxU/tKbZZHdv0qE2qIG3yoGgFDc6sHXDQSVVkWwifP0yUpCHzhkqVI7AgtZOp+8
	 ZJA4UnMoFq+UA==
Message-ID: <sashiko-outbox-221971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] mm/mglru: skip the flags cmpxchg when nothing
 changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-5-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-5-9eee2fe97a2d@tencent.com>
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

> From: Ridong Chen <chenridong@xiaomi.com>
>=20
> folio_update_gen() and folio_set_lru_refs() always end with a
> try_cmpxchg() on folio->flags, even when the new value equals the old
> one. The locked instruction still takes the struct page cacheline in
> exclusive state.
>=20
> That is common in practice: a folio mapped by many processes is visited
> once per mm during a page table walk, and after the first visit it is
> already in the youngest generation with refs cleared and PG_workingset
> set. isolate_folio() and the eviction paths also call
> folio_set_lru_refs(folio, 0) on folios whose refs are already zero.
>=20
> Break out of the loop when the flags would not change. The update is
> complete at the point of that read: the flags already hold the target
> [ ... ]
> [kasong: folio_update_gen() is replaced by folio_inc_lru_refs_walk()
> later in the series, which keeps the same early exit.]
> Reviewed-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D5

