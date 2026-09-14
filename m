Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C483BFE3C
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429356; cv=none; b=Yno/XMEkXqj0IY4Xqz5/26mmkEl+EhUZ+EPduEwiBmVERMPk8XITcvFnj523sbKLjxtFZi32s/iU4Pq/6h1oilYyzuu+754Xop4ucYjB/arKcwzNdU/2yInWemU87gNm/YyEm6SyFGSmm27WgkguF6WktMVuhyh945kmUsAh+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429356; c=relaxed/simple;
	bh=k8dB9aftbqy+/l2dSLKF9U73VQBuvgFc3z9B3BV0xKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5AkZLYTs73rk+NPW5CfTV4WOx48dE26b9fUmFeggY7U91LYPC8ZYYPIwtw6wBMOgNZiQ+KXww9MrF+ZuavA9cMFqgmQdSlFyEgrkYUWd2Vo8AhL3yu9y3flreq1q2qsqXjS/dH33G9TU+RllMG7eAvM44GvCuxzr2ynJ7Rjp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnSxt5g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnSxt5g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B601F000FF;
	Mon, 14 Sep 2026 23:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429353;
	bh=z34HvTomq8sU2uWcIJIm6zAQcc7pj47eAIpgSJWuVTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnSxt5g8TyWP4P06g5NB4CZVlG6HPSIrPc99J0d+77C0n6O/4AddgE+pWqCz/2QiK
	 zOH1EQ6YcpvGGGXqOym1FchStrDKhtsEEYTpZOuR7cVeMMartVSea0YJ8RxYTSiSG4
	 rclSDtS4kwdwA/aSle35Ly1iJIHMTfk2kR2bdW/QbsxzmjbRIMD2/Jm/kD4UjifwQF
	 dMxWVZd5LvPMDt1y+LFyv0w/hFDvtZiaB4qnPqPyHrwLwPNrBRgB7dyoBtkNB/UILb
	 QGXPwxiNamUfCx86GWcw4WqwO6TskoMPs4cehv1qo12uge2d3McUTaNJnjj0yV07iL
	 n7eqa16OAWwdA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
Date: Mon, 14 Sep 2026 16:42:24 -0700
Message-ID: <20260914234226.99997-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914154459.6CF891F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 15:44:58 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing test coverage for invalid DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter commits.
> --
> 
> commit 3dd853ee9735627ad90ea3f3d15874f043b5bdb4
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core-kunit: test invalid damos filter commits
>     
> This commit adds test cases to verify the validation of damos filter arguments
> at commit time.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 2b0931cf6fb32..527abc2570616 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit *test)
> >  			.allow = false,
> >  			.sz_range = {.min = 234, .max = 345},
> >  			}, false);
> > +	damos_test_commit_filter_for(test, &dst,
> > +			&(struct damos_filter){
> > +			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
> > +			.matching = false,
> > +			.allow = false,
> > +			.sz_range = {.min = 456, .max = 123},
> > +			}, true);
> 
> [ ... ]
> 
> > @@ -1197,6 +1204,13 @@ static void damos_test_commit_filter(struct kunit *test)
> >  			.allow = false,
> >  			.addr_range = {.start = 456, .end = 567},
> >  			}, false);
> > +	damos_test_commit_filter_for(test, &dst,
> > +			&(struct damos_filter){
> > +			.type = DAMOS_FILTER_TYPE_ADDR,
> > +			.matching = false,
> > +			.allow = false,
> > +			.addr_range = {.start = 567, .end = 456},
> > +			}, true);
> 
> [Severity: Low]
> This isn't a bug, but is a test needed here for
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM?
> 
> This patch adds negative tests expecting failure for invalid filter arguments
> using DAMOS_FILTER_TYPE_HUGEPAGE_SIZE and DAMOS_FILTER_TYPE_ADDR.
> 
> Because DAMOS_FILTER_TYPE_PROBE_HITS_WSUM uses identical validation logic in
> damos_commit_filter_arg() that rejects arguments when range_max is less than
> range_min, should a similar test be added to provide equivalent coverage?
> 
> Also, earlier in this file, damos_test_commit_filter_for() validates
> successful copies for other types, but lacks a case to check range_min and
> range_max for PROBE_HITS_WSUM. Would it make sense to add validation for this
> filter type there as well?

It makes sense to add the test.  But not necessarily a blocker of this patch.
I will separately work on the test.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914142327.92510-1-sj@kernel.org?part=8


Thanks,
SJ
