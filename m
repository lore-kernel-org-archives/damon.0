Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199620;
	b=M9ZJIADt+BtPJX6HCiNLEcUSClnLm0+zli0Ussn30Hafk8O6/YClUBsNDN1d+Eu6tDs4
	 6HRO96n0XHfVvesO7QmEvlP9bKZ4Wb/xj/eSPJ4rN8xJX0YVZ45epK7pQsyOzOfj/V/FE
	 5zf0uE4UiAww5QG6UWLEagkc8BpXhaZ58uB6tdJ7HNskeJDn7dFjR3j4kpTV2XvDtRCXU
	 PnLktDVwJ9aCkK/M/6SB9FvF++pf+Po7DJRZEy2rsdlmhJR3QdgsWxU6D0OwPJqTX2W/G
	 vU12avs08QOfp+eD7xiCQ1iyLpivd3QFNUsH+EJCOS24uHMhrjVGdU80McCmzk+f4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199620;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wNhjsUB7XcU5gCjg2sVzpbrcZZ9or5ow9SLiudtkXCY=;
	b=d1/+FmscsO9Kx9XmJZYC+ilWawGB1Ck9onElAHl7goykWKSV7V9LniIyoTiS/q/zIy/m
	 iJFC3HwrxPIwXHeZOn+4cu4Yn/bZHq0sT9x0ROhStmm/xijjxNbkqr+IY6935fBKBmhL6
	 ohrEhjmDOqJ9iW/wHMx5o0PdeVinO4G2l3PMce+U+Kaavvfg5Zp59FMb8CmIkAOaFqM9s
	 QmMarXYnayJVhKxuA4dcQ+kaI3XH898L0n5YLm5aFxGe9lkHSqBtP2p5AAaa5GOnhLs3V
	 2L70R4X95ErUJrELyYbJqh5Z1hcwol5TweOn1Syl4UvsUHFyj1LSk7Od61mXRbJIMaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+mJMXhQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772D606A31D
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+mJMXhQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960A91F01829;
	Wed, 28 Oct 2026 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199620;
	bh=wNhjsUB7XcU5gCjg2sVzpbrcZZ9or5ow9SLiudtkXCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V+mJMXhQw6wIsVsBJjw9kHY6bX6+1owDJ1lCzj8wYPMRythrhVkw1Rf9bJrM1A+vC
	 PAlT5Mf3SeY18Oz75FdJo42kmBsoV8vXyVQ3OjlaLjCWzEtQkniG+MQdBIxm/NMCeS
	 iRyfijheRwoEVH1lpGddSBiFTeB4gN8CKaGrjlXYdlq/NiJjl2iqjBSGk0OtPd3MJh
	 un6yKF95PfXlcRqGKwOoDStOeumVIOEzrScLWp0cDfr+6chvmDnahtccfXqyneuoZj
	 /YtZeptlPISGaJYoMo1ZWR+0HZ7Kv+ymNUZVMIf5awiBvPMk0PBkuYSQRODgx46MeT
	 8pXJwufDJx4Ww==
From: SJ Park <sj@kernel.org>
To: CharSyam <charsyam@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	bijantabatab@micron.com,
	ravis.opensrc@micron.com,
	bijan311@gmail.com
Subject: Re: [PATCH] mm/damon/vaddr: preserve migration weights above UINT_MAX
Date: Wed, 28 Oct 2026 08:00:07 -0700
Message-ID: <20261028150007.163381-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMrLSE7U92fKTBzRYL+hiSMzoMXO2=ZcQYVpV-90CF=193Khpg@mail.gmail.com>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 23:44:28 +0900 CharSyam <charsyam@gmail.com> wrote:

> Hi, SJ
> 
> > Even just keeping the current behavior looks not really bad to me, as long as
> > it is easy to test and only shoot the foot of users who didn't run test for
> > their weird inputs.  We can revisit after a real issue report is delivered.
> >
> > What do you think?
> 
>  I agree. This is a correctness issue, but I am not aware of any
> real-world impact,
> so I do not think it needs to be fixed now. We can revisit it if a
> user reports a problem.

I agree, let's do so.  I will consider adding the input validity check with low
priority, since it might help us getting a real issue report sooner.

> 
> > Please avoid top-posting [1] from the next time.
> 
> Sorry about that. I will reply inline from now on.

No worries!


Thanks,
SJ

[...]
