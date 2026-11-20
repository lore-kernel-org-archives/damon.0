Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198768;
	b=1rMv60sk3DypUoUKJ0aRtxtp5x1Z0NEqy3uISjbLi9sSGtF7nKC2nS2umxamQSlpgKeV
	 7/35ZrDqlJOVqM0fR8U7vjZJVZ0Zg9KxabyDRWLptY5m/t2VqXkfYiWH78TatDRZV43CE
	 Jy+yvNWzVcKD/5TkB+vLpXVEMggSB2FroQ41kfo8A6LeXzXkFoZatGAlGKrXHJA7W/PhR
	 z4k7ZP8TE1Npj/5fIUJYwXwGYPCCrst+0B7TxJbSWYiLliBIZBlS1BuMpGyhwKJUZJ2Yd
	 NJvw1abdtDuwKmc5EMK9P0J8L8Wqq0ZFnbeuFhhzXw6ZgWmBdJzhePcHmeCN1tnkOig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tgcN1cobELGnahr0gS/Le8lzEnL6yqjlOXQkYyUvOsU=;
	b=pabAWDsFPWj+/z83/YOUW2/kYFm3e8UIvR1ecmp8IITx+tFkTzD3OTYHixAWSR1E+yrV
	 d+toiZZt/43WxpUctUSv9BzvK7L2GZ2Ue8JtZ284RNA5Mvvb5tuwm5ReeQphlMUYf3YWD
	 OL26aFxsS8cXiAyTR1xAr6VNAr/nON3qHWh66KYSdHAVhkcpoLKEiow3STpGmauaNYaxY
	 HCus4gWQL8r45es0j4gn+FRGMBDlQmdr0yitye9zvcza0F/Q0OIwBMkdOnWCd/5e3mfxT
	 w0xB5LTTy700wUKuEPxwI2qrZzvluM7WwSkt3s9dm6E39Oj0VSQFBPs3olsCoiRwl5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvPvjlyp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0A606A8BB
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvPvjlyp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21E01F000D8;
	Fri, 20 Nov 2026 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198767;
	bh=tgcN1cobELGnahr0gS/Le8lzEnL6yqjlOXQkYyUvOsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YvPvjlypRThcw9xegCo8NwIneQRthsTb+i6MqrPFA9xvCYGEwHwLFh00WKKzZWzCG
	 ZlNa16PI/AWvsFd0o2wxLGLRYFq/63HfVr5yS83P1q5OQo85kZt5UP6qX1oiOKYhST
	 jN3kXJOpm4V06t3eQHjlq7LcxdPS0itfUMmDC8G+mSqlslA+jKSLutaOQ8HMHmtGxB
	 teQDMOVVUDo8aTfgn4gSM2qDRzwxy05EFPFB07NLUYPcHChJWvIwmLKcGSTBSUyOba
	 FspJ2+X0odmffnt08PUkh41jNfdNFM+kFQym7KJHDYYTxdRF4ud5er2oMQZsrsGw6a
	 d8IzfDnapmtUA==
Message-ID: <sashiko-outbox-225795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/60] mm: base hash distribution on common memory nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-14-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-14-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:19:27 +0000
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
> hashdist is useful when large kernel hash tables can be allocated across
> multiple NUMA nodes. The tables come from ordinary allocations, which
> only N_MEMORY_COMMON nodes serve.
>=20
> Count N_MEMORY_COMMON nodes when applying the single-node optimization.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D14

