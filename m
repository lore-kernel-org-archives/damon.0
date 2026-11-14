Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616419;
	b=P1T2zZlYF9HXyHk+i8Tb1in/g1+5fCgTKop+czE80msugJO+jIpCU9L7cSJIEQZVqCsA
	 g3ojlP5IxLOdXnv9XMBOScEzXfcAvtZODoAB+wotV23fsu63NgLM7KZ2gPdRKe6u6EmL2
	 3XqnPvenY47jzebsHUlQELRa5wKq9xhf8Qa4TBLiNV7mwafvKNkgCh3YJotGk8BnHFG+j
	 npcLVo8heQZX4kYggyMwj19h3h/7f1ABKkxBinIeA5eNP4WVIjGNdE/z515hQYSN9Wuss
	 njx3y+cN8/O8t8/GH64hupD1EqnA9TpPhkZ0jA0p03fhE8CsIQMj1atsRMkk9rCzJ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616419;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LZ1bp3qH+U+m6tq3/lACxiXywhDUkyntpItg3gUDvDM=;
	b=R6rVicvGVNF1Dh9kZ6SG1yNymVZwIBUxY0N6SP63I3NnE83jX1dVnyZxsy7HfZoaqNex
	 9mlQFwkB6plq577ldbYtNAYQ8UKaHVCfLWuC0bq8rHV35WRlOHp9f9CJt0Frc0uJ/PQMb
	 uacZ1+WuzfT/W4VP8HCYJ6p/OgQTYyFGR2B5btNETTXF7S541Ke3jqrXy0CNa4mDNebrX
	 R5Y6ZW2gfeV5GYHWm3AUmi6OBewlL2j1P6mzThgY/B3ldR4Kj3xRboUP2bdrRKLXdusbT
	 z35ewj31tksSv5OVAKo60tFridwhCU9V7GEqif+NwfnnX6X7Yp6bw/9udkfGSHf151g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSSdJoS6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A33606A332
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSSdJoS6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AC51F000C5;
	Sat, 14 Nov 2026 00:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616419;
	bh=LZ1bp3qH+U+m6tq3/lACxiXywhDUkyntpItg3gUDvDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSSdJoS6tREaH9nekeHdxuX4uz+e2xMuGN7lJG/M/1iB3Q6FD5JGifRbvMZl+UCed
	 HggWGZoEYMhJ8Q9/yFGstsfUi4hNQ7jSZgFR40pBDc4DAtUuzFXaVeicRdP4ksEYBC
	 qhpCC2MpPu1z+Rc56ly9ghMHmk2/Jc9o353wN4Aq++6QqGM/udqPt2bjO+wcE3lam8
	 RQnOt/aOrQJQeczboKNFEn45EGT2QEEkvVdIpVU1ZC5JlneylOAobeKciJZUD+gNyH
	 X6H0ZIeBxye/lkzkuJkgllilWO//9++QswyDSjIGMli7hqVTUI0qZ7qUjV4cT7DjI1
	 JSYUIarVaRtqQ==
Message-ID: <sashiko-outbox-213932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] mm: workingset: skip the root memcg flush in
 workingset_test_recent()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261114002822.1043378-4-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
 <20261114002822.1043378-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:33:39 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> We can skip the rstat flush in workingset_test_recent() when the
> eviction memcg is the root memcg. lruvec_page_state() now reads the LRU
> sizes of the root memcg from the node counters, which are always up to
> date, and workingset_test_recent() only reads the eviction memcg's own
> lruvec. This avoids an expensive flush on the refault path, as flushing
> the root memcg flushes every memcg in the system.
>=20
> For reclaim however, we still need to keep the flush (for now) since
> global and root reclaim also read the rstat stats of the child memcgs
> they scan, which the flush is needed for in order to keep up to date.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114002822.1043=
378-1-joannelkoong@gmail.com?part=3D3

