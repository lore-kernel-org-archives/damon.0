Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BE40D58A
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793699; cv=none; b=pIG4/nr0mjsZjgT7XrUEpWuv4WJVmtcMykC02buEKQOza83z1qlnqQrz6MNFegZYV8ZKM6KMyzD8cdxqM4Wr3jYiAR2R5CfrLTX4UjS7+sNDfXYGCiwkdDQ9DI7503T/GUjvYsP1mt0EYdlwGWN1B1bwVrFNa6om3vVBkpxz8Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793699; c=relaxed/simple;
	bh=jVewIjSNxnrPU1WKtXqD0oXDOu++SV1gv7xBbDy5IVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8VhM8hgsLl2qLYyEG3aM38ZfnbVRYafSrbSEbffxPX7ee7hB4lic3WP5X5eFmiuUDi744gbiOS5DFGaw9pJ4uYA1WphhAzMpo98qSxoIkBGhU0p+ZtZB8tgPthQkoWE04vvW7+4UJqqi4tM2cPiAHF/azQPaQsKS6oSxtDK+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrSC6OG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrSC6OG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DF11F000E9;
	Tue, 30 Jun 2026 04:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793698;
	bh=CgeMa80LpD3plt85TLlC/rltfSkL4ZyqoxzR8E74DLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrSC6OG3hnQxEaXCq5Y4cWlSGdcL9Xm5KlxEZWLkxe4Yx4djW6tTcz9uXtwzuNZ48
	 nwv5a8O+QullWprmV4QG3Fr8iI5h/aoEM9EHBlLxgB9y/dkP0NZ+PFdvszR+lUxFwF
	 LObDw94X1w2Bh/jZrbC4jYVn30zgB3q5y34KgBggb/KevbL1/OPTYLFz3hujm++TjH
	 k1hHXfI/vxx9JSTMOenxJLfbtF0FnKJXHFS6cvKYiNMquzBJEBhs3wCoWFUcraclp3
	 LnX5rUuQox/O7tbJMzmP0JKtNqF3SNQDWftgWSs0uWtra4msZxuLOG+XGN6DqTK5zc
	 TI1QrTfmdV6hQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 01/18] mm/damon/core: introduce damon_nr_accesses_mvsum()
Date: Mon, 29 Jun 2026 21:28:13 -0700
Message-ID: <20260630042814.151495-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630041935.2076E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:19:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Calculation of `left_window_bp` and moving sums in `damon_nr_accesses_mvsum()` and `damon_mvsum()` suffers from an integer overflow on 32-bit architectures when `window_len > 429,496`.
> --
> 
> commit 55e8315faa6caec232a35b71d630c4dd8cbb568f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_nr_accesses_mvsum()
> 
> Introduce a new DAMON core function, damon_nr_accesses_mvsum(). It returns a
> pseudo moving sum value of a given region's nr_accesses for the last
> aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 027250e43c66f..fe4c470726d0b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -208,6 +208,68 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> >  	return NULL;
> >  }
> >  
> > +/*
> > + * damon_mvsum() - Returns pseudo moving sum value for a time window.
> 
> [ ... ]
> 
> > +static unsigned long damon_mvsum(unsigned long current_nr,
> > +		unsigned long last_nr, unsigned long left_window_bp)
> > +{
> > +	return current_nr + mult_frac(last_nr, left_window_bp, 10000);
> 
> [Severity: Medium]
> Could this mult_frac() calculation suffer from an integer overflow on 32-bit
> architectures?
> 
> If a user configures DAMON with a large aggr_interval and a small
> sample_interval such that window_len exceeds 429,496, last_nr could be
> equally large. Since unsigned long is 32 bits on those systems, can the
> internal multiplication inside mult_frac() silently overflow and result in
> incorrect moving sums?

Known low priority issue.  Not a blocker for this patch.

> 
> > +}
> > +
> > +/**
> > + * damon_nr_accesses_mvsum() - Returns moving sum access frequency score.
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
> > +	if (time_after_eq(ctx->passed_sample_intervals,
> > +				ctx->next_aggregation_sis))
> > +		left_window = 0;
> > +	else
> > +		left_window = ctx->next_aggregation_sis -
> > +			ctx->passed_sample_intervals;
> > +	left_window_bp = mult_frac(left_window, 10000, window_len);
> 
> [Severity: Medium]
> Does this calculation also overflow on 32-bit systems?
> 
> The mult_frac() macro calculates (left_window % window_len) * 10000. If
> left_window is greater than 429,496, multiplying by 10000 will exceed the
> maximum 32-bit unsigned long limit (4,294,967,295), causing a truncated
> left_window_bp result.
> 
> Should these calculations use 64-bit arithmetic, such as div64_ul(), to
> safely support large intervals on 32-bit systems?

Known low priority issue.  Not a blocker for this patch.


Thanks,
SJ

[...]
