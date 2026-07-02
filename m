Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F987B67E
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950721; cv=none; b=PkB6FaqlEz9Ci81igJ5CtsVBXDKELzGNT0tBOiXpAg6gMR9f1rSapJNLmuL3A4dI0XiI2ZRrGy347XCh4Cp1O1miBroJrq7CLUcFOtIM7YwJvNhVvVSGgOF/Dmrho7CEblf7ms1USd6pF5enFHi2Isr6ocT8L1y4hxQLAODxUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950721; c=relaxed/simple;
	bh=yJH65FD65IW72w405dbvp69Bg8X9rqQCi6VtzHJ4CvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBzCOHanzprHb3kfiocQ1Pz5AXf+BKtoguhBt7EOMt+SBvh595kkermpM0ZCVWpfBhzb30UdLNBvf1hWVW7n3sQng2JPbsAHrrnOyzaGAR12e+ftYKeekHsI2CbeLByxOtaE1Eo4iCHKEq08Hi5jY1uDyiH7AXGVE+rsnfTFUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhaJl1kb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhaJl1kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75CF1F000E9;
	Thu,  2 Jul 2026 00:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950719;
	bh=HaAvULyBR8KoX5IZutavUNYdx5b4lTFzdizI7qK+ma8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fhaJl1kbtg8M7nK5l1ftSUEELTC2jcC/7HqpLh9h9zrDkh8450WzAl+hQ5Lr32zqB
	 h0dbfwD8LAPUhrbWPOS0JwmFHkADvt4CzySIfTqSsMHUvS03HXMog8INZ6K+pltxd2
	 WLDyWHF1NrIRVVo2Nh/lYx3d7n/DUylNMQ40tVFsqdU5++jB/4i5OO4RQJYIQeCJKi
	 KFScrYh+hux1hRrkgCUk0TktCmUb8DoEqwLVIaPzymc5pZfPfbsbWPPXqOqeWF/BeU
	 Q4eyKZ9ndPjaQ2hmJhxAviKSMSXv1Qi8ktr/ihOVxJvHu/n5Nc9vHbZFSpzZYxjlzH
	 UfAhZZv4Imprw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/8] mm/damon/core: do parameter testing commit on damon_start()
Date: Wed,  1 Jul 2026 17:05:09 -0700
Message-ID: <20260702000509.86086-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701152050.BDBEE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 15:20:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] `damon_commit_ctx()` incorrectly validates `dst` against `test_ctx` instead of `src`, bypassing the safety mechanism.
> - [Medium] Reusing a single `test_ctx` across multiple loop iterations in `damon_start()` leaks state between contexts, leading to non-deterministic validation outcomes.
> --
> 
> commit db4fd1a9680927efd94179ba2c47dd9fdd14f123
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: do parameter testing commit on damon_start()
> 
> damon_start() and damon_commit_ctx() are the two main API functions for
> setting DAMON parameters. This commit embeds the parameter check already
> present in damon_commit_ctx() into damon_start(), allowing callers to
> safely use damon_start() without manually validating parameters first.
> 
> The commit message mentions that damon_commit_ctx() does holistic
> parameters testing. Looking at damon_commit_ctx() in the same file:
> 
> mm/damon/core.c:damon_commit_ctx() {
> 	...
> 	test_ctx = damon_new_test_ctx(dst);
> 	if (!test_ctx)
> 		return -ENOMEM;
> 	err = __damon_commit_ctx(test_ctx, dst);
> 	if (err)
> 		goto out;
> 	err = __damon_commit_ctx(dst, src);
> 	...
> }
> 
> [Severity: High]
> Does this bypass the safety validation mechanism in damon_commit_ctx()?
> 
> The validation incorrectly tests the active context dst against test_ctx
> instead of testing the incoming parameters src. 
> 
> If invalid parameters are supplied or if a mid-commit allocation fails, the
> incoming parameters src are directly applied to the active context dst
> without any prior dry-run validation. This leaves the active context dst in a
> corrupted state (maybe_corrupted = true), potentially leading to monitoring
> thread crashes or unpredictable kernel behavior.

Correct.  Same finding was replied to the patch 1.  I promised to fix it in the
next revision.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 5ca176eb27e1d..ace202f47dd7c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1785,13 +1787,22 @@ static int __damon_start(struct damon_ctx *ctx)
> >   */
> >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
> >  {
> > +	struct damon_ctx *test_ctx;
> >  	int i;
> >  	int err = 0;
> >  
> > +	test_ctx = damon_new_ctx();
> > +	if (!test_ctx)
> > +		return -ENOMEM;
> > +
> >  	for (i = 0; i < nr_ctxs; i++) {
> > -		if (!is_power_of_2(ctxs[i]->min_region_sz))
> > -			return -EINVAL;
> > +		err = __damon_commit_ctx(test_ctx, ctxs[i]);
> 
> [Severity: Medium]
> Does reusing a single test_ctx across multiple loop iterations leak state
> between contexts?
> 
> If a caller invokes damon_start() with multiple contexts (nr_ctxs > 1),
> test_ctx is mutated in the first iteration. In the second iteration,
> __damon_commit_ctx() runs on the same, un-cleared test_ctx.
> 
> For example, if ctxs[1] has an obsolete target:
> 
> mm/damon/core.c:damon_commit_targets() {
> 	...
> 		/* target to remove has no matching dst */
> 		if (src_target->obsolete) {
> 			err = -EINVAL;
> 			goto out;
> 		}
> 	...
> }
> 
> It evaluates against the residual targets of ctxs[0]. If ctxs[0] had enough
> targets, the obsolete target incorrectly matches and passes validation. If
> ctxs[0] had no targets, it fails with -EINVAL, producing non-deterministic
> validation results.

Good finding.  I will allocate text context for each user-given context in the
next revision.


Thanks,
SJ

[...]
