Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088642;
	b=Gml5gZCqZmV26ci5OusEMWm3U3T/OxS4ngouhZLnQzBCYx+9zTo2QqWrBvKUYQkJLISb
	 LZyOpYpZh5w5mkLzg8/G2yQyC2ildqJsq0AeQh0fr3UrD5pIQtBA999QybEmb/DlboqKZ
	 uSQ65b2Ti8Ep9KTBApsf9qi7ziIYI+WwRoS1oFl78S0viud2heT+ZdiD4VoamgcCS02YD
	 pq5VgiYNYumR0g4iaCqy2xl2CwPewyznBX0xB6Ju5aca59Y+xHCPXHhsuRQ3N94VWlvI6
	 6L9TeWbPUgCDphZIRiAVhAbTi1Pt5uHhVYoohDlcWqzJ02CGDb/Jh8ZxyYJ7KpAJDqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gYYMAa5YBdy7N6uvtbUiMSIXqva0kg7l+5Cr4FSw7KA=;
	b=n54MWL1Iq26Kdri9dF1zEWQh8KthnWaB3IlgmMSNKOk9tIrXbKUa0CUeTbvEIqVUqcUr
	 aAB8fy3NfH77R8qub40Wtj4Md2159+xbpuubclBZpNfRMV9DBTCFFG1tSV50rddrFQb3k
	 Jvia2/WtiHuIBAApjkZf7wK0PE/wJvD2g8ZcmgCR9OmHbiNy6Z1MIGIS8RYIScwNpp+1H
	 O71RlvR5Pq7ifFxwY5qzsASraHw4VuUHMsRjU7I2CXP2K8jLpKk3KICcH5sjxvS2Zroa8
	 4eWCTGZBxTbY2LBLA2eLEqsnNk6+2g7qibL2p8VpSMbufSXnywZjLSzETszVC/qljAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO9cTSHz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2A606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO9cTSHz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6659F1F0089F;
	Sat,  7 Nov 2026 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794088641;
	bh=gYYMAa5YBdy7N6uvtbUiMSIXqva0kg7l+5Cr4FSw7KA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YO9cTSHzeCfScxvX9pJuVxxsms0m9wVVYS5s2Ug5ZPGaO4EhtauGb9CRVeIyrafyG
	 4KrWPF/Nh0Mu3PWx0346Ot0v0w7oHHRcO1QHk/usDd4CWg/YhsbCYaGy4kSDAKdzIV
	 7QaMnX9Dvn4PLcLal5nOROI8w0LyQYqPLmgKCI+hFOeZXnRDhd/iA3n6BkKIOp/QLF
	 sNCA0Yutd4rE12CnNDQJZBj8MPTQtjtAMSF7Nr3Rb8cjc11J9Fjide2tG984K3b7NP
	 ZHdABiCwaJs3SA7x2fsuhJUKL6GlRcAF5cVshVKH4UeQ4Ej8aL3DG0cgQD6SJXxLMo
	 OnWjEwQMhbaIw==
Message-ID: <sashiko-outbox-203349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.12.y 3/5] mm/damon/core: handle uninitialized
 damos_quota_goal->last_psi_total
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107214525.304638-4-sj@kernel.org>
References: <20261107214525.304638-1-sj@kernel.org>
 <20261107214525.304638-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 21:57:19 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.  However, it is initialized only after
> the first feedback loop.  The first iteration of the loop uses the
> uninitialized value.  As a result, the feedback loop can change the
> effective quota in an unexpected way at the first iteration.
>=20
> The user impact of the issue is not big, because the issue impacts only
> the first iteration of the feedback loop.  The feedback loop also has an
> internal cap of the quota adjustment.  The wrong adjustment will soon be
> corrected over a few iterations.  For this reason, doing no initialization
> at commit time was intentional.  It is also explicitly commented.  That
> said, nobody likes behaviors that are unexpected or difficult to be
> expected.
>=20
> [ ... ]
> Cc: David Gow <davidgow@davidgow.net>
> Cc: Quanmin Yan <yanquanmin1@huawei.com>
> Cc: <stable@vger.kernel.org> # 6.9.x
> (cherry picked from commit 29c6084658af41b5b1fefd873d26d441830ced34)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107214525.3046=
38-1-sj@kernel.org?part=3D3

