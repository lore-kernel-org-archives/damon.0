Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090547;
	b=Jx4ahOiRCvQaHO0x2LXMUSDQLnzQEtA/G1em8DHps6UAb3QDg1uljPWazw1OAqlR0TpZ
	 /7LKEqH6RuW/mLBA3YEBU2vKZUFxfYFcHftHXAAAM/TzrArxll++5LohRaYMXYhTLEBt6
	 DZseXqB2kv0FNYtN/dtlD57CU4kiK7j/uvUnyZvp8r3dfG4CVG7O34V7vs/YO0IsnQtZx
	 fRBEYQQh4+kPsjX46vMFNUiVDvsarkPaQnhBnrk+wwRzqUD1ULyWMf6A3EOqpANUNm3hO
	 LovRL8AcPw5ppcS2iO9eq9VhL7UAu6Ovrjx/UO4cqeechQF257O50FAYAAV7YY5FEvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d8rzaLmod9hiDF4G+MlCbWdWyTmETfp82LhWWlg0nuY=;
	b=Cofp7CkLvC4OXmEEVrg+rcrX67Y+uYJ8dyBaHwFA2yhdfluE8umQNq6ha0K7iKG+pS0/
	 RImaIl52LVfnk/kcIzXz8nccQ8LCzZz/DiO2r7qscrRIeKpbyTyf6KeKgiJglJEoTY3NT
	 ElsAWN/Ap9oxk/ekOVaXvPyG0xxa5JTipFU9TCbq3e1HWtTzJ+va7406RpcrY2WEG1wwL
	 PmL9ggopPkRm6/XB1VkOdQ6IRrZolhTmU18vSJJLLO97i+U5THjNmll5OaCOFlphAUV1j
	 hMCAy2Rq+uovLhI9yPChxOMLI87gmbQpvAwi5IR/gHnUZCr8swFpKoYugqObh/R1MXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpZSAkW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A6606A326
	for <damon@lists.linux.dev>; Sat,  7 Nov 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpZSAkW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05F11F0089F;
	Sat,  7 Nov 2026 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794090547;
	bh=d8rzaLmod9hiDF4G+MlCbWdWyTmETfp82LhWWlg0nuY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpZSAkW9ffTGXQU6zQfgVLdCzZSKokQhcVG+oYdAEXqdrHeKxP38gHWYXl3bGZ6LC
	 SYRAMwpci8aXJO6EFtU+WpQG0RBvZPKQzdpUF5/IElFY9IYBdIuK99IZpbrj7jPUFL
	 kTne8RE1BWplEhFA7nWTBKt1pj/h1HTbelIg7YftdBFS/8qzDn2rCri6LBOXPfLV6x
	 kKQ1FTgpka6LHXtA6Yu8mWamOx62gM0R09E6pvgDFesUZW4GrYzhlrlxTd1g2S1HIQ
	 jvNLKh6vUhu1refL/O53044EcdtmwzBS9rMltGggbEbhxyZ41B2lC3VaoWTu+GPS9L
	 QHGCHcKIa8FQQ==
Message-ID: <sashiko-outbox-203365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.6.y 2/3] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261107222202.331476-3-sj@kernel.org>
References: <20261107222202.331476-1-sj@kernel.org>
 <20261107222202.331476-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 22:29:06 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When an address type DAMOS filter is configured, DAMOS tries to split the
> region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash or
> leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that the
> user has excluded via address filter could be a surprise depending on the
> use case.  It is only theoretical.  No such real case is found yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
> Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # 6.6.x
> (cherry picked from commit bbeec2d8324d7aac438bb12dd2d22b184e0a8d43)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107222202.3314=
76-1-sj@kernel.org?part=3D2

