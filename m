Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198800;
	b=2J0/OADkafCbg3QKv6SMoIo6ufNqu3rlv0uAA9WqtaELvLZX3wFujptVRaNOHOu2KGSd
	 2NFrqnITTO0Be9cetyjq03k4aXfvAy17Rt2jYrXteUSFTI7KCYpJ2iVBaOzQCxwnUJGyJ
	 ahTF2zmEGZMD1v7T2LoNRyaplw0wworTEEAGi5+9u7ayDv/b2qCcoWhshzvqkKqBnZg0s
	 Bt5HU25WsBwiSl/bm90O9aqj4tirUaJrEVTSyp1fTcXCLR+MnXnDZm+ndoZl48TjBJKMk
	 pnWK2oW9HQ5vjea2OaIKAeqHbdz2dKqqjhxeCs+c7Akn48A712vYfcpU4Ly+KgcryRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HHjjdbAJWCmRVLwRXUvIJCCI0HDaIJgzI3yjTnqDsTU=;
	b=4qc9XBXYQLUMwDQOIAxMWX83wuaxqsNAT/1qz8XKmfMsc6O9/uGRrtp8CtkpGo+Edr6l
	 CwlpNx/7GEUqUD3Ir5mZAGYUq59zjtIEuJwnOd3os55jhtw2qr8QHu5YeavZC5Bkvn9vx
	 scVy72YMGk9OrTW5RE67+fpRK5jsbfFAZSOI1PvAbJjoJZi9WPlKWtvfSYw7GL8BsfX9m
	 1eELRoTZvkomLFX81n+qEMdV4bKjeTG3/AgdCwwckjVRFbujognM3/tB17v4JzVEjVAKQ
	 5HJIAkC8EvARZuLfFb3SjPPZ2c5eQLfy7jHt/J+Cgr0h2fTSE7v0SI3SqQ5A9FGeCJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXgSNvPQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A231606A88E
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXgSNvPQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B840A1F000D1;
	Fri, 20 Nov 2026 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198799;
	bh=HHjjdbAJWCmRVLwRXUvIJCCI0HDaIJgzI3yjTnqDsTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XXgSNvPQx0qHR4oUe49zlvZ+0EUp+tMCEF11Z8zrMon/C/sNxPfQphioAO983d4/1
	 KaoM9hOjzjBQ5Y146/B0zVdb5XTJ3X/CxBIOkAEjqKM15FZ92Mpj5uXY/+Wzwq3MqH
	 C35qPHb6RtpvkC6C7Sc+PUdKndhjINlLFjMF4JVM7j2aL8ymqpUH+Vws167lQ1LVSU
	 aW9W5ZvNn2WG12AQDOaa9W+tEuoAWzJLOCWIjWgtZRFZrbKmSnyBEMCN9x1sCG0xas
	 aFop/jJ3NgZFVZA8+sa2/En57HNcnUxsSrb9mpcqxi4LNYoU5qbDX36xmgACGnh+tG
	 YYwY0OiEJEaQA==
Message-ID: <sashiko-outbox-225797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/60] mm/madvise: restrict reclaim advice to common
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-24-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-24-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:19:59 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> MADV_COLD and MADV_PAGEOUT age or reclaim the folios a caller names,
> and MADV_FREE marks them lazyfree, whatever node they are on.
>=20
> Restrict them to common memory: convert their ZONE_DEVICE checks,
> including the one in madvise_free_huge_pmd(), to
> folio_is_common_memory().
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D24

