Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C5366823
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794100; cv=none; b=i59MIKIIa+jUHEn71ESJiQ0TenGbOXhqOqNbm4YMg/P/t/E2WkfjWIKlcUYnfMd5CsTkwi1Yuxuh/cODay0HsbqavqfQDUJZPX/BAgameR4lzBAm1CSO51ylP4DBStK8binwc5jCtwdUNw8RJNBlomqwmlJ6bt5+Na9E1u9AxuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794100; c=relaxed/simple;
	bh=Fb8Gbnv9Ax/t625x9btt5n7/1YZV5KHXml+cvZw4yvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqJzkUxa48RC63xQjaGkYJU70Sb4nTD8e/hmoD+u8G5J1ukjpm3TlIkP6uzwrZOQCnVVBVdk3OWVugRt01GdNU4tiqR17Y4fnJudxotrHOiZpP/kJn/3P27mZcI6lsim/0HtNfY9zo7wP5IwNXrMvSfN0Gtmcl2Wi3A7Q43sK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+0trvcJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+0trvcJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2C51F000E9;
	Tue, 30 Jun 2026 04:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782794098;
	bh=Fgep95wFuMgHBre1Qic4CZ5EZAlvwvICkrFf4uXcmNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+0trvcJkzv+ERgQ9at/Tkk2kEbnonL5tdPFGbiTiVW1e7uzzcuHaU59jSqPdVUOL
	 TY5qjplsnnTg2XZfhGV/fP/SIYAEeREkd9Za5WtynJfeTQrnr+4ERSH41jP6l3xJ/f
	 GTACYNxukSRLVs/unXJp31DvKlgjMiLtoeVWkcqImPy5lc1rn1WNTs/LZB4jer6Zwt
	 IJ96l5NlR4rAmt6SC13jsE0R/K7cDADN68zfjvm5P28Lx50EprAqzFKhxEjre96Ew4
	 /xEFTyhsOEPVYvg1jcm0gtlm+DUi9qZXZueL1yyU+ptfuBNVPylGHkJfOLME2wH4jZ
	 6IGdrYw5HqMaQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 05/18] mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
Date: Mon, 29 Jun 2026 21:34:50 -0700
Message-ID: <20260630043451.151900-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630042540.7F8461F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:25:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] 32-bit integer overflow in `damon_nr_accesses_mvsum()` when calculating `left_window_bp` via `mult_frac()`.
> --
> 
> commit 73c4d41e08fa85ce70e1cc04b1dee325a553e44e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: use damon_nr_accesses_mvsum() in __damos_valid_target()
> 
> This commit replaces the direct read of nr_accesses_bp with a call to
> damon_nr_accesses_mvsum() in __damos_valid_target(). This calculates the
> access score dynamically to be more tolerant to errors.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index df79f4d10bdc3..50939c3359bf7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2126,10 +2126,11 @@ static noinline_for_stack void kdamond_tune_intervals(struct damon_ctx *c)
> >  	damon_set_attrs(c, &new_attrs);
> >  }
> >  
> > -static bool __damos_valid_target(struct damon_region *r, struct damos *s)
> > +static bool __damos_valid_target(struct damon_region *r, struct damos *s,
> > +		struct damon_ctx *c)
> >  {
> >  	unsigned long sz;
> > -	unsigned int nr_accesses = r->nr_accesses_bp / 10000;
> > +	unsigned int nr_accesses = damon_nr_accesses_mvsum(r, c);
> 
> [Severity: Medium]
> Does wiring up damon_nr_accesses_mvsum() to the active DAMOS region filtering
> path expose a 32-bit integer overflow?
> 
> Inside damon_nr_accesses_mvsum(), the calculation of left_window_bp uses
> the mult_frac() macro:
> 
> left_window_bp = mult_frac(left_window, 10000, window_len);
> 
> If a user or auto-tuning configures an aggr_interval / sample_interval ratio
> greater than ~429,496 (for example, an aggr_interval of 5,000,000 us and a
> sample_interval of 10 us), the intermediate multiplication inside mult_frac()
> can exceed the maximum 32-bit unsigned long value on 32-bit architectures:
> 
> (left_window % window_len) * 10000
> 
> This truncation would result in a severely deflated left_window_bp, leading
> to incorrect moving sum access scores. 
> 
> Could this cause DAMOS schemes to evaluate targets improperly, leading to 
> sub-optimal memory reclaim or migration decisions?

Known low priority issue.  Not a blocker for this patch.


Thanks,
SJ

[...]
