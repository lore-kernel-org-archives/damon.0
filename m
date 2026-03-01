Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D5202F71;
	Sun,  1 Mar 2026 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772383353; cv=none; b=jZuqTp8rybdaGiekG3MHxVPlYt2MsUCe7FHhac5kabbXd+T2f+JkkYtSTBMB5rywRdcXdWGEtOaIhGx/wgnmen81EH8cAeuby9O3qJ82df1AARXcBujHiBOh8VnaFWln6FfktPFRoZjJziOdkXEKYRed4iz09RExoi4Z9vtkqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772383353; c=relaxed/simple;
	bh=2gPoW7S6UrtEjGc6IJ81tfoCTpZblLaI9E7KswG3ITU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgUsxo220hk8uXLUYl+JSHNQEHgI9QX40lBS5vgWAUobUaSnHu0IFZauxjrSe9nWiwAlAm6LR1eWXdHzzm1Fj4jYaRbEA+OMJp/ePTyPfHtx9hhxjxQU6Qj+g5pBV2cEKRTTAd5i3QinG7MUb/AGavivp0WJB5E/DTJjCgwO4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wnd70n6j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wnd70n6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF7DC116C6;
	Sun,  1 Mar 2026 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772383353;
	bh=2gPoW7S6UrtEjGc6IJ81tfoCTpZblLaI9E7KswG3ITU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wnd70n6jiT0ymJ3bZwNy8tt0sM37n3DbyG9rBZ7/nDH0Xx01Rpu9ecDXBPcQrSwQH
	 8+pui6ei6kTqKPaMFYKOjbUVLcf7AzzlJ5ysP3ASBSfbP+Gz093exPm/ch2k/UxPxJ
	 UiasMVnDPx2N6m64OSFAX6ympGAKUGikcLoaQ4z9/gvU5DfhE8o3ycHdfoDwI4xsYC
	 EiL+G1gUgq4z3/meX3wghqQzPqdkAQMBgGZNIUoVqzgsLqhBHYkyU9D48mgDUm0VkJ
	 UG5+O4WQza1TH/DTcTOjq+OE+Uo7j6lALf/9RF/MrPDF84xeyqhNBzX5Gh2EAmvRct
	 RExOjJqdBLWLg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 06/10] mm/damon/core: add damon_merge_regions_of() debug_sanity check
Date: Sun,  1 Mar 2026 08:42:25 -0800
Message-ID: <20260301164226.93108-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-7-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Feb 2026 11:36:23 -0800 SeongJae Park <sj@kernel.org> wrote:

> damon_merge_regions_of() should be called only after aggregation is
> finished and therefore each region's nr_accesses and nr_accesses_bp
> match.  There were bugs that broke the assumption, during development of
> online DAMON parameter updates and monitoring results handling changes.
> Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 291a847a8c9bb..94be598cafef1 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2545,6 +2545,22 @@ static void damon_merge_two_regions(struct damon_target *t,
>  	damon_destroy_region(r, t);
>  }
>  
> +#ifdef CONFIG_DAMON_DEBUG_SANITY
> +static void damon_verify_merge_regions_of(struct damon_region *r)
> +{
> +	if (r->nr_accesses == r->nr_accesses_bp / 10000)
> +		return;
> +	pr_err("nr_accesses (%u) != nr_accesses_bp (%u)\n",
> +			r->nr_accesses, r->nr_accesses_bp);
> +	WARN_ONCE();
> +}
> +#else
> +static void damon_verify_merge_regions_of(struct damon_region *r)
> +{
> +}
> +#endif
> +
> +
>  /*
>   * Merge adjacent regions having similar access frequencies
>   *
> @@ -2565,6 +2581,8 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
>  		else
>  			r->age++;
>  
> +		damon_verify_merge_regions_of(r);
> +

This verification doesn't need to be here, after the above 'age' updates.  I'll
move this to the beginning of this scope in the next spin.

>  		if (prev && prev->ar.end == r->ar.start &&
>  		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
>  		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
> -- 
> 2.47.3


Thanks,
SJ
