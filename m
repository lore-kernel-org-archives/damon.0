Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211D3DE45B;
	Mon,  4 May 2026 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904988; cv=none; b=ugtZVSWWMRPCXB+UU5RcK4Wh3h8dHP7Nrpu4z+1KXd2fJRY241F5JYsaHCpQUDsKfX5vvY3rRScwINGLmY+ysdFK0Jcy8MsyjzSwFg/rvLGBU9NWzeJIV04fOiuaYYiLFVgG3yhiCiDRhkwwwXJxE2x8HHDLsPRMw2NQoiFwfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904988; c=relaxed/simple;
	bh=RWPpvvTVRyYs7jhXekMKoLTBM8/LmmD2tjP809kwXwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qNjqhEQA86BjEmgnp6t6wxZk0sJ7AI0HYa7oQh/SC1O/of0FJejik/NohTCN+Bsk7tC1u2Ll2BPePBsBFdVao2N+5y7MV0THPrY4vg+KlpnD3RFg6qHcLiN2d3lSzgXlGH9vVKm7M4O8344EOLCqhWdx/0GrXtAySP0AdVnad6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g8PD825zxzJ46BB;
	Mon,  4 May 2026 22:29:28 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 30DA440575;
	Mon,  4 May 2026 22:29:42 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 May 2026 17:29:41 +0300
Message-ID: <847e0e8a-42a8-40b5-a713-d0737c5421e3@huawei-partners.com>
Date: Mon, 4 May 2026 17:29:40 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
To: <sashiko@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260430134139.2446417-4-gutierrez.asier@huawei-partners.com>
 <20260430154338.E22E6C2BCB3@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260430154338.E22E6C2BCB3@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 4/30/2026 6:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Silent failure and invalid state when target PID is not found.
> - [High] TOCTOU race condition on `aggr_interval` leading to divide-by-zero kernel panic.
> - [Medium] Memory leak of DAMON context upon module initialization failure.
> --
> 
> commit 982630eef231c8c59229da1208ed3240bf24f081
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
> 
> This patch introduces a new DAMON module (DAMON_HUGEPAGE)
> which collapses hot regions into huge pages.
> 
>> diff --git a/mm/damon/hugepage.c b/mm/damon/hugepage.c
>> new file mode 100644
>> index 0000000000000..02729736dc560
>> --- /dev/null
>> +++ b/mm/damon/hugepage.c
> 
> [ ... ]
> 
>> +static struct damos *damon_hugepage_new_scheme(void)
>> +{
>> +	struct damos_access_pattern pattern = {
>> +		/* Find regions having PMD_SIZE or larger size */
>> +		.min_sz_region = PMD_SIZE,
>> +		.max_sz_region = ULONG_MAX,
>> +		.min_nr_accesses = 0,
>> +		.max_nr_accesses = UINT_MAX,
>> +		.min_age_region = min_age /
>> +			damon_hugepage_mon_attrs.aggr_interval,
> 
> Is there a race condition here? Since damon_hugepage_mon_attrs is exposed
> as a module parameter, aggr_interval could be modified locklessly. If it is
> set to 0 concurrently between the check in damon_hugepage_apply_parameters()
> and this division, could it trigger a divide-by-zero kernel panic?
No, damon_hugepage_apply_parameters is called only when the module starts
or when a new change is committed by the user. The user first changes
the value and then commit the change.
> 
>> +		.max_age_region = UINT_MAX,
>> +	};
>> +
>> +	return damon_new_scheme(
>> +		&pattern,
>> +		/* synchrounous partial collapse as soon as found */
>> +		DAMOS_HUGEPAGE, 0,
>> +		/* under the quota. */
>> +		&damon_hugepage_quota,
>> +		&(struct damos_watermarks){}, NUMA_NO_NODE);
>> +}
>> +
>> +static int damon_hugepage_apply_parameters(void)
>> +{
>> +	struct damon_ctx *param_ctx;
>> +	struct damon_target *param_target;
>> +	struct damos *scheme;
>> +	struct damos_quota_goal *goal;
>> +	struct pid *spid;
>> +	int err;
>> +
>> +	err = damon_modules_new_vaddr_ctx_target(&param_ctx, &param_target);
>> +	if (err)
>> +		return err;
>> +
>> +	param_ctx->addr_unit = addr_unit;
>> +	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>> +
>> +	spid = find_get_pid(monitored_pid);
>> +	if (!spid)
>> +		goto out;
> 
> Does this silently return success when the monitored PID is not found?
> 
> Because err is 0 from the successful context creation above, jumping
> to the out label returns 0.
> 
> This would cause DAMON to start with an empty context without informing
> the user that their configuration failed.

Good catch. I will handle this case.

>> +
>> +	param_target->pid = spid;
>> +
>> +	if (!damon_hugepage_mon_attrs.aggr_interval) {
>> +		err = -EINVAL;
>> +		goto out;
>> +	}
> 
> [ ... ]
> 
>> +static int __init damon_hugepage_init(void)
>> +{
>> +	int err;
>> +
>> +	if (!damon_initialized()) {
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
>> +	err = damon_modules_new_vaddr_ctx_target(&ctx, &target);
>> +	if (err)
>> +		goto out;
>> +
>> +	call_control.data = ctx;
>> +
>> +	/* 'enabled' has set before this function, probably via command line */
>> +	if (enabled)
>> +		err = damon_hugepage_turn(true);
>> +
>> +out:
>> +	if (err && enabled)
>> +		enabled = false;
>> +	return err;
>> +}
> 
> Does this code leak the allocated ctx and target if damon_hugepage_turn()
> fails?
> 
> Because module initialization failure prevents the module exit routine
> from running, it seems damon_destroy_ctx() should be called in the error
> path to avoid a memory leak.
> 
The code is correct. In case of initialization failure, we just mark the
module as "non running" and exit.

-- 
Asier Gutierrez
Huawei

