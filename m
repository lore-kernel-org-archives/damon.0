Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EB20125F;
	Mon, 23 Mar 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275653; cv=none; b=MVnoXlZYfpCWvDKP8Ohx2YJfKnpcDtJAzAZXLx5OHBupjl0j0Bk5UTML2Kylzlzm9hVxtFEhMzKWzicbaTLbUVnH+pDmiaioQ1hfVhFmiZI2waUNsq/XfSqt+nRp6wfAbosrMRZ3T0cJ/61EEgHczurPVksj3N7UkIo2CODNw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275653; c=relaxed/simple;
	bh=np7GJeZ0jLioNC9C95zZxpcbkD3f0U2gmsKmzHDihrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSL5S7NUESmK0voPlQ7OksqFgk+X7hCP+5x4Um+rIV1JeqFa/2DhlaoQ4nPZjUeW1A6qY39xabCBUz5hDn3M5bLgMqHfVaSp6gPdX5r5U1UTlK6tp5LcufKGuktPT56NGt/iaAtttQ/hH9ZKdtEqZArF29S0v1g2H/ZqpRjisw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9vvI0tK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9vvI0tK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC5C2BCB1;
	Mon, 23 Mar 2026 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774275653;
	bh=np7GJeZ0jLioNC9C95zZxpcbkD3f0U2gmsKmzHDihrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9vvI0tKLWmkNCkn4S4AWjUSeFwUR9rM5pWcBZfnmjvukAEgO3a0g/9uztS9Mie+t
	 TbeR2eyzy2LFzOl3htMehCtUtp2ZnJ0E1vdv5Bcn6lqM9WJyW+OH4JYVJsy+FSOWjP
	 Gwxo+3u15Noo6oLOV/htC5qADytjHECCxmceHlpaK/H3/ELs3ni3OmBy7VkEJ58d6n
	 3dy/jXUSpcHDvCudF6tm+NIpQZ7THgXxLe1OSAsVEOPlNIiKyvcnoadQknsY8mmcyn
	 pL2yWQdfzJXZ+2fCVYqvi4gwpXM4c7sDHxEMN6zVdn/fi8pL93KtspvrzAF/G2cwq7
	 elZBP5aCuRqow==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: optimize kdamond_apply_schemes() with pre-filtered scheme list
Date: Mon, 23 Mar 2026 07:20:51 -0700
Message-ID: <20260323142051.80436-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322225627.263202-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 22:56:27 +0000 Josh Law <objecting@objecting.org> wrote:

> Currently, kdamond_apply_schemes() iterates over all targets and regions
> for every scheme in the context, even if the scheme is inactive due to
> watermarks or hasn't reached its next apply interval.
> 
> This patch introduces a pre-filtered list of active schemes at the start
> of kdamond_apply_schemes(). By only iterating over schemes that actually
> need to be applied in the current interval, we significantly reduce the
> overhead of the nested target/region loops.
> 
> This optimization maintains the original Target -> Region -> Scheme
> behavior while providing substantial performance gains, especially when
> many schemes are inactive.
> 
> Performance Benchmarks (Filtered Array vs Original):
> | Scenario Description      | Speedup |
> |---------------------------|---------|
> | Mostly Inactive (2/10)    |  7.5x   |
> | Half Active (5/10)        |  2.9x   |
> | All Active (10/10)        |  1.3x   |
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  mm/damon/core.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c884bb31c9b8..3b59e72defd4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2114,19 +2114,16 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  
>  static void damon_do_apply_schemes(struct damon_ctx *c,
>  				   struct damon_target *t,
> -				   struct damon_region *r)
> +				   struct damon_region *r,
> +				   struct damos **active_schemes,
> +				   int nr_active_schemes)
>  {
> -	struct damos *s;
> +	int i;
>  
> -	damon_for_each_scheme(s, c) {
> +	for (i = 0; i < nr_active_schemes; i++) {
> +		struct damos *s = active_schemes[i];
>  		struct damos_quota *quota = &s->quota;
>  
> -		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
> -			continue;
> -
> -		if (!s->wmarks.activated)
> -			continue;
> -
>  		/* Check the quota */
>  		if (quota->esz && quota->charged_sz >= quota->esz)
>  			continue;
> @@ -2476,7 +2473,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	struct damon_target *t;
>  	struct damon_region *r;
>  	struct damos *s;
> -	bool has_schemes_to_apply = false;
> +	struct damos *active_schemes[32];
> +	int nr_active_schemes = 0;
>  
>  	damon_for_each_scheme(s, c) {
>  		if (time_before(c->passed_sample_intervals, s->next_apply_sis))
> @@ -2485,12 +2483,15 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  		if (!s->wmarks.activated)
>  			continue;
>  
> -		has_schemes_to_apply = true;
> +		if (nr_active_schemes < ARRAY_SIZE(active_schemes))
> +			active_schemes[nr_active_schemes++] = s;
> +		else
> +			WARN_ONCE(1, "too many schemes to apply");

We may need to increase the size of the array insted of just warning.  That
will make this code little bit more complicated.  I'm worried at maintenance
burden from such a complicated code more than the benefit of the optimized
performance here.

If this is real bottleneck that bothers real users, we should optimize this
even if it makes code dirty and more difficult to maintain.  But, at the moment
it is unclear if this is a real bottleneck.

I'd suggest to hold this for now, and revisit if this becomes clearly a
bottleneck of a real use case, e.g., a user claims so.


Thanks,
SJ

[...]
