Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387577;
	b=m7cdtUZRBx07j33ViiURj6lJuCAdMvjcX9txF4Ymv3NGVfZcCguvzsd+93gxc66AdWGX
	 jMVvjmVe5Fm7dQESIyulrM9vae7Lv8pWAUc3xCb1q05bfimdsLE18eEVFpDRffiy1d1Vy
	 YYnS4rIpxB7L6JqEgPJepNX18cZiJQaR7wRFoLxyT9AIVlVyPvzGvXrXsimDxHK4bsy0I
	 j1ZpauwhAlv0ffjnVVFpaI3T5SS8ik0AiCSitpY2brwJ/keQP1ZFfGhiDwBqPdLd/eCqc
	 lOx55J2lPL0THLQx7wasDc1/s8FU5cNvVdospnX86zB4CAxWk1ZBSvzwUt1AaYTmQbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387577;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+bVpBXbONfLW2veEvY5MyXOg1V+Z2ij8/G5tQ2lFqlY=;
	b=P7yWdOFFxdWeKNhH6prOcyD2EHfnO4qDsxRLnoGlKKGwk50Yo9HYACG4wtpn5FpSiCD9
	 ecIDlXkbfd4l71aunikic1ewkCeiswm2sRpA0Nksjs+HLGU1Z5el2P0dAkcyLusS/otEA
	 0yPUCkc6jAOcQyfsEsnXf/bNTS9ItqtxAEPNIGaN3RoEIr8r51q1qjJWzgcvV1tymkVXe
	 tZcWZVSKXwbtX38mEvKYashCVo+GMzCXnsrRUOeltbFLgW3pUvwSIwR3SiXmf47DqLQXc
	 SNI734IRyLGK5swmEZbq7kZiFVikUhglAAXQOVtbnqnyxJGUjzW0z92VjdF/Qkp6IYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLVqH1ZH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7E606A31E
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VLVqH1ZH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DFB1F000C4;
	Sun, 22 Nov 2026 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795387576;
	bh=+bVpBXbONfLW2veEvY5MyXOg1V+Z2ij8/G5tQ2lFqlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VLVqH1ZH1OMuu3ddPTjFASULkRW473RSQLjmft+1igBODw1KwWF8Ve1Hd7BZ9hajr
	 5a73x/bjJJd/ZUSKzxft/XCpA9xcEs4c44IQ6pMZOh99S0P+UWM5s1sLuPfy+k2Tnh
	 bftum1lgzECqPkUwlRqOXOYToBI2MQ3L4r70IL0R/GNAyfaVNo7HaVkZES48QqHqNt
	 JpxUOFT+Xcb3B/Z7UwjUo7LqFgPaWPMBNZT93oG8zVuGGOZsF4IvkPpdIHeO3//HT/
	 kpD1dPp5gEjeL7TBLO4wUpbyFRUV1obf1Isr6BBkTvY6zr825h67erpCfVwJ9tmMp3
	 tWvkVdnPJNEFA==
Message-ID: <sashiko-outbox-228415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mm-hotfixes-unstable] mm/damon/core: cleanup
 damos->walk_completed in damos_walk_cancel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261122224054.79767-1-sj@kernel.org>
References: <20261122224054.79767-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 22:46:15 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS walk could be unexpectedly only partially performed.  It can
> happen when there are multiple schemes and the walk is requested after
> the previous walk is canceled.
>=20
> The expectation of DAMOS walk for a setup that has multiple schemes is
> that it will walk for one snapshot for all schemes.  To know if the walk
> for the one snapshot of a given scheme is done, each damos struct has
> the walk_completed field.  It is set when the walk for the given scheme
> is completed.  The walk skips schemes having the field set.  It is reset
> for all schemes when all the schemes get it set.
>=20
> damos_walk_cancel() cancels all existing walks.  But it does not reset
> the walk_completed field.  damos_walk_cancel() can be called at any
> kdamond loop iteration.  For example, due to DAMON context pause or
> DAMOS watermarks-caused deactivation.  It means that the function can be
> [ ... ]
>=20
> Closes: https://sashiko.dev/#/bug/linux-228a4c52-0545-4c1f-90ce-41114d827=
2e9
> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122224054.7976=
7-1-sj@kernel.org?part=3D1
