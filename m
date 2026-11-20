Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198892;
	b=uVtUVQw8f3t4QNc/gUXTf4XxHfM6MuAYzoCXs9CSpPJ4RF0BJActFHUmDkm3wKVKRYgF
	 05dkPSVS2NdzF7b15wJqb7wyOMvBwSPFLJqlZzvc6fHBia9yDsNDPL8xGXGil8w42CamS
	 ++7FdnU6tXTpNqTbrNy3odnZ8AsXk3jfw/30I6AIzZxRBcgfbiCzRkJQ/XKmQNNPXNTCS
	 VHXRHbaaopf7v4wLqg/wEzBUn5CFoUWv/0BwJdckAegakUkoZXf00PO6V2SGiYkn0m5u1
	 ptAbMOXmMVI+3r/5CECror5HDFQU/P4Fgj8pwRxbJntOdiS8Fi3VCSNq5XbDy1WBsOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hf5jQEnBmYO19n5GFa09x/mqEhEsAg2mhYrr22lgyMA=;
	b=IZLiR/sxPv+VGdL2ztCeaOVJ8Nup7mB+uC/Z+UsQtPF3YWI8+/elsZIjyWEFFP0Nrk/G
	 yyVAR0nRCZW7baV7OTs60FOurtIVGS0x9Hhrl72hz1ClhUbf3y6JfFRzUL/K0c9v1JFt6
	 7aLLBV1LW6efztV0dkA/wkCIN6aMNbwlVyPzrkU+L9fIci+DJh0pm333PVHDRPUcd4H3x
	 Nyh1T/u+5wze+L6p7U40NuaoMu0R+cjoG6BIGJTFZI1hlNGC4+fxXR/pYSGx2Xk10lKwo
	 JwzwmxmVW2iHsSjNhVwanumyUNf2Djq8aC6bYPgKg6qrtY4Dp0V3ndlvRZWH+CADiqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmBFnokS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6E606A896
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmBFnokS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6B21F000F0;
	Fri, 20 Nov 2026 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198892;
	bh=hf5jQEnBmYO19n5GFa09x/mqEhEsAg2mhYrr22lgyMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmBFnokSFQUfhS3CX2Eo2pu/KO7Fjyi2fkSLuIQnN/xChwqFPJeeX1oTmcnwkXryh
	 DYeeKORS1qF/kpYei2jbpfLCHGUFFCiN3IAB6Gq/UonpIfLPYMiNDZ2TyclKS3o4tM
	 +SH5idCYJ0eRCgLlgLQBVzcDwWst2/9avKlTaLKx1N6Nv1UM0M+XJTtov/Tf0DWHyx
	 yZk6l2nm56miuICL2wXrc5VNmvmPgU/1WpTcbOMip1o2eZNAn+mK0uiUntQwgoNXCJ
	 9QnrXZTS1S8LrkthoChLw4idsN3V1pprcjoIh1mgKtMz/h69/CruKSZr1XRuE3qVgi
	 D2Kge7FYxceoA==
Message-ID: <sashiko-outbox-225810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/60] mm/memory-tiers: restrict demotion topology to
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-7-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-7-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:31 +0000
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
> Memory outside N_MEMORY_COMMON is outside the ordinary allocation pool
> and cannot be a generic demotion source or destination.
>=20
> Build demotion paths and the default DRAM performance reference from
> N_MEMORY_COMMON rather than every node that has memory, and do not
> assign other nodes to a memory tier through the generic hotplug path.
>=20
> Removing a node's memory already resets its demotion targets, so a node
> that unplugs and returns outside N_MEMORY_COMMON keeps none.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D7

