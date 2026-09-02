Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403553859C2;
	Wed,  2 Sep 2026 05:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326262; cv=none; b=QF1NBfTtIehW8zPUOOB8N83sno7Wtgt61j0t18xwhdWQX8jtirq2oPWkz+wxDUUsWRY0Gqb7/WvVv3QE4AInVsJvHY2BEExBSEBnJUp7JKuNJ3G1j2bKrbuEreA/OBTVK4tza/bz6EKfIumMM5o5zg2UO8WelCnEPuxiCtcmuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326262; c=relaxed/simple;
	bh=h4aTff5SpAEig8WQPWo54WUYF0Jtz7syKZ1hjE0nmkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bm35GNczcwht/gY0w9At/DJXNEt//sJcDGRKf+z6mHw+iP24PF56neRtyBnRXdQI6wjbLE5dCYbPbIVhc0u13hzjE84jrfAKLmIKluV4CQw1ccSqas467dduIgmQ7kXoTmdjasx0lxDul+8Muhk+I+CSLOyMQDfMZiY7/n/QCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUysMIxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUysMIxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E971F000E9;
	Wed,  2 Sep 2026 05:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788326260;
	bh=+TLw6zL3vSpm7FMUBCdrBPYkyQicKr+Z+UYAKZ2UXqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUysMIxOFdJR6EZRow/6+Cl39Xl2LEN0yNLkWLnRXkEOOdLa2//96Sg6VXGgF1YPp
	 owk4idofXqDJZcwdAc0kqziDnsJUsS23WOX4iHSsVfiIALkxEUVMABYRhBgoFx9Tb6
	 vqmnONDU2FzllyP2lUrB0iONj8NUTqZgyevsfDjEopSEIp8ZpqbqaEY6L2fXEihRS2
	 BBd17IgyN3XVCpIdll4JgF+22S9ZHjwlEvXNjpB4NHy97HnSZDRr0fFhz1IvvGsr1i
	 TIiQzce8/+uWjGS8hmRez0SgyiJSBZyQTY5rZYQCnTDux8RzgL2fvwGKRIFzuLPTcK
	 eRwwQYrLHJ/PA==
From: SJ Park <sj@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: support hugetlb folios in access monitoring
Date: Tue,  1 Sep 2026 22:17:32 -0700
Message-ID: <20260902051732.90094-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902025700.17975-4-kiyer@crusoe.ai>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 19:57:00 -0700 Krishna Iyer <kiyer@crusoe.ai> wrote:

> DAMON's physical address space monitoring is blind to hugetlb-backed
> memory.  Every access check starts at damon_get_folio(), which rejects
> folios that are not on the LRU lists.  Hugetlb folios are managed
> outside of the LRU by design, so every sampling attempt on
> hugetlb-backed memory silently fails and the pages are reported as
> never accessed.
> 
> This is a significant blind spot on virtualization hosts.  Cloud
> hypervisor hosts commonly back guest memory with 1 GiB hugetlbfs pages,
> covering the vast majority of the machine's memory.  On such hosts,
> modules like DAMON_STAT observe only the host-side remainder (page
> cache, daemons) and report all guest working sets as permanently
> idle, defeating the purpose of host-level access monitoring.  In
> testing on a 1 TiB host, an hour of 4-thread random access over 842 GiB
> inside a guest was statistically indistinguishable from an idle host,
> while a 40x smaller host-side workload produced a quantitatively
> correct response.
> 
> Add damon_get_monitor_folio(), which additionally accepts hugetlb
> folios, and use it in the two paddr access monitoring primitives,
> damon_pa_mkold() and damon_pa_young().  With the previous commit
> teaching the folio-granular rmap walkers to age huge PTEs and to call
> the mmu notifiers spanning the whole huge page, this makes guest
> accesses visible through secondary MMU (e.g. KVM/EPT) young bits.
> 
> Free hugetlb pool folios have a zero refcount, so folio_try_get()
> naturally keeps rejecting them.
> 
> The DAMOS action appliers (damon_pa_pageout(),
> damon_pa_mark_accessed_or_deactivate(), damon_pa_migrate(),
> damon_pa_stat()) keep using damon_get_folio(): reclaim, LRU
> manipulation and migration cannot act on hugetlb folios, so their
> behavior is unchanged.
> 
> Note that the access check granularity for hugetlb-backed memory is the
> huge page size: one touched byte reports the whole (up to 1 GiB) page
> as accessed.  Also, DAMON now consumes secondary MMU young bits that
> KVM's own aging uses; at DAMON's sampling rate (one page per region per
> sampling interval) the interference is negligible.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>

Assuming you agree to below suggestion,

Reviewed-by: SJ Park <sj@kernel.org>

> ---
>  mm/damon/ops-common.c | 31 +++++++++++++++++++++++++++----
>  mm/damon/ops-common.h |  1 +
>  mm/damon/paddr.c      |  4 ++--
>  3 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 373b25db5950..80207b56c6fd 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -15,14 +15,20 @@
>  #include "../internal.h"
>  #include "ops-common.h"
>  
> +static bool damon_folio_acceptable(struct folio *folio, bool monitor)
> +{
> +	return folio_test_lru(folio) ||
> +		(monitor && folio_test_hugetlb(folio));
> +}
> +
>  /*
> - * Get an online page for a pfn if it's in the LRU list.  Otherwise, returns
> - * NULL.
> + * Get an online page for a pfn if it's in the LRU list, or a hugetlb folio if
> + * @monitor is set.  Otherwise, returns NULL.
>   *
>   * The body of this function is stolen from the 'page_idle_get_folio()'.  We
>   * steal rather than reuse it because the code is quite simple.
>   */
> -struct folio *damon_get_folio(unsigned long pfn)
> +static struct folio *__damon_get_folio(unsigned long pfn, bool monitor)
>  {
>  	struct page *page = pfn_to_online_page(pfn);
>  	struct folio *folio;
> @@ -33,13 +39,30 @@ struct folio *damon_get_folio(unsigned long pfn)
>  	folio = page_folio(page);
>  	if (!folio_try_get(folio))
>  		return NULL;
> -	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
> +	if (unlikely(page_folio(page) != folio) ||
> +			!damon_folio_acceptable(folio, monitor)) {
>  		folio_put(folio);
>  		folio = NULL;
>  	}
>  	return folio;
>  }
>  
> +struct folio *damon_get_folio(unsigned long pfn)
> +{
> +	return __damon_get_folio(pfn, false);
> +}
> +
> +/*
> + * Same to damon_get_folio(), but also accepts hugetlb folios, which are
> + * managed outside of the LRU lists.  Aimed to be used by access monitoring
> + * primitives.  DAMOS actions that assume LRU-managed folios should keep using
> + * damon_get_folio().
> + */
> +struct folio *damon_get_monitor_folio(unsigned long pfn)
> +{
> +	return __damon_get_folio(pfn, true);
> +}

The comment looks bit verbose and feel more like commit message to me.  I'd
suggest to drop the comment for now.  Because it is a very trivial change, I
will do so when I pick this into my tree, and later repost with the change for
mm.git merge.  Please let me know if it doesn't work for you.

> +
>  void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
>  {
>  	pte_t pteval = ptep_get(pte);
> diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
> index f7811c9c7a02..172f0f17c4a8 100644
> --- a/mm/damon/ops-common.h
> +++ b/mm/damon/ops-common.h
> @@ -6,6 +6,7 @@
>  #include <linux/damon.h>
>  
>  struct folio *damon_get_folio(unsigned long pfn);
> +struct folio *damon_get_monitor_folio(unsigned long pfn);
>  
>  void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
>  void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5c6c3a597fd0..ed7b7f31291a 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -37,7 +37,7 @@ static unsigned long damon_pa_core_addr(
>  
>  static void damon_pa_mkold(phys_addr_t paddr)
>  {
> -	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
> +	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
>  
>  	if (!folio)
>  		return;
> @@ -67,7 +67,7 @@ static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
>  
>  static bool damon_pa_young(phys_addr_t paddr)
>  {
> -	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
> +	struct folio *folio = damon_get_monitor_folio(PHYS_PFN(paddr));
>  	bool accessed;
>  
>  	if (!folio)
> -- 
> 2.54.0


Thanks,
SJ
