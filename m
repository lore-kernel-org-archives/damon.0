Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632236;
	b=Wa1DXvge/xhjEP9m5sDMB+rmN1cG725jMQarw0Og8lCl3Tpj3R5Sa1CyzetEA4kKOtXZ
	 uz4os/dCXKkCJZK5OP0mPBz4vCaoX5QIhgyxQ9mGEYKI7dNOh/3G4ES+/u4TlE+Yyl9Dq
	 6V1ehmqGGeCzuIvIqqg+ZoGGwbEP0LcAFI5a1SWYacl0fGXfXQVUgT/jtj+K9hO9N0zzt
	 97tG58DS9rvzsW9z4XxVH6ywYvIZ0iCLSF/0VlVOT3IuKjyEdAunJzPxu0APZ7zh6yOza
	 7cHujYxO6JTFInBL3k3k9kY54zfvlpcpJoVfRpf5Zj9R7FSV4N+bM3+intJ6KfIbtbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RxlhBq6qsMYFK2TteCy+GaCR8fORPJrcSM48P+L1Xh4=;
	b=E/TosWpxQYFB5o4kwK0VFsTfV2ITjvJAUAmN5C9JKAQ7NP5JuV07qMKfaTtgSTfGIb4W
	 XZv/gAyqvmXaSCpctqMkUVSK7SD9n6j/b03nuLQuFJpB5Nide2tdPa10bjXBtAG2hE8yk
	 dDFHiS8DUsbPiN7y7vCEs6UGCDPAwzaLHCBey8bVWtgRl8cn3rEBnD3Rj5wl+8/bjf9W6
	 JX+i1gxpm085wDDjuYZO2avMvVziEVXfuksa3kmU1Z8gV9NTjYnpRUCnN3pCQiweO2nuZ
	 K0HQgJ2j8WB9tSZ9jKbNRNChhJlM6IazlHWYZsRBDEAs57rdjR5edpf77R8mgIpCAlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RC7lW4BJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9937607365A
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RC7lW4BJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83F01F00A1F;
	Mon,  2 Nov 2026 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632235;
	bh=RxlhBq6qsMYFK2TteCy+GaCR8fORPJrcSM48P+L1Xh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RC7lW4BJ3SWzo8wLWymjXrkTguesE5AE65uZtVQPru0AnopDvutQ17lK3MJjfSrCW
	 CxMMaa8zOTUQnJkkfIPjK2IacFRLxS/GrfANiwGtUJOwaxgQqaqfv9Nw7u+GtkuZjB
	 psymvS5UARRMASFMlqCYNKoRF9ucaA9N4+zisZUpQrDnSDNm2iVmnnVBDGot/SwcbR
	 EqOZP+cWXsyNmBEwJ4p06vp7qiFmZ1gHU/aatZHcRUBvhWJ4C/e/gk4o+qdDdo0fi5
	 gLwrsffBLPlPmzQxzD4BrIpRx/lG34t8sxeWx1Xe96OhxRcqnINsrHWqLcRLRqdZcA
	 cjcFIFZvaStcg==
Message-ID: <sashiko-outbox-193637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] mm/damon/core: remove unnecessary
 zero-initialization in damon_new_ctx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-2-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:10:35 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
>=20
> damon_new_ctx() allocates the context structure using kzalloc(),
> which already initializes all fields to zero.
>=20
> The explicit initialization of passed_sample_intervals,
> next_aggregation_sis, and next_ops_update_sis is therefore redundant.
> In addition, they are later initialized by kdamond_init_ctx() before use.
>=20
> Remove the unnecessary assignments to simplify the code.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D1

