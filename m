Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6463F3DFC6B
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793818; cv=none; b=MKJRaGP32EyokOHNuNRdm70O1Lz1N+//47M3P6u0oRRESAsGhxVsPdr0ov+MElaR5/oyOR1X5LM+Y8Y4A0dZduzfhTaaXkIA+QJ5JkClYyJ4+vs5trzWToM7xOSruxppv8HTFGNx8B7fdSIVDjULVR1U7bU4fZXgOnPGILXeGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793818; c=relaxed/simple;
	bh=rbYegyFGuWIr0WFwR46lKs4cp4txXhMoWPzhqtge4iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok8yPquYBwCytZTTMcV6vQBw/NZUvR2WzYxbHbTQtm6KmPApMYWWEYQCo2MTRgQ8BcPEuyvBUDszJ4tH61DtultZmnGhNHcN0C2pHW4KnKZCqItw66DrtKuyR/2VFKTMjsGI0HxVuWiufS3Eo5iT/NLUejrCQvDX31N/nq79sIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW1H3qoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW1H3qoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2493E1F000E9;
	Tue, 30 Jun 2026 04:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782793817;
	bh=3+cR1hmqjHrM0YGXJtltXU0ZMIXcW6MvYvsiwXliYBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OW1H3qoCXGCqhMhiQoIIHVUYH/x9g5DaaeH8EeSM1iS1MMsx2OTeYNC0FF6O97l4U
	 nLGkaAq8xt6verX1o/CNL79o6wfoNeHBH+c1Reu5xiN2feL+5+U9pZv0aeCH9RUogS
	 rXJKIl7bO6DQk3bl20P2RKmxmu69QgadZSh/SMySj+DTrclQmntllcMu7/xWrhYXaK
	 +8n1eRD0BnVsChTwi86t1OgePtg6Vq5X9+uOKn8aPv54soq/7w6dI9fnpbWFyp/mcI
	 4fwGOGg1akwt/Xw4c6cGMmPTNI/8v/r1dReQAOyd501fb/vEbM0GPZoYgXLO3VTVMM
	 FT0HLDDyz7Fmg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 03/18] mm/damon/core: always update ->last_nr_accesses for intervals change
Date: Mon, 29 Jun 2026 21:30:09 -0700
Message-ID: <20260630043010.151633-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630042143.7C5261F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:21:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] A 32-bit unsigned integer overflow in `mult_frac()` silently corrupts region access basis point conversions when the aggregation interval is significantly larger than the sample interval.
> --
> 
> commit f786cbe1a79f2e1958843b60ee1875084aebedbc
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: always update ->last_nr_accesses for intervals change
> 
> Each iteration of kdamond_fn() caches the next aggregation time. This patch
> ensures last_nr_accesses is always updated to prevent returning wrong values
> when damon_nr_accesses_mvsum() is called during an intervals change.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -871,6 +871,8 @@ static void damon_update_monitoring_result(struct damon_region *r,
> >  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
> >  		bool aggregating)
> >  {
> > +	r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
> > +			r->last_nr_accesses, old_attrs, new_attrs);
> 
> [Severity: High]
> This is a pre-existing issue, but does the underlying access basis point
> conversion silently overflow on 32-bit values?
> 
> When this calls damon_nr_accesses_for_new_attrs(), it relies on
> damon_nr_accesses_to_accesses_bp() to calculate the scaling:
> 
> mm/damon/core.c:damon_nr_accesses_to_accesses_bp() {
>     return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> }
> 
> Because mult_frac() evaluates the multiplication using the type of
> nr_accesses (a 32-bit unsigned int), multiplying by 10000 will silently wrap
> around if nr_accesses exceeds ~429,496. This could happen if a large ratio
> between the aggregation interval and sample interval is configured via sysfs,
> causing hot memory regions to be incorrectly evaluated as cold.
> 
> A similar issue appears to exist in damon_nr_accesses_mvsum() where
> left_window (a 32-bit unsigned long on 32-bit architectures) is multiplied
> by 10000 inside mult_frac():
> 
> mm/damon/core.c:damon_nr_accesses_mvsum() {
>     ...
>     left_window_bp = mult_frac(left_window, 10000, window_len);
>     ...
> }
> 
> Could these operands be safely cast to a larger type to prevent the overflow
> before passing them to mult_frac()?

Known low priority issue.  No blocker for this patch.


Thanks,
SJ

[...]
