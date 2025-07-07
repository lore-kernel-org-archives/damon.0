Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A891F8AC8;
	Mon,  7 Jul 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904911; cv=none; b=L23WTuYHidYBxzlH6C+g/Bs68ri3g6aKtNdMjBD9cHWYt0YiwOpcUf1xgvKZDPXNiYqY9yZaNhESu+s5Db27yes8K4gtXiLdJClKvsbmkE4Yy1I4HPRF/Y+5ksOx3bLX4FpZjlYI6FQOfFIG5+LiX1BPJv1p/8x5Fay7vSlVY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904911; c=relaxed/simple;
	bh=T452YEkKfjvjzCiqbAyq6ODzZ4DafggrKpSyaGNIn2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APpIso4XmCzQIpuBAhmMAtogdyTmVyiHVGEe4RBmcx6IW0b3BfJ3gBFRx7omKnbuvBxX61WrmHaVOGdymRXf9zLlyumZ/H+FQIM3QkHt6RfZWhbe0cBE8mw0fW93MUsibAKgQ9gFMkucLfysaV6BdklkG3BgVEFrGJuh0nCX/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY3MigCe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY3MigCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424A7C4CEE3;
	Mon,  7 Jul 2025 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904910;
	bh=T452YEkKfjvjzCiqbAyq6ODzZ4DafggrKpSyaGNIn2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NY3MigCekCHgNC7E0HDea7EkLXDimGWDUnCmerTRZHIOBnIz4r+evfUii6KeBpLI+
	 MtUyMWB4HQ2c0Q78Ru1b+OpuEykAh8Q1XV46kAxj+QPhMaN/Zs5hWt8UKvmBkjZFre
	 SCvpizuzJoL+Jhrw5vMT+cyyL7kUFtOz7t2036iG9+BID4GuO6eQa60uE+fpUZ246T
	 XF0NhoLPv/T2JeG1pJiv5jvOJB9G7LoJgPKjHsXaphTzVCc/x5tjuno+mDA8wfcpi/
	 RA974taOjByGXVFhlybKClV68KLaA2sYe3zDKXl4owZAx5jhslZAtSpyR1djleKDRI
	 FokQpCXaZbL6Q==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [PATCH v3] samples/damon: support automatic node address detection
Date: Mon,  7 Jul 2025 09:15:08 -0700
Message-Id: <20250707161508.85341-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707023135.453-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yunjeong,


On Mon,  7 Jul 2025 11:31:34 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> This patch adds a new knob `detect_node_addresses`, which determines
> whether the physical address range is set manually using the existing
> knobs or automatically by the mtier module. When `detect_node_addresses`
> set to 'Y', mtier automatically converts node0 and node1 to their
> physical addresses. If set to 'N', it uses the existing
> 'node#_start_addr' and 'node#_end_addr' to define regions as before.
> 
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> ---
> V2 -> V3: Removed an unusable comment
> V1 -> V2: Removed second patch, added a new knob, and cleand up code

Thank you for revisioning.

Let's clearly mention the v1 and v2 were RFC versions.

Also, from the next time, it would be greater if you could add links to the
previous versions.

For other reviewers,
RFC v2: https://lore.kernel.org/20250703074423.1771-1-yunjeong.mun@sk.com
RFC v1: https://lore.kernel.org/20250701085417.1734-1-yunjeong.mun@sk.com

> ---
>  samples/damon/mtier.c | 41 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index f3220d6e6739..3a6ae78efafe 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -42,8 +42,33 @@ static bool enable __read_mostly;
>  module_param_cb(enable, &enable_param_ops, &enable, 0600);
>  MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
>  
> +static bool detect_node_addresses __read_mostly;
> +module_param(detect_node_addresses, bool, 0600);
> +
>  static struct damon_ctx *ctxs[2];
>  
> +struct region_range {
> +	phys_addr_t start;
> +	phys_addr_t end;
> +};
> +
> +static int nid_to_phys(int target_node, struct region_range *range)
> +{
> +

Let's drop this unnecessary blank line.

> +	if (!node_online(target_node)) {
> +		pr_err("NUMA node %d is not online\n", target_node);
> +		return -EINVAL;
> +	}
> +
> +	unsigned long start_pfn = node_start_pfn(target_node);
> +	unsigned long end_pfn   = node_end_pfn(target_node);

Let's put declarations before executable statements, for the coding style
consistency.

> +
> +	range->start = PFN_PHYS(start_pfn);
> +	range->end  = PFN_PHYS(end_pfn);

Or, you could just skip the declarations and do something like below?

range->start = PFN_PHYS(node_start_pfn(target_node));

> +
> +	return 0;
> +}
> +
>  static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  {
>  	struct damon_ctx *ctx;
> @@ -53,6 +78,8 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	struct damos *scheme;
>  	struct damos_quota_goal *quota_goal;
>  	struct damos_filter *filter;
> +	struct region_range addr;
> +	int ret;
>  
>  	ctx = damon_new_ctx();
>  	if (!ctx)
> @@ -82,9 +109,17 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	if (!target)
>  		goto free_out;
>  	damon_add_target(ctx, target);
> -	region = damon_new_region(
> -			promote ? node1_start_addr : node0_start_addr,
> -			promote ? node1_end_addr : node0_end_addr);
> +
> +	if (detect_node_addresses) {
> +		ret = promote ? nid_to_phys(1, &addr) : nid_to_phys(0, &addr);
> +		if (ret)
> +			goto free_out;
> +	} else {
> +		addr.start = promote ? node1_start_addr : node0_start_addr;
> +		addr.end = promote ? node1_end_addr : node0_end_addr;
> +	}
> +
> +	region = damon_new_region(addr.start, addr.end);
>  	if (!region)
>  		goto free_out;
>  	damon_add_region(region, target);
> 
> base-commit: db16fe88cdf83a1e7fdf75de282025b6ad61d08f
> -- 
> 2.34.1


Thanks,
SJ
