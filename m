Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640681;
	b=dreItrk+oewYdHQAqUA2yTDQKjL6k2lfT2RQj9qhvQ7tK/90jNbi8iE+ChW7zGsKicZ/
	 RQpoCAyp9C8ZDVfmwRu/ZiidXwCIpXOTZHkpyGOrWojNn8h1VBx8MirovxfL6h7kEzbMm
	 ysHHfUOThgJ9HgUqQtHyWL6bksRwndyzRv5NPrvh9UzRwHekOwzafOjvxDLBERMoyBphP
	 YrLF+0SKPrJ4VyRg/Iu3/FPfllg+5poy4V5a9ZDUvWgRQjvMtVdsoDv+QUrLtil8S5EZf
	 HCUpbEug3eXCS8z10KLvdCsjTJARNefy4Te4P4hF9d8V9By02NTFFfWip5BSNOtuZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640681;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j9dEU1a32rPqG8zOkVXJmFaL1Z5EEmucqHL3KaJK9fQ=;
	b=Wv+uLt6+ldMOLSK8PsIa425Zt8/cwU58jaaFK1fwd1TGi5MjbkO8QL0YfEl6yokH2BBU
	 dwzhMvFv+xevatyZW9UG81DOl2Ychmq77DXsXRQ99ff5+26jt/90W7kV6xj+ZuPpJKffg
	 5nvR9fD6+7cP4GClxkRzk21iGVZBpkcZvGsidDYGgJzRd+knMtut+dSMqx8CF4GMPktyl
	 SRuShiGKKKk+VN1zrWWZywF/DxGZHQyVQCC3YiYjPxbM8X1djSII/dAYxPwcD7K+CwJ83
	 AvJANtvWoolQ4hU+U4+M1OPzu3U5iUymhtXBzhct1l6a4lybY6LIsu6Y6cLpUHt3D3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuC3DArO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F7606A323;
	Sat, 14 Nov 2026 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuC3DArO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB901F000C4;
	Sat, 14 Nov 2026 07:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640680;
	bh=j9dEU1a32rPqG8zOkVXJmFaL1Z5EEmucqHL3KaJK9fQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YuC3DArOD6i9lwDiSO5yuD/wt7gnH76wKn0+Qezcd/LDskM1OjTgyj4kpLQKrun0m
	 TGCUDntPwHYFf5/JTLAAcsBE98MRKYLz+ZVfqoBszJmpdpDIClj2mfSIJ3J/o2FwuA
	 hjcEH7/RaSegaL3i232+weg3Lw/sNJF9pn/7xHmamR4RIwatQd8QjK8iNFDkrd/GXB
	 GpVGYJ6ewd2EvnD0UB4Aosgro+qO0Tp85+YkyszWf1ejmrVO6iWHRRGxy4XQf5Xy/Y
	 uqfbjJRU4HVxlkHu+EYe91bmWjZRzGX6ak8XXyOBLt1z4Crh96UdQJlqfq5rkSC00T
	 xn62fce/T6Bwg==
Message-ID: <sashiko-outbox-214249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/22] mm/hugetlb: restrict pool growth to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-14-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-14-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:18:00 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Fresh HugeTLB pool folios come from ordinary allocations, which only
> N_MEMORY_COMMON nodes serve.
>=20
> Restrict HugeTLB allocations and pool-growth to N_MEMORY_COMMON nodes.
>=20
> Keep the original allowed mask for pool shrinking and demotion so
> existing pool folios can still be found on any online-memory node.
>=20
> The result of this change is that hugepage allocations will fail on
> nodes without N_MEMORY_COMMON.  This restriction can be loosened later
> when/if it grows a user.
>=20
> All memory is common at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D13

