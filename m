Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3536A01E;
	Thu,  2 Jul 2026 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990430; cv=none; b=BGFCRPqBNzdkLA4neRg9AHWy/pRE0zOoS0g7AzCEV7dXzJPF92mVASo82Hnp3SEi1UWNNs0PRJ45szydfHuhoNJcq+tX5wKIN803YLjFAsrdZec0KizxKSkX37XugxjwzW1JsNKHFNqCD2R1x/U/XtAer1Qgg/urlRvDN7fHRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990430; c=relaxed/simple;
	bh=Y3Jny+C+WpwhQ3V+DCjvK1z/vLtgAy8jJFmBnCFy5pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxNIPCE/dca3CRX2/1lj9a1gwl8Da96oWlWx48XUzwzoEEv5ZWO786ohDCWi8canSkpUL7vD1j6KC4iBf+VghSjGlzybq+QGygJzwSD1P8JqcyBeq9Zb5nfF+3femBTlFL0UM+qP4PIc//f0e3JonNGo7mqo36JIU/gnvC5NHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElFvPb1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElFvPb1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF591F000E9;
	Thu,  2 Jul 2026 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782990428;
	bh=4d1wkfMy/kn2HrMiby9/+qbShSv+iY/X8urJnQHH9sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ElFvPb1V13j7MFUteyYeiivDlYBLd1UZ1toxNM2jRHdSJy7T99kf2oGuENCoV8EAA
	 4RZYzHAdmSmNiSp6TMtPg4TndbCz9NxwB0wcdr4qqtZllzxJZ3mwmSoiG7rxce+Jsa
	 cUqb21JiJWR/XzTWtgBcFwmZxZT94zJJnZabSIWHh8ANvI6d2iLtUvykmmkJsYtIgj
	 JK1+EmHk1yZ5QkuC+UWyTmb6Q/qJ0g5f3hWmqkjqhX2hTGhcO6YhAnxw5qpV7kH0aV
	 +mnYn7rPsjWeHpAvEcOlc9WMVedEHP573+HoRYqnz2t/m6cAeWfGE4Qc0SUF0sR6OO
	 RblHvFEojOWkw==
Date: Thu, 2 Jul 2026 12:07:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	daichaobing@sangfor.com.cn, kunwu.chan@gmail.com, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add
 damon_collapse_folio_range() for external callers
Message-ID: <akZDj6s8U5_Mnetv@lucifer>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <20260702094633.75658-3-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702094633.75658-3-lianux.mm@gmail.com>

(+cc missing people again)

Sorry but we're not going to accept anything that exports THP logic like this at
all.

And a damon wrapper in core mm code is just a non-starter, so you really need to
rethink your approach.

I think SJ already commented on this in your v1 from what I can see? I'd listen
to his advice on this :)

On Thu, Jul 02, 2026 at 05:46:30PM +0800, Lian Wang wrote:
> Export a thin wrapper around collapse_huge_page() that allows external
> subsystems such as DAMON to trigger THP collapse on a target address
> range.
>
> Currently restricted to PMD order (HPAGE_PMD_ORDER), since
> collapse_huge_page() does not yet support arbitrary mTHP orders.
> The restriction can be relaxed when khugepaged gains mTHP support.
>
> The caller must hold a reference to @mm.  Do not hold mmap lock:
> collapse_huge_page() acquires mmap_read_lock for validation, releases
> it, then acquires mmap_write_lock for the actual collapse.  Holding
> an outer mmap_read_lock would cause a self-deadlock when the same
> thread attempts the inner mmap_write_lock.
>
> Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.wang@processmission.com>

This patch is exporting internal mm logic without proper safeguards so it's just
not something we're going to accept, sorry.

(Also not sure it's correct to have multiple S-o-b for the same person (unless
re-tagging a backport or something)? I'm not sure though)

> ---
>  include/linux/khugepaged.h |  9 ++++++++
>  mm/khugepaged.c            | 46 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index d7a9053ff4fe..f7d49cba712f 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -20,6 +20,9 @@ extern bool current_is_khugepaged(void);
>  void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  		bool install_pmd);
>
> +int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start_addr,
> +			       unsigned int target_order);

No thanks. We're not putting damon wrappers into core code. This is breaking the
abstraction and letting arbitrary users invoke internal mm logic.

Plus you're literally exporting this so it can be abused by drivers.

> +
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
>  	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> @@ -47,6 +50,12 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
>  {
>  }
>
> +static inline int damon_collapse_folio_range(struct mm_struct *mm,
> +		unsigned long start_addr, unsigned int target_order)
> +{
> +	return -EINVAL;
> +}
> +
>  static inline void khugepaged_min_free_kbytes_update(void)
>  {
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 617bca76db49..7fe9ce1e0533 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -3272,3 +3272,49 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
>  			: madvise_collapse_errno(last_fail);
>  }
> +
> +/**
> + * damon_collapse_folio_range() - Collapse base pages in range into a THP
> + * @mm:         mm_struct of the target process
> + * @start_addr: start address (must be order-aligned)
> + * @target_order: page order of the collapse result (currently only
> + *                HPAGE_PMD_ORDER is supported)
> + *
> + * Thin wrapper around collapse_huge_page() for external callers such as
> + * DAMON.  The caller must hold a reference to @mm.  Do not hold mmap

This is really fragile and bug bait.

> + * lock: collapse_huge_page() acquires mmap_read_lock for validation,

This is just gross, you're now collapsing based on an outdated concept of
what the current VMA state is...

You're also losing literally everything that madvise_collapse() does.

AND you're overriding THP limitations like max_ptes_none, which is horrible...

> + * releases it, then acquires mmap_write_lock for the collapse.  Holding
> + * an outer mmap_read_lock would self-deadlock.

This is a sign the interface is wrong!

> + *
> + * Return: 0 on success, -EINVAL on bad arguments, negative error from
> + *         madvise_collapse_errno() otherwise.
> + */
> +int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start_addr,
> +			       unsigned int target_order)
> +{
> +	struct collapse_control *cc;
> +	enum scan_result result;
> +
> +	if (target_order != HPAGE_PMD_ORDER) {
> +		pr_warn_once("%s: only PMD order (%u) is supported, got %u\n",
> +			     __func__, HPAGE_PMD_ORDER, target_order);
> +		return -EINVAL;
> +	}
> +	if (start_addr & ((PAGE_SIZE << target_order) - 1))
> +		return -EINVAL;
> +
> +	cc = kmalloc_obj(*cc);
> +	if (!cc)
> +		return -ENOMEM;
> +	cc->is_khugepaged = false;
> +	cc->progress = 0;
> +
> +	lru_add_drain_all();

This is quite literally a copy/paste from madvise_collapse(). No no no :) code
duplication like this is also unacceptable.

> +
> +	result = collapse_huge_page(mm, start_addr, 1, 0, cc, target_order);
> +	kfree(cc);
> +	if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
> +		return 0;
> +	return madvise_collapse_errno(result);
> +}
> +EXPORT_SYMBOL_GPL(damon_collapse_folio_range);

We _definitely_ cannot have internal mm logic _exported_.

Yeah sorry you need to rethink this.

Thanks, Lorenzo
