Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C058326928
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 00:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223076; cv=none; b=Cieb6wMAaANp0hcoA7x0f8HopqfCS9fVpwlamw32+VB+qvEQ4PQx0iIh/KcVnOs0QS2DiLje+pgGf5Muop/Yq85uAVkTa68trjm7jvKqZp+cZuxbad5A06bwMAO9y5PIh5tr5sQIITyXHihHFCvoPnWr++KR5X/219/e5sZH6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223076; c=relaxed/simple;
	bh=gll1tmEnQqPkbSCMq2nO04aFlB+4+kKwAOBOtrGJEdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZDqwaWI6vs/XtPS+OEszgLjq1wuDKB1aV4GFqIfyEZ0fvTfAbtaQCwAz/V1eFv7ig8inxWFbHj291M/wYzYxy0xxNofMZfK9PMWD0GXqv8yx5KtejDV1Jbf2SRdBbcTuBXFgFgppaXTC7QDdRUtZCfpw/znhdVir0kM0yWrAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf9yGMub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf9yGMub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FD31F000E9;
	Tue,  1 Sep 2026 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223075;
	bh=AxgJkGnJ8RizMhHAI7dsNMY5qH2qdzahPkMyAV4QJNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vf9yGMub0kgLgtF6ncusuCsxeRWsWNrZJExQAajoQuTZSAE26WskLWi/7iXyQFLOj
	 varnuo+r+CpJMdaJ9ETc4bii9uPhmDPIn+pSvzJpMCbbNfrDXtLuJzFypwk08Bt0BE
	 ibKtHsx/nG3g4yYPLNVqFCV/8ehkqgKPCtyWmBZ3vkdGFuF+eSNOPzvd9Gf+PC1QJV
	 nKxfDeceWBocsHy4plEPMAVBR9zN5R96ToHusTTSKuWTu6O9/vEweXlIj4oI21qIJo
	 tQK63R2vMCtGqVK2oZtpvmfS9e06+etxKfGA9CxvMFA0LYR5Ab8UQ8KflHriH7E1CU
	 tR/GHXLHW0eww==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 8/8] mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
Date: Mon, 31 Aug 2026 17:37:47 -0700
Message-ID: <20260901003748.88963-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831184956.1DA321F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 18:49:55 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Silent integer overflow on 32-bit systems in mult_frac() usage across DAMON quota metrics, leading to drastically incorrect memory metrics.
> --
> 
> commit ba2ca9efc083502fb5555a81a42e9de1ab623b4d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle extreme memory state in get_in_active_mem_bp()
> 
> damos_get_in_active_mem_bp() uses the sum of the active and inactive
> memory amount as a denominator.  In an extreme and unlikely environment,
> active and inactive memory might be zero.  In this case, hence, it
> results in a divide by zero problem.  Avoid it by changing the
> denominator to one if it is zero, before it is being used.
> 
> Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3779a04753061..f8dddbff74a77 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3015,7 +3015,7 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
> >  	inactive = global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
> >  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> > -	total = active + inactive;
> > +	total = max(active + inactive, 1);
> >  	if (active_ratio)
> >  		return mult_frac(active, 10000, total);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the use of mult_frac()
> here cause a silent integer overflow on 32-bit systems?
> 
> The mult_frac(x, n, d) macro calculates (x / d) * n + (x % d) * n / d. On
> 32-bit architectures, intermediate multiplications like (x % d) * n are
> evaluated as 32-bit unsigned integers if x is an unsigned long. This
> silently overflows if the result exceeds ~4.29 billion.
> 
> For example, in damos_get_in_active_mem_bp(), active is counted in pages.
> If active memory reaches roughly 429,496 pages (about 1.7 GB),
> 429,496 * 10,000 exceeds the 32-bit maximum of 4,294,967,295 and wraps
> around, resulting in drastically incorrect memory metrics.
> 
> This same unsigned long overflow seems to be pre-existing in other DAMON
> quota metrics in mm/damon/core.c as well:
> 
> - damos_get_node_mem_bp(): same issue with node memory.
> - damos_get_node_eligible_mem_bp(): node_eligible is cast to unsigned
>   long bytes, which can overflow if eligible memory exceeds ~419 KB.
> - damos_set_effective_quota(): total_charged_sz is in bytes, which
>   overflows when multiplied by 1,000,000 if it exceeds 4294 bytes.
> - damos_quota_score(): goal->current_value tracks PSI in microseconds,
>   which can easily be millions, overflowing when multiplied by 10,000.
> 
> Could these calculations be performed using 64-bit math on 32-bit systems
> to prevent runaway aggressive memory reclaim or total failure to reclaim?

Known low priority issue.

> 
> >  	return mult_frac(inactive, 10000, total);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831140254.72004-1-sj@kernel.org?part=8


Thanks,
SJ
