Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29B2C234A
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022463; cv=none; b=Ibx7EHEKxBcuJLaS8IFRM0JcymQgwVdOM3XlAJPdD24mTZWa+Qb5wQuzpcjUzX+VZjzrRG3zgq6HE8KqbMDUHRsBiX0KmHNxo4BpXmhw+f0i3hYEXA4JNVxkeJVe+nSI94EbAX+2Spqm9s0sVcXiwnbtmO7o5xMeTVVQ+y8d0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022463; c=relaxed/simple;
	bh=3mdYeXu905skC/89gw8l55UiEcSVhPp295JiaoTe1Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feLEBRpbr92WYmv6GeeWibNk0XgRJz+RPFOsBVQluD/qN7zp0pj97G1ejUM/viac2HsLA9Tz5+/QoCbFKT/ksv6d4MR54MT9hshJBrC3miGclHV3t940hfB5F6nkV1lkfADqJWL14dKQsyn1W8x5nScukDBE9MWspzNps6Ma+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyAFRhvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyAFRhvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483FE1F000E9;
	Thu,  2 Jul 2026 20:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022460;
	bh=s1O7yxhZA4uvwDJ7tfSidpqHooCz3PzvrPr8bHBzeY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SyAFRhvlIwWuXxtyW+DsYxsCGfICLywCNwisc9/R05DvJtWpdXfO+V6YaT9UJRYS5
	 7yqczLFVhUoBa3jiKUac4MKkaeZf2UzyH8UGuiY6lH4K7GojUiUjy52dxu2T58nvUv
	 F29DoDuvn9S0r+/qz6nm46ufYGH4dVO2Rh1Bgnb/wOCU8US+ZbyyaEYxUl3KSW3UmI
	 pw1ldkWPvsljqcBZZC0J3dnyowVHxs9de1m61hnMxMTbcuV/P8WLw8TjWCl/3c/Nu3
	 LOJSd/23nPnoB6lKTFsxrkKyWp/djcFqpEZmQ2cg3+4P3FYEd/kGlCqYkP3hnrkX/t
	 lCsfBmpVPRnuw==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: Re: [RESEND RFC PATCH v2 4/5] mm/damon: introduce DAMOS_SPLIT action
Date: Thu,  2 Jul 2026 13:00:44 -0700
Message-ID: <20260702200045.92126-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702094633.75658-5-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 17:46:32 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Add DAMOS_SPLIT to the damos_action enum for splitting large folios
> into smaller mTHP-order folios.  Add a target_order field to struct
> damos to specify the desired split order.

This commit is not adding but reusing the field.

> 
> Expose the action as "split" through the DAMON sysfs interface with
> target_order validation (must be 2..HPAGE_PMD_ORDER-1).
> 
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.wang@processmission.com>

Let's have only one S-o-b: line if there is no reason to have two.

> ---
>  include/linux/damon.h    |  9 +++++++--
>  mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 5a0587556573..30cf4afb212c 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -121,6 +121,7 @@ struct damon_target {
>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>   * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
> + * @DAMOS_SPLIT:	Split large folios to the target mTHP order.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
>   * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
> @@ -141,6 +142,7 @@ enum damos_action {
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
>  	DAMOS_COLLAPSE,
> +	DAMOS_SPLIT,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,
> @@ -573,8 +575,11 @@ struct damos {
>  	struct damos_access_pattern pattern;
>  	enum damos_action action;
>  	/*
> -	 * @target_order: target order for mTHP actions (DAMOS_COLLAPSE).
> -	 * 0 means system default (PMD order).  Valid: 0, 2..HPAGE_PMD_ORDER.
> +	 * @target_order: target mTHP order for DAMOS_COLLAPSE and
> +	 * DAMOS_SPLIT.  For COLLAPSE, 0 means PMD order default,
> +	 * valid values: 0, 2..HPAGE_PMD_ORDER.  For SPLIT,
> +	 * valid values: 2..HPAGE_PMD_ORDER-1; 0 and HPAGE_PMD_ORDER
> +	 * are rejected at scheme creation time (defaulting to 2).
>  	 */
>  	unsigned int target_order;

As I commented to an earlier patch, let's use the union.

>  	unsigned long apply_interval_us;
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 7dcd582ded86..84a4617ca3d3 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2293,6 +2293,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
>  		.action = DAMOS_COLLAPSE,
>  		.name = "collapse",
>  	},
> +	{
> +		.action = DAMOS_SPLIT,
> +		.name = "split",
> +	},
>  	{
>  		.action = DAMOS_LRU_PRIO,
>  		.name = "lru_prio",
> @@ -3058,11 +3062,23 @@ static struct damos *damon_sysfs_mk_scheme(
>  			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
>  		target_order = 0;
>  	}
> +	if (sysfs_scheme->action == DAMOS_SPLIT &&
> +	    (target_order == 0 ||
> +	     target_order >= HPAGE_PMD_ORDER)) {
> +		pr_warn("DAMON split: target_order %u invalid, need 2..%u. Defaulting to 2.\n",
> +			target_order,
> +			HPAGE_PMD_ORDER - 1);
> +		target_order = 2;
> +	}

As I also commented to an earlier patch, this validation will eventually
dropped.

>  #else
>  	if (sysfs_scheme->action == DAMOS_COLLAPSE && target_order != 0) {
>  		pr_warn("DAMON collapse: target_order not supported without THP. Use 0.\n");
>  		target_order = 0;
>  	}
> +	if (sysfs_scheme->action == DAMOS_SPLIT) {
> +		pr_warn("DAMON split: not supported without THP.\n");
> +		target_order = 2;

Why set target_order here?

> +	}
>  #endif
>  	scheme->target_order = target_order;


Thanks,
SJ
