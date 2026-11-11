Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362046;
	b=KG3gpYWt+uXj8QiEekO6+Z7F9ULd2tREuE+Gm8zivb2EKNDmzjBEq/hHR4Ckl3D7rldp
	 gvcvGocMWX/YDGM+OWZzB5Hgv9HnvHOQFYKBNUAZkHJtROt2gG5xwfKnVyZR9Rky/ncbS
	 /5fG6ZoG5SC95DdMyIyLFXC5pHrJ1vl8je3rCDKiEp3hKmXWiAXypvL+pYqcj8gF+ge6O
	 lTH5gJ7jfVTXs0zJb5ajOeqo8ZYfU5Rlwi5I9hRYlcmSJ4yaGxgOxh4B3F1AelFJEdSrQ
	 19Nna06ljdWJkb363DQlBzjnmWJiOZB9kpqVzp+CidKwNnEbzqL1dMW1EstiNnC0I4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bGfTNt8IUWaTV/I2yUozNS9DjvHUcqMa9Kik+KR3S/k=;
	b=B8eRmQTuPrqHHWF+8b7Cc2jQwHnrPm4UHw6JGzOAk69HiQ1p+PWNZdq2bb+ZzZwcmfWy
	 ANZBF4GdieGZLAmHghI2AgAnAqnMT4AMV3hKt257c2EC5z0OSdqdsJWVH3vHiEaK5fEws
	 iwX3BRboGmjxo6WTiC/29nXF4L2YCUN/okc77gMcuaZThECM8DywTljqrVxa4xq9mMuZY
	 LmzXdrLnldz0ekVYkkqRMaz205dGW04bczzxIZZztHCCCHgvRjyCXgGlBQdG+zKzwEhfA
	 pIpCxCF79gndtCNM6FCda77wsdXzDITbJKRChxWZijrZwPVi2uQj/iV7PpRgNQHRwYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTGhNiuA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BB1606A32A
	for <damon@lists.linux.dev>; Wed, 11 Nov 2026 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTGhNiuA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629F91F00A04;
	Wed, 11 Nov 2026 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362045;
	bh=bGfTNt8IUWaTV/I2yUozNS9DjvHUcqMa9Kik+KR3S/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTGhNiuAnMEz0vFTK7ugfJEmp7Y6URwqObldfp9V7qIVNq0ETOIZVXQfO11FfDA6l
	 3tvzkFkfii0GDZCrYmORQqB6uzCtkpUpoRzdx7kx35YnzN0TfHxZw2y2uQaT7d8L15
	 XwbIsXebcmblmEKE65uWZIZIpAdafurpUkfIY3PdldNC2rCa5oE18dNSHH7kTB1Idi
	 bagfYMbQe3ktECARtReYAg5OVWXDNuc7K1a6ZoPyjZe14bwbOTbh4Xqo+ZfAzLjCQl
	 CxGjBY2K2M3tK6l4NUceJgEQhhWufj9VriL5REf3+Z6lmjAKIy+yjlz4jNWr2mH+gm
	 pEI0472yuMdrw==
Message-ID: <sashiko-outbox-208056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110151927.158140-1-sj@kernel.org>
References: <20261109202159-failed-5.15-26ae50a0901a@kernel.org>
 <20261110151927.158140-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 01:54:04 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
>=20
> Move the variable into the damon_ctx struct to fix the problem.
>=20
> Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: <stable@vger.kernel.org> # 5.15.x
> (cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110151927.1581=
40-1-sj@kernel.org?part=3D1

