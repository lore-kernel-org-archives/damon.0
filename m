Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9B4964F
	for <damon@lists.linux.dev>; Fri, 19 Jun 2026 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898758; cv=none; b=WyvS29AyMTsnh3afknEUp5e3CobfqxiPw/u9yfa71s9u2FXZucYUiU6UF6qEBMnuRwsw3Mahl8UaM7JxErSgUAyUhZBSDm09If8oeJyT7eFZt5Oob3eJkSn58ZMivBP7BU8nNuMARZr2mQmo8CRjRXE9V/GWdydvZ2fjwztRIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898758; c=relaxed/simple;
	bh=hpTYacq3SaRdfyD+iYo72odXZgMV4LRxBtOYo67dQIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjMzO9rWQtNXS+wNShW57wy120byxrSSeju2rYQQn7LDuQ2Ox2AXa0mLgAAC5yKAeECbjb81bDBAXyV/rjTuPVVDBMvJS7YRvFLdM63DIlINSZ+2ZxgmxKK9nQNZXKkFUtaPgdi48ZfkIYTFPZLynDCMzFQ/WMl0Yl7AFX7rEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8qS3OA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8qS3OA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B271F000E9;
	Fri, 19 Jun 2026 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781898757;
	bh=a5OIBvauAdOm9gqlpcSsvmUvmoMUPBbNQ8gyTtvnrpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8qS3OA298D+wesZ2qr2SJYFTpjVRVsGXkdoN/9pzCge4wBrf1fHUNPHJ+SG6RTKS
	 e/kU53FLJLuhRGMFtg22OxY3XKSxbxZwQO9JjRGiEDRbvd5yas8zqp6ENtQWeQFfuW
	 IWwJ4DACIpk2ZGBQ+P0SCFPYQnKseCFohH74pUb1+uRnzy5LogGZPsZDf+AQ5MbNJR
	 FP7Pg0q9E28RM+0wst9qPEydGqGlN1m1JodCwnFIGDbL/ayXZPAiR5eoOCWLZjP0F2
	 kk/x1tGbwONUgBRdd8L60v1daS1Mq5eroejsbY1LyZ119bDryWc5BKdWOwhZnkIhC/
	 13qSkhsBna4yA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 01/13] mm/damon: introduce damon_nr_accesses_mvsum()
Date: Fri, 19 Jun 2026 12:52:31 -0700
Message-ID: <20260619195232.26053-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619194428.7A3BA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jun 2026 19:44:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Kernel panic due to division by zero in `damon_nr_accesses_mvsum()` when `aggr_interval` is configured to 0.
> - [Medium] Integer overflow in `mult_frac()` leading to severely incorrect access scoring on 32-bit systems when `window_len` is large.
> --
> 
> commit 0c6de91631a66fe41c1e81f68011cf31d86b4825
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: introduce damon_nr_accesses_mvsum()
> 
> This commit introduces damon_nr_accesses_mvsum() to calculate a pseudo
> moving sum of a given region's nr_accesses for the last aggregation
> interval. The function is designed to be executed on-demand rather than
> at every sampling interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> > +		struct damon_ctx *ctx)
> > +{
> > +	unsigned long sample_interval, window_len, left_window, left_window_bp;
> > +
> > +	sample_interval = ctx->attrs.sample_interval ? : 1;
> > +	window_len = ctx->attrs.aggr_interval / sample_interval;
> > +	left_window = ctx->next_aggregation_sis - ctx->passed_sample_intervals;
> > +	left_window_bp = mult_frac(left_window, 10000, window_len);
> 
> [Severity: High]
> What happens here if aggr_interval is configured to 0?
> 
> If userspace configures both aggr_interval and sample_interval to 0
> via sysfs, sample_interval evaluates to 1 through the fallback, but
> window_len becomes 0.
> 
> When window_len is passed as the denominator to mult_frac(), does this
> result in a divide-by-zero kernel panic?

Good catch.  I will add a handling of the case in the next revision.

> 
> [Severity: Medium]
> Is there a risk of an integer overflow here on 32-bit systems?
> 
> The mult_frac(x, n, d) macro evaluates the fractional part using the type
> of x, which is an unsigned long here. On 32-bit architectures, this has
> a maximum value of ~4.29 billion.
> 
> If a 5-second aggregation interval and 1-microsecond sample interval are
> configured, window_len and left_window could reach 5,000,000.
> 
> The intermediate multiplication in mult_frac():
> (left_window % window_len) * 10000
> 
> could evaluate to around 50,000,000,000, which overflows a 32-bit
> unsigned long. Could this lead to inaccurate access frequency calculations?

I don't think that's a sane input that need a support.  We can revisit if a
real user report from this is made.


Thanks,
SJ

[...]
