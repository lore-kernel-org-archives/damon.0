Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97233E35C
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223520; cv=none; b=mYIWAPRnM9GYT57lgK70e4AN9Yr+8gu5l5fvg9DA89hI4ioIbMkvc1qnatslAV/l88js/aznAFxIvg3ctLfUMeRI4a1IJG78KgXoM8v5hzzI3obSsH7OFTWIpWOAYcSWgTHe2ICvyD/SnmRTjjWEHsCC2PwtKEoGKqoSjTmOC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223520; c=relaxed/simple;
	bh=IlB8qSL3bCHsh7P45EOnt78C+T2wSVf4jfL7NaRNuJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKemCMhJvXnQjqXYnCNvv4eDFjMmBHArX7FC5pjS03K34+3B4W3fd42mnMN1h3mxD0oabPaNwgL3rDGhPuy4BtYEhnrVRO1tcyvOImF5PMaCgoVX7FPyLVHEH+d/T0YUO47Z9CVKuctSXviTUOTs39UGcD3rO1CSOfSWZ7knISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZACp3Uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZACp3Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E21F000E9;
	Tue,  1 Sep 2026 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223519;
	bh=HzF4wQ8aVkFxllJBAlomMBMSVjaJM9+4j4l4hZRvj6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iZACp3Uc2bZAvizot9bHDMixObal1Zzw68/L/v/QD7C7tfuyP8fgQe72aYoNeccmm
	 0D36zoooUMd5vDf+op5m7e2AUAQAdcGTvDvfl6rXDVCQCJFFCxDw98qWIfeiV+j1f4
	 eXV2sNr7E0mt6CEa9rqCAm5gj5js6J77UER4/Nscnxyc2K7Gth+QrGRsPBp/Xv6gyO
	 g/Sa/vKgXzLT7uib4nVGr2BW6r8NdXzEgr264aKO9F9OjzT7TFSs0ai8yR2Lv/Xdrh
	 F8/FkxBTZ+r1/N/NeuEMqw7Gu30F/7V/mpW3AAaE2kTRMkgzzTQsy716hGh5yHOzR6
	 HV3hRcFMtKBEA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Mon, 31 Aug 2026 17:45:11 -0700
Message-ID: <20260901004512.89394-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831181632.73CD81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 18:16:31 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Unbounded metric calculation due to vmstat drift can destabilize quota tuning.
> - [High] Silent 32-bit integer overflow in `mult_frac()` during memory ratio calculation.
> --
> 
> commit 59f2c739bce03363ce501965d6708d807908af18
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> Date:   Mon Aug 31 14:47:28 2026 +0000
> 
> mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
> 
> This commit introduces a new DAMOS quota goal metric,
> DAMOS_QUOTA_HUGEPAGE_MEM_BP, to auto-tune quotas based on the ratio of huge
> page consumption to total memory consumption. It includes a fallback
> mechanism for situations where vmstat counters drift and report more free
> pages than total RAM.
> 
> Link: https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/
> 
> [ ... ]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..9c0e42a1d2cfc 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3007,6 +3007,22 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  	return mult_frac(inactive, 10000, total);
> >  }
> >  
> > +static unsigned int damos_hugepage_mem_bp(void)
> > +{
> > +	unsigned long thp, total_pages, free_pages;
> > +
> > +	total_pages = totalram_pages();
> > +	free_pages = global_zone_page_state(NR_FREE_PAGES);
> > +
> > +	if (total_pages <= free_pages)
> > +		return 10000;
> > +
> > +	thp = global_node_page_state(NR_ANON_THPS) +
> > +				global_node_page_state(NR_SHMEM_THPS) +
> > +				global_node_page_state(NR_FILE_THPS);
> > +	return mult_frac(thp, 10000, total_pages - free_pages);
> 
> [Severity: High]
> Could the independent vmstat counters drift enough to produce an
> out-of-bounds ratio here?
> 
> Because NR_ANON_THPS, NR_SHMEM_THPS, NR_FILE_THPS, and NR_FREE_PAGES are
> updated asynchronously across CPUs, they can drift in opposite directions.
> On systems with high core counts, if the system's actual used memory is
> low but the thp stat artificially drifts higher than the calculated used
> memory (or used memory drifts toward zero), the calculated ratio could
> vastly exceed 10,000 (100%).
> 
> Would this cause the DAMOS auto-tuning PID controller to calculate an
> exponentially inflated goal score, ultimately crushing the tuning quota to
> zero and paralyzing DAMON's actions?

The tuning logic ensures the resulting quota is 1 byte in minimum 2x of current
quota in maximum.  So, it will be no real problem.

> 
> [Severity: High]
> Can this calculation silently overflow on 32-bit architectures?
> 
> The mult_frac macro evaluates an intermediate multiplication that retains
> the 32-bit type of x. Both thp and total_pages are declared as unsigned
> long.
> 
> On 32-bit architectures like ARM32 with LPAE (which supports Transparent
> Hugepages and up to 1TB RAM), unsigned long is 32 bits. If THP consumption
> exceeds 429,496 base pages (around 1.71 GB), the intermediate calculation
> (thp * 10000) will wrap around U32_MAX.
> 
> For example, 2GB of THP on a 3GB system might falsely report a 9.4% ratio
> instead of 66.6%. Will this cause DAMON to mis-tune memory limits due to a
> highly truncated quota goal metric?

Known low priority issue.

> 
> > +}
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831144732.80910-1-sj@kernel.org?part=1


Thanks,
SJ
