Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199148;
	b=L72LWlgd6etKS6jbdvwhYzU1tFPa8Zu5k9FLeNR+dWt8pKcgzwObuc8n+tABQFH8r3Ad
	 RJYO+TMhmlFXqmPIPqxEZvEnn6MiNSiL5UuuiH09WmmbexEMKt8KqWFOo1ph0qd5x67Nb
	 V3oQOYUTCVCpeK6LPusO0zLZ7f36+EUKXCkpf1Vx9Os9eDwVlN9TNhHV2F2Pei1ofPcFi
	 ob4JkjGThelsyEWDQZwhFs5zYUAvvW3fm0d+qboJr3yYeVUmrR4oOUY9RCwRUxrOezqMP
	 RPlIp1EtLAWu4bYQ3X3mek8d9EHpc2GHprjaGWnnnnUgNc7P6p4vHKvim5doqDBMXLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zvGGy+7OhtLU8AukTrrmQ6/Hipz+NLT+DSAKASTiEVU=;
	b=jcm5dWHMdMQy/CPHGS5K1oWhvlD8XhvV+MHwjKhSjjX1KV34TXbI7Og2W8CkDcG0ULi0
	 xvix5brOA/oPrf1Ot31AfvPamaJpgXXiV1ZAdC5omc9j4nuPvNhO+onWGvNM5n00IVZMZ
	 0ERZrR/M0HQh03ihp32lUTEOXLG2XICk/ROA+3YxRm9BFksV562vH2/hQ0fPtrzUYEyPA
	 puJwQswycg06AI60yeuu9AfL1VgzS6K3LvD1iQh/Uud7dZfuKW/WLlYdgzo2AmZLPeFFB
	 HoiHo8scEbjGJhle51pjHjXkYr3h3tlZTmbq9l6CnojqjZDLP9W6KKgMUfnJatji5Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuVZgKQL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D8606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuVZgKQL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DC1F000C0;
	Fri, 20 Nov 2026 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199147;
	bh=zvGGy+7OhtLU8AukTrrmQ6/Hipz+NLT+DSAKASTiEVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IuVZgKQLqqGZ/iTxpXGrORTr2rwCSlpocOEkJ2WL7zsLRRscwrPtxqtPJE1NMlAmQ
	 wGGKn6ElaPnj+IR1czgJrY/BFsLitdYLp68L5UANtotxEm2hE3R54tKzJ5knrlULN1
	 LPxXvv8Gv0Onw6+Dqfjx0WWQi155T7y6gbvnE5bJnx8SCxt3lckxVGKqRtYroEVkuC
	 SzPGHwDilwYjw6ZTDhmShMYGlB7/BXQU1qr6Jmc9kyCazBHeJWV1Nyani8V+gpQbI2
	 RbKppaPHF2s/WgSw871lDv4i6EaI4Jijj5kU+pqbt/rrXwZYXPI3z11WS5Kxwm1BQU
	 WUe6nu7ugg+Ow==
Message-ID: <sashiko-outbox-225824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 27/60] mm: add the private-memory node state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-27-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-27-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:25:47 +0000
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
> N_MEMORY_COMMON describes memory that ordinary allocations and MM
> services may use. Some memory is online but is not part of that pool.
>=20
> Add N_MEMORY_PRIVATE for nodes with such memory.
>=20
> N_MEMORY_COMMON and N_MEMORY_PRIVATE partition N_MEMORY, so a caller can
> drop private nodes from a mask without also dropping memoryless nodes.
>=20
> Expose the state via `has_private_memory`.
>=20
> Without CONFIG_NUMA, node 0 holds all memory and none of it is private.
> We have to adjust the node_state check to return false for this node,
> previously when CONFIG_NUMA was disabled it would always return true.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D27

