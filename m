Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036243;
	b=OIqDRIixj0kYEreyv15cSHPme/YxSuhi5u9aenHDmOIFqwPKDZ8XML9Smq3C/vvnna0q
	 YoezWXkRum15HN4oh5miqr6qYk0I50bmibsllkllFswxmOYMLl4xyn32h8IhcQwyWDQkM
	 d1YRxiQH6Y1fpSfCKhknTCNg9Ns+Zi9ZTuqjop9tfHpzThhFuXJOLVVFE8oL9Sd3kQ07l
	 9JdZnXRZL9qPf/BoIiRgcfE+gzlKuWEy5MisID9pz0Ns4wRnIgWgSPrhvyENudmHVbKYr
	 duIlgL2TrwwE1/2xdwOyI38qi0fo9Mch02bv3itKa8hN1CdL1hItVblEePSe5xwcxzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j/gjUMsUVQQRDD6hIrHuavOjGv0w+lqXuOWeYBBr580=;
	b=a0s10bVniL3lpTqqL9wGb42VbuU3RCzsYwnpvH9NBJXT65BIz4miBV4O/iOiYvLZE8Ry
	 +bq0TspocyYj9jJXin8vMs534Kjs0TCqM3un7O7YWmp0deEehmylH+vV9WHeyFBDoxIns
	 i8vF+2niF8IGfldG3gAjhZMhyFX39d00rLk8yLEdy0x+2xCfJJQHLwCSLECIyfg5/agHi
	 39SEJzCohYN8XJo72+5Os1DlSW63GSuCzAHRAdvMnx3Bv/VmLQ+Lmzp7jGsLok6DdJ9Ho
	 QkztLqHf2ioZBm/s8z+m+4mciN9mCopL8z6WDVLfuAPFlCaGNVNzIIWawb67eVpOpYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baUglGb7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E3606A320
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baUglGb7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE51F000C6;
	Wed, 18 Nov 2026 21:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036243;
	bh=j/gjUMsUVQQRDD6hIrHuavOjGv0w+lqXuOWeYBBr580=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baUglGb76xetrECg2SudHCIjAhGCtEVX4IhJhdi4XVCz4jYpxJji9i0Vj+cu3vg2s
	 z80QLyxOJD04KM8Q3ZuS/WWjxEb4J8gCHjJduebM7l+ce3VDnquX9aCUxUud+hlV5v
	 u5vda7sEolK3gf2MOGnOgPqW5anMsMdCzMSNLPiisIOr1YpDqnGHTXvUFWjOOY7vYZ
	 GOZJ979EdOpI163rVxtoqs/2ORYeOputT6WRgULd2GtOt+N3UoZ+UbuNo4JgSfc+C1
	 uTtRuFPdUNZnxknmV5A+lB5IQ7kg+KIRk8Ae7gWnmTXbTxB+lQr2b2n9riOdIiA+bb
	 2E2yyU/gQHP7g==
Message-ID: <sashiko-outbox-221974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] mm/mglru, smaps: convert to LRU refs based
 operations for MGLRU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-10-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-10-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:10:43 +0000
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
> PG_referenced is only the lowest bit of the folio LRU refs count
> (LRU_REFS_FLAGS) now, and MGLRU never kept it stable: promotion used to
> clear it, and now it toggles as the count grows. But with the LRU
> referenced count as a stable API now, we can use two helpers to provide
> in-kernel users a stable and sane reading of the referenced status of
> an LRU managed folio.
>=20
> Add folio_check_lru_refs() and folio_clear_lru_refs(), which use the refs
> count when MGLRU is enabled and PG_referenced otherwise, and switch the
> smaps paths over to them. The lru_gen_enabled() test stays inside the
> helpers, so its static key is not splattered over the few call sites.
>=20
> Convert smaps as the first user of them. MGLRU now reports every folio
> with a nonzero count, so the reading no longer flickers and clearing no
> longer results in an ambiguous status.
>=20
> The classical LRU case is unchanged.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D10

