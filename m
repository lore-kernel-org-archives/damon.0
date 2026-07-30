Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D8DF6C
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369724; cv=none; b=VkeoSSUap6WFbjlpRwiGzvWLipo2VZ2fJNzJGwUjvfYwFlRn2ibWR6r8vpiRikh9IiAR+PmC43kF1UlMMhn4ZVQMkmHI/O7Ax8J+WyzE0qb87GxorfY6Xn+NZ+/GQ1oDhxFM83fXUj78seVZtD3QyN6pWmkOgGZwCfya21lQtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369724; c=relaxed/simple;
	bh=pNfwBq9xCga22AItmbKrk8tKxKnQu8A17FPfSllskb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nflg7LQoCnLo1+RqwPfd0sfm/47l4fxX6qB5c/Hbr0Ql6PtANsWF7+5+ECLZTP5iu0c6i6/JFAFlahfKv13OcZh3iho1gFjaZLmMWifyc5QLDq2EUmMCuSL7NBjGhGvIO8oQRdXpnxsyl9qPWHuhjWAsXsp4ygKg/2BDsYb9+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2pMYcIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2pMYcIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C785F1F000E9;
	Thu, 30 Jul 2026 00:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369722;
	bh=g43twrhPZJeqTVAHn/G0fOpjbomVkrIxUa3RXEtHbW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2pMYcIzD8oYRA9EaueqH/7aGmR+V+lUBKfl43zwsTuyCZ30oTnNdCzZHccG7I8+r
	 1ku8/62QDE7NKvjjbAyzJlrnrn0EbhzJUu9HVMo48xBBxKSBrlTMjKlgkrUyn/SghB
	 D0tx+iZOns2Rd4k/v/wgqcgH5iMFo2XOEIdzo6GexHiWQGDSkAoDqR80KbgGS+mbAK
	 fkGMEKxQM/G7GXKa/zUn3mtm6hY1WC+Qgkr2Pq2sr+j5UmbWFkPDwug2nFs07++7Qk
	 3HEd0MO4CO2b8HiIQUvW8eUGbOd29cXVl7SCDW7VFwIkv5B9uFhJyKBfOVwBHz9tfB
	 zGsxEZbAUgytg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/6] mm/damon/tests/core-kunit: test damon_commit_filter()
Date: Wed, 29 Jul 2026 17:01:54 -0700
Message-ID: <20260730000155.99604-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729145257.CCFBE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 Jul 2026 14:52:57 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The kunit test uses the wrong enum type `DAMOS_FILTER_TYPE_MEMCG` instead of `DAMON_FILTER_TYPE_MEMCG` when checking `src->type`, causing the `memcg_id` assertion to be silently skipped.
> --
> 
> --- Patch [1]: [RFC PATCH 1/6] mm/damon/tests/core-kunit: test damon_commit_filter() ---
> commit e16ea26a19f85858bdb608d81842e976d30c3270
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/tests/core-kunit: test damon_commit_filter()
>     
> Add kunit test to ensure damon_commit_filter() updates destination
> filter as expected for valid inputs.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 4a536d41cdb2d..6cbe22accabfb 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -1306,6 +1306,45 @@ static void damon_test_commit_target_regions(struct kunit *test)
> 
> [ ... ]
> 
> > +static void damon_test_commit_filter_for(struct kunit *test,
> > +		struct damon_filter *dst, struct damon_filter *src)
> > +{
> > +	damon_commit_filter(dst, src);
> > +	KUNIT_EXPECT_EQ(test, dst->type, src->type);
> > +	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
> > +	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
> > +	switch (src->type) {
> > +	case DAMOS_FILTER_TYPE_MEMCG:
> > +		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
> > +		break;
> 
> [Severity: Medium]
> Will this case label ever be matched?
> 
> This code checks against DAMOS_FILTER_TYPE_MEMCG, but damon_test_commit_filter()
> below initializes the source filter with type DAMON_FILTER_TYPE_MEMCG.
> 
> Because of this mismatch, the switch statement falls through to the default
> case, and the test silently skips the assertion for memcg_id.

Good catch, I will fix.

> 
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static void damon_test_commit_filter(struct kunit *test)
> > +{
> 
> [ ... ]
> 
> > +	damon_test_commit_filter_for(test, &dst,
> > +			&(struct damon_filter){
> > +			.type = DAMON_FILTER_TYPE_MEMCG,
> > +			.matching = false,
> > +			.allow = false,
> > +			.memcg_id = 123,
> > +			});
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729144738.90895-1-sj@kernel.org?part=1
> 


Thanks,
SJ
