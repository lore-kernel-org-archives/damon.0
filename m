Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C91D29AD
	for <damon@lists.linux.dev>; Sat, 27 Aug 2022 21:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2361C433C1;
	Sat, 27 Aug 2022 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661635502;
	bh=068uzntAkNH5X9Td+k8jUVFGtdkDKzgG4mnydnaanMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4FWztKIudC8xTWLlZ26k0EWVjG6yfms7TsrfOUSuA4LrHAdJ68l+1TO66PZ3kzvq
	 MUJIgPeLqae0lG74qHSvhKg5EpaPyJ1hI3XJ+ZNEHgoTzwIReBwEJulqx7soYRjc/l
	 jJ5zcKjQNui9V8rMbkNe6Eo6v6ojMrHDM5rbJ0WJ+Zv/S2X2i7ApuL4+bHe5zE5zGh
	 kSOoiTq7kDRg3M2roTL9qVPfuXexvfZD9q2LRxQsgOl3HEbenxmhoiGZFH2o1dKd+x
	 o+fjMQirr4GFDEG66ApAPmLYsTvOy5TnFlwSp24nMTt49T4jm6wWZ5drPDDSlWoL95
	 johV6GXOQ72Sw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2 2/2] mm/damon/vaddr: remove comparison between mm and last_mm when checking region accesses
Date: Sat, 27 Aug 2022 21:25:00 +0000
Message-Id: <20220827212500.50479-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1661590971-20893-3-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The damon regions that belong to the same damon target have the same
> 'struct mm_struct *mm', so it's unnecessary to compare the mm and last_mm
> objects among the damon regions in one damon target when checking accesses.
> But the check is necessary when the target changed in
> '__damon_va_check_accesses()', so we can simplify the whole operation by
> using the bool 'same_target' to indicate whether the target changed.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/vaddr.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index e481f81c3efb..5f66c826ee3a 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -533,15 +533,14 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
>   * r	the region to be checked
>   */
>  static void __damon_va_check_access(struct mm_struct *mm,
> -				struct damon_region *r)
> +				struct damon_region *r, bool same_target)
>  {
> -	static struct mm_struct *last_mm;
>  	static unsigned long last_addr;
>  	static unsigned long last_page_sz = PAGE_SIZE;
>  	static bool last_accessed;
>  
>  	/* If the region is in the last checked page, reuse the result */
> -	if (mm == last_mm && (ALIGN_DOWN(last_addr, last_page_sz) ==
> +	if (same_target && (ALIGN_DOWN(last_addr, last_page_sz) ==
>  				ALIGN_DOWN(r->sampling_addr, last_page_sz))) {
>  		if (last_accessed)
>  			r->nr_accesses++;
> @@ -552,7 +551,6 @@ static void __damon_va_check_access(struct mm_struct *mm,
>  	if (last_accessed)
>  		r->nr_accesses++;
>  
> -	last_mm = mm;
>  	last_addr = r->sampling_addr;
>  }
>  
> @@ -562,14 +560,17 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>  	struct mm_struct *mm;
>  	struct damon_region *r;
>  	unsigned int max_nr_accesses = 0;
> +	bool same_target;
>  
>  	damon_for_each_target(t, ctx) {
>  		mm = damon_get_mm(t);
>  		if (!mm)
>  			continue;
> +		same_target = false;
>  		damon_for_each_region(r, t) {
> -			__damon_va_check_access(mm, r);
> +			__damon_va_check_access(mm, r, same_target);
>  			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
> +			same_target = true;
>  		}
>  		mmput(mm);
>  	}
> -- 
> 2.27.0
