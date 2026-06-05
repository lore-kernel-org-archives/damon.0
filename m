Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572740E8FD;
	Fri,  5 Jun 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668975; cv=none; b=im1sBTXaze7MFHKqCxHSemG6f808HV+mGAZIGsx/CGK0m/Re7ZIfr3u34KpD452zQiv+avVXmPYHcwIRzOM5K9A7gLNVUnmb8A2V0m2PGWDdRUQ0jqSGaXataNPKbRAsO+JWLIHf9Fsym4D8xwZi10ZBhGOzeGFG3K42Fxouz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668975; c=relaxed/simple;
	bh=+EvO1PUhMdZJPq7wNkkhEHzNs/1H1UxD2/HOUYFH0VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nnCyM1CXzWQTFgY6DKth4RaBGXDJt3EDwQzyVhNEnOVh+8fk2DUnKTyCt/JGA1djkbE23t4BVc3ya7haBfVM2ADFep9wOCYXK4hCRL476/X8z+b5ux+tFLZmCUSERRkc2vWjwecekyObba3fKqH+279bmqu0dinZ5u6F89uRJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gX3Pw1gwhzJ46DT;
	Fri,  5 Jun 2026 22:16:04 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 83E8B4058D;
	Fri,  5 Jun 2026 22:16:09 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Jun 2026 17:16:09 +0300
Message-ID: <87e5f21b-34ba-41a5-9b04-a4c420e85bd9@huawei-partners.com>
Date: Fri, 5 Jun 2026 17:16:08 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/4] mm/damon: introduce DAMON_HUGEPAGE for hot
 region hugepage collapsing
To: <sashiko-reviews@lists.linux.dev>
CC: <damon@lists.linux.dev>
References: <20260604150338.501128-4-gutierrez.asier@huawei-partners.com>
 <20260604154137.2E4EE1F00893@smtp.kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260604154137.2E4EE1F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 6/4/2026 6:41 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in damon_hugepage_apply_parameters() can lead to a division by zero kernel panic.
> - [High] Writing to the enabled sysfs node or passing it as a load parameter before module_init finishes causes an immediate NULL pointer dereference.
> - [High] The sysfs parameter addr_unit can be set to ULONG_MAX, leading to an integer overflow in the ALIGN macro and a division by zero kernel panic.
> - [Medium] Misuse of ALIGN() produces a non-power-of-two min_region_sz, silently breaking the monitoring daemon.
> - [Low] The addr_unit module parameter is exposed and documented for address translation, but is entirely ignored by VADDR operations.
> --
> 
> commit 3617a4956285835faa63e992e7cc7a6aa7cb4d8d
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
> 
> This patch introduces a new DAMON module (SAMPLE_DAMON_HUGEPAGE)
> which collapses hot regions into huge pages.
> 
> SAMPLE_DAMON_HUGEPAGE operates in the virtual memory space, for a
> specific task. The user is expected to supply the PID of the task
> that is going to be monitored through the monitored_pid module
> variable.
> 
> SAMPLE_DAMON_HUGEPAGE uses the hugepage auto-tune mechanism to
> increase or decrease the aggressiveness of page collapsing. User
> autotuning is also available for additional tuning aggressiveness
> control.
> 
> The module also includes changes to the DAMON compilation, so that
> the module can be enabled or disabled.
> 
>> diff --git a/samples/damon/hugepage.c b/samples/damon/hugepage.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/samples/damon/hugepage.c
>> @@ -0,0 +1,350 @@
> [ ... ]
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
> [Severity: High]
> Since damon_hugepage_mon_attrs.aggr_interval is a module parameter that can be
> modified concurrently without locks, could it be set to zero exactly between
> the zero-check in damon_hugepage_apply_parameters() and this division?
> 
> If a privileged user writes 0 to the sysfs node in that time window, it would
> trigger a division by zero kernel panic.
Changes to the modules should always be made using the commit parameter.
>> +		.max_age_region = UINT_MAX,
>> +	};
>> +
>> +	return damon_new_scheme(
> [ ... ]
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
>> +    // align power of two
>> +	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / ALIGN(addr_unit, 2), 1);
> 
> [Severity: High]
> Does this ALIGN() macro expose us to an integer overflow if a user sets
> addr_unit to ULONG_MAX?
> 
> The macro adds (2 - 1) before masking, which would overflow ULONG_MAX to 0,
> making the evaluation 0. This leads to a division by zero panic on
> DAMON_MIN_REGION_SZ / 0.
> 
> [Severity: Medium]
> Will this ALIGN(addr_unit, 2) calculation produce a non-power-of-two result
> if addr_unit is set to a value like 6?
> 
> ALIGN(6, 2) evaluates to 6, and damon_commit_ctx() strictly requires
> min_region_sz to be a power of two. If it isn't, damon_commit_ctx()
> returns -EINVAL and flags the context as maybe_corrupted, which silently
> terminates the kdamond background thread.
> 
> Should this use roundup_pow_of_two() instead?
Since VADDR doesn't use addr_unit, I will just simplify this line
in the next RFC patch.
>> +
>> +	spid = find_get_pid(monitored_pid);
> [ ... ]
>> +static const struct kernel_param_ops addr_unit_param_ops = {
>> +	.set = damon_hugepage_addr_unit_store,
>> +	.get = param_get_ulong,
>> +};
>> +
>> +module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
>> +MODULE_PARM_DESC(addr_unit,
>> +	"Scale factor for DAMON_HUGEPAGE to ops address conversion (default: 1)");
> 
> [Severity: Low]
> Is this parameter accurately described for VADDR operations?
> 
> The DAMON core explicitly ignores addr_unit for VADDR operations. Exposing
> this parameter does not scale addresses as documented, but it does improperly
> shrink the byte-granularity of min_region_sz, creating a misleading user API.
I will remove addr_unit.
>> +
>> +static int damon_hugepage_enabled_store(const char *val,
>> +				const struct kernel_param *kp)
>> +{
>> +	bool is_enabled = enabled;
>> +	bool enable;
>> +	int err;
>> +
>> +	err = kstrtobool(val, &enable);
>> +	if (err)
>> +		return err;
>> +
>> +	if (is_enabled == enable)
>> +		return 0;
>> +
>> +	/* Monitored process may have exited. In that case, ctx->kdamon is set */
>> +	/* to NULL. If enabled is set to 'off' through sysfs, we just set the  */
>> +	/* params and exit */
>> +	if (!damon_is_running(ctx) && !enable)
> 
> [Severity: High]
> Can this crash on boot or module load?
> 
> If the parameter damon_hugepage.enabled=Y is passed at boot or module load,
> this store callback executes before the module's init function runs. Because
> the init function hasn't run, the global ctx pointer is NULL here.
> 
> The left-hand side of the condition calls damon_is_running(ctx), which
> unconditionally dereferences the NULL pointer at mutex_lock(&ctx->kdamond_lock),
> causing a kernel panic.
This is a sample module. It's not meant to be started at boot time.
>> +		goto set_param_out;
>> +
>> +	/* Called before init function.  The function will handle this. */
>> +	if (!damon_initialized())
>> +		goto set_param_out;
> 

-- 
Asier Gutierrez
Huawei

