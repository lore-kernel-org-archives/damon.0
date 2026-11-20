Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199608;
	b=sAZJCuUsMGa8sGSltEg+ej0sUr7JvRN3ig8w2J5DmQzPyamifHPiwA1MTlynFlVD+f1T
	 uB4mjnrRzze5W8gxM8/u8S3NWjjiBXqpuGtyuPq1AUJYV0ibTiDLpEOnSUah3WTkvrG2L
	 gTjp3Ndsd8XAsDwSQPfdZOc3bTRnwFIkZW0gYAZXUiuSJplxUhP2d++AqcsoYtTGzKIGw
	 wgxObdqcUXD5kotnZBFvWVQMzZTSYsGuLt4mTpoZgZbD8PZ3vGD+Xnh/UakrrzAjTeMyH
	 lWJKovL3IAC8O0lqEvLHp6rR697Jq7xWDVo43nbxAyEAvrbSoHezmQ6QJfQHhU7aS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JN59o2IrulO/4AW9envJpH0TNTRO+G/D0wqHcNq9acE=;
	b=wq3x5kSF6aSDRoZJsiJG6Gf7Ba4AjEz78zxl32An/uULShZ4jLBcQvf905zth2VjTmPP
	 H7ehGdhgr2mm5nVyY0pIq0HA6EfFEvijT06e8pYY6GdtiRRJDf/cbOdKQcMtf7F5ZgY6F
	 jtshEsnGfFmlQXj5QHEkBQc+fiG5YF5fLVGArnqYV4stNF6nvDyiJUjKHXZudVwsW+fgR
	 5Ib+F05eK/NULOVx2Rp+AL1sVlJqRL9pwBQA7DITnmMxf+9NrgtVKuYH5iRGv6Fnfru8s
	 xK2kkS1b1ev6tAJ3pkGf7O5lhbBgkrabHPDgnSVQb8KlAiLlQQx+9Kx4dwSWji+KYAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyGTiCso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AAC606A333
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyGTiCso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B411F000CF;
	Fri, 20 Nov 2026 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199607;
	bh=JN59o2IrulO/4AW9envJpH0TNTRO+G/D0wqHcNq9acE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyGTiCsow36EJ9HuUmj1EeWyvipl0Ju74uyyziZs+4PX0YT2uRw83H9rqLPskdOJR
	 P5yrxjybqS7X7Lb9nIQKLJt3cPGO71YkhwIJv+ndc7+/w6HKi9V9zrh9C7yPipvZm0
	 iFsCTF+L+SkdPqoM6jaEbsS30ZWMbsINXHyH6BMwQSSDTMkKqCUCG0XMs37kp6FcpM
	 Yu+SbN2My7dbxm6Img4z2hx4L+1tUB1cM2JuBf3xuVUXjqxk4rPzrEnB4eOks80AlH
	 VRc/Pwp60HRL0bKe1IF/vPeepoWDDbBOf9e6wO4RIQCg3WFARPColqYCQ29HWBe/fu
	 bJrBPFKTJAPqQ==
Message-ID: <sashiko-outbox-225841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 52/60] mm: count memory with userspace placement as
 general purpose
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-52-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-52-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:33:26 +0000
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
> Userspace places ordinary data on N_MEMORY_MEMPOLICY nodes, and neither
> the commit charge nor a task's RSS can tell nodes apart. Treat their
> memory as general purpose: totalram_pages() and MemFree count it, and so
> do the limits sized from them (overcommit, OOM capacity).
>=20
> Other defaults sized from totalram_pages(), such as the zswap pool and
> tmpfs sizes, also see the larger total, as they already do for memory
> the kernel cannot allocate from in ZONE_MOVABLE.
>=20
> Free memory on these nodes serves only private bindings and migration,
> so counting it in MemAvailable or the global dirtyable memory would
> overstate both. Add common_free_pages() and use it there.
>=20
> MemAvailable also assumes about half of the file LRU can be reclaimed.
> Reclaiming file pages on these nodes frees only private memory, so
> count only the file LRU on common nodes, via common_file_pages().
>=20
> File pages that reach a private node through migration stay covered
> by the dirty limits' file LRU term.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D52

