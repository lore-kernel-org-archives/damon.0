Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FF1A6823
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400477; cv=none; b=LXEzEIRA3a0gqa3Q4zRVj7TVO1SGhpqvbEXiKRtVl8iWjCywFg4dkO3qzBBC63DJKP2Rdte+Ul2FeU6PRjzZpJMyGG9KZTmn7AZaCc/1V9FWrLLuXpMNzcDiETOuEfUBRR84RMNUlzoXpG0tIjA8nqPePgbEXSdti3vfWINDOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400477; c=relaxed/simple;
	bh=DJRMG7DO6p/HPE2RO/qkKLUl6+Fv02IH6NTcT3x60bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvxrueuydJS4RqSkrwLi8V5ILY0gGEEAU0bzl1FdzW9miY4V+nmscTZgHMgOXcm7QFt93l93t/iCta/+qsC8YcJAW23iOzqs5FP/iRLVa0JMzUtGkcP8tSXqSOUAD7UKmiPIO7r2LagqHOESmaoeD276BQM6ktEPJVQBSkuiL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmE7c8RX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmE7c8RX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4501F000E9;
	Tue,  7 Jul 2026 05:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783400475;
	bh=s1CcGOLZpzoeAU/8VhqrfoRbQFXNHrkypLOt2TIlI/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmE7c8RXuaKSTfAzxTqs7FO5LlFDXmp+8+iw5ffMDXVvYBz4hqeFDh4ojBvP2JQ6F
	 3BeuyS1HEs/fo3BiQXmBtI3OdBpmMDWLkktgxiTYVa7O7YfsNw0qjaEPewMM2FKt6u
	 vI0yEQ6G6Ygz+QiKmgO/1vQ0lL2B/auFSy8GbQ17T6Q/NsHnubsi/5tzgCvCk27Q6p
	 +4pr8CCy3l/MApftgUcbby7Re1VoVM97Tr7Orbfxj+fyJ8q2Jh36MvsDQv5E9IU4pj
	 3VMCnhaWoy8F+uzH8pp80oezTrIzD5fzr85H0umc/tQebuNuIpJweibFScXCDcVcG+
	 AKr1AvGvD+IVg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/6] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Date: Mon,  6 Jul 2026 22:01:12 -0700
Message-ID: <20260707050113.102129-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707044841.3BBC61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 04:48:40 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Multiplication overflow in DAMON access rate calculations due to 32-bit arithmetic.
> --
> 
> --- Patch [1]: [RFC PATCH 1/6] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/ ---
> commit 928ef68b58766df0da13e507ad449f7ba9d5c79d
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
> 
> This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
> to better describe that it returns the number of samples DAMON checks for
> each region per aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 390e00b3685ef..e710e2789085e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -880,7 +880,7 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
> >  static unsigned int damon_accesses_bp_to_nr_accesses(
> >  		unsigned int accesses_bp, struct damon_attrs *attrs)
> >  {
> > -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> > +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this multiplication in
> damon_accesses_bp_to_nr_accesses() overflow 32-bit arithmetic?
> 
> If the sample interval is configured to a small value and the aggregation
> interval to a large value, damon_nr_samples_per_aggr() can return a large
> number. Multiplying accesses_bp by this large number wraps around modulo
> 2^32 since both operands are 32-bit unsigned integers, resulting in an
> incorrectly reduced access count.

Known low priority issue.

> 
> >  }
> >  
> >  /*
> > @@ -893,7 +893,7 @@ static unsigned int damon_accesses_bp_to_nr_accesses(
> >  static unsigned int damon_nr_accesses_to_accesses_bp(
> >  		unsigned int nr_accesses, struct damon_attrs *attrs)
> >  {
> > -	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> > +	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
> 
> [Severity: High]
> This is a pre-existing issue, but does the use of mult_frac() in
> damon_nr_accesses_to_accesses_bp() also suffer from a 32-bit overflow?
> 
> When nr_accesses is sufficiently large, the internal calculation in
> mult_frac() overflows 32-bit arithmetic.

Known low priority issue.

> 
> >  }
> >  
> 
> [ ... ]
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index e8c389ad3226f..7e077084cb03a 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -303,7 +303,7 @@ static int damon_lru_sort_apply_parameters(void)
> >  		goto out;
> >  
> >  	err = -ENOMEM;
> > -	hot_thres = damon_max_nr_accesses(&attrs) *
> > +	hot_thres = damon_nr_samples_per_aggr(&attrs) *
> >  		hot_thres_access_freq / 1000;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this calculation in
> damon_lru_sort_apply_parameters() overflow on 32-bit architectures?
> 
> Multiplying the sample count by hot_thres_access_freq overflows 32-bit
> arithmetic on 32-bit systems when the sample count is large.

Known low priority issue.

> 
> >  	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
> >  	if (!hot_scheme)
> 
> [ ... ]
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 6bdd1cfd3863a..89c694f6e4fa8 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -112,7 +112,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  	int hotness;
> >  
> >  	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
> > -		damon_max_nr_accesses(&c->attrs);
> > +		damon_nr_samples_per_aggr(&c->attrs);
> 
> [Severity: High]
> This is a pre-existing issue, but could this calculation in
> damon_hot_score() result in a 32-bit overflow?
> 
> Multiplying r->nr_accesses by DAMON_MAX_SUBSCORE (which is 100) overflows
> 32-bit arithmetic if the number of samples is near UINT_MAX. This might
> cause hot memory to be incorrectly identified as cold.

Known low priority issue.

> 
> >  
> >  	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
> >  	if (age_in_sec)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707043828.97900-1-sj@kernel.org?part=1


Thanks,
SJ

[...]
