Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390F1B6D08;
	Wed, 17 Jun 2026 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781669099; cv=none; b=bF3ExIPJcWhkOTEMncuLv6ozkQpVxdzKEb3pkgLZ7oqLeGnzMyY06P/+9jxYLIYP3Ghx1su2FJfYpn7BKs6FW9/CktIUi5fVpJ+3QHGi0+ZkTmayGxyrz+1j+zr3p9FlVWfnONR1YIn4sdJjQvJmp1f76B5CBiw4aFzTXpFUTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781669099; c=relaxed/simple;
	bh=eVaRMPckhV9FlyCT4H9DbqNxhNx51BveZmR+WAWjLOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaK9t+7UHkMlIt7dEaKSTzy1Tt29amCBQBIgIE408sRPtz6XyE0TT/lqlVxCX8TqoinglYKmd9UIVuac2xNOiT9TlcZmrc9pKpS7ihp5WOkXJY9epiMIARQhsq3iVCK7u/inLPL87K6Q4E9pGGI7Lrtcn9iFc68x+QTBudN3yl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKPH2dow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKPH2dow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8637A1F000E9;
	Wed, 17 Jun 2026 04:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781669098;
	bh=CzwO8wyPCbgXUfabywX6hMjgq1NpqudjdbpQdWLuUA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKPH2dowmgNQUhdAg8e2TmF2PdIYeK5R1BxU5ykQ1VRs0/4eb3oPKcuL/uZRnY7Ph
	 egEHJSQSc//qPYth6kzOqHh2Tjc1EFix+p79K7uaxY7aauL+EJYdLY8YW0ukrKga2s
	 1RSjtsHo02A1E3JwhyKnrVjb5x02w25adiLF6YTpQTc4gaWxN6BuqX075zuo47a+ZK
	 03HAxKQSxveCXVYnRdzTzyrFKmpgW4vRIH5hm3IzjpdxbQbABx0dz5XBhJI4BVKzMf
	 y0hRYJ9TdSkaQYBoinnNAGxfJF6sMPC3/yL90CRYwiQ67nKI+M//AUkVbWhDSER9Uz
	 odxPNMt3JnjIw==
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
Subject: Re: [PATCH v1 2/3] mm/damon: introduce DAMON_HUGEPAGE for hot region hugepage collapsing
Date: Tue, 16 Jun 2026 21:04:52 -0700
Message-ID: <20260617040452.98621-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150316.580819-3-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:03:15 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This patch introduces a new DAMON module (SAMPLE_DAMON_HPAGE)
> which collapses hot regions into huge pages.
> 
> SAMPLE_DAMON_HPAGE operates in the virtual memory space, for a
> specific task. The user is expected to supply the PID of the task
> that is going to be monitored through the target_pid module
> variable.

s/variable/parameter/ ?

> 
> SAMPLE_DAMON_HPAGE uses the hugepage auto-tune mechanism to
> increase or decrease the aggressiveness of page collapsing. User
> autotuning is also available for additional tuning aggressiveness
> control.

Is the user autotuning really needed for this sample module?  I'm concerned if
it is unnecessarily making the code complicated.  Can we drop this?

> 
> The module also includes changes to the DAMON compilation,

I think this is not true?

> so that
> the module can be enabled or disabled.
> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> ---
>  samples/damon/Kconfig       |  14 +++
>  samples/damon/Makefile      |   1 +
>  samples/damon/hpage.c (new) | 207 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 222 insertions(+)
> 
> diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
> index cbf96fd8a8bf..1ef0b12c32e6 100644
> --- a/samples/damon/Kconfig
> +++ b/samples/damon/Kconfig
> @@ -40,4 +40,18 @@ config SAMPLE_DAMON_MTIER
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_DAMON_HPAGE
> +	bool "Build DAMON-based collapse of hot regions (SAMPLE_DAMON_HPAGE)"

Please make this be consistent to other sample modules.  E.g., DAMON sample
module for ...

> +	depends on DAMON && DAMON_VADDR && TRANSPARENT_HUGEPAGE
> +	help
> +	  This builds DAMON sample module for collapsing regions into huge pages.

... for huge pages collapsing?

> +
> +	  This module monitors a certain PID provided by the user through
> +	  target_pid attribute. Hot regions are determined by DAMON-based

Please use two spaces between sentences, consistent to others.

> +	  sampling. Collapsing occurs according to the quota goal using total

"DAMON-based sampling" sounds verbose and technically not making much sense.
How about just "DAMON"?

> +	  memory usage to huge page usage ratio. The ratio is set by the user

huge page to total memory usage ratio?

> +	  through a module attribute.

s/attribute/parameter/ ?

> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/samples/damon/Makefile b/samples/damon/Makefile
> index 72f68cbf422a..a348dc74ddcb 100644
> --- a/samples/damon/Makefile
> +++ b/samples/damon/Makefile
> @@ -3,3 +3,4 @@
>  obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
>  obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
>  obj-$(CONFIG_SAMPLE_DAMON_MTIER) += mtier.o
> +obj-$(CONFIG_SAMPLE_DAMON_HUGEPAGE) += hpage.o

... Can this be compiled...?

> diff --git a/samples/damon/hpage.c b/samples/damon/hpage.c
> new file mode 100644
> index 000000000000..ebbe5e1be1a1
> --- /dev/null
> +++ b/samples/damon/hpage.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 HUAWEI, Inc.
> + *             https://www.huawei.com
> + *
> + * Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> + */
> +
> +#define pr_fmt(fmt) "damon_sample_hpage: " fmt
> +
> +#include <linux/damon.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "damon_sample_hpage."
> +
> +static bool enabled __read_mostly;
> +
> +static unsigned long target_pid;
> +module_param(target_pid, ulong, 0600);

Why 'ulong'?  I think 'int' is enough?

> +
> +/* By default, total huge pages to system memory usage ratio set to 10% */
> +static unsigned long quota_percentage_hugepage __read_mostly = 1000;
> +module_param(quota_percentage_hugepage, ulong, 0600);

"percentage" in the name sounds weird.  What about hugepage_mem_bp or
target_hugepage_mem_bp?

> +
> +static unsigned long quota_autotune_feedback __read_mostly;
> +module_param(quota_autotune_feedback, ulong, 0600);

I'm not really sure if this is really needed.  If not, could we drop this?

> +
> +static struct damon_ctx *ctx;
> +static struct pid *target_pidp;
> +
> +static int damon_sample_hpage_damon_call_fn(void *data)
> +{
> +	struct damon_ctx *c = data;
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, c) {
> +		struct damon_region *r;
> +		unsigned long hugepages = 0;
> +
> +		damon_for_each_region(r, t) {
> +			if (r->nr_accesses > 0)
> +				hugepages += r->ar.end - r->ar.start;
> +		}
> +		hugepages = hugepages / HPAGE_PMD_SIZE;
> +		pr_info("hugepage: %lu\n", hugepages);
> +	}
> +	return 0;
> +}

What's the purpose of this function?  If not really  needed, can we drop?

> +
> +static struct damon_call_control call_control = {
> +	.fn = damon_sample_hpage_damon_call_fn,
> +	.repeat = true,
> +};
> +
> +static int damon_sample_hpage_start(void)
> +{
> +	int err;
> +	struct damon_target *target;
> +	struct damos *scheme;
> +	struct damos_quota_goal *goal;
> +
> +	pr_info("start\n");
> +
> +

Let's have only one blank line.

> +	ctx = damon_new_ctx();
> +	if (!ctx)
> +		return -ENOMEM;
> +	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
> +		damon_destroy_ctx(ctx);
> +		return -EINVAL;
> +	}
> +
> +	target = damon_new_target();
> +	if (!target) {
> +		damon_destroy_ctx(ctx);
> +		return -ENOMEM;
> +	}
> +	damon_add_target(ctx, target);
> +	target_pidp = find_get_pid(target_pid);
> +	if (!target_pidp) {
> +		damon_destroy_ctx(ctx);
> +		return -EINVAL;
> +	}
> +	target->pid = target_pidp;
> +
> +	scheme = damon_new_scheme(&(struct damos_access_pattern) {
> +				.min_sz_region = HPAGE_PMD_SIZE,
> +				.max_sz_region = ULONG_MAX,
> +				.min_nr_accesses = 0,
> +				.max_nr_accesses = UINT_MAX,
> +				.min_age_region = 50,
> +				.max_age_region = UINT_MAX},
> +				DAMOS_COLLAPSE, 0,
> +				&(struct damos_quota) {
> +				.ms = 10,

I don't really suggest time quota to people nowadays.  Size quota is easier to
understand and sufficient in many cases in my humble opinion.  Did you find it
is really helpful and essential for this module?  If not, could we unset time
quota?

> +				.sz = 128 * 1024 * 1024,
> +				.reset_interval = 1000,
> +				.weight_sz = 0,
> +				.weight_nr_accesses = 1,
> +				.weight_age = 1,
> +				.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL},
> +				&(struct damos_watermarks){}, NUMA_NO_NODE);
> +	if (!scheme) {
> +		damon_destroy_ctx(ctx);
> +		return -ENOMEM;
> +	}
> +	damon_set_schemes(ctx, &scheme, 1);
> +	goal = damos_new_quota_goal(DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> +				quota_percentage_hugepage);
> +	if (!goal) {
> +		damon_destroy_ctx(ctx);
> +		return -ENOMEM;
> +	}
> +	damos_add_quota_goal(&scheme->quota, goal);
> +
> +	if (quota_autotune_feedback) {
> +		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
> +		if (!goal) {
> +			damon_destroy_ctx(ctx);
> +			return -ENOMEM;
> +		}
> +		goal->current_value = quota_autotune_feedback;
> +		damos_add_quota_goal(&scheme->quota, goal);
> +	}

Seems this module is not really utilizing the user input feedback.  To use that
in real, the module should periodically read user's input and feed that to
DAMON core.  I find no code doing that in this module.  If it is not really
being used, I'd suggest to drop this.

> +
> +	err = damon_start(&ctx, 1, true);
> +	if (err) {
> +		damon_destroy_ctx(ctx);
> +		return err;
> +	}
> +
> +	call_control.data = ctx;
> +	err = damon_call(ctx, &call_control);
> +	if (err) {
> +		damon_stop(&ctx, 1);
> +		damon_destroy_ctx(ctx);
> +	}
> +	return err;
> +}
> +
> +static void damon_sample_hpage_stop(void)
> +{
> +	pr_info("stop\n");
> +	if (ctx) {
> +		damon_stop(&ctx, 1);
> +		damon_destroy_ctx(ctx);
> +	}
> +}
> +static int damon_sample_hpage_enabled_store(const char *val,
> +				const struct kernel_param *kp)
> +{
> +	bool is_enabled = enabled;
> +	int err;
> +
> +	err = kstrtobool(val, &enabled);
> +	if (err)
> +		return err;
> +
> +	if (enabled == is_enabled)
> +		return 0;
> +
> +	if (!damon_initialized())
> +		return 0;
> +
> +	if (enabled) {
> +		err = damon_sample_hpage_start();
> +		if (err)
> +			enabled = false;
> +		return err;
> +	}
> +	damon_sample_hpage_stop();
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops enabled_param_ops = {
> +	.set = damon_sample_hpage_enabled_store,
> +	.get = param_get_bool,
> +};
> +
> +module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
> +MODULE_PARM_DESC(enabled,
> +	"Enable or disable DAMON_HUGEPAGE (default: disabled)");

s/DAMON_HUGEPAGE/DAMON_SAMPLE_HPAGE/ ?

"(default: disabled)" seems unnecessary.  Could you please remove that?

> +
> +static int __init damon_sample_hpage_init(void)
> +{
> +	int err = 0;
> +
> +	if (!damon_initialized()) {
> +		if (enabled)
> +			enabled = false;
> +		pr_warn("Module not initialized\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (enabled) {
> +		err = damon_sample_hpage_start();
> +		if (err)
> +			enabled = false;
> +	}
> +	return err;
> +}
> +
> +module_init(damon_sample_hpage_init);
> -- 
> 2.43.0


Thanks,
SJ
