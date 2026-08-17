Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0ED440A1A
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974605; cv=none; b=LDTFtgvCI+3T+Q8j7yt/0rxFc84eeSODhNkM/q6gj9L5LNoqiPAk0VDkgs2c87WhsD3zIbGBYFdusJtG9lERNkHBv0SkTgNWzrk1e25tWA5j4yCMluy3UAg0EwbCbj7tW1JVgilR6ODCl0oDrtSLZ+cPSuSV36xZGjTRw7l6Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974605; c=relaxed/simple;
	bh=B0co/0rScDaRr0gBu18BkztdeCpkaTGcypUvZSgpMCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JQM6t8HZmEb0HYCfx4JgeEYjyi+t61iWGvU2MjjYBxpJLl4+GnLfe0MtTbRvySZ4aZ2X+OqD9ES/dfi/zzyTaCrC8jc+nEAN8sXeC0IyjpXjiSYQl5xf/c5svT0Lszmbk1MMh2igi3UMTZHT3jZWxcRaK5DCAtGCiWzRrj1YSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=ad5DWPZN; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="ad5DWPZN"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b/Sge/HEaRHrAnq6gNY9Urt58pOU9P34p0y2R0WVaEE=;
	b=ad5DWPZN3XAbiYxp7mTiS9vw22QA2QbQ/CsFhV52wvnlImJKGoN7CzDhWbtFj0LJJis75hoLt
	H9DvtZ9d4jEsbmjFmeny8iTNN0bZhyFws0odThksdMKabfPRuUnB/xIK4M1eiDJqCNtaTwDrg9T
	mDDLsS5EZaLKv0rv8XalUQg=
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hNvMn1ngmzJ46F6;
	Mon, 17 Aug 2026 21:49:41 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 146BB40575;
	Mon, 17 Aug 2026 21:49:46 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 16:49:45 +0300
Message-ID: <dc075f92-2291-49f0-8f89-01b2ffb7fd82@huawei-partners.com>
Date: Mon, 17 Aug 2026 16:49:45 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/core: introduce damon_set_target_pid()
To: Enze Li <lienze@kylinos.cn>, <sj@kernel.org>, <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <enze.li@gmx.com>
References: <20260817125319.888994-1-lienze@kylinos.cn>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260817125319.888994-1-lienze@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi Enze,

On 8/17/2026 3:53 PM, Enze Li wrote:
> The logic that finds the struct pid for a given pid number and assigns
> it to a damon_target is duplicated in multiple places.  Including
> damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
> of the two sample modules, samples/damon/wsse.c and
> samples/damon/prcl.c.  Add a function that does the work, and replace
> the duplicated code in the places with calls to the function.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 12 ++++++++++++
>  mm/damon/sysfs.c      |  6 ++----
>  samples/damon/prcl.c  |  5 +----
>  samples/damon/wsse.c  |  5 +----
>  5 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 0c8b7ddef9ab..a937aa55170b 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -1054,6 +1054,7 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
>  
>  struct damon_target *damon_new_target(void);
>  void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
> +int damon_set_target_pid(struct damon_target *t, int pid);
>  bool damon_targets_empty(struct damon_ctx *ctx);
>  void damon_free_target(struct damon_target *t);
>  void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a1656..82b196407ae8 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/kthread.h>
>  #include <linux/memcontrol.h>
>  #include <linux/mm.h>
> +#include <linux/pid.h>
>  #include <linux/psi.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -795,6 +796,17 @@ void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
>  	list_add_tail(&t->list, &ctx->adaptive_targets);
>  }
>  
> +/*
> + * Assign the struct pid of the given pid number to the given target.
> + */
This method is simple enough. Do we really need a comment?
> +int damon_set_target_pid(struct damon_target *t, int pid)
> +{
> +	t->pid = find_get_pid(pid);
> +	if (!t->pid)
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  bool damon_targets_empty(struct damon_ctx *ctx)
>  {
>  	return list_empty(&ctx->adaptive_targets);
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index e3858ffab4b2..3c81b4c91ac0 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -3,7 +3,6 @@
>   * DAMON sysfs Interface
>   */
>  
> -#include <linux/pid.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  
> @@ -2035,9 +2034,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
>  		return -ENOMEM;
>  	damon_add_target(ctx, t);
>  	if (damon_target_has_pid(ctx)) {
> -		t->pid = find_get_pid(sys_target->pid);
> -		if (!t->pid)
> -			/* caller will destroy targets */
> +		/* caller will destroy targets */
> +		if (damon_set_target_pid(t, sys_target->pid))
>  			return -EINVAL;
>  	}
>  	t->obsolete = sys_target->obsolete;
> diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
> index 842099bd6228..83ddf12811d5 100644
> --- a/samples/damon/prcl.c
> +++ b/samples/damon/prcl.c
> @@ -32,7 +32,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
>  MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_PRCL");
>  
>  static struct damon_ctx *ctx;
> -static struct pid *target_pidp;
>  
>  static int damon_sample_prcl_repeat_call_fn(void *data)
>  {
> @@ -79,12 +78,10 @@ static int damon_sample_prcl_start(void)
>  		return -ENOMEM;
>  	}
>  	damon_add_target(ctx, target);
> -	target_pidp = find_get_pid(target_pid);
> -	if (!target_pidp) {
> +	if (damon_set_target_pid(target, target_pid)) {
>  		damon_destroy_ctx(ctx);
>  		return -EINVAL;
>  	}
> -	target->pid = target_pidp;
>  
>  	scheme = damon_new_scheme(
>  			&(struct damos_access_pattern) {
> diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
> index 37fd5da20158..53944aea8428 100644
> --- a/samples/damon/wsse.c
> +++ b/samples/damon/wsse.c
> @@ -33,7 +33,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
>  MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_WSSE");
>  
>  static struct damon_ctx *ctx;
> -static struct pid *target_pidp;
>  
>  static int damon_sample_wsse_repeat_call_fn(void *data)
>  {
> @@ -79,12 +78,10 @@ static int damon_sample_wsse_start(void)
>  		return -ENOMEM;
>  	}
>  	damon_add_target(ctx, target);
> -	target_pidp = find_get_pid(target_pid);
> -	if (!target_pidp) {
> +	if (damon_set_target_pid(target, target_pid)) {
>  		damon_destroy_ctx(ctx);
>  		return -EINVAL;
>  	}
> -	target->pid = target_pidp;
>  
>  	err = damon_start(&ctx, 1, true);
>  	if (err) {

Otherwise, it looks like a nice patch.

-- 
Asier Gutierrez
Huawei

