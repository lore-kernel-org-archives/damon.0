Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199063;
	b=0wEt88T1NfZ6CEmcuFYdY60sTFcmSs7n1/cpYlq9TkkI7Y5Ia6rHQI62NfFGoID8HvUU
	 v/EJiPZtyMoBMNgpk23JWHpmZQ/eOWlkrG98ov4WWiyHwcOZx0PyX1z1Dkr8ZED8w+pKu
	 toD0UVBY8O6qiGY4piVWppb6Dvfm8x9999ANwdOLOKajLOUsGzfy+l4AhYA7hZ7CH3Ioh
	 vj6Xgi0SMR4mfm/Hq0KiOb7Dl82XcXrt+aH562MRwLjPa+6Lt4LZJi6ttrazAWW2lTKU3
	 ddJIKQZ0KtZdniAK1Pb/zB5KJlG1C+zDmTLuGqNyXPJ/MN/Y6xPaJ/nyiugy8t2AcFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qT5cYFlOEsEnjmbRh7GtLw9Ckfdiis0oyRdFiU4g6B4=;
	b=r8ngZjePTHVLMNjwsiONNMAkqTTsiI5UU4n8Z1ciyLf22EP5R4TYG0M5MvoBH5TLNo7i
	 f3tCklDxxINzHsWR5R9LpxHX00y0VZ804CxWgCLPam16keRw28aBEUJLj9pikml5W4WpP
	 DAdX4HTfIrwDdFYKvb6y8GH4Iz2hieHsgZKNLYkFbpct37VMcBpgq36bCq0B0VL8KMiZe
	 N6pNXIjuVPjpKIVNUe6OrLor2kvxXD+oPyipGfy94hBJp74SO/y9fz9/vZgp4qMcTCMME
	 n4+QP9EfXUYLU44j+NPrqcp9Mj3baMT+UB+uv1vzrCbKeTGRCpBeJCG4H+6/K22SQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS13duBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663B606A325
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dS13duBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DF61F000D1;
	Fri, 20 Nov 2026 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199062;
	bh=qT5cYFlOEsEnjmbRh7GtLw9Ckfdiis0oyRdFiU4g6B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dS13duBBa1fb0wrFsgg2e3VvtGfbpe6G8fYnqjwag9S9ain4g1eBXk5Gx/w1Wh+v9
	 fsyzQvMjOXfq+FLDlftjgdxyuBfMwWiY27AsL07o32uDdY7PpZ5D7rsHJo53aNF+m4
	 388Zk8wvLiKIO+OkpOvldZfp8gfKqYO+JU9OalE0GfqNo0Ypcya8+Dgjyde1ok41j0
	 ej+wMvQ4zj+FYaLwTzyzRNyEMYpnKD65C3JNrlvgnQ1p79tCZ6Ph5aNHgzUnA+/nfP
	 CNUN9PPwPMcQTEYHQkz3Un+MJXvryI783kSo5GAToq4+WUrvTGoZcQ2nKBqGPpeVQl
	 Lry2cztXyoolA==
Message-ID: <sashiko-outbox-225820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 36/60] mm: refuse explicit reclaim and compaction of
 private nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-36-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-36-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:24:22 +0000
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
> kswapd and kcompactd do not run on private nodes, but nodeN/reclaim and
> nodeN/compact name a node directly. Reject them for a private node with
> -EOPNOTSUPP.
>=20
> Memoryless nodes keep accepting the requests.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D36

