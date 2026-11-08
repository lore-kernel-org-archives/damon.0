Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165549;
	b=ybfIsoQ8qctN059h7g0JAvj3lhMclqQh9eYdw1APT1s9+UErzry955951iQ3zNnBvbcU
	 cb6u2GTdgooiUF0wL4iMqQ4meFNs8LRWYX2BBguI7HOHJGnw/InlajYGvSvMZcGAlYnND
	 B/ZugqSZRRTRXyiYAaB/Hy77xF4W73a8kF36oLvDfikbkThw2ZGxHIa0dSSNQBWbCQ6Ee
	 cGX3W6saebcdmJVFtfvI3bErQTQrsF6Vnck24zPWNlWBaU56huIxMKwylFYYb3YZ6/Li4
	 1+6tLRYAO7Y0MfyJ3C3jCeS5wYcbxhdVEJJRI90ImFAHU0//QF+lOpoN2tWlHZARWWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165549;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I+INFpPJnNgQv3VpCSdd4PRQF5aTCQ6lJ5cDjXFdGog=;
	b=tmypqWXOrV9Y4p0zzea5WiI8PFtyAkbSAyCgFbWyCMePmYAsKpnw83YtYxK8Gnc1ZOeS
	 13e92yXhZlHBbMCNbp3J+n0wAHqgU9k84uySUMGbSN0/WOMnfQtMOjhSAyrQhu/w+gXch
	 qSnZCZdXNvI7+ryUx/gFodJQX6APCe12AfqfmWnLvefRrqSh7YUWmYfcc45pYslxET9rM
	 XCNRRB/JZ+gdUV5b1m62sEevsqZFkskTMLMEDPBE6sT3FzaBLb+clXvit67FdETjotrwH
	 Rlu7yFymFgz8TZVYrRwQcdOEKid2AKzNaXx3mP2imINBHMI5NVYxwVtCiW+gp6vXiwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRwcUHlG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35705606A320
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRwcUHlG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922241F008A1;
	Sun,  8 Nov 2026 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165548;
	bh=I+INFpPJnNgQv3VpCSdd4PRQF5aTCQ6lJ5cDjXFdGog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRwcUHlGsJkCm1laaDNMzFCAIsNMA+E2XuGGrForDBwQdWILQwEe/UatDgR3fy3cj
	 zqsaAlBQ/BsmxvgMi7A2tbnGKuqd2d0S4XlofSa/gpDmFtkpk8uA3V8PHedOau0vgX
	 KUgktJy6kCFEllxmKekgL2BFotrABlZcVJa63nRz8NYPcTvN34kUuXI7JjD96T7KJf
	 Cx/3nBo58AY+L9XnLxOQ+BYQG7guZ5xmlfornXzF99wUpZcZQVft77r8oI46lgYl7b
	 lUEzF3jLyxHVOkjAaR3E7rbnOI7gw30Sxmu3b0upeJJmQfETfdoldGCwsakOF25ZMT
	 O1ArsYj0aXVlA==
Message-ID: <sashiko-outbox-203934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] mm/damon/sysfs: support LRU-activeness based
 DAMON filter setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108191615.113362-4-sj@kernel.org>
References: <20261108191615.113362-1-sj@kernel.org>
 <20261108191615.113362-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:19:08 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Support DAMON sysfs interface based setup of DAMON_FILTER_TYPE_ACTIVE
> type DAMON filters.  For that, wire the type with a new user keyword,
> "active".  Users can set up the new type of filter using the existing
> DAMON filter setup interface with the new keyword.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108191615.1133=
62-1-sj@kernel.org?part=3D3

