Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234414A4CC;
	Thu,  3 Jul 2025 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751503879; cv=none; b=UHWiD8pDZgSEdnmjI6oDqlblShxsnrqq/v+75Ixx4dax7L5Sxif6Uk89n3PxFS/iagdSH1HwfB5wuuAxdCTosMyFnN7ZuBrYw7ekOSFfOtzxHCj+d12sX7M9ZVaTly7u3fmXdQr7FZgbc0ZMhhHL9UX+tqZPJH+IlRyD44wM26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751503879; c=relaxed/simple;
	bh=79aaVnD4tqItZ8SHXeEkYCBAgpkFHISaXgz2yNItgc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huMgVMB61PalA+m/rdvKgZ1HlkFN2WXrKzjDCsxpcQsHOUX4xrGuohoBxY7ntxrOJeYHJ5r3gv2oHbuivovLw/hZ2yuD0KM7m5KoaD+rQvhHHioxfVXH5ThoXVnDnIkURBu4khc41XUa+92g5/v3ZDAZyvD1DoMzdo+g6swwCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkz9TD/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkz9TD/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23142C4CEE7;
	Thu,  3 Jul 2025 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751503877;
	bh=79aaVnD4tqItZ8SHXeEkYCBAgpkFHISaXgz2yNItgc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkz9TD/vAsLJ0xpNJ8ZLq8Ty4cVX2k62BGmftOZFm5iHZXRxi/IoNuUqmK2q34GVL
	 fVXOQnF0C8zrUDYOsSe09xodsW7Orf7R6MveFgEA12dZ1bb72FUGdpHkFMPvKbQef0
	 Xx7vAOBPOwp4N9T42UWU+9eWvGiol9oQ9ob7S7xIB+3FyX47Nj37hdJrKbLqm5G8gY
	 VDw33EXOhVUQeyRAFMof8ZwvR5bYBudNHc45DHbEHL0HZtmKb5dvLoSSEcYeGCTD0n
	 ceGVAycWp3BDJcdtNLP1vs/z3SLUqMoV2/pDlSzC2Z8Xv8q3GYif7hNTz1Y+5AY5xD
	 tFbdC66wdygzg==
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
Subject: Re: [RFC PATCH v3 13/13] mm/damon/vaddr: Apply filters in migrate_{hot/cold}
Date: Wed,  2 Jul 2025 17:51:15 -0700
Message-Id: <20250703005115.57803-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-14-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:36 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> The paddr versions of migrate_{hot/cold} filter out folios from
> migration based on the scheme's filters. This patch does the same for
> the vaddr versions of those schemes.
> 
> The filtering code is mostly the same for the paddr and vaddr versions.
> The exception is the young filter. paddr determines if a page is young
> by doing a folio rmap walk to find the page table entries corresponding
> to the folio. However, vaddr schemes have easier access to the page
> tables, so we add some logic to avoid the extra work.
> 
> Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> ---
>  mm/damon/vaddr.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 5f230a427fdc..2a485bf19101 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -611,6 +611,62 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>  	return max_nr_accesses;
>  }
>  
> +static bool damos_va_filter_young(struct damos_filter *filter,
> +		struct folio *folio, struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep, pmd_t *pmdp)
> +{
> +	bool young;
> +
> +	if (ptep) {
> +		young = pte_young(*ptep);

Let's use ptep_get().

> +	} else if (pmdp) {
> +		young = pmd_young(*pmdp);

Let's use pmdp_get().

> +	} else {
> +		WARN_ONCE(1, "Neither ptep nor pmdp provided");
> +		return false;
> +	}

Can this really happen?  If so, let's remove WARN_ONCE().  If not, let's drop
the entire else case.

> +
> +	young = young || !folio_test_idle(folio) ||
> +		mmu_notifier_test_young(vma->vm_mm, addr);
> +
> +	if (young && ptep)
> +		damon_ptep_mkold(ptep, vma, addr);
> +	else if (young && pmdp)
> +		damon_pmdp_mkold(pmdp, vma, addr);
> +
> +	return young == filter->matching;

I now realize this function is not returning if the folio is young, but if the
youngness matches the filter.  Let's rename, say,
damos_va_filter_young_match()?

> +}
> +
> +static bool damos_va_filter_out(struct damos *scheme, struct folio *folio,
> +		struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, pmd_t *pmdp)
> +{
> +	struct damos_filter *filter;
> +	bool matched;
> +
> +	if (scheme->core_filters_allowed)
> +		return false;
> +
> +	damos_for_each_ops_filter(filter, scheme) {
> +		/*
> +		 * damos_folio_filter_match checks the young filter by doing an
> +		 * rmap on the folio to find its page table. However, being the
> +		 * vaddr scheme, we have direct access to the page tables, so
> +		 * use that instead.
> +		 */
> +		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
> +			matched = damos_va_filter_young(filter, folio, vma,
> +				addr, ptep, pmdp);
> +		} else {
> +			matched = damos_folio_filter_match(filter, folio);
> +		}

Let's drop enclosing braces for single line if-esle statements.

> +
> +		if (matched)
> +			return !filter->allow;
> +	}
> +	return scheme->ops_filters_default_reject;
> +}
> +
>  struct damos_va_migrate_private {
>  	struct list_head *migration_lists;
>  	struct damos *scheme;
> @@ -695,8 +751,12 @@ static int damos_va_migrate_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	if (!folio)
>  		goto unlock;
>  
> +	if (damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd))
> +		goto put_folio;
> +
>  	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
>  
> +put_folio:
>  	folio_put(folio);
>  unlock:
>  	spin_unlock(ptl);
> @@ -724,8 +784,12 @@ static int damos_va_migrate_pte_entry(pte_t *pte, unsigned long addr,
>  	if (!folio)
>  		return 0;
>  
> +	if (damos_va_filter_out(s, folio, walk->vma, addr, pte, NULL))
> +		goto put_folio;
> +
>  	damos_va_migrate_folio(folio, walk->vma, addr, dests, migration_lists);
>  
> +put_folio:
>  	folio_put(folio);
>  	return 0;
>  }
> -- 
> 2.43.5
> 
> 


Thanks,
SJ
