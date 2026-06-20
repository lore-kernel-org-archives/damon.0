Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F5233922
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977171; cv=none; b=h1X+kq55ANYNF0JUjSrI7JbKGBvY/Pz1x8sb+CuOGIp4TyaN8H8UrS8cMLt99SwzjhjamjIG9oIqSZjnBpI1wlDKnSxsBy9ggCSjia3rJudVcYs4l8LZiqRnFFyYHnFIFQ/SjvRCqpWHR9RSNReZnVnpV/kEliSzAwvsLJxTf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977171; c=relaxed/simple;
	bh=BbwMWl3Tr2gflJkdwRQQQLARveXURLeodHYTAVDASwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quwZLTU0RwnF0ZIrhXSuyPFdXCzxuxanYVWHHs5RPLv+X043VlYskdwMdYU4PGKby3hNzBOdFTCary0bIYoHOzRq6gqvb9VUn0wlMbWSMyq+3KcAWXkE+2J8d56KnMC9aGFBN27btQR/58bC5odW2CwKHV80/O8z7PR0mF7Idgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrBa4pfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrBa4pfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F1F1F000E9;
	Sat, 20 Jun 2026 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781977170;
	bh=5WN9zYq6d8Ke8qkw5u/yEiSHA/mJif+nwlSf6u7qf7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SrBa4pfwlNJBwEN+mmFei65xbz9AUXHhG10NIscAr9Dq33uNnwkkWtP1uMELdEMUl
	 8Snm4X0rt7Ho/I5OD8SXJ7fZIB+LXCsowEsxQ+MSr8NTsg3y650CsZnAm4pZIQJB4B
	 aDrS2q3br611Egz6mg7d2YQMeJj0lARelEiJIPCjelnvzNqpiX3xhb566r2dChegrc
	 HPN8GMC1sH9Dwk8oBvUmluC/5EgY0VOrErLBNDiFYpxw4B84TIYMn3d1jnYfd1+vHG
	 oWVzKIosFyc3cyi/fp5CLrB4eRnunV2P1F3NiFyexRSu+7f9gX5VLR0cC11yiT0DQd
	 8jgnaY3HPHMeA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 01/13] mm/damon: introduce damon_nr_accesses_mvsum()
Date: Sat, 20 Jun 2026 10:39:14 -0700
Message-ID: <20260620173914.92469-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620173632.E56031F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 17:36:32 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Integer overflow in `mult_frac` within `damon_nr_accesses_mvsum()` corrupts DAMON moving sum access score on 32-bit architectures.
> --
> 
> commit 33b6652e4ab7390d9a1e1c6a292edc9a0fec212a
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon: introduce damon_nr_accesses_mvsum()
> 
> This commit introduces damon_nr_accesses_mvsum() which returns a pseudo
> moving sum of a given region's nr_accesses for the last aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7e4b9affc5b06..af95783d3402a 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -210,6 +210,63 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> >  	return NULL;
> >  }
> >  
> > +/*
> > + * damon_mvsum() - Returns pseudo moving sum value for a time window.
> > + * @current_nr:		The value of the current aggregation window.
> 
> [ ... ]
> 
> > +unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> > +		struct damon_ctx *ctx)
> > +{
> > +	unsigned long sample_interval, aggr_interval;
> > +	unsigned long window_len, left_window, left_window_bp;
> > +
> > +	sample_interval = ctx->attrs.sample_interval ? : 1;
> > +	aggr_interval = ctx->attrs.aggr_interval ? : 1;
> > +	window_len = aggr_interval / sample_interval;
> > +	left_window = ctx->next_aggregation_sis - ctx->passed_sample_intervals;
> > +	left_window_bp = mult_frac(left_window, 10000, window_len);
> 
> [Severity: High]
> Can the intermediate multiplication inside mult_frac() overflow on 32-bit
> architectures?
> 
> The mult_frac(x, n, d) macro computes (x / d) * n + (x % d) * n / d. Since
> left_window is generally less than window_len, the remainder (x % d) evaluates
> directly to left_window.
> 
> On 32-bit architectures, both left_window and the resulting product are 32-bit
> unsigned long values. If window_len exceeds 429,496 (for example, a 5ms
> sample_interval coupled with a ~36 minute aggr_interval), the intermediate
> calculation of left_window * 10000 can exceed ULONG_MAX (4,294,967,295) and
> silently wrap around.
> 
> This wrap around would cause left_window_bp to calculate as a truncated,
> artificially low value, leading to an incorrect access frequency score that
> might affect memory reclaim or protection decisions.

This can happen only under a weird setup that we are not aiming to support for
now.  We could revisit this if a real user claims this as an issue and ask a
support.


Thanks,
SJ

[....]
