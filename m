Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148223;
	b=DIUQ57gdMNrNYmr2vp2NiJDVitBxwHwcI4lNfcl7qNFbe4Iaj9d/iFbHZecxYG/2itlu
	 OlCZvutwoxgeW4ldzVeana7XODV+wZKp3vn76PYJPlkQt/19j46gKnaHE5W3bM2bqQw+8
	 fV2RmmJ1hW46KHlCyxkBXEG4jG3zZ8/Y2IjI/fPMyBqUN2dioY46CbscVfnW4SkVLGgPd
	 LEN4N4oJDKwLnkM1mt4xJestbNbca7OTPD+gWd36gf7u5yGXRloVyOzOFlRlU+Eu3K9BP
	 xe+uH/L3/L4dewDNurA9xC1XVcJ+0k5nJGyPbbDpvSR5T0J2ui0TWPVn9qf9D5EJXUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WpCoFTUIjxCS4FmGXYaqDO+Q+b+RAm9IyIvNFcfMbyg=;
	b=43/xR9fUWTjAGOXZf/zezHNccOajC3ZPzONG4tI3Ct71tNxZ6+1DBYTs/4qVp9Wu2I8Y
	 SsRKkb1jHrYCZJBJzFVkzV3jN8lsQ7PwYFounffuV2thvkP0CpBb4BXHtn+/tsw3Z1aev
	 1o4ou4Wths+7CMWsWE2P9BxYym4J6276XMuAbNv6K8QS2iURLGfjOoTtiPQMf1L0NdnRb
	 WA7Jl2UxJciu8nR1RrDQMxmyIuS3NkRTfSHWXFcI8zI1B3jm3t7gaQsSVlLnts3YaX5p6
	 F0X0zzxs3OeaO5q+Vw+L5s1WW8x1I/r70IczvrQRWV14wYu0/bIKCRVHY9kxh+uqK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFdeB1sz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA37C606A322
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFdeB1sz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE981F0089F;
	Sun,  8 Nov 2026 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148222;
	bh=WpCoFTUIjxCS4FmGXYaqDO+Q+b+RAm9IyIvNFcfMbyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFdeB1szbs+dp49t7iHoVn8ZsLxVIvQUABQ2EP8sH9f4Qk7AwQ6l7HWZSljYPNqzD
	 TXnRr6yW0Y/ztuPAGepZjnv/j9PGty22KdlK9qvb1uyMay5kKEY6y0wuYRSvQbrWI0
	 fmmVCtx0fQR+VW3i1nGeUxd0iAlHsdXx0A0EULvG6bHBzDmN4oT9NDUMSXrkosT/hB
	 Xi3VxHph1DXnDAxv9ekV9h8lqx41QKSVJ4B8UTny8uiLYP+sCxTEa7lxm7KlGhNmj2
	 n2qX2wjm8va0wy1vJpXKXmgTqZbtCiJC3Hmij1vmB8KEkx6WwyamKEPfClMkTY5xH/
	 3vkmJ1TzK7vTg==
Message-ID: <sashiko-outbox-203806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/paddr: add KUnit tests for addr_unit
 conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261109-test-damon-paddr-addr-unit-kunit-v1-1-bd10bb87be98@gmail.com>
References: <20261109-test-damon-paddr-addr-unit-kunit-v1-1-bd10bb87be98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:30:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_pa_phys_addr() and damon_pa_core_addr() convert between DAMON core
> addresses and physical addresses using addr_unit.  addr_unit lets 32-bit
> kernels with a 64-bit phys_addr_t monitor physical memory above 4 GiB,
> but no test covers the conversions.
>=20
> Add a KUnit suite for both helpers, including a case for addresses above
> 4 GiB that is skipped when phys_addr_t is 32-bit.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-test-damon=
-paddr-addr-unit-kunit-v1-1-bd10bb87be98@gmail.com?part=3D1

