Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B43F1055;
	Fri,  9 Oct 2026 07:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531836; cv=none; b=YUtE1qDOOO1Vrko93JbIG7+mBJ2DJ0rh9CySyLvIZoe+y5hbCahycwt1gsTuCFe4Xclry+nv+YNwSeZ4Tdchi/CFgjT8JeYd+u4GMvL7WJZyxkii7fw5l9Sf+CtI9k3/x2j8V24Kn9VQ03e8dfzHwLRS87aR3CCHGC92pR+wyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531836; c=relaxed/simple;
	bh=IpMzkkNqepgxJPFSkix3xsTlOZo3gMZlPAmQq3aVWMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE0HW7OrVd2iHpBAgsf2aVU5/zPa6XjFJr7QKCwy6j7unZLcmCv392Y3Ak+F8Jqlgq3so4z5lEKRsh/jCPF3QS2yCYSaMmkc+t0kTddKo/5EA353qpnjE51zFI0P9UUefYPoGLp/qpZRtzCsRMBy3Pd0MeAjREqkirVvrjqZ6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwklBata; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwklBata"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3101F00893;
	Fri,  9 Oct 2026 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531835;
	bh=vrj+nhypUG08L0LQQg/weWxoS5B/DorI7msAivdz5r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gwklBata4izVqdnVUPTJdgYIIsv8m03v60Hc+bMKD8+zpMaEnf8Yh8YDnirz6DcnS
	 L/+gLFuj1V1AQSivhZN/XcFQkIJlA7VweNG1lchxo0slVwPTtkhHlcKKwCj2pxSf1B
	 w5eLrgV2SK/isxSwfgEyYXEDeaXK0EMaPeguxTCYGPh+x4orL86omnezAdibluxnzZ
	 0/eIHOmCJYta0REGuZ54YSkc26p7OVIWdEK/3U8lY1txZXIvADbR+Eam7vnVuYK7P+
	 hM53XYqQzBD43q0DgRgeVSkSu4wrs4tWgEWrrscS7pVK6ZwmLPf7gO87jtiYekszij
	 u2/FKsV2OMNtw==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	aethernet65535@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Fri,  9 Oct 2026 00:43:49 -0700
Message-ID: <20261009074349.40812-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008151944.113714-2-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Suhaas,

On Thu,  8 Oct 2026 20:49:25 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. However, it is
> possible that we have fewer probes installed than DAMON_MAX_PROBES. In such
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
> 
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.
> 
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
> ---
>  mm/damon/core.c             | 16 +++++++++++-----
>  mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++--
>  2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b63e60ef8990..fc202f90991b 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3524,20 +3524,26 @@ static void damon_verify_merge_two_regions(
>  /*
>   * Merge two adjacent regions into one region
>   */
> -static void damon_merge_two_regions(struct damon_target *t,
> -		struct damon_region *l, struct damon_region *r)
> +static void damon_merge_two_regions(struct damon_ctx *ctx,
> +				    struct damon_target *t,
> +				    struct damon_region *l,
> +				    struct damon_region *r)

Please use two tabs for indentation of the second and next lines of function
parameters.  For example:

'''
@@ -3739,8 +3739,9 @@ static noinline_for_stack void kdamond_apply_schemes(struct damon_ctx *c)
 }

 #ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_merge_two_regions(
-               struct damon_region *l, struct damon_region *r)
+static void damon_verify_merge_two_regions(struct damon_ctx *ctx,
+               struct damon_target *t, struct damon_region *l,
+               struct damon_region *r)
 {
        /* damon_merge_two_regions() may created incorrect left region */
        WARN_ONCE(l->ar.start >= l->ar.end, "l: %lu-%lu, r: %lu-%lu\n",
'''

>  {
>  	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
>  	int i;
> +	struct damon_probe *p;
>  
>  	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>  			(sz_l + sz_r);
>  	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
>  	l->ar.end = r->ar.end;
> -	/* todo: do this for only installed probes */
> -	for (i = 0; i < DAMON_MAX_PROBES; i++)
> +
> +	i = 0;
> +	damon_for_each_probe(p, ctx) {
>  		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
>  				* sz_r) / (sz_l + sz_r);
> +		++i;
> +	}
>  	damon_verify_merge_two_regions(l, r);
>  	damon_destroy_region(r, t);
>  }
> @@ -3590,7 +3596,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
>  			goto set_prev_continue;
>  		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
>  			goto set_prev_continue;
> -		damon_merge_two_regions(t, prev, r);
> +		damon_merge_two_regions(ctx, t, prev, r);
>  		continue;
>  set_prev_continue:
>  		prev = r;
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index ef146ca2ae8a..4e380c6c5eb2 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -182,13 +182,27 @@ static void damon_test_merge_two(struct kunit *test)
>  {
>  	struct damon_target *t;
>  	struct damon_region *r, *r2, *r3;
> +	struct damon_probe *p;
> +	struct damon_ctx *ctx;
>  	int i;
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
> @@ -198,6 +212,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	damon_add_region(r, t);
>  	r2 = damon_new_region(100, 300);
>  	if (!r2) {
> +		damon_destroy_ctx(ctx);
>  		damon_free_target(t);
>  		kunit_skip(test, "second region alloc fail");
>  	}
> @@ -206,7 +221,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	r2->age = 21;
>  	damon_add_region(r2, t);

Let's allocate and setup 'ctx' and 'p' here.  That will reduce alloc failure
handling code.  Also add 't' to 'ctx'.  That will let us to remove
damon_free_target() call from the final cleanup.

>  
> -	damon_merge_two_regions(t, r, r2);
> +	damon_merge_two_regions(ctx, t, r, r2);
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
> @@ -220,6 +235,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	}
>  	KUNIT_EXPECT_EQ(test, i, 1);
>  
> +	damon_destroy_ctx(ctx);
>  	damon_free_target(t);
>  }
>  
> -- 
> 2.55.0

Thanks,
SJ
