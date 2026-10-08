Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14546492E37
	for <damon@lists.linux.dev>; Thu,  8 Oct 2026 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456301; cv=none; b=dBKAI/M9vCAdoE2bOufVMeeie1jwTLezFQ7wYORUkPGbFDGwBWXwNGc7869APH0Mc5lyPN/Pp++aFnFFd4cP5GfLwPj5HDZsRidi3qWnVj0v3+E4gJUwnG7ASFBWq9XHzFOfy90/Ci1H0sO93+GvDaT53K9NXNq+A6LJ1BEE3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456301; c=relaxed/simple;
	bh=maDdtaErG0HEiphcfEJYV2BkFrxfFYOvxUhDvySilEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLJTD3a4hjc+qY+Dh2CtvQs6LOHHTWOxHpnhf3xi8mW42Y6wCmlZ+HECEVYqbo4ghw6sjyhvveDuVGn8rXPQq9VjfDdszUk33YUUfy6P0ceC9YtW4O/edUjxVwEcj9o7mxySZuy3o8TeU1o+VmGQTYDbnzYj+0bSHtr+RoIyYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlvF7lOd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlvF7lOd"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ccd0887c542so1290616a12.1
        for <damon@lists.linux.dev>; Thu, 08 Oct 2026 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456298; x=1792061098; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dH+v/ufGOq7i0ts93hi9MHjSRomJDT2cVjr72NMJIW0=;
        b=PlvF7lOdcxgmMaM9uX2IKDo3Ep158PBQoR7QfQDI7cdo4rd1/Gc0IimyCylK+CHxZL
         aRJ2mFAKkFYuhXrrkOMacy94K4Sokh6cbh/pINLsY6JUh/eZ1ZO8fKBgPn60seS6D0Ae
         Tk+pCg/ZrxR1D6IWoC7LUhTVtiCPdiOg8PTfs1ixPDI0Jl/2z9ypecDgx7XiWl14Xj/c
         VHg+WEc0rhblrrp0upsva3E7mJBJfmlgLVURU+48xB2bI4yHJUM6AQitMxZMP9UU5AgX
         ePqgi25lVUzOpXO28/k8WgIe87zy+j1YDKBWdN7vwqYFiU1gPC46cgk5zB2aVuMCeflz
         eENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456298; x=1792061098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dH+v/ufGOq7i0ts93hi9MHjSRomJDT2cVjr72NMJIW0=;
        b=dZ+cu9AHQgA4bv7aytQvqTNkX1RQ9f5eZHFubOsk4Pi+/4UF1kvGOC6JtipU516JKU
         P1OrGcjlWOmIFyak11KCYAHBhwL215F3Grks225us2r7p5icdFay2lt/PQqC+XuIwu+6
         8bE+KuLWkZkYYyY2UQcMFBa6qHpi2p5QQqN8fmWiIUVnNYDDfJyP+zw+g0ytVzdd65Wc
         Z5bmhENLl1lChxifEvggVm14gBNo/u7z+zfX9VVUwUMSpozOIzsxfd54FtSHw9zN8BEc
         zzLUK/0nSlo8OEMnCEq+g/bjqCDlSK/lOivK4EyJTxKhCGdXKscqYqJDKW+FNfqRNF2w
         MWbg==
X-Forwarded-Encrypted: i=1; AKwUvBxFjlCr40wqJW807dr6kjxKwZc7ED2LKT3VrB6E/kXkASpS8DWwoq97Xa7R+ok/4PVdETL7jw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK2WepRTD9Po+CAlS/+BUmFsg12p702/t/m1JdKD+MIH5BNruH0
	6eUqO1pXuEtiFsiNvxsIIVO4+z45flAnFWnq3+bZauS+OX4wjULYEbJl
X-Gm-Gg: AYBFou2KaT7F4uCckaat/DnZop61/4VKVtqrfQ1V/XzBpiFFFPui8X0CJxZnJq2XUCz
	k7t+RyiXwOAe0lkg1Cit9HOtT2LwG5lxrYFwxOIby7CATtYdRteqvhUkd2F+DhdaU+j4HaC/+3B
	NLHPZ8YK2D1zYS6X7WguTkBQMEaGOlU4w4FuvLSOyu57DVBLBLllTqIlmPYkk3rJdMW2xttwCZq
	T14IsAyhT+y3kRYil76vkU84/zor6TjPOousQzbE68lsFljUMUh2iKD7QVKGscN1AwxUDiUuZFA
	mLUILXVmbfsQwUKqwvg4jklAey4BGJaHZHWyTPIExJyfaE1hg7bZbdtIisK2uvSa1eEudMXyi5m
	lx6Or+W50DDyJYXx4UvPgiVNzHkUpFPlTWxrowdtcYozxSMwiGtQ0WFtN8h3J8sFzGA23QLSoj0
	MX4crPtKVFLo1uPgb7sF/KHubYhUEgCV6dziPPXBb7f1pb2aegdHxfV2/qB1tVhwVNrMqnBskvc
	J66y0HY779aQ/E92pE0bCzOTA==
X-Received: by 2002:a17:90b:4fc5:b0:3a6:dc2f:f07f with SMTP id 98e67ed59e1d1-3a8a1982a7fmr4554157a91.10.1791456298338;
        Thu, 08 Oct 2026 03:44:58 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2001:d08:1334:29ed:db11:2c4c:ee4f:606])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9ff848f9csm3616656a91.9.2026.10.08.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:44:57 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: suhaas@s-joshi.in
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	SJ Park <sj@kernel.org>,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Thu,  8 Oct 2026 18:44:45 +0800
Message-ID: <20261008104511.5290-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007154851.45368-3-suhaas@s-joshi.in>
References: <20261007154851.45368-3-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 07 Oct 2026 21:18:46 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in which
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
> 
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().
> 
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
> ---
>  mm/damon/core.c             | 42 +++++++++++++++++---------------
>  mm/damon/tests/core-kunit.h | 48 ++++++++++++++++++++++++++++++-------
>  2 files changed, 63 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a3af5ee685e1..025df4d19e20 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2049,8 +2049,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
>  	return sz;
>  }
>  
> -static int damon_split_region_at(struct damon_target *t,
> -				  struct damon_region *r, unsigned long sz_r);
> +static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
> +				 struct damon_region *r, unsigned long sz_r);
>  
>  /*
>   * damon_apply_min_nr_regions() - Make effect of min_nr_regions parameter.
> @@ -2075,7 +2075,7 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
>  	damon_for_each_target(t, ctx) {
>  		damon_for_each_region_safe(r, next, t) {
>  			while (damon_sz_region(r) > max_region_sz) {
> -				if (damon_split_region_at(t, r, max_region_sz))
> +				if (damon_split_region_at(ctx, t, r, max_region_sz))
>  					goto out;
>  				r = damon_next_region(r);
>  			}
> @@ -2494,9 +2494,9 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
>   *
>   * Return: true if the region should be skipped, false otherwise.
>   */
> -static bool damos_skip_charged_region(struct damon_target *t,
> -		struct damon_region *r, struct damos *s,
> -		unsigned long min_region_sz)
> +static bool damos_skip_charged_region(struct damon_ctx *ctx, struct damon_target *t,
> +				      struct damon_region *r, struct damos *s,
> +				      unsigned long min_region_sz)
>  {
>  	struct damos_quota *quota = &s->quota;
>  	unsigned long sz_to_skip;
> @@ -2523,7 +2523,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  				}
>  				sz_to_skip = min_region_sz;
>  			}
> -			damon_split_region_at(t, r, sz_to_skip);
> +			damon_split_region_at(ctx, t, r, sz_to_skip);
>  			skip = true;
>  		}
>  	}
> @@ -2581,12 +2581,12 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
>  		}
>  		/* start before the range and overlap */
>  		if (r->ar.start < start) {
> -			damon_split_region_at(t, r, start - r->ar.start);
> +			damon_split_region_at(ctx, t, r, start - r->ar.start);
>  			matched = false;
>  			break;
>  		}
>  		/* start inside the range */
> -		damon_split_region_at(t, r, end - r->ar.start);
> +		damon_split_region_at(ctx, t, r, end - r->ar.start);
>  		matched = true;
>  		break;
>  	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> @@ -2779,7 +2779,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  					c->min_region_sz);
>  			if (!sz)
>  				goto update_stat;
> -			if (damon_split_region_at(t, r, sz))
> +			if (damon_split_region_at(c, t, r, sz))
>  				goto update_stat;
>  		}
>  		if (damos_core_filter_out(c, t, r, s))
> @@ -2826,7 +2826,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
>  		if (damos_quota_is_full(quota, c->min_region_sz))
>  			continue;
>  
> -		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
> +		if (damos_skip_charged_region(c, t, r, s, c->min_region_sz))
>  			continue;
>  
>  		if (s->max_nr_snapshots &&
> @@ -3643,10 +3643,12 @@ static void damon_verify_split_region_at(struct damon_region *r,
>   *
>   * Return: 0 on success, negative error code otherwise.
>   */
> -static int damon_split_region_at(struct damon_target *t,
> -				  struct damon_region *r, unsigned long sz_r)
> +static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
> +				 struct damon_region *r, unsigned long sz_r)
>  {
>  	struct damon_region *new;
> +	struct damon_probe *p;
> +	int i;
>  
>  	damon_verify_split_region_at(r, sz_r);
>  	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
> @@ -3658,11 +3660,13 @@ static int damon_split_region_at(struct damon_target *t,
>  	new->age = r->age;
>  	new->last_nr_accesses = r->last_nr_accesses;
>  	new->nr_accesses = r->nr_accesses;
> -	/* todo: do this for only installed probes */
> -	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
> -	memcpy(new->last_probe_hits, r->last_probe_hits,
> -			sizeof(r->last_probe_hits));
>  
> +	i = 0;
> +	damon_for_each_probe(p, ctx) {
> +		new->probe_hits[i] = r->probe_hits[i];
> +		new->last_probe_hits[i] = r->last_probe_hits[i];
> +		++i;
> +	}
>  	damon_insert_region(new, r, damon_next_region(r), t);
>  	return 0;
>  }
> @@ -3691,7 +3695,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
>  			if (sz_sub == 0 || sz_sub >= sz_region)
>  				continue;
>  
> -			damon_split_region_at(t, r, sz_sub);
> +			damon_split_region_at(ctx, t, r, sz_sub);
>  			sz_region = sz_sub;
>  		}
>  	}
> @@ -3723,7 +3727,7 @@ static void damon_split_some_regions(struct damon_ctx *ctx,
>  			if (sz_sub == 0 || sz_sub >= sz_region)
>  				continue;
>  
> -			damon_split_region_at(t, r, sz_sub);
> +			damon_split_region_at(ctx, t, r, sz_sub);
>  		}
>  	}
>  }
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 5ad89c1d9fc2..e02604c7e0bc 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -141,12 +141,26 @@ static void damon_test_split_at(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r, *r_new;
> +	struct damon_ctx *ctx;
> +	struct damon_probe *p;
>  
> +	p = damon_new_probe();
> +	if (!p)
> +		kunit_skip(test, "probe alloc fail");
> +	ctx = damon_new_ctx();
> +	if (!ctx) {
> +		damon_destroy_probe(p);
> +		kunit_skip(test, "context alloc fail");
> +	}
> +	damon_add_probe(ctx, p);
>  	t = damon_new_target();
> -	if (!t)
> +	if (!t) {
> +		damon_destroy_ctx(ctx);
>  		kunit_skip(test, "target alloc fail");
> +	}
>  	r = damon_new_region(0, 100);
>  	if (!r) {
> +		damon_destroy_ctx(ctx);
>  		damon_free_target(t);
>  		kunit_skip(test, "region alloc fail");
>  	}
> @@ -156,7 +170,7 @@ static void damon_test_split_at(struct kunit *test)
>  	r->last_probe_hits[0] = 3;
>  	r->age = 10;
>  	damon_add_region(r, t);
> -	damon_split_region_at(t, r, 25);
> +	damon_split_region_at(ctx, t, r, 25);
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
>  	if (damon_nr_regions(t) != 2)
>  		goto out;
> @@ -176,6 +190,7 @@ static void damon_test_split_at(struct kunit *test)
>  
>  out:
>  	damon_free_target(t);
> +	damon_destroy_ctx(ctx);
>  }
>  
>  static void damon_test_merge_two(struct kunit *test)
> @@ -1648,19 +1663,35 @@ static void damos_test_filter_out(struct kunit *test)
>  	struct damon_target *t;
>  	struct damon_region *r, *r2;
>  	struct damos_filter *f;
> +	struct damon_ctx *ctx;
> +	struct damon_probe *p;
> +
> +	p = damon_new_probe();
> +	if (!p)
> +		kunit_skip(test, "probe alloc fail");
> +	ctx = damon_new_ctx();
> +	if (!ctx) {
> +		damon_destroy_probe(p);
> +		kunit_skip(test, "context alloc fail");
> +	}
> +	damon_add_probe(ctx, p);
>  
>  	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
> -	if (!f)
> +	if (!f) {
> +		damon_destroy_ctx(ctx);
>  		kunit_skip(test, "filter alloc fail");
> +	}
>  	f->addr_range = (struct damon_addr_range){.start = 2, .end = 6};
>  
>  	t = damon_new_target();
>  	if (!t) {
> +		damon_destroy_ctx(ctx);
>  		damos_destroy_filter(f);
>  		kunit_skip(test, "target alloc fail");
>  	}
>  	r = damon_new_region(3, 5);
>  	if (!r) {
> +		damon_destroy_ctx(ctx);
>  		damos_destroy_filter(f);
>  		damon_free_target(t);
>  		kunit_skip(test, "region alloc fail");
> @@ -1668,27 +1699,27 @@ static void damos_test_filter_out(struct kunit *test)
>  	damon_add_region(r, t);
>  
>  	/* region in the range */
> -	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1));
> +	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, f, 1));
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
>  
>  	/* region before the range */
>  	r->ar.start = 1;
>  	r->ar.end = 2;
>  	KUNIT_EXPECT_FALSE(test,
> -			damos_filter_match(NULL, t, r, f, 1));
> +			damos_filter_match(ctx, t, r, f, 1));
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
>  
>  	/* region after the range */
>  	r->ar.start = 6;
>  	r->ar.end = 8;
>  	KUNIT_EXPECT_FALSE(test,
> -			damos_filter_match(NULL, t, r, f, 1));
> +			damos_filter_match(ctx, t, r, f, 1));
>  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
>  
>  	/* region started before the range */
>  	r->ar.start = 1;
>  	r->ar.end = 4;
> -	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
> +	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, f, 1));
>  	/* filter should have split the region */
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
> @@ -1704,7 +1735,7 @@ static void damos_test_filter_out(struct kunit *test)
>  	r->ar.start = 2;
>  	r->ar.end = 8;
>  	KUNIT_EXPECT_TRUE(test,
> -			damos_filter_match(NULL, t, r, f, 1));
> +			damos_filter_match(ctx, t, r, f, 1));
>  	/* filter should have split the region */
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
> @@ -1717,6 +1748,7 @@ static void damos_test_filter_out(struct kunit *test)
>  	damon_destroy_region(r2, t);
>  
>  out:
> +	damon_destroy_ctx(ctx);
>  	damon_free_target(t);
>  	damos_free_filter(f);
>  }
> -- 
> 2.55.0

Thank you for your patches!  LGTM.

Reviewed-by: Liew Rui Yan <aethernet65535@gmail.com>

Best regards,
Rui Yan
