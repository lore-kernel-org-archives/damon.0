Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046244;
	b=0PzazMqGUD41PkErfQbs4+ldELZXWPrzFDgVvTLQEb2uyzVsEnSqNppqvrDF7NCRpyJi
	 isn6R7WEDEvkklwvx+wYc3y2vPb6SFh1DbBe4dDeR9kGCkLHID9n4TpIu7kGJ+q1X2Lf5
	 zi+91mlhJ8TcM+qPKlbmZCpW1WloOHB0fp1pEcUGsJr51ksr2Z8UAM4yjnZQNsi19tflg
	 ucy365GZCqhq9AUWYY1pE1XBTkxhlNmgbt2q9mW3dfmeW4mepKCHM7Db1/UWPxkSE8eFo
	 hSB4m/qyNO4LchzxWnkBLHIZHmOWpz5p+K+FEH8dwVArMtzkoTkhWodhfthxKM4KBAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QCgOT7g7HFrL+puZLt1tr7zv56lwSHBFSlkj8LuEo0Y=;
	b=GwEJQLAeStwgI3HWlUYvK85P2JbIBihSTraoEcj0recKys5Q0rJT4zOBC1ZjUhfVaNfG
	 Hx1E7mR+P7QKJ41deZjJ1SlDwK7IsW2DW2JDNgFpPLDeiXfT8pvDuzB8FgPvEBkt3SWD8
	 DJ/ZqI8xL3rvpNM+MMFAEedO+FUl5jCF3gNVqnaodbhmq2+BUjGBmhXnjoN4RWVHGu1cy
	 JQvnCcMQ+KCxGUA+sg/yIoKeBASiY4nFaDnK4cMnh+NnzU033UJ2CPM6f8qprTHvBGXj1
	 I+fws8cDoCdO/rD9OXN9sAEjysp0PrI0ZJJCKtKUe/+f1fHD+WnM3yEan+OQuHj4qeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE+1ytKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECB606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE+1ytKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB28E1F000C9;
	Wed, 18 Nov 2026 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795046243;
	bh=QCgOT7g7HFrL+puZLt1tr7zv56lwSHBFSlkj8LuEo0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WE+1ytKSHM6CL9NMqriGfvYFgloBO2Z6zrzhAm6PLSLDlmt/vd/B9+RioxJswDx51
	 IgHQA4pYp9WIxuSS4OWCRaTZz3t3oLLX2wh0cO43Hylv6tHi3g+wEjZY1TXF65QsPi
	 F6S1izZKEZRTHxN4IUGWHf0Ht8EB/LWr0yRCtdcYejxVfYGBUWxCLPgvRYIx3AwDDg
	 1Sd6usLwPaBjY3KIQu05PTCf798zMASOcUfzUx/ASxNBeiYMmgqAUvntY1JYp3gRgH
	 BoJ7/D7TvwDntwABofwmK9PFJ7lnDOizFgQAKdmlpe3x7q0DUGDltVZYlBj/WLa2X0
	 2+6KuGFULvXKA==
Message-ID: <sashiko-outbox-222220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: fix damos_walk() hang with zero
 watermarks interval
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifan Feng" <evanfengff@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118235012.14859-1-evanfengff@gmail.com>
References: <20261118235012.14859-1-evanfengff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:57:23 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_wait_activation() cancels damos_walk() requests while all
> schemes are deactivated by their watermarks.  But it returns without
> waiting when the watermarks check interval of a deactivated scheme is
> zero, which is the default of the DAMON sysfs interface.  The kdamond
> main loop then runs with all schemes deactivated.
>=20
> In that state, kdamond_apply_schemes() finds no scheme to apply and
> returns before it calls damos_walk_complete().  The walk request is
> neither completed nor cancelled, so damos_walk() waits until the
> watermarks activate a scheme again, possibly forever.
>=20
> For example, with a scheme that has the free_mem_rate metric, zero
> interval_us and a high watermark below the current free memory rate,
> writing update_schemes_tried_regions to the kdamond state file never
> returns and cannot be killed.  The writer holds damon_sysfs_lock, so all
> other DAMON sysfs writes including "off" fail with -EBUSY meanwhile.
>=20
> Do not skip the deactivated schemes when deciding whether
> kdamond_apply_schemes() has something to do.  damon_do_apply_schemes()
> still skips them, so no action is applied, and the walk is completed
> with no region for them, as it already is when another scheme is
> activated.
>=20
> Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
> Cc: <stable@vger.kernel.org> # 6.14.x
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118235012.1485=
9-1-evanfengff@gmail.com?part=3D1

