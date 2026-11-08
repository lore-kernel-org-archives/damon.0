Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169361;
	b=DueBlpWx19MWp9+X1/cuyzs5CRCtcBCNtUUKkobNAIdl5xxGqlpI9M6w+WhAmHSAFRya
	 W6iZ5Ea7GntRulcjOGLlJaqkktxJfe5SUAsbbsZNysdF9ojJ0IaflMMleSeoIAStnGTTo
	 lgejE0a6i4SyRhHVfvRsESn4DclR98ugh4brqfT2BKH4G5WxvbSh8+LIKBSgVQ8YxShd7
	 df6isZY62ZvCSqNh8Ke2TPBm/ZdpTkqD8Zq2ElnSyFntOp5xeJjz11/QrFH0BvCiHHc4f
	 zNSXEMJFoJ9a4JlRNQy+AYVwgknxRtEiUsZdKsegI2b5piqH7OvXPLdwON3Dym/u+eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E+p18EIROBMxVD0jqjnHNJu4f/pkCw6LWfOkniC3yrY=;
	b=HgFWnimZZ9ViycFtXVe35TDX420vXSoNbvVBx28TFe95rxICgDN3ok8Hi77qFiioZnx7
	 ltp4eenlSSG2Bpc+ClKrlB54bDkTUQuQG7a1mAvCPYmXugeCW3d9j/1WgTbBTi7UPeC/V
	 ckDtFi5C5LJKqdbToFxuD6gaFEU4IDdnw02cN8rQfRadhSQ8TvR4fr/JWezr+w2sMMAzo
	 8SGb7HpMv3z/eZJHNJcBH1eIyTxZBpwR1sL/CcnM1rLRprQVXazZ6vL3osQTd66Sb2Uo7
	 YuUBu8u5OhmlCY0A9w8SVPRWInBOTsupY1Bm/ntx6nnxhpi7VSYgz5fhbLVR3zY/2Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIIjMVmJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBDD606A9E4
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIIjMVmJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24A51F008A2;
	Sun,  8 Nov 2026 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169360;
	bh=E+p18EIROBMxVD0jqjnHNJu4f/pkCw6LWfOkniC3yrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIIjMVmJ0IoLocPRkq8vYnTt3TjVbqCsmuDCGAreDvYqMLV4m/WiPcebiOaYIxEYG
	 +qWEJ0GashwjWIjx3AaFv0CSXCszpchPN9OnVscgMqtT+wh00bjFtfxNM6cMDp1vym
	 NeKQ2HwC+dXegk34jcM1vXA67y+dDoIdcL5x41syTCBjXzO/bmFKn45U+1UESQpkZS
	 5nFypZiaIVzCcmv4IUtQQxKFSm76IcI79OGoZZRyBxseGHkfBAV2aQIVgbK8IphzgS
	 OjjY5a5M5Zlfeb/e+2PEezklAdqNnstc+Rgx4xhb0GdREvo385L7SiaI4i3iYPqJb7
	 hNBdzN0Nr/orA==
Message-ID: <sashiko-outbox-204012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 2/3] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108201456.116824-3-sj@kernel.org>
References: <20261108201456.116824-1-sj@kernel.org>
 <20261108201456.116824-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:22:40 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When an address type DAMOS filter is configured, DAMOS tries to split the
> region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash or
> leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that the
> user has excluded via address filter could be a surprise depending on the
> use case.  It is only theoretical.  No such real case is found yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
> Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # 6.6.x
> (cherry picked from commit bbeec2d8324d7aac438bb12dd2d22b184e0a8d43)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108201456.1168=
24-1-sj@kernel.org?part=3D2

