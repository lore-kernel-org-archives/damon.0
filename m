Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C53E63B6
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398289; cv=none; b=RaaFgMzDbTl7F1mlnytBzMm/R55ag5Mu+AeJ4wu3VgCYJbGWJJaaHtuxVqS/UxLPckMs4o5IV48d3dxjkz6piwafAeoI5Lz42Y9fFLwzf0W2KCJRMrTYbYNbuq1YOSDzlWRb4v4d4vINZtl8pbkn8j56Ep26+ksnD2KahgY4ub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398289; c=relaxed/simple;
	bh=VoK3wGlqdJpH70X7BmjMCcQyuyPfpu1BxJy0zhM3G1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+ZDvzaidONykxcbLstusH1r9/N/rv0sRrZcQiP6Cr2THLr4+5FxMn4QJcRu/E9NBWv2I7/Pd5vDrZhqrdjeQLp8Wc9TH9ux2a63s+m8muNcCO2ghcLzupi+O6PTIbOkbOxFY5cxj1T+ndr1gViqj9gqBzuBZvznw3gQ77Wvsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkk09vu9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkk09vu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C53E1F000E9;
	Thu, 25 Jun 2026 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782398287;
	bh=oiiUF4UVKlcdjIxtw4f87qV7DqzROJhmlZHXPliwau4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xkk09vu9pPz27JkomQugTgIyoYhvLMZ2shKOcNiZ4AbgLNFugQkYAzXXzoBMz2Ek6
	 EYMMxNwuoIb9CaRfsY+qDjser8ca7O0/VwauGDeCDBy+CRPja1g8yG+uw4JYvrbPGq
	 AInKaq9fBLJcAFZhwKDn0cm0Sj1aLDIXv8ls/xM5HQswxIJZpXePhKR/PD9Kq9hLXm
	 f+3hfLQrOik7DOFNwubrvocv+Voa6OBWY8Yt4AnYrIdP1GNIzc2mG0sNn+UvQVlFEB
	 M3tcJZ84WPFGBanaW7NhSJlt2a+ps2pO14JePnm93YJJC94LYW6bIDELiNZ72f3YlK
	 Ndsvg9Q0eZ/3g==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Thu, 25 Jun 2026 07:37:44 -0700
Message-ID: <20260625143744.104757-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625143115.8303B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jun 2026 14:31:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The `counts` array computes a histogram of the generated random numbers, but the results are never validated.
> --
> 
> commit 545f6f76f7e281c6063dff020687345d3e3d45e4
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test damon_rand()
> 
> This commit adds a kunit test for damon_rand() to ensure the generated
> output falls within the specified bounds. It follows a recent change
> that optimized DAMON to use a per-context lockless PRNG.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 1cfb8c176b873..eec7cb325a431 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1460,6 +1460,22 @@ static void damon_test_is_last_region(struct kunit *test)
> >  	damon_free_target(t);
> >  }
> >  
> > +static void damon_test_rand(struct kunit *test)
> > +{
> > +	struct damon_ctx ctx;
> > +	int counts[10] = {};
> > +	int i;
> > +
> > +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> > +	for (i = 0; i < 10000; i++) {
> > +		unsigned long rnd = damon_rand(&ctx, 0, 10);
> > +
> > +		KUNIT_EXPECT_GE(test, rnd, 0);
> > +		KUNIT_EXPECT_LE(test, rnd, 9);
> > +		counts[rnd]++;
> 
> [Severity: Low]
> Are we missing a validation check here? The counts[] array computes a histogram
> of the generated random numbers, but the accumulated data is never read or
> verified after the loop terminates.

Good catch.  I will drop counts[] in the next revision.


Thanks,
SJ

[...]
