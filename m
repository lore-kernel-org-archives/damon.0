Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622811;
	b=0Z2PRrXtHuvJkJhO6IKxhVAuhwDiY3O8VFp/n0RsX42CsB/tuDp33Ym5k82y9J1W9CJU
	 kcR6lUSrIoppLeh/i0qTMWl7fkU5abc74fFypLhmT6AVG2W//hMfe7uwU7hv83s2oh/af
	 y4Y1elwiRb/rnppifBDUvIWoY7cfQhwmlTPScx7DWZZ1JKAXWzKgZNMBQdgfbMhB9tYGz
	 rCNRBY7Qu2Py/wAeO9iHY99ZZtzL1XvKwheR02ks+6nvwCOEwmyHKifgn6b0HhU+7Jr1I
	 VQaJrotUj+NAV3WL+pCelpx//f/wDt66k8VZZYMO7rZsx/90WamsY36p1jsrdU4UKww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622811;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6bGsd12+MFPupXLn2HJlax53WlKnxsLm64VvDIFikGQ=;
	b=1xDdesv56Q/9WdRd6XVJ/6kPkzTid58dLuc2V4nVxWbGXOdkJ2MwpX2GYXku2zMtnT8h
	 oE8fP3t3H4OWL0H8OgVuvayibeLZSZkjAzM20rfn1EmtxBBXEwKpw5Y+miDdKGLhM1PYy
	 kvP/ic/dBf+LBk1lKUPmJr47OPbNpORhbQIs1dRwp4xN/Gf+2gDGY015rqSSWggOg2Bri
	 v85UMviOeHuwNTAHsj1veQIVAEPCGurMvShL7LeZ2P6AGIEWbnTndV7AZ5bNPm5Cf2qSv
	 ZtD674GuExzvkblOb2ryejsTJ+D53AhHJ5XXnqkvUjUr6rmxW372+1mbvBXJdrdGRqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJOENWwj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF9606A329;
	Sat, 14 Nov 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJOENWwj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C451F000C4;
	Sat, 14 Nov 2026 02:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622811;
	bh=6bGsd12+MFPupXLn2HJlax53WlKnxsLm64VvDIFikGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJOENWwjAMpzrTNkqG3+m3Ig8inmXTzAD5uRAYyUl+LECaWsrGECMtNxx/luhMuFL
	 m6IQtIL6qAO0wcEGSJhzoQN0cepbKlJcIWI0subP/xHH7WK4mAF915pvAq1YsPv7hk
	 x5yERpWNMAu3akcd8VEiI8W4KkTPuAtJt1MeB+if3nv7d8exY/SC+dreyZVc4NE5hj
	 4wEm38D8XbkFC9gHpx3fF0hok1BW4qnTpYxJpdFqdKQbQq9+4qlXy/e7Be0LoExMIG
	 Is6mE382MiI6oIX1Sj+OfbiMcL6Irc4SswevnLCYw7zUpJ+RK/Bo5K6cdPcw1muliY
	 6y/X4zzp8MQYg==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/damon/tests/core-kunit: test DAMOS_FILTER_TYPE_AGE_MS interval changes
Date: Fri, 13 Nov 2026 18:20:03 -0800
Message-ID: <20261114022004.110044-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113-test-age-ms-filter-v1-3-b99eab2f71bb@ucla.edu>
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

On Fri, 13 Nov 2026 07:58:57 -0800 Jason Angelov <jasonangelov@ucla.edu> wrote:

> DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
> milliseconds to filter for target regions.
> Aggregation interval can be changed by users or intervals
> auto-tuning features.

Let's put the second sentence in the line of the end of the first sentence.  In
the way, we can save one line.

> 
> Add a kunit test for each:
> 
> - convert region age to milliseconds, correct behavior at boundaries
> for defined filter range

Let's add two spaces indentation, to make the bullet point lists easier to
read.

> - DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
> aggregation interval changes

Ditto.

> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
> ---
>  mm/damon/tests/core-kunit.h | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index fb84d30a712d..6de7c2531702 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -1837,6 +1837,86 @@ static void damos_test_age_ms_filter_is_core(struct kunit *test)
>  	KUNIT_EXPECT_FALSE(test, damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
>  }
>  
> +static void damos_test_age_ms_filter_interval_changes(struct kunit *test)
> +{
> +	/* Filter window: 200-400 ms.  Start: 100 ms interval, age 0. */

This looks like not a complete sentence for readers but a personal note.
Please make the comment more human-readable or just drop.

> +	struct damos_filter filter = {
> +		.type = DAMOS_FILTER_TYPE_AGE_MS,
> +		.matching = true,
> +		.range_min = 200,
> +		.range_max = 400,
> +	};
> +	struct damon_attrs attrs = {
> +		.sample_interval = 5000,
> +		.aggr_interval = 100000,
> +		.min_nr_regions = 3,
> +		.max_nr_regions = 3,
> +	};
> +	struct damon_ctx *ctx;
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	int err;
> +
> +	ctx = damon_new_ctx();
> +	if (!ctx)
> +		kunit_skip(test, "ctx alloc fail");
> +	t = damon_new_target();
> +	if (!t) {
> +		damon_destroy_ctx(ctx);
> +		kunit_skip(test, "target alloc fail");
> +	}
> +	damon_add_target(ctx, t);
> +	r = damon_new_region(0, DAMON_MIN_REGION_SZ);
> +	if (!r) {
> +		damon_destroy_ctx(ctx);
> +		kunit_skip(test, "region alloc fail");
> +	}
> +	damon_add_region(r, t);
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(ctx, &attrs), 0);

Why test damon_set_attrs() in this test?

> +
> +	/* below window: age 1 = 100 ms */

What the "window" means?  Filter's range_{min,max}?  This again feels like a
personal note rather than somewhat useful for other code readers.  Please make
the comment more human readable or just drop.

> +	r->age = 1;
> +	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
> +			ctx->min_region_sz, &err));
> +
> +	/* inside window: age 2 = 200 ms */

Ditto.  Same for all comments in this function.

> +	r->age = 2;
> +	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
> +			ctx->min_region_sz, &err));
> +
> +	/*
> +	 * change aggregation interval 100 -> 200 ms:
> +	 * inside window: age rescaled 2 -> 1, still 200 ms
> +	 */
> +	attrs.aggr_interval = 200000;
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(ctx, &attrs), 0);

Why test damon_set_attrs() in this test?

> +	KUNIT_EXPECT_EQ(test, r->age, 1u);
> +	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
> +			ctx->min_region_sz, &err));
> +
> +	/* inside window: age 2 = 400 ms. */
> +	r->age = 2;
> +	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
> +			ctx->min_region_sz, &err));
> +
> +	/*
> +	 * change aggregation interval 200 -> 50 ms:
> +	 * inside window: age rescaled 2 -> 8, still 400 ms.
> +	 */
> +	attrs.aggr_interval = 50000;
> +	KUNIT_EXPECT_EQ(test, damon_set_attrs(ctx, &attrs), 0);
> +	KUNIT_EXPECT_EQ(test, r->age, 8u);
> +	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
> +			ctx->min_region_sz, &err));
> +
> +	/* above window: age 9 = 450 ms. */
> +	r->age = 9;
> +	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
> +			ctx->min_region_sz, &err));
> +
> +	damon_destroy_ctx(ctx);
> +}
> +
>  static void damos_test_filter_out(struct kunit *test)
>  {
>  	struct damon_target *t;
> @@ -2599,6 +2679,7 @@ static struct kunit_case damon_test_cases[] = {
>  	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
>  	KUNIT_CASE(damon_test_valid_probe_params),
>  	KUNIT_CASE(damos_test_age_ms_filter_is_core),
> +	KUNIT_CASE(damos_test_age_ms_filter_interval_changes),
>  	KUNIT_CASE(damos_test_filter_out),
>  	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
>  	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),
> 
> -- 
> 2.53.0
> 
> 


Thanks,
SJ
