Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AB3D1A99
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540851; cv=none; b=mRxeAIgaNcxGsRERES28xTCKT8cRdGzjqT7LMEIJZu0+YUDSyRDfzrzAccArq57E/zQTfHbUl5aCbNUTY4Mu9+UumUZLYVd2xtgOjaDHzy8+jAWsTpgtyB2+Ug42qNWE6QJRC2Yz9Dw51g7v8+leNa2n/t5LulB6WmpSRW9Fw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540851; c=relaxed/simple;
	bh=IO2IpjRrwq36GZmHNlW4xGDi3np1LLgn+WNb7ci2Ax8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hu8vIq3JEjJco/YXBgpek/2qm3ungMcf/meBN4aowLb156W2iLqWtrDqmBa2Ir2S/hyf61mHr2JerZfJUnyAO8QGjnZHPujrjjxB598SnNv8NS1LTeSga0jhtgqeRkPk9Mt52f0g1pYfnoLtWjh5a6HJBgqHKNW2RKy+CjXRx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=TfAwzd9h; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="TfAwzd9h"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nYPufc9vJgZQgfGaq7EwQsT9y5mRrKBC2QSET+yH5J4=;
	b=TfAwzd9hM1GQaYzd0y32K6hbhXaqJCx2Hkc6LVK3wz1/UQYG38I66oi18XdZ0DFubo8jO8d9g
	1U2QeVWzNuxu7WfCq8p2ph1UWke7QsZFuNIRZ8eTT5nonUoM7rrPljJIq3UJFo+0yHLDB4nfmXr
	9S6FBCBvgKqz+5LMel4dgpw=
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4h3bJp4fvQzJ4673;
	Mon, 20 Jul 2026 17:47:06 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id F130940569;
	Mon, 20 Jul 2026 17:47:24 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Jul 2026 12:47:24 +0300
Message-ID: <e01fa50e-b9a7-4c0b-ba70-6088b8d6ddfd@huawei-partners.com>
Date: Mon, 20 Jul 2026 12:47:23 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/3] mm/damon: introduce DAMOS_SPLIT action
To: Lian Wang <lianux.mm@gmail.com>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>
CC: <sj@kernel.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <npache@redhat.com>,
	<ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>, <ryan.roberts@arm.com>,
	<daichaobing@sangfor.com.cn>, <wangkefeng.wang@huawei.com>,
	<zengheng4@huawei.com>, <kasong@tencent.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <lianux.wang@processmission.com>,
	<kunwu.chan@linux.dev>
References: <20260720030327.80153-1-lianux.mm@gmail.com>
 <20260720030327.80153-2-lianux.mm@gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260720030327.80153-2-lianux.mm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 7/20/2026 6:03 AM, Lian Wang wrote:
> Add a new DAMOS action, DAMOS_SPLIT, that splits large folios in the
> target region down to a smaller order.  A new per-scheme field and sysfs
> file, target_order, selects the split target: 0 for order-0 base pages,
> or 2..HPAGE_PMD_ORDER-1 for a smaller mTHP order (order-1 is rejected at
> store time since anonymous THPs cannot be split to order-1).
> 
> Unlike DAMOS_COLLAPSE which builds large folios, splitting only dismantles
> them; it allocates nothing, copies nothing, and no THP admission policy
> applies.  khugepaged deliberately refuses to collapse a folio to a
> smaller order, leaving the shrink direction to callers like this one.
> 
> This patch adds the DAMOS_SPLIT action, the ``order`` field (placed in
> the existing union alongside target_nid and migrate_dests), its sysfs
> interface, and documentation.  The vaddr operations set handler is added
> in the next patch.
> 
> Link: https://lore.kernel.org/20260605161422.213817-9-npache@redhat.com/
>  ("mm/khugepaged: skip collapsing mTHP to smaller orders")
> 
> 
> 
> Co-developed-by: Kunwu Chan <kunwu.chan@linux.dev>
> Signed-off-by: Kunwu Chan <kunwu.chan@linux.dev>
> Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> ---
>  .../ABI/testing/sysfs-kernel-mm-damon         |  7 +++
>  Documentation/mm/damon/design.rst             |  5 ++
>  include/linux/damon.h                         | 15 ++++--
>  mm/damon/core.c                               |  2 +
>  mm/damon/sysfs-schemes.c                      | 48 +++++++++++++++++++
>  tools/testing/selftests/damon/sysfs.py        | 11 +++--
>  6 files changed, 79 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> index 907a504fb64c..ee8e260a631c 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
> @@ -265,6 +265,13 @@ Contact:	SJ Park <sj@kernel.org>
>  Description:	Action's target NUMA node id.  Supported by only relevant
>  		actions.
>  
> +What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/target_order
> +Date:		Jul 2026
> +Contact:	SJ Park <sj@kernel.org>
Shouldn't this point to your email address?
> +Description:	Target folio order for the ``split`` action.  Large folios in
> +		the target region are split down to this order.  Valid values
> +		are 0 (order-0 base pages) and 2..HPAGE_PMD_ORDER-1.
> +
>  What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/apply_interval_us
>  Date:		Sep 2023
>  Contact:	SJ Park <sj@kernel.org>
> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> index aed6cb1cf483..87a801954b1b 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -549,6 +549,11 @@ that supports each action are as below.
>     Supported by ``vaddr`` and ``fvaddr`` operations set. When
>     TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
>     fail.
> + - ``split``: Split each large folio in the region down to the order specified
> +   by the scheme's ``target_order`` (``0`` for order-0 base pages, or
> +   ``2..HPAGE_PMD_ORDER-1``).  Supported by ``vaddr`` and ``fvaddr`` operations
> +   set. When TRANSPARENT_HUGEPAGE is disabled, the application of the action
> +   will just fail.
>   - ``lru_prio``: Prioritize the region on its LRU lists.
>     Supported by ``paddr`` operations set.
>   - ``lru_deprio``: Deprioritize the region on its LRU lists.
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f69442a9d431..88b61b900a36 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -110,6 +110,7 @@ struct damon_target {
>   * @DAMOS_HUGEPAGE:	Call ``madvise()`` for the region with MADV_HUGEPAGE.
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>   * @DAMOS_COLLAPSE:	Call ``madvise()`` for the region with MADV_COLLAPSE.
> + * @DAMOS_SPLIT:	Split each large folio in the region to a smaller order.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
>   * @DAMOS_MIGRATE_HOT:  Migrate the regions prioritizing warmer regions.
> @@ -130,6 +131,7 @@ enum damos_action {
>  	DAMOS_HUGEPAGE,
>  	DAMOS_NOHUGEPAGE,
>  	DAMOS_COLLAPSE,
> +	DAMOS_SPLIT,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_MIGRATE_HOT,
> @@ -582,10 +584,15 @@ struct damos {
>  	struct damos_quota quota;
>  	struct damos_watermarks wmarks;
>  	union {
> -		struct {
> -			int target_nid;
> -			struct damos_migrate_dests migrate_dests;
> -		};
> +		int target_nid;
> +		struct damos_migrate_dests migrate_dests;
Shouldn't we keep target_nid and migrate_dests together using a
struct, as in the initial code?
> +		/*
> +		 * @order: target folio order for DAMOS_SPLIT.
> +		 * Split large folios down to this order.  0 for
> +		 * order-0 base pages, 2..HPAGE_PMD_ORDER-1 for
> +		 * smaller mTHP.  Order-1 is rejected.
> +		 */
> +		unsigned int order;
>  	};
>  	struct list_head core_filters;
>  	struct list_head ops_filters;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 806a67d02a6e..394c62455ad5 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -693,6 +693,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  		return NULL;
>  	scheme->pattern = *pattern;
>  	scheme->action = action;
> +	scheme->order = 0;
>  	scheme->apply_interval_us = apply_interval_us;
>  	/*
>  	 * next_apply_sis will be set when kdamond starts.  While kdamond is
> @@ -1446,6 +1447,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
>  
>  	dst->pattern = src->pattern;
>  	dst->action = src->action;
> +	dst->order = src->order;
>  	dst->apply_interval_us = src->apply_interval_us;
>  
>  	err = damos_commit_quota(&dst->quota, &src->quota);
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 32f495a96b17..725ed81ccf6c 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -4,7 +4,9 @@
>   */
>  
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/numa.h>
> +#include <linux/huge_mm.h>
>  
>  #include "sysfs-common.h"
>  
> @@ -2260,6 +2262,7 @@ struct damon_sysfs_scheme {
>  	struct damon_sysfs_stats *stats;
>  	struct damon_sysfs_scheme_regions *tried_regions;
>  	int target_nid;
> +	unsigned int target_order;
>  	struct damos_sysfs_dests *dests;
>  };
>  
> @@ -2293,6 +2296,10 @@ static struct damos_sysfs_action_name damos_sysfs_action_names[] = {
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
> @@ -2326,6 +2333,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
>  	scheme->action = action;
>  	scheme->apply_interval_us = apply_interval_us;
>  	scheme->target_nid = NUMA_NO_NODE;
> +	scheme->target_order = 0;
>  	return scheme;
>  }
>  
> @@ -2645,6 +2653,40 @@ static ssize_t target_nid_store(struct kobject *kobj,
>  	return err ? err : count;
>  }
>  
> +static ssize_t target_order_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_scheme *scheme = container_of(kobj,
> +			struct damon_sysfs_scheme, kobj);
> +
> +	return sysfs_emit(buf, "%u\n", scheme->target_order);
> +}
> +
> +static ssize_t target_order_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_scheme *scheme = container_of(kobj,
> +			struct damon_sysfs_scheme, kobj);
> +	unsigned int val;
> +	int err;
Move the variable declaration to the top of the function.
> +
> +	err = kstrtouint(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	/* Valid split targets: 0 (order-0 base pages) or 2..HPAGE_PMD_ORDER-1. */
> +	if (val != 0 && (val < 2 || val >= HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +#else
> +	if (val != 0)
> +		return -EINVAL;
> +#endif
> +
> +	scheme->target_order = val;
> +	return count;
> +}
> +
>  static void damon_sysfs_scheme_release(struct kobject *kobj)
>  {
>  	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
> @@ -2659,10 +2701,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
>  static struct kobj_attribute damon_sysfs_scheme_target_nid_attr =
>  		__ATTR_RW_MODE(target_nid, 0600);
>  
> +static struct kobj_attribute damon_sysfs_scheme_target_order_attr =
> +		__ATTR_RW_MODE(target_order, 0600);
> +
>  static struct attribute *damon_sysfs_scheme_attrs[] = {
>  	&damon_sysfs_scheme_action_attr.attr,
>  	&damon_sysfs_scheme_apply_interval_us_attr.attr,
>  	&damon_sysfs_scheme_target_nid_attr.attr,
> +	&damon_sysfs_scheme_target_order_attr.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(damon_sysfs_scheme);
> @@ -3011,6 +3057,8 @@ static struct damos *damon_sysfs_mk_scheme(
>  	if (!scheme)
>  		return NULL;
>  
> +	scheme->order = sysfs_scheme->target_order;
> +
>  	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
>  	if (err) {
>  		damon_destroy_scheme(scheme);
> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> index 3ffa054b6386..49d3c319dfd8 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -131,11 +131,12 @@ def assert_scheme_committed(scheme, dump):
>              'hugepage': 3,
>              'nohugepage': 4,
>              'collapse': 5,
> -            'lru_prio': 6,
> -            'lru_deprio': 7,
> -            'migrate_hot': 8,
> -            'migrate_cold': 9,
> -            'stat': 10,
> +            'split': 6,
> +            'lru_prio': 7,
> +            'lru_deprio': 8,
> +            'migrate_hot': 9,
> +            'migrate_cold': 10,
> +            'stat': 11,
>              }
>      assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
>      assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
> 

-- 
Asier Gutierrez
Huawei

