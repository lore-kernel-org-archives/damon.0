Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A6142E73;
	Tue,  1 Jul 2025 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414051; cv=none; b=JNrqeZzfBBDEIsNwPufnwzDMXv5A8Fyj6rOaBCBlrFOEWcuEyVngdXPTALbXC/p+lcKxZCRi7+ES8U7d712BoQbzdt8HE46BO5kaO6eKzcHk9gUfSDO+BjF5Nx9Y5fk5i5vRFRg+igbq7D2hhILAYf8bsiBSURk8JTWd/2aBa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414051; c=relaxed/simple;
	bh=mbFhslX3DVOk0S3Kn1dLLJTRL/+V1bf1gxONJ/aQqy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf0BTnkdo9QJRJ3q3Qh3ZWZovUC/DaAgvGG0rmpIQFQHcQJLiXs4e5ApZssJnUmdaLFHiHEpGOD4ITVvI40OTF2X3WQpaGlzSytLfEKh8337/vTjFXHziQfMIz91hPYyxp79vTAD7SlBMEKkN4QaFXmIzbKXa9Z8fXcKYSTiV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMeXLc9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMeXLc9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559B6C4CEEB;
	Tue,  1 Jul 2025 23:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751414050;
	bh=mbFhslX3DVOk0S3Kn1dLLJTRL/+V1bf1gxONJ/aQqy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AMeXLc9CCOO8jp0Dy15eQaB5zHy3dytlFXsMVCQ9uwlEwJKJ9Q6NMuvC+mOgXLzA6
	 gRr964c4PlkIFgsfL+K3Bx2OQGKkqduaVSEEs1nui7PXJ57mAIHsBnQio4WP3UA5UW
	 mKZ9950aMjT8UZKJ4HhB0oxQQxyoylLedYDkIwaOflDNnKvXE/GkAEm2OR6HnBnZxb
	 Bq3qQ+o53sJ1cKQJBO6YDeOIZxc0VTvyYHTJvySLZAMvdb7aPmnMw5l2uS9VjOIdHq
	 uI9mYKtU4N/f13lQoj1DF+530c1nAJBiNKL1HBtiRLBrlIY3E2DbFc7dAkA3TInfQK
	 BAI6oMzRMwUIQ==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 1/2] samples/damon: convert node id to physical address
Date: Tue,  1 Jul 2025 16:54:07 -0700
Message-Id: <20250701235407.57420-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701085417.1734-2-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yunjeong,

On Tue,  1 Jul 2025 17:54:16 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> This patch removes the `node#_start_addr` and `node#_end_addr` knobs,
> and introduces logic for converting numa node id to physical address.
> It only checks whether a numa node is online and calculates the
> start and end addresses of the node. It does not verify whether each
> memory block within the numa node is `usable` or part of `System RAM`,
> as performed by `damo` [1],[2].

This is just a sample module, but I'd like to avoid making unnecessary
user-breaking changes.  How about keeping the existing knobs but adding yet
another knob for the automatic detection, say, 'detect_node_addresses'?

> 
> [1]
> https://github.com/damonitor/damo/blob/v2.8.5/src/damo_pa_layout.py#L72-L90
> [2]
> https://github.com/damonitor/damo/blob/v2.8.5/src/damo_pa_layout.py#L92-L10
> 
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> ---
>  samples/damon/mtier.c | 44 ++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index f3220d6e6739..ba6938a89c21 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -12,18 +12,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  
> -static unsigned long node0_start_addr __read_mostly;
> -module_param(node0_start_addr, ulong, 0600);
> -
> -static unsigned long node0_end_addr __read_mostly;
> -module_param(node0_end_addr, ulong, 0600);
> -
> -static unsigned long node1_start_addr __read_mostly;
> -module_param(node1_start_addr, ulong, 0600);
> -
> -static unsigned long node1_end_addr __read_mostly;
> -module_param(node1_end_addr, ulong, 0600);
> -
>  static unsigned long node0_mem_used_bp __read_mostly = 9970;
>  module_param(node0_mem_used_bp, ulong, 0600);
>  
> @@ -44,6 +32,28 @@ MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
>  
>  static struct damon_ctx *ctxs[2];
>  
> +struct region_range {
> +	phys_addr_t start;
> +	phys_addr_t end;
> +};
> +
> +static int numa_info_init(int target_node, struct region_range *range) {
> +

checkpatch.pl complaints as below.

ERROR: open brace '{' following function definitions go on the next line
#82: FILE: samples/damon/mtier.c:40:
+static int numa_info_init(int target_node, struct region_range *range) {

> +	if (!node_online(target_node)) {
> +		pr_err("NUMA node %d is not online\n", target_node);
> +		return -EINVAL;
> +	}
> +
> +	/* TODO: Do we need to support more accurate region range?  */
> +	unsigned long start_pfn = node_start_pfn(target_node);
> +	unsigned long end_pfn   = node_end_pfn(target_node);
> +
> +	range->start = (phys_addr_t)start_pfn << PAGE_SHIFT;
> +	range->end  = (phys_addr_t)end_pfn << PAGE_SHIFT;

Let's use PHYS_PFN() instead.

> +
> +	return 0;
> +}
> +
>  static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  {
>  	struct damon_ctx *ctx;
> @@ -53,6 +63,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	struct damos *scheme;
>  	struct damos_quota_goal *quota_goal;
>  	struct damos_filter *filter;
> +	struct region_range addr;
>  
>  	ctx = damon_new_ctx();
>  	if (!ctx)
> @@ -82,9 +93,12 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	if (!target)
>  		goto free_out;
>  	damon_add_target(ctx, target);
> -	region = damon_new_region(
> -			promote ? node1_start_addr : node0_start_addr,
> -			promote ? node1_end_addr : node0_end_addr);
> +
> +	int ret = promote ? numa_info_init(1, &addr) : numa_info_init(0, &addr);
> +	if (ret)
> +		goto free_out;

Yet another checkpatch.pl complain.

WARNING: Missing a blank line after declarations
#119: FILE: samples/damon/mtier.c:98:
+       int ret = promote ? numa_info_init(1, &addr) : numa_info_init(0, &addr);
+       if (ret)

> +
> +	region = damon_new_region(addr.start, addr.end);
>  	if (!region)
>  		goto free_out;
>  	damon_add_region(region, target);
> -- 
> 2.34.1


Thanks,
SJ
