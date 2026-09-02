Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3080947207A;
	Wed,  2 Sep 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347054; cv=none; b=Smw4KDplYsZ4Ll+5ccICwHNGeh68Z6LJVrjf622UilCTlf987j+xiDEccflT0RQUukBSB+nhPaAXKbKI+L8iADHFTpqmUOwA5cZZGM4SkoWN1c9HzjLoMEghqsPVq8GwF95+iscZ9KwXQGXIbig7h/rFIZf4uHMZ7y4YW7PO6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347054; c=relaxed/simple;
	bh=SAf2JSenv0JBAHHMau2xC6feQHwTvcAXsGFro7wTG/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jI3um0ntk/zNA/kqHxFKqbxk7XPM1yILkCxm1j1bDkkZN3e4M0GeeGQdXEerVyf1rv2zfiIjyBCYxYaApAj15TjoxbwwXKBE1QT6uIP+ho8gX8yMrugExvoysfsrOeC29tIvE4qXO6YPYIr15vdVkpLb/xajIaOCV4bz3gOc2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8h1Z+dk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8h1Z+dk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5141F000E9;
	Wed,  2 Sep 2026 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788347053;
	bh=Qa968iYyf3Rzv3iYdxNLmQbVwQB1cG46gXSWOnf1TTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8h1Z+dkgzaN4BQuFCqkR9I1rVkZjRviRRnkDIq2vt+XNagccyMP5oCGJzX5jbcoN
	 TtIoGn1ueTcWy/t95x3TimlgDmziZklxvP/A0damVST4m1VPB+2SMEpxbO9dpuloGX
	 i+3Kzezie21NAcpvXywEuj4vpHGOHRLOkjfsTbo9kmRoIrUUXthBkVwFWv1v/Clorq
	 Eg4o66vbncsbKTaRBFaKTTpiBWxl+mCTONkYqfnYu64GYaQwXkctseQ4aCSme0cwdd
	 YSlquO0is+fsBfMBWvvvbvPwRHagYBJGCjbwPDL4MM1nn5cr1yFm9CFLWfCcSTtDzI
	 RGKkY22NBcsNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/11] mm/migrate: add a dedicated movable_ops
 migration pass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, kvm@vger.kernel.org, "Chuck Lever" <cel@kernel.org>, dsterba@suse.cz, "Anna
 Schumaker" <anna@kernel.org>, damon@lists.linux.dev, linux-cxl@vger.kernel.org
In-Reply-To: <20260902-migrate-refactor-shivank-v1-5-9dcca87669c4@amd.com>
References: <20260902-migrate-refactor-shivank-v1-0-9dcca87669c4@amd.com>
 <20260902-migrate-refactor-shivank-v1-5-9dcca87669c4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:04:12 +0000
Message-Id: <20260902110412.BA5141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Pages with movable_ops transfer ownership through a driver callback and do
> not need the unmap, TLB flush, copy, or LRU handling used for LRU folios.
> These pages are expected to stop being represented as folios. Separating
> their migration from the LRU folio path prepares for that conversion.
>=20
> Add migrate_movable_ops_pages() before LRU folio migration to handle
> allocation, locking, retries, and cleanup on a separate list. Return
> remaining pages through @ret_folios and remove the now-unreachable
> movable_ops branches from the LRU path.
>=20
> This changes three details of movable_ops migration:
>  - Pages are processed before LRU folios rather than in source-list order.
>  - Synchronous callers use the requested mode from the first attempt
>    instead of the LRU asynchronous pre-pass.
>  - A callback returning -EAGAIN ends the current attempt, so a later
>    retry allocates a fresh destination.
>  - MIGRATE_SYNC_LIGHT waits for the page lock instead of giving up,
>    because !uptodate check is not applicable for movable_ops
>    pages.
>=20
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-migrate-re=
factor-shivank-v1-0-9dcca87669c4@amd.com?part=3D5

