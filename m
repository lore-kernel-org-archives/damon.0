Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154761FFE
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015780; cv=none; b=piBfkveVzsEgTqCZOdxb5wkWHMASYN2hqtytIb0rLDvnCMmxwJpmK4rAqgUIIUR65NmqMwyCEfiWM9cR3MbyHLVPye6bHxEIVsg0QU3LPqL0UK9VjTCaGz9wj9s9/A5cLI2Vlk4VJ6e83easA4/Gdrl/+Df1o3lmYzTxvvXJ9mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015780; c=relaxed/simple;
	bh=VQBnaY0WLWcqwM8S3VHq58q4ED0xIgmMk9vFt8OQa9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYIeul5J1YZXvNaSO4gW4BHF+0ySgbeBuzUsTo3fRRA+Zbpl2GSBUXH5SY9agAkgkNxvEB9T7IX7mUa+QRiwTsDtxOrG/Hb6TzBkzshGuEOzaBFPJ/dVFAwEwPrV2Fy6NNWwJFR8TY6uaUxP98Qu3l2ZG/l8OGl5LRv7rSmBDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEpiEEN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEpiEEN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF82B1F00893;
	Tue,  9 Jun 2026 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015779;
	bh=gD4/8xyEVuWUni2ulMEGs9rfa4mpEf8J7ghUlXct0Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEpiEEN/MG1dVdaS/4Loyp433/5uTP1yFk+WqDeiyFQebJMJFTKEmMw7lNj83dV8C
	 7xTRKcpy9Rncycx0PdYHSUHuckxhKz2wqWQicFc+m3G4XZwFx74zcBP6WEen/zUafn
	 ConEAy/mM5qabH1njBkFf5ev5mm4w2PtEJv0iAhzc0USh+e/hyTUwrthw0mGQZf5xr
	 vNN3O6GjQZTCjBku6e+zeRHnYe5KODVkNGWUND4/ECZmKw9lP8BaPi4XQ4OTwVY/E2
	 2PW2JkkTnMYd/xMwSYCmgBLlSvZ7R3gIGqxnWNweG39fFWkq6sYeIGerZ2YQa97gRe
	 j2ViUSVMeGytQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Zenghui Yu" <yuzenghui@huawei.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2] samples/damon/mtier: fail early if address range parameters are invalid
Date: Tue,  9 Jun 2026 07:36:15 -0700
Message-ID: <20260609143615.69115-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260609065829.6CBAC1F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 06:58:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak of `damon_ctx` structures and potential orphaned `kdamond` threads when `damon_start()` fails.
> - [High] Incomplete fix allowing integer overflow and resulting in `WARN_ONCE()` and massive region size.
> --
> 
> commit 567b4e8a4b1811419a6203e400b62d93a47bfe84
> Author: Zenghui Yu <yuzenghui@huawei.com>
> 
> samples/damon/mtier: fail early if address range parameters are invalid
> 
> This commit adds an early check in damon_sample_mtier_build_ctx() to ensure
> the address range parameters are valid. This is intended to prevent a
> WARN_ONCE() that occurs when the node address bounds are not properly
> initialized before the module is enabled.
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index eb1143de8df17..3785b0c7ffb17 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  		addr.end = promote ? node1_end_addr : node0_end_addr;
> >  	}
> >  
> > +	if (addr.start >= addr.end)
> > +		goto free_out;
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this incomplete fix still
> allow an integer overflow?
> 
> If addr.end is set to ULONG_MAX via sysfs and addr.start is a valid address,
> this check passes. Later, damon_set_regions() calls ALIGN():
> 
> mm/damon/core.c:damon_set_regions() {
>     ...
>     ranges[i].end = ALIGN(ranges[i].end, min_region_sz);
>     ...
> }
> 
> The ALIGN macro will add min_region_sz - 1 to ULONG_MAX, causing an integer
> overflow that wraps the value to 0. This results in calling
> damon_new_region(start, 0), which triggers the exact WARN_ONCE() this
> patch intended to fix.

First of all, not a blocker of this patch.  I also don't think this is what
normaal and real users would really do with a good intention, or easy to
mistakenly set.  I don't think this needs a fix for now.  We could revisit this
if it turns out this causes a real (not test-purpose) issue.

> 
> Additionally, could this cause damon_sz_region() to return a massive value,
> breaking the logic in damon_apply_min_nr_regions() and causing excessive
> allocations?

DAMON manges the monitoring target address rannge with dynamic-sized regions.
And the maximum number of regions can be set by users.  So I don't think this
kind of issue can happen.

> 
> >  	range.start = addr.start;
> >  	range.end = addr.end;
> 
> [Severity: High]
> This is a pre-existing issue, but does this code leak the context structures
> and orphan the threads if damon_start() fails?
> 
> samples/damon/mtier.c:damon_sample_mtier_start() {
>     ...
> 	ctxs[1] = ctx;
> 	return damon_start(ctxs, 2, true);
> }
> 
> If damon_start() fails (e.g., returning -EBUSY or -ENOMEM), it returns the
> error directly without cleaning up the dynamically allocated contexts in
> ctxs[0] and ctxs[1].
> 
> The caller damon_sample_mtier_enable_store() sets enabled = false on error.
> Subsequent attempts to enable the module will allocate new contexts and
> overwrite the ctxs array, permanently leaking the previous contexts.
> 
> If damon_start() successfully starts the first context but fails on the
> second, does the first context's kdamond thread remain running as an
> orphaned thread?

Not a blocker of this patch.  I'm separately working [1] on this.

[1] https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org


Thanks,
SJ

[...]
