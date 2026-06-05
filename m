Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77013D539;
	Fri,  5 Jun 2026 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620269; cv=none; b=ZZFQDAWcmRaFrEe5vHh5jxMj//mZG4S7Dc+abeLSdnMIFhoOukrDuQDAFAX8b42b2/ovLROAPc1mCOyWRoFbIjSHWTTJKFllOlwDkT9yFSGdo4vhgiW6I6RWgyWq03SVBW2V9A5GQ+gFwAr/k7mNkAMTEtue0gmLXuW949j/nok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620269; c=relaxed/simple;
	bh=4Vkg6o5Sa+/8zbFcs16G1eaOuZsWW5zg0q4ikaIzSPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEXzJnzMXTrsNaeYz0nBm8y2DQKNm9Grds4N/kwRwbmF01q9gj1giBaXgPJuWodMMAEJB+Cng5BWvgX1Jkrz6u8ntdwM++prF3UaM2gJqQ8BjBwmbf0Bb5PscKL7ThPK4B+K/2DcjP/LsJEUEgn5QiY+clCz34DXlQz/VguyWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evSrm9Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evSrm9Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8A41F00893;
	Fri,  5 Jun 2026 00:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780620268;
	bh=6q2i0FownRA3YZDzx7XlKDNjZ1os0IoGmvW0lPidl0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evSrm9FcuKl26K4DQgLNCuVj0BGkyeskpZqhPt+rGdj2hEX78hB/S+maA9XDn9w7H
	 eB/9UvWVhr1vC8htSeE+oxgVjQpIEIJ8ryqaCvNcqVTmQaWozEQysDKevfJvTubzzD
	 xRazdqK6U+9QrLjDopCbUxU2mpOfBsIwdN8//vuwx8CQMvG2jwb7BBhr6SwSfBkaGN
	 3ibx6nn1KujOWLQsd2L+X/PLf3lYTEo7+IjTrczhFxAKC0mMyQvll4zNXc5G61cfGJ
	 XyLPtblkPCq0+tmePgdkbpqnNnR4AmOo4HghrlcniKPnfIWCUelqASA47Pc4PmAxXm
	 m/46vt3uDbGvw==
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
Subject: Re: [RFC PATCH v3 1/4] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Thu,  4 Jun 2026 17:44:22 -0700
Message-ID: <20260605004422.82568-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604150338.501128-2-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Jun 2026 15:03:34 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> Introduce DAMOS_QUOTA_HUGEPAGE auto tuning Add a
> new DAMOS quota goal metric to measure the amount of huge
> page consumption to total anonymous memory consumption
> ratio.

s/anonymous// ?

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
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

On the previous revision, I suggested renaming this to
DAMOS_QUOTA_HUGEPAGE_MEM_BP for consistency, but it didn't got your reply.
Could I ask your opinion?

Also, I asked you to add the kernel-doc comment before dropping RFC.  I know
you didn't drop RFC tag yet, but could you consider adding it from the next
revision?

>  	NR_DAMOS_QUOTA_GOAL_METRICS,
>  };
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 9f38deddcb30..7fc7477a353a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2536,6 +2536,17 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
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

As Sashiko also [1] commented, let's avoid divide by zero by checking if total
is zero, before calling mult_frac().

I wouldn't mind ignoring Sashiko's 32-bit concern, but do you have any opinion?

> +
>  static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		struct damos *s, struct damos_quota_goal *goal)
>  {
> @@ -2567,6 +2578,9 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
>  				goal->nid);
>  		break;
> +	case DAMOS_QUOTA_HUGEPAGE:
> +		goal->current_value = damos_hugepage_mem_bp();
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.43.0

Other than the above comments, looks good to me overall.

[1] https://lore.kernel.org/20260604151932.93C431F00893@smtp.kernel.org


Thanks,
SJ
