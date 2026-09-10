Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E548F842
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050871; cv=none; b=TMYsSgP11SP1h+acR9xrljMm/r7PGa+Hu4rOGvVwUUwGqXM1qf9BQUlWOprd16uiAFBH/WiLyypEf4m/upf0CC5OIbB5KKiV1q0wCMuPWoeaUBMhKgMq7P2PFJeA/LUb/fRhvSM2sYEM4tX8jhCAP5naPowg32Mj2CEnEKsp1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050871; c=relaxed/simple;
	bh=FzAupavITpcpFXE2OIrLzydWV5uJKBuTURQx+ep+VS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4P+f0PU2nkXzRHptmQqSN0Rskzk+4pHopWb5fgLWftW20aLj83Axtjtd0UEz1Q/5lwr8PUJqTJvM3D6jTGDOiETwGQJyR4vXOwqZTLkN79KSzz2Sh27ijwcYpyQltEYcbFz40EiFlGYc65BUQ6PNlYD4ZtNgHHS6t+dvYNF2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhppB0vQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhppB0vQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F44A1F000FF;
	Thu, 10 Sep 2026 14:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050870;
	bh=sfx0HlymFPifhWbtVbUftKwiHUQ18Xts0IiDLvXBDZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FhppB0vQHE/FCMPOOeacu780DBN2+egO8867TqC81WxKz2pw8nzoGo9AQtlrAqWCs
	 SRjbY9gp2xUNRWoGmeir1liNiB8W1JZ+EL8F8rFE3Jr84f7dsYN3VMSKy/muk8f8tb
	 JumfXJXzUYp6DpYWG+XwF4Vnvxybyx7r9x0MuvKgVGrjgS9U4OR29AA8N64plgLDdb
	 1/Gtpa1REgriQlzWiim/QRzRLH3+BVdQFfqS+slJpgoyrK6B5DK7hLE4ZiuI6W2iUh
	 8TSW2kkmSbcIL/VveYdDQLmM9ttkSRiveyPFWyVeN+3t+fk7GbxQinDaP8DuszohOW
	 oRVvAGZXbT67Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Thu, 10 Sep 2026 07:34:21 -0700
Message-ID: <20260910143423.173709-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142606.B7A281F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 14:26:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing KUnit test coverage for the new DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter.
> --
> 
> commit c30ab09af6b4b9ef8cab31ff2d43ce4d72f9e904
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: support probe_hits_wsum damos core filter
> 
> This commit implements the probe_hits_wsum DAMOS core filter support. It updates
> the core layer to treat it as a core filter, copy its range parameters, and
> match regions based on their weighted sum.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e9630f41e51fe..d9d56f4be1a97 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
> >  	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
> >  		dst->sz_range = src->sz_range;
> >  		break;
> > +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> > +		dst->range_min = src->range_min;
> > +		dst->range_max = src->range_max;
> > +		break;
> >  	default:
> >  		break;
> >  	}
> 
> [Severity: Low]
> Should this patch also update the KUnit tests to cover the new filter type?
> 
> The new DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter is not validated by the 
> DAMON core KUnit tests, leaving this argument copying logic untested.
> 
> For example, it appears missing from the validation switch in 
> damos_test_commit_filter_for():
> 
> mm/damon/tests/core-kunit.h:damos_test_commit_filter_for() {
> 	switch (src->type) {
> 	case DAMOS_FILTER_TYPE_MEMCG:
> 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
> 		break;
> 	...
> }
> 
> And the orchestrator function damos_test_commit_filter() does not seem to 
> invoke a test case for the new probe_hits_wsum filter.

Good suggestion but no blocker.  I will consider doing this as a followup in
future.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910141849.170896-1-sj@kernel.org?part=3


Thanks,
SJ
