Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199912;
	b=2BDk+6sqyTcDwQ+9ye+/hSj9DpDFVRIQf3C6Fo57cVztfiqRZaSBjnpnmYlRe25ml3T6
	 n15AOjblshpfQDCHS6dcaW51eNQhYHJSXbmNbpc4IokJ9a4MGVhGj9HMGCwVnMj4a64My
	 o6CftdmcxJYtnpcbu3Dzuew/oCHZyZtQYMt5hz0qppXTclus9LG08ovbt+LmBY6LoegJL
	 7Z8mSsPIzAMF2WiXTD9YfJorKT+T+YRyXra72+XorwAE9ap4eyW4jqCTZ3AYM7Kh7Hlcw
	 pWMIJQvqK8v+Z93NERWRsJMDPMJtZJdlAE1TmFKs2joxh184Pr96kfFJaJDqPbmfPFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a1rgYUpE34+tvi3aJJgf/ZGlk3eDsBF/cbFnWFj1EJs=;
	b=r6hVobfGaUhnHLVn/sjHN0PnaXEdO74CBifCRhIpAdCYpJYG/xf/0Imjh03wV6yPDdRj
	 ZSlr34pXYvWEEH9uRSFMfhcZXjP+hWDWwtHWYIPNw9kQ7il0jesT00U6dymLAv/0lsO4H
	 jdlC48CC/Gk9tHhoQU3F6xuFzARl+sGrboOGa3M4HeWME9Ea0wx0/aJt5W+6S+MfHVF0L
	 pGdTAgH9EWKznTgHrI/Y4xdrsyi0OUbOr+qyc3NJIjVZY30klOfQsdvZepAC9ojUEapPi
	 G7pUGbkLeDqxmntOmact6H/3/xHzD4ZKgopbt38G6bMBh6I1iDAQrI6O1/ZzOK7HmCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nME1WlTT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB760A2600
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nME1WlTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C4D1F000C0;
	Fri, 20 Nov 2026 18:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199911;
	bh=a1rgYUpE34+tvi3aJJgf/ZGlk3eDsBF/cbFnWFj1EJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nME1WlTTbkxwCShQ5DXXm7mDWITFv80+EGYzyYt6VSCNqmpdxAwSCprzj+egBBngj
	 y6L+QLcujBw8HMAaTdF8BlEgY2bguoM45JwlUu3IK8120YytLkTFvXBfRUvwfm0IpD
	 AZLKG0PSycKWFJXcztsXR1ofxd61snOmHePxySj589jdiyXHo+2mlG73/zWtl1GTlt
	 Ty3SfHK9JSdaTiNnU3NZTQcI7wUmc89dhb6ktur+zDlblnWjB+E6yejSP9CqNm5GN4
	 JHQf8BfFSgCWKi/hClJvm1ROdgDnuzRqc9nN4BJOv8Rz2yiBEKpmd8ex1m3hYB5TlV
	 Z3BTaZ8s2POzg==
Message-ID: <sashiko-outbox-225855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 51/60] mm: restrict explicit migration to
 N_MEMORY_MEMPOLICY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-51-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-51-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:38:31 +0000
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
> mbind(MPOL_MF_MOVE), migrate_pages() and move_pages() act only on folios
> on common memory. N_MEMORY_MEMPOLICY nodes are the nodes memory policy
> and explicit migration may target, so let explicit migration also act on
> folios already on them.
>=20
> Add folio_allows_mempolicy(), which requires the folio's node to permit
> memory policy, and use it instead.
>=20
> Memory on other private nodes is still left alone:
>   - move_pages() refuses to migrate it.
>   - mbind(MPOL_MF_MOVE) and migrate_pages() skip its folios.
>=20
> Cpuset migration can now find pages on these nodes. Evacuate them only
> from nodes the cpuset no longer allows. Private nodes are still never
> destinations for this kind of migration.
>=20
> Migration keeps its best-effort behavior and can affect shared backing
> pages seen by other mappers.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D51

