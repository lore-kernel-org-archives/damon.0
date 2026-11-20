Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198829;
	b=ULDilG0JG/6ppjL224YrkCL3AQvZ5EIPYy/EW7XQw+Jkm+kJox14ryOPiX+JcY9tEQjH
	 P/UycmYCFg1glbbRLJtUJ47QhL51XXDgjU7YpLYq7kMsd/G0ZnnrWF3X5OGk+s1A+7cK9
	 wxUChMVCSxyVZndiGQ0tgxJEgpjhViSeGT2GqeBSbcq9917QCH+qzteLP0Llzz7nDqWd3
	 b1Y97MtFBWbsna9efAoDw0aAGsu0/8RWRAOL6ERQZhnhYGEg5oWA5oNed+ia7jMSK1apL
	 ox+2M21U5A8Dz6lircSCeXheyJLUfanM+zS6H1cC+boYQGmazWu01gQAm+7UVpjNWbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GQfX7kiA4b2SS9gWbnjwV++YmwNcg9zVDdDHzESwS1A=;
	b=wpc2grOAb+a3/8wYzHhDOI2GNy3o6Sux9phUXMTmkYeluhPl//q/sMzkmMf30E6gOpX0
	 YYtRr7mLE4AO2H786wiB7hx4ywsneDvLKiZyLE+ebhZmR8dbAUA5M4NZs1mjcwYulGGCi
	 soYw12w+S56YZ7nZhqLnjfBvBqmyZeFEp5T0qUiDDCmTLfYYcZSdl45LnfjY5hHD+XQj3
	 HdshbHo9X/GGGfile31T4HbQa4Q1/ny2hVintJ8g98g4EskElIXsRYAzBa50DOy7rJac/
	 Sr0yUa4ADEqAHuSBSDCP07mnQFTKXRHfSe3QUgb5ojBzhjrGDjqMmAzlmzCN0RR4JPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXrqhCSM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12011606B44A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXrqhCSM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593091F000D0;
	Fri, 20 Nov 2026 18:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198828;
	bh=GQfX7kiA4b2SS9gWbnjwV++YmwNcg9zVDdDHzESwS1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jXrqhCSMg6Os+3frCnOgOCW9JaGc999ztUO1bQovinH1hK4LI+Dyrjz5tjUimayro
	 k76JmGer+3yn3ZL17NEVRJzaM9Po0ZbpspgtRZo6TQFxKs4k9g7bMPhGC0l7ZlU5QV
	 QUBmlpjhrSLOkECdTlbCnF8HJQBRf/eAeM/DnAkW+AByCkRNGtRmF8tN6br2eAKDLj
	 W70f8Cx+lW25sHgSbgRMGq4fv8MnQ7R+gOwoarGqmqjTe3L5qH+7fjHdSjTd5EH0Ld
	 a0DQeXD6THiDpxAIUKwHDWwmCEEtQPDKKBWlimfT+/54WMd8cR0qcaaaI5IpZJzqTs
	 7l0ISTzcm766w==
Message-ID: <sashiko-outbox-225805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/60] mm/memory_hotplug: migrate offlined pages to
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-6-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-6-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:27 +0000
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
> do_migrate_range() / alloc_migration_target() is only capable of
> allocating memory on N_MEMORY_COMMON nodes. The destination nodemask
> presently starts with N_MEMORY and removes the source-node.
>=20
> In the current code, if the destination mask becomes empty, the source
> node is restored to allow migration during partial offlining.
>=20
> Consider this configuration:
>   Node0 =3D N_MEMORY_COMMON
>   Node1 =3D N_MEMORY, not N_MEMORY_COMMON
>=20
> Node 1 keeps the destination mask non-empty, despite being unreachable.
> This leaves migration with no usable destination because the source
> node is not an eligible allocation target.
>=20
> Restrict the hot-unplug migration target-list to N_MEMORY_COMMON so it
> reflects the nodes the allocator can reach.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D6

