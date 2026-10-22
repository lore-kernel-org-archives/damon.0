Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651212;
	b=yS9mR0RR3urxK9WAIHSe+HWgpv78tm5GEjlPoFWI1HLmDcGPSPzAqiKtMuw+5o9mHk3o
	 wtUTzQjPpun5VRJDmco+cWRfAdZ69XrgG5aJo3fiTaQuX5LNvrN1c4Nlm5Z0AiuF2v/qp
	 mQLaMfmtwFT4v1WvxrooltsR+CJwwu29zc9IRxwBTqwI9ZiRVAU+96OsRwjvBxaNzEdF8
	 AOyDepZEEsaWFtC+K5BuMRM8bDyMF8zi/ROdV32XB7tVrWqmyH3ZPQcq4ELPbloqGS7QB
	 AyS+7JCPoQSSRCjs398d793S+Ec+O9D3i4Xu+CdetCUYuyDHHML/DM2wK519wyyOrUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R5gCCQimyO99QTsX2pdRubumYSF/8SidCMgJVGI0n7w=;
	b=h7194cqUFtn/IdwN5pNsvSDYswWjV1tfaRcbWgwTdCJnJvcgg47RhrTeEMZeYzuPtW7f
	 vMu/d540kF6OIRvJRBNS8svQ+JY/OHM/o0fen/w1Vouq+u2fgDLxuoBd3TXZWpwMIWOH7
	 iSr50HZGjQO7HCqVuOPKtVBX3oqi0JZtBgFFcGE77Fxk42Hg5r4xoK/fXNyukQ5kSU+tw
	 Ce/8hgxudeGl9aAafED1TOiIg2ajB1p0+fTRrPqbAUWYVkXePwIwf3r/dNWuO03gxZgtD
	 XT1u+TxUtEC2WEp8QaAXFCdhsqHe5J6Ll+o20vkcYRzbFK+aAnYWdD86GkgVQLbAGRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVf4ooWO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8E606A319
	for <damon@lists.linux.dev>; Thu, 22 Oct 2026 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVf4ooWO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5CF1F000C1;
	Thu, 22 Oct 2026 06:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792651212;
	bh=R5gCCQimyO99QTsX2pdRubumYSF/8SidCMgJVGI0n7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVf4ooWOiyw9lA33IuaQFM/P/NzzAoTBtwii/6E2mYk/XLBU7v2svjumbAcI/eEUR
	 qJ3tN+Eypji2lBImrbvx6GJodhBxNcLUCEVa4ooMf6vYtcXCuPzoUjpkFeNfH49p/+
	 KcvJdGvphwW4JwzbFP3Ksf4ET5IxRm92DCoghSHmW5L5UuxQ0EvpVjYJPzCz3K/Yiv
	 o8rk4EjIgmbfFO0MLklZL1Bl+yu2nOxWNKZFJB8tJHU82FYXDZxGqULFmhTYNBHbZS
	 JBDMqDBZWV+jga6e5zx/vUrYh5wgOB1s+oUCGH8uoZBkRnLQsXDd3NJVWAfVvsM5Jk
	 jKkgh35O2z69A==
Message-ID: <sashiko-outbox-181099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon: align MMU notifier range when clearing PTE
 young bit
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2h1YmhhbmcgS2F1c2hpayAoQW1wZXJlKQ==?= <sh@gentwo.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org>
References: <20261021-damon-align-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 06:40:11 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON selects a byte-granular sampling address.  damon_ptep_mkold()
> clears the young bit of the PTE covering that address, but passes the
> unaligned range [addr, addr + PAGE_SIZE) to MMU notifiers.
>=20
> For an unaligned address, that range extends into the following page.
> KVM ages every guest page intersecting the notifier range, so it can age
> a secondary mapping for the following page although DAMON cleared only
> the sampled page's primary PTE.
>=20
> Align the address before both the primary PTE operation and the
> MMU notifier call so that they cover the same page.
>=20
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-damon-alig=
n-pte-young-notifier-v1-1-d0365ac45b66@gentwo.org?part=3D1

