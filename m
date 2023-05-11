Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9421F92D
	for <damon@lists.linux.dev>; Thu, 11 May 2023 13:14:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F832113E;
	Thu, 11 May 2023 06:14:58 -0700 (PDT)
Received: from [10.1.34.59] (C02Z41KALVDN.cambridge.arm.com [10.1.34.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65933F5A1;
	Thu, 11 May 2023 06:14:12 -0700 (PDT)
Message-ID: <e414905a-8129-5c39-77cb-53fd75910440@arm.com>
Date: Thu, 11 May 2023 14:14:11 +0100
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v1 1/5] mm: vmalloc must set pte via arch code
To: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev
References: <20230511125848.78621-1-ryan.roberts@arm.com>
 <20230511125848.78621-2-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230511125848.78621-2-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

My appologies for the noise: A blank line between Cc and Subject has broken the
subject and grouping in lore.

Please Ignore this, I will resend.


On 11/05/2023 13:58, Ryan Roberts wrote:
> It is bad practice to directly set pte entries within a pte table.
> Instead all modifications must go through arch-provided helpers such as
> set_pte_at() to give the arch code visibility and allow it to validate
> (and potentially modify) the operation.
> 
> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9683573f1225..d8d2fe797c55 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
>  {
>  	struct vmap_pfn_data *data = private;
> +	pte_t ptent;
>  
>  	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
>  		return -EINVAL;
> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> +
> +	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
> +	set_pte_at(&init_mm, addr, pte, ptent);
>  	return 0;
>  }
>  

