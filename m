Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616419;
	b=gyMNF5FwgXmtqJtF5X3JjIuGiZQS6WvnEjakwQD2ZgmJnN8fIBCzMrqLt5Wugwj47ybg
	 pc4O01EHxzLJKW3mkNa7OwBneH4jhy9my4xYNDh/Hrtmah+mUdEikDjH41Kb6KmWNkk6/
	 hsvJi/s+CEwW+3E/qbjdOADFwTsnU8GoW9T9/EG8bzM9mYZoPKVDHoXx5wmJ7+Gebec0T
	 oEOP9N+WHWxT29cOQ+V+DX0xSaYhA9naoXAH7KBO5YOH4YL34jlWj3IMoADFlcOZ4usi3
	 6vaFeuCcy0nG+JRITVwQuZnh/nVs+St/Xy3e8gd+h8fdtUFVSBf03QoliNJiHjChoGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616419;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N+eZWXb5Uf62qKn8y2g0SN4gfQzT9PBSlQ0Bg+/E0Cs=;
	b=2/RrAZ6zX7y09qL3Wada8cKx92M6DiTIovpBvqxdaLPBoey15O2AApU5JOv5HoQ97g5G
	 QgXtGseCmtaANTI1EEGUijmcFGlaq2B+Jz2PoRRzfm26GJud9KDm70MbjLv85fCIXoQ1L
	 6DZ38SlYRtSp2DslbuPToqoTIQaDn1c4ctqgn999J8fAWNxnbDRI3zan+Hf3xageaAhne
	 uSLU5JKrchQR7MI1jepmecs3rC7PlXx78bN3qUSchWFUyxQLicvR0R4+G26YM33xjhiBu
	 wToGtghXfa/rY3kkqhyEsyFF55jGDY3cZvt2VO6Lz3D9mYaPN0B0wLNXrHWHS6teNBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StwyFpmN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDD5606A332
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StwyFpmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B718A1F000C4;
	Sat, 14 Nov 2026 00:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616418;
	bh=N+eZWXb5Uf62qKn8y2g0SN4gfQzT9PBSlQ0Bg+/E0Cs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=StwyFpmN0yCrYEirPC2HuZp8m7rRxnpa6/+7jvLcB0INF8IdR2eO6bMsakigwaUGq
	 OYEr93bcTkoE9FkCYK+7ewnjVOzU+kagfe+u2wfD6JX+uoedG0D0n25vb0sOCeYqAD
	 p8yFe2KSj+yqq+FjuELznoowJeyq2p5L/vn2FYdKg3JBsvekgy58YCvJY/LTu55kWu
	 pgjZOiKVQh8I+yiwEC6gITyO4K4yNGLuaq0ZF/sE2wJGBbaNLGC2eyhi/vMJLbe56X
	 DQElKAudLnxuEqDY1ZUDcme+IyEpuz6btwFmFhoYXXpryYDe9VAVYzzqQ347h8sP8V
	 hj6TH+LaRZlYQ==
Message-ID: <sashiko-outbox-213931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] mm/damon/core: use node counters instead of
 flushing the root memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261114002822.1043378-5-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
 <20261114002822.1043378-5-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:33:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_get_node_memcg_used_bp() flushes the memcg stats before reading
> the LRU sizes of the goal's memcg on the goal's node. For the root
> memcg, that flushes every cgroup in the system. The flush is not
> ratelimited, which means it happens every time the goal is evaluated.
>=20
> lruvec_page_state() now reads the LRU sizes of the root memcg from the
> node counters, which are always up to date, so skip the flush for the
> root memcg.
>=20
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114002822.1043=
378-1-joannelkoong@gmail.com?part=3D4

