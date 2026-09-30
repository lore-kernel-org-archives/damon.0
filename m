Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C4361969
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 04:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742061; cv=none; b=MZMpri/KxWSru8O0A03HbXWQ5gHQqKYaLB1tVGvOuhpPd37SxnD85gVjbugGYR/Ldo50V+upYu0qZMlskR39Jj9G4cVrOKZXEgSOfduH6bT+GssSN7sUkiD4Rsqjyf/wBO5wpCa4cjjIjZARxtFxttgb8bSF7oRrZHbnCF2fh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742061; c=relaxed/simple;
	bh=UxlHUYv22rgyq7ZVxruY0QE2y0GtfTw2R9yOES+jmXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQEcBBpsmdEWJ10CYN1EPSBgWVDViXYdWTvdeqhiRPEffgCuHgSV4JEtqwZoUCXfhOrJV5FMhEaZhCRutu+flI309iZrfXBTmVIHpLEpHYXykMWqK6ixh2F0n3NYIB+MCb5s9G6UaAhsxaPEU4/Q7svaQmgP9v7ARoY2GbmB04s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iiXj3sGk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iiXj3sGk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D941516;
	Tue, 29 Sep 2026 21:20:55 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D13163F85F;
	Tue, 29 Sep 2026 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790742059; bh=UxlHUYv22rgyq7ZVxruY0QE2y0GtfTw2R9yOES+jmXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiXj3sGkrhMAurjVuvisN1wyrF4L5DGjA9KvALcFVE4OmoxhVrf+/REwA/xaRN5Yk
	 5me6wieFhJOwAoyLIoLbXtSHLf2oRy3WVoldA0+46lHll1bRbjR+OrUDdKJOwbDcUR
	 LpuyMIJJwxFQf9usQsgGIu9RHfEsZZyZAGi0LfSg=
Date: Wed, 30 Sep 2026 09:50:55 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, SJ Park <sj@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, damon@lists.linux.dev, kasan-dev@googlegroups.com, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 2/9] mm: rename pointers to software PTE values as
 ptentp
Message-ID: <ch63uaxr36anablz2sra57huiud2gxjtpmilwk4je2qkm5hb7j@eiun5t4erg2l>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-2-5670b8cb9059@arm.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-pte0-v3-2-5670b8cb9059@arm.com>

On Tue, Sep 22, 2026 at 06:12:30PM +0100, Muhammad Usama Anjum wrote:
> Some interfaces use pte_t * for a software PTE value rather than for an
> entry stored in a PTE table. These pointers must remain pte_t * when
> pointers to PTE table storage are converted to hw_pte_t *.
> 
> Rename these parameters in the install_pte callback,
> write_protect_page(), and guard_install_set_pte() to ptentp. The later
> Coccinelle conversion skips pointers named ptentp, allowing it to convert
> the remaining PTE table pointers without changing these interfaces.
> 
> Some functions already use ptentp for such pointers, including:
> - madvise_folio_pte_batch()
> - folio_pte_batch_flags()
> No need to rename them.
> 
> This patch only renames parameters and makes no functional change.
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> Changes since v1:
> - Rewrite the subject and description to distinguish software PTE
>   values from PTE table storage.
> 
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
> index 624f37975e129..2a4f19fe0f696 100644
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
> index 73c2901b9adbf..dd75a673e108f 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1113,12 +1113,12 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
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
> 
> -- 
> 2.47.3
> 
