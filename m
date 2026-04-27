Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB93C3C16
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295899; cv=none; b=cyNrs9WMYyEe4t9D7YpgV1j5F7fepmExHxqlFsef7kSmxCzHkx9SMrpl8TYZD8rWaSu4hHsPUhR26GDyoPrb+br9gIdtroSqV75gTDQqZXQkco3Cl8CnDcTWrONztw1kF8c0MVPlCVDBKVT5WivCYwA4SZMCRFg7QoxIbNZEkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295899; c=relaxed/simple;
	bh=v3mDuqWwB3fGTmDhLFQcE5KYj/sxpHR8PQ0Sy8Q38aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TndfTlo4T2AEGPVJgmYRQe00DeyIpz/Ndz7Heg5524x977fDTbTZhDiGD2xYx1/24mMDlvhWLbLTje48bAxKum756ca/uKQLqNNJVHXkDXYFFcMtdiJjEhQBshtAVQT6boGI4QqejgF9bxjta+0a4s4wzw27LNM40v1P40NTfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g43yR1fTszHnGk5;
	Mon, 27 Apr 2026 21:17:35 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C05740570;
	Mon, 27 Apr 2026 21:18:15 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Apr 2026 16:18:14 +0300
Message-ID: <2e2bee93-d68c-4b29-9ad1-1ef975fccec4@huawei-partners.com>
Date: Mon, 27 Apr 2026 16:18:14 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/19] mm/damon/core: embed damon_probe objects in
 damon_ctx
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260426205222.93895-1-sj@kernel.org>
 <20260426205222.93895-3-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260426205222.93895-3-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/26/2026 11:52 PM, SeongJae Park wrote:
> Let damon_probe objects be able to be installed on a given damon_ctx, by
> adding a linked list header for storing the objects.  Add initialization
> and cleanup of the new field with helper functions, too.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  9 +++++++++
>  mm/damon/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index da2f026eac725..65d7ee0a70ac0 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -859,6 +859,7 @@ struct damon_ctx {
>  
>  /* public: */
>  	struct damon_operations ops;
> +	struct list_head probes;
>  	unsigned long addr_unit;
>  	unsigned long min_region_sz;
>  	bool pause;
> @@ -892,6 +893,11 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
>  	return r->ar.end - r->ar.start;
>  }
>  
> +#define damon_for_each_probe(p, ctx) \
> +	list_for_each_entry(p, &ctx->probes, list)
> +
> +#define damon_for_each_probe_safe(p, next, ctx) \
> +	list_for_each_entry_safe(p, next, &ctx->probes, list)
>  
>  #define damon_for_each_region(r, t) \
>  	list_for_each_entry(r, &t->regions_list, list)
> @@ -934,6 +940,9 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
>  
>  #ifdef CONFIG_DAMON
>  
> +struct damon_probe *damon_new_probe(void);
> +void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
> +
>  struct damon_region *damon_new_region(unsigned long start, unsigned long end);
>  
>  int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index f556786597c83..861ab977d1edf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -109,6 +109,38 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
>  	return err;
>  }
>  
> +struct damon_probe *damon_new_probe(void)
> +{
> +	struct damon_probe *p;
> +
> +	p = kmalloc_obj(*p);
> +	if (!p)
> +		return NULL;
> +	INIT_LIST_HEAD(&p->list);
> +	return p;
> +}
> +
> +void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe)
> +{
> +	list_add_tail(&probe->list, &ctx->probes);
> +}
> +
> +static void damon_del_probe(struct damon_probe *p)
> +{
> +	list_del(&p->list);
> +}
> +
> +static void damon_free_probe(struct damon_probe *p)
> +{
> +	kfree(p);
> +}
> +
> +static void damon_destroy_probe(struct damon_probe *p)
> +{
> +	damon_del_probe(p);
> +	damon_free_probe(p);

Why don't we inline list_del and kfree here instead of calling
damon_del/free_probe?

> +}
> +
>  #ifdef CONFIG_DAMON_DEBUG_SANITY
>  static void damon_verify_new_region(unsigned long start, unsigned long end)
>  {
> @@ -633,6 +665,8 @@ struct damon_ctx *damon_new_ctx(void)
>  	ctx->attrs.min_nr_regions = 10;
>  	ctx->attrs.max_nr_regions = 1000;
>  
> +	INIT_LIST_HEAD(&ctx->probes);
> +
>  	ctx->addr_unit = 1;
>  	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
>  
> @@ -653,12 +687,16 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
>  void damon_destroy_ctx(struct damon_ctx *ctx)
>  {
>  	struct damos *s, *next_s;
> +	struct damon_probe *p, *next_p;
>  
>  	damon_destroy_targets(ctx);
>  
>  	damon_for_each_scheme_safe(s, next_s, ctx)
>  		damon_destroy_scheme(s);
>  
> +	damon_for_each_probe_safe(p, next_p, ctx)
> +		damon_destroy_probe(p);
> +
>  	kfree(ctx);
>  }
>  

-- 
Asier Gutierrez
Huawei

