Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9C6AAB
	for <damon@lists.linux.dev>; Thu, 11 May 2023 13:14:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE07C113E;
	Thu, 11 May 2023 06:15:22 -0700 (PDT)
Received: from [10.1.34.59] (C02Z41KALVDN.cambridge.arm.com [10.1.34.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24A423F5A1;
	Thu, 11 May 2023 06:14:37 -0700 (PDT)
Message-ID: <27f2ad91-2507-a58c-2fb7-211c7f90bbdb@arm.com>
Date: Thu, 11 May 2023 14:14:35 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v1 3/5] mm: Fix failure to unmap pte on highmem systems
To: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev
References: <20230511125848.78621-1-ryan.roberts@arm.com>
 <20230511125848.78621-4-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230511125848.78621-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

My appologies for the noise: A blank line between Cc and Subject has broken the
subject and grouping in lore.

Please Ignore this, I will resend.


On 11/05/2023 13:58, Ryan Roberts wrote:
> The loser of a race to service a pte for a device private entry in the
> swap path previously unlocked the ptl, but failed to unmap the pte. This
> only affects highmem systems since unmapping a pte is a noop on
> non-highmem systems.
> 
> Fixes: 16ce101db85d ("mm/memory.c: fix race when faulting a device private page")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f69fbc251198..ed429e20a1bb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3728,10 +3728,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  			vmf->page = pfn_swap_entry_to_page(entry);
>  			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					vmf->address, &vmf->ptl);
> -			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
> -				spin_unlock(vmf->ptl);
> -				goto out;
> -			}
> +			if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
> +				goto unlock;
>  
>  			/*
>  			 * Get a page reference while we know the page can't be

