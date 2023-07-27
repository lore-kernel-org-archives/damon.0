Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514991CA0A
	for <damon@lists.linux.dev>; Thu, 27 Jul 2023 21:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3F2C433C9;
	Thu, 27 Jul 2023 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690494800;
	bh=Y3Xmaq/xTIj2r6AHGezOL4uhwn8qF3iH6+f0u/RI6rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRxP92P/stHqjvuis4AuCMW2avLQAKUzM4EQjZEhatWhnIKf0crT/tVy71isi/IMa
	 d/GA0VqH09UbRGsIoNxztvM1e84wd3K/jHpF32HpB6WbJFeoQmnznf3rpuBooA8Vxg
	 7kdPEva+zMQwe8g7eaxAsk01mrHvH1Xpp3Den2NWpUMa0LvbJ2R/KngxlatoavhedI
	 o2AvdI2tJBSsBTv32SGAF3Y/8mT1OaY2i/z83/eJ9g8F6bIfKqArpdmOXdvul08n3O
	 yDealoqZHntihTZg4n4baAQskMqpxHen0o//hmwEoSdqCvgbRBoPZK9J8LE2Qdtwq9
	 PiEOltJy4lQTA==
From: SeongJae Park <sj@kernel.org>
To: Levi Yun <ppbuk5246@gmail.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] damon: Use pmdp_get instead of drectly dereferencing pmd.
Date: Thu, 27 Jul 2023 21:53:18 +0000
Message-Id: <20230727215318.43455-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727212157.2985025-1-ppbuk5246@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Levi,


Thank you for quick respin.

I still hope the subject to drop the ending period, and start the subject with
lowercase, like other mm/damon/ commits.

On Fri, 28 Jul 2023 06:21:57 +0900 Levi Yun <ppbuk5246@gmail.com> wrote:

> As ptep_get, Use the pmdp_get wrapper when we accessing pmdval
> instead of directly dereferencing pmd.

Based on the usual git commit message line length recommendation (72
characters), there is nothing really wrong, but putting 'instead' at the first
line may look more consistent with other messages.

> 
> Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> ---

Since this is the good place to put additional comments not suitable for the
changelog[2], it would be helpful if you could put changes of this patch that
made after the v1 here, from next time.

Above comments are only my trivial and personal preferences, so I wouldn't ask
you to respin, unless you really want to.

Reviewed-by: SeongJae Park <sj@kernel.org>

[1] https://github.com/torvalds/linux/pull/17
[2] https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format


Thanks,
SJ

>  mm/damon/ops-common.c |  2 +-
>  mm/damon/paddr.c      |  2 +-
>  mm/damon/vaddr.c      | 23 +++++++++++++++--------
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index e940802a15a4..ac1c3fa80f98 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -54,7 +54,7 @@ void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr
>  void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	struct folio *folio = damon_get_folio(pmd_pfn(*pmd));
> +	struct folio *folio = damon_get_folio(pmd_pfn(pmdp_get(pmd)));
>  
>  	if (!folio)
>  		return;
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 40801e38fcf0..909db25efb35 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -94,7 +94,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
>  				mmu_notifier_test_young(vma->vm_mm, addr);
>  		} else {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -			*accessed = pmd_young(*pvmw.pmd) ||
> +			*accessed = pmd_young(pmdp_get(pvmw.pmd)) ||
>  				!folio_test_idle(folio) ||
>  				mmu_notifier_test_young(vma->vm_mm, addr);
>  #else
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 2fcc9731528a..d01cc46f4bf4 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -301,16 +301,19 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  		unsigned long next, struct mm_walk *walk)
>  {
>  	pte_t *pte;
> +	pmd_t pmde;
>  	spinlock_t *ptl;
>  
> -	if (pmd_trans_huge(*pmd)) {
> +	if (pmd_trans_huge(pmdp_get(pmd))) {
>  		ptl = pmd_lock(walk->mm, pmd);
> -		if (!pmd_present(*pmd)) {
> +		pmde = pmdp_get(pmd);
> +
> +		if (!pmd_present(pmde)) {
>  			spin_unlock(ptl);
>  			return 0;
>  		}
>  
> -		if (pmd_trans_huge(*pmd)) {
> +		if (pmd_trans_huge(pmde)) {
>  			damon_pmdp_mkold(pmd, walk->vma, addr);
>  			spin_unlock(ptl);
>  			return 0;
> @@ -439,21 +442,25 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct damon_young_walk_private *priv = walk->private;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (pmd_trans_huge(*pmd)) {
> +	if (pmd_trans_huge(pmdp_get(pmd))) {
> +		pmd_t pmde;
> +
>  		ptl = pmd_lock(walk->mm, pmd);
> -		if (!pmd_present(*pmd)) {
> +		pmde = pmdp_get(pmd);
> +
> +		if (!pmd_present(pmde)) {
>  			spin_unlock(ptl);
>  			return 0;
>  		}
>  
> -		if (!pmd_trans_huge(*pmd)) {
> +		if (!pmd_trans_huge(pmde)) {
>  			spin_unlock(ptl);
>  			goto regular_page;
>  		}
> -		folio = damon_get_folio(pmd_pfn(*pmd));
> +		folio = damon_get_folio(pmd_pfn(pmde));
>  		if (!folio)
>  			goto huge_out;
> -		if (pmd_young(*pmd) || !folio_test_idle(folio) ||
> +		if (pmd_young(pmde) || !folio_test_idle(folio) ||
>  					mmu_notifier_test_young(walk->mm,
>  						addr))
>  			priv->young = true;
> -- 
> 2.37.2
> 
> 
