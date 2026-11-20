Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199476;
	b=U10VujAteVqRK6IzQrBBf3K5E+tajwCl5QeD+MyYqBWlX98eyzOoiH+dAtoCwzRK6yfr
	 NFDJRncsTJfb0i724EvG2ZrOZFZPfhzideT7sWe1iqSRQT3cSiCFvTPcusTeac+FwwsFH
	 dDLdmeX813Z5CMViU6ArLgcoZ51AUqiyFbxI6cStxMM/LJENhnywmGpc9GcDjbYz04IT0
	 qZX84o13vnR2kU79irpn32hsneqi4PpnHo9rLvhPHylOURZi3+h6WOTyAoykymHp+KYdl
	 ownGrrjfZRhLEKknTHYoZ1p0MkFivg/KlaSm8PNfTFItxIJ8gAKpIl77dcA6h5JZLMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qc7luR4mOdvZdBnv8X4ED5vW4OPBr0sRdjY0jA3ztd8=;
	b=b7J1awH4HGziX8WzbMUKocbpWD8lmxqNBMn5OVoZCbIYbF8W7ehaaOKgMypRdAU8Wqeo
	 6R4NKvCOCCXlaiYtsmX9v9WtwKtGcJvfYUREH+3gceze6RSYF4t23VFwu8wCTINRcICvV
	 7dLnnptidJAFq5RLDAVM6pO2sx128R1lc65J5Qpj8pnu/9YqbeLOWoRgTGLe2CPL03D28
	 zke87FuzBc7wNWl2kHfS5FG0cQvLEmf478w7a4kksUYT9rfRSrAcmh2dgu38qz8gHpgQc
	 f0lsGNqxvoynJZSqrlSWEun7LC9R24mnBJ5rIRvDQT3wzbxqVNuBT/4uubMK34lyRDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sec4FoKP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3289606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sec4FoKP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3244D1F000C0;
	Fri, 20 Nov 2026 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199476;
	bh=qc7luR4mOdvZdBnv8X4ED5vW4OPBr0sRdjY0jA3ztd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sec4FoKPcvEaT/UgXQZreCYMIqWrtlS1UKXkvs6sl65AsuymvBHFcf7tRRZjmvpma
	 vzh7wsqoTaXVXUIOHjQZIhQvcR9vjgbplfLKneYRcxTz00Rft0X1c4suJsRImmdjeK
	 cPAdfmWkCDS/j5U4s8kqxudqJiZ+iUfrEtDZznTje1pgWoi+MFxH3IUpQI8kcZziVt
	 bcg9wJVrTBi13H5w/J/wf1+NKjBgJQ0ILpcs4mm51VwZuU5PqwwPbxwwz9WZCNgBBn
	 nZCTqwFUUVkiEdcHPuemY8A68ij4N5trHTyYoyGAwwNdDuhHxExhLA++oA6xxms+Pl
	 bXDAO/6jmefww==
Message-ID: <sashiko-outbox-225834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 39/60] mm/page_alloc: add a private-node zonelist
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-39-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-39-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:31:15 +0000
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
> A private node carries N_MEMORY without N_MEMORY_COMMON, so the FALLBACK
> and NOFALLBACK zonelists already exclude it. That leaves no zonelist
> that can reach it.
>=20
> Add ZONELIST_PRIVATE, which holds a node's local zones only if the node
> is private. Common nodes have an empty private zonelist.
>=20
> Like the existing zonelists, it is sized for every zone of every node.
> That adds a zoneref (16 bytes on 64-bit) per possible zone, MAX_NUMNODES
> * MAX_NR_ZONES, to each pgdat. A smaller local-only zonelist type can be
> a follow-up if this matters.
>=20
> When the zonelist becomes selectable, __GFP_THISNODE will still suppress
> OOM, while the page allocator selects the private zonelist instead of
> NOFALLBACK.
>=20
> If a user grows requiring fallback behavior to COMMON nodes when the
> private node is out of memory, we can consider adding a fallback
> variant - but for now private node allocations use a local-only
> zonelist to limit complexity.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D39

