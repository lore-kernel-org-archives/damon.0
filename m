Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914722D3ED1;
	Sun, 30 Aug 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788108529; cv=none; b=pCgeMQxMvmh0MXY0kSh36wkUTaXAGIrWd7DbHpWk/G/vRzg5aK6cZkhlMVpMN9BqU+fennhlulCf0YB6tdLxBjAL2UhAHfhqkFtv3Lh2snsPMGRVfq3xpAzmH35CO7Tihm+NW7h6bEgz7egesctM71oKrdemeoW8kja1D/lEHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788108529; c=relaxed/simple;
	bh=sLgZVCZrLIOvQ3XMGFAaF99G2Af0Q4gko4ca181qTMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9Neu36P6peXs3zS9l/6jGslpvxLGzP5m6INcwd3sRlZE+ewepVl2pQgGRC9DQU6HcSsm1t24PCVaSrzXdc2M+rDwGamqb4I2ofC4R3em0skF+aqxcH6jzoTGjjuGnxBIgtlJsW58LOtcvk8zDtc5ynjrO3AVXNGYV9EgHsURrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alleFJ3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alleFJ3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E621F000E9;
	Sun, 30 Aug 2026 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788108528;
	bh=pzu+ACkuwUxOrchSybuObnY6MIz1l+8zvuyyHN0CqRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=alleFJ3/WMBQoZD+8zwyyiLEGd0cTl0GKTN52DYrQFDRvVW6EgqTuD/QRRKxP6+Gk
	 0QgsFSBBursCxqkLwNJz8fg+fxD6m4NX+SwLgEKdbx9rb1lKxAZms1FQgwZrkeON3I
	 9YdDua1nep0yilZ/Yx1SxJQf7fvjJIzEXVJgaYgCJjTCN6FjmHT2xQeTsP/h7KHQP/
	 qQmNx5Y1qL+EkvykG0VC4x8aELSYYcuBmaiP1gCYOEi/IzX/DDNwcXjdHi5DUhG2Kg
	 EPWshzwU/2iNxo+18UbI/EQuYqoK3dGgHnWlPqGPwy65iwYI1w5169mF8y+ZKIP/aW
	 4sOQErbfdq9Ag==
From: SJ Park <sj@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Sun, 30 Aug 2026 09:48:40 -0700
Message-ID: <20260830164841.103180-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830051407.50008-3-kiyer@crusoe.ai>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 22:14:03 -0700 Krishna Iyer <kiyer@crusoe.ai> wrote:

> damon_folio_mkold_one() and damon_folio_young_one() assume the folios
> they walk are mapped by normal PTEs or THP PMDs.  When the folio is a
> hugetlb folio, page_vma_mapped_walk() returns the huge PTE in pvmw.pte
> with its page table lock held, but the walkers treat it as a normal
> PTE: they read and age it with PAGE_SIZE-granularity helpers, which is
> wrong for huge PTEs (up to PUD level), and notify secondary MMUs for
> only PAGE_SIZE of the mapping.
> 
> Add hugetlb branches to both walkers.  The mkold walker reuses
> damon_hugetlb_mkold(), which the virtual address space operations set
> has been using for hugetlb aging: it clears the young bit of the huge
> PTE via set_huge_pte_at() and calls mmu_notifier_clear_young() spanning
> the whole huge page size.  The young walker gets an equivalent new
> helper, damon_hugetlb_young(), which reads the huge PTE with
> huge_ptep_get() and consults the page idle flag and
> mmu_notifier_test_young() like the existing PTE branch.
> 
> Locking mirrors what page_vma_mapped_walk() provides: the huge PTE's
> page table lock is held inside the walk, and for shared hugetlb
> mappings (the only ones subject to huge PMD sharing), rmap_walk_file()
> already holds i_mmap_rwsem, satisfying hugetlb_walk()'s locking
> requirements.
> 
> This is currently dead code: both rmap walkers are only reachable
> through damon_get_folio(), which rejects hugetlb folios since they are
> not on the LRU lists.  A following commit will let the physical address
> space monitoring primitives opt in to hugetlb folios.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
> ---
>  mm/damon/ops-common.c | 63 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index f5fe92b825bb..62004206ca31 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -193,10 +193,20 @@ static bool damon_folio_mkold_one(struct folio *folio,
>  
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		addr = pvmw.address;
> -		if (pvmw.pte)
> -			damon_ptep_mkold(pvmw.pte, vma, addr);
> -		else
> +		if (pvmw.pte) {
> +			/*
> +			 * For hugetlb folios, page_vma_mapped_walk() sets
> +			 * pvmw.pte to the huge PTE with its page table lock
> +			 * held.
> +			 */

This comment looks too verbose.  Let's drop.

> +			if (folio_test_hugetlb(folio))
> +				damon_hugetlb_mkold(pvmw.pte, vma->vm_mm, vma,
> +						addr);
> +			else
> +				damon_ptep_mkold(pvmw.pte, vma, addr);
> +		} else {
>  			damon_pmdp_mkold(pvmw.pmd, vma, addr);
> +		}
>  	}
>  	return true;
>  }
> @@ -221,6 +231,24 @@ void damon_folio_mkold(struct folio *folio)
>  
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE
> +static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
> +		unsigned long addr, struct folio *folio)
> +{
> +	pte_t entry = huge_ptep_get(vma->vm_mm, addr, pte);
> +
> +	return (pte_present(entry) && pte_young(entry)) ||
> +		!folio_test_idle(folio) ||
> +		mmu_notifier_test_young(vma->vm_mm, addr);
> +}
> +#else
> +static bool damon_hugetlb_young(pte_t *pte, struct vm_area_struct *vma,
> +		unsigned long addr, struct folio *folio)
> +{
> +	return false;
> +}
> +#endif	/* CONFIG_HUGETLB_PAGE */
> +
>  static bool damon_folio_young_one(struct folio *folio,
>  		struct vm_area_struct *vma, unsigned long addr, void *arg)
>  {
> @@ -232,16 +260,29 @@ static bool damon_folio_young_one(struct folio *folio,
>  	while (page_vma_mapped_walk(&pvmw)) {
>  		addr = pvmw.address;
>  		if (pvmw.pte) {
> -			pte = ptep_get(pvmw.pte);
> -
>  			/*
> -			 * PFN swap PTEs, such as device-exclusive ones, that
> -			 * actually map pages are "old" from a CPU perspective.
> -			 * The MMU notifier takes care of any device aspects.
> +			 * For hugetlb folios, page_vma_mapped_walk() sets
> +			 * pvmw.pte to the huge PTE with its page table lock
> +			 * held.
>  			 */

Again, this new comment looks unnecessary.  Let's drop.

> -			*accessed = (pte_present(pte) && pte_young(pte)) ||
> -				!folio_test_idle(folio) ||
> -				mmu_notifier_test_young(vma->vm_mm, addr);
> +			if (folio_test_hugetlb(folio)) {
> +				*accessed = damon_hugetlb_young(pvmw.pte, vma,
> +						addr, folio);
> +			} else {
> +				pte = ptep_get(pvmw.pte);
> +
> +				/*
> +				 * PFN swap PTEs, such as device-exclusive
> +				 * ones, that actually map pages are "old"
> +				 * from a CPU perspective. The MMU notifier
> +				 * takes care of any device aspects.
> +				 */
> +				*accessed = (pte_present(pte) &&
> +						pte_young(pte)) ||
> +					!folio_test_idle(folio) ||
> +					mmu_notifier_test_young(vma->vm_mm,
> +							addr);
> +			}

I feel like the indentation becomes too deep.  Could we split out this into
another static function, say, damon_pte_young()?

>  		} else {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  			pmd_t pmd = pmdp_get(pvmw.pmd);
> -- 
> 2.54.0

Other than the above two simple things, this patch looks good to me.


Thanks,
SJ
