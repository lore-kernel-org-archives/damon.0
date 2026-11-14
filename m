Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640519;
	b=ctbd5zYo2h96HA8ZVCPYPbjhaZd6/gOmZ8Xua+ONipQbTdwKxVN0RGgpqI/ig7MopKG5
	 rtMrYyc8viuYGBvb8AyR78j8KzZfqfndyIdhIXUZ9H9ZG6MlF0ws6PPP/+0fZwQJXcjop
	 BFnca4mdYlWXQPgMiIojPruOK5Ys7r41B+yOcOCPQC1q9ig7kHkkubHXNSnXQH81WKxNZ
	 8uGnd4DR2In5m7hdaYCmGkWat2UfYBkWnA3WAg9m5HTahKziWKI+JeYFDc70XjCDuE9gP
	 DuuTh/7DPBBcLYIiIvvs31XveGGUcfFBysZWEdrJLKDeBAEW9fk433HVvV7SpUzhNWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640519;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CR6fPytoB4crjrCevk1enNbYhHiXI9eyKv0iNH8bhVE=;
	b=zSkNQOQPDzsCg3HJFjhVvZBlTiRh53MOOha9uPljJbIiRi2S9IUuWU+NX5sJceyCoBZS
	 9dh3VDgdnkafP+Ayg/sWUs/J5jPtK7IYt5VcqIyxifpvvtM3WxWa7QryfTF4AIkwfVF5o
	 u8CO9AdtcY3+XXmVsNjtqsm1gqWqulKwnXoCT8jojMs7zPhUMV9gG4xJckKu/Pyj/Sf0l
	 rm6x8KyGJcn51FIpERFmxWZgFFe75V5q3HvWjEaMGVlkb49p3/XMhOUtYMB3jasqrfeGC
	 Fjsr+ICmvhrD9XcF2owJ0RJ/qdl5eqHL9dQED950+P0C+fLoxzRpoU4JVu44PA7z2Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MHmz8/6b";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB1606A327;
	Sat, 14 Nov 2026 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHmz8/6b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6CF1F000C4;
	Sat, 14 Nov 2026 07:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640518;
	bh=CR6fPytoB4crjrCevk1enNbYhHiXI9eyKv0iNH8bhVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHmz8/6bxVUQt/OaK1XXRge/qwpSdvQEmZlGOpeVZ+0zpGW/pu+eQfR0VIjcHYle1
	 ETTPsjrBzfrrdpcxKAdqGCv1V397VAR0Y5NI3nhnhjzw0ayye+OyfU+hup2oiEb2oh
	 74A3buHbK2P6UTsHXz2mUm5UUgEpHIFzjyFZivGxKsysA9L29MhkhQIQSQ+7JO1jM6
	 9OLwB1qu5A2UtDL0RCPE+68WIFvQx1cDoRS2w8Ufx1wb0K3302cH/w+tp9K4yBjr5T
	 +k1qCtxegvgQxiTA4uihO/ilz7q3g4D0WXOmoBIg30TKw/Hs9sgMvK85uBXd69PBfP
	 XH9tsC8cxqsLA==
Message-ID: <sashiko-outbox-214242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/22] mm: base hash distribution on common memory nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-7-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-7-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:15:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> hashdist is useful when large kernel hash tables can be allocated across
> multiple NUMA nodes. The tables come from ordinary allocations, which
> only N_MEMORY_COMMON nodes serve.
>=20
> Count N_MEMORY_COMMON nodes when applying the single-node optimization.
>=20
> All memory is common as of now, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D6

