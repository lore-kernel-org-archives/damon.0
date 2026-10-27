Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110221;
	b=emzx1NZCB/K3dnFhKzbDxJ2l4dyRB/cLGntv0BZG5FgSyWDorvRhQQ8irM+GHCwadhAw
	 8o0RZaAQqLI5JGrDSgT+8QnMsPMgQwahEDedr2Tnf14ubjMP1bVVwfgpKM3PeA3bJvxHy
	 gSvP9YWLDyhNZlerEoVKT1QhF3C3hzWyI6UNZd3w8U3gifks+p/aryVqQLCtBZtHNrV/Y
	 kJ4ovV9FppSVRwAc25J7GzXCNWrtdyTqPXlH0o0WorTX8WjIP40fnTAHz58ND91QwWhVF
	 ysXA8SjSqKBkpjhaYq/Yir26tIqJE7lLhKmJwrdMw4x2KM5+Y8i3kO8FiERTMTaafIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c6FGhj7emcMUIM/lLEFE/4RVAnAWbol2bu4PplRrWAI=;
	b=2g4s+jYtRdGjdT21Dzt86KctNp9hevIJj/wsDxGrqBdAttHNwuRxXLSe/LPouPoQ4dVm
	 mM3geoKSYmNccsIulAuXWpJy8LPV4Y2ypzxam/w/aSyq6woZ9u0FJ0uGxXECQU4WH5Xo5
	 q6Tjak2/hlO3dsUoWguptSUQZtCCgbuYlo0n8ADBEWokcAsk90yOTEXgtWvBMpbSYq03x
	 1vSCUmMkVgxyQPGZGlUX5upxkY9zuHJsvMmr1MkndD4k0qu9SCcdRTJE9ZQ9kBrDpWaox
	 xoShpgX60n/mR4kL1FhBtvRqFFv4Z2xGaYwzXSigSna/UYkw72jah/VKlbr8tUsaLNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwOkqJPd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12074606A31D
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwOkqJPd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7706A1F01825;
	Tue, 27 Oct 2026 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110220;
	bh=c6FGhj7emcMUIM/lLEFE/4RVAnAWbol2bu4PplRrWAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwOkqJPdX7q9L63BX/dfb0eKBrQ0uxh5joUTfOd2tY9O13RFlYSF7AaYfynaiU06g
	 B/n/aXH0FZGgXfA5gkmDSll862CnHPbdYce4Lp2mQRf4jCphqMyfHgHsN2FuogI52u
	 JmN13r45hhwjQwUsb1GgtVoaJMLG7r+UdnaYlgWNSf3ZP3R+czxXsvJfz7AaJ5BkGt
	 +yTbfJqHnn8PQuxGjhHPG722u1z0m6jiC2r0LLGDZ9rm8ex97qK53SgUQ0qQNtVG93
	 UhyzAYAClGkJK6mHr4BXBlQROxQsxZBNaTkAmAEgSxTT9bfJbRthsGuFUiW9O2fe61
	 8tSTf9CeE/ALA==
Message-ID: <sashiko-outbox-186707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] mm/damon/core: avoid overflows in monitoring
 results calculations
Reply-To: sashiko-reviews@lists.linux.dev
To: "DaeMyung Kang" <charsyam@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261027135932.2301646-3-charsyam@gmail.com>
References: <20261027135932.2301646-1-charsyam@gmail.com>
 <20261027135932.2301646-3-charsyam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:10:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When monitoring intervals change, DAMON converts region ages and sample
> counts for the new intervals.  The conversions overflow before division:
>=20
> - damon_age_for_new_attrs() multiplies the age by the old aggregation
>   interval in unsigned long.  On 32-bit kernels, the default 100 ms
>   interval makes this overflow after about 72 minutes.
> - The sample ratio conversions multiply unsigned int values.  They can
>   overflow on every architecture when an aggregation has more than
>   429,496 samples, such as a 1 ms sample interval and a 430 second
>   aggregation interval.
>=20
> The moving sums also use mult_frac() for the fraction of an aggregation
> window that remains and for the previous window's contribution.  On
> 32-bit kernels, both can overflow with long aggregation intervals.  For
> example, 500,000 remaining samples of a 600,000-sample window are
> [ ... ]
>=20
> Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new mo=
nitoring attributes")
> Fixes: 9f3786d8602f ("mm/damon/core: introduce damon_nr_accesses_mvsum()")
> Fixes: 2ec26dd341d1 ("mm/damon/core: introduce damon_probe_hits_mvsum()")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027135932.2301=
646-1-charsyam@gmail.com?part=3D2

