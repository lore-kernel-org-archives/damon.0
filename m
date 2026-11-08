Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166269;
	b=DwDOnhhuULspQeywsNgdD86nbx4Bj2OZVqz6arNoZjwqj1x7syYspW7qCQblkkvePTUU
	 F3WK9DWGprKFyMXPkuVIiph6z0F/qJnlr7P+0HHPacRCZe+suGhmZfFJtsvWQAy81HNuX
	 VMgUv9ED+MzcybbSyElBt6YmNl3ZMB8PgY0xye3X59BAC4kR+3O/5DGRp/8jn+rERQTJy
	 RRP3F0M+pcYdadkCOMXbJuQKteL9BgAbN/fJXLQITmdptF1egZ68AUQsJp0+R48GufAO6
	 elPooX7CZb2ixnjJ0s+JmscPzuxIb/nzQKrDxr5SN/AR6zxB+OUOpeXTn4tfd8b0h3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rAlcP9dw2LpkFO9MDMT2YuT8skYn6YuLlzleJQ5ybGA=;
	b=RN7FYo8ac4B6DIFLstR0SLhQqGhxNKOMoA1q5/eNvIo1pJuYAg2OjBjBz+kWrmDaXkfi
	 Sj/BIwZWyj2QjzYtUt0NldFDpC0RPfVD3Ta5y+c8+1LDm8nXZR0dZhNl+Aa+kcZp+1Aki
	 swwAkbaH5R+ymKFlM1/YfJjVDxuKAQtUv1kxDcphzViyUwOWmB7O4UTCk52qXccvhw46U
	 oTybORsrAxxqza+JbvVPZqYIP/LN1Vs78JBRbFx20e8Vw2qoFrQM7cE3OBFMcURT2QHub
	 EZDamS8w0Gv/teSTzoSGyBxCv3Raz/zgHGqOUmEcyeXkOKReVgMPUek1fyUEVYcgLEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NR+T37B2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE1606A321
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NR+T37B2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B611F0089F;
	Sun,  8 Nov 2026 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166268;
	bh=rAlcP9dw2LpkFO9MDMT2YuT8skYn6YuLlzleJQ5ybGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NR+T37B2kRHVYsIkAsZJKUBrMyXlNBk468m4f020t1kCwwJl3iOY7rtUsYOfAk4Nt
	 r8DLLBcEO9kw7owAAV/gvjyGKj9s4r/Pemh80MWs62OukDH+YrbEYw3q13GBA6SbeZ
	 pr8TeE1DPf1QbgAH6u8xBdTYsrfDTqlPho1jNV/rSDhcMbrp0iS4T0tYOdOSPu+uS0
	 Ioi/pNv+awRZBg1Fuqb+J7cbqxBBL8M+gvRfBQWZLMO7UUF22Km9dwXkja+Z9gjTZH
	 qYT08+mUwvG8BGBE7Qz20HNJ350dlTkgmAE8p+/C+RhEGYxaxNkpSUoWlXw8fpDqUy
	 NY44UDJjAz9Xg==
Message-ID: <sashiko-outbox-203954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 5/5] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108192221.114362-6-sj@kernel.org>
References: <20261108192221.114362-1-sj@kernel.org>
 <20261108192221.114362-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:31:07 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108192221.1143=
62-1-sj@kernel.org?part=3D5

