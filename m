Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F123B058E
	for <damon@lists.linux.dev>; Tue, 11 Aug 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445895; cv=none; b=O38RTFMW/Q28yJZ8w4EqqSL4qogA+Fy7+1Xi9FHmimdeOirficJd9m70oBfqsNM1IrIXDAmx3T0utPRDmLhItnIDXG29UB/Wkv8mmalg/iJVTlFLk5xgozH8q0DJZj/nkrrmQdNlT4iW7pEcZPFWf5rZ1ndnAYWwsvqT/4+728g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445895; c=relaxed/simple;
	bh=E2Q5I65meboDct+4hfaKsQDzSd1S1/tsAKEVH3DzJwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxR9+4spMrmAZWoEThYU07mA40YRBfO82WmF6rv9vAhugk6MequsA1hMEF/fQnHb2bMelIKWd0jXbUq8PcwPWEjgrmhXoRbI5FZUKYllziuvSLbB81RZlSQMeqCXnwOG9obnUgmkqmZPheasIb5t1ht06IN2Mqi2CyvFdWnJtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tKGjJivw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tKGjJivw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D0C1682;
	Tue, 11 Aug 2026 03:58:08 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 820043F86F;
	Tue, 11 Aug 2026 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786445892; bh=E2Q5I65meboDct+4hfaKsQDzSd1S1/tsAKEVH3DzJwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tKGjJivwGyrqmHqJQhgHkKc1NYH5dpUS0DWnYV/mVHQACS1frf2TRd2UhTyMG8JvA
	 Bw0BndUTcgOm1QZBl4JI/V5svJA1QNwOZVE/G2oL5rd2q44W5xc5apxl/s1/v2NISQ
	 JQrQY7r9UAbIHixEwxX6nTsx2ykLpYcEoEZ681SE=
Date: Tue, 11 Aug 2026 16:28:09 +0530
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
Message-ID: <e7osakog3yvdewhdlrk3bsp27pwt2nnhroeb7zihlfxyjotarb@rwxkcb25crh3>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-4-usama.anjum@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806083926.1807279-4-usama.anjum@arm.com>

Subject line is very confusing. Perhaps something like the following.

mm: Rename pointers to copied PTE values as ptentp

But even 'copied PTE values' is not very clear as well.

On Thu, Aug 06, 2026 at 09:38:41AM +0100, Muhammad Usama Anjum wrote:
> The hw_pte_t conversion must retain pte_t * for pointers to standalone PTE

We need to explain what is `standalone PTE values` first.

> values. Name the value parameters ptentp in the install_pte callback,
> write_protect_page(), and guard_install_set_pte() so the later mechanical
> conversion can distinguish them from pointers to PTE table storage.
> 
> Some functions already use the ptentp name, including:
> - madvise_folio_pte_batch()
> - folio_pte_batch_flags()
> No need to convert them.
> 
> This is a naming-only change.

Small nit - s/naming-only/rename

The commit message needs rewrite clearly explaining the following details

- What are standalone PTE values
- How these are different from HW pgtable pointers
- Change is just a rename for pointers into such 'standalone PTE'
- These renamed 'ptentp' here would be used for skip or replaced during
  upcoming mechanical change via a script
- No functional changes intended

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
> ---
> Changes since RFC v1:
> - Update the description for the architecture opt-in conversion.
> ---
>  include/linux/pagewalk.h | 2 +-
>  mm/ksm.c                 | 4 ++--
>  mm/madvise.c             | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
> index b41d7265c01bc..c34d826c5e4a2 100644
> --- a/include/linux/pagewalk.h
> +++ b/include/linux/pagewalk.h
> @@ -89,7 +89,7 @@ struct mm_walk_ops {
>  		       struct mm_walk *walk);
>  	void (*post_vma)(struct mm_walk *walk);
>  	int (*install_pte)(unsigned long addr, unsigned long next,
> -			   pte_t *ptep, struct mm_walk *walk);
> +			   pte_t *ptentp, struct mm_walk *walk);
>  	enum page_walk_lock walk_lock;
>  };
>  
> diff --git a/mm/ksm.c b/mm/ksm.c
> index ad05d7791307e..11d50518d02e9 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1292,7 +1292,7 @@ static u32 calc_checksum(struct page *page)
>  }
>  
>  static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
> -			      pte_t *orig_pte)
> +			      pte_t *ptentp)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
> @@ -1371,7 +1371,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
>  
>  		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
>  	}
> -	*orig_pte = entry;
> +	*ptentp = entry;
>  	err = 0;
>  
>  out_unlock:
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 07a21ca31bad4..c324cc991f841 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1101,12 +1101,12 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
>  }
>  
>  static int guard_install_set_pte(unsigned long addr, unsigned long next,
> -				 pte_t *ptep, struct mm_walk *walk)
> +				 pte_t *ptentp, struct mm_walk *walk)
>  {
>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>  
>  	/* Simply install a PTE marker, this causes segfault on access. */
> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
> +	*ptentp = make_pte_marker(PTE_MARKER_GUARD);
>  	(*nr_pages)++;
>  
>  	return 0;
> -- 
> 2.47.3
>

How did we ensure that the above changes are comprehensive and nothing
else got left in here ?
