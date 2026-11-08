Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165630;
	b=aJwLW+MZUBAFXt6XElLwS7JVIHbl9sDyiw3ftkU10GonQL85wsCBnSgUf21HRSqoXejR
	 734X+TKhTfI4ozcnxM9SlY21siyWc16CpLhe7EGsYvUWeqdoGwWXdCO47VloNcwyrjLDV
	 R76BfueN5yvU/cEK1sBVt55e0WdujD7Yv/KeSXS4aAeu2guVzPjZmJeQoOCPCMtYkg0nI
	 9rva9p35nEwjL/8w8rocQQgypVs+i8fLXliHgba8S2tvugbXTObT2moVptvNDFD1q0/0T
	 pJ240pgxHVGetgqRP6IcMwFL/MUTS7wcjHQLHJAFHvDOKkwCTj6AI20opTfFQH6nk3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IziNtHj/KGlzUfjo1qWFxFt9XtVnYir3qiomg9xazMQ=;
	b=tO0yIOHb3sGnQ281A9SP0VGCNVz+k3eP/qA/wfNMzGJfRbGmIIwbkEFQmUt71+O/9HAb
	 pizjg2Uz3UMfQ96ct72faiwiP9itaX6Q8yV4L7QQL9+qgcARRlQQhHoagixsYHVJJQ5/X
	 uzVso23293W0xctLHiPMX6KGRkd4nKn5HjL5xoyyp2ZtajJ2CFxkSQpp2m2wUyAxnzcaS
	 g9ShzM+D7IlVwDiTRrRlRBT5lH48CiWtWDhMknFSE2zSYf35USgm2HKcKtr0TSILRAw91
	 DrcbiVKBigIBsYP2XnFokcQ62FY2IenSeVFGJ+CJDQVF0OD7IgdP+uNd7ttfWZSv2Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqWxkaNk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71747606A336
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqWxkaNk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB451F0089F;
	Sun,  8 Nov 2026 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165630;
	bh=IziNtHj/KGlzUfjo1qWFxFt9XtVnYir3qiomg9xazMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TqWxkaNks0AReq09Gwsn5nq7mPekWL7pYeEY24jiEXhRX979V4cOJPBQSKr0RaMbV
	 2xHP2dZjcmbJfCfyQolGIW1bQ8Tkkys+DBDfU6ANcHlyAydFyE6CsPRhkVcl5IV1V+
	 U9HbW05fDZV6CwetaLi0SRXGKs9UJviyxbDnyCcW6Uc2YRuHA5RoXBVH43gFfEXgtF
	 QAWDux8LWaLXns3e4+8/VMPoE1MvWeeIVrqKEusx2E9/DMIsAvH6q5Nq45AaDJo2u6
	 ZxguYVd+sTII+QpezWxipyMXMXZVZ/KrkOXAkY8de7uQOP1tsFIFUkErobTnMsitGs
	 EhyXLMTCwxOIg==
Message-ID: <sashiko-outbox-203937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] Docs/mm/damon/design: update for
 DAMON_FILTER_TYPE_ACTIVE
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108191615.113362-5-sj@kernel.org>
References: <20261108191615.113362-1-sj@kernel.org>
 <20261108191615.113362-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:20:29 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly added LRU-activeness DAMON
> filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108191615.1133=
62-1-sj@kernel.org?part=3D4

