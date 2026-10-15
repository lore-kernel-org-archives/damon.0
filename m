Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B5D3C1F22
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088950; cv=none; b=FrS/+TxwsrasjNwbd5wLtKlq0cg4I1cRlxSFANKbC3swqbScLe12I3sV8YIUmBWyH3Aqz8j687hfBe6jOWbiJX1V+E7Hla6XGXxbp0wcTW3SObk8FUktQRAg2GlU9ypiTuzNWmTrgejozTxZAVw69DaluxPvjAgKH076VnHCn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088950; c=relaxed/simple;
	bh=bIjDqYOGegnMr/eCpmmomn2QWzrL2wXZHRzwToYyZ/0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WpALy5xloLQk2I0VaqGP4S7/K+aNpiLv5BACb9UVuUCnAY2IYVPQuq2a6IO1pINFP2jzgUorWRryrgPAcd9AaxPV8JVU29PJbtO9YnyUPVowq6q+vGP3mwgwStdsZvVFzy5/fGeXyBnb7l84s7TMpXwx4jU99e+NEc0CodcpYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bThuDSAA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bThuDSAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6865D1F000C4;
	Thu, 15 Oct 2026 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088948;
	bh=3jsdCrnn1bJkIJaa4jM2rvbax/6qaDd04/6x8wBLU5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bThuDSAAugQkvr5v/hjRi4/5jclQ6Pe6dE1roWyY79oVs5OFlGApObPJANnlvTR1+
	 7omoo4nDicCIhiPD5L+EPrAi/HgJbTq2e8WGZoDf4lKo1Z5yWeJiCdWU+ZVhUj/L15
	 AXZIgkIuaWvFpVmFGV/SvT2y5Tn9UTbWDUiAgOV5aU5nHzO0Py3IX5yuwXnwpI9FGQ
	 wN0vk82WXRjqK6hnxVHZ2VP4wt+X7hnJBQOwqExHEWnKp8XMOz7m2hdmLdmvZiL+vg
	 p0yePAFqwCNcG4ysLgF95I794hW6CVzfA4gIUwWLPJj1n83p6XPFkU3HjQUkDE3wvS
	 LMFaJ+FKGeLSA==
Message-ID: <sashiko-outbox-173295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/17] mm/mglru: make folio_inc_lru_refs lruvec
 lockless
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-15-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-15-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:29:08 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> concurrent aging from corrupting the size counters.  This is no
> longer needed: the per-generation counters are atomic, and the
> active/inactive ABI counters are updated per folio and linearized by
> the CAS on the folio flags, so concurrent aging can no longer corrupt
> them.  The same argument already allowed folio_reset_lru_refs() to
> drop the lock.
>=20
> Use folio_lruvec_live_get()/folio_lruvec_live_put() to hold the RCU
> read lock around the lruvec lookup, and drop the spinlock entirely.
>=20
> Without the lock, aging can advance max_seq while a promotion is in
> flight.  Generations are indexed by seq % MAX_NR_GENS, so the folio
> [ ... ]
> implies gen >=3D 0, and lru_gen_update_size() needs no explicit guard.
> The active/inactive ABI update keeps its gen >=3D 0 check because an
> off-LRU folio has no lruvec to update.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D15

