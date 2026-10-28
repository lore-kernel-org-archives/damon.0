Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150055;
	b=dxqanrrIJ6tcGXEUiHnqXKMvoC61dS6nlSp10sMlGkTpqZgS0CMI9O7N753Xul3g5C9U
	 x/000+At3gObs2dJRlwCSldFDMeQ5vVNQKjTXf2V8lNyVjz4VMMVz5VOGF03CxwBz6PGJ
	 zAAMtokH0dP66T3Lt6sUk3DMmphiKr/T2vR8XpGeyAb/ExjGWwW2YXZ7rODFLgQOyFACP
	 9UVpYFDOp4/HdpMyogPbqun3OUPZUGqCasd/vkGatk9UZrTwRo4irb+IVRdEJAPGtisyF
	 W5kWKZyUI7C+GuEggx5w/svmNLqAaaG/Yh8BWIKOXUNzoh9RXuT8TEiIdumGWeT9/JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6dbJEUvFwYbOEtArHPJAXBmSiUmaMUnfMzCeCjYDsM4=;
	b=4HyOl1XvId/kq7s6SRCM2LRmcThHFJNOTQND+2gQI525yDKctdIWRwsY0PW+MOBFuIqZ
	 lriGP4pNyalezUIgno2/I4KQw4vljBpKVdCxckm7JmDXQU6pmsQUaLNm4htrbM0Zc6HXZ
	 LJ5iIINig4wOk6/FIk0075Ws37qhnkY64f5E41mIP4Q4v/zEAQhCFFENdNlk2K3Xq+wvS
	 1zFaUJFXUNqbaPFQy8tqYgIIhRRTM6eBpTltX9lziBNmaIhHrBgUULDs2KLDeeSvGT1ro
	 wiNr4Bha7ke4NPrEwHET2Gq09cgMjp2ixJ2lqCiAhUt2pEsc8W0DkQ1s8tbwMVNHfMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khNLSr60;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0F60A262E
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=khNLSr60
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667A21F031E2;
	Wed, 28 Oct 2026 01:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150054;
	bh=6dbJEUvFwYbOEtArHPJAXBmSiUmaMUnfMzCeCjYDsM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=khNLSr60xKxnSTDAhh/cErgjBZqPQLXJQh+XcBJfev5UItFuDHY0uFfUxP/IT7wKb
	 BMYTpJaxUXppdhbZGNfLANPXgwizsBVSn6GnbdVbcfjeFGuDNElRk2Uc5RcmIHPeF6
	 qonqd6cjgwFxOmY6tyb+HPk0dxJMTLSelL+ne3l591a8/rDM2H+/IBrNlVgczLcuhS
	 8Oy3X00riIFVhneIBPp7YF6S7yY24Z2yI6MZmku+8WWKI/ToVDTEBvjbWiuxITFg5w
	 PCdkmS9C5MZnRKf/pnzGjl4rS2D2Bh986Q1xWXy0qSiBznEFW07jECD9lAVcoDDVud
	 dKe28ZCi20MWg==
Message-ID: <sashiko-outbox-187307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: error damos_commit_quota_goal()
 for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028010247.158237-1-sj@kernel.org>
References: <20261028010247.158237-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:14:14 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Patch series "mm/damon: move zero damos quota target_value handling to the
> core layer".
>=20
> Having zero DAMOS quota target value can cause division by zero.  DAMON
> API callers are checking the target value parameters to avoid that.  It is
> easy to make mistakes in some of the multiple API callers.  Move that to
> the core layer.
>=20
> Patch 1 adds the corner case handling into the core layer DAMON parameters
> validation logic.  Patches 2 and 3 remove no more needed DAMON API callers
> side handling of the corner case in DAMON_LRU_SORT and DMON_SAMPLIE_MTIER,
> respectively.
>=20
> This patch (of 3):
>=20
> [ ... ]
> Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 610c4438fb66e06d9e693c0ad3b2c1be54c0d61f)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028010247.1582=
37-1-sj@kernel.org?part=3D1

