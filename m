Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948954;
	b=xbt8exbJ2n5nA7AZLZB3lSpjdUi29IXlHrTNJQp3bw/dMCkzpVSxmPMZKGVom0yRfgo1
	 m+B/Vja9sJoi4RLsUDCllkTkeR19LNby31iHE4N879Qmo3ldkxDKiEKPbeVytoXRg4WzU
	 jd6Y7SZlL8H/g/y3G+rr+qzngdtF2JiaJWnGH4LLcuPUvQAqEbp7H2MGE0bLTluErqt7O
	 mhT8Sph+C1bdI7e1ipvX86crgFJjYthYTXB7hsz7fguX9OF8YLGHga0gIKNr6+GSDg/xQ
	 uhUSAmycMZ1Ci0I2LAayqM0D5MlPFuSXYtE5uCc8BTvmnBHPuINGEoO6N0aGrN/PyzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+tiogsU/KTiY6pBPcWTgQSEaUAPf8FqTw37NgszPS+0=;
	b=m5YOuRY7+3iSvKp3HuFPrA6vcdShVqOh4HvSUGUpdYAA+nzEogx0zTWuGbN7fCQTzLHS
	 4R6PzNiNWx0eH/VANaNiWPz0Y9/MI+6HxZCtiAKi9W1hckLrqawL2bWwtCzfzi7Nv7Fy5
	 yS1qkNlBowQEStWwFea+li2412/E4zxy2tIjykPX2zIuR4A/Iju8/HECWnMSFk8uFuhkh
	 u1uzOW16J4z70k66SFIdGsQ3ZUHPONVNOSBWq+cMKDoUDEn4SmM+XxwdLG9BEA9ysamZW
	 zqjIlfXUABkSPn0jul1FLK6JydQD2J6LydJzcIxjHDolUj99hiJC6SQ5K02zPM1UTPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7neG5MC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B0606A31A
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7neG5MC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7AC1F01825;
	Sun, 25 Oct 2026 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792948953;
	bh=+tiogsU/KTiY6pBPcWTgQSEaUAPf8FqTw37NgszPS+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U7neG5MCn0vaqXdn4RZYs7C22pex8jXog83Q+G/iupUtIjsszNr2l+Zn3+/qRNaJD
	 hdPqNWvsPE/ndJbUI5kQboSuopH/LyG1LX3XSBBMIbWJBCc8zP1NXtEbH6yjOYr8FL
	 LqWB3evmLNG/k9QvAkNi0Ur56ohTuWoq4RA3ys0WHNuiNGQsJDv4qfBAZkZLXJNiSO
	 n58tBOtE19li+8PebpAE0jIISB6NCNJ3t4vTvqfbru7PKhw6KSj0ra+kxatoSqdEK5
	 PlSHpN7JMXq7YiOqILfoSqlroackK4ibdkP0qTCah0yA4F0zUz013SUWnMvLQZRR/O
	 NAcDJh6377BlA==
Message-ID: <sashiko-outbox-184292@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7.3.y] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261025171526.157414-1-sj@kernel.org>
References: <20261025171526.157414-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 17:22:33 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025171526.1574=
14-1-sj@kernel.org?part=3D1

