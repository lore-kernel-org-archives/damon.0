Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022853;
	b=Ox++Soc1mOQ/h5ATKGYYQVoesb6rrb7FOqxlwzW6nFPemcfk7GqW3HgCfsSDkV0Ea6Qk
	 426aLv5NNGUtnRJYfZp/mDusuYSi4i4Yhp438ZR4uAMPEd5p4HMSHxUNVAcSTshiXv6MU
	 B1Yb+G+nqJh69NKfe/mTKqqenQi+y9u2fg4R+aTVsaL/h9DUTz46+W4vR8HTh1GY3n8I2
	 HXkG0r4AV3QH/bRLZBHLFevYc565/2kNq03jG0vrNGOev2qeK+2LKI0d0LvwOK2JR6di1
	 ck6a2ulbugZHAdD6N2yKeQhkK0i62aeqwYoRKSVAUeZU1nm7T67ys8gJoAT0DqjcMEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022853;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xab8AbE2EXdbNDwFqWUaWxsCTQnsfRltuXZqOKlThgM=;
	b=vucz/2HojpqAXkd/Zz1jnyAy/oIqvwnxfD+PgczPeaJm62iULK6sj1S2dWsrKXYnG7ki
	 2YjOMm0bJqpBniBEAR/ISigWrcf6obvQ7U9M3j592J1ToWbWYqQ5MyPWbyDKqY301sEnB
	 pKKlPz96q6J1Vo5C6T46QJSkOW/obB2lDQ4TvQaoBqsbq73vGh4pKupzvEKrZoP0QGVrl
	 uZ+eJzcXP6LG6L/IdB5UiT9Xsuw1I3OtY4yZMmgEsB/Mc6ziAKX+W6DM07iqbHID83lrI
	 glpU8kMi18YEvscEpWmRPleD30UT/Me/rU08XuFCj5VcwO4JCsYWVuOgoV4zrBAp45A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlQ7EDJ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91E606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlQ7EDJ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B500B1F01825;
	Mon, 26 Oct 2026 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022852;
	bh=xab8AbE2EXdbNDwFqWUaWxsCTQnsfRltuXZqOKlThgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlQ7EDJ0+M0j+kuAxk59aPLBNiZpR3Fvx7MJYRs+z6UYUF+iLFR9mV94ajt1jlwLx
	 hNDfSCDG58/L1vUoGmXRCcXnO3YNimlyXUzNV4MBFhwEeEiXml/SWaE4uZ/Dn/HUJm
	 NIpzPBIiMiki9idllSNpBaeFsNx0bZ7cBdTD9BuJx9gM1ryVGPpB7LwaFved9ghps6
	 8N+ZQ5ZmCaDGW/zPaD7iuo9NeyoA6qkTZyJxN8VyedlLYbkmi4CGmXFdyER+TCCmWz
	 oRxTbaRZq4/KeepFIdrYygnbvHrcNQhFEFxamP574f27J+mLmUR7OGLbf6EH2/jJc8
	 /a+PMHNWBcLeg==
Message-ID: <sashiko-outbox-185353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.18.y v2] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026134740.149027-1-sj@kernel.org>
References: <20261026134740.149027-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:54:12 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026134740.1490=
27-1-sj@kernel.org?part=3D1

