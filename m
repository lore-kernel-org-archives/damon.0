Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA439B97F
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022186; cv=none; b=YtimoYYGTLdMHlVyGiYxRw+jSliS5U67NBMTHRIv1KbqZmPsSxwD3F7Qhq9iQr8LfHSwFyl+YxTsn6M+x+jCAHS7YZbaCc1yeZjobPfCw172vNB25jGkUA9tD5D++CqejONSVVYHaeV7gcfAmgiEzla117dGGLMG7MYEpBtvRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022186; c=relaxed/simple;
	bh=nVHC9othIIS3flQxvZZbg9C1h5I7jXZ6IZejaRP21D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWfWXTdeiOnOp/kxpi84X4tclpkVBVRS5jtxQIUM/Mw7ffNBSaV+G4Lil1NdImMW+4BZ28yo3IOkKgCFGfjyKxqxafDBTVlriEbi4akzX8lISqTTan4UCGGWqPCIr7Ms/GmR8nsUfoIXSEr0QyH9gXmqN9bt8qVaV1lRvMh16yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/FWB6jt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/FWB6jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A4F1F000E9;
	Thu,  2 Jul 2026 19:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783022183;
	bh=8pPyJqfnMYXXqo+RHQk7hHYPHe8mO9fxIeSu/W46PMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/FWB6jt/dWaj9Km4IL7UnuVEtMf+BFcFz2ur9eOgAlxhIq72KfufKL9vRuwm+hWc
	 ccEGRd6j6VI9qoSwL7i/dNhwpp+UdizZdh9oWDjT71rAYGFqkdwHW0EON7p+vwnS+8
	 cOwvxG17Z2cJktUpux8Dl5E/YNbfwxPFOaC34VqPeioGIGoVauLzv9KWQxHfj79FLC
	 aJSJqIgTeo9RF98anzhicX/8I8Y9XHTpXGWN9nrdDBZ3hkeDnOpBc4QoqSxHNZ6DTK
	 MZuKmdpziG2uSJ7lieXuXiwb0ayj+uhZZPfn+NbJ9vIli6yP5sSDuNzYnwwn52xPFE
	 esJuiGkOUKfPA==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: Re: [RESEND RFC PATCH v2 3/5] mm/damon/vaddr: implement mTHP-aware DAMOS_COLLAPSE handler
Date: Thu,  2 Jul 2026 12:56:17 -0700
Message-ID: <20260702195617.91982-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702094633.75658-4-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 17:46:31 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> When target_order is set (non-zero), the DAMOS_COLLAPSE handler now calls
> damon_collapse_folio_range() to collapse pages into the requested mTHP
> size, iterating over the target region in order-aligned chunks.  When
> target_order is 0 (default), the existing madvise(MADV_COLLAPSE) path is
> used, preserving backwards compatibility.
> 
> Region boundaries are expanded outward to the covering aligned range
> (ALIGN_DOWN start, ALIGN end) so that collapse works even after
> kdamond_split_regions reduces region sizes below the chunk size.
> collapse_huge_page() internally validates VMA bounds, so expanding
> beyond the original region is safe.
> 
> No external mmap lock is held: collapse_huge_page() acquires
> mmap_read_lock internally for validation, releases it, then acquires
> mmap_write_lock for the actual collapse.  Holding an outer
> mmap_read_lock would cause a self-deadlock when the same thread
> attempts the inner mmap_write_lock.
> 
> Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.wang@processmission.com>
> ---
>  mm/damon/vaddr.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index d27147603564..98a87609376b 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -14,6 +14,7 @@
>  #include <linux/page_idle.h>
>  #include <linux/pagewalk.h>
>  #include <linux/sched/mm.h>
> +#include <linux/khugepaged.h>
>  
>  #include "../internal.h"
>  #include "ops-common.h"
> @@ -899,6 +900,50 @@ static unsigned long damos_va_stat(struct damon_target *target,
>  	return 0;
>  }
>  
> +static unsigned long damos_va_collapse(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr, end, chunk_sz;
> +	unsigned long last_chunk = ULONG_MAX;
> +	unsigned int target_order = s->target_order;
> +	unsigned long applied = 0;
> +	struct mm_struct *mm;
> +	int ret;
> +
> +	if (target_order < 2 || target_order > HPAGE_PMD_ORDER)
> +		return 0;

I think this validation should be done by the caller, or whoever before this
function is called.  Let's remove this.

> +
> +	chunk_sz = PAGE_SIZE << target_order;
> +	addr = ALIGN_DOWN(r->ar.start, chunk_sz);
> +	end = ALIGN(r->ar.end, chunk_sz);

How about ALIGN() for addr and ALIGN_DOWN() for end?  I show madvise_collapse()
is doing so and being consistent to that is maybe a good idea to less confusing
users.

> +	if (end < addr)
> +		return 0;

Let's early-return for end == addr case, too.

> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	while (addr < end) {
> +		if (addr + chunk_sz < addr)
> +			break;
> +		if (addr == last_chunk)
> +			goto next;
> +		last_chunk = addr;
> +
> +		ret = damon_collapse_folio_range(mm, addr, target_order);
> +		if (!ret)
> +			applied += chunk_sz;
> +		*sz_filter_passed += chunk_sz;

Shouldn't this call damos_va_filter_out() before damos_collapse_folio_range()?

> +next:
> +		addr += chunk_sz;
> +		cond_resched();
> +	}
> +
> +	mmput(mm);
> +	return applied;
> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme, unsigned long *sz_filter_passed)
> @@ -922,6 +967,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		madv_action = MADV_NOHUGEPAGE;
>  		break;
>  	case DAMOS_COLLAPSE:
> +		if (scheme->target_order)
> +			return damos_va_collapse(t, r, scheme,
> +						 sz_filter_passed);

Let's use two tabs indentation on the second line of parameters, instead of
aligning things with the mix of tabs and spaces.

>  		madv_action = MADV_COLLAPSE;
>  		break;
>  	case DAMOS_MIGRATE_HOT:


Thanks,
SJ
