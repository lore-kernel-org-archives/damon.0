Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230621;
	b=xO1TF6sr8yH3v/W6Uwo2JXaGgYRQcgeVFOzLowmGt2MX3XKiH9dXkeFJrl1g0B2Yn5ww
	 bHs9g1XYE74QDFtvxvARjJz7PlQwwE1x5cla9xv8qzZDlJTyvcLi8utzEPd+e/SKVuw2r
	 7HtRJvdJCjEFict3V6cTVPIfQveID9XKZn/UrnQ8CK/1wPpo3J3OZc7CdD152slcMedTp
	 H3HaG1ywUb/UPrvxdZHrD//I1Pc2wksXZ2sthoED05Nd3BMsZPUWsmYmjwSu8E4lat8u7
	 ilA5hGU7GI2YS0E31WlxanBuSz/ogFlPnZ1Z2loKf/PuNo4j/R/7zBmXi0NrPYx6/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230621;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cjSO02t3zAWzdYyGRrS23QitgV6ft8P4BIay6Jwu4jU=;
	b=gGmC/VyTIX7sJQWHdboKYjKcWqD7dS+MZJnmAWxwg2QIi5vVWsLi/lhdyrd/LuxzyyDO
	 YvVLc0rBmoEOsku4vV5lJxklr0v7BKBYmLQg15xKf0yFL7NS6iYZ83xdVSRC507RIW3vl
	 Bti/SAliBSVkq8Md1RhpHBisQ5juG4Dax0BS7GWrkujlKrK+Gf+9uwZur5Wdan68+vXmv
	 NJQdwpfvQEsV61VBV9KI5te/eOL8vI7fytO/Jq9Mgy0auMumMnhwNqVKzuW+Y+LVHhOFs
	 HLBb5cA0Id7HRXiccF/pu5YAXiSebYzdE4mMyiCBxavkx378nlUN49+VeszO3KQUF1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eK/rqZSr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1C606A6A9
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eK/rqZSr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146D61F000C0;
	Sat, 21 Nov 2026 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230621;
	bh=cjSO02t3zAWzdYyGRrS23QitgV6ft8P4BIay6Jwu4jU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eK/rqZSrTlLmE73rB0S8M+Wf16ZQTVA5vsCwrxY3286vwAD5XpdpbWRwwqPS+yaku
	 G4IB3jK+tKq7hTU6FLbYC5VETjjigBuywGwLlCqD24X10KclJy9PPBnedgurO1U+pR
	 zB3Pnlq0T/JUzdS+bwpc/ns67jDWLrAnWlqZhgGQiJMFFBNdPGApfVJRy9eGMMMYEV
	 zr9aTAlumT75dBhPd5RTSFPBaMGcnxdiekosIWB8IABuxu2XRUk1vKehYOWVIvE90w
	 XVA4MfF1+LL9Rg/esrkuKnUT9zYFTly5ifcTM5UgPGnhohvj3Zo5sdMv4TpLjav8Ng
	 IT59lSU/w3y8w==
Message-ID: <sashiko-outbox-226559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/core: fix damos_walk() hang with zero
 watermarks interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Feng" <evanfengff@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261121025626.75981-1-evanfengff@gmail.com>
References: <20261121025626.75981-1-evanfengff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:10:20 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_wait_activation() cancels damos_walk() requests while all
> schemes are deactivated by their watermarks.  But it returns without
> waiting when the watermarks check interval of a deactivated scheme is
> zero, which is the default of the DAMON sysfs interface.  The kdamond
> main loop then runs with all schemes deactivated.
>=20
> In that state, kdamond_apply_schemes() finds no scheme to apply and
> returns before it calls damos_walk_complete().  The walk request is
> neither completed nor cancelled, so damos_walk() waits until the
> watermarks activate a scheme again, possibly forever.
>=20
> For example, with a scheme that has the free_mem_rate metric, zero
> interval_us and a high watermark below the current free memory rate,
> writing update_schemes_tried_regions to the kdamond state file never
> returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
> other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.
>=20
> Cancel the walk request in kdamond_apply_schemes() when no scheme is
> activated, as kdamond_wait_activation() does for a non-zero interval.
>=20
> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Suggested-by: SJ Park <sj@kernel.org>
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025626.7598=
1-1-evanfengff@gmail.com?part=3D1
