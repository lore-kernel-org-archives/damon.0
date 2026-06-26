Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C8D2D5C7A;
	Fri, 26 Jun 2026 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485668; cv=none; b=FIheTSkxSYq3AiUK1eKT7TqC/mTc1N7EFEfqDBHHY3xtYMnLXOwEzK7oDy/HLmCSl13dtl+pL0zmiEcTENCJ31irPfP8YKeOo38Ixsz1nXXO6rC8Xe/M1ocqkUPtt2iFbPS9aX1/5qQiTe8RWIWCEIcZxhX45hQjIIJTowFq4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485668; c=relaxed/simple;
	bh=464CQPWa6XmK9NV9BudFQWJCSlDgmCQxHF/JFxK4zXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOSu1EywUjytUd2HXkhMTJVeu8qTU6VB+//LlqLMDpymB7yB3JLW3EtRF2mLLkMi50WM38bYTog3G/tX6WUvXgN7sR5/x2CO78ohrUEwnvVCZJL/VNlas7SYrqzuVjSwTaI1PQOfyShVZssvDGn8bseJkZCDmujAovbAxuGge7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMBjWOBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMBjWOBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD931F000E9;
	Fri, 26 Jun 2026 14:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485667;
	bh=Ys5iUrX/oJGm/Bdw8OQUFFBkeX74LvSEyWlQGwdHoSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMBjWOBKBYrAViDw7U24Nn69r5pzYFtMK1napV2Ak+nBGK1BX/RQEwmNyfnz22oaZ
	 Vc49WPQBUvLHhIH6Fxo/fbdg66jyKx+kPxL0KylrdHUffFZkUOKExhgU8+yhKDWFVS
	 nUF8Ryb1ou1FLRRJifZhgH4wRK526G/8tuHdpYmT/7lCsAyl/OaNjxeTeAPrXXS9tM
	 SpfSECV0tL1+2mSXDE5wZOgIh+92pAOoGiPd14du7JygBaWMg4jlpV03+bvrbRPtd6
	 HMPSkbg+EMuL2hFsiFcerLoI/aQjs2dPOTmbHxw3FohkO7FOWsQm8Z6841otMY7Xsl
	 dvwmEazQxNXuQ==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	jiayuan.chen@shopee.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/tests/core-kunit: test split above max_nr_regions/2
Date: Fri, 26 Jun 2026 07:54:14 -0700
Message-ID: <20260626145415.88225-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626085851.70754-3-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jun 2026 16:58:38 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Add a test that exercises kdamond_split_regions() when the total
> region count is already above max_nr_regions / 2, asserting that the
> function still splits a fraction of the regions (makes progress) and
> does not overshoot max_nr_regions.
> 
> The region size and min_region_sz are picked so the split arithmetic
> does not depend on the page size.
> 
> All tests pass:
>   damon: pass:31 fail:0 skip:0 total:31
>   Totals: pass:31 fail:0 skip:0 total:31

Nice!

> 
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

I have trivial comments below, though.

> ---
>  mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 29fbe495e532..6fe7abcd670d 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -341,6 +341,69 @@ static void damon_test_split_regions_of(struct kunit *test)
>  	damon_destroy_ctx(c);
>  }
>  
> +/*
> + * When the total region count is already above max_nr_regions / 2,
> + * kdamond_split_regions() must keep refining the resolution by splitting a
> + * fraction of the regions (making progress), without exceeding
> + * max_nr_regions.
> + */
> +static void damon_test_split_above_half_progresses(struct kunit *test)
> +{
> +	struct damon_ctx *c;
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	unsigned long start;
> +	unsigned int nr_before, nr_after, i;
> +	const unsigned int nr_init = 760;
> +	const unsigned long region_sz = 100;
> +
> +	c = damon_new_ctx();
> +	if (!c)
> +		kunit_skip(test, "ctx alloc fail");
> +
> +	/* Keep the split arithmetic independent of the page size */
> +	c->min_region_sz = 1;
> +	c->attrs.min_nr_regions = 10;
> +	c->attrs.max_nr_regions = 1500;
> +
> +	t = damon_new_target();
> +	if (!t) {
> +		damon_destroy_ctx(c);
> +		kunit_skip(test, "target alloc fail");
> +	}
> +
> +	for (i = 0; i < nr_init; i++) {
> +		start = i * region_sz;
> +		r = damon_new_region(start, start + region_sz);
> +		if (!r) {
> +			damon_free_target(t);
> +			damon_destroy_ctx(c);
> +			kunit_skip(test, "region alloc fail");
> +		}
> +		r->nr_accesses = (i & 1) ? 0 : 100;
> +		r->age = 5;
> +		damon_add_region(r, t);
> +	}
> +
> +	damon_add_target(c, t);
> +
> +	nr_before = damon_nr_regions(t);
> +	/* Above max_nr_regions / 2, so the blanket-split path is skipped */
> +	KUNIT_EXPECT_GT(test, (unsigned long)nr_before,
> +			c->attrs.max_nr_regions / 2);

Above KUNIT_EXPECT_GT() feels unnecessary.

> +
> +	kdamond_split_regions(c);
> +
> +	nr_after = damon_nr_regions(t);
> +	/* Still made progress ... */
> +	KUNIT_EXPECT_GT(test, nr_after, nr_before);
> +	/* ... but did not overshoot the configured maximum */
> +	KUNIT_EXPECT_LE(test, (unsigned long)nr_after,
> +			c->attrs.max_nr_regions);

In future, we may do this multiple times.

> +
> +	damon_destroy_ctx(c);
> +}
> +


Thanks,
SJ

[...]
