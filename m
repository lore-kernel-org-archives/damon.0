Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155035;
	b=r7tZ94ph/wDvOg53G2Me+hes+h0Lv+jnudH+FyWjzLJ7gqSWmwL6fZTi0OFy9piy3wLU
	 X2h7PnoZxRqx8ldQ5g1pYkVJS8aI8bVhCsI9j+CgEY9JmFPQ+oT4N/ZN67huUNqUXqxwV
	 PSYVgkY+RAfpbWzSOQS8V3cZvq4sxtIBvmSWU2HRD867gbAq03xwZU6OORV11JWLSdHg2
	 4hxJox169KaMMSMyoPYuf0lrRoOaoaDJgnGqjwBE9Os3Ml8YMPCm2nq3IMTALUxy56buy
	 rkPQDIuuaPOmga8tv30ZkxTtRoE4UGftL73A/rgdDLkpa8xa6pcEp2XMwfEcdjTzxCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fxxP9MgmlQTQxdD9nrx/7jT5XffBKYdRo0jU/83Ed90=;
	b=C3zHt2WiMAp1Pjs92rAO2TmNs3dUfDo7MdrpYj/pJ2FxZ4TgPjv23Zv7P7+TSa3dB5LO
	 NuBAZvloBRH4oaonu2BsVQ+dJDiX9Q+wkhJprYr9DHiV1iimxGaZWwKegKwTldygvZA2I
	 PSQPV2vL9LpZPcDHuVYGj0NN6kWKgjS8PQPYERutXysnkJ5yyj/6LmxxmtRJ6HDVLxW25
	 4A4N2XZCNemqS2d4AfzvMAWnf09zbebRFbjl5/cS9QwQjRGbnZz6LiQXm2QoFzD8gyf4h
	 3AijU1WEq7euOUei0ASFg00FPFoS46J70zohYRHpY4Q1jReUlrQFtnNnYR+V6HSD+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDBi2kxR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244E606A516
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDBi2kxR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9091F000C6;
	Fri, 20 Nov 2026 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155034;
	bh=fxxP9MgmlQTQxdD9nrx/7jT5XffBKYdRo0jU/83Ed90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDBi2kxR+p//YA64OLBW5TdNre8g66WVLczlsxSi6zspxDBQgfZWNYW3hTQwVLaJY
	 PDstFyZOsU8l9SZyOBRnVOXJLypYK7oTGkgvDHCkgzp21yUK1hn6hq9aznzJYHFP4Z
	 8DPxPCTK3uanEdoRaAlZMcL73m4y8K+biXkPauHgC42gE+5axkgId73JPhAvZteKHa
	 F+X/a0/LjJb6nf/QobiD/Tw9xFr89FH75fpaZGcf/6L3jG/wsuauDlO4kG+6ttWbjN
	 8bKPeYOj6Uu15sbdMFBX+15kUT7cdXz7CZfx8M6vyJgAImpJPVs+mBTaKjMyTxBvF+
	 UBGu9/JZ0Ev3A==
Message-ID: <sashiko-outbox-224539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] Docs/admin-guide/mm/damon/reclaim: update for
 changed default parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120060741.92121-5-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
 <20261120060741.92121-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:10:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON_RECLAIM user documentation to reflect the changed default
> parameter values.  Intervals and PSI-driven coldness threshold
> auto-tuning features are enabled by default.  The free memory ratio
> based watermarks feature is disabled by default.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120060741.9212=
1-1-sj@kernel.org?part=3D4

