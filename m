Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4D280331
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 03:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297381; cv=none; b=T1BKLramK6W/nC+j4S9P1uOA43XXzsNNqh+S1xcpooA28gdunO3RjMl0T7Wa4TmcacTrQGWqnSsuLSm2h19jeDZNXTDzkIC2/ooPVR5/aRGJkg+F2FZNNU5wGrndszzAwi4LCObMtUZvquoOajJbxvf1L6nMViH0evXP7tZbxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297381; c=relaxed/simple;
	bh=lmW2qeZCZyJXuhtEZZSlOO06aIDXdzGP5eKUW5Pm2gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjkFcUzj6cPiRI73LvsLcDh+Kr/eoUEQgUiAsX4OH8bEKMkL5hBtEBj2UQZImiUg0DpBWznq2xqgcJ2zU6NrRiIUF4xS54wYXAAU4FUZCno3uTLYX9ESen1vm7rHXfeVkWRj43RYDlqLLnT4vKFQJhx9NxotDlvYcp2gqHQ5Vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhlxxGf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhlxxGf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E1B1F000E9;
	Wed, 29 Jul 2026 03:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297379;
	bh=zzC4e7i6M/GnNe7Vb3htl4yruz10aNdEOgaZ/AxJBFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhlxxGf2TgE7DahVgHYrnjNL8nKxvvmQ5/rvkaAAFV+GdSBLSrmZsDgLe0zFFdCTk
	 OY4et2OcAPTJjp+PlCT40fn2YKvaj4LImgNrW0gJUpS5PhU2GWAPZzziJR/CyfhiZ5
	 TWpcqJPO7NMxjlrvJbr7BppHP1swHPGH44hrBn8UCIW1s4Dg4rYXZXi3zkXCQbdMHX
	 dnL9UBonSkxHNF0hNd19pzlHOZ9x9Nq6FT/tiHoIMF7zAI0G+pn9vKad1DoJyW/mQW
	 GLLhWkKLmhl/bi7kx63D8hhLtDFKznwKycVXtCypKR06wVwDpgWUfRGZSxldjHsD67
	 Ny2cxXS0ZAIWw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 06/10] mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
Date: Tue, 28 Jul 2026 20:56:11 -0700
Message-ID: <20260729035613.131661-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729034822.AE14B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 03:48:22 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Typo in comment: 'alingment' should be 'alignment'.
> --
> 
> --- Patch [6]: [RFC PATCH v1.1 06/10] mm/damon/tests/core-kunit: test overlapping ranges for set_regions() ---
> commit 696ade5451511d51ec415451a2df25bef4d15e9d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
> 
> This commit adds a kunit test case to verify that passing overlapping input
> ranges to damon_set_regions() is properly disallowed.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index ac15393a7935b..3041b8288ec26 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -606,6 +606,17 @@ static void damon_test_set_regions(struct kunit *test)
> >  			{.start = 42, .end = 21},
> >  			}, 1, 1,
> >  			(struct damon_addr_range[]){}, 0, -EINVAL);
> > +	/*
> > +	 * Regions resulting in same region after alingment should return
>                                                   ^^^^^^^^^
> 
> [Severity: Low]
> This isn't a bug, but there is a typo here (alingment instead of alignment).

Thank you, I will fix.

> 
> > +	 * -EINVAL.
> > +	 */
> > +	damon_test_set_regions_for(test,
> > +			(struct damon_addr_range[]){}, 0,
> > +			(struct damon_addr_range[]){
> > +			{.start = 10, .end = 20},
> > +			{.start = 20, .end = 30},
> > +			}, 2, 4096,
> > +			(struct damon_addr_range[]){}, 0, -EINVAL);
> >  }
> >  
> >  static void damon_test_update_monitoring_result(struct kunit *test)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729033751.131213-1-sj@kernel.org?part=6


Thanks,
SJ
