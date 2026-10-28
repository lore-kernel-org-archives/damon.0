Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164835;
	b=HIb2PuhZmVefXczOnaeS4uNpBnlN2Ai1L+d2KXetgcKR7ukUUqsSFen0+asP7UGvi92c
	 w1bgQJ9/J7+09/2/FhYXiUBhyMisIPaYfVSGFO9fltyP1ulVdJpBbkDy7a7eu3h4Q6V3O
	 Ft1CZVBG1sD8iJSEGQIoCk3OJp/nSlxkBKT3/D1sy0N1605ibVySjAj9SDUoV0ATjfOOg
	 yUqcxOeakiz7lTCMLeOnP+Q2+6WTG668nSQkQSHDEiNMeyObdLHSviTmIGPeD/mY6DHVs
	 k1IzExicA3xGDAMpqyKshWTv3jqFn+4Y8Vxcd1hZg8Hwv0CBCeVz//wkCHzxh9nbLbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H0xBG+xgv6fbezQlDemDQ+tWGKLiW1LS2vRUrw2MdXU=;
	b=uEXdbN4JfADxyeK5hO8SN/P+kUAGLijiA/jHGaZTl0eneOskTKvxXv15KLRaIDQQ4eQX
	 1eicbSlweQCTBVh1BSr8u7JlyTRYQd76amtZhpamnFPNmAu/DYOC8zOfLBqUZNP+Fd4f0
	 ZCzQ7pSvgqj4m0G9zOwST9+sfvBKeS8oqsnfzqFJrgAADbUbwRTwTbdAqC0ytnIAGQGoL
	 OJcBrXtCqsM8RhzsZpeFZe/PH1K7sRn/xJoTf9mIYN5HH+Pn4Oe/YoyfYme+UsY+xvPuA
	 LMQqS1GuXgzYN/26vEG/8+3g0jESWKc4bOUBwTfeOzrsQogoEyrauCw7r7skP2a4Cvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO3Wllub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519F606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO3Wllub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B8D1F01825;
	Wed, 28 Oct 2026 05:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164834;
	bh=H0xBG+xgv6fbezQlDemDQ+tWGKLiW1LS2vRUrw2MdXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZO3WllubGDUB+68BLIUpTBdiym2u/ZFEKrrBjuTOvveAo14ihGCFlUOZo/t06jq7m
	 lDmsnBOxrD2fJB6xFuGT/oLEsLyLeTphk3b0liwQLoLdVdw+vgTYFAD8RM9uuemKQP
	 qiL1mLh4TNLvVFzQkxq9oSttoAx0+7ct/clOFG471qQD57XmZDQECqBHjWswmXUrZM
	 AzbY5pOKTBGeW45gCEknXsfTCywQc0M7jCGVYu9dqJ8unMUrKxjKEgtYQGRvHR1lN2
	 vy47ubrPxCDFpRlIg1Qqig44m8DJYqfKDfhMPrRq57sYbXAouumAPYnmEN8eaWYfpI
	 NKYT8JNduSSdw==
Message-ID: <sashiko-outbox-187526@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6.1.y 1/2] mm/damon/sysfs: put target pids for
 damon_start() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028051104.154232-2-sj@kernel.org>
References: <20261028051104.154232-1-sj@kernel.org>
 <20261028051104.154232-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 05:20:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_turn_damon_on() allocates and sets up damon_ctx to start.
> If it is for virtual address space monitoring, the setup increases the
> reference counts of the target pids.  After the setup, the function
> invokes damon_start().  If damon_start() fails, it deallocates the
> damon_ctx object without decreasing the reference counts of target pids.
> As a result, pids can be leaked.
>=20
> Fix the leak by putting pids using damon_sysfs_destroy_targets() before
> deallocating the damon_ctx object.
>=20
> Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spac=
es monitoring")
> Cc: <stable@vger.kernel.org> # 5.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028051104.1542=
32-1-sj@kernel.org?part=3D1

