Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21A29408
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286909; cv=none; b=j2MeCc4Zixx0Y7eIX7aB2DJRFviatzyTsiSVVqdxTT8BUT05E53bv0Er56C2UC31M4P5jbDWZQZhUi8tHwzY0WRQhH3P7tuVVoxI2sOogASUp5rveSsMA7+EufGkiuYF1GJoC0VpB7MWz+szxMID1cjhaoZQxg0SkImMKyyyEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286909; c=relaxed/simple;
	bh=ChfcFUZCusicMDCzKPX+bKNxxzvANe+cVg/Xf1FjFeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ+qclcVLvs+hQiDavoyKqgdxdmcc6Wyq4SWJ+JHG/ZH/UaofKDVLxEXmx686PR7UldMuZaMHMWR2r+ULFYHm7NkdcCIlBT7WlWXkHMKbAm71jvHUPIqPHu+cuXJdswkDGZPlB1BhoUAC1F9vGetzOqLiPWdW7Zt8qYGFDP+MUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5uJRVUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5uJRVUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D685F1F000E9;
	Sun,  5 Jul 2026 21:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783286908;
	bh=9eAYjITEbg6JAUw2zMunqETy4RrCh2yAqsR42ktui5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5uJRVUPLoNZCtSsmf6g54E8eeaT0ZXekECIHAvwuMC30TbcTPYmIKwfe7JK2CuBj
	 nJavwZc1sMK/RVC1TC1Fkk6l4x+5TGmE2vVigx6/fkmSdwYpVrSwaqZYDcpZrwE8sx
	 jYSgHuwcSTYVG9RT8PrO3N2kK51gxciyThETxmQN/g6mgu8Fs+RtSVgkXUVpvRaG2E
	 LZWDtslYczRENF9I0hEbZfVKE+2zSUxnW+LvNFQvsRwOMDyps4XoSEXc1qqMy8x0Sq
	 soJ98qP4EiQgOaXfNE05jv7SKLn6czrXrs0GxLVIr6oVUHk9dbDXfvrJaiCpl3SkF+
	 PT8NXX2PsPyXA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 03/16] mm/damon/paddr: set samples in apply_probes() if requested
Date: Sun,  5 Jul 2026 14:28:18 -0700
Message-ID: <20260705212820.100537-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705211147.EFEE11F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 05 Jul 2026 21:11:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The `probe_hits` counter in `struct damon_region` is an 8-bit integer (`unsigned char`), which overflows if the ratio of aggregation interval to sampling interval exceeds 255. When this wrapped value is used by `damon_merge_score()` (introduced in this series via `damon_probe_hits_wsum()`), DAMON incorrectly merges regions, breaking its core tracking logic.
> --
> 
> commit 26a2b31429c08214403a84c01f1b8d381e461d92
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/paddr: set samples in apply_probes() if requested
> 
> The apply_probe() callback implementation in DAMON_PADDR ignores the
> set_samples parameter. This commit updates it to respect the parameter by
> setting the sampling address if requested.
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index b13bf7c6eade3..ff4fcca949660 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -178,6 +178,10 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> >  			phys_addr_t pa;
> >  			struct folio *folio;
> >  
> > +			if (set_samples)
> > +				r->sampling_addr = damon_rand(ctx, r->ar.start,
> > +						r->ar.end);
> > +
> >  			pa = damon_pa_phys_addr(r->sampling_addr,
> >  					ctx->addr_unit);
> >  			folio = damon_get_folio(PHYS_PFN(pa));
> 
> [Severity: High]
> This is a pre-existing issue, but does this code overflow probe_hits[]?
> 
> Looking at include/linux/damon.h, probe_hits is defined as an 8-bit integer:
> 
> struct damon_region {
>     ...
>     unsigned char probe_hits[DAMON_MAX_PROBES];
> 
> Shortly after the sampling address is set in damon_pa_apply_probes(), this
> counter is incremented:
> 
>     damon_for_each_probe(p, ctx) {
>         if (damon_pa_filter_pass(pa, folio, p))
>             r->probe_hits[i]++;
> 
> If a user configures DAMON such that the ratio of aggregation interval to
> sampling interval exceeds 255, this counter will overflow and wrap around to
> zero.
> 
> Since this patch series modifies damon_merge_score() in mm/damon/core.c to
> rely on this counter:
> 
>     if (use_probe_hits)
>         return damon_probe_hits_wsum(r, last, ctx);
> 
> Could this overflow cause highly-accessed regions to be treated as having few
> matches, leading to incorrect region merging and breaking DAMON's core tracking
> logic for filters?

It can overflow, and it is the intended behavior.

Since the core layer parameters validation series is just merged into mm-new,
I'm considering limiting aggregation interval to be less than 256 * sampling
interval using the validation mechanism, though.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260705205743.98656-1-sj@kernel.org?part=3


Thanks,
SJ
