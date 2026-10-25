Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949683;
	b=nqzjO71++f8DBogAwQ8hx4dtjOwvt6Of9jLvDNmfPcPCleGoJj1z34CtDcbJ7IGiZsry
	 oBnKb04liZLCb/W0lM0Sq8RaO1pb7ancdEnDCbPv+WDdEIP6KyV40diPeflj85+DAhYgB
	 60ZfKKCCfhnJ3NMOey74okkW5KJyJgjeEDyhSqyHzJL/pJx9o8LM2q7aDimwAPVGGenoX
	 z3g9C1R9lYwdVwRmkY+hg7WS3vuRUMRyoTIiTT7IUrjtqO9DN0ZWFmAEfjHOcaIi5FqaW
	 X8dmZ+uZduesCTJmxmphbZbTHKyxm+nH3r7O6aCVy4hdW8lddALBDkmVENFtfJSXpGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vVdLF3rSRfIbQqqzW5CTin+AfzdEC4jqWC2LKvMv3no=;
	b=v7hVqBlIyBsMND0zbY4NEvZwLr8nTyxG2Iu+a8Zf94fxPTou+wJWE+yJOuxBu9Hw1quM
	 8aC2uJJ8TrIgN/Jt4D8E0lHUmv5EoHd35YNWX5Qf2AtUum15wL9wtLijkxEYmeqDuyS14
	 Tv9HPkcnXnGVoICo5QWtjfNPzX8lGiiDg2K2BKb758vKrvX2fBhSpRsPIeuyFubOvCnv+
	 jMRkFlnFhrd4BWnIw9+I9Su3ZtGNJ0DjtayCFy3oc2me6zpo8eNuBLPUHy2ND/cifmY8w
	 n2gqhDLfZGYPlKJl419c3CSa2r5rVIJwa7YTkcfdPylgwVCfsWNmpsaTF6BGpn9Pjvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5rQDZit;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02485606A31A
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5rQDZit
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A991B1F01825;
	Sun, 25 Oct 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792949682;
	bh=vVdLF3rSRfIbQqqzW5CTin+AfzdEC4jqWC2LKvMv3no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c5rQDZitzlkLzCEwsZ2iQ+XdtmdxOAz0mFiqdq7wx03EWzZ9P5v0uKaFv2PNWuzP2
	 BvodoDK4hFYHwY1L2H/mQfOCj0ICl2AqF9bGii6q7lnA+gR5lqsg/indyLkpDzX0u/
	 LlBDnzyMG0DIg+NCARuF9W0a/poRuNae+B/EUIWCM2fbQLQITZO9NlJm5vTJpOmchc
	 +IOVtsrahDcTu6xVEijHGGWpeyIL+XMwHoN5d4BcT6dckVx5J4yT95iKlpIpIX4trX
	 jk4XO+HWmEBpw8ESL+/HM09bxrBOdd0s8p4IpYuGHAmIIXj9I17zK9+3ptpfq6MkIC
	 jrbb/9wWzwOdA==
Message-ID: <sashiko-outbox-184294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7.2.y] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261025172434.161597-1-sj@kernel.org>
References: <20261025172434.161597-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:34:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025172434.1615=
97-1-sj@kernel.org?part=3D1

