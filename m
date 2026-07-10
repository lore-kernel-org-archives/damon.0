Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75E3DB651
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695180; cv=none; b=oLnAqJZCaYoHX8DQb9o/q4xZ4TRUG0zLndRJsHYOkLQrXPe4YrCjzWxfp2ZrmFEwCl+Brx7B0GUSh/mEWGelP12qE5Gtz6X9oUa/oERrVF/DeBARVQdLMEeiC7kbU0FlS1C2UlFr0bzpk18D3BngDlwiIYawyRltjA9G0CWbDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695180; c=relaxed/simple;
	bh=/K3qi3+zBTtXVtwQcKBxsVpJT2TTyXtN3cK2vobYJfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9pX2sHRWLKB5g5r93RiMdzsNeaC5HADdjZmj4mjHrPP28Lt75HXxVsQcJ4aecZv1BbhqoHavzaBI3OHACnE93X8WY9RJ1Q0ZVmlcCQcqfZokuwXPNfj9v1rub/GPlygXae2JZoxGrC7uIO5xjsc1yaqMOqHz2T/F2XcdXW2GJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/GMG0Vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/GMG0Vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FBE1F00A3A;
	Fri, 10 Jul 2026 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695177;
	bh=ApTZzKMYgomPIHqJIHiPlShA+Ydk8lApjG6R0iDPVac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L/GMG0VsemdPnCporufjLLbmb3XnrKD5mkAZ+nNJRmf05OwzsG57jmlgir5Gf8Tx1
	 s/RK/gyUxxRgyCRG7FyPncylc0UrDEX+vPJ2merK4XlPCvXKZ2ovC0qYWB71OjkCoN
	 KcJBva7tRmp7I0EQlJu6tiCfnd93uxPSFttS7Gbt8WXLP+H18X2m2LZFe2DcGMpbJH
	 uyd/U6BdQm6rIulV/zYTVvZzI2sDVrgwcDiscDZ/VlXsz2ARe/YBqwC2+zLWyLgZiw
	 VDjDvNDtXUqdp8Ed2s60XEVoZjAiGRqtvZgcuP2+YfuezEbz8/yePCYq0TfKro7Lac
	 MBn7qsELdCUQg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set
Date: Fri, 10 Jul 2026 07:52:47 -0700
Message-ID: <20260710145249.27265-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710140254.9DD651F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:02:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] kdamond_merge_regions() uses a stale or 0 threshold (max_nr_accesses) when probe weights are set, preventing proper region merging.
> --
> 
> --- Patch [12]: [PATCH 12/19] mm/damon/core: set samples in apply_probes() if probe weights are set ---
> commit c57b42d6ad5d1b962d67f040aa171492d081c859
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: set samples in apply_probes() if probe weights are set
> 
> When probe weights are set, the prepare_access_checks() ops callback is
> not invoked, so sampling addresses of regions are unset. Ask apply_probes()
> to set those together in the case.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 65f91e3b58d2e..dd0612e1a408b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3777,7 +3777,8 @@ static int kdamond_fn(void *data)
> >  		if (!access_check_disabled && ctx->ops.check_accesses)
> >  			max_nr_accesses = ctx->ops.check_accesses(ctx);
> >  		if (ctx->ops.apply_probes)
> > -			ctx->ops.apply_probes(ctx, false, false);
> > +			ctx->ops.apply_probes(ctx, access_check_disabled,
> > +					false);
> >  
> >  		if (time_after_eq(ctx->passed_sample_intervals,
> >  					next_aggregation_sis)) {
> 
> [Severity: Medium]
> When access_check_disabled is true, ctx->ops.check_accesses() is skipped.
> Does this leave max_nr_accesses stale or set to 0 when it is subsequently
> passed to kdamond_merge_regions() shortly after this block?
> 
> If max_nr_accesses evaluates to 0, it seems this might defeat the 10 percent
> tolerance logic for region aggregation.
> 
> Could this force adjacent regions to merge only when their scores match
> exactly, leading to region fragmentation until the maximum region limit
> is hit?
> 
> Since damon_has_probe_weights() currently returns false unconditionally
> to safely stage the new feature, this appears to be unreachable today, but
> might become a regression once the feature is fully enabled.

No issue.  access_check_disabled is always false at this moment.  A later patch
in this series will avoid the issue before it can be true.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=12


Thanks,
SJ
