Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660507;
	b=lVxxgTh5YBqhkdsCnS+8ceHFSHccnKEx+5ENIQsScVSiSKykjj1fVwdk95iP7OIsyNxI
	 PM/WS8ywGPVjijHyrbEKLz9BGT+z6VlzkER/ZgQacBIvRW0Yy1xLqPn0L2wtQO24DTDuH
	 L171Mh5fBAu0pOu8lI5IA3gLB55l4X2yCS6N5bNy69OiSCrs65Q4VnvyaKm1g/PfOEEXB
	 Yhqt5w2vgsmcKtCWFs74GQa8ulUh1OAsVFxXEr2+4LXJfXK+RP8pmIox4/mlbPGGJ+4on
	 u79OLkCqdIf4IqrNs/N8WqvgU54Im54lDYCz3hXII0s70hKvgLe63RcuCD3vML1go3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660507;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=upn5gSzR7ND8EXCDMdkS1/YxsDiug3vQsxX5fpS0UXI=;
	b=sbhCizkyw8XzYWBSKhNOBvSaqmWiGVP7OQG9hXTBw836Lt+iHKlwO1WMQi93XCsrIFqP
	 nVsNlYbHtGhFG2CjovVWzRnWGNR3TKEQj+O3PLEmsEAIwYd9gAFk5vyJMsnafqPKubMoi
	 Uo6uxAy+BnZI1PztMqRH+pL1qT8uJa6ojSBYeS5F0PSyLfHFFIcu6Qv37ENFWasSFqbSs
	 tNT4lLeRSJQAmPw8YP2idCGPSsPU7LUdCmdTwJv6gcH6aPzPpxFj1stemK4DR4TvtdhX4
	 iQ0eadQlnUpMbT3xEQK1R4/npvLqSwlgYbCqFhFUXAW8KyTxhdZWdKN9i6o8nG5wwEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSDTR5Ik;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8CE606A324
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSDTR5Ik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286141F00A17;
	Mon,  2 Nov 2026 23:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660506;
	bh=upn5gSzR7ND8EXCDMdkS1/YxsDiug3vQsxX5fpS0UXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSDTR5Ikzq2LSBWiCN5oRbuUc+OHXZzeufvnOWgJmuseB5bBanMujP8H0BKWPFIo0
	 tR1AeKfuWhrtiTEo5hh1TqlYESufzSDdBKhvWZAAdGDM8lG/Jo9Pfk1JgL2xRtPdZT
	 pS6/J9k0/t6xqxnIZmfCX3HJiX5y5+Ksy0xg3g6WTCaXrZ9RJCt277jU4Ov63uuYey
	 ZzIXbh24NLjsXSPDP06EKo2MyhKy3Dtjt9TAxLyA3ZE22v0YeasujAWhTN7swHtoFi
	 XfsBPCE/fUa1XfRy+sUN4z28g7yUP0/If5u6axjmiLTUlklXDclVacZVDutCHmRVQX
	 n/1p0u9o/4+lA==
Message-ID: <sashiko-outbox-194311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] mm: zswap: fix shrinker count for the root memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joanne Koong" <joannelkoong@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102225030.2743129-2-joannelkoong@gmail.com>
References: <20261102225030.2743129-1-joannelkoong@gmail.com>
 <20261102225030.2743129-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 23:01:45 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> zswap_shrinker_count() scales the number of freeable entries on a
> memcg's zswap LRU by the memcg's compression ratio. That compression
> ratio is computed from the memcg's MEMCG_ZSWAP_B and MEMCG_ZSWAPPED
> stats.
>=20
> However, for the root memcg, the zswap entries owned by the root memcg
> itself are never accounted for in the stats (obj_cgroup_charge_zswap()
> skips the root objcg, and before the root memcg had an objcg, its
> entries weren't charged at all). The stats only reflect the entries
> owned by the root memcg's descendants. When the root memcg's descendants
> have no zswap entries (eg when the whole workload runs in the root
> cgroup), the shrinker reports nothing to reclaim for the root memcg, and
> its zswap entries are never written back by the shrinker. When its
> descendants do have entries, the root memcg's entries are scaled by the
> descendants' compression ratio instead of a ratio that includes them.
>=20
> Fix this by using the zswap pool-wide counters for the root memcg
> instead. The zswap pool-wide counters cover every zswap entry, including
> those owned by the root memcg.
>=20
> This also gets rid of having to flush the root memcg's stats, which
> flushes every cgroup in the system.
>=20
> In a VM running a reclaim-heavy workload in the root cgroup with the
> zswap shrinker enabled, the shrinker wrote back no pages before this
> change (zswpwb stayed at 0) and 1016 pages with it.
>=20
> Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102225030.2743=
129-1-joannelkoong@gmail.com?part=3D1

