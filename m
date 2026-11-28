Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795891829;
	b=oR02ZLBf7WNQWEpVlqF83L+mHJj9NMXkc9co4y7pdhVRFl2D2H/4AyifWHa9J0wGLC5F
	 zESN+dhC64imeu7k/XbfADJzNAgKDYi/RkaEJtXt5R5a0vzOK4FKAyCrHLlZZoYzZdHEx
	 W93uA268McupY1an7B7Xoz+k/eBALlOrh8oS4iDRkyU3y5mziIylpQutN72Lte5m5FP9T
	 YFCOKmZ6UzfFY8Yg+J6k3ZZNi9L0u3/LQBBrrxFYGaPTDawWpPWqQ//sTvPOCClaOl9Tm
	 J84MN2p7CLfvA4KbDc2iiB3lCVBZJPBKAo8AQcoNr3NJDK7rpGjal/0ol8nvPOgsgdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795891829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uNZwWUNVKjS5Bh30JHUnmd4I7fFx7M3Uz8rCmTdlDjc=;
	b=Ozx9L1w0ZwL0zvqgPWCc7OAXF9WXL7hf0Z//pk/zxDK1DZgj552RGvVMMavSegijbwSK
	 95wtizKHXzeJRgSaSvR8/dG9iJ152B63TgFztKdKibqpSgk8HPYSBGCNhJRuwkjVPO/7x
	 8xLybVP04nMayVsFdrQPcfnT+2RkfMJAhxQq9K6dRpzfbDh0EGh1tt0+OwdX//tL8PuPI
	 j62CouYpCkCJ0DEVvxkDXXFAoPfq+eAKCOxTPHJQcCHC7YknyyEviGBTshPIS2I+W9prT
	 O6+Vxnh9Dz9mPGfqKc0/MjbWqHBc+hj7MnpiXvF9uUWUFRumvxbo+/X0cuc17FB6Yig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b3NXiW2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3559606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3NXiW2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622731F000C1;
	Sat, 28 Nov 2026 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795891828;
	bh=uNZwWUNVKjS5Bh30JHUnmd4I7fFx7M3Uz8rCmTdlDjc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3NXiW2/9INPmJ3LLx8wL6554uAWgc7wb8lXSpT/6xzaY05rlObAzOWXNPfZGbg6k
	 cFXfAW7j+fZOl3QfxRkYYK3PI6JpgrYTYQh1XajnQBbrBgq8zk3OqkRbMFjTNzMnfp
	 4F1l6QA+eETknWRM/h0FLO6Jv82P6ZiT3k+K/CZA5X0/KZ06Ued4vM9u4b5OD/S6/q
	 Zq7hG6LObcZhmEvoJjjnjgLVlZRlVlE/XfQpIj2hmetflIrgv155z9yUZQTFgkZXse
	 Nqz1HAlhAZLz4vDcJJssZqxVN8zzrXFFIPvF0GxxuLmM56baK4h0B/k3sPIFGh3YIx
	 Q5wxvlq3xZXEg==
Message-ID: <sashiko-outbox-238972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: let kdamond freezable
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261128184311.161492-1-sj@kernel.org>
References: <20261128184311.161492-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 18:50:27 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON's worker threads, kdamonds, are not freezable.  If DAMOS is set,
> it could migrate or reclaim pages while the hibernation image is being
> copied.  It could corrupt the resulting image.  As a result the system
> could run with the corrupted memory after resuming from hibernation.
>=20
> Users could work around by stopping or pausing the kdamond before the
> hibernation imaging is started.  But it is easy to forget.  Just make it
> freezable.
>=20
> The user impact is quite bad.  Nonetheless, the problem is only found by
> the theory.  No real issue from such memory corruption is found and
> reported so far.
>=20
> This change was originally suggested [1] by Lin Ruifeng.
>=20
> [1] https://lore.kernel.org/20260408080652.1745410-1-linruifeng4@huawei.c=
om
>=20
> Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schem=
es")
> Cc: <stable@vger.kernel.org> # 5.16.x
> Suggested-by: Lin Ruifeng <linruifeng4@huawei.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128184311.1614=
92-1-sj@kernel.org?part=3D1
