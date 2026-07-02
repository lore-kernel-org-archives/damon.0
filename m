Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2133890FC
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028171; cv=none; b=Tu9+VMaInmrc/GZm5ykgzJ8QbuGwGUYytJ1u0TBZFnUQpukVAHOq/cv3P5VjIVJXmXeDsPfxZJHup7Lgr+mulRJEQZVLj7wk1XXJ8zodcx8sifMgoa60+BzI17HHiLDtpRkduK6OxU16+NUw758tt9jnn+wt6t5HgLOUUgWvZrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028171; c=relaxed/simple;
	bh=mFX247ufhc2FqgMA0Ltzq/Yf9A9eA9wYi7GQ6QJZhnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRSetrW+ICdoQM3sHaOuYJoQ4OeG5DADtHheYHC+Dc51QifMKjKqEftsWJB2dKO5id9hbLn2yvNr/cRXYJwS/wud3wCMwJqZKrky9t2lLrlkKKP5sqEnfgTNHm4cFZgoOlhOnkv31mcuFOZPUlRFuu9wifUJh0SVykmcTVdObTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY46lJQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY46lJQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFE21F000E9;
	Thu,  2 Jul 2026 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783028167;
	bh=87obZ3gHOsKSg8hj4RXJ47bcCG407TM305NP62ku6Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HY46lJQqA+sMONCI79KAt25KQCUQyBc5wmyex200z1nvay69bedXkjKPTrCgRnFke
	 o887VWVV5orJ6tWM2Tu9N+rib827mzhkhkpm/Rn2P+Cs+wGFqrzKpGFLE5TObB9WZZ
	 5kVkgrOftpsmysVcVlkMbuPI+wtQrTHi7PjVyn+/Mzo6z/NbIGm9R93x8Ij9VKp2qi
	 1CEZ26FMZs6toq9Zmx2TGaJI2tGjw1i5DILRtttfVrwNB6JkoHJ/ee6P2sDqU1GC3R
	 2hGhv8Wv5w9LM9I+CfEOeUMO9CRad4Om3wbLbOfY/ufnehwhrpAQn3SfUFhk42t4IW
	 MI7FTThRSrhXg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/8] mm/damon/core: safely validate src on damon_commit_ctx()
Date: Thu,  2 Jul 2026 14:35:58 -0700
Message-ID: <20260702213558.96934-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702212143.0CB6D1F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 Jul 2026 21:21:42 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] damon_commit_ctx() silently corrupts the quota charging state of running schemes.
> --
> 
> commit b274d76c061808ff0cd97c6e9433199f816cc1de
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: safely validate src on damon_commit_ctx()
> 
> damon_commit_ctx() does its holistic parameter set validation while
> applying the new parameter in the set one by one.  If it finds a
> parameter is invalid, because some invalid parameters may already be
> committed (it is called "commit" but not atomic and irreversable), it
> stops the running DAMON context.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c6fc35be633b3..b523a18a7b971 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1702,6 +1689,52 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
> >  	return 0;
> >  }
> >  
> > +static struct damon_ctx *damon_new_test_ctx(struct damon_ctx *dst)
> > +{
> > +	struct damon_ctx *test_ctx;
> > +	int err;
> > +
> > +	test_ctx = damon_new_ctx();
> > +	if (!test_ctx)
> > +		return NULL;
> > +	err = __damon_commit_ctx(test_ctx, dst);
> 
> [Severity: High]
> This is a pre-existing issue, but does this unintentionally corrupt the running
> quota state?
> 
> When __damon_commit_ctx() is called with the running context (dst) as the
> source, it copies the schemes via damon_commit_schemes(), which calls
> damon_new_scheme() and passes a pointer to the active scheme's quota:
> 
> mm/damon/core.c:damon_commit_schemes() {
> 	...
> 	new_scheme = damon_new_scheme(&src_scheme->pattern,
> 				src_scheme->action,
> 				src_scheme->apply_interval_us,
> 				&src_scheme->quota, &src_scheme->wmarks,
> 				NUMA_NO_NODE);
> 	...
> }
> 
> damon_new_scheme() then calls damos_quota_init() on that provided quota
> pointer:
> 
> mm/damon/core.c:damon_new_scheme() {
> 	...
> 	scheme->quota = *(damos_quota_init(quota));
> 	...
> }
> 
> damos_quota_init() zeroes out the fields in-place:
> 
> mm/damon/core.c:damos_quota_init() {
> 	...
> 	quota->esz = 0;
> 	quota->total_charged_sz = 0;
> 	...
> }
> 
> This mutates the running scheme's quota state, which would make the quota
> effectively "full" mid-interval and prevent the scheme from applying its
> actions until the next reset interval.

That doesn't matter because it is only testing purpose scheme, not the schemes
of the running context.

> 
> Since this patch moves this test context logic into the core
> damon_commit_ctx(), doesn't this expose all API users like damon_reclaim
> and damon_lru_sort to this state corruption when parameters are committed?

So, no problem.


Thanks,
SJ

[...]
