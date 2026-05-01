Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7C46B5;
	Fri,  1 May 2026 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596513; cv=none; b=cQCvpfUR7kPoWbo9RJNF5tkb99uG85zyfhHB2HQf8gnF6ZMYs7HYHBwcK3bQ7fzdsn6nHIta49Ni/oyrRm1XX338LQYew0KCSqKxemzP9MH0knYeQc2DgVmr+jTKZUKEut7GQrk6RsCEFLJB58D3VezU9dcJli8R5dy9HRZhZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596513; c=relaxed/simple;
	bh=QYE+u2FdAXNX5PHivfzb78bycey5Sr9+axN8eMvgZ5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHBo6BXvCh0MhZdmqo2ttXStHYipB+Y9ogrsBcRkXycQmxbFBzsX8vKfN5tkI/DbrAuv/GfG0gd5xAr3K1ntm/tsM+ny5J9PE68AAIHlTpf0vx8/QIVetmqkYrZ8PgP71rtFr7dNheWXpK4nOy+2LmJvNfG/6F1+zADRxwSdrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCc/Eje4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCc/Eje4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58751C2BCB3;
	Fri,  1 May 2026 00:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596512;
	bh=QYE+u2FdAXNX5PHivfzb78bycey5Sr9+axN8eMvgZ5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCc/Eje4Chjgo2zyRCKBH8S0cTpX4fnADHoRHjEO0waIJ8DBK2QQzd0H0BVvbQR/d
	 BI3N+3UuMSfoGwJUCsUJUAUaAORV+eBJGhcypZDEIjFEHidpl3eXtDwsaDAdbemT/U
	 T4Bp92SVyn3OGefNn/BV3bQACapuVLYgmI2I2WiZZJijjuqgAXv3JqBAlxIwj1x00H
	 sy+hBDoQskyxoNUpHpP1ai/9/2jlvk3DmJOIOvXqOKRZvrw4BCC0CUs1/YHrqRGcSu
	 Ft1XnNfF/bpBV2+YyRLtpQvdCKCku1Q06wCizNnVh0KQvBw5NMZeygJUWAqrOCRAIl
	 4+N55HASG72Lg==
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
Subject: Re: [RFC PATCH v1 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Thu, 30 Apr 2026 17:48:28 -0700
Message-ID: <20260501004829.79016-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430134139.2446417-3-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 30 Apr 2026 13:41:37 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning

You forgot the sentence ending period.

Also, the cover letter was calling it in a different name.  Let's match those.
Also, as I suggested on the reply to the cover letter of this series, too, I'd
prefer having the unit for the ratio on the name, like other goals, e.g.,
DAMOS_QUOTA_HUGEPAGE_BP.

> Add a new DAMOS quota goal
> metric to measure the amount of huge page consumption to total anonymous
> memory consumption ratio.

Why only anonymous memory?

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f2cdb7c3f5e6..97201e9fa407 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -172,6 +172,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE,
>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3dbbbfdeff71..06547e590ff2 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2319,6 +2319,18 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
>  
> +/*
> + * Returns anon hugepage memory to total anon memory use ratio.
> + */
> +static unsigned int damos_get_used_hugepage_mem_bp(void)

Name sounds bit long.  What about damos_get_hugepage_bp() ?

> +{
> +	unsigned long used_hugepages, total_used;
> + 
> +	used_hugepages = global_node_page_state(NR_ANON_THPS);
> +	total_used = global_node_page_state(NR_ANON_MAPPED);
> +	return mult_frac(used_hugepages, 10000, total_used);
> +}
> + 
>  static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
>  {
>  	u64 now_psi_total;
> @@ -2345,6 +2357,9 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
>  		goal->current_value = damos_get_in_active_mem_bp(
>  				goal->metric == DAMOS_QUOTA_ACTIVE_MEM_BP);
>  		break;
> +	case DAMOS_QUOTA_HUGEPAGE:
> +		goal->current_value = damos_get_used_hugepage_mem_bp();
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.43.0


Thanks,
SJ

[...]
