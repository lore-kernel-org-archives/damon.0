Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59000299A82
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976755; cv=none; b=tc28DhCUK6sS2dSL6N4NHc0LnlrszYob5H3UJINXoztmsaxuyQ/edaOFWldq+67HeVVSjYPr4Deq05PI0QAsTLWBsSF3SQ8ymZm/Fk7FZZQlifRQvjKBc3dH6D7iNXTtIwSYan4I9/UlrH5alKQWoHc6eHi/gZdbctMAvq2OOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976755; c=relaxed/simple;
	bh=G+CuynHKCf130E19Jpd3jZKHhq4NxOzoMKXVA10G1kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2uvSpjcsmkj/grXWDt+EdVGATkZo2gVx43eMH7Oi3EvTsVreH1J4dbC/XWkyUDYqlIf1ymmdBHj+wRwapzJyMtVcJcfjBkf/Bq79RYgfjIytEL9NZcyo1ea3fx+WfsLMaVMS4wU4chVOnUOjzNOR5p1gal0j5BzyNSgMqjKa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTUgvRzn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTUgvRzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85DB1F000E9;
	Sat, 20 Jun 2026 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976754;
	bh=+63JghOeGhM11HISez2jW+xr0KF9G8nvQrZ0LMuBUpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BTUgvRzn5SiKsa1VJ+NzYQNUM8Q2VTc6faFwbLMT21tyKyghhUTYiiDJVrhoVMfQA
	 dk0bu9HtPJgyEKLCb8mlE3na1J9NRdF+zSUtnLigcx35T1wSg/rJq4dhZ+z/0NFdNT
	 KaijFP3CT7EK/6fqyybBxOkkJdOLq4NpuLCvQvRu49Tj9e1RewAGQ9bCZ1LRyP2ZWI
	 dfxnuMizO0xzeLW8CnxN8HixJ3sLTbVCHgoYWKqcmuFMfDBsgvXoxDf/CMAsvFeWYk
	 tdqEolZVQ0Laz2/q3UL0SuPcYqsIoWIUbseGB+88G29dB6gocwglvM5gAQVNu+OIws
	 pSorLRjfqKMGg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1] mm/damon/core: handle zero intervals in damon_max_nr_accesses()
Date: Sat, 20 Jun 2026 10:32:28 -0700
Message-ID: <20260620173230.91842-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172503.2DA311F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 20 Jun 2026 17:25:02 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Pre-existing integer overflows when scaling `nr_accesses` based on user-defined intervals.
> --
> 
> commit 2fc9b9ee26cec1a6b183b74636dd1922579cd4da
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle zero intervals in damon_max_nr_accesses()
> 
> damon_max_nr_accesses() causes a divide-by-zero if the sampling interval
> is set to zero by the user. If the aggregation interval is set to zero,
> the function returns zero. It is wrong, since the real maximum
> nr_acceses in the setup should be one.
> 
> Link: https://lore.kernel.org/20260619202459.145010-1-sj@kernel.org
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 6f7edb3590ef9..888570f55b416 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -1065,9 +1065,13 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  
> >  static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
> >  {
> > -	/* {aggr,sample}_interval are unsigned long, hence could overflow */
> > -	return min(attrs->aggr_interval / attrs->sample_interval,
> > +	unsigned long sample_interval;
> > +	unsigned long max_nr_accesses;
> > +
> > +	sample_interval = attrs->sample_interval ? : 1;
> > +	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
> >  			(unsigned long)UINT_MAX);
> > +	return max_nr_accesses ? : 1;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but are there integer overflows when scaling
> nr_accesses based on these user-defined intervals?
> 
> Since DAMON allows configuring sample_interval and aggr_interval via sysfs
> without restricting their ratio, a region's nr_accesses (an unsigned int)
> can grow up to aggr_interval / sample_interval.
> 
> If this ratio exceeds UINT_MAX, nr_accesses wraps around. More practically,
> the codebase multiplies nr_accesses by 32-bit integer constants:
> 
> In mm/damon/core.c:damon_merge_two_regions():
>     l->nr_accesses_bp = l->nr_accesses * 10000;
> 
> Can this overflow 32-bit unsigned math if the access count is greater than
> 429,496?
> 
> Similarly, in mm/damon/ops-common.c:damon_hot_score():
>     freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / damon_max_nr_accesses(&c->attrs);
> 
> Does natively multiplying r->nr_accesses by 100 before dividing by the max
> accesses cause a 32-bit integer overflow if the accesses exceed 42,949,672?
> 
> Additionally, on 32-bit platforms, can this calculation overflow unsigned
> long?
> 
> In mm/damon/lru_sort.c:damon_lru_sort_apply_parameters():
>     hot_thres = damon_max_nr_accesses(&attrs) * hot_thres_access_freq / 1000;
> 
> Multiplying damon_max_nr_accesses (up to UINT_MAX) by hot_thres_access_freq
> natively overflows unsigned long on 32-bit architectures.
> 
> Could these overflows corrupt DAMON's core metrics, potentially causing
> incorrect memory operations like aggressively swapping out hot pages under
> the false impression that they are cold?

We believe this happens only under very weird setup that is not realistic, and
hence ignoring this kind of issues for now.  We could revisit if a user claims
this as an issue.


Thanks,
SJ

[...]
