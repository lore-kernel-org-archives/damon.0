Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036975;
	b=H76Cqt7E0raafchNjcwFXnJ9dktxEvM8XtPP1/hUUKGyvCJhzCMOJ21UJ7mj/E/NWwat
	 H+KwXaO0wkn1V/KOGwEjcBiZMklyKZpEk033tZcfoVgHhju4Hl21GfglBi1mih4hdKkPO
	 3mDbzpT1jc/q0NFJ5oQO1wq1c4ZlafWZV17dJZuf/+KgrD1kmU7xX7e2zjGbw9H/4HBhe
	 /rzGN/xUJnP4/U1YUdfBOpm/MA3uAwwsqNcm7XYXFgC6oQpVmWziJhuwADAFdhQM2wgHi
	 j4IAcn45QkYVcs83MMr6zjeXzEcfAXyxIBWSaq45hmOfIlLhn2uFqHqpc7x/ZSid3uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TRQ4olWrbBtFeTNfB5Ad29w+VZRBpUBuD35lm/UsRv8=;
	b=vO+i3HxqOSESIXrrjzLFYFOnE2JIALCbNg2scs2fkG7sE+chJQSkiYc2EhiBe5661Vms
	 5ERp0mLoVlwhNZ70dhyA0FEu4wnMfIjIg1RWdCjVcxLs9UfjqGR7xle8DhjXASxq53kJu
	 7oj7adtj6l1gD7Tm3vUnt5Z82aSKsvnfTniNZl6T0lEhpOQnY7yVS9/R2OlUSIvRCjlNQ
	 vhNg6PkMtlggCkL8pd0AG+pydpth0R1T114mJFHjfq/G1j8uCWgEsFY61LMAPtQ/djQWk
	 MqAIS9LrRANrr8I+LaX3KwQzIYWtmyN73UMVogGVdlX6RdvausfUyxW9VLO9nGosNQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdtCGUhX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26550606A320
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdtCGUhX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58A61F000C4;
	Wed, 18 Nov 2026 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036974;
	bh=TRQ4olWrbBtFeTNfB5Ad29w+VZRBpUBuD35lm/UsRv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DdtCGUhXfDztvJh1Mk1gYWzoX7Cu8RBBqvFyM/ylAAf6impscKGcEAzxbuoH+G3Lg
	 25FFugK6aaRkJvaaw3u1V/fHX4OYRuZ2rUrjwaMzLmJYk9IJMHQZiaqyY94D//8GHJ
	 phXNQc4EVZzubx0Y5nYwsjQhwZgz4iL9fFePTwkv1UOcH+Q9p/jMlrMZ0fAdQcaCu7
	 mrPha6WE2fgCXUszY3ZbdpiIToalpiw5NHZ2Hal9URkFpA9ksfHTki3/pIXsPW/7ia
	 1DN5BP7XuGfGmgbPi21qMATFGM1tBcm8zIxhVNQzcimwuDNv9eAqRf7K6FXJmuQHwF
	 4CaQ1m4P+74DA==
Message-ID: <sashiko-outbox-221988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] mm/mglru: make folio_inc_lru_refs lruvec
 lockless
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-16-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-16-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:22:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> The lruvec spinlock in folio_inc_lru_refs was only taken to keep
> concurrent aging from corrupting the size counters.  This is no
> longer needed: the per-generation counters are atomic, and the
> active/inactive ABI counters are updated per folio and linearized by
> the CAS on the folio flags, so concurrent aging can no longer corrupt
> them.  The same argument is what lets folio_reset_lru_refs() update
> the counters without the lruvec lock.
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D16

