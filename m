Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276146;
	b=pnkuTgEbmZJQ2GA8h6xPiKFBj/0Sqbb4v3YViWlTieVQsItc2Jj2Mvp7eT5bUPvPl5UH
	 jXxVLdeYNE2yKmJq45IMsGjnYejtS6K8Z5ilnM2+ADyTP4+GIYDcRQ5Oi0uICg+VJvHT8
	 ATcdZx/Kyd/46WL02S0Bd65jf50qSftixDQaVvoROToVaoxS0Ko8xJE01DMXoi+e15XEv
	 qzNI0tsQwUEto4U+59R+EZkA0oTGOWSurgdtSUU57vKdXOAVmVnMaqlARdrsKyuenPBom
	 IPXK3da8wx8RyzZ7c0fXPhmrdmHttfPcTk3yq9RCR7GEnlboKHPyjtMNuNLJnAaizDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276146;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K8470TKDqPRzUoBBAzOxqawD61dJiXZ+DySi51AnrbI=;
	b=mvX6lOBWCamDUFd1yW02zWJdKOQFJVD4Ji8L0n63QSNS4VoeRIg/DyIvAlNVGd+8Uv5j
	 Qc8RhviD+M0LyrvogXGqjsYUgoXD+J/OPBRdjZvdEpqB1Vye3rZn5dpjR0/XE92zJaWhq
	 HIH6OLwfUL0WA8kvG7Y9u/PorGDuvCMRo3bG2g0Ia8PVnm6tkE+XP+3UU6cXD/56txLIV
	 GmPFTrvj4wfR3Ari81ylri7GkbfFNxFXZtfP5ttn/aCqnQUAHrH3YkAyNiO0LPZTOcsEX
	 N3QLoqPrlZpdE/9XGFtte2UMxk+mQYn3V5JeflG1vOf5lRbQJ2g4IWVa/ogDRXD5WDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYvRS+1R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D7606A330
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYvRS+1R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02711F008A1;
	Tue, 10 Nov 2026 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794276146;
	bh=K8470TKDqPRzUoBBAzOxqawD61dJiXZ+DySi51AnrbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYvRS+1ReLupPmH2334fGEZ/qMQiFk49waega4vKCEp76ZeNgZeNH0mTLaUkgrd0k
	 KFDMVFL7oPUhRujDC4gSTQAUaPa2rYECjQH5WOA+gOp36UmrdvLwJahRT6xnaDi/9s
	 hM234oJltECDUqcpgIeJU8NZAnac9sNTF1uysXA84ZgDC02soKRNjU9xlZC93qwiyS
	 Md9ony8Ge7knsPvoK3cAIFt/iBNGngCnMxNwcoDfsihhXFJamHTifMgu42zpK6faFA
	 GYOG53hDUfOfXByBq03G6yVBp0QsThzoxgvxNG2H1RkqelcQWIOcHw9MxRS1sbwqvi
	 4fGHB2RZYuS3A==
Message-ID: <sashiko-outbox-206013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] mm: zswap: fix shrinker count for the root memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110015321.611093-2-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
 <20261110015321.611093-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:02:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> zswap_shrinker_count() scales the number of freeable entries on a
> memcg's zswap LRU by the memcg's compression ratio. That compression
> ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
> stats.
>=20
> However, for the root memcg, the zswap entries owned by the root memcg
> itself are never accounted for in the stats (obj_cgroup_charge_zswap()
> skips the root objcg, and before the root memcg had an objcg, its
> entries weren't charged at all). The stats only reflect the entries
> owned by the root memcg's descendants. When the root memcg's descendants
> have no zswap entries (eg when the whole workload runs in the root
> cgroup), the shrinker reports nothing to reclaim for the root memcg, and
> its zswap entries are never written back by the shrinker. When its
> descendants do have entries, the root memcg's entries are scaled by the
> descendants' compression ratio instead of a ratio that includes them.
> [ ... ]
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110015321.6110=
93-1-joannelkoong@gmail.com?part=3D1

