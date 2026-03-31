Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151D3FEB20
	for <damon@lists.linux.dev>; Tue, 31 Mar 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969214; cv=none; b=gsa4T257MBZelkPMSpyjKc0SYouuE7pc6RnikrQ139fwSUk8xc9Hon5f0MsToT68kSqmWd8MJarkQXiYGzofeMep+RTV0ho2/3M4lhk08UmPjTQNdjrb+NeJOOvy8PI2JJd7F4Gz6XK/xnxfEiCkfRVeLs8YbLUUCMxZ2U6UhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969214; c=relaxed/simple;
	bh=opaHL4swGOEZano7r3/TcQh2cE9yH7TW36780Mdj7MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqEdYKuDRVtOAL+2XWj/MP9IWJdFtnD6SjCNi70g0gzzMU4REVLGJca/NtLZv8598UtNW6Kg9UwKuT4h27gR8gRILV4++iyiQjJN2TWsBmDp++W62I/GCcoXWKX57+lszJGIqIzn3Vbp+4j74aGmqLKY7OUBRuuqKWjxCLNucsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKCd//84; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKCd//84"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so2871335b3a.1
        for <damon@lists.linux.dev>; Tue, 31 Mar 2026 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774969212; x=1775574012; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLLxzw5GoGg/yFRLXTVGHHzH2KjcxDISY31IWyrVnzg=;
        b=UKCd//84+DlBuwgK1g3aBWegX8dVfio0mK/4INTa6jFs20B8kBALXNpORk8ePZ8htb
         F6GL0yr1OxEM4LNbi3yNslWYJyBN4mXx9cIZlE+H0IdoN8wndwFdRbj6EVy+EmEmKJia
         TVf+ODkxxG+Z5Lj8zVbjKFvsLT5gVw7pOvJnTYMlL3AH+Tgs9+yXrgXwjjyZg3vLlyVF
         LDTYj4XPAIu9Wlk9p9baHzJyKh9rxuLf3bs+ns1ZE7tdduKHgTTbfZiNNyUsSpQidu8d
         fB2g6e2m5IaI70BZgW7gRKyBQJXnbJ/THk2trLLJBcRxeggt2/wUX9HLbtjYUsNmCCyG
         t65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774969212; x=1775574012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLLxzw5GoGg/yFRLXTVGHHzH2KjcxDISY31IWyrVnzg=;
        b=sI28FTQqxLF48JYlYJ1ENYezYdx8RyFePiv1JuYB/NiLNHYaFsOs/wS8nIE79gBBRI
         207uRBdPkuS+P6zeQVUBB1L+Qb+IHF5j/n3cEwV5p+wZRRK7jOYTPkXshW0NEHJW/r8N
         x1mi5N1TBxTpL89qMRlwuv4MjEJndJhnb8XJkKDA3TLtrnRqu8Cxi//uBndtl04GFVZW
         mGk1z9/WdOixTFnyyMctEijpcc7+BaLKQuEGcvFl6ggL2ZqrAqgpyqc7r1/oD9VWtQkQ
         uVXi5M1ffx6Tg2DDfYbGmWU//2GQA0pOjrmloDZJviyVSRPVXnfZ9GGKcuP5vAXNjSrY
         D5yw==
X-Gm-Message-State: AOJu0Ywb73s22PBuaDpkuR39YeqfeQvBWFHqMNjMfWQ5I0Ge+sIjrx+B
	gT6nhftV67K6xLZgRzKeG6p6FZVNS8bw3b2FmeNs7gdP51XOXF1KJglO
X-Gm-Gg: ATEYQzyBjosVHiqnOUHGwFasxLdLibQexSCGnKopgNAMSsbEpwcnL6f5CmDv+RxsWN2
	Uu07C0ydSqDjffqgj5sryO+Jp2NdHJzpagLNZuJV8jlQAFNMDDvzTNzkuw/KrtaNm55/MPZoVgR
	Lkmgn/qeQ5v/bUHvdXJeKx6ups+c5i5DPZLnkb2vh6n+kvl6R01FZzXpf5bSkkfXvEMQy1Rnwu/
	TNSEmzfkrT0ox42Tfr+xRW4C6iWGuWbP8biCbjCn5wD44g5RxDbOZOCluAwB2en8WpLgaOIiSNh
	adpt8Undt1uT+IBc7OcypQWe/U5+LfQVE+Cp5Fd7YFHwl+I2nHZhrgFQqhObnrVHap8u8aWYYHK
	8YDs0MxLHQQXaHZLMH4IkUGu14z4VQEsvsR4Es63LBfdqYDo2JB8P6rG7r9yhrJc5RlnVOMod1c
	/S2SRENkgSArZT84OzfaftZHiP4xrx6Mc9ezY+Na05nRvugavL3EA=
X-Received: by 2002:a05:6a00:2345:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-82c95eba347mr16752033b3a.22.1774969210580;
        Tue, 31 Mar 2026 08:00:10 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdf219c17sm2141792b3a.49.2026.03.31.08.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:00:10 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH] mm/damon: validate min_region_size to be power of 2
Date: Tue, 31 Mar 2026 23:00:09 +0800
Message-ID: <20260331150009.5014-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331073231.30060-1-aethernet65535@gmail.com>
References: <20260331073231.30060-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260331073231.30060-1-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 883916ab04d9fc6b9074dcd36200cd14402cc8fb
Author: Liew Rui Yan <aethernet65535@gmail.com>
mm/damon: validate min_region_size to be power of 2

This patch adds checks to ensure that min_region_sz is a power of 2 in
damon_lru_sort_apply_parameters() and damon_reclaim_apply_parameters().
If the value is not a power of 2, it returns -EINVAL immediately to
prevent kdamond from terminating unexpectedly.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d72976..205592194efd 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -294,6 +294,9 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz))
> +		return -EINVAL;
> +

Does this code leak the allocated param_ctx?

Looking earlier in damon_lru_sort_apply_parameters(), param_ctx is allocated
via damon_modules_new_paddr_ctx_target(). The existing error paths below
this check use a goto out; to ensure damon_destroy_ctx(param_ctx) is called.

By returning directly here, does it skip freeing param_ctx?

>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err = -EINVAL;
>  		goto out;

[ ... ]

> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index 86da14778658..6e29d92670c4 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -204,6 +204,9 @@ static int damon_reclaim_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz))
> +		return -EINVAL;
> +

Can this result in a similar leak in the reclaim path?

Like the previous file, param_ctx is allocated earlier in this function
and there is an out label that handles cleaning up the context. Could this
be changed to set err = -EINVAL; and goto out; instead of returning directly?

>  	if (!damon_reclaim_mon_attrs.aggr_interval) {
>  		err = -EINVAL;
>  		goto out;


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260331073231.30060-1-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260331073231.30060-1-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail
