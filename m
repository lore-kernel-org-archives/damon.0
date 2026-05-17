Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755773B636B
	for <damon@lists.linux.dev>; Sun, 17 May 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042122; cv=none; b=dL63HqAhr10ciGMZb8yEWayouJEFE5RSnGwRkQaNq6TAnvqYRLbfjhMzzMo/LNe4P0O/eQLpVdtjRh5P2EKYmqsVYaUJ+7cHFZXINCNGooHryOORL2jTPAKt2OLWFgRIYPr666etuDzkXlvmJXlznz9hBXCG/ZUdUqBA/RPSxjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042122; c=relaxed/simple;
	bh=9lEAGC49X5tMRFaIQhMrE3Y6Hsb1JN39G97R5BgU4Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTWBGMXfPm4DwlWdbHK6heFNB3LARfr12rRv683AdsQffN8gQMbXF5Qn/Sk5A+uhuXvGITV/NiBum5dshUVzK8U7WMEdfYC8AVRTFOeMB5Z/ZjAobAfWvqxdd5xY7g7ZWRc7F9P9wUqvq9wqPbjtoL5MVDXL176+6A7deangbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8HABbzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8HABbzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08393C2BCB0;
	Sun, 17 May 2026 18:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042122;
	bh=9lEAGC49X5tMRFaIQhMrE3Y6Hsb1JN39G97R5BgU4Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8HABbzC9UfnrILk4uLJbGPs6htsRxkq8XOmif4IOgDetnCdjQZVZhpQuPgxyiQOm
	 y6D8s+6RqZAAe+c3Vgea5BvFV4Ked5GhCuA3We8Mm+Q4g6mxDJIOx+Y4/0zUxFjwYJ
	 +8ut394Cs3kRIAtWprhC1fMkygmo/4JnWyATqS6cFUmo9jZNzeeM3RykCX98q1w6V9
	 RLtRzcLhG+GKab9cSYw8NTT3au9aKKjr6hftFt89syhPfCw0/Ua20KyeLB9B2BOd7O
	 wg/TSvi0rK+fm7+Tj3QcxyBX+vNgq9B5xVlCe3W1MGw5rHC4ZwUXKcsW9hbk1Rd5bQ
	 ptY2q7GmAsJ3A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum
Date: Sun, 17 May 2026 11:21:54 -0700
Message-ID: <20260517182154.4232-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516222951.8CEFCC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 22:29:51 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Unsigned integer overflow in DAMON's moving sum and access rate tracking for large intervals.
> --
> 
> commit 1d58ed9728ddbaf4579ec265e453a7b3a233285c
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> 
> mm/damon/core: fix nr_accesses_bp underflow in damon_moving_sum
> 
> Guard against unsigned integer underflow when nomvsum/len_window exceeds
> mvsum. When that subtraction wraps, the moving sum returns a near maximum
> value and corrupts nr_accesses_bp. If subtrahend > mvsum, return new_value.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3a8725e400c6b..9975f3d9ebfe9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3449,7 +3449,11 @@ int damon_set_region_system_rams_default(struct damon_target *t,
> >  static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
> >  		unsigned int len_window, unsigned int new_value)
> >  {
> 
> This isn't a bug introduced by this patch, but could the nomvsum argument
> passed here be silently overflowing?
> 
> Looking at damon_update_region_access_rate(), damon_moving_sum() is called
> with r->last_nr_accesses * 10000:
> 
> mm/damon/core.c:damon_update_region_access_rate() {
> 	...
> 	if (attrs->sample_interval)
> 		len_window = damon_max_nr_accesses(attrs);
> 	r->nr_accesses_bp = damon_moving_sum(r->nr_accesses_bp,
> 			r->last_nr_accesses * 10000, len_window,
> 			accessed ? 10000 : 0);
> 	...
> }
> 
> DAMON allows configuring aggr_interval / sample_interval up to the maximum
> 32-bit unsigned integer (for example, 10ms sampling and 1.5 hours
> aggregation).
> 
> This means len_window, which bounds last_nr_accesses, can exceed 429,496.
> 
> If this happens, won't the multiplication r->last_nr_accesses * 10000
> silently overflow the 32-bit unsigned int limit of 4,294,967,295?
> 
> If this overflows, the corrupted, wrapped-around value is passed as nomvsum,
> which would cause subtrahend to be artificially small.
> 
> Additionally, would this cause r->nr_accesses_bp (which accumulates mvsum)
> to also continuously wrap around 32-bit limits?
> 
> Could these silent integer overflows corrupt memory access tracking and lead
> to erroneous memory management decisions, like reclaiming hot memory?
> 
> A proper fix might require bounding len_window to 429,496 or using 64-bit
> integers.

That could happen when user sets aggr_interval > sample_interval * 429,496.  I
don't think that's a common setup, and the sane user would do some testing
before using such arbitrary setup.  So I'd suggest revisiting this when we have
enough time, or if a real world issue is reported.


Thanks,
SJ

[...]
