Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792947232;
	b=QHOpyIQLqkLpzOyu7ETmLVOd3uv67QeAf5lgLuKEX+C5TiYA6O82k4nESyUUeCpXu242
	 CkUg3x4ZT3l+zQTQwsSwkQMjsoYXO1+5ip6YDH6Zx7UJtTaB59zog57HMlB6ZBZXdNmrX
	 ekTJUbgda3sNNNDKu52kXE8ma0PF9dBJNEAuK7a3opPHgZip/KyTq4necWbvKDnSxAj9K
	 HpE9GmeAN6tk+X9ZJ5JEDMcTLuNJwv8hTUp+inctR4DpDAzsrTT3sgBu4RtLzQQ6IENgC
	 phQ/C4MHQu3iVlFCbxEiF3Cdju0v4atD4OiqBtFbcjHJrMFvMj+mr/6xk6nU0KgCKYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792947232;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4aXGV9omOA5pjV7TB6r8XBSmZPCz3U3HoTBjml181DM=;
	b=Y1cntz8APPhxRpiM0bwJ6uyTqdqzUPEwOgHd7vve0yXPXO2bviQFMErInVhMjSPPV030
	 ILXG8QO/8lGTXsflKnTjNeYjQa350tgcB1Sm/vWEuwP2zTxlsk/jdYytukCOcRHcJH1ux
	 FOLdVqnNEbx5lxbwohS8PByGXr0NUCpClgSdlN5WwdGJuC2/KQ4ZkcEVLUHwbCiCeAWMu
	 CUdUixF0jBytCnFEdj/n+InhKobj36dcihQLoOvM/V5cFuMklvPhjzVKqJQ5MWOgLK3Rf
	 kRcKc2wPS/h6b8QCDfZmMvGJ73FCRd+RSeCGmU7VdkSUQMmDGyqRDd6zTlb6bHyIvCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jc6wvD8j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31754606A31A
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jc6wvD8j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A475F1F01825;
	Sun, 25 Oct 2026 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792947231;
	bh=4aXGV9omOA5pjV7TB6r8XBSmZPCz3U3HoTBjml181DM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jc6wvD8jMx3JN2NRcPgx5z5Qe9DVWcG/hoc1nzXOj2z3DZV5V2/irY34FDwJxgjYi
	 JdQSreELmBpW0/OEkdZdAyPdiIRnNMqWad6EYRhVn2xEihnCoJO60pb4tWjSiqvlH2
	 le1PD+MUhiep7OrhF6OsFS1ehiHHVfkhkHou+7gkRbBtk7iLwyGhR5JBAnv9txiWlb
	 gnR6NoiefyehZzaE9T/seoCiJGZcSKgIwBknl/9+v8qyQX0PwwQgTU8eHNeRsxO6QT
	 5S/Y3VC6awQohxEr5UImF0bIB3kFbtuS7IZr/Fv5aCJeHa7uYx6qJNmVkskLDTUBkT
	 GrKA+LVSL/2/g==
Message-ID: <sashiko-outbox-184284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mm/damon/core: move static variable last_nr_regions
 to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261025164808.152048-3-sj@kernel.org>
References: <20261025164808.152048-1-sj@kernel.org>
 <20261025164808.152048-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 16:53:51 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
>=20
> Move the variable into the damon_ctx struct to fix the problem.
>=20
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Cc: <stable@vger.kernel.org> # 5.15.x
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025164808.1520=
48-1-sj@kernel.org?part=3D2

