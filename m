Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667715;
	b=b4+JWaAJsnJqB08ExqhNgRWTveVgJXYxEHM7VX77geuhPUoY2qEId4ECMd1ZqOwUmGZL
	 EPjqBbX34WalyuFkyHy2Of0zxNUw4W/Wg/uY+7jHPfUpheEie6mga4gcxv7itLii5nANB
	 rxJAURWs/fte9MvJK/U2lUoe0huZc+zL6egIYw7klmTqRjYNCA7L7HKnLdbwynsa9LcfG
	 dVbA/pXtzmefn0PsHBY6kS9vgymsQz+yvLHRA/t3EcUBZkFt+OY4RoDg8WJI5BDW3eEHY
	 HZoHFbrWyMy7xR95Nfrt/aztOOoYeCbxldqi4gW8aA+CsxrUZGiVOp8FRGQl1CMRIGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W78gqsXgZFRomKqv97kikLrHwpe922AJpMbZsKckZf0=;
	b=vcFa/ddxBhYsq7Jkz7BDgsxJ1Ck2RNUz29T59mPZuVgdsfLH3ESDeGETkaF9WggJrZra
	 /3POgda/5kqGx+8rl0SCWT6OICGQXOQXYuZHe9hOAQlqF6E0tTlY6vas2+3vw/h+YC1jI
	 WPQtx0upCsxQyMByAS33JreY0ilYiwJ6ltdnx+aiCJ2Qen3cCY5hny9wikE1XHv+8M8F6
	 5nfdtlua6cEzfr81PZP4+6NVXXX/a3AZW63HI/qCXC2G4HLJ8TCUopcK79hqNZ6mO1bTv
	 pQODSJQzBCurUD+WmjKaFTYLfztVZsmM5/TuXHD6sa1ov3Os17+XVslRYFJPIO/9ukA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k+08vU/p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15210606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+08vU/p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0FB1F000C1;
	Tue,  3 Nov 2026 01:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667714;
	bh=W78gqsXgZFRomKqv97kikLrHwpe922AJpMbZsKckZf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k+08vU/pWxv0VJfwHggVCDWpFKjel2icPmptHyKJeE7qJPF7W4TV6thb6JNT9mM1l
	 IP2p2LmLEWpW8c1YSUSTTCBaOCNNT5Tm/ZPrRN8GI2GXImR0N3mkTZN9Sim5RiX+DC
	 oq8REoVwhvXz5a6EkLi1PrrLYL1Kb/IWwic/AW/GhgZXSBiGyR48L2NDPcCUmH+iUc
	 iLvB78miOcyXmD2X8yhSJqT0fBcRYmXwt4qCyBP6+FXZHNkTl5ifmq5anSmJ3Kvmvc
	 OLSQxhssLRLjbPtU0PEIaN7YW7AKOJJhIR3WSKBz2M9Z/CWXJMC6pM2r7nio3DZHYP
	 q7/e5eEMJ9XEg==
Message-ID: <sashiko-outbox-194414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun
 agreement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-3-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> "converts it" refers to the access events, so I think it should be
> "them".  Rewrap the paragraph while at it.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D2

