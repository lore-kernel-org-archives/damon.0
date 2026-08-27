Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254022F7445
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805325; cv=none; b=scTp0IGKW2k7RBKnA0ZQgFKwU99mbqCcHdl/sRihORGD3tUedm3JGxVfG7YZLo6azJyuaZbhI9v6HrZ5ekghKrTGJTYMmbG8rWaz7AFDBSuEZl6R5ofI3C5ZpVYI5cQci3kLde6uol6wCzR1f6nhr5EOgiZ6O7Kxm5PQhdiKw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805325; c=relaxed/simple;
	bh=HGmB+i4Wcr0uvzv5bu4tBsACZylyALi3LvfgGeGJJpI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C7uP4qWnL556aMWIpFOSlRm4Az40U4aCOJS2NgxQgRL7cQPw2i3fs/j3t0xWf89U87Gap06v/uBdfClhz2SfDem4kr2vLKVOBGjksH6R24EeGy7wNkRbcMx+RVPmYWhbHjVqk0uGYf8T8UF2usz8W+t/Ccp+EsQ8ZgHBf3YXnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4aec80m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4aec80m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25C61F000E9;
	Thu, 27 Aug 2026 04:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805323;
	bh=Z+ZBF81ux49DKuqq8vszPtBqE+ht3GW2PI9oit9pKFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f4aec80m2lNHayiuKaQOF2UXiLtM2eLKX82lYJLJjwPR0uJVvgQ5ZwO7k3j+/vVBT
	 4Stm/ipE4YuHdtqVqsPP+WzkT/gdDvpKou/AZ9lLZLGhOkbvibdbYc5ZkjjnPBT9Va
	 +Se8TIJe/TP1kzXhy1QBdsg9Zf5d2SONeZALYBZI6YOWPzob5VP8unK7fzfDwxMoCq
	 PRCcWOqD9HMn8VjDGz5UyK6lsbgwJ3xTQZ9eQiT5kYfqqdzv91ecnmKBBd5S82jLC9
	 fG8MFputgyS2tWnYLBlB+fSeeuLxhvw68kxq5UKWeiEFUrB4gHF5bbdNlkO3qSHpJL
	 goWfRV/PQaTRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] mm/damon/sysfs: set next refresh jiffies per sysfs
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260827042920.93580-3-sj@kernel.org>
References: <20260827042920.93580-1-sj@kernel.org>
 <20260827042920.93580-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 04:35:23 +0000
Message-Id: <20260827043523.A25C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
>=20
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug.
>=20
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a glo=
bal variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827042920.9358=
0-1-sj@kernel.org?part=3D2

