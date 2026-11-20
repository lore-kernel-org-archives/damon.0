Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199237;
	b=eZzo/fMHbCkw5UDUXXUzmlSitw6NxG/nX3mWLrDeb/J+Uy/p4IUvyuWckLTUnhIMEsRl
	 afv/oPbT6b9IPpo/huxEWr41+c2Knbwox1J3FmppEfF82vn7EPzkyWE2iY3PMb6JGpRlz
	 OtVdIjHnLGyQ6JmClwNJ4JNqqJ/leHRQolY02GrwpPuKCWK+wLoB74AO04pxjqlv0YZo/
	 UFyhd6lmplKhAiDHUsJVxuLVTEU6APeJ7YP7h4zQgpbq6PJJYLzLgMd4zvqD20lGyCoD6
	 +5pM7op+PRnRr1AXMAPLCXhUZB4u8J60Xb8S78PpFjQ7SOc6bbrVUfUDoF3VAF40wug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199237;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lEYUqK4so9017tXTqH0DSYWLwTuKrPovNfGMCNPaFuQ=;
	b=wMTLvNV1OtNGRxdJ3jc4eiukoAF1DCKdBYe5NnO23cZDdPYskjzyzELVY1sZa4o7f/gu
	 VrsYojPMyDlyGd+fPZDX1VD/QNXTanpZe7TWETC0K/gYrRzuVA7jhxSb8K1P3qDqhVC6G
	 ZTfu7qNfQoBoGb6aPb1zWmmu1XiTbj4FE4AGe8W/FLy6aUAH4fXq7ESlhKc5jnkpiFdwf
	 mIxrRf7ro99pD4rSdRieggzSdkCMQHpvqC8HfHrl8ADJIRs/wBL6KZ3YihdrCXhVXiU+w
	 R8tuVDKkz5XDJ6kUpH059FPxOCDsGK5RcScp2zse4gBEPB0cn1rkgpS82OFZ9B3qLKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbGailcV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D807606A332
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbGailcV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97801F000C4;
	Fri, 20 Nov 2026 18:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199237;
	bh=lEYUqK4so9017tXTqH0DSYWLwTuKrPovNfGMCNPaFuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NbGailcVRn0eHmh85WEZN/7gPJ/4YF7DodjyrtIVCOTA4kB5Gjcnz3xXnEIaKUqff
	 JzKcWPUoKQ5FQCCo+ekbHKqNIxkuPFfTSKc/KerzfllpeSEdXhNLkZJKReEXrztPVO
	 qx6k7BlTAdVeWrVL6A5d0BeksEYimjjTdeSPi0ht/AYRQY6yF9tEU8TkfcrRuJjATD
	 tNWVH7JnjOgB3J0tKd31c4do+bflV3YGnVXdyo2sfwLSrCUxveUrITi944cFXXzpWc
	 Vii567qmM7z+gNklAad3eE06Il0x7+KMkEMWNDiGoB5lByPxdlujQ/O2CsFRrWuEyU
	 yYHle7XMHilfQ==
Message-ID: <sashiko-outbox-225827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/60] mm/page_alloc: build zonelists from common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-4-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-4-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:27:16 +0000
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
> Zonelists decide which nodes an allocation can reach.
>=20
> The fallback lists hold every node in N_MEMORY, and a node's
> __GFP_THISNODE list holds its own zones whatever the node's state.
>=20
> Ordinary allocations should reach only common (general purpose) memory.
>=20
> Build the fallback zonelists from N_MEMORY_COMMON, and __GFP_THISNODE
> zonelists only for a common node.
>=20
> The build_local_zonelist() refactor lets us reuse the code to build
> a local-only zonelist for nodes outside the N_MEMORY_COMMON set later.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D4

