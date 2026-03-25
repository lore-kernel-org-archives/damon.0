Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBF244660;
	Wed, 25 Mar 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450489; cv=none; b=hmUtr1qJo428BhMKzK6s1aNJJDc1f1JzH33sHs3cegMUno6h9zuFgq6H8l/4cAnZ2t/uVZ/pGFeTHFZPlpG1H7zvPhFlOIl9G30OQrNXoCZZviZh0P2XEgZUko3t9GFl7Id9JkT5Bmv7/zR51URgizrVV0exXdk1++AlAXw2WdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450489; c=relaxed/simple;
	bh=lrf0z5bvG1v0mlYr6634sLmsiqfSBpG+1b5Vled0Cqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvT9fCS4ii0O12OpehnEYdlWmkdqoeZSyStl66+p3aEbBCcsQYSBgJJbhG0+A382KPESUdt5kTIfHTk2AoZ7PTw/bQ6DrEmmDQtqaSNFOVTmYBghBJOHRhItxycl866yxsKKoi6yX9gGWWZx5Oyv7HD5UK8sKEFNMg8Gm+ez2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoRIgOhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoRIgOhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65F5C4CEF7;
	Wed, 25 Mar 2026 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450488;
	bh=lrf0z5bvG1v0mlYr6634sLmsiqfSBpG+1b5Vled0Cqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UoRIgOhnJFqGaS7j+ghb1dkb5nBHqB93nT2V1uvZ6BzWeKCMa3bUReXKdSdN5OEzj
	 AQ2dIYCQ33Vl1zhAqMRd7T+hMgpSGyJt0s9V/K9EnpW7CA7ALUnLMtZdL1ga8jVKvQ
	 PE/GaWQooBNL6ppUWDIWCUckuGlJ76nT1ZbPg6hV8h8amymC9bCQPJWpKjlt9iQT+y
	 S6BHOQRZ6Lh9riaV6w3hPFP11w44m9iM9Us//MbdcZToaNAILGx9rDNkm+CD6KhzRn
	 zMW9yeGZlpxKptas8zxOfu96Y4GEPvl70muQ0Npx3kgaYacRpTbNI4cRTI0MmC64vz
	 CoKBcIGlUnIug==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Wed, 25 Mar 2026 07:54:46 -0700
Message-ID: <20260325145447.87994-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324154005.83651-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 15:40:05 +0000 Josh Law <objecting@objecting.org> wrote:

> Hardware integer division is slow. The function damon_max_nr_accesses(),
> which is called very frequently, performs an integer division.
> However, the struct damon_attrs already caches this exact ratio in the
> internal field aggr_samples. We can eliminate the hardware division in
> the hot path by simply returning aggr_samples.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  include/linux/damon.h       |  3 +--
>  mm/damon/core.c             |  1 +
>  mm/damon/tests/core-kunit.h | 16 ++++++++++++----
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6bd71546f7b2..438fe6f3eab4 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
>  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
>  {
>  	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> -	return min(attrs->aggr_interval / attrs->sample_interval,
> -			(unsigned long)UINT_MAX);
> +	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
>  }
>  
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b0ab0ee6eab9..59b709f04975 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -582,6 +582,7 @@ struct damon_ctx *damon_new_ctx(void)
>  	ctx->attrs.sample_interval = 5 * 1000;
>  	ctx->attrs.aggr_interval = 100 * 1000;
>  	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
> +	ctx->attrs.aggr_samples = 20;
>  
>  	ctx->passed_sample_intervals = 0;
>  	/* These will be set from kdamond_init_ctx() */
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index e86d4f4fe261..56d03ef6a5a4 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -416,6 +416,8 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
>  		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
>  	};
>  
> +	attrs.aggr_samples = attrs.aggr_interval / attrs.sample_interval;
> +
>  	/*
>  	 * In some cases such as 32bit architectures where UINT_MAX is
>  	 * ULONG_MAX, attrs.aggr_interval becomes zero.  Calling
> @@ -434,7 +436,8 @@ static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
>  static void damon_test_update_monitoring_result(struct kunit *test)
>  {
>  	struct damon_attrs old_attrs = {
> -		.sample_interval = 10, .aggr_interval = 1000,};
> +		.sample_interval = 10, .aggr_interval = 1000,
> +		.aggr_samples = 100,};
>  	struct damon_attrs new_attrs;
>  	struct damon_region *r = damon_new_region(3, 7);
>  
> @@ -446,19 +449,24 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>  	r->age = 20;
>  
>  	new_attrs = (struct damon_attrs){
> -		.sample_interval = 100, .aggr_interval = 10000,};
> +		.sample_interval = 100, .aggr_interval = 10000,
> +		.aggr_samples = 100,};
>  	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
>  	KUNIT_EXPECT_EQ(test, r->age, 2);
>  
>  	new_attrs = (struct damon_attrs){
> -		.sample_interval = 1, .aggr_interval = 1000};
> +		.sample_interval = 1, .aggr_interval = 1000,
> +		.aggr_samples = 1000,
> +	};
>  	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
>  	KUNIT_EXPECT_EQ(test, r->age, 2);
>  
>  	new_attrs = (struct damon_attrs){
> -		.sample_interval = 1, .aggr_interval = 100};
> +		.sample_interval = 1, .aggr_interval = 100,
> +		.aggr_samples = 100,
> +	};
>  	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
>  	KUNIT_EXPECT_EQ(test, r->age, 20);
> -- 
> 2.34.1

I think this amount of change is somewhat too much maintenance burden for the
simple optimization.  Apparently aggr_samples was not designed for this use
case.  I think another way should be used, but failing at finding a good
alternative.  And I'm not very sure damon_max_nr_accesses() deserves that much
time to optimize.

So, if you find a better way for optimizing damon_max_nr_accesses()
without adding maintenance burden or evidence of benefit that justifies this
amount of maintenance burden, please feel free to repost a new version.  But,
in my humble and frank opinion, I don't see that much worth in the
optimization.


Thanks,
SJ

[...]
