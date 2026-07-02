Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174E30C608;
	Thu,  2 Jul 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021441; cv=none; b=LWSL8m0J+KU+QiKS8cYkI04kjNgl/Es2rkcusOvSzhCgCUfdi+y00MR8w1F7YUsxFXDTuEUesmafuePRdkiBh0kOOobkDEXa5Zq2RYUfectOZfjOY6kNPPxPURsDih02OMKPRYLTUxGWDU4fhmiXtsexPaD+UBE021/xNRm8jIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021441; c=relaxed/simple;
	bh=K6ycMzLM1OhJDXmJKhBtIyBS+Mkc3oO4tVw2ofZT9YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILqFbhuKKg58qOG7evRn1KzQ/tL8pURD/YPCISpYlTEShbg1uSm8qpqB3/VozPDeL0zIbHsD7Fraeq2lalaBXWCMwnX0e7IKlvt/Af8Q5uSkkGtABZw36cdHSXgH9MocRfxMruqfovpPermjBLnp67ncst09u25caCJbvoXTUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0yrWKeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0yrWKeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9D51F00A3A;
	Thu,  2 Jul 2026 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783021439;
	bh=q2PsvY3R2LHOj6IcES5Ab5eU1XEwA3syZT/3P9Yzi04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0yrWKeMu9pwVpTJjikV0jmmd1jEtIMRZ+SZnV7SwS0BdLuCK1iKhdY/64SN7bas1
	 3RrBgfdoK+hNu4xb9GVyAGtuljGeW68cliYQPstJ58lX2RvBcutSp4IsCMRJ4eTXvz
	 cBnhrbOcrRAGIblXQ99ELUniJLxylQGRA01RJLQj41tXdMan+9Uw6Ca6bqSiyKNhj8
	 DzjRx0tN7AuQKLdJLAunLiL4HHMkXl27XJnGa0r1UpdGsciLoJswaGZo5X8PwTS4sV
	 o/EfsllG7pK0e0r/MMJk2ORwnn6JQ+lBbMP9r3sHDySAY+6dlFoycxmP0JeyehcI3m
	 HtzduSrhZ3RVQ==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 2/5] mm/khugepaged: add damon_collapse_folio_range() for external callers
Date: Thu,  2 Jul 2026 12:43:53 -0700
Message-ID: <20260702194353.91778-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <akZDj6s8U5_Mnetv@lucifer>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jul 2026 12:07:01 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> (+cc missing people again)

Thank you for adding the recipients, and review, Lorenzo!

> 
> Sorry but we're not going to accept anything that exports THP logic like this at
> all.
> 
> And a damon wrapper in core mm code is just a non-starter, so you really need to
> rethink your approach.
> 
> I think SJ already commented on this in your v1 from what I can see? I'd listen
> to his advice on this :)

Lorenzo is right.  Not disrupting the world outside of mm/damon/ is the first
principle of DAMON development.  Sometimes we may have to make some changes
outside of mm/damon/, but we MUST make it not disruptive, small, and perfectly
aligned with the developers of the area with respects.

> 
> On Thu, Jul 02, 2026 at 05:46:30PM +0800, Lian Wang wrote:
> > Export a thin wrapper around collapse_huge_page() that allows external
> > subsystems such as DAMON to trigger THP collapse on a target address
> > range.
> >
> > Currently restricted to PMD order (HPAGE_PMD_ORDER), since
> > collapse_huge_page() does not yet support arbitrary mTHP orders.
> > The restriction can be relaxed when khugepaged gains mTHP support.
> >
> > The caller must hold a reference to @mm.  Do not hold mmap lock:
> > collapse_huge_page() acquires mmap_read_lock for validation, releases
> > it, then acquires mmap_write_lock for the actual collapse.  Holding
> > an outer mmap_read_lock would cause a self-deadlock when the same
> > thread attempts the inner mmap_write_lock.
> >
> > Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> > Signed-off-by: Lian Wang <lianux.wang@processmission.com>
> 
> This patch is exporting internal mm logic without proper safeguards so it's just
> not something we're going to accept, sorry.
> 
> (Also not sure it's correct to have multiple S-o-b for the same person (unless
> re-tagging a backport or something)? I'm not sure though)

I agree to Lorenzo.

As I replied [1] to patch 1, if you just want to give a credit to your
employer, you could add your employer name on the single tag, like "Lian Wang
(processssmission) <lianux.mm@gmail.com>".

If it is for ensure the replies goes to not only your private inbox but also
corporate email inbox, you can simply Cc: your corporate email address.

> 
> > ---
> >  include/linux/khugepaged.h |  9 ++++++++
> >  mm/khugepaged.c            | 46 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index d7a9053ff4fe..f7d49cba712f 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -20,6 +20,9 @@ extern bool current_is_khugepaged(void);
> >  void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> >  		bool install_pmd);
> >
> > +int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start_addr,
> > +			       unsigned int target_order);
> 
> No thanks. We're not putting damon wrappers into core code. This is breaking the
> abstraction and letting arbitrary users invoke internal mm logic.

I agree.  First of all, having something with 'damon_' prefix in khugepaged.h
makes no sense.  If we have to expose something, maybe mm/internal.h could be
considered in my opinion.  But for only DAMON usage, include/linux/khugepaged.h
is definitely wrong.

> 
> Plus you're literally exporting this so it can be abused by drivers.

I was raising my eyebrows here.  I show this patch adds EXPORT_SYMBOL_GPL() at
the end.  Lorenzo is completely right.  I believe Lian added that only by a
mistake.

> 
> > +
> >  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
> >  {
> >  	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> > @@ -47,6 +50,12 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
> >  {
> >  }
> >
> > +static inline int damon_collapse_folio_range(struct mm_struct *mm,
> > +		unsigned long start_addr, unsigned int target_order)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> >  static inline void khugepaged_min_free_kbytes_update(void)
> >  {
> >  }
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 617bca76db49..7fe9ce1e0533 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -3272,3 +3272,49 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> >  	return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
> >  			: madvise_collapse_errno(last_fail);
> >  }
> > +
> > +/**
> > + * damon_collapse_folio_range() - Collapse base pages in range into a THP
> > + * @mm:         mm_struct of the target process
> > + * @start_addr: start address (must be order-aligned)
> > + * @target_order: page order of the collapse result (currently only
> > + *                HPAGE_PMD_ORDER is supported)
> > + *
> > + * Thin wrapper around collapse_huge_page() for external callers such as
> > + * DAMON.  The caller must hold a reference to @mm.  Do not hold mmap
> 
> This is really fragile and bug bait.
> 
> > + * lock: collapse_huge_page() acquires mmap_read_lock for validation,
> 
> This is just gross, you're now collapsing based on an outdated concept of
> what the current VMA state is...
> 
> You're also losing literally everything that madvise_collapse() does.
> 
> AND you're overriding THP limitations like max_ptes_none, which is horrible...
> 
> > + * releases it, then acquires mmap_write_lock for the collapse.  Holding
> > + * an outer mmap_read_lock would self-deadlock.
> 
> This is a sign the interface is wrong!
> 
> > + *
> > + * Return: 0 on success, -EINVAL on bad arguments, negative error from
> > + *         madvise_collapse_errno() otherwise.
> > + */
> > +int damon_collapse_folio_range(struct mm_struct *mm, unsigned long start_addr,
> > +			       unsigned int target_order)
> > +{
> > +	struct collapse_control *cc;
> > +	enum scan_result result;
> > +
> > +	if (target_order != HPAGE_PMD_ORDER) {
> > +		pr_warn_once("%s: only PMD order (%u) is supported, got %u\n",
> > +			     __func__, HPAGE_PMD_ORDER, target_order);
> > +		return -EINVAL;
> > +	}
> > +	if (start_addr & ((PAGE_SIZE << target_order) - 1))
> > +		return -EINVAL;
> > +
> > +	cc = kmalloc_obj(*cc);
> > +	if (!cc)
> > +		return -ENOMEM;
> > +	cc->is_khugepaged = false;
> > +	cc->progress = 0;
> > +
> > +	lru_add_drain_all();
> 
> This is quite literally a copy/paste from madvise_collapse(). No no no :) code
> duplication like this is also unacceptable.

Thank you for kind review, Lorenzo.

I believe Lorenzo's concerns are valid and should all be addressed before
dropping RFC tag of this patch.  Also, if you "have to" post the next revision
before addressing those to get reviews of changes on other parts of this
series, let's make sure the fact is very clearly described.  In the way, we
can avoid wasting time of reviewers.  For example, you could add a note like
below at the beginning of the next revision of this patch.

"""
NOTE to THP reviewers: This patch is not yet addressing problems that are found
on the previous revision.  This version is posted for review of only other
parts in the series.  Please ignore this patch for now.
"""

> 
> > +
> > +	result = collapse_huge_page(mm, start_addr, 1, 0, cc, target_order);
> > +	kfree(cc);
> > +	if (result == SCAN_SUCCEED || result == SCAN_PMD_MAPPED)
> > +		return 0;
> > +	return madvise_collapse_errno(result);
> > +}
> > +EXPORT_SYMBOL_GPL(damon_collapse_folio_range);
> 
> We _definitely_ cannot have internal mm logic _exported_.

I completely agree.  Please drop this from the next version.

> 
> Yeah sorry you need to rethink this.

I wonder if we could extend madvise_collapse() for mTHP and use it.

I initially thought this is a silly idea, but
'Documentation/admin-guide/mm/transhuge.rst' is saying "currently",
madvise_collapse only supports collapsing to PMD-sized THPs and does not attemp
mTHP collapse.  It reads to me like supporting mTHP from MADV_COLLAPSE is a
possible TODO.  And it makes sense to me.  Users who do MADV_COLLAPSE may want
it to at least have a best-effort mTHP.  The interface of madvise_collapse() is
already receiving arbitrary address range, so fit with DAMON's purpose.

If supporting mTHP with MADV_THP is not a real TODO but just a silly idea that
better not to be implemented, I wonder if we can split out the core of
madvise_collapse(), extend it for mTHP, and expose it on mm/internal.h.

I concern if the above idea makes call depth unnecessarily deep, though.  A
shallower approach would be renaming madvise_collapse() to somewhat general (I
fail at making an example, but whatever without maddvise_ prefix) and extending
it for mTHP support.

Off the topic of this patch, but I find 'madvise_collapse()' is declared in
include/linux/huge_mm.h, while it is being used only inside mm/.  Would it make
sense to move the declaration to mm/internal.h?

[1] https://lore.kernel.org/20260702185137.91227-1-sj@kernel.org


Thanks,
SJ

[...]
