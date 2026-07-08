Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC44315F
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482755; cv=none; b=AGFGUNA6VeYBVb1GXfm0U9xx+4A3mnZYQkj3YDmT+7X3kPDy4cBT6MhYRwT8NLTveb8+mTh0MNFgq3yhxGU/OZhrb97SBhJ2UbA0aZGaNmP1oFMQdtE4hAKBJOF6JgXHTgXWVEt7gbGU02lScM6X/6y/1wbdGUvYohE9BYd2uIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482755; c=relaxed/simple;
	bh=idJKBIKbdcQGShZv++zi5t4nR3nPeyWxg/CRW3c/MBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixyMRebHKfwwFgaziaJSTV5bUHa6iVxB7prpLu2yngCAjiflUXoHDcE8H81FtGeINb84URkgAJQcPDikEASZoJsF3OOGWivlRs/DzXl4jcqxQvAm7uoHX3kUuqcVpqPKzIG+B/yYyjgD/Zd5u7zKa3J6pxsojITKpD7YkvTfHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmdLdcYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmdLdcYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F01F000E9;
	Wed,  8 Jul 2026 03:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482752;
	bh=Ydp/FBhYT0hlnM12ng5n/JTaBbluU7+eoBCFB47diAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GmdLdcYMBjRIHm63TAh0vzRB991RB8HqlQB3NrgZFcrPY0ZguHBtTc2JYSu968taD
	 WIU1yk3Uid6lUoDAXM11198PRC31IbbmDCad0NwpgKZyGe2A0biFYGVGi71rOMlPUA
	 Nj9+17OMT+b8Su5jm+99A9hwuTr4OHjPgmlRklcoQpUY7SeCykVTNRZbrwVJI6F2C0
	 UrLpTme6+1ere7Nz7q5DZUZHbdKXinf6gHn3/Jpo2bvYB91MB6kCtpQ4AHAnsJaMUP
	 KQN4iuR6iZFWL3XVBoq0U2BnmIgfWpdfU2ZetLC+PhuzZqNmtxk9+Os//qTPYU0hEX
	 JOaCPBbZTp+Zw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 2/7] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Date: Tue,  7 Jul 2026 20:52:21 -0700
Message-ID: <20260708035223.118057-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708025818.BD9701F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 02:58:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Arithmetic overflow in DAMON access frequency calculations for large sample counts.
> --
> 
> --- Patch [2]: [RFC PATCH v1.3 2/7] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/ ---
> commit f4e38af8a3753be681be346a7474a71c5bfadd23
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
> 
> This commit renames damon_max_nr_accesses() to damon_nr_samples_per_aggr()
> to better describe that it returns the number of samples DAMON checks for
> each region per aggregation interval.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index a15005db82899..177e5abc981ef 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -880,14 +880,14 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
> >  static unsigned int damon_accesses_bp_to_nr_accesses(
> >  		unsigned int accesses_bp, struct damon_attrs *attrs)
> >  {
> > -	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
> > +	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does multiplying accesses_bp by
> damon_nr_samples_per_aggr() overflow 32-bit arithmetic?
> 
> If the total samples exceed ~429,496 (e.g., by configuring a large ratio
> between the aggregation interval and sample interval), this calculation
> seems to wrap around, leading to a drastically lower access count threshold.

Known low priority issue.

> 
> >  /* Convert nr_accesses to access ratio in bp (per 10,000) */
> >  static unsigned int damon_nr_accesses_to_accesses_bp(
> >  		unsigned int nr_accesses, struct damon_attrs *attrs)
> >  {
> > -	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
> > +	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this use of mult_frac()
> overflow?
> 
> The mult_frac macro internally multiplies the remainder of nr_accesses by
> 10000, which appears to overflow 32-bit math for large interval
> configurations.

Known low priority issue.

> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index e8c389ad3226f..7e077084cb03a 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> 
> [ ... ]
> 
> > @@ -303,7 +303,7 @@ static int damon_lru_sort_apply_parameters(void)
> >  		goto out;
> >  
> >  	err = -ENOMEM;
> > -	hot_thres = damon_max_nr_accesses(&attrs) *
> > +	hot_thres = damon_nr_samples_per_aggr(&attrs) *
> >  		hot_thres_access_freq / 1000;
> 
> [Severity: High]
> This is a pre-existing issue, but does this calculation overflow hot_thres?
> 
> Multiplication of the samples by hot_thres_access_freq (typically hundreds)
> looks like it overflows a 32-bit integer when calculating the hot threshold
> if samples exceed ~8.5 million.

Known low priority issue.

> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 6bdd1cfd3863a..89c694f6e4fa8 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> 
> [ ... ]
> 
> > @@ -112,7 +112,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  	int hotness;
> >  
> >  	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
> > -		damon_max_nr_accesses(&c->attrs);
> > +		damon_nr_samples_per_aggr(&c->attrs);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this multiplication
> cause an integer overflow?
> 
> The r->nr_accesses variable is multiplied by DAMON_MAX_SUBSCORE, which is
> 100. If nr_accesses exceeds ~42.9 million, it overflows a 32-bit integer,
> resulting in a drastically lower or zeroed hotness score. This could lead to
> miscalculating region hotness and erroneously reclaiming actively used pages.

Known low priority issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708024855.116614-1-sj@kernel.org?part=2


Thanks,
SJ
