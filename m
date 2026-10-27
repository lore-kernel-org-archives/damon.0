Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110736;
	b=QpplyPO9iSblcWKhKLv8xvX3KL8udw5swPee1RFfXUoKnk9sfTZVzKf3kZY++4arqm11
	 eaMl/C6qnA7On6dJkZ4EM1EcM6wGW8AC9v21R1EsJMVtnBZjQABCo8NxQLPBcaBjnKgs/
	 9WmW7nuVj73HYhnTStLmxsWgO3NOvsDDFLSTENI8R/0vuX5eQ65dFeuko6XTTkKEJuwO9
	 6LFBI2uXwmeNnqg3nF801aySti2cUZAO0sF5JEipd9PgoeSmpcXG0X/bU9ZSzgPEi6LDb
	 X0w4yP3w4zi93yw8ZTFSAqUD/m6IYGJGrpafz7iFtc3+kLb2lng9l1q9MdfaDWI5ozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110736;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=eiBXRvXB6ucqRXBbXNrVVoeakFgTM5grHuB2oFQ2RlI=;
	b=S1keqbh0eneOKEs2Lw0++8FGg77SSvkpQiicmpZNQXg0d89YulqSPIdXMz86rbZ9jekE
	 oQsF5hawB7aEk1sFhWsdd4sZGs4IeD5gFfnajXvZYIr3sIY2GsVInOnPi/Lul8zsa5CwP
	 Gux1wl5TvZlnjsl2F6JiHmu42mOPpPa8jnWfkKNAMF5sWFT7OiChq9tOJGElVuh5hKeDD
	 xalzkQNOdq/rcgi2w5KJDxyvSFA+vbnUvafX2ssARDmvFM031dJnKn869HVHCOLT9/TUn
	 jQzOjYW+7Pdb+wqVXBM8u5/5QROYMWw8l6TUsDG4WsKPHTgfflqAu7QVAzlvEn/uMWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei-partners.com;
	spf=pass smtp.mailfrom=huawei-partners.com;
	dkim=pass header.d=huawei-partners.com header.i=@huawei-partners.com header.a=rsa-sha256 header.s=dkim header.b=UuHxzaPU;
	arc=none smtp.remote-ip=14.137.139.54
Received: from framsgout02.his.huawei.com (framsgout02.his.huawei.com [14.137.139.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325D606A31A
	for <damon@lists.linux.dev>; Tue, 27 Oct 2026 14:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9325D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei-partners.com header.i=@huawei-partners.com header.a=rsa-sha256 header.s=dkim header.b=UuHxzaPU
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eiBXRvXB6ucqRXBbXNrVVoeakFgTM5grHuB2oFQ2RlI=;
	b=UuHxzaPUOaToqOid5Pph1aPtUauVJtUqA8tcq/3kNZlx+HqclP5EBgLW7B2WBheIsGRroHCJL
	/jMH4B0W3JDQLaLdctjcsEAuwrIhYHvxgrGhmbhu3FMDB/rmzUia4sDiGLbc46qjg5mYL1il8NT
	24poqMF9jC+WzXhhZAX/qF0=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by framsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jDXfY3hyTzLlSP;
	Tue, 27 Oct 2026 22:18:45 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id D9A3D40584;
	Tue, 27 Oct 2026 22:18:51 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 27 Oct 2026 17:18:51 +0300
Message-ID: <2b86ed0e-8ead-47ee-b9d9-b8ee36f845bb@huawei-partners.com>
Date: Tue, 27 Oct 2026 17:18:50 +0300
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] mm/damon/core: avoid overflows in monitoring
 results calculations
To: DaeMyung Kang <charsyam@gmail.com>, SJ Park <sj@kernel.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20261027135932.2301646-1-charsyam@gmail.com>
 <20261027135932.2301646-3-charsyam@gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20261027135932.2301646-3-charsyam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi DaeMyung,

Thanks for the patch.

On 10/27/2026 4:59 PM, DaeMyung Kang wrote:
> When monitoring intervals change, DAMON converts region ages and sample
> counts for the new intervals.  The conversions overflow before division:
> 
> - damon_age_for_new_attrs() multiplies the age by the old aggregation
>   interval in unsigned long.  On 32-bit kernels, the default 100 ms
>   interval makes this overflow after about 72 minutes.
> - The sample ratio conversions multiply unsigned int values.  They can
>   overflow on every architecture when an aggregation has more than
>   429,496 samples, such as a 1 ms sample interval and a 430 second
>   aggregation interval.
> 
> The moving sums also use mult_frac() for the fraction of an aggregation
> window that remains and for the previous window's contribution.  On
> 32-bit kernels, both can overflow with long aggregation intervals.  For
> example, 500,000 remaining samples of a 600,000-sample window are
> 8,333 bp, but the first calculation returns 1,175 bp.
> 
> Add damon_mult_frac(), which preserves mult_frac() results when its
> intermediates fit, calculates larger remainder products in full width,
> and saturates results that exceed unsigned long.  Use it for the
> conversions and the moving sums.  Saturate the unsigned int conversion
> results at UINT_MAX.
> 
> Add KUnit coverage for the helper, the conversions, and the moving sums.
> 
> The conversion issues were discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260708140944.F26821F000E9@smtp.kernel.org
> 
> Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
> Fixes: 9f3786d8602f ("mm/damon/core: introduce damon_nr_accesses_mvsum()")
> Fixes: 2ec26dd341d1 ("mm/damon/core: introduce damon_probe_hits_mvsum()")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
>  mm/damon/core.c             | 41 +++++++++++++++++---
>  mm/damon/tests/core-kunit.h | 74 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 73b571b429cb..5cd4007cc370 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -281,6 +281,32 @@ static bool damon_has_probe_weights(struct damon_ctx *c)
>  	return false;
>  }
>  
> +/*
> + * damon_mult_frac() - calculate @x * @n / @d without overflowing.
> + *
> + * Same as mult_frac(), but the intermediate product of the remainder does not
> + * overflow, and a result that does not fit in unsigned long is saturated to
> + * ULONG_MAX.  Returns the same value as mult_frac() when mult_frac() does not
> + * overflow.  @d must not be zero.
> + */
> +static unsigned long damon_mult_frac(unsigned long x, unsigned long n,
> +		unsigned long d)
> +{
> +	unsigned long q = x / d, r = x % d;
> +	unsigned long frac;
> +
> +	if (n && q > ULONG_MAX / n)
> +		return ULONG_MAX;
> +	if (!n || r <= ULONG_MAX / n)
> +		frac = r * n / d;
> +	else
> +		/* r < d, so the quotient is smaller than n */
> +		frac = mul_u64_u64_div_u64(r, n, d);
> +	if (frac > ULONG_MAX - q * n)
> +		return ULONG_MAX;
> +	return q * n + frac;
> +}
To me, this is too complex. We are introducing a bunch of branches,
which will run for all cases, 64 and 32 bit architectures. This adds
overhead to all users.

I don't think there are 32 bit architecture users who are running modern
linux versions with DAMON enabled. I may be wrong, of course.
> +
>  /*
>   * damon_mvsum() - Returns pseudo moving sum value for a time window.
>   * @current_nr:		The value of the current aggregation window.
> @@ -305,7 +331,7 @@ static bool damon_has_probe_weights(struct damon_ctx *c)
>  static unsigned long damon_mvsum(unsigned long current_nr,
>  		unsigned long last_nr, unsigned long left_window_bp)
>  {
> -	return current_nr + mult_frac(last_nr, left_window_bp, 10000);
> +	return current_nr + damon_mult_frac(last_nr, left_window_bp, 10000);
>  }
>  
>  /**
> @@ -337,7 +363,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
>  	else
>  		left_window = ctx->next_aggregation_sis -
>  			ctx->passed_sample_intervals;
> -	left_window_bp = mult_frac(left_window, 10000, window_len);
> +	left_window_bp = damon_mult_frac(left_window, 10000, window_len);
>  
>  	if (left_window_bp == 10000)
>  		return r->last_nr_accesses;
> @@ -361,7 +387,7 @@ unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
>  	else
>  		left_window = ctx->next_aggregation_sis -
>  			ctx->passed_sample_intervals;
> -	left_window_bp = mult_frac(left_window, 10000, window_len);
> +	left_window_bp = damon_mult_frac(left_window, 10000, window_len);
>  
>  	if (left_window_bp == 10000)
>  		return r->last_probe_hits[probe_idx];
> @@ -990,21 +1016,24 @@ static bool damon_attrs_equals(const struct damon_attrs *attrs1,
>  static unsigned int damon_age_for_new_attrs(unsigned int age,
>  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
>  {
> -	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
> +	return min(damon_mult_frac(age, old_attrs->aggr_interval,
> +				new_attrs->aggr_interval), UINT_MAX);
>  }
>  
>  /* convert sample ratio in bp (per 10,000) to count */
>  static unsigned int damon_sample_bp_to_count(
>  		unsigned int bp, struct damon_attrs *attrs)
>  {
> -	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> +	return min(damon_mult_frac(bp, damon_nr_samples_per_aggr(attrs),
> +				10000), UINT_MAX);
>  }
>  
>  /* convert sample count to ratio in bp (per 10,000) */
>  static unsigned int damon_sample_count_to_bp(
>  		unsigned int count, struct damon_attrs *attrs)
>  {
> -	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> +	return min(damon_mult_frac(count, 10000,
> +				damon_nr_samples_per_aggr(attrs)), UINT_MAX);
>  }
>  
>  static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 43e2f950f8ff..e71e60d59400 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -698,6 +698,64 @@ static void damon_test_update_monitoring_result(struct kunit *test)
>  	damon_destroy_ctx(ctx);
>  }
>  
> +static void damon_test_mult_frac(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(7, 3, 2), 10ul);
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX, 0, 1), 0ul);
> +	/* the remainder product overflows on 32-bit */
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(524288, 10000, 786432), 6666ul);
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(500000, 10000, 1000000), 5000ul);
> +	/* the remainder product overflows even on 64-bit */
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX - 1, ULONG_MAX,
> +				ULONG_MAX), ULONG_MAX - 1);
> +	/* the quotient product overflows */
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX, 10000, 1), ULONG_MAX);
> +	/* the largest representable result, and one beyond it */
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX - ULONG_MAX / 10000,
> +				10000, 9999), ULONG_MAX);
> +	KUNIT_EXPECT_EQ(test, damon_mult_frac(ULONG_MAX - ULONG_MAX / 10000 + 1,
> +				10000, 9999), ULONG_MAX);
> +}
> +
> +static void damon_test_age_for_new_attrs_large_value(struct kunit *test)
> +{
> +	struct damon_attrs old_attrs = {.aggr_interval = 100000};
> +	struct damon_attrs new_attrs = {.aggr_interval = 50000};
> +	unsigned int age;
> +
> +	age = damon_age_for_new_attrs(50000, &old_attrs, &new_attrs);
> +	KUNIT_EXPECT_EQ(test, age, 100000u);
> +
> +	new_attrs.aggr_interval = 1;
> +	age = damon_age_for_new_attrs(UINT_MAX, &old_attrs, &new_attrs);
> +	KUNIT_EXPECT_EQ(test, age, UINT_MAX);
> +
> +	old_attrs.aggr_interval = ULONG_MAX;
> +	age = damon_age_for_new_attrs(UINT_MAX, &old_attrs, &new_attrs);
> +	KUNIT_EXPECT_EQ(test, age, UINT_MAX);
> +}
> +
> +static void damon_test_sample_ratio_large_value(struct kunit *test)
> +{
> +	struct damon_attrs attrs = {
> +		.sample_interval = 1000,
> +		.aggr_interval = 600000000,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, damon_sample_bp_to_count(10000, &attrs),
> +			600000u);
> +	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(600000, &attrs),
> +			10000u);
> +	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(500000, &attrs),
> +			8333u);
> +	KUNIT_EXPECT_EQ(test, damon_sample_bp_to_count(UINT_MAX, &attrs),
> +			UINT_MAX);
> +
> +	attrs.aggr_interval = attrs.sample_interval;
> +	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(UINT_MAX, &attrs),
> +			UINT_MAX);
> +}
> +
>  static void damon_test_set_attrs(struct kunit *test)
>  {
>  	struct damon_ctx *c = damon_new_ctx();
> @@ -735,6 +793,7 @@ static void damon_test_mvsum(struct kunit *test)
>  		3, 10, 5000, 8,		/* 3 + 10 * 0.5 */
>  		32, 100, 1000, 42,	/* 32 + 100 * 0.1 */
>  		42, 49, 0, 42,		/* 42 + 49 * 0 */
> +		0, 600000, 8333, 499980, /* 32-bit remainder product overflow */
>  	};
>  
>  	int i;
> @@ -794,6 +853,18 @@ static void damon_test_nr_accesses_mvsum(struct kunit *test)
>  				damon_nr_accesses_mvsum(r, c));
>  	}
>  
> +	c->attrs.sample_interval = 1000;
> +	c->attrs.aggr_interval = 600000000;
> +	c->passed_sample_intervals = 100000;
> +	c->next_aggregation_sis = 600000;
> +	r->nr_accesses = 100000;
> +	r->last_nr_accesses = 600000;
> +	KUNIT_EXPECT_EQ(test, damon_nr_accesses_mvsum(r, c), 599980u);
> +
> +	r->probe_hits[0] = 0;
> +	r->last_probe_hits[0] = 100;
> +	KUNIT_EXPECT_EQ(test, damon_probe_hits_mvsum(0, r, c), 83);
> +
>  	damon_free_region(r);
>  	damon_destroy_ctx(c);
>  }
> @@ -2494,6 +2565,9 @@ static struct kunit_case damon_test_cases[] = {
>  	KUNIT_CASE(damon_test_set_regions),
>  	KUNIT_CASE(damon_test_nr_samples_per_aggr),
>  	KUNIT_CASE(damon_test_update_monitoring_result),
> +	KUNIT_CASE(damon_test_mult_frac),
> +	KUNIT_CASE(damon_test_age_for_new_attrs_large_value),
> +	KUNIT_CASE(damon_test_sample_ratio_large_value),
>  	KUNIT_CASE(damon_test_set_attrs),
>  	KUNIT_CASE(damon_test_mvsum),
>  	KUNIT_CASE(damon_test_nr_accesses_mvsum),
Thanks
-- 
Asier Gutierrez
Huawei

