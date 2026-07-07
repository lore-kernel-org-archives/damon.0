Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921715E8B
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382722; cv=none; b=dBnlQc0AvOCaXbFGwYVWqX2KEnEhpekZZVQj5B/kKU/EQs7ihsoA6oQcJ4Bs2JzPRuD5PlF+M7BciOJ0Q0821+CAM2hL2cpbiUmOOWtUm9le8AFYb5WLWegoBJShPWOREwciqt55m0ukxdGHxH67PHgDNF4jvgSBvZLZOLu4a5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382722; c=relaxed/simple;
	bh=+dNfGSnw2kU3ic/1elfTCTuynJ0nVWx54p6/WR+7ovg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXwj3+MecOY/wvtxhvzuslQ9muWDVVC3X0IDyRaPiVSjuZuMcdZv+NCcDIwpefh1CzV3584/0/43HE5nkNloGS/4OZSGscutoZHKkhD5EUOXsWzIy4eY+xIidD7vlXRfqr4MZnuXnQf4sx/RyIOvtaFFkbq5Dd/qtr78AwN7VYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myaCiaXM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myaCiaXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FD61F000E9;
	Tue,  7 Jul 2026 00:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382720;
	bh=q9//8FVH9TbmCDzVLLJU+sOX52kxSQ66Wcr9GfjlY7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=myaCiaXMqh6n2zb7kgruzE/GKVMO4dQ/k7PJWjLxdZNbhyKMku37pK6GPuA1SAx2+
	 V04KTkzpnW+Y+mCAPXNxnrITH7KkNxb6CHCVkAeOROMMAL3/Bsapt0DKeCGjprSrfm
	 1MQo7U/szYPXRYYImh4XOXcKHdGtbn+FtEmH7yn8kRv289n36TrzmLNGvSsJTSfPTR
	 WasSfHL5+AMLqY1PMTWSj11BMu4nKLT0zvREGM8KvvSDX1gn/ALFufblPdyKuAUh/l
	 GdND7uJNlfcqAWPvuFcuRMVzr5+9RF7yPlUyRn1QxBHfU20cDckZDo9eZAQvQ/Resr
	 ROiAaMdqcjOtw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 12/16] mm/damon/core: implement damon_has_probe_weight()
Date: Mon,  6 Jul 2026 17:05:09 -0700
Message-ID: <20260707000511.97649-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706151652.866B51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 06 Jul 2026 15:16:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Setting probe weights on a DAMON context whose operations do not support `apply_probes` (e.g., `vaddr`) silently disables all monitoring.
> 
> Pre-existing issues:
> - [High] The `probe_hits` array in `struct damon_region` uses `unsigned char` counters which wrap around at 256, corrupting monitoring data when the number of samples per aggregation interval exceeds 255.
> --
> 
> commit 3891f362834bef45987ebcee1cdb0abcd9df6ea2
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_has_probe_weight()
> 
> DAMON monitors only data attributes when probe weights are set.
> However, the function for detecting it is intentionally returning false
> always.  The intention was to make changes for complete support of the
> mode in a safe and incremental way.  Now all the building blocks are
> made.  Complete the mode detection function so that the mode can really
> start working.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index fa78d8d592aa3..6e5a029989a0c 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> >  
> >  static bool damon_has_probe_weights(struct damon_ctx *c)
> >  {
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_probe(p, c) {
> > +		if (p->weight)
> > +			return true;
> 
> [Severity: High]
> Does returning true here silently disable monitoring if the context operations
> do not support probes (e.g., vaddr)?
> 
> In kdamond_fn(), if this returns true, access_check_disabled bypasses standard
> checks. However, if ctx->ops.apply_probes is NULL, the probes are skipped:
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
> 		bool access_check_disabled = damon_has_probe_weights(ctx);
>     ...
> 		if (!access_check_disabled && ctx->ops.prepare_access_checks)
> 			ctx->ops.prepare_access_checks(ctx);
>     ...
> 		if (ctx->ops.apply_probes) {
>     ...
> }
> 
> Would it be better to ensure ctx->ops.apply_probes is also implemented before
> returning true?

I will fix this in the next revision.

> 
> [Severity: High]
> This is a pre-existing issue, but since this patch enables probe weights,
> can the 8-bit probe_hits counters overflow if the number of samples per
> aggregation interval exceeds 255?
> 
> Looking at struct damon_region in include/linux/damon.h, probe_hits is
> declared as an unsigned char array:
> 
> include/linux/damon.h:struct damon_region {
>     ...
> 	unsigned char probe_hits[DAMON_MAX_PROBES];
>     ...
> }
> 
> In damon_pa_apply_probes(), it is incremented during every sample interval
> without checking for overflow:
> 
> mm/damon/paddr.c:damon_pa_apply_probes() {
>     ...
> 			damon_for_each_probe(p, ctx) {
> 				if (damon_pa_filter_pass(pa, folio, p))
> 					r->probe_hits[i]++;
>     ...
> }
> 
> If a user configures an aggregation interval that is > 255 times the sample
> interval, could highly-hit regions wrap around to 0 and be falsely identified
> as cold memory?

Known low priority issue.  No blocker.

> 
> > +	}
> >  	return false;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260706141912.88445-1-sj@kernel.org?part=12


Thanks,
SJ

[...]
