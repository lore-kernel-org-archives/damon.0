Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701072;
	b=lHQTpuPB30wQgxkzjTEp86gKsucwB72veLAjXb10PBH3reUmoKXq6TNFp8i8mIWsn0xB
	 yH6jxrGeOCqAwEFm5JfJ4RWmpkdJ6ypT8OWREalp1+HJJge7SNUhS/DinDfYhOWCp57pk
	 WEMrUYinyt6Lplk8wKDEdMg72xBnrhT9ga4Zt8VJ3JyJWANc3SifJrynxA7IS8EJPDBBp
	 xMF8Ocv8K/suKfnD7fKfvI3tbNraIuZHvb99cUWrefj4M1ONqvMKuOeT4E2ySAu0Q9ApJ
	 Xd/Fh6VNwM4qyWwc8Jqgi7uOXYGKDjauBYCrGW6PwIvcCX3iiHecuB6H0nfAtMC5ZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=33oxIv5bV5W14yoEXBmgyrXwL6U3Kc9QUVyErlfwUw8=;
	b=dfqzLw6W/8W95d86QJ3Q2cI1JYLzJwsY/lFFmbLuIbrfMr9GdXWnR2kp8RmtYkNTF0Me
	 aIfT82MCaR5TwBOiMtbFF7eNa7U0spEYt/kmlsOTd9iSkU8BDNhwCUBwzPnAPBkl2trN9
	 Ig0DOB1PFcVVfWUpUoN5zGO2CJYBQqhOw23fPtfStvBvTd1TxCWNI/7tEUJdJVS8mqRMo
	 McrBmCS3aFARkNCjXQadJFCKRk0IK4U2IE37qI4xhUF6+C0xnWhsswPwBXy+ifdFdx18C
	 8/I102bMOT/BWEfGZUG8Jy2mOKgPtWSU5kTLcM3F2ju+C+b+y/j0MAc3VwbOOgfqeSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyScuS0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1F606A808
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyScuS0B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15671F00919;
	Tue,  3 Nov 2026 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701072;
	bh=33oxIv5bV5W14yoEXBmgyrXwL6U3Kc9QUVyErlfwUw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyScuS0BXqTJFHqurXwmsBrXuA3TtGqJZ8jUse2azCE+wg5EtBbLqf7VRpGSP6I2u
	 4gHWED0iBIZgpHRey6m7EYF0cd+HMWLHRzj3hrE2iKkQYwOT7IreWZybedOOsSjXtb
	 Cmu8rzG8HPGfQHASRGvzDAWsha0Q+oXdE1mi1YelC+2/B35s/jnH/OktODHcEXzAKv
	 L4V4Bsgc31OLuidg0gvIFBMaRDJ3pT+Fu75QDDLZPJP5v2/OmmVq4cVHn7ycxG7BmS
	 kk/aCUOm6wRJAU2fDfINjBXFxV/lZ7ipZQrRo8bzUMzmhGrx5JcDBTiP+m9T0vbqMy
	 4FzlSRGHz0OCw==
Message-ID: <sashiko-outbox-195023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/core: use list_{next,prev}_entry() in
 damon_{next,prev}_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Enze Li" <lienze@kylinos.cn>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103100714.70742-1-lienze@kylinos.cn>
References: <20261103100714.70742-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:17:51 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_next_region() and damon_prev_region() manually do container_of()
> type casting to fetch the next and previous region from the linked
> list.  Use the dedicated list.h helpers, list_next_entry() and
> list_prev_entry(), as damon_first_region() and damon_last_region() do.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103100714.7074=
2-1-lienze@kylinos.cn?part=3D1

