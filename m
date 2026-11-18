Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036819;
	b=U7i2NfMVOrZKnotV9zgNmCVwalWVgMS14Atvg5wZl8a5DxgdIqs8a85som4uFbHyJkKZ
	 6oIpTpAt9DvJyydIT+mYFSA+C+IRxUNCXJEV04VRRQ5AuLtPfAB7lb0vGZDc8YnKeb2l+
	 HDqpodc8bJlWZicwyKaY5tEJuUMMAdG6qRsgCNcO2bxoMjWCkbx/vEtGR1m76LXdcntnZ
	 xdqSJUU+2icrexl9xa1COmQZIKzsQlgVhqFuRV0ZgbRn7JwUiwRSieZOPuPQlNN/VNiOF
	 10r2qmgqbQjQQf8YTmoIM92aRNTm0qdNrZWBdUd/MhcLFxrCe9VeFaD7K+OrUboDLjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036819;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D68Ry5fgKPbK9v+vGFFk66RM3Qo1czdsrND+hm5yE3s=;
	b=LlQUcBoaFH7WHv62wiPaBn6zWwK2fE5/wFqQBEa+HpHbgNBhIWRaEWflL7DOkDaF0m4z
	 Jw8uI+B/Hio4nd2RHraPZvm2dUmrTPIdbAjIBlW1H0ub1RrY0iqtrInEfSznxuV46/Ve3
	 u6bHoSzJRQEOWtj55B+jOmXNTBYaZ+9+6NFapPqNaZJFY4ViM0svja8Y2ng+a181IBdvx
	 o3Hd3Pb8BSICCIR7tlQj0X80kuZI6b2qNrdrUA2ryiFm6qNi6uwsg3u+ZiTSaZ5A2pK/9
	 tgE/gOZoEogyeDThguaIPMPw3PYIXAofL39Y/GK/mdKlSJj4unQKxPLDHtzYQz8FpPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBornHVq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2B6606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBornHVq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1031F000C4;
	Wed, 18 Nov 2026 21:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036819;
	bh=D68Ry5fgKPbK9v+vGFFk66RM3Qo1czdsrND+hm5yE3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YBornHVqab9yHFrYT8ejYe82lF05f29jIy/jnvXpGRo1QAlC3L9i6YtuBcekm3HgO
	 ojMYv9xKLqThC9F5y31O8SbKe5fw4FfhFBEkJH6EZ5k4fqKBD+/pJRpCZAbBTP4rG6
	 /MMAgbaXcxhGLDb4den3js0rSDGpt8Yorm5hNjktfumF+xKgCXTTIhmgsq0gT24q1S
	 f6qXU6+4oD7JxP7z61pyYbtQdpPCAPvWAumKdzDPt9g6THPX/VCZgLCCAu6RQMwB1e
	 Z4RdFsAauGDFsFeJfwgRThvpIqc8eEiEPMOl8FBSCnim/5famHScIlWHptNvM0MrMl
	 YU/LBg8tKv+4w==
Message-ID: <sashiko-outbox-221985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] mm/mglru: make folio_test_workingset() work
 based on folio LRU refs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-17-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-17-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:20:18 +0000
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
> folio_test_workingset() currently tests the PG_workingset bit, which
> is only the second lowest access bit of the folio LRU refs count now.
> Folios with refs 4 or 5 carry it in the LRU_REFS_MASK field
> and no longer have PG_workingset set, so the bit test misses them.
>=20
> folio_set_workingset() currently sets the PG_workingset bit with a
> plain set_bit(), which also over-promotes folios at a higher refs
> count: e.g. a folio at refs 4 is bumped to refs 6, advancing it
> toward LRU_REFS_MAX and an earlier generation promotion.
>=20
> Move the test into mm_inline.h as an inline helper based on
> folio_lru_refs(), checking refs >=3D LRU_REFS_WORKINGSET.  The set
> stays a plain PG_workingset bit operation reserved for the
> classical LRU: under MGLRU the refs count is maintained by
> folio_inc_lru_refs(), and now triggers a debug WARN when called
> while MGLRU is fully on (the switching window is exempt, as the
> classical paths legitimately run alongside MGLRU then).  The one
> PageWorkingset() user in erofs is converted to the folio helper.
>=20
> Under the classical LRU the refs count is not maintained, so the
> test is equivalent to the PG_workingset bit test, which is the old
> behavior.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D17

