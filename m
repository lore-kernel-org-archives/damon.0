Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DCEC5;
	Thu,  3 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751502753; cv=none; b=HvXUzd6iJXYudA1wgKvwL5wSuxlrzdqowCtfTSJPomNOYxZWhH24DLrB0veMBPyFh/NBuNt5A0AIXKduKf/ueHZikBW36aY1pInjl59lyjKzWF+O1RtNkNDsA8ipVhPQiysivwH42YAvsQhG4FK+zRK8F0cccA+JoZ2M6F9TNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751502753; c=relaxed/simple;
	bh=lnfsM+pTvlwBy9XeP2BVG6w3v0RAdty1OU7awH2eo7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIsapfYM+Eg7IJO2BS/O6GfpFsPH73vPbfqLUjQu0LtskoPAOxK1usgZGUwezPBczbl3g6OZ3tNVzG/qqHznwYNagRQ31wVQwLYHXU6GTvK8YG+RVSbJ6/73IEJpNXaRO7tQpSwd9Ga2uZKEofG5zl7PkLahD20epfvF8oLz5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Hz3X/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/Hz3X/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56FAC4CEE7;
	Thu,  3 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751502752;
	bh=lnfsM+pTvlwBy9XeP2BVG6w3v0RAdty1OU7awH2eo7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/Hz3X/TPQ0VoTzcd2HVktVxCuT0+EELVKLXuVhqWF0qfgtYpRR8npVrrzrappR8f
	 00mMnKynMXuAHrUaW2FohSrbnYznm493AVwronQ3ivtE33wY+oED7oGy+unHEwy8qf
	 BdlcAOQeLpKhu+CAAz145Splmlihk/eXwRsxQ1wc1kqv8VmSktzz/PbDS4i1cnmDs+
	 ZqjHVGbRcXwKaL+SD4O9SpU0TA4ZA+6OphJYEHSWi9C4dcYbm8M+yQjCa9QkRO362X
	 ihE4Ymkcn7Q/AOM9ALUlfbwUN1y0I9lSBawZbWDRoBAZYnbnTTj+SQ0yRIxgGvvi1j
	 5EDNrKl0hTY8A==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: Re: [RFC PATCH v3 11/13] mm/damon/vaddr: Use damos->migrate_dests in migrate_{hot,cold}
Date: Wed,  2 Jul 2025 17:32:29 -0700
Message-Id: <20250703003229.57429-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-12-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:34 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> damos->migrate_dests provides a list of nodes the migrate_{hot,cold}
> actions should migrate to, as well as the weights which specify the
> ratio pages should be migrated to each destination node.
> 
> This patch interleaves pages in the migrate_{hot,cold} actions according
> to the information provided in damos->migrate_dests if it is used. The
> interleaving algorithm used is similar to the one used in
> weighted_interleave_nid(). If damos->migration_dests is not provided, the
> actions migrate pages to the node specified in damos->target_nid as
> before.
> 
> Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> ---
>  mm/damon/vaddr.c | 114 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 97 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 5cdfdc47c5ff..5f230a427fdc 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -611,11 +611,76 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>  	return max_nr_accesses;
>  }
>  
> +struct damos_va_migrate_private {
> +	struct list_head *migration_lists;
> +	struct damos *scheme;
> +};
> +
> +/*
> + * Place the given folio in the migration_list corresponding to where the folio
> + * should be migrated.
> + *
> + * The algorithm used here is similar to weighted_interleave_nid()
> + */
> +static void damos_va_migrate_folio(struct folio *folio,
> +		struct vm_area_struct *vma, unsigned long addr,
> +		struct damos_migrate_dests *dests,
> +		struct list_head *migration_lists)

Based on the name, I was thinking the function may do the real migration.
What about using more self-introductory name, say,
damos_va_migrate_dests_add()?

> +{
> +	pgoff_t ilx;
> +	int order;
> +	unsigned int target;
> +	unsigned int weight_total = 0;
> +	int i;
> +
> +	/*
> +	 * If dests is empty, there is only one migration list corresponding
> +	 * to s->target_nid.
> +	 */
> +	if (!dests->nr_dests) {
> +		i = 0;
> +		goto isolate;
> +	}
> +
> +	order = folio_order(folio);
> +	ilx = vma->vm_pgoff >> order;
> +	ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
> +
> +	for (i = 0; i < dests->nr_dests; i++)
> +		weight_total += dests->weight_arr[i];
> +
> +	/* If the total weights are somehow 0, don't migrate at all */
> +	if (!weight_total)
> +		return;
> +
> +	target = ilx % weight_total;
> +	for (i = 0; i < dests->nr_dests; i++) {
> +		if (target < dests->weight_arr[i])
> +			break;
> +		target -= dests->weight_arr[i];
> +	}
> +
> +	/* No index being chosen indicates a mistake in the algorithm */
> +	if (i == dests->nr_dests) {
> +		WARN_ONCE(1, "Error determining target interleave node");
> +		return;
> +	}

This cannot happen, right?  Let's just remove this.

> +
> +isolate:
> +	if (!folio_isolate_lru(folio))
> +		return;
> +
> +	list_add(&folio->lru, &migration_lists[i]);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		unsigned long next, struct mm_walk *walk)
>  {
> -	struct list_head *migration_list = walk->private;
> +	struct damos_va_migrate_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	struct list_head *migration_lists = priv->migration_lists;
> +	struct damos_migrate_dests *dests = &s->migrate_dests;

Seems priv->sheme is only a carrier of ->migrate_dests.  Why don't you add that
in damos_va_migrate_private directly?

>  	struct folio *folio;
>  	spinlock_t *ptl;
>  	pmd_t pmde;
> @@ -630,12 +695,8 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	if (!folio)
>  		goto unlock;
>  
> -	if (!folio_isolate_lru(folio))
> -		goto put_folio;
> -
> -	list_add(&folio->lru, migration_list);
> +	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
>  
> -put_folio:
>  	folio_put(folio);
>  unlock:
>  	spin_unlock(ptl);
> @@ -648,7 +709,10 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>  static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
>  		unsigned long enxt, struct mm_walk *walk)
>  {
> -	struct list_head *migration_list = walk->private;
> +	struct damos_va_migrate_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	struct list_head *migration_lists = priv->migration_lists;
> +	struct damos_migrate_dests *dests = &s->migrate_dests;
>  	struct folio *folio;
>  	pte_t ptent;
>  
> @@ -660,12 +724,8 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
>  	if (!folio)
>  		return 0;
>  
> -	if (!folio_isolate_lru(folio))
> -		goto out;
> -
> -	list_add(&folio->lru, migration_list);
> +	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
>  
> -out:
>  	folio_put(folio);
>  	return 0;
>  }
> @@ -717,34 +777,54 @@ static unsigned long damos_va_migrate(struct damon_target *target,
>  		struct damon_region *r, struct damos *s,
>  		unsigned long *sz_filter_passed)
>  {
> -	LIST_HEAD(folio_list);
> +	struct damos_va_migrate_private priv;
>  	struct task_struct *task;
>  	struct mm_struct *mm;
> +	int nr_dests;
> +	int nid;
> +	bool use_target_nid;
>  	unsigned long applied = 0;
> +	struct damos_migrate_dests *dests = &s->migrate_dests;
>  	struct mm_walk_ops walk_ops = {
>  		.pmd_entry = damos_va_migrate_pmd_entry,
>  		.pte_entry = damos_va_migrate_pte_entry,
>  		.walk_lock = PGWALK_RDLOCK,
>  	};
>  
> +	use_target_nid = dests->nr_dests == 0;
> +	nr_dests = use_target_nid ? 1 : dests->nr_dests;
> +	priv.scheme = s;
> +	priv.migration_lists = kmalloc_array(nr_dests,
> +		sizeof(struct list_head), GFP_KERNEL);

sizeof(*priv.migration_lists)?

> +	if (!priv.migration_lists)
> +		return 0;
> +
> +	for (int i = 0; i < nr_dests; i++)
> +		INIT_LIST_HEAD(&priv.migration_lists[i]);
> +
>  	task = damon_get_task_struct(target);
>  	if (!task)
> -		return 0;
> +		goto free_lists;
>  
>  	mm = damon_get_mm(target);
>  	if (!mm)
>  		goto put_task;
>  
>  	mmap_read_lock(mm);
> -	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &folio_list);
> +	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &priv);
>  	mmap_read_unlock(mm);
>  	mmput(mm);
>  
> -	applied = damon_migrate_pages(&folio_list, s->target_nid);
> -	cond_resched();
> +	for (int i = 0; i < nr_dests; i++) {
> +		nid = use_target_nid ? s->target_nid : dests->node_id_arr[i];
> +		applied += damon_migrate_pages(&priv.migration_lists[i], nid);
> +		cond_resched();
> +	}
>  
>  put_task:
>  	put_task_struct(task);
> +free_lists:
> +	kfree(priv.migration_lists);
>  	return applied * PAGE_SIZE;
>  }
>  
> -- 
> 2.43.5
> 
> 


Thanks,
SJ
