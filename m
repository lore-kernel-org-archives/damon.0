Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D9360EE2
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730163; cv=none; b=n6RTOUyBeFJZR8M6VgOVA++H96woJNiblGouz3x7WAuW7XzIdDuxOeRhNq4UhpbEerNZl1iLgyQC/R/1kYe5NOGivoOOHnUPwKRZDIjf5iYlgTQLpJ5R7yBlRfi7qmrdlS7iWFBsll/lkNhbW9JHPozADCIHUhYcoWNXa4WS8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730163; c=relaxed/simple;
	bh=3uQspdSs0+5VXB18+0UeK5qPB/RratGQ389b9zgbQTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQkSUr1GvspV0RkUAa6Nlo8hMTK/t1jkGeRvo0dwGEmf2o0mo54NdZfYK9UvzghS/tLLZ1SNKGj5IM6KhVXul3aoO2Bn+NZ39545Ms1adly59uFnh2nKiEh/imT4bEY2TGuREIGnKFKeGi4GgH9n1TU7Hfl+bwd4P5EJs93RKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3s47l4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3s47l4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD4E1F00A3D;
	Sun,  6 Sep 2026 21:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788730162;
	bh=ZvGsm4n8GEfZ1ggL6CF3L0qW3laUsm0eX6HCV+Nf4Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3s47l4WPup0VZj9zi4G2vKz32nOCIdyKB6BmJpRQHUdfGruwfAxBXWWgoZPXBjAb
	 auNLusiJN4JkpetUiFqbsVl3ibrtB/3359i+6RMCeEO8DbBv2K+RiqN+zv34X03xvI
	 jZ3a0Cj3QA4o3g+fpPDiHlrSEERzluEvnZcfuI/WU1Fs37ZeUi53AXW5KKMlyRAxTt
	 Q0ph9Yvf8RcFlnp9+467/k59FPRXs09WcB7DuSqV5TWDf1JB5Y3F5WjsC+mAXAns0q
	 bw6gOj7nVpEIFroY/YucLKgkW/RtWgUUVz4EMCj+whJUZaottFtRYzmykr1eaGOevs
	 xf1TI41RsrEwQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 2/6] mm/damon/core: support probe_hits_wsum damos core filter
Date: Sun,  6 Sep 2026 14:29:13 -0700
Message-ID: <20260906212914.108567-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906211753.CD8911F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 06 Sep 2026 21:17:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] DAMOS_FILTER_TYPE_PROBE_HITS_WSUM uses raw, unscaled probe hits instead of a moving sum, leading to inaccurate filter evaluation when apply_interval is smaller than aggr_interval.
> --
> 
> commit 75c1f2781e8de8f015329fce3e8a8d40e521f7de
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: support probe_hits_wsum damos core filter
> 
> This commit implements the probe_hits_wsum DAMOS core filter support. It
> updates damos_filter_for_ops, handles the range parameters during filter
> commits, and calculates the weighted sum of probe hits for filter matching.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ce8c6f99106ed..ec1a1666aa9cc 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2538,6 +2543,11 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  		damon_split_region_at(t, r, end - r->ar.start);
> >  		matched = true;
> >  		break;
> > +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> > +		wsum = damon_probe_hits_wsum(r, false, ctx);
> > +		matched = filter->range_min <= wsum &&
> > +			wsum <= filter->range_max;
> 
> [Severity: Medium]
> When a scheme's apply_interval_us is smaller than its aggr_interval_us, does
> this evaluate incomplete probe hits?
> 
> Because the probe_hits array accumulates from zero over the aggregation
> interval, evaluating the raw probe hits mid-interval yields artificially low
> values. This differs from access pattern evaluations, which scale the count
> based on the elapsed fraction of the aggregation interval (for example, using
> damon_nr_accesses_mvsum()).
> 
> Could this cause regions to incorrectly fail or falsely match the filter
> depending on when the scheme is evaluated within the aggregation interval?

Good catch.  I will extend damon_probe_hits_wsum() to provide moving sum based
weighted sum, and use it in the next revision.

> 
> > +		break;
> >  	default:
> >  		return false;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260906210513.106895-1-sj@kernel.org?part=2
> 


Thanks,
SJ
