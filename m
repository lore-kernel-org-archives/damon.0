Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036142;
	b=EWc5ZKc76HOQ68kFn11h1O/od6pYq9Y1I4I8EoLVdBjAPUakjmQfLqAWrZ3OOKF8bm6F
	 nnhxjQ6NVgtcgjkpNnNk4RYe26q2s4ANqXjiZO8NMoO0sA7INakC2bJhM6eBaHoWrUA1z
	 BtqX+nczBE17ATAWuzw90tHKmJWZW0R22tmkt4qpBwUpt4cLCs+++Vrbdzw+gOyrnLpkD
	 hZutSFjX7SsEUEifMp0rqju8olElUotfa736eTr3nkr1pfXV3o1e0ZUHf7/Kvj7ze1akw
	 91z5OHAnoNewvCPlhyB3wsIlM6qBs8VhWlt2N5GBtB1TtzkjuPKmzkd5xmrMXlpPqmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036142;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fsJMQdillzPNFGPdj66Tay9WpMtNmtqPUvUMQauzC34=;
	b=Vp8D9EhIFESt4lkoJUdbReQujNjGaI+l1tpsDNPhIE94RcM1a/LEGqiVYG3UC8Xffh2c
	 hXgxuFKyXa2r+cJ0rjza+pHnPsNYpeIcYnb/Tmdl0u/q7Dl3NR7pQmy9jcRc3am3soocs
	 1zvd+e88hV7u492Lo6WHU96uduRMlWuMrVn79jxCH3DjrJ6syQCJNICm0oAF/Q5M9d3VM
	 6LaknY0e5RuernPfzyOgF989WuUZJrkAvH+4vPNQ9pU+dV/Ao0hX+idal2gktyGrpJguB
	 UR98Rs2F5kv0gFbsUTzv3l5CBKtkGSKz0MqxNzTl1SuZUK1/ngQ0EOh4RfQssg88cSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/RlDaQr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8BA606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/RlDaQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0E01F000C5;
	Wed, 18 Nov 2026 21:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036142;
	bh=fsJMQdillzPNFGPdj66Tay9WpMtNmtqPUvUMQauzC34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/RlDaQr8Y7xSj6fkcRi0UZou8c2StPINfCB8SbXiS/q1S12p9H2lgn1UwaUnuzfn
	 F+qBGKN+3sbzIgF+rq41bvFuhL9mcBtjFQaaCHYkWUlcXvC5L4U5Rylr2pB2LYkWFf
	 aD/WylmWOJoZlv74daWLkxOTZW3zEJQZEJCEGxE4gByHT7mQ7sUVA6J5HmOMjQ1XW+
	 T/U0W88k7YdELN8vMcgSaz6ywWhHjfQKYkMfVTK3agCcl/OWNur2zECf01Ptld/D66
	 Kxe1WXy31EkTF8zIyyTD8Qk204buszQkgBTYTEIzahvqmH9wcaTkAXkvB8M7fHw+ap
	 USCIMu8fKaINA==
Message-ID: <sashiko-outbox-221972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] mm/mglru, gup: mark folios referenced via a
 fast helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-9-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-9-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:09:01 +0000
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
> Introduce folio_inc_lru_refs_fast(): raise refs from 0 to
> LRU_REFS_REFERENCED via cmpxchg, or just set PG_referenced for the
> classical LRU as before. No counter update or promotion is needed,
> nonzero refs are left unchanged.
>=20
> This helper only aims to be fast, it exists so the gup fast path can
> stay a fast path. The new helper doesn't account refs above
> LRU_REFS_REFERENCED but that's fine for now as GUP never used that
> or anything similar for CLRU either.
>=20
> Convert the gup fast-path sites. No behavior change for classical LRU.
> There isn't any regression for MGLRU either.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D9

