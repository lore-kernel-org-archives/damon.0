Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022296;
	b=UZDmjz+VcEBFdLFMjQSgt2Q6eWTpd6+wJhqYHgci7S8m12tFEf/x/OHc6NIZC5nKf6QC
	 n4Ewe+MgX1lu7bI52YMSYGTT6agi69TbfeYV4TbKulxUUtvZAxk87Pb4TnOnCCbkNt9FY
	 aZDSemEfVbmaH5RVR5M6wD+GH+XwOORZ5LR5MxpP2qD1T9BFXhT18zUzQMygTaWVsM2CP
	 LSc+J2QaeYsYEcin7RfZSgeZJ4rPyQ4D9CrEYf6jl55QAXc4aMrPHIszddeyawprbNSW3
	 fkngmPbBTtQ+GM/G/2yMOb3WH+GFbf+Wv0NFAgxwNZXolxck9JJe/1pB8fRGoSskkOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022296;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+5+BcnPA3TasL3pGkZQPb41lgq+0gWIVGehsz+Es24Q=;
	b=W8FnJXojcb8RaQGuwkWm4vTGVOcjPXLOK3vBJv1ufnoc2ueLHEbkX1LwvyNvhVTL2/DR
	 hypP2IVW7XXf6j43+AhmZRtnZBgtmUpSS0rNxqcDSwOJPcvlQMTrcn4y2BUSRk1qenFs3
	 jZgKElWEad9GJJIjU1pw0n5yQ3DGNS8SVP97tZ+YKfYYpcFjUHsyigmACrtCddBmP+9uI
	 BW9yPdgJxjHKUpeDBnLHjTgrec6jvMSv45MSD84rpaT6heCBw+MDvUdr4Vccb8e0f62qt
	 J0sLX/bPRqj1vQ34Ad0r61XRI+HJYA7NvF+/pffLBRrXylMCEHTuNSikBy/bgXa24kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYXyJnTB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602B606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYXyJnTB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A371F01825;
	Mon, 26 Oct 2026 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793022295;
	bh=+5+BcnPA3TasL3pGkZQPb41lgq+0gWIVGehsz+Es24Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYXyJnTBh9Tf6d3TM9Fv+Od5psl3mO+ECkySzfHDARFoZ1wi36sLAA6mn+2b34PVp
	 0WWPKj2kUp1TQAhrR0hrRglS3hVlRVn8ckeXNFVrzbnlMjtw8jkFyShPcIpTr7/Hhe
	 rX1i7GJCLPbVWsM29OfovsZYcHsg0AtURnewNfvgJniVDRzDUnnCL0FBFQCki+muuO
	 D3HsoxlPb4rtJgAgjhBEJtXk9A5oBEdI6iS1aaZwfV7/AkEXXp6jBCQppwChLOsv/A
	 xX1UiNWwS3oN17V69l+ggQ0zyX75SWL9aFIKL1guaUiRDQmDza0WjoXS1ZUpA3ScFu
	 inz/75Q2HOB8Q==
Message-ID: <sashiko-outbox-185333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7.2.y v2] mm/damon/core: error
 damos_commit_quota_goal() for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026133645.119485-1-sj@kernel.org>
References: <20261026133645.119485-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:44:55 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026133645.1194=
85-1-sj@kernel.org?part=3D1

