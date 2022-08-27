Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEF029AD
	for <damon@lists.linux.dev>; Sat, 27 Aug 2022 21:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF142C433D6;
	Sat, 27 Aug 2022 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661635445;
	bh=fXm1bSisSqGSY59/IcPlbBIAN4KpPKVMt1s0HfiiqZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOjPeSlXP0tsnvP0jKEqd31BB9DQ4JUN2Mk4n0dAGwdwP41RLy6jJ3+wjPXLIWucE
	 HvHhHf6FRQejJBP4KvFlJG3RJ7dqzNd5O3u6jMl7hHaO8obYaKOH84sMYJRhipKa51
	 WsqViPetJNdaD1+XvnJf/G8bWQEh45dcWkQ0ZTPFp4snycbTd/sH9hunfXAXpUKs7c
	 tVkCZKW6oUf+qR1s7nepZrXE7dVbt8xkPLuwf3wTmA81pG6jFHYaG4oBUjXLLfpQ2O
	 tvo33aTHaH2II/ad1jfposZntyhGKbl1fvVjySmk+IcfE2M+9njfa4To5LI4zLmjs0
	 lCUOEAANikG5w==
From: SeongJae Park <sj@kernel.org>
To: xiakaixu1987@gmail.com
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
Date: Sat, 27 Aug 2022 21:24:01 +0000
Message-Id: <20220827212401.50416-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1661590971-20893-2-git-send-email-kaixuxia@tencent.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kaixu,

On Sat, 27 Aug 2022 17:02:50 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The parameter 'struct damon_ctx *ctx' isn't used in the functions
> __damon_{p,v}a_check_access(), so we can remove it and simplify the
> parameter passing.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/paddr.c | 5 ++---
>  mm/damon/vaddr.c | 6 +++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index dc131c6a5403..6b0d9e6aa677 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -166,8 +166,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
>  	return result.accessed;
>  }
>  
> -static void __damon_pa_check_access(struct damon_ctx *ctx,
> -				    struct damon_region *r)
> +static void __damon_pa_check_access(struct damon_region *r)
>  {
>  	static unsigned long last_addr;
>  	static unsigned long last_page_sz = PAGE_SIZE;
> @@ -196,7 +195,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
>  
>  	damon_for_each_target(t, ctx) {
>  		damon_for_each_region(r, t) {
> -			__damon_pa_check_access(ctx, r);
> +			__damon_pa_check_access(r);
>  			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
>  		}
>  	}
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3c7b9d6dca95..e481f81c3efb 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -532,8 +532,8 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
>   * mm	'mm_struct' for the given virtual address space
>   * r	the region to be checked
>   */
> -static void __damon_va_check_access(struct damon_ctx *ctx,
> -			       struct mm_struct *mm, struct damon_region *r)
> +static void __damon_va_check_access(struct mm_struct *mm,
> +				struct damon_region *r)
>  {
>  	static struct mm_struct *last_mm;
>  	static unsigned long last_addr;
> @@ -568,7 +568,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>  		if (!mm)
>  			continue;
>  		damon_for_each_region(r, t) {
> -			__damon_va_check_access(ctx, mm, r);
> +			__damon_va_check_access(mm, r);
>  			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
>  		}
>  		mmput(mm);
> -- 
> 2.27.0
