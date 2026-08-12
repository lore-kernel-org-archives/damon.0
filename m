Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932DD383323
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507578; cv=none; b=JvQA9mgSjs+iVP3m6J49WxXBZUrJ5GlOawkzlnUaK5/hS0C16tf2UwHgYZtx20Ypw1TJLAN4Y383dyIK5UdCOhnptfJdBcfhy8P9Bu0kuhNRmEpARH8bqqDjJf7N1nir/WRhiuHPPG1vTvDIOuUSJ8Svlv6Q4dorE3bNr0BqVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507578; c=relaxed/simple;
	bh=IHjypAHsNKjpNGDu8aCRCeoUOQ9LFF7rYITg0sTzbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMEU3qYwQ81aYugOdHHMotCOiJ8XFRIe8UwXUHNqEnuw3UT9Hg/hwu+m6WrKzyL7An4A5lppJQd03Q6RQEsLxkrxH+5WBBAUT8Xh5nxAXCpSDdKScGVKffIsUjr9LC2r9tLKZeM1f8Z4xIfbZvTaP4WXrxkhKRhH3cykj92sh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Rg9GEe8O; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rg9GEe8O"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B399D1596;
	Tue, 11 Aug 2026 21:06:10 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 018DD3F86F;
	Tue, 11 Aug 2026 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786507574; bh=IHjypAHsNKjpNGDu8aCRCeoUOQ9LFF7rYITg0sTzbDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rg9GEe8ORnIQSzAFzPE9Q3CsOniFeZz3B5DAx1vSbU2ayamMlqi+pdI/abA/SWthR
	 JHd2kD7S7LWpcNIoT65928j5y1fwj3S00eMdlQR9LYSfVNqmGWvx2Jo8nRyP2/XrUC
	 occW+1n2ku+jahULG28ttJSOr0S4qPMQj+wCR/cQ=
Date: Wed, 12 Aug 2026 09:36:11 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	David Hildenbrand <david@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, ziy@nvidia.com, 
	pfalcato@suse.de, agordeev@linux.ibm.com, ryan.roberts@arm.com, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	damon@lists.linux.dev
Subject: Re: [PATCH 3/9] mm: name pointers to copied PTE values ptentp
Message-ID: <hwkurkpobxysltkid5523qxndufebqqmat4qjaq6zhwno2drmh@efwoegm2huo6>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-4-usama.anjum@arm.com>
 <e7osakog3yvdewhdlrk3bsp27pwt2nnhroeb7zihlfxyjotarb@rwxkcb25crh3>
 <b21c4cc9-84a3-429e-8156-0b9967b2f133@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b21c4cc9-84a3-429e-8156-0b9967b2f133@arm.com>

On Tue, Aug 11, 2026 at 03:09:07PM +0100, Muhammad Usama Anjum wrote:
> On 11/08/2026 11:58 am, Anshuman Khandual wrote:
> > Subject line is very confusing. Perhaps something like the following.
> > 
> > mm: Rename pointers to copied PTE values as ptentp
> > 
> > But even 'copied PTE values' is not very clear as well.
> 
> Something like:
> 
> mm: rename pointers to logical PTE values as ptentp
> 
> or
> 
> mm: rename pointers to software PTE values as ptentp

Yeah but we need to get these nomenclature right at the very beginning
and also probably get it documented some where.

> 
> > 
> > On Thu, Aug 06, 2026 at 09:38:41AM +0100, Muhammad Usama Anjum wrote:
> >> The hw_pte_t conversion must retain pte_t * for pointers to standalone PTE
> > 
> > We need to explain what is `standalone PTE values` first.
> > 
> >> values. Name the value parameters ptentp in the install_pte callback,
> >> write_protect_page(), and guard_install_set_pte() so the later mechanical
> >> conversion can distinguish them from pointers to PTE table storage.
> >>
> >> Some functions already use the ptentp name, including:
> >> - madvise_folio_pte_batch()
> >> - folio_pte_batch_flags()
> >> No need to convert them.
> >>
> >> This is a naming-only change.
> > 
> > Small nit - s/naming-only/rename
> 
> I'll fix it.
> 
> > 
> > The commit message needs rewrite clearly explaining the following details
> > 
> > - What are standalone PTE values
> Logical/software PTE is correct and better name here.

Right but we need to define these early on and then be consistent in their usage
afterwards in the entire series.

> 
> > - How these are different from HW pgtable pointers
> > - Change is just a rename for pointers into such 'standalone PTE'
> > - These renamed 'ptentp' here would be used for skip or replaced during
> >   upcoming mechanical change via a script
> > - No functional changes intended
> I'll update message in more elaborate way.
> 
> > 
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> >> ---
> >> Changes since RFC v1:
> >> - Update the description for the architecture opt-in conversion.
> >> ---
> >>  include/linux/pagewalk.h | 2 +-
> >>  mm/ksm.c                 | 4 ++--
> >>  mm/madvise.c             | 4 ++--
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> >> index b41d7265c01bc..c34d826c5e4a2 100644
> >> --- a/include/linux/pagewalk.h
> >> +++ b/include/linux/pagewalk.h
> >> @@ -89,7 +89,7 @@ struct mm_walk_ops {
> >>  		       struct mm_walk *walk);
> >>  	void (*post_vma)(struct mm_walk *walk);
> >>  	int (*install_pte)(unsigned long addr, unsigned long next,
> >> -			   pte_t *ptep, struct mm_walk *walk);
> >> +			   pte_t *ptentp, struct mm_walk *walk);
> >>  	enum page_walk_lock walk_lock;
> >>  };
> >>  
> >> diff --git a/mm/ksm.c b/mm/ksm.c
> >> index ad05d7791307e..11d50518d02e9 100644
> >> --- a/mm/ksm.c
> >> +++ b/mm/ksm.c
> >> @@ -1292,7 +1292,7 @@ static u32 calc_checksum(struct page *page)
> >>  }
> >>  
> >>  static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
> >> -			      pte_t *orig_pte)
> >> +			      pte_t *ptentp)
> >>  {
> >>  	struct mm_struct *mm = vma->vm_mm;
> >>  	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
> >> @@ -1371,7 +1371,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
> >>  
> >>  		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
> >>  	}
> >> -	*orig_pte = entry;
> >> +	*ptentp = entry;
> >>  	err = 0;
> >>  
> >>  out_unlock:
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 07a21ca31bad4..c324cc991f841 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -1101,12 +1101,12 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
> >>  }
> >>  
> >>  static int guard_install_set_pte(unsigned long addr, unsigned long next,
> >> -				 pte_t *ptep, struct mm_walk *walk)
> >> +				 pte_t *ptentp, struct mm_walk *walk)
> >>  {
> >>  	unsigned long *nr_pages = (unsigned long *)walk->private;
> >>  
> >>  	/* Simply install a PTE marker, this causes segfault on access. */
> >> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
> >> +	*ptentp = make_pte_marker(PTE_MARKER_GUARD);
> >>  	(*nr_pages)++;
> >>  
> >>  	return 0;
> >> -- 
> >> 2.47.3
> >>
> > 
> > How did we ensure that the above changes are comprehensive and nothing
> > else got left in here ?
> 
> The order of patches and even the code was found out after adding hw_pte_t
> structure. Then everything was converted, until some pte_t pointers were left
> which didn't require conversion.
> 
> If something is left, we'll get build errors when we build a converted architecture.
> So the branch mentioned in the cover letter when built, would produce build errors.
> (Those patches would be sent separately, after finalization of this series).
> 
> Whenever I'm rebasing (on mm-new), I'm rerunning Coccinelle script to see if new code
> has arrived which requires conversion or renaming.

But in the early patch where the manual renaming was done for the script to
pick up 'ptentp' patterns needs to be audited again.

> 
> -- 
> Thanks,
> Usama
> 
