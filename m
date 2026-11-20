Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199243;
	b=sykRPzVMSBgvN4Ix5gzZ3OqLQTwIPJHBzbeqVvhoqLVlxlrlDtnVMFl9Iq3vg7GDCM4P
	 KhsxmBW+QNGe+8kiJf9XoBVqi6srLWM22oWJaUdkqm0OFNv1wIQtCbeBcdwXdrgLzRUbR
	 lpY5vtjSJ7b01zvT131r+D+CgEHUPpl4b6Mzcg7TIPTj4eGAJaVm2QMOvYsXSYqilTM+K
	 JRHJogMhwHi4NFzeUibGKngFp4hQNTOukyKG8ykSil4UR7Nh6cFVPif2RUpxe8OSibUpP
	 +GB0W/XYbJ2XAsiQVkw0OmmpwCjA3KRWZIeQ09c5V1RRH55vztypXG6+wMxXjdE28jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NrdfOd4QMk/hng2geBQY5cUbhKKJIJOQ5MqcLuz3MUg=;
	b=y5lnF9NtZA1hxnVgSnw5G1iB7lRJO/ZaNPCGKpzg0qY3MSdwZUAE81NhZDSdagbRntHU
	 tuZJCyzLpKzFdPjlLrI3FZ+3BHv5bO3iVnoZuBIOFB6SEP1l6RN5VBoJW6z8ZWTZC3675
	 sg5+H7nZhjPDdaBl+2y9+722xLc2Oo20UWextECbnMIybmYsnF01dqxp0NY0h0NYhcLvQ
	 stcaKql2OqS7H7+WK+4fTzxWZci2PseHuLh+SSNomPuuxYy6tsK+E2QoKv3bAYEIrta1Z
	 azCj7J+UE7SL4A/iQ7LMM1bjS+q6J88p45NjLvdDEPgvyFSZe2n96tmxiZhi5K7B3eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtTmwVoE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C252606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtTmwVoE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884A61F000C0;
	Fri, 20 Nov 2026 18:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199242;
	bh=NrdfOd4QMk/hng2geBQY5cUbhKKJIJOQ5MqcLuz3MUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtTmwVoEapLSTAY2TdDqRx8uKW07+XX+Xs+M5Kk6zKP/uzf5lmIeFYloj/yKT1dj6
	 7jN6hflPHUo1JDz4ddCbYw+BGExrdWZtsvshB4DOzMrAT/IDG1tMW4dPOR7hAB6FOE
	 Xe3pq8crLoxzix4cZwWFAnUf+1ZOKk/u6LHOUlu/3pHyUkDyqPChhuMhIkwbRckzNB
	 pSm7R4Cpds8OwJ6/+B0Z8bs/OsYYyy6HhD/N4hClBKCAGgyjWeWVVx1uenSrruy6qZ
	 eBZbm4wujVHpFbjlWAbbxTgz/ADP7RyoerW5DO3U73LX1/f0P8X9OfQDTwHVdNeqAi
	 G1qxRIw0JGOLQ==
Message-ID: <sashiko-outbox-225828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 50/60] mm: add N_MEMORY_MEMPOLICY node state
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-50-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-50-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:27:22 +0000
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
> Add N_MEMORY_MEMPOLICY as an internal state for the nodes that memory
> policy interfaces and explicit migration may target, and
> NODE_MEMORY_FEAT_MEMPOLICY for memory providers to select it.
>=20
> Userspace placement lets ordinary processes use the node like any other
> memory. That assumes the node is reclaimed and compacted, so the feature
> requires both.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D50

