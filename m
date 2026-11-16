Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857488;
	b=1qXaheWTGf+1cdBSMGOCxsTrquX1nw2u+HN0oQ/rEuolqcRUIRC0pbPJj0cQret08I+1
	 27bBON434f1Z7khjqW67ZqQSH8pTABergLfweF5NuqR82MQ4Br5h1BzCHjYtnlmivZ4ef
	 Z5+7VTfehxjScX5UB8qY169zvOURo6fCfR/WMxI+kZQaBDn7e52ney0grFZuDnxUwpZCf
	 cTtskC2OP/f5TDlTorbLBNxHB6ZGmAZ5yRNbzQsLSqeBPR0HZ+OX8CImGt7mCP0qdgPzl
	 Cdw2lomqopp5jvX+w8Jj7TgdvuRaEVio7So4eeXJuOf6z8G3srRDSw1kbZTpowvkv5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KVXZvGVmtLy9ZnZAXeYG9G4MmuMN/6JReDXNa9EkyHc=;
	b=2OfNvknHa5u0PH/nh/P0WhYJCN9ltvbrxR8CourjdFc03Vi416OUlxoEJ92KJ9EX9DP5
	 gRcetJKCosrLxEXw0mTfAXetYkFXRT1D/62Qg0WBX4zc4jzfJvruJ5DsqehrdNhbA9uPS
	 /9EPGTfyUSTpSUN6zcfA2CF1WKsNDDhMTZogXbHiGaFpGEBAa3KPeTYkhZQJSsHJ/4TFf
	 qZ/Wgrg44BM8l09tgDdqCUeu8Rw7Br0BgPcj4TnO9HELKJxbxcXagSMhaDBo2YVRJKOr+
	 /SNm38NT5+vCuU4Ak2+40vglDj62hEEG8JgDoD84n5QcD68B3tQSHzvRmDa1zHtD9Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5hgR+Fn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710F8606A31C
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N5hgR+Fn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A991F000C4;
	Mon, 16 Nov 2026 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857488;
	bh=KVXZvGVmtLy9ZnZAXeYG9G4MmuMN/6JReDXNa9EkyHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5hgR+Fncru9gfl65KFmA26I+1EIzl16L+R1AQzfOFrzhJTKAUUtvqhZxyWurxOOX
	 WZfrnPmb2dd+vmatWyVQBqhJ1flmUoMZFMXM9TWaXGemB7p5HM8/AW/8H00/swjlWC
	 t1aOsK4hPdRKZ4J9BZRy1G5PQvAAyH3PVXoCuWlIlTiacfZKgTQ0VVokDlT1w4PUMH
	 ZS0Dc1vvLFmWYMuq3AmyJOTZg4ByhtZeyRWRs/Xp9cQt7JQOdie/GEvnb3vWDl2prg
	 7X1yo/Z/TwLChR0GL8ChyPzTlvgkwAgrEOR67P0pVI98Cc163K1PnX27Hj7oZglcwG
	 o4FxMd/9QsOww==
Message-ID: <sashiko-outbox-217567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] Docs/mm/damon/design: update for
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-damon-sz-ops-b4-v1-4-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
 <20261116-damon-sz-ops-b4-v1-4-1cffe7227e6d@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:31:27 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
>=20
> Update DAMON design document for the newly added DAMOS stat,
> sz_ops_filter_passed_last.  Also explain that, unlike other
> stats, it is not accumulated from the beginning of the scheme's
> execution but shows the value of the last apply interval.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-damon-sz-o=
ps-b4-v1-0-1cffe7227e6d@uber.com?part=3D4

