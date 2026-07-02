Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A9230BD5
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023518; cv=none; b=o2QVObbOb7gNDAoAhy+4/U/T3WaXT9e0P2nfCm3wP8uxlez8tbzWxwWpUxFdPWkvk4Ryo3pB7H4XByCDSug5dIP3fL44BV04aRGr68rOLWttet9rAtNhW5yHaLzPqOlQTaJaSPHb/699oz5d8eFj4nf+vrDCCKFXy7o/d4hFRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023518; c=relaxed/simple;
	bh=7RWnh0Zt4qj5mz08cUjdNsXvCZVBYBZdEj9vFYl7vuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r90h9XW2WmsKPGOh6cCblyEgP+HNTBCSSZw1xXecS67ORV/1HBgMOH3yUGJm8mmMVPpXBn1tUlG8kGU2NJmW1CKYxwW+OG57x1bhMDmHMNHlDc/io6+2LFmMYBXwl4vjnJLYSpJTMcHHtsJWdroQSESp9LmTVwKUAYAhrprzhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF2hnxBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF2hnxBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170131F000E9;
	Thu,  2 Jul 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783023516;
	bh=aJVj3aZrzou3ulR6wLajsObd6FMKWMyiLZL8yCyBvek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZF2hnxBYbHqnz/AtyCwcoywaVufriI/VFNc7GpUjb8cSGNRr+7TnrNNgOmfv+0MSr
	 WlkHLEAoHeBDF6pZniDqHPaYeXvJo+pKK5qshRdzuZl/bGGy/KhchjnGNThO7nQJJt
	 SuD5x+8HWNBm+te2Fj5zU+tQLfDITVCERgQn6ETA6WlyocN56nqcCMSBaOs4/nXICW
	 f3PKTSh2Nf/phfbvX9+VvpNciEBssNY3Tjaz0WBSUY9lludhJuA3TXKiUbhYqImvHx
	 ejahQFP0C/aGtXT+X7HHix1r9+Zj/62x4jxllEjRwW98krgE5Ijz1MWWTT9CGfQJZR
	 qrDgQNghczm8A==
From: SJ Park <sj@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	daichaobing@sangfor.com.cn,
	kunwu.chan@gmail.com
Subject: Re: [RESEND RFC PATCH v2 5/5] mm/damon/vaddr: implement DAMOS_SPLIT handler
Date: Thu,  2 Jul 2026 13:18:14 -0700
Message-ID: <20260702201814.92375-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702094633.75658-6-lianux.mm@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  2 Jul 2026 17:46:33 +0800 Lian Wang <lianux.mm@gmail.com> wrote:

> Implement the vaddr operations layer handler for DAMOS_SPLIT.
> For each folio in the target region that is larger than the
> scheme's target_order, split it via split_folio_to_order().
> 
> This supports both anonymous and file-backed (e.g. tmpfs/shmem)
> folios, covering KVM guest memory backed by THP tmpfs.
> 
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.wang@processmission.com>

Let's use single S-o-b: if it works.

> ---
>  mm/damon/vaddr.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 98a87609376b..a177703f7e0a 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -944,6 +944,83 @@ static unsigned long damos_va_collapse(struct damon_target *target,
>  	return applied;
>  }
>  
> +static unsigned long damos_va_split(struct damon_target *target,
> +		struct damon_region *r, struct damos *s,
> +		unsigned long *sz_filter_passed)
> +{
> +	unsigned long addr, end, chunk_sz;
> +	unsigned int target_order = s->target_order;
> +	unsigned long applied = 0;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	struct folio *folio;
> +	struct folio_walk fw;
> +
> +	mm = damon_get_mm(target);
> +	if (!mm)
> +		return 0;
> +
> +	chunk_sz = PAGE_SIZE << HPAGE_PMD_ORDER;
> +	addr = ALIGN_DOWN(r->ar.start, chunk_sz);
> +	end = ALIGN(r->ar.end, chunk_sz);

Like I commented to collapse part, would it make more sense to ALIGN() addr and
ALIGN_DOWN() end?

> +	if (end < addr)
> +		goto out_mmput;
> +
> +	while (addr < end) {

Above 'if (end < addr)' seems unnecessary, as while() here is covering it?

> +		unsigned long folio_sz;
> +
> +		if (addr + chunk_sz < addr)
> +			break;

What's the purpose here?  Preventing overflow?  How the overflow can happen,
and what is the consequence?

> +
> +		mmap_read_lock(mm);
> +		vma = find_vma(mm, addr);
> +
> +		if (!vma || addr < vma->vm_start ||
> +		    vma->vm_flags & (VM_HUGETLB | VM_MIXEDMAP))
> +			goto unlock;
> +
> +		folio = folio_walk_start(&fw, vma, addr, 0);

Why we need this?  Can't we use the simpler pattern like that on
damos_va_stat_pmd_entry()?

> +		if (!folio)
> +			goto unlock;
> +
> +		folio_sz = PAGE_SIZE << folio_order(folio);

You can use folio_size().

> +
> +		if (folio_order(folio) > target_order) {
> +			if (!folio_trylock(folio)) {
> +				folio_walk_end(&fw, vma);
> +				goto unlock;
> +			}
> +			folio_get(folio);
> +			folio_walk_end(&fw, vma);
> +
> +			if (!split_folio_to_order(folio, target_order))
> +				applied += folio_sz;
> +
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			*sz_filter_passed += folio_sz;

Shoudn't this code calls damos_va_filter_out() before split_folio_to_order()?

> +			addr += folio_sz;
> +		} else {
> +			folio_walk_end(&fw, vma);
> +			*sz_filter_passed += chunk_sz;
> +			addr += chunk_sz;
> +		}
> +		mmap_read_unlock(mm);
> +		cond_resched();
> +		continue;
> +
> +unlock:
> +		*sz_filter_passed += chunk_sz;
> +		addr += chunk_sz;
> +		mmap_read_unlock(mm);
> +		cond_resched();
> +	}
> +
> +out_mmput:
> +	mmput(mm);
> +	return applied;
> +}
> +
>  static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		struct damon_target *t, struct damon_region *r,
>  		struct damos *scheme, unsigned long *sz_filter_passed)
> @@ -977,6 +1054,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
>  		return damos_va_migrate(t, r, scheme, sz_filter_passed);
>  	case DAMOS_STAT:
>  		return damos_va_stat(t, r, scheme, sz_filter_passed);
> +	case DAMOS_SPLIT:
> +		return damos_va_split(t, r, scheme,
> +					  sz_filter_passed);

Let's keep the order same to that of damos_action.

>  	default:
>  		/*
>  		 * DAMOS actions that are not yet supported by 'vaddr'.


Thanks,
SJ
