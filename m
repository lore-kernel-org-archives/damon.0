Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DCEC121
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 21:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68E5C4339B;
	Fri,  2 Jun 2023 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685742891;
	bh=gCs8lv7QzbHnoWxQdwszcYV+QYvUCCO1/czQtJohcFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ts7sAD57zMu7vNGEpDIixZvsiCJOZ80qVMELZ4CaImTurenx2HP26g13kCMI3Bffm
	 3UiQfr0XQOhK3uV65sXsNKniBv0Vq7wHx/6q3alx5oUnt97bTptVmunhDmaIp5AT10
	 JayT2NdmOxOq2na3VbRxvvCYCAsW+cPy+p+Ks1iIFHud46AI2g5vvwwcwrvAlj0CNi
	 YYkAzjXX67DfIU7VbUAP7EXfYc4vKM7qx6EzIsqM5uMM33aytyfGTP5WsK1/xlOX/d
	 P/oaziCvx8iFLG+gxDhd2tm4HrV/dbkLrcGUhoYm4IVNrvgLB288ByElyoY/Ch9SJT
	 hyCq98DJScunQ==
From: SeongJae Park <sj@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 3/4] mm/damon/ops-common: Refactor to use {pte|pmd}p_clear_young_notify()
Date: Fri,  2 Jun 2023 21:54:49 +0000
Message-Id: <20230602215449.107659-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602092949.545577-4-ryan.roberts@arm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ryan,

On Fri, 2 Jun 2023 10:29:48 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> With the fix in place to atomically test and clear young on ptes and
> pmds, simplify the code to handle the clearing for both the primary mmu
> and the mmu notifier with a single API call.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/ops-common.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index acc264b97903..d4ab81229136 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -39,21 +39,12 @@ struct folio *damon_get_folio(unsigned long pfn)
>  
>  void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
>  {
> -	bool referenced = false;
>  	struct folio *folio = damon_get_folio(pte_pfn(*pte));
>  
>  	if (!folio)
>  		return;
>  
> -	if (ptep_test_and_clear_young(vma, addr, pte))
> -		referenced = true;
> -
> -#ifdef CONFIG_MMU_NOTIFIER
> -	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
> -		referenced = true;
> -#endif /* CONFIG_MMU_NOTIFIER */
> -
> -	if (referenced)
> +	if (ptep_clear_young_notify(vma, addr, pte))
>  		folio_set_young(folio);
>  
>  	folio_set_idle(folio);
> @@ -63,21 +54,12 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>  void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	bool referenced = false;
>  	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
>  
>  	if (!folio)
>  		return;
>  
> -	if (pmdp_test_and_clear_young(vma, addr, pmd))
> -		referenced = true;
> -
> -#ifdef CONFIG_MMU_NOTIFIER
> -	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE))
> -		referenced = true;
> -#endif /* CONFIG_MMU_NOTIFIER */
> -
> -	if (referenced)
> +	if (pmdp_clear_young_notify(vma, addr, pmd))
>  		folio_set_young(folio);
>  
>  	folio_set_idle(folio);
> -- 
> 2.25.1
> 
> 
