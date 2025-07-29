Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C315FDA7;
	Tue, 29 Jul 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753758397; cv=none; b=LzelJ6RlncOisgfR8YeXaCncR755n+b3QWYLWNNPzQvT3FdBKdwHQWNpGfma8q1sfgcxyto8VX8DJAksQmBXo5dHdELi2SretGcZSgAcfG6o9GX+EB3IV4ASxbyioZjbwfAVfMc8Moe3NqQZOLqgx7j1So7BkH8mA1NG1rbgGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753758397; c=relaxed/simple;
	bh=PasCfrKP/M0P2PtxhDuFhw39XtRSAGXbWOtMBPpKFxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHzQK1iNMeGB6ldB5CykA136tKpUwwEAb6XcMpIq5VEHXxfq8Gh5S3j9Wjzr3kmpLPL30iJ0+9J+YkZ8jMDTsGBMtIeTny/+/i5hlIKfG6LZYl+qWTTBMsAV8oUoGuJj1e5MQcLI5HU1UgVrzz8nILIpmjIdsMKxVIYekw6esLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ2NgLfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ2NgLfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940E0C4CEE7;
	Tue, 29 Jul 2025 03:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753758396;
	bh=PasCfrKP/M0P2PtxhDuFhw39XtRSAGXbWOtMBPpKFxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJ2NgLfB2FQdzy5SZp3IlNVGIqpxyw2XlYvpZ32t5HSC4H4sNT10O8CWt6e+dbKzI
	 7OEirxzbp2qspSMRTSUXh3w+bwyT28D4uu/nWguSjoiFSSJW7/MtZV3IDooq9oUEKB
	 Bh50rOYeVGo3dsPPXQCZ6wh8NgKG6qx2Pm08otxz5ylupJF+WbhDoYpBS32EOlPwZN
	 AejgJ3PMin0lFIe2YYTctlK4guJQHXJFxai4zXmOtacUnjDnpuBwLTHl30pK3tKSYP
	 +OS1ebIiH9Cd0W0Z4ebl5ocz4oiefB2+TrkRfcp2sv3MsstsmSgPd3qBKgTYOisc3J
	 AzWJ2GMGeUbHw==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jann Horn <jannh@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC v2 5/7] mm/memory: implement MM_CP_DAMON
Date: Mon, 28 Jul 2025 20:06:32 -0700
Message-Id: <20250729030632.1829-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <804015e3-78f7-47d8-b887-434f0f7edf8a@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Jul 2025 06:19:35 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Sun, Jul 27, 2025 at 01:18:11PM -0700, SeongJae Park wrote:
> > DAMON is using Accessed bits of page table entries as the major source
> > of the access information.  It lacks some additional information such as
> > which CPU was making the access.  Page faults could be another source of
> > information for such additional information.
> >
> > Implement another change_protection() flag for such use case, namely
> > MM_CP_DAMON.  DAMON will install PAGE_NONE protections using the flag.
> > To avoid interfering with NUMA_BALANCING, which is also using PAGE_NON
> > protection, pass the faults to DAMON only when NUMA_BALANCING is
> > disabled.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> This seems to not be an upstreamable series right now unless I'm missing
> something.
> 
> Firstly, you're making a change in behaviour even when CONFIG_DAMON is not
> specified, and Linus already told you we can't have that default-on.
> 
> I'm very very much not happy with us doing something for 'damon'
> unconditionaly when !CONFIG_DAMON on the assumption that an acessible
> mapping has PROT_NONE set.
> 
> This change makes me nervous in general ANYWAY as you are now changing core
> mm and introducing a new faulting mechanism specifically for DAMON.
> 
> And we are assuming that NUMA balancing being disabled is not racey in a
> way that will cause things to break.
> 
> I really also dislike the idea of an _implicit_ assumption that we are good
> to use the NUMA balancing faulting mechanism to 'tack on' DAMON stuff.
> 
> Is it really all that useful to provide a method that requires NUMA
> balancing to be diabled?
> 
> Finally, you're making it so DAMON can mprotect() something to use the
> DAMON/NUMA balancing fault handler, which doesn't appaer to check to see if
> NUMA balacing is disabled, but anyway it could be re-enabled?
> 
> And then now DAMON is making stuff fault as NUMA balancing faults
> incorrectly?
> 
> This just seems broken.
> 
> Unless there's really good justification I'm really not inclined for us to
> merge this as-is right now unfortunately.

Thank you for review and comments, Lorenzo.  I fundamentally agree all your
points.  I don't aim to merge this as-is.  Actually this patch series is more
like POC, but apparently I was rushing.  I will try to adjust your concerns in
the next version.

> 
> > ---
> >  include/linux/mm.h |  1 +
> >  mm/memory.c        | 53 ++++++++++++++++++++++++++++++++++++++++++++--
> >  mm/mprotect.c      |  5 +++++
> >  3 files changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 21270f1664a4..ad92b77bf782 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2567,6 +2567,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
> >  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
> >  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
> >  					    MM_CP_UFFD_WP_RESOLVE)
> 
> /* Comment here :) */

I will add the comments on the next version.

> 
> > +#define MM_CP_DAMON                        (1UL << 4)
> 
> Shouldn't this be something more specific like MM_CP_DAMON_REPORT_FAULT ?

Thank you for the suggestion, I will use it.

> 
> >
> >  bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
> >  			     pte_t pte);
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 92fd18a5d8d1..656e610867b0 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -75,6 +75,7 @@
> >  #include <linux/ptrace.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched/sysctl.h>
> > +#include <linux/damon.h>
> >
> >  #include <trace/events/kmem.h>
> >
> > @@ -5972,6 +5973,47 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
> >  	return VM_FAULT_FALLBACK;
> >  }
> >
> > +static vm_fault_t do_damon_page(struct vm_fault *vmf, bool huge_pmd)
> 
> You need to explain what this function is doing at least.

This function lifts the protection and reports the access information to DAMON.
I will add more comments on the next version.

> 
> > +{
> > +	struct damon_access_report access_report = {
> > +		.addr = vmf->address,
> > +		.size = 1,
> > +	};
> > +	struct vm_area_struct *vma = vmf->vma;
> > +	struct folio *folio;
> > +	pte_t pte, old_pte;
> > +	bool writable = false, ignore_writable = false;
> > +	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
> > +
> > +	if (huge_pmd)
> > +		access_report.addr = PFN_PHYS(pmd_pfn(vmf->orig_pmd));
> > +	else
> > +		access_report.addr = PFN_PHYS(pte_pfn(vmf->orig_pte));
> > +
> > +	spin_lock(vmf->ptl);
> > +	old_pte = ptep_get(vmf->pte);
> > +	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
> > +		pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +		return 0;
> > +	}
> > +	pte = pte_modify(old_pte, vma->vm_page_prot);
> 
> This is little weird, you're applying VMA protection bits to the PTE then
> later asking about protection bits? Can't you just tell from the VMA flags?
> 
> Seems like do_numa_page() copy/pasta.
> 
> > +	writable = pte_write(pte);
> > +	if (!writable && pte_write_upgrade &&
> > +			can_change_pte_writable(vma, vmf->address, pte))
> > +		writable = true;
> > +	folio = vm_normal_folio(vma, vmf->address, pte);
> > +	if (folio && folio_test_large(folio))
> > +		numa_rebuild_large_mapping(vmf, vma, folio, pte,
> > +				ignore_writable, pte_write_upgrade);
> > +	else
> > +		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
> > +				writable);
> > +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +
> 
> All of this seems to be duplicating aspects of do_numa_page().

You are correct.

> 
> Seems more sensible, if it makes sense to accept this change (I'm still a
> bit dubious about changing the faulting mechanism here), we should probably
> implement a 'do_non_present_acessible()' function that avoids duplication +
> bit-rot, with #ifdef CONFIG_DAMON's in place, or even better, just a hook
> into damon code that's static inline void {} if not enabled.

I will do so in the next version.

> 
> Note that the numa fault handling logic is called _even if numa balancing
> is disabled_. So we'd avoid all the other changes too.
> 
> > +	damon_report_access(&access_report);
> > +	return 0;
> > +}
> > +
> >  /*
> >   * These routines also need to handle stuff like marking pages dirty
> >   * and/or accessed for architectures that don't do it in hardware (most
> > @@ -6036,8 +6078,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
> >  	if (!pte_present(vmf->orig_pte))
> >  		return do_swap_page(vmf);
> >
> > -	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
> > +	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
> > +		if (sysctl_numa_balancing_mode == NUMA_BALANCING_DISABLED)
> > +			return do_damon_page(vmf, false);
> 
> Making an assumption here that, even if damon is disabled, we should handle
> a 'damon' fault is just icky, sorry.

Agreed.  I will make this happen only when CONFIG_DAMON is enabled.

> 
> Also are we 100% sure that there's no races here? When we disable numa
> balancing do we correctly ensure that absolutely no racing NUMA balancing
> faults can happen whatsever at this juncture?

Enabling CONFIG_DAMON will not automatically invoke change_protection() with
MM_CP_DAMON.  Such invocations will be made only if the user disables NUMA
balancing and run DAMON in the reporting mode.

So there can be two racy cases.

If the user enables NUMA balancing and then disables it after a while, page
faults for MM_CP_PROT_NUMA can be handled by DAMON.  That could look odd, but
there should be no real problem in practice.  DAMON's fault handling will
cleanup the PAGE_NONE protection like NUMA balancing, and DAMON has no problem
at receiving such additional reports from MM_CP_PROT_NUMA-caused faults.  DAMON
may show a few more than expected accesses, but that's no problem for DAMON.

Similarly, if the user starts DAMON in the report mode, stops DAMON, and then
enables NUMA balancing, faults for MM_CP_DAMON that installed while DAMON was
running in the report mode can be handled by NUMA balancing.  This should also
not make real problems in practice in my opinion.  NUMA balancing could see
more accesses and migrate pages little bit more than expected, but that should
be just for a moment.

Maybe I'm missing something, or not well explaining my thoughts.  I will be
happy to learn what I'm missing, or get chances to further clarify my points.

> 
> Have you checked that and ensured that to be the case?
> 
> You really have to be 100% certain you're not going to wrongly handle NUMA
> page faults this way, on a potentially non-CONFIG_DAMON kernel to boot.

I will ensure that never happens on CONFIG_DAMON disabled kernels, in the next
version.

> 
> Keep in mind fault handling is verrrry racey (purposefully) and can be done
> under VMA read lock alone (and that's only very loosely a lock!).
> 
> This is just, yeah, concerning.

Thank you for the caution.  DAMON's fault handling code only saves the
information in its internal ring buffer.  It doesn't touch vmas.  So I think
there should be no such problems.  I will add the clarification on the next
version.

> 
> >  		return do_numa_page(vmf);
> > +	}
> >
> >  	spin_lock(vmf->ptl);
> >  	entry = vmf->orig_pte;
> > @@ -6159,8 +6204,12 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
> >  			return 0;
> >  		}
> >  		if (pmd_trans_huge(vmf.orig_pmd)) {
> > -			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
> > +			if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
> > +				if (sysctl_numa_balancing_mode ==
> > +						NUMA_BALANCING_DISABLED)
> > +					return do_damon_page(&vmf, true);
> 
> Now we have _more_ weirdness around what CONFIG_TRANSPARENT_HUGEPAGE
> enables/disables.
> 
> >  				return do_huge_pmd_numa_page(&vmf);
> 
> This function will be called only if THP is enabled, but now damon
> overrides that...
> 
> Let's try and make this consistent.

I will do so in the next version.

> 
> > +			}
> >
> >  			if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
> >  			    !pmd_write(vmf.orig_pmd)) {
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 78bded7acf79..e8a76114e4f9 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -714,6 +714,11 @@ long change_protection(struct mmu_gather *tlb,
> >  	WARN_ON_ONCE(cp_flags & MM_CP_PROT_NUMA);
> >  #endif
> >
> > +#ifdef CONFIG_ARCH_SUPPORTS_NUMA_BALANCING
> > +	if (cp_flags & MM_CP_DAMON)
> > +		newprot = PAGE_NONE;
> > +#endif
> 
> OK this just seems broken.
> 
> Firstly, again you're introducing behaviour that applies even if DAMON is
> disabled. Let's please not.
> 
> And predicating on -the architecture even supporting NUMA balancing- seems
> rather bizarre?

Agree, I will ensure there will be no change on CONFIG_DAMON disabled kernels,
in the next version.

> 
> Secondly, somebody can disable/enable NUMA balancing, and thus you are now
> allowing this function to, when somebody specifies 'DAMON', get NUMA
> balancing fault handling??
> 
> If you don't bother checking whether NUMA balancing is disabled when you
> set it, then boom - you've broken the faulting mechanism, but even if you
> _do_, somebody can just switch it on again...

As I explained on the two racy cases aboe, faults that caused by DAMON or NUMA
balancing can be handled by the other's handling code, but only for a limited
time under the user's controls.  But to my understanding that should not cause
real problems in the practice, and users wouldn't be suggested to operate the
system in such a way.  I will add more documents and cautions about that in the
next version.

Again, I may be missing something, and would be happy to be enlightened or
get more chances to clarify my points.

> 
> Sorry but unless I'm wildly missing something here we're going to need a
> new faulting mechanism (if we even want to allow DAMON to have its own
> fault handling that is!)

No worry, I completely agree to your main points.  I think I was bettr to
explain more about the racy cases and ensure no interference on CONFIG_DAMON
disabled case, and thank you for letting me know that.

Maybe we need more discussions on the racy cases, but anyway I will try to
address all your concerns in the next version.


Thanks,
SJ

[...]
