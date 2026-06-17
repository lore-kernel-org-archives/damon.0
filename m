Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE842FFFA4;
	Wed, 17 Jun 2026 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667073; cv=none; b=gjsf6zVLMezBfeKVSdwag/eKW9XwUwchwi02BhnE1ST+BvsUdMBSlF8+xRVAEGsidDTj6191ROQitdYBp4behGIeKP1ruWxZO2DXcd05wnSGtcAmosvcBtFlj+5by3R0ymwv19p4+ATu3FWXjd7X621z/4zmXt6WPhMzV/0pad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667073; c=relaxed/simple;
	bh=NE63TY1tIW8a++nec75k203mHUTNTWv5ueggWdEKdeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQg2AG/2DAzYcFxOBrKRYGleuKZ9RqRpxaZQhA3MjAN+8sdd2pVTw6OFOB0xv+gkXHZ0rn3NNF4QxpsziVURmFDUW9kt4CWdIyVCfRfm6P+0m2xQL5dbLn6aGg/ebRdqM4Uy1/SJ36DRRFIgQpnnTZPEhFk0vaEF/FvavVZJPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFSc5IUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFSc5IUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA21F000E9;
	Wed, 17 Jun 2026 03:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781667071;
	bh=oRk5REZ1sq8yz/FEd2MRrPo8/o6v1rgYxnNAIv2TPNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nFSc5IUugCDmljlonMMQqY1wbqP+8d8ppLolDixCmob043Rpc25zvnPMzTg6tJkTf
	 /Da6IpoogaOI9xqf/fEm+gsmViQmX1sqFEy105e+cDLOtEEVHkFmBc/YXDEL4ZVTxp
	 brmx2SveZyDtG17HgiFXfl/jBW5FOk0nSL8o44JqxsY46pgzKPiON+Rer7hJcZwlH4
	 fBOllj/UKLXIQx8Ko0Xf1EaqAv09xo3CbcApTo0dkX1QPFvKROfFGVLVzLhPXsonQY
	 KTrM1LNBEHpNmuEzj45MdLW/IF7uq1nKngzldKqLVn16RiNg2m0C+qHxLQKCQ+KFVc
	 IjA6o+vaTHp6w==
From: SeongJae Park <sj@kernel.org>
To: gutierrez.asier@huawei-partners.com
Cc: SeongJae Park <sj@kernel.org>,
	artem.kuzin@huawei.com,
	stepanov.anatoly@huawei.com,
	wangkefeng.wang@huawei.com,
	yanquanmin1@huawei.com,
	zuoze1@huawei.com,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Tue, 16 Jun 2026 20:31:03 -0700
Message-ID: <20260617033104.98334-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150316.580819-2-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:03:14 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new

Please fix the name of the quota, and add the ending period after 'tuning'.

> DAMOS quota goal metric to measure the amount of huge page
> consumption to total memory consumption ratio.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  include/linux/damon.h |  2 ++
>  mm/damon/core.c       | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef..23a9cec05033 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -162,6 +162,7 @@ enum damos_action {
>   * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to total LRU memory ratio.
>   * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:	Scheme-eligible memory ratio of a
>   *					node in basis points (0-10000).
> + * @DAMOS_QUOTA_HUGEPAGE_MEM_BP:	Huge page to total used memory ratio.
>   * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
>   *
>   * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
> @@ -176,6 +177,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE_MEM_BP,
>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b0..b001f80681b1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2795,6 +2795,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
>  
> +static unsigned int damos_hugepage_mem_bp(void)
> +{
> +	unsigned long thp, total;
> +
> +	thp = global_node_page_state(NR_ANON_THPS) +
> +				global_node_page_state(NR_SHMEM_THPS) +
> +				global_node_page_state(NR_FILE_THPS);
> +	total = totalram_pages() - global_zone_page_state(NR_FREE_PAGES);
> +	return mult_frac(thp, 10000, total);
> +}
> +
>  static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		struct damos *s, struct damos_quota_goal *goal)
>  {
> @@ -2826,6 +2837,9 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
>  				goal->nid);
>  		break;
> +	case DAMOS_QUOTA_HUGEPAGE_MEM_BP:
> +		goal->current_value = damos_hugepage_mem_bp();
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.43.0

Code looks good to me.


Thanks,
SJ
