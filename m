Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855352;
	b=VHsx4i0W+IZJxDEpqalYW6d5yJ8Hm+z3ZSmc6NxNz3P5r6Fhmy+bzPTgpvMJS1VPFVn/
	 OEqNFta/DuBC8JCA9FQrt5k9h8eup0MVXjpn6Jlhl0g9omtOh7+2rUJwigRa/WWpAKol9
	 zV6b9NBLdFCb1K8cBftvo4/gLk02fGIEL7iP9aFssdC+HE7jGEJLQQz6sC4WXpQshEudy
	 VQKavh4DrQwKQ43DCtcV0wtj8QAAmRyfDuj9/a6f3rjd/UUa4me3U24UQzBv4FoTLCMBD
	 kJ7ZYPGIj3JtotMLYlIlnG7DzKGksrB/GkJ22Chjtc0Q6boB6JdIf3ir6+0S1XGtdtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NVjhKhBJ1oUBAreFU+zkJHpDMRywHm7v/hTjYaL27mI=;
	b=DcNOVECylHS5CNnuYzRSyiXzHHPkDKlj2HpCrQw0KKuo6NnPmhIY5PRpWKS3nARZODFT
	 b+o4v6DApN7VClY6tNocWv+WHem4SauU9MYgoyv8ECSLT42cYET+rQsLPnN34JncXVuzk
	 25+TZ0GPF1sJfkI1gSN3VY48nJbYO9hpXBJ6Rx8XcG8o98HiPUs6VW2eTqCJMjoJ+ssTr
	 KoN3HOJwaPORwsUpxFq3FSgkzRwb0gx0ak4HrOIdJ67UCpEjmshieeNFW6Ql78n8bh8Vh
	 Wh4YqNt6MHzXnQLvt2hRAA1LurPBkKKwEXL8G6M2WlAoEfvFLfZhqa+mXCohMmBE8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiF92giW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD37606A328
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiF92giW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8081F00A17;
	Thu,  5 Nov 2026 05:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793855351;
	bh=NVjhKhBJ1oUBAreFU+zkJHpDMRywHm7v/hTjYaL27mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WiF92giW9TXL6Du/iE3M3lfYTBW+q3y9PRiWrFooahhHgbSQB5SAz9omhz8hzzv4r
	 sKCHbBpYWl16qsYw67TSaFspVf0/nF1/sruXsNyBUPVa637zMyIjarq+mzqj1btzZu
	 PJ0YPqmdgPY9xSYJt3Pg5L3Vg1TGnTQdmNOvqc2Z9ppzINCRwZILJ4Vii2q6ObHVo7
	 JL8ypGMuFeVe6oMJYOyFdEsRoM6THDq1xHhOXr1cBzA5XQ+Gfnc0rfkOL/D6KtvW5f
	 wp2Z+2WsV2xV9gU4uoUP3dJC/fztGIO0x2lKjwF54CMrEfsp/idHXDN7XVuwz11dMD
	 CVEgXGoi8DPLg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 1/4] mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
Date: Wed,  4 Nov 2026 21:09:03 -0800
Message-ID: <20261105050904.87870-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-198571@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 05 Nov 2026 04:55:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon: 64-to-32-bit truncation of age_ms in damos_filter_match()
> --
> 
> commit 2459402d4dc794f740b6a5720a69fe4a1a61ae62
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
> 
> This commit introduces DAMOS_FILTER_TYPE_AGE_MS in the DAMON API and core
> layer to allow filtering DAMOS target regions by age in milliseconds. It
> converts the region age from aggregation intervals to milliseconds using
> div_u64() and compares the result against damos_filter->range_{min,max}.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index d36823f4d0928..0a056949604f9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2552,7 +2554,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  	bool matched = false;
> >  	struct damon_target *ti;
> >  	int target_idx = 0;
> > -	unsigned long start, end, wsum;
> > +	unsigned long start, end, wsum, age_ms;
> >  
> >  	*err = 0;
> >  	switch (filter->type) {
> > @@ -2594,6 +2596,12 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
> >  		matched = filter->range_min <= wsum &&
> >  			wsum <= filter->range_max;
> >  		break;
> > +	case DAMOS_FILTER_TYPE_AGE_MS:
> > +		age_ms = div_u64((u64)r->age * ctx->attrs.aggr_interval,
> > +				USEC_PER_MSEC);
> > +		matched = filter->range_min <= age_ms &&
> > +			age_ms <= filter->range_max;
> > +		break;
> 
> [Severity: Medium]
> In damos_filter_match(), age_ms is declared as unsigned long. On 32-bit
> architectures, unsigned long is 32 bits wide, so storing the u64 return value
> of div_u64() into age_ms truncates the upper 32 bits whenever the region age
> in milliseconds exceeds ULONG_MAX (about 49.7 days, or for example
> r->age >= 42,949,673 at the default 100,000 us aggr_interval, and
> proportionally earlier when aggr_interval is larger).
> 
> When that happens during kdamond_apply_schemes() -> damon_do_apply_schemes()
> -> damos_apply_scheme() -> damos_filter_out() -> damos_core_filter_out() ->
> damos_filter_match(), age_ms wraps modulo 2^32 and can misclassify old
> regions as young regions or fail to match old-region filters.
> 
> By comparison, damon_hot_score() in mm/damon/ops-common.c stores the result
> of div_u64() in a u64 variable (as fixed in commit 0284dff76e87 ("mm/damon/
> ops-common: fix 64-bit division in damon_hot_score()")):
> 
> mm/damon/ops-common.c:damon_hot_score() {
> 	...
> 	u64 age_in_sec;
> 	...
> 	age_in_sec = div_u64((u64)r->age * c->attrs.aggr_interval,
> 			     USEC_PER_SEC);
> 	...
> }
> 
> Should age_ms be declared as u64 (or saturated to ULONG_MAX before storing into
> age_ms so filters with range_max == ULONG_MAX on 32-bit continue to match) to
> avoid truncating the quotient on 32-bit systems?

The overflow could make DAMOS behave little bit suboptimum for certain cases.
I don't think that will be measurable.  Regions of age longer than 49.7 days
would be rare in my opinion.  Also, DAMOS resets age of regions to zero when an
action is applied.  Hence I think 49.7 days is practically long enough.  I'd
keep this as is for simplicity for now, and revisit if other human raises
concerns or a real issue from the possible overflow is found.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261105044425.87142-1-sj@kernel.org?part=1
> 


Thanks,
SJ
