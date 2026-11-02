Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630928;
	b=CazU2TZ+4efBIYe7nUu5ZZRPMpj4WnY8BML3zXAkGLfYkKATapEEpg5WaybjAT5HB2j5
	 7dG5CNLZY0uyo40ItzYZLuLOgl+7QO+sLgmWsYq4d+jD9yAspE7tVntajdDZgJz41QNkd
	 FULAcKBqLM3RmlNJCJwGk4J0k2ZBS+0JL8bCcdqFEcw14MCENW2/qIOvQCrxq8/9J8BNg
	 5SPbhdf+oniCWXcZty9VLeKpUxObrZL6SvYehREVqDDtY5azzmLTm3C3tKHBUjlEN1O1X
	 Z7DvSR6BywFLoeOe2rrtL6BuwiC2VfycvYdCre0ZmtsxsrS+ePfvWMbweSYNEHu/hxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630928;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y5WlFLElMB431G3ZNM4dZCEkZMIcokDkM66S6LRmp/o=;
	b=KgoEyWyCBA645ld75gh4f6KuR9Tc7+01JiV3AJx7J9LqlB5/G9szg9zxwlAkVVB14VtD
	 AVsI2SrMnvRagOpXvEQA51baXRAeJVbmS/ihnwHZK14Dk+0GpR/UQmTbH6GS3633nngSx
	 jKS1Rnp7Enjszguz4xV/tVCNqTT0CkFdjPP3IwZGgezsG0k4r71vLDCXVhpZXUohZTr4z
	 xbnGz24+KZSGAGmwY+1gJvJsWYsxfp4MABolkMzP4ucyQC5I09pA4p2yuZvzYSh21PkmK
	 xc52JBzuVPPehU7ENFhsGSBAevzRsp5Cehxe6hRCEN7q9Nf9tv5MUGjA8rj9XGmEdBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9MyM1qY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14DE606ABA3
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9MyM1qY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E91F00A1B;
	Mon,  2 Nov 2026 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630928;
	bh=y5WlFLElMB431G3ZNM4dZCEkZMIcokDkM66S6LRmp/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E9MyM1qYPp9Oh6bbwY0kY1b0+vFJZ8NFTBFuisaSn0pee76qS6oFacOVMPmykjZWa
	 4crplJ34n7eO8hMPiZmgc8ViBYFAPVxZKpA0evLauOa4xAQgq0tRzZYnzDrQdMEBYa
	 rn7oD2E/t9zUo9sulXWDzUIWqUGhNpCi3KA+C6Q2mrMYQ7aSSnL1Vshm8D9nGIGkNV
	 jCTd7AQ0+pMvtdKfuTJ/QNm0lZjnNi33P3qMXLdYVs68yTl5Ltc+Rmgu5bUgw1sv4g
	 xpfCmmGh4H8cjhGkQT9c6mo5fbgVxzlr5wSnrcYDYhnucvvmTI7NA7dY1s3lb+wiXs
	 aWWOElohGCarQ==
Message-ID: <sashiko-outbox-193603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes-unstable 1/3] mm/damon/core: reset watermark
 wait state on each iteration
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102144627.88843-2-sj@kernel.org>
References: <20261102144627.88843-1-sj@kernel.org>
 <20261102144627.88843-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:48:47 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> Found while reviewing the DAMON source code that if an online commit
> removes all schemes while kdamond is waiting for watermark activation,
> the scheme loop becomes empty but min_wait_time keeps the previous
> positive value.  kdamond then keeps sleeping instead of resuming
> monitoring without schemes.
>=20
> The way to wake up the kdamond again without DAMON is bit complicated.
> Install a scheme having watermarks that can activate the kdamond again,
> and remove the scheme again.  Doable but cumbersome and complicated.
>=20
> Initialize min_wait_time and init_wait_time on each loop iteration so
> the wait is calculated from the current schemes and an empty scheme
> list resumes monitoring.
>=20
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Assisted-by: LLM
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144627.8884=
3-1-sj@kernel.org?part=3D1

