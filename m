Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD393B7759
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427441; cv=none; b=IUCDQNejWHSIOkZsU3wpAhE3+C4h0VtxFRqBLaFvtHTEeMRZXLZ4XsQilwbLhxy54SD3MJr54/gES/uWSkVNu/vGBqryAMLb8Z9HALrChD6X73Lkdv3KLVINApLTv2NLDSsI1vGb1jYdKxty6/+NQTFjdXhzogsWyviENmDvaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427441; c=relaxed/simple;
	bh=RtjW6gApa3Po8RM0j3sc1s0MN0vmoCVMf34WnHB+xR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0/jt5UDgndNJw/CZiXLfOR0jY7vQBi9AJYfZmoSdxF1SkMfD+Mzb+Pc1KZy4xxKwp+DttQofaKGfhvsVQRj32oQ1OI/hzhScbNyATbD+cpja7LsIbn/WJI9oYQjI2SN6moDoDCZQurdtt3MR2alFnleZoWt0mCelP+VzNawsu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBDc35jW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBDc35jW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1837461a91.2
        for <damon@lists.linux.dev>; Thu, 03 Sep 2026 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427433; x=1789032233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7qTGz8yA1h581X4DOr85MyyM+WIOFqQrYJ5cYnccTM=;
        b=aBDc35jWAe8K9nE+yLLiqK39+BNvrQZ91dHTrnZzor+UPD9v05zb2nweHi+8E+4EsP
         eaSQQkCxRLxddCHN5FdD5GySHbuv3L2jcjkECbtsH8ioiK7yZeYEl+tsgxo4myv0H3aY
         MVeRRfTXD3BKxn9SjDIpR2tJisMDOS4PGWxzsIPMcpfMCle01aV2PiDLmHqelNhKTTmN
         Ktvo6+U9zTllLozASSRwSG9/93+68e+bl7eK6qUoxDhE5jOjo71g0nEyB2sXz+ebEUot
         Xh2+eTAwthjG/BL1xc6cudqNxASveyh3XM5RPjXpZkyqINBpO3je65XqxDIIloMAnOlp
         gkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427433; x=1789032233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7qTGz8yA1h581X4DOr85MyyM+WIOFqQrYJ5cYnccTM=;
        b=AxzpTThagjUYmD+bgP59Y5/6lr3lvocs0t344pukied7cw9VTVj4DcbLNGmBNDqxK7
         LBjuOTcp3lnT5z2Vk7lxXjVbiym1OCHeGZ1CQVdmirFeOu4tV3zY93t3DKVo9/ciuRIW
         6DGmu7MJgrsFqAGiRP290C43vOeQkMUXhKN8HI6RLfMasum+QWh//bvfXkwF8JNoHMuh
         K31WGfLz74P3hij1yyfmJVMcRrqTS/5hrNLmWfoSFRIwRG6RSOoA5td/pCp/PG7X/Wc8
         3fRZse85ywiid3zE8JX9Wh86vMepJmqTo+oShJ966pRYtVhlOZM/kU31Q44NWnl9guGz
         SIrw==
X-Forwarded-Encrypted: i=1; AKwUvBzwx3EkXrqvnv0J1IDxYFh7s/VfZEBgZ+9xBMwhh9xC39gSQPksPyJ7oR/RP7lGkszCh4AAGA==@lists.linux.dev
X-Gm-Message-State: AFuF++kb1kX16DUU/ShSz7NgLg3+dZva4OFDKvggqg3Jp9yykq1Rgt79
	ZZXKJv5oKW/XwD4Y44RHZf0lxVbhaehSZRvWqKUdzNqY8ykwQDoBvxioWauqTYBOF8c=
X-Gm-Gg: AYBFou3fY9mZSfkNhj+PwBfzxTKKFOVfnkdASNBy1wDynpIxN1Gg49f0V0PqRIGl8IT
	5kGlFru7J5NgaU023FzOue+iezZvho/CoQJs4pI1Bwk5aTilXNxDIOdmgqXsJgPulUJld429ybQ
	DaQ2IF/SETlHvWM3L7ATPpAYaaCHdPH1Q8fSX+v/aa1mgVr6T4sR7RLsQc9LZjACS9Wi/2NGwD+
	yrNUnlIsD6Jg3V0jC1dPESvfBlq2XcMYcwdwsPnuSZXCxApEqfmhuusEl13cb3IoZvA0PEz9LM1
	6hW96IUYohc4eoEy5oqA/mo8ehl56FRsiZ9LLWrSyap5eW7J+2Wzq2dxJeJFV0XD0gSL4o77hEx
	/5s6U5PTuGeKAPuTDxZ8H98f+H44sxUQw3qoRQKO2khzjhus2encqrxSW8N2zuALtFf+/eNfQ4k
	HzGYIXhsRm+EtGH58Rz/CwiGCQCywYO3IhOQx7s5XASZhKjNBncgefnupb3wE=
X-Received: by 2002:a17:90b:2d4d:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39aee108918mr17835573a91.19.1788427432993;
        Thu, 03 Sep 2026 02:23:52 -0700 (PDT)
Received: from gmail.com ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccdecdsm2638527a91.2.2026.09.03.02.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:23:51 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: SJ Park <sj@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH 2/4] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Thu,  3 Sep 2026 17:23:33 +0800
Message-ID: <20260903092344.3079122-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902002725.108635-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 17:27:21 -0700 SJ Park <sj@kernel.org> wrote:

> When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> delta for the feedback loop is calculated using
> damos_quota_goal->last_psi_total.  However, it is initialized only after
> the first feedback loop.  The first iteration of the loop uses the
> uninitialized value.  As a result, the feedback loop can change the
> effective quota in an unexpected way at the first iteration.
> 
> The user impact of the issue is not big, because the issue impacts only
> the first iteration of the feedback loop.  The feedback loop also has an
> internal cap of the quota adjustment.  The wrong adjustment will soon be
> corrected over a few iterations.  For this reason, doing no
> initialization at commit time was intentional.  It is also explicitly
> commented.  That said, nobody likes behaviors that are unexpected or
> difficult to be expected.
> 
> Check last_psi_total initialization and skip the tuning round when it is
> not initialized.  For this, initialize last_psi_total with U64_MAX in
> the goal creation and the goal commit time.  U64_MAX means the field is
> not initialized.  The tuning round shows the value and adjusts it to
> guarantee the current quota is maintained for the round, and
> last_psi_total is correctly initialized on the next round.
> 
> Before this change, committing a new PSI goal on an existing PSI goal
> with goal-only DAMON sysfs command (commit_schemes_quota_goals) just
> worked.  After this change, the tuning round right after the commit will
> be unnecessarily skipped, because last_psi_total is unconditionally
> marked as not initialized in the damos_commit_quota_goal_union().  This
> is an intended tradeoff for simplicity.  Skipping just one round of
> tuning is no problem.  Meanwhile it makes both the code and the behavior
> simple to understand.
> 
> Also update the quota goal commit unit test for changed last_psi_total
> setup behavior.
> 
> The issue was discovered [1] by Sashiko.
> 
> [1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org
> 
> Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
> Cc: <stable@vger.kernel.org> # 6.9.x
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  mm/damon/core.c             | 13 +++++++++++--
>  mm/damon/tests/core-kunit.h |  9 +++------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0df785e72438f..20748b0a71026 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -636,6 +636,8 @@ struct damos_quota_goal *damos_new_quota_goal(
>  		return NULL;
>  	goal->metric = metric;
>  	goal->target_value = target_value;
> +	if (metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> +		goal->last_psi_total = U64_MAX;
>  	INIT_LIST_HEAD(&goal->list);
>  	return goal;
>  }
> @@ -1129,6 +1131,9 @@ static void damos_commit_quota_goal_union(
>  		struct damos_quota_goal *dst, struct damos_quota_goal *src)
>  {
>  	switch (dst->metric) {
> +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +		dst->last_psi_total = U64_MAX;
> +		break;
>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		dst->nid = src->nid;
> @@ -1150,7 +1155,6 @@ static void damos_commit_quota_goal(
>  	dst->target_value = src->target_value;
>  	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
>  		dst->current_value = src->current_value;
> -	/* keep last_psi_total as is, since it will be updated in next cycle */
>  	damos_commit_quota_goal_union(dst, src);
>  }
>  
> @@ -3039,7 +3043,12 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
>  		break;
>  	case DAMOS_QUOTA_SOME_MEM_PSI_US:
>  		now_psi_total = damos_get_some_mem_psi_total();
> -		goal->current_value = now_psi_total - goal->last_psi_total;
> +		/* uninitialized last_psi_total; make no effect this round */
> +		if (goal->last_psi_total == U64_MAX)
> +			goal->current_value = goal->target_value;
> +		else
> +			goal->current_value = now_psi_total -
> +				goal->last_psi_total;
>  		goal->last_psi_total = now_psi_total;
>  		break;
>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index f1e11548c771b..af26b3d60957b 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
> @@ -757,19 +757,16 @@ static void damos_test_commit_quota_goal_for(struct kunit *test,
>  		struct damos_quota_goal *dst,
>  		struct damos_quota_goal *src)
>  {
> -	u64 dst_last_psi_total = 0;
> -
> -	if (dst->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> -		dst_last_psi_total = dst->last_psi_total;
>  	damos_commit_quota_goal(dst, src);
>  
>  	KUNIT_EXPECT_EQ(test, dst->metric, src->metric);
>  	KUNIT_EXPECT_EQ(test, dst->target_value, src->target_value);
>  	if (src->metric == DAMOS_QUOTA_USER_INPUT)
>  		KUNIT_EXPECT_EQ(test, dst->current_value, src->current_value);
> -	if (dst_last_psi_total && src->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
> -		KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);
>  	switch (dst->metric) {
> +	case DAMOS_QUOTA_SOME_MEM_PSI_US:
> +		KUNIT_EXPECT_EQ(test, dst->last_psi_total, U64_MAX);
> +		break;

The U64_MAX sentinel approach looks correct to me.

In the first feedback iteration, setting `current_value` to `target_value`
gives the PSI goal a score of 10000, so the uninitialized PSI delta does
not affect the quota score. The current PSI total is then recorded,
allowing subsequent iterations to calculate the delta normally.

I also checked the commit path: the PSI goal is reset to U64_MAX when
committed, which intentionally skips one tuning round when replacing an
existing PSI goal.

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>  	case DAMOS_QUOTA_NODE_MEM_USED_BP:
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
> -- 
> 2.47.3
> 

Sent using hkml (https://github.com/sjp38/hackermail)
