Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022139;
	b=19+DgL1BLbwSP9w3DXQDdgwvwSLzQXak2A/s8sMpAwGDMSU3E/4nYPzsplG4SAt8YSvo
	 IG03u5EbgBzu9KEZysUIr/CvZN18TtEPqbQmLXkHR+w+GWh/R0pQ+KRXv99yP5CIlOkj8
	 DRu6L/zL8XpnNenWgh99fg4aXNFq4QlozlSGAjiOCnLh7V7nQ9PFMtqSXSXLJMZurEvUL
	 NRY8Ql8H/ri3oXjKDGtK9QFzg2osPmwA3yIcUE8x5YDRsVY6+GVuh8pNnTvIzmcemSLs6
	 CdfnpGN2A8t1QWxkORy7cZFI/ZitPfbxAO4oCwyKNRwFL7b9q2FNMin22iddj0OAHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j8QMB/Zbu3pSmjToLJD1z99Ta8FDwHJe8fx7RyfNJg4=;
	b=4bGeWV2HoGy3SzK0qGehCjbPZAkKCID0P9kWiKTe2di3VJ8k/t0e7RZXBJzKM74asznC
	 wNIgXhz6y/bb6yq2gLzupATCVrz7aUfYwHqtHEwUnoEivx0c1iTehLtVQXzAaBJcK44ye
	 qLi45b+4I4WsirUXMJ/yVHCD0sTTB5VBVIMHEfm38UmlbfVpQbw1hEK9cVjnVRJulXzpv
	 yYTymHhapC3dhOSTcnKcVDgl3g6KZDhdNA2E5Ze+PoVyU5Yy/nFYEZN51uBZGs7d8yqmS
	 f1E95kRAtkZNieSrEzeuzalSZDUhkzXryDIurCZ9a8CY6D6QZqjjdkuv2rSFMrco4Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fj8tDop1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF93606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fj8tDop1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1177F1F01825;
	Mon, 26 Oct 2026 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022139;
	bh=j8QMB/Zbu3pSmjToLJD1z99Ta8FDwHJe8fx7RyfNJg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fj8tDop18bzlC2y24eWNfPWtWYCVsT4nPzEeylC2GKS9CHz3Kbii4Pw+9/SUks097
	 qYJyGKsM+XsmAq/OI5D8rrkASwq+swvbawk+ptVIk3UaboVXmlGjDtpb2kNchhcP2P
	 JySshc3IqrYhyZ9hls5GwIG+5HcK2Ulx26pabQ8xxiM9HeFUNfwBv+6PUaOmR2ZY2V
	 ToZz1HrPHVCxkX8E74buUWw2HNG1Mva9TmPE2x6OXVuQHDVuzNihKp5EKOmsiB0J5x
	 6nT28j6XCJLgwXQkJEM75amkmWH+pLvTgGi0v1UlprM3M4YokFFWvF2AJowiW/dA9b
	 4gJ8i3YvPYAWg==
Message-ID: <sashiko-outbox-185325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.3.y] mm/damon/core: error damos_commit_quota_goal()
 for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026133320.68445-1-sj@kernel.org>
References: <20261026133320.68445-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:42:18 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Patch series "mm/damon: move zero damos quota target_value handling to the
> core layer".
>=20
> Having zero DAMOS quota target value can cause division by zero.  DAMON
> API callers are checking the target value parameters to avoid that.  It is
> easy to make mistakes in some of the multiple API callers.  Move that to
> the core layer.
>=20
> Patch 1 adds the corner case handling into the core layer DAMON parameters
> validation logic.  Patches 2 and 3 remove no more needed DAMON API callers
> side handling of the corner case in DAMON_LRU_SORT and DMON_SAMPLIE_MTIER,
> respectively.
>=20
> This patch (of 3):
>=20
> [ ... ]
> Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 610c4438fb66e06d9e693c0ad3b2c1be54c0d61f)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026133320.6844=
5-1-sj@kernel.org?part=3D1

