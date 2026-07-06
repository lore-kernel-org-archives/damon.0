Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E62236E0
	for <damon@lists.linux.dev>; Mon,  6 Jul 2026 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381613; cv=none; b=gqNX/3shn5EkLQnwBGT79gTi7nMzhRMRTQqJycj+6rCBQqDL+AjWwfJ5EF15okrAs60qqdZj7OFwkHnZ9iIQ2YuBDsdty98JSFJ1BRACseJexFrQxTsBYX84/u53tyUh/zDjzCL+ZqYDmADh50dU+sHGISvhen9cv9NZnTBUpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381613; c=relaxed/simple;
	bh=kxnr7K/UxpVckt/Wue8nkIdhQsnMs4OO/+EHb9cIuog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0b98O+37MQxh5dXK6yVwiaXZSFFwiOYQJWSqlY875rtfhoiXn74tYXxaGrNVnZpVTrs4XcFvXQx8+nLVGVk1LyUgvbBSVp+iw+P/YdFBIQhQ4L97F1O864u7W3C6WNtuFA3GavuK0XRq6D7SZd3jsyACboK/RkMR1BtElDsbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvUWy+c8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvUWy+c8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279171F000E9;
	Mon,  6 Jul 2026 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381612;
	bh=5o5me3Rr/77cPpWPaGgFoYLtqnlqb9G50tcFFuNomxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvUWy+c8WHARdkWvVcyyqtIDD1+7Vfj7mHuiyD2HZ09FKXQwFbDEHEsFk+xsvVGOE
	 nN7RwZBAtNNL4KBvbZuDyIfa9CtjKrO8LiB91iOO5EfvkrARS8vTTfNNKOOEy/209y
	 Smiqy+cFh901Dncin4k7dUY4QJeU0uQfAUJ2bKGUYMktpIPb5rO8u82zHXUn9HskpA
	 1kPEtA8nslP3j2zY+VoaIFZZmWKyiPIA4tzNd88mP7BMFCQyEB40PZyXP1NjjsNXjD
	 YVS6eE38IzJwy2QzIXAeWe9q5w2CjlfqS96tJLSMl9NdI4m4hRkLEyMWfB+2hTV935
	 TFaH5ty+2dviQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 05/16] mm/damon/core: implement damon_probe_hits_wsum()
Date: Mon,  6 Jul 2026 16:46:43 -0700
Message-ID: <20260706234645.96802-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706144135.1573D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 14:41:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] The calculation of the weighted sum in `damon_probe_hits_wsum()` is vulnerable to integer overflow, resulting in a silent wrap-around.
> - [Low] Misspelled words in the kernel-doc comment for `damon_probe_hits_wsum`.
> 
> Pre-existing issues:
> - [High] `r->probe_hits[i]` is an 8-bit `unsigned char` but serves as a sample counter across an aggregation interval, making it highly susceptible to wrap-around.
> --
> 
> commit 627b12cd883dbd832e93cc6b4f4e3373c791b6d0
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_probe_hits_wsum()
> 
> This commit implements damon_probe_hits_wsum() to calculate the weighted
> sum of probe hits for a DAMON region. This weighted sum is intended to be
> used by users as well as DAMON internal logic like region merging.
> 
> [ ... ]
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index dbd1f86a0832f..42f27849af722 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -390,6 +390,30 @@ static bool damon_is_last_region(struct damon_region *r,
> >  	return list_is_last(&r->list, &t->regions_list);
> >  }
> >  
> > +/**
> > + * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
> > + * @r:		region to get the weigted sum of.
> > + * @last:	if the request is for last-window agggregated probe hits.
> 
> [Severity: Low]
> This isn't a bug, but there are spelling errors in this kernel-doc block.
> 
> "weigted" should be "weighted" and "agggregated" should be "aggregated".

Good finding, I will fix these in the next spin.

> 
> > + * @ctx:	context of &r.
> > + *
> > + * Return: the weighted sum of probe hits of the region.
> > + */
> > +unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
> > +		struct damon_ctx *ctx)
> > +{
> > +	struct damon_probe *probe;
> > +	unsigned int sum = 0;
> > +	int i = 0;
> > +
> > +	damon_for_each_probe(probe, ctx) {
> > +		if (last)
> > +			sum += r->last_probe_hits[i++] * probe->weight;
> > +		else
> > +			sum += r->probe_hits[i++] * probe->weight;
> 
> [Severity: High]
> Can the accumulation into sum silently overflow?
> 
> If a large probe weight is configured via sysfs (e.g., > 16,843,009), the
> multiplication of this 32-bit unsigned int weight by r->probe_hits[i] could
> wrap around when accumulated into sum.
> 
> This might corrupt the DAMON region merge and split logic that relies on this
> score.

Yes, it can.  But it causes only poor monitoring results for wrong user setup.
Maybe we can improve it, but not necessarily right now.  No blocker.

> 
> [Severity: High]
> This is a pre-existing issue, but can r->probe_hits[i] wrap around during long
> aggregation intervals?
> 
> The probe_hits array is defined as an 8-bit unsigned char. If the user
> configures aggr_interval and sample_interval such that their ratio exceeds 255
> (for example, 1s aggregation and 1ms sample), the counter will silently wrap
> around to 0 without any bounds checking.
> 
> This could severely degrade the accuracy of DAMON's monitoring, and is
> exacerbated here by relying on the potentially corrupted counter for the new
> weighted sum logic.

Known low priority issue.  No blocker.

> 
> > +	}
> > +	return sum;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=5

Thanks,
SJ
