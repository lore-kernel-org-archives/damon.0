Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F01369D56
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018312; cv=none; b=DcHANfPQ+ntEDvXlQebIgDtfHOWw3GOhv8/C/PHqYA7lilGV14xaeEph27ohEYlnUovCBs0CxiLOWAjYv3MKrOjUVi+6zZ2JrFcfHAqyYmYUvXzkxogvbm0+AuFtf0+fnz5/MLGa7k+I7jezqSAaGQGLamQFScDKrawV2rc/yTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018312; c=relaxed/simple;
	bh=AdFH1hHbX852vPMJa/RntNJvPqr6Bhz4n/Yk4IKCIQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQ0ucXoE2bDcZeRuRcLAR9xhC33L3C1fDqfMhil1H7b/BwooelmOQYpu9qnJ59PboTueQpRVWjZnHBWGb2DbvHzU1rel7s8M3Hof5xDbHEna0brX5AXoBYFI89MZshAKcIwOI/0dw2m6VeqB/qeQopWFzB2e87LhvDDh3qjUK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQozmxJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQozmxJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA611F000E9;
	Thu,  2 Jul 2026 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783018310;
	bh=GRvPQ6/Z0g76HRnzKKDLecrWTfumsay2ZV4G7sApkk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQozmxJdkoRbRH5oLgqkPWRBXd+Qnd82D6mUzoSS5n4Q6rQTo02sW3z9jkxnXDNtF
	 776BYNsJFUH2Gm6HxCjpw3Xqf5qdYWHJssvWv+lKw+CZxzNkj+VAjXjHqCZ7YzyTfx
	 ZF8bQlg18Pt/G9dwGXoeLoYSE9yR9alB8rt7l5XpXGXh3iBBsu7RjZ8BJ34KI5+K0U
	 LlhTdioZY7ZLfHuXzHBceHgdWcbzQSEAocedZqJVsl/3UhnqFr3VsTYC0kHuBY7cEl
	 fTnCTkoIoTeULVqalWWKq8qvkkdqo08zG6EwZBrAkP6MLJ28dhWHWLuiN1gmutMWJP
	 uDp/y5CCWdbGA==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: Re: [RESEND RFC PATCH v2 1/5] mm/damon: add target_order field for DAMOS_COLLAPSE
Date: Thu,  2 Jul 2026 11:51:37 -0700
Message-ID: <20260702185137.91227-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702094633.75658-2-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 17:46:29 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> DAMOS_COLLAPSE currently collapses into PMD-size THP only.  Add a
> target_order field to express per-order mTHP collapse intent.  Zero
> means system default (PMD order, same as current behavior).  Valid
> values are 0 and 2..HPAGE_PMD_ORDER.
> 
> Wire up the sysfs interface: a per-scheme rw file "target_order".

Unless there is a name conflict, let's just call it "order".

> Validate at store time that the value is in range, and warn at scheme
> creation time if DAMOS_COLLAPSE is used with an unsupported non-PMD
> order, resetting to 0.

I'm working [1] on centralize the user parameter validations into core layer.
It is fine to have this for now.  But once the core layer validation is merged
into mm-new, let's use it for the validation.  That is, just let the user
writes invalidate target order.  But eventual attempt to use that via
damon_start() or damon_commit() will fail.

> 
> The actual mTHP application via the khugepaged wrapper will be added
> in subsequent patches.
> 
> Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.wang@processmission.com>

Having two Signed-off-by: looks odd.  If you want to give a credit to your
employer, you can add that to your signature, like:

Signed-off-by: Lian Wang (Your employer name) <lianux.mm@gmail.com>

That's a de-facto standard in mm community.

> ---
>  include/linux/damon.h    |  5 ++++
>  mm/damon/core.c          |  2 ++
>  mm/damon/sysfs-schemes.c | 61 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 6f7edb3590ef..5a0587556573 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -572,6 +572,11 @@ struct damos_migrate_dests {
>  struct damos {
>  	struct damos_access_pattern pattern;
>  	enum damos_action action;
> +	/*
> +	 * @target_order: target order for mTHP actions (DAMOS_COLLAPSE).
> +	 * 0 means system default (PMD order).  Valid: 0, 2..HPAGE_PMD_ORDER.
> +	 */
> +	unsigned int target_order;
>  	unsigned long apply_interval_us;

Let's rename to 'order'.  And put it in the union having 'target_nid' and
'migrate_dests'.

>  /* private: internal use only */
>  	/*
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 265d51ade25b..be54defd4646 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -579,6 +579,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
>  
>  	scheme->migrate_dests = (struct damos_migrate_dests){};
>  	scheme->target_nid = target_nid;
> +	scheme->target_order = 0;
>  
>  	return scheme;
>  }
> @@ -1278,6 +1279,7 @@ static int damos_commit(struct damos *dst, struct damos *src)
>  
>  	dst->wmarks = src->wmarks;
>  	dst->target_nid = src->target_nid;
> +	dst->target_order = src->target_order;
>  
>  	err = damos_commit_dests(&dst->migrate_dests, &src->migrate_dests);
>  	if (err)
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 329cfd0bbe9f..7dcd582ded86 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -6,7 +6,9 @@
>   */
>  
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/numa.h>
> +#include <linux/huge_mm.h>
>  
>  #include "sysfs-common.h"
>  
> @@ -2257,6 +2259,7 @@ struct damon_sysfs_scheme {
>  	struct damon_sysfs_stats *stats;
>  	struct damon_sysfs_scheme_regions *tried_regions;
>  	int target_nid;
> +	unsigned int target_order;

Let's rename to 'order' if there is no problem.  Same for below.

>  	struct damos_sysfs_dests *dests;
>  };
>  
> @@ -2323,6 +2326,7 @@ static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
>  	scheme->action = action;
>  	scheme->apply_interval_us = apply_interval_us;
>  	scheme->target_nid = NUMA_NO_NODE;
> +	scheme->target_order = 0;
>  	return scheme;
>  }
>  
> @@ -2642,6 +2646,39 @@ static ssize_t target_nid_store(struct kobject *kobj,
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
> +
> +	err = kstrtouint(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (val != 0 && (val < 2 || val > HPAGE_PMD_ORDER))
> +		return -EINVAL;
> +#else
> +	if (val != 0)
> +		return -EINVAL;
> +#endif

As I mentioned above, this should eventually removed in lieu of core layer
parameters validation.

> +
> +	scheme->target_order = val;
> +	return count;
> +}
> +
>  static void damon_sysfs_scheme_release(struct kobject *kobj)
>  {
>  	kfree(container_of(kobj, struct damon_sysfs_scheme, kobj));
> @@ -2656,10 +2693,14 @@ static struct kobj_attribute damon_sysfs_scheme_apply_interval_us_attr =
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
> @@ -2970,6 +3011,7 @@ static struct damos *damon_sysfs_mk_scheme(
>  	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
>  	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
>  	struct damos *scheme;
> +	unsigned int target_order;
>  	int err;
>  
>  	struct damos_access_pattern pattern = {
> @@ -3005,6 +3047,25 @@ static struct damos *damon_sysfs_mk_scheme(
>  	if (!scheme)
>  		return NULL;
>  
> +	target_order = sysfs_scheme->target_order;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (sysfs_scheme->action == DAMOS_COLLAPSE &&
> +	    target_order != 0 &&
> +	    target_order != HPAGE_PMD_ORDER) {
> +		pr_warn("DAMON collapse: target_order %u not supported, only PMD order (%u) is available. Use 0 or %u.\n",
> +			target_order,
> +			HPAGE_PMD_ORDER, HPAGE_PMD_ORDER);
> +		target_order = 0;
> +	}

Ditto.  This validation should eventually be removed.

> +#else
> +	if (sysfs_scheme->action == DAMOS_COLLAPSE && target_order != 0) {
> +		pr_warn("DAMON collapse: target_order not supported without THP. Use 0.\n");
> +		target_order = 0;
> +	}
> +#endif
> +	scheme->target_order = target_order;
> +
>  	err = damos_sysfs_add_quota_score(sysfs_quotas->goals, &scheme->quota);
>  	if (err) {
>  		damon_destroy_scheme(scheme);

Overall, looks good.

[1] https://lore.kerneel.org/20260701144815.113325-1-sj@kernel.org


Thanks,
SJ

[...]
