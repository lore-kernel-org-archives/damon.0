Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198814;
	b=op5yNQtuzZvLJXSmLVOBvDiv733/I28FKwvT50RowhHJTJX7OJRw9+B4rB536FcPeEuF
	 7uhR05hC+zxZHtwHc8NwBS74xn6oRV6iB5hWcyVfrqRCDZx5xeGk7pmEQXVGwaqHNCLBQ
	 pyY89JnJH+tnK1TVOW4W+RN5DSQVqqSEQkQr9hZLnyf/8PVL9WJGrLKd9SZmv2oiWzmZu
	 4yAruRmHbUvNBEpS5bA6lNPIRkb8vEs4UDNFVTQQDuqDrpiSTzxZmQM9+4kbrX+1fqFe5
	 XaviFKCFTW8sf/zzWpelxBimXKJqFT1QtGy1QJHpTB8iEBYFlYA1QKw/nD29yRcJqBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ky0NYXMZOATiH2w+0f4pjJgkXGiJ7Ex313KWQkW2+t8=;
	b=ysF0k9atyg45RA30LUg/qtFMzpYQLH59/84r2aBWKPHkPNqyfN/UYy9zNBtrMbGh57DW
	 Gv3Q7RCSJSsWjFTIcEyDv1SCe3qZQj7807OfVP6L1P+3W3x83aQ62YpZGj4gVEcUbhoNz
	 CGW/J2lb3vo6eGZphjY8NlPa9e100TldxFj9qMSq8port0kLgdNvu4vDUlVblxGXteAjz
	 xi994JrvdkbLkJjPZsJaRmbf8d7wpenTHrYhtqsK425jgS51KZfrpR0Lxhm5kVAgIjWY2
	 MRlek200lANTyj5phFleh1MaPNUirLqdBe1+oq6e/9rjGQhJXEoPieEeWUaDDg+9Z2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P60gRHWj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DA606A8AB
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P60gRHWj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772241F000D8;
	Fri, 20 Nov 2026 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198813;
	bh=Ky0NYXMZOATiH2w+0f4pjJgkXGiJ7Ex313KWQkW2+t8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P60gRHWjjt8ThwlE+qNua8MQULCM+mMLiYmj9P5GaRy/d1qxEQK1ICRZSe47596s2
	 9PDwHt5XbPYxadlnBZAhKSqTSO7w3WaB/SFb7CU6BoOtiAN+vjSR7vKYqqWsPKyeGU
	 Tc4UlZliQrpKPaRVn9qoN9RwUIEwcsu8k8fSVu/D2isW8r5JhLOml43Bae7skJZbK2
	 A3sU8eROaJ9jN+XCXpe6LbanqDOgS4vr9nhaJQedQICxUDCahHyA0S/cMFTx5UlpKB
	 1g1FJBJPVFEyqr4BrNO1ELqAyCgRjkgpJhjbjWUMz3jhZ4vSQIikGMeuQ8vy5sjuDI
	 mFud2kFOsla4g==
Message-ID: <sashiko-outbox-225801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/60] mm/ksm: restrict merging to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-20-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-20-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:13 +0000
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
> KSM is an opportunistic MM service and should leave memory outside
> the ordinary memory pool alone - as it already does for ZONE_DEVICE
> folios where its scan picks up candidate pages.
>=20
> Use folio_is_common_memory() at those same sites, which still rejects
> ZONE_DEVICE folios.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D20

