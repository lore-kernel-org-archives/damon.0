Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586B378D72
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400979; cv=none; b=BpX95XE9VvO3t1P6IPNJO5j7YL9xXjzg6y/XP7Av3YwOL8oqhE1szqntsc+YPWDRgyZFBt3+jP1NAmET4+C7lhQNGZdBUwhbyVPYrlAHVWyWQdFVrkIiOQu020T0G476grC0C0nYFw2n0qawdhzk9+m5OpuNNkU27b++SRAHOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400979; c=relaxed/simple;
	bh=f8AI/j7guKS+7C5PT1X0qzRrYa3j6cRMW4dHDqGmJB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDKt7CDBFmtHYkfovOQKSGaU4K/MD98nak03QWU/3HtQSUCha0mZRxNG5QYQ/bnp82gYtCVKoA3CeBxdVfkKAFHNmPOjagrQPAfeA8XbR/S+Jsh/4zijBxZf89IiC0Jwn69cN5JcXDrWvfiIE7KQbE9DN9q9Xn8ibzd8u8Hq5H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW056C82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW056C82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D301F000E9;
	Tue,  7 Jul 2026 05:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783400977;
	bh=/gzqAyBCqys0eXxRQpaNB4TS/qgU6oNwfvD/PKQjhCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FW056C82l1eP7KUwbFNzq6Jb5nshmKDp66GdmXzyMhM8qNrw0bfDjeIxU95tssqfP
	 Dj9AL78Qc5Zms07s1pKwrYKnsXmePmo9ZLmjLuZWsNAzMADJ5zWhOfkS/TTX/kCaT+
	 i++gSHpPAXCWILD/CGMSAIKbCNwG+HY8GwSLe327a2v3vl8Plt0jcI0F0/93JGpsq2
	 tj3uzgB+d0/1mRgobjLQQbMIHTfndVfNAW0cfrIW5zMCKFw+xIxdsEfZnW1u0rxhdF
	 VZSJxlPkL5YYgj+5O7ylBmwSts48dPDmxKVlD5lWO5mzdiEvIlEnbjrRgwCUxMJlir
	 rMaUeTfsHOe3Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/6] mm/damon/core: update probe hits for new parameter commit
Date: Mon,  6 Jul 2026 22:09:29 -0700
Message-ID: <20260707050930.102693-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707045152.460C01F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 04:51:51 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit arithmetic overflow in interval scaling functions corrupts core metrics.
> --
> 
> --- Patch [5]: [RFC PATCH 5/6] mm/damon/core: update probe hits for new parameter commit ---
> commit 7e26d9c01ec3d36d75d519b11f48ef36f78ec868
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: update probe hits for new parameter commit
> 
> Users can update DAMON parameters at runtime. If the samples and/or
> aggregation intervals are updated, monitoring results depending on the
> intervals should also be updated. This commit ensures probe_hits are
> properly updated to reflect new intervals, similar to age and nr_accesses.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index cda318806b65b..9a3ff0fe55a61 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -898,10 +898,32 @@ static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_accesses,
> >  			new_attrs);
> >  }
> >  
> > +static void damon_update_probe_hits(struct damon_region *r,
> > +		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> > +		bool aggregating, struct damon_ctx *ctx)
> > +{
> > +	struct damon_probe *p;
> > +	int i = 0;
> > +
> > +	damon_for_each_probe(p, ctx) {
> > +		r->last_probe_hits[i] = damon_nr_samples_for_new_attrs(
> > +				r->last_probe_hits[i], old_attrs, new_attrs);
> 
> [Severity: High]
> This is a pre-existing issue, but can the scaling logic called here
> overflow and corrupt the core metrics?
> 
> Looking at the underlying functions called by
> damon_nr_samples_for_new_attrs():
> 
> mm/damon/core.c:damon_sample_bp_to_count() {
>     return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> }
> 
> and
> 
> mm/damon/core.c:damon_sample_count_to_bp() {
>     return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> }
> 
> If a user configures a large aggregation to sampling interval ratio
> (e.g., 1 second aggregation and 1 microsecond sampling), the ratio can
> exceed 429K. 
> 
> When damon_sample_count_to_bp() scales a count of 500,000, the internal
> multiplication in mult_frac() (count * 10000) evaluates to 5,000,000,000,
> which overflows the 32-bit unsigned integer maximum and yields an incorrect
> value.
> 
> Similarly, damon_sample_bp_to_count() performs 32-bit multiplication
> which can overflow if bp * samples exceeds the 32-bit limit.
> 
> Should these scaling calculations cast to 64-bit to prevent silent
> wrap-around and wildly inaccurate statistics?

Known low priority issue.

> 
> > +		if (!aggregating)
> > +			r->probe_hits[i] = damon_nr_samples_for_new_attrs(
> > +					r->probe_hits[i], old_attrs,
> > +					new_attrs);
> > +		else
> > +			r->probe_hits[i] = 0;
> > +		i++;
> > +	}
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707043828.97900-1-sj@kernel.org?part=5


Thanks,
SJ

[...]
