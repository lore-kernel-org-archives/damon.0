Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421194;
	b=AuYEc+yyDrQAqVtPlsnvzJNFW+LJV/Jj9onPWOfY5kW+3ImyBtWOxIXmDm0Z7Yq/srOD
	 GFGw1qkJ5m+MZ+0zZxJru6HTIBgo85upYuQ0038Xskl36AZNm7uLoX2vnhfd8UALsHdPv
	 MkUW+mFP08ned99xUickHr1uM1alyNvpppDOp1F6PlKGU2w2UmJq+QlvHHvgiDLU6a6Fy
	 Z+d6lKN1XW5nJOE29SHNYMkLHVXhB86dLCi12ep6DBDj5OvPsVWPP/aFZ6kbfcRNIWYz2
	 lFWzXIvA3SpKLM5q3bvL+KV0CHOBGjbvlcs4s7upWk38GyT9quotTeLNyPruCkPCZYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ph780no6zmba/TdUxq4UuXTYVOapNXuNSRyVQGNMCvE=;
	b=vt7jlsp3EQFln7kfmTl0YBWh6kFFcNl1kl0mKl/ZvMav/EPihBeoa8MtvOGz8cjhHZUv
	 Bv1psUywW0YOHu4sjwN+akgvTHB+8Iu+RvwsF38mAVfesY6x+q4z5Jul1bFj2Qi0iljXT
	 7wTC5oIFXTlqmlTa1cbQoVjkOQgOATuqDDfIWxkl9/mgv6UfZzydZjLk2WA6CtymDZZh2
	 weeHfOL9KsnzLNQNCSvQxaMGCdodyevprTHHUe6hy7GeTqHntJVmqfKQI4mfW6FQdqX+W
	 eqDl563zdz2pURPwKZP+Nj5f1IBoR3ikhfm6SdAHL6QRBVIsKjfq9a89HIVT6ljVMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ge79a4L/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61171606DB7C
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ge79a4L/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC0D1F000CA;
	Mon, 23 Nov 2026 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421193;
	bh=Ph780no6zmba/TdUxq4UuXTYVOapNXuNSRyVQGNMCvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ge79a4L//+p+r4uAwz9THQp6M/WFpE3EUxEXESV6Ad6ykZhXCLeqsXkg3hLLZePzN
	 VPgXBXjGn7LZgIufN9lu1FEk4dWhnQ/vPFHBZjwkbIQ+qzYqZGVW4fbANXzL9OWcPo
	 bh4eInb8GGnkkdR8/JCKGLesWP6RczNN5hPqPpiQemcFAFMaYy3W38BCxd3vI/MEHe
	 a0z0XxddktHEXnnIJwUBY6gBSjU3oQzRp11StIdKg1PHSInDA/FTXRViQmFMcTkORW
	 zdhS+UhdmL9+HxWLaP+8yZQR3U8BU4POAOWT5VUtIEDF3O029qgMHy7FVZfc7Oqil0
	 wQo9++wT8eLgg==
Message-ID: <sashiko-outbox-228876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/sysfs: skip registration if DAMON core init
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261123-damon-sysfs-init-guard-v1-1-a2a6ca65693a@gmail.com>
References: <20261123-damon-sysfs-init-guard-v1-1-a2a6ca65693a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:06:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Hi SJ,
>=20
> Here's the sysfs fix I mentioned in the report queue review.
>=20
> -- >8 --
>=20
> While reviewing the DAMON report queue series, I noticed that DAMON
> sysfs still registers its interface if DAMON core initialization fails.
> If damon_init() fails to allocate damon_region_cache, starting a
> kdamond with an initial region can pass a NULL cache to
> kmem_cache_alloc() via damon_new_region().
>=20
> Check damon_initialized() before creating the DAMON sysfs directory and
> return -ENOMEM if the core is unavailable.
>=20
> Fixes: a18709442869 ("mm/damon: improve damon_new_region strategy")
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-damon-sysf=
s-init-guard-v1-1-a2a6ca65693a@gmail.com?part=3D1
