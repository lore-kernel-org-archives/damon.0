Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660289;
	b=JQeE3E0fZ04kqcI6keLjVF9yMxXf6O/RSrqWpv5lgoSRI3lipEbbPO0O2mmCXqndTpmY
	 l8a9qQfkedhKNw6i86+SIrI1IH/PS2S/GsREkI9YXKNde4Isx28CeICjNFfojG+3Ue4vE
	 umKT3UACSwb/jxyzfdBD8oAwOodPd4v8FW6y9zofteKHmroAv3JkTGN+BFSbg8mGl3hR1
	 3RsyinCTHbz4/6X6fBGCWx3ozg9c2d9OeuRW/01rtnFvdM9MjODBB0DqTGJiwg3TE4dkP
	 MyyIOQ4vFBjGO8XfwXf2NJeN70tFCy8+EXazZ631PhwYYcjgqQt1+Z1MFfj90PnBJ2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1AxbFkxxgP31ZRI9Qm3fFbk+njjhIhlXefH0JMCsCAU=;
	b=CNCHM4FXVL0kdwrAl9gjVOGfRMU5Bp8I9Sx6A21zbEZuTk3IJcSdu0SURXX815q0A6BK
	 /6seIw6AMD0hFoV0hxrcVVOpNqbx50mbJV0g9C/GHxu1Ozo/pZBRCdmaGRN4TpmrjuiRb
	 eTrHVfcUWUOtzmmdCM6LK3eORRrBl2Eq7mukdeAy5G58sUYqA7NYaTLd2LIyhZ/176hbc
	 3LdxPCkBKfrD+iBJas/T9nu5sy7sDesVH1f7Aw/Ds3TYljbY5K/ghFO7V9/CErRIbi2El
	 7ROB4cRZyDHNjlbbiry0R6H2wdo7q0SriKPSMJIdTjspvpUCHOI/rxbXKkLK9emsb+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU4zt+Ag;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF8606A326
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU4zt+Ag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423511F00A16;
	Mon,  2 Nov 2026 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660288;
	bh=1AxbFkxxgP31ZRI9Qm3fFbk+njjhIhlXefH0JMCsCAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hU4zt+AgKbIwa7wdNlAQ5gBNnBawKAcSr0+05pAnTIjzncuVEFLNd8TW2NiF1lNjP
	 ruj7sHjYFz18FeksTY9SVsZZNcsn5n2ppjTTucuKwOcZwW5r1hbGhdymEjhdSLBY9j
	 XNuBwSfe4LPPnWAVo7YdF0PyGrfzoEFTX/OE1O5V3V+jiIw6UyCUhcjZNWorGv5Uw7
	 w6q/HS9p2fX9MEy3iDVBguWzHQ96xrq74FOn8FzRRX5svreP36FSYDqQx0d9JQ+s1R
	 ccQQBo1sIb5tCr5bbdzpoPui9cr4TI+Skl3zJnqc1ttnzxKahn2rZV+w6JC7UwFdVm
	 yJSdBLocgEfdA==
Message-ID: <sashiko-outbox-194309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] mm: memcg: read root lruvec LRU stats from the
 node counters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102225030.2743129-3-joannelkoong@gmail.com>
References: <20261102225030.2743129-1-joannelkoong@gmail.com>
 <20261102225030.2743129-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:58:07 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Reclaim and refault detection read LRU sizes and workingset counters
> from the target lruvec after a ratelimited rstat flush. For global
> reclaim and the root memcg, that flush covers every cgroup in the
> system, and the ratelimiting can leave the stats stale for seconds.
>=20
> For stats that only track memory charged to a memcg (LRU sizes,
> workingset, rotation and reclaim writeback counts), the root memcg's
> hierarchical value equals the node counter, which is always up to date.
> Add lruvec_lru_page_state() and a monotonic variant that read the node
> counters for the root memcg, and use them in reclaim and
> workingset_test_recent(). Root reclaim and refault detection then see
> current values instead of stats that can lag by seconds.
>=20
> workingset_test_recent() only reads the eviction memcg's own lruvec, so
> skip its rstat flush when that is the root memcg. For reclaim however,
> we still need to keep the flush (for now) since global and root reclaim
> also read the rstat stats of the child memcgs they scan, which the flush
> is needed for in order to keep up to date.
>=20
> On an 80-CPU machine, a root flush took 69us on average with little
> cgroup activity and ~0.9ms with 128 memcgs actively allocating (wall
> time, including waiting for the rstat lock). Reading a node counter
> doesn't add any cost. It took the same amount of time as reading the
> rstat counter (~150ns, which includes bpftrace probe overhead).
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102225030.2743=
129-1-joannelkoong@gmail.com?part=3D2

