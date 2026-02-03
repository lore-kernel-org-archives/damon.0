Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F41A2C0B;
	Tue,  3 Feb 2026 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095102; cv=none; b=WntovxW/3jwcIuj4UyrYpFzLu1hksxdffOh5rn4mDULJg9q7XFPjqt7SGrLcjxbfbgMTHpHIj1/CR2UfSTJn/vxcEjmxgJLoXKT+yy1YkOst4wG1q++jv3IasqooBf3MiWtUNp+udU7ZyVSsWSdY1q8b1uEs2ArZjopyiyWhHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095102; c=relaxed/simple;
	bh=bmVtOnBLTLN+OzbUqF7EZxQlQGGm2e3FFNynpIQbNZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cU2GbkiVZdAuN4ae4V3di10ydWJYSrLuMxB3qi5rRvmwN54hIsG+bNEzYe3LWOz9mm1h5VMIG67wvQd48JXl6d+cenSCKfnItT0gHudGqOJxrBJYqT1pjg6ht2WqpsfXrIl5V9iLNuLODQMMSocOTsj9AZ1L9guZsxXiYUIN6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km26BteT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km26BteT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F56C116D0;
	Tue,  3 Feb 2026 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770095101;
	bh=bmVtOnBLTLN+OzbUqF7EZxQlQGGm2e3FFNynpIQbNZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=km26BteT8/xjDYLpH3jF915gACbYEHixl2nF9yYJ+QAn/01hgt8A7igh0Iu3O0NpN
	 ua9TfZS09ikMxxz+9ajeSdgp3/EPlV6eC2JjUVFij7vpGBBbUq5qQiLPL2DPX+gJJs
	 ho6pZNZTbpLBim9PIyEEsh7TPia5jZ9Y+3JioQle+Ax1k5sCwFy6wla8/uYnvbiO8R
	 C+TwVXNqe7zJ4rnoHL/m7Z9fq3Il3ebIOI5Je+t9E9Oin/91iqAM3dJgMQkehtrIea
	 gLnE9u5CPH1fKf4b4EmdeMmQgk4GW64OlEivhMM11YthpUwjrD7OO9LmGkm/Mfakej
	 kXMUIpkZ5lDIg==
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
Subject: Re: [RFC PATCH v1 3/4] mm/damon: New module with hot application detection
Date: Mon,  2 Feb 2026 21:04:40 -0800
Message-ID: <20260203050440.68631-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202145650.1795854-4-gutierrez.asier@huawei-partners.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2 Feb 2026 14:56:48 +0000 <gutierrez.asier@huawei-partners.com> wrote:

> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> This new module detects hot applications and  launches a new kdamond
> thread for each of them.
> 
> 1. It first launches a new kthread called damon_dynamic.

I feel like the name is bit ambiguous.  What about something more specific to
this module's use case, say, damon_hugepage_monitor or more shortly
damon_hugepaged?

> This thread
> will monitor the tasks in the system by pooling. The tasks are sorted
> by utime delta. For the top N tasks, a new kdamond thread will be
> launched. Applications which turn cold will have their kdamond
> stopped.
> 
> 2. Initially we don't know the min_access for each of the task. We
> want to find the highest min_access when collapses start happening.
> For that we have an initial threashold of 90, which we will lower
> until a collpase occurs.

As I asked to the cover letter, I'm curious if you considered using DAMOS quota
goal.  Let's continue the discussion on the cover letter, though.

> 
> Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
> ---
>  mm/damon/dynamic_hugepages.c (new) | 579 +++++++++++++++++++++++++++++
>  1 file changed, 579 insertions(+)
> 
> diff --git a/mm/damon/dynamic_hugepages.c b/mm/damon/dynamic_hugepages.c

I think the file name could be simpler, say, hugepage.c ?

> new file mode 100644
> index 000000000000..8b7c1e4d5840
> --- /dev/null
> +++ b/mm/damon/dynamic_hugepages.c
> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 HUAWEI, Inc.

Captain, it's 2026! :)

> + *             https://www.huawei.com
> + *
> + * Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> + */
> +
> +#define pr_fmt(fmt) "damon-dynamic-hotpages: " fmt

Again, I'd prefer simpler one, like, "damon-hugepage: "

> +
> +#include <linux/damon.h>
> +#include <linux/kstrtox.h>
> +#include <linux/list_sort.h>
> +#include <linux/module.h>
> +#include <linux/sched/loadavg.h>
> +
> +#include "modules-common.h"
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "damon_dynamic_hotpages."

Ditto.  Maybe "damon_hugepage."

> +
> +#define MAX_MONITORED_PIDS 3
> +#define HIGHEST_MIN_ACCESS 90
> +#define HIGH_ACC_THRESHOLD 50
> +#define MID_ACC_THRESHOLD 15
> +#define LOW_ACC_THRESHOLD 2
> +
> +static struct task_struct *monitor_thread;
> +
> +struct mutex enable_disable_lock;
> +
> +/*
> + * Enable or disable DAMON_HOT_HUGEPAGE.
> + *
> + * You can enable DAMON_HOT_HUGEPAGE by setting the value of this parameter
> + * as ``Y``. Setting it as ``N`` disables DAMON_HOT_HUGEPAGE.  Note that
> + * DAMON_HOT_HUGEPAGE could do no real monitoring and reclamation due to the
> + * watermarks-based activation condition.  Refer to below descriptions for the
> + * watermarks parameter for this.

Do you willing to use watermarks?  Can you further explain how you will use it
in your use case?

> + */
> +static bool enabled __read_mostly;
> +
> +/*
> + * DAMON_HOT_HUGEPAGE monitoring period.
> + */
> +static unsigned long monitor_period __read_mostly = 5000000;
> +module_param(monitor_period, ulong, 0600);

What is the time unit of this parameter?  Documenting it would be nice.

> +
> +static long monitored_pids[MAX_MONITORED_PIDS];
> +module_param_array(monitored_pids, long, NULL, 0400);
> +
> +static int damon_dynamic_hotpages_turn(bool on);

Seems the above declaration is not really needed?

> +
> +static struct damos_quota damon_dynamic_hotpages_quota = {
> +	/* use up to 10 ms time, reclaim up to 128 MiB per 1 sec by default */
> +	.ms = 10,
> +	.sz = 0,
> +	.reset_interval = 1000,
> +	/* Within the quota, page out older regions first. */

You don't page out, but collapse, right?  The coment may need to be updated.

> +	.weight_sz = 0,
> +	.weight_nr_accesses = 0,
> +	.weight_age = 1
> +};
> +DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_dynamic_hotpages_quota);
> +
> +static struct damos_watermarks damon_dynamic_hotpages_wmarks = {
> +	.metric = DAMOS_WMARK_FREE_MEM_RATE,
> +	.interval = 5000000, /* 5 seconds */
> +	.high = 900, /* 90 percent */
> +	.mid = 800, /* 80 percent */
> +	.low = 50, /* 5 percent */
> +};
> +DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_dynamic_hotpages_wmarks);

What's the point of setting watermarks here, in hugepage use case?

> +
> +static struct damon_attrs damon_dynamic_hotpages_mon_attrs = {
> +	.sample_interval = 5000, /* 5 ms */
> +	.aggr_interval = 100000, /* 100 ms */

This means nr_accesses of each region can be only up to 20 (100ms / 5ms).
IIUC, you are auto-tuning the DAMOS target access pattern's min_nr_accesses
starting from 90.  If I'm not wrong, you may better to start from 20.

> +	.ops_update_interval = 0,
> +	.min_nr_regions = 10,
> +	.max_nr_regions = 1000,
> +};
> +DEFINE_DAMON_MODULES_MON_ATTRS_PARAMS(damon_dynamic_hotpages_mon_attrs);
> +
> +struct task_monitor_node {
> +	pid_t pid;
> +
> +	struct damon_ctx *ctx;
> +	struct damon_target *target;
> +	struct damon_call_control call_control;
> +	u64 previous_utime;
> +	unsigned long load;
> +	struct damos_stat stat;
> +	int min_access;
> +
> +	struct list_head list;
> +	struct list_head sorted_list;
> +	struct list_head active_monitoring;
> +};
> +
> +static void find_top_n(struct list_head *task_monitor,
> +								struct list_head *sorted_tasks)

You ain't need to put that much tabs on the above line.

> +{
> +	struct task_monitor_node *entry, *to_test, *tmp;
> +	struct list_head *pos;
> +	int i;
> +
> +	list_for_each_entry(entry, task_monitor, list) {
> +		i = 0;
> +		list_for_each(pos, sorted_tasks) {
> +			i++;
> +			to_test = list_entry(pos, struct task_monitor_node, sorted_list);

I'd recommend to use list_for_each_entry() here, if possible.

> +
> +			if (entry->load > to_test->load) {
> +				list_add_tail(&entry->sorted_list, pos);
> +

The above new line seems unnecessary.

> +				i = MAX_MONITORED_PIDS;
> +			}
> +
> +			if (i == MAX_MONITORED_PIDS)
> +				break;
> +		}
> +
> +		if (i < MAX_MONITORED_PIDS)
> +			list_add_tail(&entry->sorted_list, sorted_tasks);
> +	}
> +
> +	i = 0;
> +	list_for_each_entry_safe(entry, tmp, sorted_tasks, sorted_list) {
> +		if (i < MAX_MONITORED_PIDS)
> +			continue;
> +		list_del_init(&entry->sorted_list);
> +

Ditto.  Unnecessary new line.

> +	}

Reading this function was not very easy for me.  Adding more comments making te
code simpler would be nice.

> +}
> +
> +static struct damos *damon_dynamic_hotpages_new_scheme(int min_access,
> +						   enum damos_action action)
> +{
> +	struct damos_access_pattern pattern = {
> +		/* Find regions having PAGE_SIZE or larger size */
> +		.min_sz_region = PMD_SIZE,
> +		.max_sz_region = ULONG_MAX,
> +		/* and not accessed at all */
> +		.min_nr_accesses = min_access,
> +		.max_nr_accesses = 100,
> +		/* for min_age or more micro-seconds */
> +		.min_age_region = 0,
> +		.max_age_region = UINT_MAX,

Seems the comments aboe are not updated since copy-pasted.

> +	};
> +
> +	return damon_new_scheme(
> +		&pattern,
> +		/* synchrounous partial collapse as soon as found */
> +		action, 0,
> +		/* under the quota. */
> +		&damon_dynamic_hotpages_quota,
> +		/* (De)activate this according to the watermarks. */
> +		&damon_dynamic_hotpages_wmarks, NUMA_NO_NODE);
> +}
> +
> +static int damon_dynamic_hotpages_apply_parameters(
> +					struct task_monitor_node *monitored_task,
> +				    int min_access,
> +					enum damos_action action)

Seems the parameters can be better aligned.

> +{
> +	struct damos *scheme;
> +	struct damon_ctx *param_ctx;
> +	struct damon_target *param_target;
> +	struct damos_filter *filter;
> +	struct pid *spid;
> +	int err;
> +
> +	err = damon_modules_new_ctx_target(&param_ctx, &param_target,
> +					   DAMON_OPS_VADDR);
> +	if (err)
> +		return err;
> +
> +	err = -EINVAL;
> +	spid = find_get_pid(monitored_task->pid);
> +	if (!spid) {
> +		put_pid(spid);

You don't need to call put_pid() when get_pid() failed.

> +		goto out;
> +	}
> +
> +	param_target->pid = spid;
> +
> +	err = damon_set_attrs(param_ctx, &damon_dynamic_hotpages_mon_attrs);
> +	if (err)
> +		goto out;
> +
> +	err = -ENOMEM;
> +	scheme = damon_dynamic_hotpages_new_scheme(min_access, action);
> +	if (!scheme)
> +		goto out;
> +
> +	damon_set_schemes(param_ctx, &scheme, 1);
> +
> +	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
> +	if (!filter)
> +		goto out;
> +	damos_add_filter(scheme, filter);
> +
> +	err = damon_commit_ctx(monitored_task->ctx, param_ctx);
> +out:
> +	damon_destroy_ctx(param_ctx);
> +	return err;
> +}
> +
> +static int damon_dynamic_hotpages_damon_call_fn(void *arg)
> +{
> +	struct task_monitor_node *monitored_task = arg;
> +	struct damon_ctx *ctx = monitored_task->ctx;
> +	struct damos *scheme;
> +	int err = 0;
> +	int min_access;
> +	struct damos_stat stat;
> +
> +	damon_for_each_scheme(scheme, ctx)
> +		stat = scheme->stat;
> +	scheme = list_first_entry(&ctx->schemes, struct damos, list);
> +
> +	if (ctx->passed_sample_intervals < scheme->next_apply_sis)
> +		return err;
> +
> +	if (stat.nr_applied)
> +		return err;
> +
> +	min_access = scheme->pattern.min_nr_accesses;
> +
> +	if (min_access > HIGH_ACC_THRESHOLD) {
> +		min_access = min_access - 10;
> +		err = damon_dynamic_hotpages_apply_parameters(
> +			monitored_task, min_access, DAMOS_COLLAPSE);
> +	} else if (min_access > MID_ACC_THRESHOLD) {
> +		min_access = min_access - 5;
> +		err = damon_dynamic_hotpages_apply_parameters(
> +			monitored_task, min_access, DAMOS_COLLAPSE);
> +	} else if (min_access > LOW_ACC_THRESHOLD) {
> +		min_access = min_access - 1;
> +		err = damon_dynamic_hotpages_apply_parameters(
> +			monitored_task, min_access, DAMOS_COLLAPSE);
> +	}
> +	return err;
> +}
> +
> +static int damon_dynamic_hotpages_init_task(
> +								struct task_monitor_node *task_monitor)

You ain't need that many tabs.

> +{
> +	int err = 0;
> +	struct pid *spid;
> +	struct damon_ctx *ctx = task_monitor->ctx;
> +	struct damon_target *target = task_monitor->target;
> +
> +	if (!ctx || !target)
> +		damon_modules_new_ctx_target(&ctx, &target, DAMON_OPS_VADDR);
> +
> +	if (ctx->kdamond)
> +		return 0;

Please use damon_is_running() instead.

> +
> +	spid = find_get_pid(task_monitor->pid);
> +	if (!spid) {
> +		put_pid(spid);

You don't need to call put_pid() with NULL.

> +		return -ESRCH;
> +	}
> +
> +	target->pid = spid;
> +
> +	if (err)
> +		return err;
> +
> +	task_monitor->call_control.fn = damon_dynamic_hotpages_damon_call_fn;
> +	task_monitor->call_control.repeat = true;
> +	task_monitor->call_control.data = task_monitor;
> +
> +	struct damos *scheme =
> +		damon_dynamic_hotpages_new_scheme(HIGHEST_MIN_ACCESS, DAMOS_COLLAPSE);

Please break the line for keeping the 80 columns limit.

> +	if (!scheme)
> +		return -ENOMEM;
> +
> +	damon_set_schemes(ctx, &scheme, 1);
> +
> +	task_monitor->ctx = ctx;
> +	err = damon_start(&task_monitor->ctx, 1, false);
> +	if (err)
> +		return err;
> +
> +	return damon_call(task_monitor->ctx, &task_monitor->call_control);
> +}
> +
> +static int add_monitored_task(struct task_struct *task,
> +								struct list_head *task_monitor)

Too many tabs.

> +{
> +	struct task_struct *thread;
> +	struct task_monitor_node *task_node;
> +	u64 total_time = 0;
> +
> +	task_node = kzalloc(sizeof(struct task_monitor_node), GFP_KERNEL);

It is more conventional to do like below:

    kzalloc(sizeof(*task_node), GFP_KERNEL);

> +	if (!task_node)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&task_node->list);
> +	INIT_LIST_HEAD(&task_node->sorted_list);
> +	INIT_LIST_HEAD(&task_node->active_monitoring);
> +
> +	task_node->min_access = HIGHEST_MIN_ACCESS;
> +	task_node->pid = task_pid_nr(task);
> +
> +	list_add_tail(&task_node->list, task_monitor);
> +
> +	for_each_thread(task, thread)
> +		total_time += thread->utime;
> +
> +	task_node->previous_utime = total_time;
> +	return 0;
> +}
> +
> +static int damon_dynamic_hotpages_attach_tasks(
> +										struct list_head *task_monitor_sorted,
> +										struct list_head *task_monitor_active)

Too much indents.

> +{
> +	struct task_monitor_node *sorted_task_node, *tmp;
> +	int err;
> +	int i = 0;
> +
> +	sorted_task_node = list_first_entry(
> +		task_monitor_sorted, struct task_monitor_node, sorted_list);
> +	while (i < MAX_MONITORED_PIDS && !list_entry_is_head(sorted_task_node,
> +								task_monitor_sorted, sorted_list)) {
> +		if (sorted_task_node->ctx && sorted_task_node->ctx->kdamond)
> +			list_move(&sorted_task_node->active_monitoring,
> +				  task_monitor_active);
> +		else {
> +			rcu_read_lock();
> +			if (!find_vpid(sorted_task_node->pid)) {
> +				sorted_task_node->ctx = NULL;
> +				sorted_task_node = list_next_entry(
> +					sorted_task_node, sorted_list);
> +
> +				rcu_read_unlock();
> +				continue;
> +			}
> +			rcu_read_unlock();
> +
> +			err = damon_dynamic_hotpages_init_task(sorted_task_node);
> +			if (err) {
> +				sorted_task_node->ctx = NULL;
> +				sorted_task_node = list_next_entry(
> +					sorted_task_node, sorted_list);
> +				continue;
> +			}
> +
> +			list_add(&sorted_task_node->active_monitoring,
> +				 task_monitor_active);
> +		}
> +
> +		monitored_pids[i] = sorted_task_node->pid;
> +		sorted_task_node = list_next_entry(sorted_task_node, sorted_list);
> +
> +		i++;
> +	}
> +
> +	i = 0;
> +	list_for_each_entry_safe(sorted_task_node, tmp, task_monitor_active,
> +				 active_monitoring) {
> +		if (i < MAX_MONITORED_PIDS) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (sorted_task_node->ctx) {
> +			damon_stop(&sorted_task_node->ctx, 1);
> +			damon_destroy_ctx(sorted_task_node->ctx);
> +			sorted_task_node->ctx = NULL;
> +		}
> +
> +		list_del_init(&sorted_task_node->active_monitoring);
> +	}
> +	return 0;
> +}

This is bit difficult to read.  Adding more comments and refactoring to be
easier to read would be nice.

And similar comments would be applied to below.  I understand this patch series
is intentionally not very cleanly wrote, as this is an RFC for high level
concept.  I therefore left comments for only things that immediately standing
out to me.  If my understanding is not wrong, I will do more detailed review of
code in the next version of this patch series.


Thanks,
SJ

[...]
