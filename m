Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640713;
	b=HsLLFTqjRECMokt28g/SIGR7RwRfVDlY+0uGciB7L7wViOzciZ+4YW9ZaltmOyXtCUtt
	 35lx86ve8+QPtIjkTU58ltoX/NuHbUgFB2KVW3T8W2H3/oR8Ea2MNXIN+1H98PRLLRyeg
	 yMEHzKWSMueJCXnHVzJjKquZzYjEdQDWreXkPlbpCNqgzFNZweE/fETSu6aFZfr/fgWgb
	 KRwufotWslYjnFEnWWc8AJnuYGl16GlZqJ0I55ROsZELwicjrE10biRpZK/0XNWspvb0l
	 uC5gGFSn9NDWfo4Z3Ytl5Iy+K8iIfwy18NA72j2SSrK0AsjeVzwvWGzRDdJq5iMnwTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640713;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YsYa3axLeAspzpHb9ePEMH2wd13vTwIRJ33rfxF7bcw=;
	b=3FY1AaKUrzwuKgdI2IdM8YANyB1ncX5InXYH/c9OpOxCuUVTV4ATd7NfHHyYfrmI/VI3
	 IVeddCzKaedzrcCEci7LLoVnge87wPNTYKnBHqOoD2SALgv6vkbMZEPvFN75vybIbIZkl
	 X65qe/oKgtYQcxERCHUvWNhZVb2Ow7uAmHmMS5SuocHFRuNCzG6mV5SX4q2p6a9akRcKV
	 ixLvvqJBKPsO8Y8vs0zNsKkR9AYkd1qP/XOyxWf6uipSCAnNxLwP4L+9b3ZvqEntEHMpA
	 9g3FeKaZ0gF8Q9Sh4v8aVPus4C+Hal8Jly1XZDbfBP0Gc9U3CFYl02MJDYLs3TjUVLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsTGGxPg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AE606A329;
	Sat, 14 Nov 2026 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZsTGGxPg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094091F000C4;
	Sat, 14 Nov 2026 07:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640713;
	bh=YsYa3axLeAspzpHb9ePEMH2wd13vTwIRJ33rfxF7bcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsTGGxPgbn6GdVw2lsBRXY9683zy/UAEPSmxbZZX06KjV8z/aPZIx4C9Q3DAsssOF
	 Dr4pAsoHq6sp5CLDhuTxHiLj4XP2tlH6SyjDkcnvlq83YAgVgtEbx80drPjuD2nldL
	 fAvtS7m1eT4X9BiV5V5S6QAy2SgmWpckCaqUjEDl11n8ZdZh/UKG9N013AP8wgMwHR
	 pT3zYHHG4fDKdERQffpYx3el0/p7LyM9lCrVDGFXkj745BYhL0UoIZQYKfjwsYqE3g
	 WzXC4JDcvMWMO/ZZWVVglFj1HGXtLaIbW9L4qpctjtxYd9sImdIsBJD3tXkIY8UgYR
	 lqFPU8C9aqZYQ==
Message-ID: <sashiko-outbox-214251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/22] mm/mempolicy: keep interleave and tmpfs mount
 policies on common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-6-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-6-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:18:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Use N_MEMORY_COMMON for boot mempolicy calculations and their per-node
> sysfs entries (weighted interleave weights).=20
>=20
> Restrict the node set mpol_set_nodemask() applies to set_mempolicy()
> and mbind() masks to N_MEMORY_COMMON nodes.
>=20
> Later when an N_MEMORY node is omitted frmo the N_MEMORY_COMMON set,
> they will be stripped from mempolicy nodemasks as they're not eligible
> (similar to memoryless nodes today).
>=20
> All memory is common at this point, no behavior change at this point.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D5

