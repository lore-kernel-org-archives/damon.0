Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935996;
	b=SsTCXny5E3UQ3oZMHrlSUYAC5OMFkxNN4rq6TOZ5tAJNtLu9KEqPWoI3la0L5Sga6o4T
	 r0h3VrZWYfj8wM3VfbI9FscofDD1Mf/XsQVYgSaPHUjLxIybY0fpql28aHgf7hfZlihN1
	 p58W+xdf16PDVVF8xBodP0LTJUV16B2kDEccfMuLEM227BslittDEf9dwKi5/cI/JsBo2
	 Yl/1pSViWpwHtW+42gRoD+3KkRPlu/of4RDMCjvFOSrP/35UR3lZKtxYVsW36D809KZy1
	 pku5ZYw0rjcnbbCzBToN9PHGFNaqnWhR/7UyIm0bClfGxqgehz6cKC7A9lm5XmqLU3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ECWSVXZXiuIp36k/u1YboDGPwUcwviYoeLAITq5+mCg=;
	b=JNuQJKfUNVL9+DY6dwYW0x0dK1Os1Udx18ocuIBkjo5SX8ZcdA4SrT3/QjHJUqEkZ9a3
	 K5aeimHYoQjGD4Ffz/BWvPXdFfSJDZosGyjUSAs0UFWPGg2vlk7as8tnO7EiMIgnRQv50
	 i6bjvgn456Kg3h1WH4eGChohGPvHSXmwN8Rt9Ru0e/fXPFzfdbRHmL/q5odPApAQ3mTf9
	 bfsywJMFP/BjRnNXze6Uf0KUV9E31Jp76cW67CC6mr8y38Owd8P9ou7YIW/t9pJBRgSz1
	 eQZBnEk3nTRUcn+Kn68IopEMQi2haJ7w+3sIaQzzQJZ1YQ5RH9bRKyhQ4do/uxFACGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrZwEZWJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319A606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrZwEZWJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130771F000C4;
	Tue, 17 Nov 2026 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794935996;
	bh=ECWSVXZXiuIp36k/u1YboDGPwUcwviYoeLAITq5+mCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RrZwEZWJhqxLh2L28Mp0zb9zJbrGJPaRIXTkfdLv0c9S5QRwQwlx5r9HL1nHrWP4q
	 qGqq7yNfcqN8kPE4IEFqQ2Ay2IjCZUTVeavb/44dqZDD1qLe8EE61rUJaZcf6Jws2m
	 Sn4A0U0kt52skendHl2kBHpEGcM+kCv83P2qaYkPVo4e1mHmyQvKQOs58CNj+ksJLU
	 mEzjfVSZ6LmJQ4+NJkwzqocVqxuHZWLqvEQscNeW0BS7SxjHoGW31VJfE51ElDJILl
	 uQqpCsoj/ryA2c1iF4vzalnsiugwM3f/f+OlTZZLnBf+wApzN9JvmT3R8mWEUUWuMi
	 xgZL0+PSGaPbg==
Message-ID: <sashiko-outbox-219225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/paddr: avoid truncation warning in
 high-address KUnit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aveline Noir" <jm5905938@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118-fix-damon-paddr-sparse-20261118-v1-1-3a0e943406d5@gmail.com>
References: <20261118-fix-damon-paddr-sparse-20261118-v1-1-3a0e943406d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:19:55 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Hi SJ, Andrew,
>=20
> The kernel test robot caught this issue in my earlier addr_unit KUnit
> patch. Feel free to fold this fix into that patch.
>=20
> Thanks,
> Aveline Noir
>=20
> -- >8 --
> When phys_addr_t is 32-bit, Sparse warns about truncating the u64 address
> passed to damon_pa_core_addr() in damon_test_pa_addr_over_4g().  The
> runtime kunit_skip() does not prevent Sparse from checking that
> conversion.
>=20
> Compile the high-address assertions only with CONFIG_PHYS_ADDR_T_64BIT,
> and keep the test skipped otherwise.
>=20
> Fixes: 7a983cc1b573 ("mm/damon/paddr: add KUnit tests for addr_unit conve=
rsion")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/20261117170155.fEdeuuhm-lkp=
@intel.com/
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-fix-damon-=
paddr-sparse-20261118-v1-1-3a0e943406d5@gmail.com?part=3D1

