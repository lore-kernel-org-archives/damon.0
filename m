Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036459;
	b=Ce+t37QtfciYQFqHQw2H4jhPDj9q8fqEXquSJg9BZyxOSs0ljGo/kGLRGKtRybMYl+an
	 3MVb7jfeGt+7ew5uI5M7PZG+s+tOjzZa9+nZUnG2BiYsy0Kte3FRh82tNzLmuJ40/WcAy
	 i+90NW3Qz+Ax0PUlZTTg8z/Ac88E9wzwh8+WUqWK5zAeg443jAb3oyGN4dBBvUst6C+o7
	 8s9c/KYj2fJCws7GdTJURnjx6zaa6CaYgRWT/diS3PzSvpp/eh7nAVjS78D1If+SIEUhc
	 237lrXRteeYbPoYSseeKNl9iOI4PwCAfP89qfJDNSdNxYHbbC9Bly4eR3Tb/J36NdKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VQ8i1Qr0JcAra/8/8n6QmwRVMmVMuQnbYoknWZ3vpeU=;
	b=hZ1zG47UH7SBRhXV8I6hPxwzoNly+h/OvicLfEtA3+aNbIFTWe5JcAYgLdAWe0ELUA50
	 YnoBnUBM7DqLOfWZfPwTsRFrMECFN1Duu7ihkAmN9+lSmpt4XTmoVxj4vhuXu6WEEEI3P
	 diMPzQivRdNZ/ni0iinxS/QKKTevx9pubQnjEJHHwS68mXJI8VSuwPSofuZhYUOrUJPvI
	 DOde+RbOa/rij9Al6UrEzVnRXM8df4XXaLTboynfFxpn+iwoUrSvVJqv1OCBU3xF3eFIL
	 dr/miRlvGnHvwn4q8l81HqzTblqFrW1w9Zm2uQ08vt/GL220yN+MdNWpynLNZJShzgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSSmasf+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A09F606A339
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSSmasf+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E231F000C4;
	Wed, 18 Nov 2026 21:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036459;
	bh=VQ8i1Qr0JcAra/8/8n6QmwRVMmVMuQnbYoknWZ3vpeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSSmasf+aPDP9/3LivfIgHFutD4EVLMusIvLzEbxjoSvO6ggMKdv/hMoswr9QY+GQ
	 gx+s9qi7XdzT8cJuCMLcrodJLc/8Uuirk9qkCfgJQBhTlMK6XSTiaty2x+eyvVMHRi
	 4br41Ts7xD6Kx1p2rapP0+XNCnjtAp1yYPvCxaMqbJv9MbHMCL+bT1UjFQZREsTRGN
	 CBfXKwIXnX6Zw66VorL3kKIy63WJxfw9s40VRE4necYwlQad4Qk54PX6sKPseAPNxA
	 FcriciK1FmdZyMpShRoS6dTZep8Sw+ViUSrC0F1EYeKk2ney+2LWasnViIQHaSwsQx
	 BHQ66X4c+WkIw==
Message-ID: <sashiko-outbox-221982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] mm/madvise: adapt for LRU refs based
 operations for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-13-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-13-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:14:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> For the active/inactive LRU, madvise clears PG_referenced so that one more
> access is not enough to reactivate a folio, and keeps PG_workingset on a
> folio demoted out of the active list so its refault is still accounted as
> a workingset refault (PSI).
>=20
> MGLRU keeps that history in the folio's refs count instead, which now
> lives in PG_referenced, PG_workingset and LRU_REFS_MASK, so writing to
> those bits directly corrupts the count. The two hints want different
> things:
>=20
> - MADV_COLD resets the count in folio_deactivate(), which also requests
>   deactivation.
> - MADV_PAGEOUT clears non-workingset refs and caps the rest at
>   LRU_REFS_WORKINGSET after isolation, before handing the folio to
>   reclaim_pages(). The hint marks the folio as cold, so the
>   eviction shadow records the capped count and does not inflate the
>   eviction/refault counters of the hot tiers that drive aging, while
>   folios at or above the workingset threshold keep their PSI
>   classification.
>=20
> PG_young is cleared for both LRUs as before, so the referenced walk does
> not count stale history as a recent access.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D13

