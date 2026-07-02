Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FE41C71
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951495; cv=none; b=g3/k+pjWMSIysL06C8x8at/7lcNg6IvMAvnngVF3/dNQVqrLz/IQT8tkpvtiGsfqrwdTGOD/sRlXiHjlTpjFecIT8pfGSLo/vor/2oe9tHt3dFai0KJAaHB7fbsiNUGS9zZP6vg2b6FfraetkrMLaa7K+OwXUA2NaW+655GWrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951495; c=relaxed/simple;
	bh=RwyN5wF22Bktg5zvEFIlmq9JObMp4v2pj7knsh/0oqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdfrKbuRCR1Obe+DuEFRiAdJ7uBqKgA75DvDP4zKvi2Grl5yHSiolUZaHXueHvraBgcXfnlIK05DZU5xPD83tEOxPlIMyXl8E5E/keeTqB4tP4T3IS9WKT71OjZBNSIlaC749jW29kl3StPR3gskR9c2+d7ugwfPGVHSO3kHeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVmN2Isw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVmN2Isw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748861F00A3A;
	Thu,  2 Jul 2026 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951494;
	bh=tB+k42O9GCXB5tQLC5pveS2zJySjrfqEesZZ2gloUW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KVmN2IswoMqO8cR7JCFav29Na6j9lPSCRhtmgVO2wFXGHCYhBB1CotLPU7S3hZThO
	 G7XZBQInrpsVVs7TH4z1kiNhjyUikqeULzkTb5VqO/YNgPCD2WgrHlhtXPNaoILrHk
	 K9i6dlwg8KHL/h7WRXYEp7DwEko2aqSZNFxq19nRLMXCOELPTrNBUWPz4wch5UjV7y
	 BBw4uWI86OjNz7n9WnlFYZjWcjCoEsDIpl3A56ppkT/oTaP4ED6QC7EcJwOzrkR0ej
	 I3mfzt9wj+N86Rg3HF0RyE54/72eBCKGyEugs8bTNqZSCkxzchTSW4QZEnjiass1Xm
	 l2fCAQHPi3+jA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 7/8] mm/damon/core: remove start, end check in damon_set_region_system_rams()
Date: Wed,  1 Jul 2026 17:18:06 -0700
Message-ID: <20260702001806.86969-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701162221.370651F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 16:22:20 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removal of bounds validation permits inverted regions (start > end), leading to a massive integer underflow and guaranteed OOM kernel panic.
> --
> 
> commit 03335779d391504c4265be49dedb155969cf1a7d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: remove start, end check in damon_set_region_system_rams()
> 
> This commit removes the explicit start > end validation in
> damon_set_region_system_rams_default(), stating that damon_set_regions()
> already performs a complete check.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ace202f47dd7c..f491a76c98bfc 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3794,9 +3794,6 @@ int damon_set_region_system_rams_default(struct damon_target *t,
> >  {
> >  	struct damon_addr_range addr_range;
> >  
> > -	if (*start > *end)
> > -		return -EINVAL;
> > -
> [Severity: High]
> The commit message states that the complete check is done inside
> damon_set_regions(), but does damon_set_regions() actually validate that
> start is less than or equal to end?
> 
> Looking at damon_set_regions(), it appears to blindly create the region
> with underflowed sizes if start > end:
> 
> mm/damon/core.c:damon_set_regions() {
>         ...
>         r = damon_new_region(
>                 ALIGN_DOWN(ranges[i].start, min_region_sz),
>                 ALIGN(ranges[i].end, min_region_sz));
>         ...
> }
> 
> If an inverted region (e.g., [4096, 0)) is passed in, could this lead to a
> massive integer underflow? The size of the region would underflow to roughly
> ULONG_MAX.
> 
> Later in damon_apply_min_nr_regions(), this underflow seems to translate
> into an effectively infinite loop:
> 
> mm/damon/core.c:damon_apply_min_nr_regions() {
>         ...
>         while (damon_sz_region(r) > max_region_sz) {
>                 damon_split_region_at(t, r, max_region_sz);
>                 r = damon_next_region(r);
>         }
>         ...
> }
> 
> Could this loop exhaust system memory by attempting to allocate quadrillions
> of regions and cause an OOM kernel panic?

My previous reply [1] should be applied here.

[1] https://lore.kernel.org/20260702001650.86841-1-sj@kernel.org


Thanks,
SJ

[...]
