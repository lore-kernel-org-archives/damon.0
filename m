Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0744486437;
	Thu,  8 Oct 2026 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456259; cv=none; b=hJZyu+1j4Sm/yTYmAZBn52leSpKYv3nShE1XEWtboLx6/Ikhj3HWa8Zy4GAiwU2OVGfpH46uUcHeoOTQbo1pP5fWb2r5bdjsPTAZB9rZn1I+vCLch0f2D2HIs3dRH+l8BBo1z6GFJwzkOceq7hcREbNYkcJngIn656qY9c8Jrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456259; c=relaxed/simple;
	bh=5His/kCO9HYQDvbAi3qLRZKbqmBR6NRT+sVuYRH0R0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugQXyQVpqGmEMvHJhjemZYdOt0rQi9ECNkD6gX9qJ2QIvlaAFruCQBYi8omUa43g5m7at5nHuJwRE24+Q5mChw53RBAtIB9N+uvXZtD+ex7iY1LSQpVwkeP4ILpD9wTnsQY8IXwJDTGOaFN8IApbpGXcWoWg06B2GBN21Zwbv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3Yn78FL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3Yn78FL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EC21F000FF;
	Thu,  8 Oct 2026 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791456258;
	bh=ALgWdXYbn+bZ4rwwXsWrPzPXW9ZDmpWl0lnnVBOFCg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m3Yn78FL9rXGtclLkP1KF5t89BIGXiOUwbOXsJclfRipe2zZck+tUTcBm6UHB4ttb
	 p0mKlWUfbx44yq4vo0dmSnlkmThwinA0atzbkQ3bt9CJSxOHxpEMr8MZLFqe3NTG4d
	 HrMv7xhjpqzN1p8olqNhfy/t4cU1p/Ak8j/fmTyuxxdF9LpY6glZdRwrU6n86BWu9G
	 mw071u56P/es6RDG1HX643YmLUcbwD5PZWH3WghjM/nuZvBZlZUwNlDGpr89aZT4ni
	 PKGUuedBqQ76WUW1e/2jaVEE36cW7dPgB1wIAfkSSgYiiQbo0fKNhvjYRKJC/mLDuW
	 2joSes8u6WlMA==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Thu,  8 Oct 2026 03:44:13 -0700
Message-ID: <20261008104414.40641-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261007154851.45368-2-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Suhaas,

On Wed,  7 Oct 2026 21:18:45 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. It is possible,
> however, that we have fewer probes installed than DAMON_MAX_PROBES. In such
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
> 
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.

Thank you for this patch.

[...]
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
> @@ -206,7 +220,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	r2->age = 21;
>  	damon_add_region(r2, t);

As also found [1] by Sashiko, seems this patch mistakenly not calling
damon_destroy_ctx() for r2 allocation failure.  Could you please add that?

[1] https://lore.kernel.org/sashiko-outbox-163177@kernel.org


Thanks,
SJ
