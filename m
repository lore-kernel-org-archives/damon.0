Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198904;
	b=4owJQqZDNm58PTY3HG4UikWy57fj9FrrPaw/YHPImK0pivcuX/BSm05Qf8P7EwTXILJe
	 0wxlSeynZJi5MBByD6yFiYP7WDxk52FSk5fpvAk3h6qFVbcavaGuHE0IrH5xvRBmSvtQs
	 5qRdDJrgo1cF8iYcQERcVZaHqLuyOalM3nmoL2YiuajeqV+iks24DqNAqDVMSPKi8MSJH
	 oNIUbJMWixvkKFkNWwOwhyFL68KWdGg5NRnhSFj/IANh4c/id0UiRxAsTWskm0v5o/7As
	 pXfo6GESwlPvQ15GqSb6+UEVHQ9DAENGE1W0nCL6DxHiD/u+09jjPLtitsySVSlKAFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z4TDWPOEdMymY+WHLYWuo5Ay1z6Os0ii2hK21+Xis/c=;
	b=0RHHoUkdZP87078ZoV3YHQrUFZbw1R9t7bnhPqsmJDfJMqw+bK3+o1ui3TdINiy64ttx
	 jjg7Vr3B+UFm0o5zrB2Ncgoe7oIk6FVZx++TDdRDQA08JbVnV9ikPDdFNutCe1N1WsQqH
	 jGUYLHUIFxDro84JDlcVa7YKZVokT4ZbTTi9Ptb4sBtjfoY3CVUzrk7HVgRdfRgxv8gO4
	 hMV3rt4iqt4iR85yuQ0/SgXusP2f5qld9go8OpbUyqj+pbGxptt33x+ib4qeXRVR8Czsa
	 6nisOsK9bX9tVeAxTLRcoKDuVdeV3weAU0WxJjjhPWMZpsyXfJe1R96XVclqjFdkveA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZK4AvZx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE60606A8AA
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZK4AvZx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3941F01568;
	Fri, 20 Nov 2026 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198904;
	bh=Z4TDWPOEdMymY+WHLYWuo5Ay1z6Os0ii2hK21+Xis/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZK4AvZxJc+qOrFOD7/9j3/mpGoyCTNja4ta01LEgnJYv5M67CPvPJ5gt1RCo13iy
	 PcOBfjwJB/r6niMbZQ1qJInoaP2yEjSjQdtBR97+uLOXwXcpLsETNv4sdMheoVX1yj
	 T9kZPuVnalT0xYdLZ8pD7ARGkyU810PvSQgNTaflvssReQ7gHSb+m6hYkZjP0I/nMR
	 QpIeWUgfYey3bJZO1o/BrwtbE4DIWDI1j/OW2SDxOjrDu9jUXxiz7ZJksig5QVkWhT
	 ywBuHCJYMK+tzVtJkrNi1BqM+B6FVE9lMmuvvqXiK6iy5AuJjoT/RWrfUTSwE09y1x
	 sHUWQ4W5BBztg==
Message-ID: <sashiko-outbox-225812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/60] mm/mempolicy: don't NUMA-hint folios outside
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-22-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-22-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:43 +0000
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
> The NUMA balancing scanner installs PROT_NONE only on folios that
> balancing may migrate.
>=20
> folio_can_map_prot_numa() already skips ZONE_DEVICE folios. Skip folios
> outside the common memory pool (N_MEMORY_COMMON) as well. Do not inject
> hint faults on those folios or migrate them.
>=20
> Convert the zone_device check to a common memory check (which includes
> the zone device check explicitly).
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D22

