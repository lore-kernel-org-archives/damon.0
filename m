Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795462086;
	b=WABcIlIZlIQ9/Tpi0CdchmSHIdZvqSryLi5D+Ug6/ij9x4QtN6XmTYj1DiZHF94D54wI
	 5J7VNDysI4HeGaqxj/XgD0YgSAALlyWi3MSSV3wFpC0aLpztyWf4uQGd2Pql3BMit6PZZ
	 SayfSe3T5BRght2I1130jEh8oDbP3/NFprI5sgV4ITmeRfaq/Bpsm1d+KSvP3V+qoorLo
	 6o5Nsahn7VgVTX8MtDlDDsB/MkLoEauVSGukqEj5RZey4xbaR0MkXTsylOoORPrdsUFY2
	 cIcrbPKXXGnL8PC+KK6Gfn3YZbLHS5hhNH8Qkew7tDwvf/jEG60GZcI33OeO8WAc58w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7Tnudxzyk0Eg/ei4lnQ63H8pexgLijrmR1TsGiR8vtM=;
	b=LQjPkq7+OhHhbvQxhFWY7cOTIy1Z0C4O6Kfd5fncgQYqxce/r8VSvNTxSo1yyi+QkikL
	 jVGGJWSh3RmYXO4ExJax9/JTCcBlsOwrbETs8ZdCdq0sHZ6WEthQnsLFjCJX57XEcFtCn
	 M3FGDNGffkTij4r7xM7YnoCmBmWE7JNFjJr+b1BZ4gse5+0VseSCH0F2hIOJQQvljHUi0
	 iuUlSZKeKySNofy/gBfuhNsUFyprsxT321vtPUISSxbeltcKXfZBMT1EJWVjWQ3QYA1cs
	 vWr2AAK47Uk5Ats0o8cHa6IoXJIB1M4nLD+Heyp+jX+GjA3UwTEzMyfSt7ZLhi32zVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM36phR1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9F606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM36phR1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2276A1F000CA;
	Mon, 23 Nov 2026 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462086;
	bh=7Tnudxzyk0Eg/ei4lnQ63H8pexgLijrmR1TsGiR8vtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jM36phR1jAqdF3l2rU9IaUSd1jNODQwWQxfB4sjpgm6x81neR1woV/apDxPxFM53y
	 qqb7VHxafzhPf9vcU0Y2C8gcTzg1AYJvYX8eouwrfb+BJTr0W7YnDnkhlKjNz6E3Yl
	 T3ApFR/woTXkG0JfiVm0RxdrmU4Q1v85jYpE4Xg2M1vYUe4/rAl8Ri59Jtr3D4+qYy
	 7LNPkHt3p/RBLOzpvxgbYu90IB87HK2BN+vU2FKr7XdbrV0GXpTQ1OsZSd9O3yQoBX
	 Cjr1uFKuy/ZNGEz1Xh4ub/cxrwBAnRSu+LmCfJ8EAf0AuRNjSAW2MsJzmU4g3XE8eU
	 HmDGM3CoZDGfA==
Message-ID: <sashiko-outbox-229934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 00/18] mm/mglru: frequency guided promotion
 (MGLRU-FG) and flag cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
References: <20261124-mglru-fg-v6-0-8ffea39934a6@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:28:05 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Sashiko has finished reviewing this 18-patch series:

- Patches 1-16 and 18: no issues found.
- Patch 17 ("mm/mglru: folio LRU refs based active/inactive numbe..."):
  1 potential issue (1 Medium)

A detailed review has been sent as a separate reply to patch 17.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mglru-fg-v=
6-0-8ffea39934a6@tencent.com
