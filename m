Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199148;
	b=s/o3qMY8/8NJ11lKrL5TOgLMHdxAagfTyK6+GQSN5v4N9hSMsCu804+qg97c/PpqglR7
	 YICUg7MKZvjpzJq55/AQ8DTwgcVqZb3h7THSo2vAjvXa6ey0ttHrkNGOamkdq3yL1ylvK
	 WWol/vqw7R5WQqgRJI6XD7W1V35np0zW9dsWiCP5Natk56zc2pJ62HVAOcDpYO4YLWGTW
	 JA09BsHp66KSYFawMYCKcA0NuUASnPdu+/XXthx3oPdFXKbqDN+YxqGQ21Puqrv30SvHY
	 n8lG+LYnxEgs4YFEHPXP2vqlbFgBR3uykHlgEcxCb3irIOWCGFULkTktmDUj/u8h6rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YXA+LgsjntDCDpxxxH+pfqy39l4yHbyCViwa0zoUIEg=;
	b=wFb/BXXMeDJQK3DU7dhtNpCrXznX0+P6cJP6f43DZbUE/EjtuJuJImrg81hP2J/q3JBk
	 Gb3o5xuk8noxBPJSJSGhhGXn6mB1ocxsmJRWB4Xzrgjk51i31UUy9zPvBApTe4wyNocGN
	 UPWk/tyQywkb6/mNJixetLIWpKS9oVM15cE1KfMz0X1/UPridXUqkqOcbuYhyOLzOyQk/
	 euz+pRwST7FiKmyBp9t5AiKgOySAG+I/LltVjGXqbhpbjSXeSWLhc862EahYSOS5TRacd
	 Xqx0XHXZxXSZJvz+6WMjFsmTkcnsURu45aEDgN0osLoJjOq+a0h6iVfSco4w42v5MmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owVpT0td;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C6606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owVpT0td
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB101F000C0;
	Fri, 20 Nov 2026 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199148;
	bh=YXA+LgsjntDCDpxxxH+pfqy39l4yHbyCViwa0zoUIEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owVpT0tdy4o0FsehNWIKtZTE0hZ7qWf6TgYiDdMfJ3LQWgC35Gu0zTOKJ3NYsy3WQ
	 obLNQpw+g1G/oXQRbnK563K/jbXBjvh6iL6KE0pGbmd6T1u2K/Nu40TvPnFOmMkvMm
	 0DKJM5wftUQBbR2HAAqfRPQjHo1yZWWdwGoyNek3N4EwQ47McXYTIwlQnTYKXUGyKE
	 Kv330uSX+aG+tym3SzM0raWJnf1Et3cv9ii9/GN56CjPxgA7BrMD0LWsP8NNdmqEX7
	 k7++uIUIvkim3ty455eHqIdqZptR55n7iZfsMjwYc/jdm7MtLJH/YpsnaFlUmKTKVy
	 cqx9LPXIIMv2A==
Message-ID: <sashiko-outbox-225825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 35/60] mm/mempolicy: keep private nodes out of
 migrate_pages() destinations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-35-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-35-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:25:48 +0000
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
> migrate_pages(2) intersects its destination nodes with the caller's
> cpuset, which can include private nodes.
>=20
> A private destination gets mapped to some source node, and every page
> bound for it attempts a __GFP_THISNODE allocation. A private node is not
> on its own __GFP_THISNODE zonelist, so the call fails with -ENOMEM and
> logs an allocation failure.
>=20
> Leave private nodes out of the destination mask, as move_pages(2)
> already rejects them. A mask that names only private nodes fails with
> -EINVAL.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D35

