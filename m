Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633607;
	b=SBAcSaH4fwlopxj/IGzn+GCi8PDwYXMy/zleKE1L+jQRDGVs4sWJlB76wq9wAKrmVb3+
	 yn2E5rufKezgmbj+Zf1C0D/66EKQoJFnnTFnMsxl4iQYkrhozNueBlWeBy3nr2jxJBD8X
	 i7GabYmxTqvI99LunqMQAk1gcZYDHLh2mmV7r606Mo998gX/dYkTqxYkr4tqRdxjIg3MR
	 s9MrP7vtB4Y4GUzVRbTgedVaIICdXtb0V+etQN+7ASiQy/XXUsgEx5u/07hGcRoWnnTf4
	 RwR+l3pJCGL6pIKu2ADDkbw6u2U3YJHznzegsXTiIrPRVj5SelUj/iSO/zDBAPbeHAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FU1tMJqX3cpcXEx7W1Z1Mfzx9FXit/zuAPxeBG0qSaU=;
	b=x8XvIvlQEwywPSOcWM1U0SpiZQbM8e9fYoG6OsGXgcdkNVgo4dni/8irNX5oXY0Le0xN
	 3Q9dlEddv2tbi1LOFndQNy8AmTqUArNbfvBpAm1t/zH3/i31nj71aNiAD73DoymT0yUIL
	 2qEfB12sZxpB8D/ZMQoPTM6v7bBkIXcfInBPdpSvwDzg4kaHNZYZ+1bNVI+aNm42/7zAJ
	 1VH7JagNZPxG9qK2rncC867LakrB/T2Nw1NfAjtK+J5iJEZpu2g5deN8bcJOmucOQpDaH
	 x2TCIOPIjUV8hKOtJH2nlYV3hX4zWyCrTWNfzfAusw+I4RFp5q75HlXQfaT9YzdQDhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHJpZu9Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657D609FAAE
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WHJpZu9Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686E61F00A16;
	Mon,  2 Nov 2026 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633606;
	bh=FU1tMJqX3cpcXEx7W1Z1Mfzx9FXit/zuAPxeBG0qSaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WHJpZu9YkzaRpLcVxAwo5wCSgLEFWkdSC3yoggfBtUEyOitAcQPEGwK8pCyW4Z3/G
	 v32hmDCU1tYrt4bgqMR9SHIkkJvnfSIH4nZCGb8t1KHOW3Uz20Kz1CaJ/mUqdWAxVE
	 lWnurbxKMzrcQ1rhoeAFsmrBvGcF1OHwAVh37qHfyByvSfmKtP2dhpS/aNPcG9bsFr
	 VkqCXOkdYzsfFCADdBb+DMaHqDMotJdwWNFwSDBNz4+1nhpQbZtJNxrIiioIxSA+hr
	 5CUGOLueqW/vYLoL4shlFgRsq33FLY5rfQ9g6+FE8Es/EOK5C5SQ8m8x7N4lXOF524
	 c4vNAUBHCkUyg==
Message-ID: <sashiko-outbox-193672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] mm/damon/{p,v}addr: skip folios already on the
 migration target node
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-6-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:33:26 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> While measuring DAMOS migration overhead, I found that the target_nid
> path isolates folios already on the target node, then puts them back on
> the LRU without migrating them.
>=20
> Skip them before isolation in vaddr and paddr, as the vaddr explicit
> destinations path already does.
>=20
> In a synthetic same-node fvaddr test on a two-node x86-64 KVM guest (8
> interleaved runs per kernel), guest-kernel cycles fell by about 29% with
> 4 KiB regions and 90% with 16 MiB regions. Median kdamond CPU time fell
> by about 76% with 16 MiB regions, with no clear change with 4 KiB
> regions.
>=20
> Cc: Bijan Tabatabai <bijan311@gmail.com>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D5

