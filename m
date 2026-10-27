Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110361;
	b=UUo6xyke85YLsIbLtmQ/2d6EyHE4nz4CnHrmhmOkvnoVL6FShgF9e1FwREBcAJnDjxOs
	 SfZoriO38jclWgwpW931jD7E6J3j3QKoUTRF3USYFBolj3PZh8UuQZ+LHchZ+wMWEMCk2
	 8BwCvc+3L+3EuS53ZhK94TucyGmrlkXSix1esdR4pYWoOrsRSRpBgZ3WHYGPULJfWgquX
	 ZVowWHtPL/zP+qlfbQYBa+v8XZrHWAYxcmEj+2vJLQoGKZS4ByGvsYVBMGJCtCb8fUQRb
	 KoXgGiZje6SNP1MDOE/0ZW7qLwMtRzcpE1StErL/3G5GkrQZhRVZN+d+CsXUutcaShA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AOn4NjsPX6fcPJ3O4vawJViGUwxd1kxioIKa9mVnYOI=;
	b=FJzSGQX6NUjH4KbPNQMHsE7rDE3VC7/d31OLHHOJ4pv5JPDRfd9PTQ1l7uQJne68vNPW
	 XgMDMGbDdDrZ+u2KHQZm5OjBrmntTikHiY7RFMTw5sgb1/Ytxzjq9+yp6CgvL0cjVsKjn
	 ZJFUXmePzugs0Y72pC2AlF7b0G5fJpTog60D9yjsPVGMKZaS9u5d8bR/TqEJiVk7lLOD5
	 GXfFoFfQSPXpu9SdL3fKzRsbJpCQUXZdhp5a4RSdo2AJAf1HOuvSScjhqJFASg2O3K0Wh
	 5sP75eSB8wElVYIpD4pbIbzlWBa7IPSFI3ByLQEGFGlv5bXJoQSGt8v0KWcNMIz3VUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi2ZMIT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C3B606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi2ZMIT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C321F01825;
	Tue, 27 Oct 2026 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793110360;
	bh=AOn4NjsPX6fcPJ3O4vawJViGUwxd1kxioIKa9mVnYOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hi2ZMIT6RbOgWl6qXEYNJoC6IENu9CMHBZVhggkL9uat42QcPsXBI+qEfGBeJHqWw
	 M2TWsEzHEpffbpZ5a/rQ8hSLHlzluthLMgkcJohMko0a8IK1fICIffCc0Wdfk8TqOm
	 2nb+Y0LGBA+MDpINVXr83dMM+uNAZDDO1QnCExvVSHmd/cD/g257Lp6oIPEUk/qe6I
	 nsTT81ydsNA4w2QVYYRsS04uxgAvSr++QbzyB0hoPnbmUKwWvOktM2iWYJ7h84kaao
	 yiRN4NKxhzQehOhRgg9hcwYe3S6ky6TYTE5IyHFhn2Pwa4KcQ2nH/FmPZH2CLmu11p
	 tpdwL7TkaTSOg==
Message-ID: <sashiko-outbox-186714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/damon/core: avoid overflows in quota goal
 metrics and scores
Reply-To: sashiko-reviews@lists.linux.dev
To: "DaeMyung Kang" <charsyam@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261027135932.2301646-4-charsyam@gmail.com>
References: <20261027135932.2301646-1-charsyam@gmail.com>
 <20261027135932.2301646-4-charsyam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:12:39 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> The node memory, node memcg memory, LRU [in]active memory, and hugepage
> memory quota goal metrics, as well as damos_quota_score(), use
> mult_frac() to scale a value by 10000.  mult_frac() multiplies the
> remainder by 10000 in unsigned long, which overflows on 32-bit kernels
> even when the result fits:
>=20
> - For the page based metrics, this happens once the numerator exceeds
>   about 429,496 pages, or 1.6 GiB with 4 KiB pages.  For example, 2 GiB
>   used out of 3 GiB returns 1205 bp instead of 6666 bp.  The LRU
>   [in]active and hugepage metrics do not depend on NUMA.
>=20
> - For quota goal scores, any current value above about 429,496 can
>   overflow.  For example, a DAMOS_QUOTA_SOME_MEM_PSI_US goal with a
>   target of one second and a current value of half a second returns 705
>   instead of 5000.  On any architecture, mult_frac() also silently wraps
> [ ... ]
> Fixes: 4835e2871321 ("mm/damon/core: introduce [in]active memory ratio da=
mos quota goal metric")
> Fixes: f465dc71aba0 ("mm/damon: introduce DAMOS_QUOTA_HUGEPAGE auto tunin=
g")
> Fixes: 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
> Fixes: 06ba5b309ed8 ("mm/damon/core: let goal specified with only target =
and current values")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027135932.2301=
646-1-charsyam@gmail.com?part=3D3

