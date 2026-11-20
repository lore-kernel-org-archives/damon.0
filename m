Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199433;
	b=0WnUMBGgcj+aDy4K3b7fd4nF5boKW4LkqQ/A0u31NOgUXKiUEUZPwio+FRjuXfqxAVx1
	 QcrzM+k12C9HxYaJ6ZBQAzvyVmSVZpbyQIVWD/HwmKuX1n370oQnXgjpWhBh+YDnU+Gb/
	 JuqIQt0KsHN/HsTf5Ji4SCnFzebOAXL1sedz1MwdZvBqMn0r9SLWTmQmvGr7OnYLnhqGz
	 71HMIbAzUxkxVjgvcnBO9R9aK2ym4KYz+jLuUYPSUvbOHz0y4JWjztzy7uvpIbqe8XCvp
	 Cyf8u8YFRdGamImbHAM1kRHg5f3lvumgR4b5mXzoKLxhHgRlO41VfGvvigQLB+x7R4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199433;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bsXZtXBajwdNkKKQ7Dljpwhq/Oiyc13pMFWXhJftEkY=;
	b=v5ECyAewsf/dD1dXEN8iYfwB2hEUBywWbmIv5jFBn4yjciScP3B0WRpQHTBRA6AQi6lu
	 JwzSJYrKoppH3ffeCaMsaGoR1fHM8NaeDqvmz1AM0Qn/gWHakrgxv3Rh/tIN9KMKlQ9IM
	 /WawproM1pEkKqXteygkU8YdaotHIYXW2OgVigGgwoMk8lYOXkkPO9KhC2GhfvLhkMIAu
	 LhvU7zNXWi9g8OPbk9TcweVi6Tz5YkNr7n6vEXrcOLLAM7cah/DoDMCulImju/4ne5FHb
	 JppsUmk1YKe68kru4hZBwXCR3/f5B4U35kfrGkz7M6Idp1tTU+Bu4R14e7QtMfn5NRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llqNehU8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586C1606A32C
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llqNehU8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE391F000D0;
	Fri, 20 Nov 2026 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199432;
	bh=bsXZtXBajwdNkKKQ7Dljpwhq/Oiyc13pMFWXhJftEkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llqNehU8F24y5ZmRMioftZF+voxWibl6ViVIKDj2gBN5CFQbR8wsOms/QCyqyCESP
	 MzRYp8kvN5j1cC+oyTxExbSevB/90VaMwwmZnaf63uQMFLKVahamcD/Om9IMNKnWP8
	 K3qvNuEwt7zTVqx6Lnu7Ku+0wNJXvvxRjUv90xDxCZYMZTMsmsr80HkBCM5prYf8zK
	 KvBQUeEWGEoNFi654/+UtrdzkadzEP0mMHqwkncrxw1EpFxDw6R0OxzVYfGOPU4HhU
	 gjMN0NqDdnqhq4JaRlsPvCRDUmOn722bYXYCbIqj0nrBV1+rH1fK2BYpu4Vd7p844B
	 rRwP291OtFiWA==
Message-ID: <sashiko-outbox-225831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 45/60] mm/compaction: restrict compaction to
 N_MEMORY_COMPACTION
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-45-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-45-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:30:31 +0000
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
> Restrict compaction to N_MEMORY_COMPACTION instead of common memory:
>   - compact N_MEMORY_COMPACTION nodes for /proc/sys/vm/compact_memory.
>   - start kcompactd and trigger proactive compaction on those nodes.
>=20
> Direct compaction is unchanged: an allocation compacts the zones on its
> zonelist, and a private node's zones are only on its private zonelist.
>=20
> nodeN/compact fails with -EOPNOTSUPP for private nodes without the
> state.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D45

