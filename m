Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEB1273D6D;
	Sat, 23 May 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779557257; cv=none; b=CN4u9aKf5KXpbXfEwZGiAaqOG8kr167qJjR2Y7OKGocakshFrvJzMBgKyS2kBseUa51/h7sc3KdSBWr2yxQpeUW9cLUnD86FzN+xNbV8Tuq6jDvWU6aJqRCyejCHQ1vcBLaJJLMStJnFdYrXdyVkiGxEYXYu2RKMyKncIyp13oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779557257; c=relaxed/simple;
	bh=1JeCJwi49yjabzYRzyVcBhLhxPKOZPTEHUQzHa6SpS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cupiV+BCcRhXjbH8j+nipqRwydo/YoSIZpIS6i0EhF95foLGEQPejyv04uGbF8l3Lv/QCFjno+w/QXAXoDgxbnhgpm88fDOZKHJi4FQtAvuRngCEfCpGvGnTFLz0zlSwLwsrmXhDNyATWNQHh2GM/NOteHsVX7nqWEKqWmkqq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrwOKdH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrwOKdH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2611F000E9;
	Sat, 23 May 2026 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779557254;
	bh=XXaz7Q/CnqS13vT7T2cImdcs5ms1pR0AbdhKZsEe4GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrwOKdH1Vd3OHCIuYkHLNh6Q0ty3iMtNYDfdWT7NJtsVadnpW/xHvK/D4ALdk2XYh
	 DSY2dY8UuNJRcke2SRULm/5FkjfyTUlHWbGf73O4lKSk2l5v7U/BkuyqFB8yliF9E9
	 sds9XRX279/pPEx2SYWQzok1GbnlzACwTrQ+twf5KpHCrNi4A7Uq00sXI+TRdi358F
	 7XH1VRyaJ1l2cYvRZS309gC5vdvhyG1aNk8tTyLSr5zKwoou6x1wiVm0BkLBFeD1F/
	 2VVmLnlK+fCUSV44P4VOOl8pHsalQQu/4m5DxtOH1qZrKuou69oHdRICpp2uAm+ucU
	 zPD8Xxf2LNz6w==
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
Subject: Re: [RFC PATCH v2 2/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Sat, 23 May 2026 10:27:25 -0700
Message-ID: <20260523172725.89221-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522145518.158910-3-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 14:55:16 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a new DAMOS quota goal

I'd suggest to rename it to DAMOS_QUOTA_HUGEPAGE_BP for consistency.

Also, you missed the ending period after 'tuning'.

> metric to measure the amount of huge page consumption to total
> anonymous memory consumption ratio.

Why against anonymous memory only?

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c7a31572689b..8e15a674e893 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -177,6 +177,7 @@ enum damos_quota_goal_metric {
>  	DAMOS_QUOTA_ACTIVE_MEM_BP,
>  	DAMOS_QUOTA_INACTIVE_MEM_BP,
>  	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> +	DAMOS_QUOTA_HUGEPAGE,
>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };

Before you drop RFC tag, please ensure to add kernel-doc comment for tyhe new
value.

>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9f38deddcb30..1f1cf10aa241 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2536,6 +2536,18 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
>  	return mult_frac(inactive, 10000, total);
>  }
>  
> +/*
> + * Returns anon hugepage memory to total anon memory use ratio.
> + */
> +static unsigned int damos_get_used_hugepage_mem_bp(void)
> +{
> +	unsigned long used_hugepages, total_used;
> + 
> +	used_hugepages = global_node_page_state(NR_ANON_THPS);
> +	total_used = global_node_page_state(NR_ANON_MAPPED);
> +	return mult_frac(used_hugepages, 10000, total_used);

So this function returns anon THP to total anon pages ratio.  Why only anon
THP?  Also as I asked above, why only total anon?


Thanks,
SJ

[...]
