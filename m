Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59F329367
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434638; cv=none; b=f2gEFIQhm+4v/+/dg6vrO9AokhUeBL8Ylhc04DxE1wg5uEiq8tzra7+1lVzTGQcr9Vt76punALck6dQwwbwsjcO4QVfEYeZIZW7PWFJOADe1N7ytvP5DKrGSRwtUTKU6V5pXi+4J6u1ZhKczFK41yC+k9wVpHDX7gJo+uLVRI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434638; c=relaxed/simple;
	bh=b5ZVu0dVNWqabIGtgmxfDrrp737sKRVHpLOkh+n5xi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoj4y8aPdZ3ontEmkNqIrJekXaXQTW6YrojdmBrD84Yf0W3UH/SvU/HhrBlMGWA0xqnawZIxjzz/FSGTh9T9GJJXGua9Rvg+kBL/prDbGRZ5csblwaeYDBI4FP8e+kobdpOEVxUk0Vnol1TIxTQSMLIQILPsMBr0qofLbSL3mQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbpBGWPD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbpBGWPD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8AF1F000E9;
	Tue,  7 Jul 2026 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434637;
	bh=C+PSZZb2a1FGFxmggpwVYurpeUzapcQH//40wH9Ipsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TbpBGWPDqG7KT2yMQ3AAapZdQgnakDn9vpGD1BBnzrzcUEXJi7zKVo0amRPVK8Ia8
	 J3CA9TNqLKIZOlHmIknXtG/3B5VYshHtYRXZhrKPsttdOYloPPq7ypj3z6bQ6AHtkn
	 R+QHXucQ5HVUBK5inpsv8er0k6e7eWg7WFKlSsMFmJYoiOb/HRP/zEYbTma8/qlc7g
	 JiKtuDbhvkSTF8l8sgdhj+nnGA3MZ1DBHOKnXOMBFqtcXEK76AL6sX06sFeaotpNfq
	 FAWTLwHQni7DPJoAm5Wwzy3GgExHZ7IVyEq2TZpFCG7qUYNrNCffRFzvq8AwOpL3zc
	 qGmncvHPE/9ww==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 6/7] mm/damon/core: update probe hits for new parameter commit
Date: Tue,  7 Jul 2026 07:30:28 -0700
Message-ID: <20260707143030.91866-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707140639.449861F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 14:06:38 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Silent integer truncation when assigning scaled `probe_hits` from `unsigned int` to `unsigned char`.
> - [Low] The KUnit test update adds the required `ctx` parameter but entirely fails to test the new `probe_hits` logic.
> --
> 
> --- Patch [6]: [RFC PATCH v1.1 6/7] mm/damon/core: update probe hits for new parameter commit ---
> commit 4d31f2a415d3352c6ff9b689ba6991c3606580b1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: update probe hits for new parameter commit
> 
> Users can update DAMON parameters at runtime. If the samples and/or
> aggregation intervals are updated in this way, monitoring results depending on
> the intervals should also be updated for a more accurate snapshot. This commit
> updates probe_hits to reflect these changes.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index cda318806b65b..9a3ff0fe55a61 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
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
> [Severity: Medium]
> Does this code silently truncate the scaled sample counts?
> 
> The function damon_nr_samples_for_new_attrs() computes and returns an
> unsigned int. However, r->last_probe_hits and r->probe_hits are arrays of
> unsigned char.
> 
> If a privileged user updates DAMON parameters via sysfs such that the new
> aggr_interval / sample_interval ratio scales the existing hits beyond 255, it
> will silently truncate (modulo 256), losing the accuracy of the metric. 
> 
> Should the result be explicitly clamped via min_t(), or the underlying type
> widened?

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
> [ ... ]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 9e631b19b184a..b4feef1a460f4 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -591,32 +591,39 @@ static void damon_test_update_monitoring_result(struct kunit *test)
> >  		.sample_interval = 10, .aggr_interval = 1000,};
> >  	struct damon_attrs new_attrs;
> >  	struct damon_region *r = damon_new_region(3, 7);
> > +	struct damon_ctx *ctx;
> >  
> >  	if (!r)
> >  		kunit_skip(test, "region alloc fail");
> > +	ctx = damon_new_ctx();
> > +	if (!ctx) {
> > +		damon_free_region(r);
> > +		kunit_skip(test, "ctx alloc fail");
> > +	}
> 
> [Severity: Low]
> Is the new probe_hits logic effectively dead code during this test?
> 
> The test allocates a new damon_ctx via damon_new_ctx(), but it doesn't add
> any mock probes to it, nor does it initialize any probe_hits on the test
> region. 
> 
> As a result, the new damon_for_each_probe() loop in
> damon_update_probe_hits() exits immediately without testing the scaling logic.

That's the intention.  This change is only for making the existing test not
broken.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707135038.90068-1-sj@kernel.org?part=6


Thanks,
SJ
