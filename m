Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3F21D5B0
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927959; cv=none; b=YDFB/lPQeUs6uRnAuCJBzBGdR27Q3SPb53nenFEil73LLyz6oFrYwxb14clPaxWwWhqtdSzHN48f/+fdIFCnuRZ/bVV0RsvuPWePpYNuaW9TKCPxR1o6JmR0/wp/bSkrMCB1SWjKW0TP9PbICC4Iglt/cqRUvAAO8OurI+lykCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927959; c=relaxed/simple;
	bh=F6+MuGGDJvKWg2CjnF9vzebluzYc+KpZhI7WMHvL8Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ClBxBTRq/1q6x36pRHmAqNld2uNXY8Vtdt0el3Kgkkhps2BnXwseR+Bs1DRtXSxerMZBes+3xzXtCPKYlreeWY/Bfs1x8fr7dm41voDvnnrx6u5QkRqRnN6GIVh/39wmpnHg4rz3deIz/ehhQFTzbzjqs5O72XhCRIt96j3p9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3QF3FYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3QF3FYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEE51F00A3A;
	Wed,  9 Sep 2026 04:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927958;
	bh=eavMHGbXX4+pkor8UwmpW1ApGwk/KV3qf4irEXgghFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c3QF3FYwhSP67btrlwY7k60eJzX3oCopTy0Em9Ixk6xaDQl9cKJqd7m6Y5IqCrvoe
	 eltUCMn+Rar1x6HfT8fxRSYiE9r1nCXmT+ew5pLrPQff+7gD5sjMLPbVhxFnawy9zN
	 cA1E7MoVUHutIKu1t9ihU4S/1gPh4i1lFgfzuWPtAapxhIvKu2+VWb1DxmhlR732Ul
	 IYAqRKOHf6S5s0zSx4PGhjH9VhKcA3MhcCiv34PJrksDkEUoxTkHdVL47Khy1Q2j7T
	 Lf12VGy2kaCYTMAMCINPr4dnjpNtOCJp5cd/Aj7p9E7HLmv8FlQX3eHzw2Zu8gdufR
	 HI1snE79s4olw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core: avoid infinite
 kdamond_merge_regions() internal loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909042048.192255-1-sj@kernel.org>
References: <2026090833-alumni-omit-f8a4@gregkh>
 <20260909042048.192255-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:25:57 +0000
Message-Id: <20260909042558.5BEE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Patch series "mm/damon: unurgent fixes for infinite loop, NULL de-ref and
> races", v1.1.
>=20
> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible.  Fix those.
>=20
> This patch (of 6):
>=20
> Due to online parameter update like events, the number of DAMON regions
> could be higher than the user-set upper limit.  kdamond_merge_regions()
> [ ... ]
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 6.10.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909042048.1922=
55-1-sj@kernel.org?part=3D1

