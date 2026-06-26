Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0813B293
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434396; cv=none; b=nET6Y7oUlqLY9bXSIDQRdHdnTkKJjQrUXTjYWjFuweoe73mr5Kw/ySE0ZtG43Zm+zT7tI7JYzXCmE97R4ZVHEaAZYVh4lJMmS8RiAVWl8JeL9RqMtL7nwJrtJtj6pPLihlKCYnvHol7OcETgYQoBVgFHJ7/mkXqpoSWIjDd1SWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434396; c=relaxed/simple;
	bh=60bAXNIFMcIh/cG4B56xpEDz2nXlEt9uM/DepdBoAAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qzdbu4/MEfsK5ymhNa4h2DHo1OLnMG9vmx7foqC7Za9lq/k5XNBEv79E8C+y1UjHgobEFNPEGvpZo9Izn0qeqpd8hD0Z3mraHqNU87s+rvTWWLZcRXTIkQnly4IIba292dWsyQ4NlLAC+phoQW0gG5ufpmWi4MSWYW+MTkrf0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnrT5zEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnrT5zEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5231F000E9;
	Fri, 26 Jun 2026 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782434394;
	bh=WH8/1431K5tIgMKonUlZiqTNQ0zXVmeq1JafwBYObaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XnrT5zEik862ALu/yxSvfZ369xZ0XTHblnLgjkmEvFEeh4LRKJleo5V6S04vkJigJ
	 62UWaaUY0mntgznoE/3seq0xiY5swJ+rN64yFTRZzJiflOjAgnP5pDM0/08UMBeM/I
	 IVuyiqIRkWRHd6TNTZbKI/eNYRLwR3z5drn61V46YwphfOu09+6cbs8wEILQFMGbWs
	 xsRe1oqEG2uP1qslyrH/vZIhEOqrjdfwoMwOKJH6bXH/vdqLPtbIK65UR+8DGj0qJO
	 DE+WbOrv8wZxzbY6hh6a0pRIEG6Z8fb34GegLNyG/+SamF+wLgKygOU44oRr/Zut6T
	 ws6I1CEw72mbw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Thu, 25 Jun 2026 17:39:49 -0700
Message-ID: <20260626003950.87863-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626002519.C1BBB1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 00:25:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incomplete test coverage: the test misses the 64-bit execution branch of damon_rand().
> --
> 
> commit e5514cf11386fbde6faace5ed2dc4b93fedc4bf8
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test damon_rand()
> 
> This commit adds a KUnit test for the recently introduced lockless PRNG in
> damon_rand(). It validates that the generated numbers stay within the
> requested bounds.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 1cfb8c176b873..282670b0fa908 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> 
> [ ... ]
> 
> > @@ -1460,6 +1460,20 @@ static void damon_test_is_last_region(struct kunit *test)
> >  	damon_free_target(t);
> >  }
> >  
> > +static void damon_test_rand(struct kunit *test)
> > +{
> > +	struct damon_ctx ctx;
> > +	int i;
> > +
> > +	prandom_seed_state(&ctx.rnd_state, get_random_u64());
> > +	for (i = 0; i < 10000; i++) {
> > +		unsigned long rnd = damon_rand(&ctx, 0, 10);
> 
> [Severity: Low]
> Does this test miss the 64-bit execution branch of damon_rand()?
> 
> The damon_rand() function implements two distinct calculation paths: one for
> spans <= U32_MAX and a 64-bit fallback for larger spans using
> mul_u64_u64_shr().
> 
> Because this test hardcodes the bounds 0 and 10, the span evaluates to
> <= U32_MAX. This guarantees that only the 32-bit path is executed, leaving
> the 64-bit logic entirely untested on 64-bit architectures.
> 
> Would it be helpful to add another iteration or separate test case with a
> span greater than U32_MAX to ensure full coverage of damon_rand()?

I agree testing it together could be a good idea.  But not necessarily a
blocker of this patch.  I will consider adding more test cases including that
in future.


Thanks,
SJ

[...]
