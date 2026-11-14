Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616568;
	b=RgCSuQwvjLtlXmsUzJSpIJCnbm9LmMPfCDlJfjRAdYQxMxgUey6LlQRr/vRJy2X8hD1b
	 zm49GtiJX4BGStBbE6PCYDiqLfm77uMDH+wGDNph4GCpWTo3ruWwmSsHMGDKtkZjCej8f
	 cVCUR99W9yaT14K3psMG9zuMHH8u/pfFwbG79z6g5XPUQkAU75ff1mU05Ehf3rwx1aLSd
	 wwb2l8faEgSBCXtOFcRqpzA1NLd80ZlnuGNu4t7+H0502hAxOW/kzvmg8J+yoh9HHDQUK
	 EuUkzV9YrRZcBNXB3G7xHEIezdMtMKUoWm8weyWchg/w7OWGm56k2OVREgMN0gFIH5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RmccqmTnzWefU0SjiyZjUx+YTsKu/Q06ID62uE+x6+I=;
	b=RUbmbjmOpdm6zC68d1YEieibool0sCbluHgZMa8cfrJe0MpKdquzlJOZWwxVfGRYyTEF
	 KDiQSIihcHgXyu7HMhBimsPAFnmd8AIN6XUdUouK0lRfHUpjDOHNR2o7fdLgzVV7FQSqC
	 l9KzBN45tTtYKsDocbRIplWseyagLYtwnmwrZGXKXSbNEtvFgGXRYEqBgKaBYnpIU9wp5
	 t4iShzS+QC2kGJMqAHUZ72RFcl661Axp1cXYN0+4BiLyd3fOhhDKp38g/iFTEV6J5/NE4
	 nJjHOUHqkBFpbsC0Bg3vWgeU9AXPu8AVpIkHo7L0MUnMaD9LL+y3/4kAmvBk/SP5iwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANZE2GUD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7F606A33B
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANZE2GUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8DF1F000C5;
	Sat, 14 Nov 2026 00:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616568;
	bh=RmccqmTnzWefU0SjiyZjUx+YTsKu/Q06ID62uE+x6+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ANZE2GUDMdLS6y2hCmIlTn12W5CwH4Ysdv0dU29ra+6NunHPd/GzBM60jpUevLxt+
	 AvcBPF5V7hbr5pn7uZnWYpXbNWS4AesvIPG9NdWj/Mdc1f2NQau7lbvD5SnJTNa2Ni
	 MGscYSKI0nO3CJPfEW4Fno7ckV6jjSLqDKHNriMJiVGDBfnhSojZMg212MG1ClZvuS
	 te6IuPoh0nOjwSU14vRNLawxMmbFeYPRr6rFNinOczrFwJ8xgi0mXFsN1uu2ps1UaD
	 M6+xvwg4vWKcDUMJ00qSFMYXtfgnfA1OIql8aI52LpQK760+35A/GcRPzWXadyqn/n
	 LDJKLT3I9Okqg==
Message-ID: <sashiko-outbox-213936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] mm: zswap: fix shrinker count for the root memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261114002822.1043378-2-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
 <20261114002822.1043378-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:36:07 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> zswap_shrinker_count() scales the number of freeable entries on a
> memcg's zswap LRU by the memcg's compression ratio. That compression
> ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
> stats.
>=20
> However, for the root memcg, the zswap entries owned by the root memcg
> itself are never accounted for in the stats (obj_cgroup_charge_zswap()
> skips the root objcg, and before the root memcg had an objcg, its
> entries weren't charged at all). The stats only reflect the entries
> owned by the root memcg's descendants. When the root memcg's descendants
> have no zswap entries (eg when the whole workload runs in the root
> cgroup), the shrinker reports nothing to reclaim for the root memcg, and
> its zswap entries are never written back by the shrinker. When its
> descendants do have entries, the root memcg's entries are scaled by the
> descendants' compression ratio instead of a ratio that includes them.
> [ ... ]
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114002822.1043=
378-1-joannelkoong@gmail.com?part=3D1

