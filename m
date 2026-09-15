Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FA03B2FD4
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477236; cv=none; b=pqQrdIwqTiUkj0Xts8QO7Ert0LxEVsdcEqviI+vVMl09sg/EWsW85R82sqWRlvcFRM68Ba68F0vLPHQBy2p1zIBEVAZA8Xai2FratovMjCSHUqYOvFqp4eUVZk6rldFzUzA83IqlnXcjO3zB465SWBQOtRvSUWzHTahiDiZKOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477236; c=relaxed/simple;
	bh=8Iig13WWjneOyX8KyPeO4Ee/L4k/7+zpdoNaaUmwk8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Erdmgd+7t9yExdte6Q8GNesX7/X313J2YWR95vClgoNkFgayJqyWij04gqrVHEIsf0dzz2pYherSqRJzxKDzbuDh6p9wNqo2ywi77HhqXelOomJgtXJLB0D1ILensRjYySKcLOsRbfPQh5vQ0v4jFIMTNmiC1pNwgniZ1REaMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vr+p6Dgs; arc=none smtp.client-ip=91.218.175.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vr+p6Dgs"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=8Iig13WWjneOyX8KyPeO4Ee/L4k/7+zpdoNaaUmwk8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789477232; v=1; x=1790082032;
 b=vr+p6DgsZ0C0zJcb5Ejn1YU5qWlSM1DOoRV4Z9MNs4WXOYjcLGCTduGVivAZHXNSLJsqLHxG
 C5+y0Ywu/fjj8B4sikDK1vnrQRk1h27l7PGGA96MIvm1xzeoucAfAACxs+bZ/iVrBC5bzqbCe4Q
 VyDxcmEcujdjxZBAGuqpTcKA=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 91b1d043b12ab9bd;
	Tue, 15 Sep 2026 13:00:11 +0000
X-Mizu-Trace-ID: 91b1d043b12ab9bd
X-Migadu-Flow: FLOW_OUT
Message-ID: <166d8533-127c-4e2b-b37e-a6650c981a97@linux.dev>
Date: Tue, 15 Sep 2026 21:00:01 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/damon: fix typos in comments
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ahuang12@lenovo.com
References: <20260915102746.647-1-adrianhuang0701@gmail.com>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260915102746.647-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 6:27 PM, Adrian Huang (Lenovo) wrote:
> Correct spelling mistakes. No functional changes.
> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
>  mm/damon/core.c     | 6 +++---
>  mm/damon/lru_sort.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d0..981a153619c0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2447,7 +2447,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
>   * This function checks if a given region should be skipped or not for the
>   * reason.  If only the starting part of the region has previously charged,
>   * this function splits the region into two so that the second one covers the
> - * area that not charged in the previous charge widnow, and return true.  The
> + * area that not charged in the previous charge window, and return true.  The
>   * caller can see the second one on the next iteration of the region walk.
>   * Note that this means the caller should use damon_for_each_region() instead
>   * of damon_for_each_region_safe().  If damon_for_each_region_safe() is used,
> @@ -2613,7 +2613,7 @@ static void damos_walk_call_walk(struct damon_ctx *ctx, struct damon_target *t,
>   * This function is called when kdamond finished applying the action of a DAMOS
>   * scheme to all regions that eligible for the given &damos->apply_interval_us.
>   * If every scheme of @ctx including @s now finished walking for at least one
> - * &damos->apply_interval_us, this function makrs the handling of the given
> + * &damos->apply_interval_us, this function marks the handling of the given
>   * DAMOS walk request is done, so that damos_walk() can wake up and return.
>   */
>  static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
> @@ -4143,7 +4143,7 @@ static bool damon_find_system_rams_range(unsigned long *start,
>   * This function sets the region of @t as requested by @start and @end.  If the
>   * values of @start and @end are zero, however, this function finds 'System
>   * RAM' resources and sets the region to cover all the resource.  In the latter
> - * case, this function saves the start and the end addresseses of the first and
> + * case, this function saves the start and the end addresses of the first and
>   * the last resources in @start and @end, respectively.
>   *
>   * Return: 0 on success, negative error code otherwise.
> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index ad8e86dd3a93..273efa3c913e 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -260,7 +260,7 @@ static int damon_lru_sort_add_filters(struct damos *hot_scheme,
>  		return -ENOMEM;
>  	damos_add_filter(hot_scheme, filter);
>  
> -	/* disabllow de-prioritizing young pages */
> +	/* disallow de-prioritizing young pages */
>  	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, false);
>  	if (!filter)
>  		return -ENOMEM;

Reviewed-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Thanks,
Zenghui
