Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5925236A9F;
	Wed,  2 Jul 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751500301; cv=none; b=FWmWunhh3BFsHak+Q5f5Vl1/7gNe6U6W2GQ3lObC9v9jv81Pi8ELrzpWGmTrrhqylHkCmM8S+2Iun4Ds12czG8H8V8HC9GRqFA41F6zCamqfE530UcXNch58cQuMVwG4HcPbKJbWmhFDkUBA044SRQ5X6VLEUbDZ5sVN1fzAfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751500301; c=relaxed/simple;
	bh=phXhRif4QEx6/qVW8NoYnau8fG9rcxcu4dhrIomKfiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PF4eBI5flIj1AU3qPqlzRoUzKLRCOOdk1lLShoZJ4FhKsQ+5mgfNCxH7RVhwSrMavyio7pWUoKxF5In6fTHFlqzwwqffv8rOhsTkBIlIwqG+jMpbqCLvp32ITHB0kLuw2ezPcgMEGkjp0mvuz+vpuXwU+r9STAokJbVQzIr1Kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmRc81Fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmRc81Fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B92C4CEE7;
	Wed,  2 Jul 2025 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751500300;
	bh=phXhRif4QEx6/qVW8NoYnau8fG9rcxcu4dhrIomKfiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmRc81FzvYLXerzuw68/k+ABrjneyRG/WsseBhXMWJhEDHyHQw+IKVDOjr+DX9BJb
	 lyMAIFg4uFGrmEthFp/rur4P5M9TG0RQI833SezpOkbFCQ/FF5Bk+J1vhPKgpyzKNj
	 ajaHWw0eJlbbWcxR81fbnBZdq2WbgEHKP5/ekdSsY9Aje5hS6J0RpieeCq8G89lU/i
	 /uncvHSJVB0N33IIJNJNUQojeBCMC58ffRg+HQzNMlm1YjsDk4uF5DYpNSnbbCLYOi
	 zQRb+JFbNViTjD57YQZYCnH4ael3xCcp2Hl9fytDNJKaqg2NqDKis6W6ydUU4ZAqAx
	 uMG912n8ySdpA==
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
Subject: Re: [RFC PATCH v3 09/13] mm/damon/vaddr: Add vaddr versions of migrate_{hot,cold}
Date: Wed,  2 Jul 2025 16:51:38 -0700
Message-Id: <20250702235138.56720-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-10-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:32 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> migrate_{hot,cold} are paddr schemes that are used to migrate hot/cold
> data to a specified node. However, these schemes are only available when
> doing physical address monitoring. This patch adds an implementation for
> them virtual address monitoring as well.
> 
> Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> ---
>  mm/damon/vaddr.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 46554e49a478..5cdfdc47c5ff 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -15,6 +15,7 @@
>  #include <linux/pagewalk.h>
>  #include <linux/sched/mm.h>
>  
> +#include "../internal.h"
>  #include "ops-common.h"
>  
>  #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
> @@ -610,6 +611,65 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>  	return max_nr_accesses;
>  }
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)

I'd suggest to put CONFIG_TRANSPARENT_HUGEPAGE check into the body of this
function and handle both pmd and pte here, consistent to
damon_young_pmd_entry().

> +{
> +	struct list_head *migration_list = walk->private;
> +	struct folio *folio;
> +	spinlock_t *ptl;
> +	pmd_t pmde;
> +
> +	ptl = pmd_lock(walk->mm, pmd);
> +	pmde = pmdp_get(pmd);
> +
> +	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
> +		goto unlock;
> +
> +	folio = damon_get_folio(pmd_pfn(pmde));
> +	if (!folio)
> +		goto unlock;
> +
> +	if (!folio_isolate_lru(folio))
> +		goto put_folio;
> +
> +	list_add(&folio->lru, migration_list);
> +
> +put_folio:
> +	folio_put(folio);
> +unlock:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damos_va_migrate_pmd_entry NULL
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
> +		unsigned long enxt, struct mm_walk *walk)

Nit.  s/enxt/next/ ?

> +{
> +	struct list_head *migration_list = walk->private;
> +	struct folio *folio;
> +	pte_t ptent;
> +
> +	ptent = ptep_get(pte);
> +	if (pte_none(*pte) || !pte_present(*pte))
> +		return 0;

Shouldn't we use cached pte value (ptent) instad of *pte?  I'd suggest merging
this into damos_va_migrate_pmd_entry() consistent to damon_young_pmd_entry().

> +
> +	folio = damon_get_folio(pte_pfn(ptent));
> +	if (!folio)
> +		return 0;
> +
> +	if (!folio_isolate_lru(folio))
> +		goto out;
> +
> +	list_add(&folio->lru, migration_list);
> +
> +out:
> +	folio_put(folio);
> +	return 0;
> +}
> +
>  /*
>   * Functions for the target validity check and cleanup
>   */
> @@ -653,6 +713,41 @@ static unsigned long damos_madvise(struct damon_target *target,
>  }
>  #endif	/* CONFIG_ADVISE_SYSCALLS */
>  
> +static unsigned long damos_va_migrate(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	LIST_HEAD(folio_list);
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	unsigned long applied = 0;
> +	struct mm_walk_ops walk_ops = {
> +		.pmd_entry = damos_va_migrate_pmd_entry,
> +		.pte_entry = damos_va_migrate_pte_entry,
> +		.walk_lock = PGWALK_RDLOCK,
> +	};
> +
> +	task = damon_get_task_struct(target);
> +	if (!task)
> +		return 0;
> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		goto put_task;
> +
> +	mmap_read_lock(mm);
> +	walk_page_range(mm, r->ar.start, r->ar.end, &walk_ops, &folio_list);
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	applied = damon_migrate_pages(&folio_list, s->target_nid);
> +	cond_resched();
> +
> +put_task:
> +	put_task_struct(task);

Seems task is not being used in real, so this variable and the related code in
this function can be removed?  Or, am I missing something?

> +	return applied * PAGE_SIZE;
> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme, unsigned long *sz_filter_passed)
> @@ -675,6 +770,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  	case DAMOS_NOHUGEPAGE:
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
> +	case DAMOS_MIGRATE_HOT:
> +	case DAMOS_MIGRATE_COLD:
> +		return damos_va_migrate(t, r, scheme, sz_filter_passed);
>  	case DAMOS_STAT:
>  		return 0;
>  	default:
> @@ -695,6 +793,10 @@ static int damon_va_scheme_score(struct damon_ctx *context,
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
>  		return damon_cold_score(context, r, scheme);
> +	case DAMOS_MIGRATE_HOT:
> +		return damon_hot_score(context, r, scheme);
> +	case DAMOS_MIGRATE_COLD:
> +		return damon_cold_score(context, r, scheme);
>  	default:
>  		break;
>  	}
> -- 
> 2.43.5


Thanks,
SJ
