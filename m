Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4E3BB4A;
	Thu,  6 Aug 2026 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023501; cv=none; b=hvQH3soy9+nANytA4XOVfKpXQgYSswrzypR8bAVOsx6baGnAjS1gzxCMdhWsJSTxx3KgTwsvO6fHAnyYfUA8odr3fI2jiZzO/BWv7YIDTPTScqn3f+Tb3muzhJMtwUKIDDgx3cAUkGifU6fqGzY9rlTBm/LX7eK7cueUlRqIy7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023501; c=relaxed/simple;
	bh=6rWgYASyYPCCAtVl8g8P5Lz5TZFHIq4dPEXTsBDRA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPwFyfS+HjpMZwfzyKJOfGqF1VhYUMBJ+4bNFEh+zZdJnNCTR0+EW51m1MrFKBvIZ3r1qPv9SAJc/Kh1qnJm9xyBQdedbNw920lEMg0a7ZxX8nYXWfAGtBz2BVpfmeRcZV0pwlk8yEugA+kBzepu8Aciq/7x8+3u2DAPsoiuuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZzxC51Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZzxC51Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EDC1F00A3D;
	Thu,  6 Aug 2026 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023499;
	bh=NxZMgXsKRknhZFPwvdBDKIyW4s144q58cHNdT366tnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NZzxC51QwJ4HjDg4ylYDO1RhiuPNVDAiyi/Qp2vbT/LeJC+CS9MU+FtrmQXgLrbmG
	 3B/cGawdM5aM8ETI5tETxhCV4iPEZDEQRE1VMt2Ho/gqmcdKLZDLMATzHnhO9fyGaT
	 V6UPD0wiNtHQi/hwuS4GFHzMG9GXgOqEtH6kaCWqrtLLo2FHORfbtyc/7YxZlFMRSF
	 fQRe0aHDpeT9NNjnrhriqVYxXAcYCS+fcYucDJ9DkNTEg5LFO+jB3DnyF0ybRd8GT6
	 YmdSBSRr6KeLKkX4lavQ32yZ4jTRpt34WHUHZhqV0WANllyHOymgKXsBypISDLRge8
	 ByyqAT58/NUWQ==
Date: Thu, 6 Aug 2026 14:37:59 +0100
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
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <anSOKjTerc97fCGx@lucifer>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-2-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728194714.3713735-2-gourry@gourry.net>

On Tue, Jul 28, 2026 at 03:47:11PM -0400, Gregory Price wrote:
> All DAMON physical- and virtual-address operations obtain their folios
> through damon_get_folio(). That helper already excludes ZONE_DEVICE
> memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> this is inconsistent with other callers in mm/ which test explicitly.
>
> Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> so the guarantee lives in one place and covers every caller uniformly,
> consistent with other mm walkers that reject zone device folios.
>
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks, nice to make it explicit!

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/damon/ops-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d7d7f100389b..d8bca7355b4f 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -32,7 +32,8 @@ struct folio *damon_get_folio(unsigned long pfn)
>  	folio = page_folio(page);
>  	if (!folio_try_get(folio))
>  		return NULL;
> -	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio)) {
> +	if (unlikely(page_folio(page) != folio) || !folio_test_lru(folio) ||
> +	    folio_is_zone_device(folio)) {
>  		folio_put(folio);
>  		folio = NULL;
>  	}
> --
> 2.55.0
>

--
Cheers, Lorenzo
