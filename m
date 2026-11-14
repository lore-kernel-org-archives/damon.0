Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640540;
	b=F1sLnOBhfbNtCSp5l7IfDwXcfgzxNZ/s7wbhrTSguKjS+SKqlCU71HHhrTWVMO/U6hpu
	 gf4cepSkwq7eJKQ5Ksds8FSSSHuXEDGNl1NDEwGem7nnrRBOTO3hjVi6bYw29nh5gPLUy
	 laVwyHqNddOZb9rsqeIdmaLot2H/OgSPv8iK6T13JyFAOVugSFu/Fxcn/ttMFkVSWwUHG
	 0h5KQD1mUyQTnA+Ix6EOLuOhVevdxJBYG4mB9NqWEyRcsIwXXAQJRysn1QauyGWMIBBNh
	 qY/i/GpE6RL/nhFBi2XmbRASUfXFIK2d0Zevon2R7MfhyuvKXBrBF616F7NZS4PotzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640540;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zfr/7TUsQGHRg75UWbP+oAoDTK7BYVL25AVHLBl8PVM=;
	b=q5L3Oe8nVPvslpNrfefIRyN/LK/DaO37bM4Rv6zsAiqDiQQwvJAQZDEAufcJTVLJ1lC8
	 eClSoIMf/0uTDSINHSWlwezG3Rz01VtuNlSrg65cqzWlRd0shO1fDO9nXOfgUqs2KJckD
	 nzfJJCyhMkFK5vlO5gDZUJMT7II4g3q6mTWqsXqDiB4xibtbZGlcy5NMB/5qIa/RGZ+27
	 jKvQWm2NqOVe4YnH8hlndb5bmmw3QGyFf2fx56afAy7fXvhgnwYrBrdBX3oRopB+b0bIf
	 t+k4TpVglKs9J1OKnbxcEiIudkd2yRsQCx5YH2o6cqoNwX1pVHz74jU/U3ggSRzo4Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOOcGkKY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36A7606A329;
	Sat, 14 Nov 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JOOcGkKY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C21F000C4;
	Sat, 14 Nov 2026 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640539;
	bh=zfr/7TUsQGHRg75UWbP+oAoDTK7BYVL25AVHLBl8PVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOOcGkKYIcseXNvmwLdijlmNwJ9spEyPHULev35iXCqKjG6iJyDJjKJAffnrwvdhe
	 fx4wUlSpMOLDgE0CrrASbnxkH6dtWlIVHpSMKzsepSG5npGq8kgK8k+wN+ZtCDypo9
	 C3UgYg4kenHEAi/fcQ9HMkJzJjw3v+VSZkNelCTxPbgYFcla1LEuit/eXNSzyUQpC0
	 5RgRTSlDR8859RrIyZaLuihgDG+oP/K2sz9jGcNqc+VAK4RLD8Z5GMYAS7wKsnLxb4
	 efON4Ur0lohnjv0tPx78ZV2UeZ2FETOyxcRiKIY85BVpt9qGQNQHWRAxY0vhKeE81+
	 oF0Eb1IDevABA==
Message-ID: <sashiko-outbox-214243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/22] mm/damon: restrict DAMON-native folio operations
 to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-13-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-13-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:15:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON acquires folios to age them, check their accesses, and apply LRU
> operations and migration. Treat these as general-purpose MM services
> and restrict them to N_MEMORY_COMMON.
>=20
> Memory outside N_MEMORY_COMMON can still hold ordinary LRU folios, so
> it would pass the checks that keep ZONE_DEVICE memory out of these
> operations.
>=20
> Treat these folios like ZONE_DEVICE memory.
>=20
> DAMON cannot acquire such a folio, so it never ages one and virtual
> address monitoring reports it as accessed, and DAMOS cannot isolate
> one for migration.
>=20
> Reject migration destinations outside N_MEMORY_COMMON.
>=20
> All memory is common at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D12

