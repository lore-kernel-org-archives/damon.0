Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1A42A799;
	Thu,  6 Aug 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025109; cv=none; b=shPBwSu4x9NvNfa3o04iyi6OgjDH7Pt5WEM9fvUBLF+vF75gGX3s4Jw8sE94v28PhRgiLlS9NErj6HzKlxT75/zXLJkIcf4xLHeYW1qtW169PAcHmXSNkB4LB3+KLpR9/Sj9lWaQ8nuTvHJcHkB4+4j4utZl77jnykLQvPmrBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025109; c=relaxed/simple;
	bh=Fej4wBcyVRGzr1QEv/2XxqD+1vELPvYsduCszLBHAcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqR3J0sBb6Z7aBIK6NArvFXhjUVIzTGnKdvNNFqyPOfqjYmoW3p9QP/XNQGddlydN9+K6JSkghFnoxO8k57vuXQcpGmxdM1IO2XNT4ba+3TvqSoOGfU6vtPATZqCBuSFfoX83+qJkofjRHeJf1ekEn4p3M2CL/5+cFin6dFDiIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7uNVDin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7uNVDin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A35F1F000E9;
	Thu,  6 Aug 2026 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025102;
	bh=Y6APqpoAC3496oI8IPDgumvxehVxwgctdvlogEWJB54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e7uNVDinolId4oTkkdWmLABrN7spjecvFSAiaGhptvu+n+kbdbWcmCcSmzLfmrtba
	 Sipuirytwl0u7KG8zwUJ7JOH9qDbSKgVSB7yWU23pRUQGY1SjR4Ky2075A642KcR+d
	 LC8t37EWOQ6t3y+k/TxyaZF6ZQLaguCMGda3y084/E+y6JS1oKXp1VyyzXRfzWDKzO
	 8PdaFkqMFd6ja8+epLmFc+Or+hozyPpNPP0K6dLNyhSQrJDIx+f32ATANefVs954KO
	 q8AMAsfmd5cyfTswesD4Em2OpTCEwqsLe65KOP7EAUoVA9H7FVUKkeq8bSlnV/1Pzt
	 vwJwAmtToXmSA==
Date: Thu, 6 Aug 2026 15:04:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org, 
	jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com
Subject: Re: [PATCH 3/4] mm/madvise: skip zone device folios in cold/pageout
 PMD range
Message-ID: <anSUb_KvuBEMnAMq@lucifer>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-4-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728194714.3713735-4-gourry@gourry.net>

On Tue, Jul 28, 2026 at 03:47:13PM -0400, Gregory Price wrote:
> madvise_cold_or_pageout_pte_range() resolves the folio backing a PMD
> via pmd_folio() and ages or reclaims it without checking for zone
> device memory.
>
> The surrounding guards do not cover every zone device case:
>
>   - can_madv_lru_vma() excludes VM_PFNMAP and VM_HUGETLB VMAs
>     (so device DAX is filtered)
>
>   - !pmd_present() branch above rejects device-private and
>     migration entries, which are non-present.
>
>   - A present zone device PMD - e.g. a device-coherent THP - is
>     not filtered by any of these, nor by pmd_folio() (unlike
>     vm_normal_page_pmd(), it performs no special/pfnmap check),
>     and would be aged or paged out here.
>
> Skip ZONE_DEVICE folios explicitly during MADV_COLD/PAGEOUT.
>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/madvise.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 07a21ca31bad..ffd6a68320a8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -395,6 +395,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>
>  		folio = pmd_folio(orig_pmd);
>
> +		if (folio_is_zone_device(folio))
> +			goto huge_unlock;
> +
>  		/* Do not interfere with other mappings of this folio */
>  		if (folio_maybe_mapped_shared(folio))
>  			goto huge_unlock;
> --
> 2.55.0
>

--
Cheers, Lorenzo
