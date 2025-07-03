Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1962C239099;
	Thu,  3 Jul 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561560; cv=none; b=pXo0+RP5a8TmznibNmQRXCHcKusU8NCw6RYVvbBi3fMzdjp3cY/otVRQFHV3fk9LMWQI2lKzeibomhFgnrTR7YUUzQ6xetJ5NC+lKEWKi36SRCZA8fIVrQnqRa+Z0xIFrEBzyKLqi54KxC9vPtm0M+A6mdnAaWQiAWTg8gMmrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561560; c=relaxed/simple;
	bh=FXncib9IFgDGC6K+cesVYMgwW7vQ5WoISOE2fNWV3IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z4wPPrlBmjNSutCLawL50WuI3tr/Augwhz2jCpZ2XNsQu3tCEF+qLyniKiNnIPgU+GAbI+FxeoRHSkmPeACnqLKu4ZLYzXbsKLV4FvxxqIKlihCcHXeWchXaBVhFp305bIspTwTZOycaD2Xj/FesVjcChVbPk3Q2Z1QU/Edvme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbjkl3By; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbjkl3By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD95C4CEE3;
	Thu,  3 Jul 2025 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751561559;
	bh=FXncib9IFgDGC6K+cesVYMgwW7vQ5WoISOE2fNWV3IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sbjkl3ByTogVRPsjQQTSV0b3uGmpTx9m3ntm9CmonxC6waeVZ5pTSvBUvbIXzmfVX
	 YOQVuSqCrkPGSZb+uV4wDDUQ/1NZxGW4buP5zLyy9CY8ovX7QfgVbs9ud+XRK4bIxH
	 KADW1gDQjW7syUY6MXnnLyMwLA5M0MRYOwcMVOxp7pbs+X69f57Y0fWLwZTgsscMra
	 RL8eraCK0bKLPjZwm1TRHyOfNNfMv+trhhX7Kl6Gow7AC52HsdCJGFQzVSUOwSKdzw
	 uA//VZ2g/vSUdbQZGYVOl2pG+vXhNGTnGhfkDjxie/5jU/UGQCY45Oxs4QCUrxjD27
	 +qkraSVIRv4ag==
From: SeongJae Park <sj@kernel.org>
To: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH v2] samples/damon: support automatic node address detection
Date: Thu,  3 Jul 2025 09:52:37 -0700
Message-Id: <20250703165237.43771-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703074423.1771-1-yunjeong.mun@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yunjeong,

On Thu,  3 Jul 2025 16:44:22 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:

> This patch adds a new knob `detect_node_addresses`, which determines
> whether the physical address range is set manually using the existing
> knobs or automatically by the mtier module. When `detect_node_addresses`
> set to 'Y', mtier automatically converts node0 and node1 to their
> physical addresses. If set to 'N', it uses the existing
> 'node#_start_addr' and 'node#_end_addr' to define regions as before.

Thank you for this patch!

> 
> Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---

From next time, please consider adding a summary of what changes have made from
the previous version here, like suggested[1] on the documentation.

>  samples/damon/mtier.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index f3220d6e6739..3570ebe10fab 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -42,8 +42,34 @@ static bool enable __read_mostly;
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
> +	if (!node_online(target_node)) {
> +		pr_err("NUMA node %d is not online\n", target_node);
> +		return -EINVAL;
> +	}
> +
> +	/* TODO: Do we need to support more accurate region range?  */

I understand you are saying we might need to remove address ranges in the node
that DAMON will anyway unable to check accesses, e.g., reserved memory.  Since
those are uusally only a small portion and this is a sample code, I think we
don't really need to do that, so I think you can drop this TODO comment from
your next version, if you are gonna make it.

> +	unsigned long start_pfn = node_start_pfn(target_node);
> +	unsigned long end_pfn   = node_end_pfn(target_node);
> +
> +	range->start = PFN_PHYS(start_pfn);
> +	range->end  = PFN_PHYS(end_pfn);
> +
> +	return 0;
> +}
[...]

[1] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ
