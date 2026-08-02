Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3B23393C
	for <damon@lists.linux.dev>; Sun,  2 Aug 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693119; cv=none; b=tYXx4sxIt3u4DrbIwzWcjSdkmklcFeYtvQRVaCyGml5YfCKX95xvBpdMG8iNcb3L2ZmhvrmUYbaPnb0yIwiAyCmL7CV4NlinZ/Adte0n8cfGZJYjAbfP0Yqas3xs0kAll4bFjjQJgsLI5B486aWcsWUL7VwhFbfsb91NUGLb6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693119; c=relaxed/simple;
	bh=697+xcFKq1gyLX+M9xU8lW3tvMwjnnuE1NnPut66IDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BheZi+OcjAB+tkIllCBeBQ9+N0E8/wge33GIsQib3k/P9nWGN+P0Xkt72CZuK8+fZTlJbObFu0MF0R/NA4u/I7LpO+igsoQcR+rdxDfGFDePiyZzFSU4gygNcHLNnzMb6T+xP3G79p9tq7FL7pe1AXtpLDuVvTkSHaEOAxvx8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5RmwJRK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5RmwJRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1B11F000E9;
	Sun,  2 Aug 2026 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785693117;
	bh=PnvCsjZ4zqRSFP1lkm1JXq5RELNNYJW7PzlofioahJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5RmwJRKorIGhCgLEukLdP5+7TNF1yH4tnZa8Nqrbr9JHLtBoDkmy0mUHXyV3PFon
	 tKm4QaLDBMRZufiBDpvuWt0QxrTwYTdvN8+K/FjbWFXbLYVw3oNcK+QoMKDdXNxgKz
	 hLupgX8hnFM6rY7EH0UehNat9Nb8ElqdhrGL8Zu+Zp84b2UjBS4QNIuOQaiXI0uR59
	 4HvIxYtp5EIAu/N7Eb0IvAQ2qD821t4DWv3KA7EtVe+Txjasm3Zt02NtfiIND7H8Km
	 dXtvBPpa9ZVFD9rhTnhYx9itl4XWQ7LdDo6DKJRI3l4h1TEOia8dXGqcjoVLBEnx6F
	 z8jkI8wPiVI6A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 9/9] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Sun,  2 Aug 2026 10:51:49 -0700
Message-ID: <20260802175150.2143-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802165105.947281F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 02 Aug 2026 16:51:05 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflows and truncations in DAMON memory metric calculations cause wildly incorrect quota logic on 32-bit architectures.
> --
> 
> --- Patch [9]: [RFC PATCH v1.1 9/9] mm/damon/core: handle extreme memory state in get_in_active_mem_bp() ---
> commit e72445b8d3c8d0866c458b7707c7433d7912c2e6
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
> 
> This commit addresses a divide-by-zero issue in damos_get_in_active_mem_bp().
> It ensures the denominator is at least 1 when calculating the ratio of
> active or inactive memory, preventing a crash if both are zero.
> 
> Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 67ad1f07c29a4..c79b854e1a971 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3014,7 +3014,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
> >  	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
> >  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> > -	total = active + inactive;
> > +	total = max(active + inactive, 1);
> >  	if (active_ratio)
> 
> [Severity: High]
> This is a pre-existing issue, but does this code overflow 32-bit unsigned
> math on 32-bit architectures?
> 
> The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Since
> n is 10000, the multiplication x * 10000 is performed using 32-bit unsigned
> arithmetic on 32-bit systems (where unsigned long is 32 bits). If active
> memory exceeds 429,496 pages (~1.76 GB), the multiplication overflows
> ULONG_MAX, resulting in an incorrect ratio.
> 
> Does this same overflow also affect other DAMON memory metric calculations?
> For example, in damos_get_node_eligible_mem_bp():
> 
>     return mult_frac((unsigned long)node_eligible, 10000,
>                      (unsigned long)total_eligible);
> 
> This explicitly casts a 64-bit phys_addr_t to unsigned long, truncating
> capacities over 4GB on 32-bit systems. It also overflows mult_frac() if the
> eligible memory exceeds just ~419 KB.
> 
> Similarly, in damon_get_intervals_score():
> 
>     max_access_events += sz_region * c->attrs.aggr_samples;
>     access_events += sz_region * r->nr_accesses;
> 
> Because sz_region is in bytes, accumulating these into an unsigned long
> seems to overflow for regions larger than a few tens of megabytes.

Known low priority issue.

> 
> >  		return mult_frac(active, 10000, total);
> >  	return mult_frac(inactive, 10000, total);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260802162631.90304-1-sj@kernel.org?part=9
> 


Thanks,
SJ
