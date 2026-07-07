Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF43E8355
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434400; cv=none; b=gD7urlD9+FR9LI87B5mXmfkVnv3G/B3SlalCgKtfS8O5HwXervafEbac5LljlwwD+oNmxN2j//G00burbU02HI7uzWAPKSvH/JF6JjZ9UooKVm+Tm+ogwC49igLvMeP+YQOMen/G0BzMWrHN+L0OVe8s6nYTAf6B9s9UzGXJAhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434400; c=relaxed/simple;
	bh=LLWQhYuXmSzIXsaVE7YqN+mrTcnPclnh1lQ8yzuE3ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRleg/8gWq0fgNq1P3mP681PAr9ZUTYx7o2DYrW+7SvnijkkFnW16Apn+98+IkhJvNzOjFXzFyVl5KITJgBagg7vHRC5lqznKZ3sqqGUBUG3p5JHCgrKgyqZ2ONcurPtkqBwmpPUemr8ex4vjMp8dFLclFx3p6SjcgQT++6AwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeRiCmg1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeRiCmg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DF1F000E9;
	Tue,  7 Jul 2026 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434398;
	bh=V/HeY1/ytrUlIw15biUF6V8yfNPger7BTkIQY2CxvLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeRiCmg1IyR0SEiBbKKO/qwjAdMj3nUfgf+nYo2mEUjjcTOKmo5IFO/P35LqPaLJW
	 isvIYmGgkIQi9PiB9zLXfMRdk8SayuuVfBb6zWFvdUfKvyCPFfKLhxSg5p9rzufTh+
	 WwG0JU5ND/ByfaOK7Ylz2tiBennHoi62wv5MzidxwtST+xvkl3j4td/9xRLcrMci8i
	 Mq454zbfGqzw7KvICki1gX6Ax68avNcgsrN/I4EUauPsW19bV02GFYYnMOFcRtKW5Y
	 zuq+oeo9ZPHIBrrfgQwjJHf1Zz7u5xwId+OedGZDQ9roo6pXuvGzmj63oG25K5z3vO
	 rYEW7KOw0jsaw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Tue,  7 Jul 2026 07:26:33 -0700
Message-ID: <20260707142635.91595-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707140221.DD3E91F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 14:02:21 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The KUnit test `damon_test_sample_count_to_bp` unconditionally fails on 32-bit architectures due to integer overflow in `aggr_interval` initialization.
> - [Low] The commit message erroneously claims to remove an obsolete division-by-zero comment that is not present in the patch diff.
> 
> Pre-existing issues:
> - [High] Arithmetic overflow in `damon_sample_bp_to_count()` and `damon_sample_count_to_bp()` on all architectures when `nr_samples_per_aggr` is large.
> --
> 
> --- Patch [4]: [RFC PATCH v1.1 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/ ---
> commit 3660ea5f51f638ba678520c22cb275f27a0966b1
> Author: SJ Park <sj@kernel.org>
> mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
> 
> This commit renames damon_nr_accesses_to_accesses_bp() to
> damon_sample_count_to_bp() to better reflect its behavior. It also mentions
> removing an obsolete division-by-zero comment.
> 
> >     Also remove the obsolete comment about division-by-zero.  Commit
> >     35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
> >     damon_hot_score()") modified damon_nr_samples_per_aggr() to always
> >     return non-zero.  Hence no division-by-zero of the note can happen.
> 
> [Severity: Low]
> This isn't a bug, but the commit message states it removes an obsolete
> division-by-zero comment. However, this comment does not appear to be
> removed in the diff below. Was it already removed by an earlier commit
> in the series?

Good catch.  I will remove that part from the commit message.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index dea63083917b0..718268df27fa7 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
> >  	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but can this multiplication silently
> overflow on architectures where unsigned int is 32-bit?
> 
> If a privileged user configures DAMON attributes via sysfs such that
> aggr_interval / sample_interval > 429,496, damon_nr_samples_per_aggr()
> will return a large 32-bit unsigned integer. The multiplication
> bp * damon_nr_samples_per_aggr(attrs) could then exceed 32 bits, resulting
> in incorrect sample counts and potentially flawed memory management policies.

Known low priority issue.

> 
> >  
> > -/* Convert nr_accesses to access ratio in bp (per 10,000) */
> > -static unsigned int damon_nr_accesses_to_accesses_bp(
> > -		unsigned int nr_accesses, struct damon_attrs *attrs)
> > +/* convert sample count to ratio in bp (per 10,000) */
> > +static unsigned int damon_sample_count_to_bp(
> > +		unsigned int count, struct damon_attrs *attrs)
> >  {
> > -	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
> > +	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> >  }
> 
> [Severity: High]
> This is also a pre-existing issue, but does mult_frac() run into a similar
> 32-bit overflow?
> 
> The mult_frac macro evaluates the remainder multiplication (count * 10000)
> as a 32-bit unsigned int. If count >= 429,497, this could overflow, leading
> to a flawed ratio calculation.

Known low priority issue.

> 
> [ ... ]
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 224a3ecaa0701..9e631b19b184a 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> > @@ -575,14 +575,14 @@ static void damon_test_set_regions(struct kunit *test)
> [ ... ]
> > -static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
> > +static void damon_test_sample_count_to_bp(struct kunit *test)
> >  {
> >  	struct damon_attrs attrs = {
> >  		.sample_interval = 10,
> >  		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
> >  	};
> 
> [Severity: Medium]
> Does this test initialization unconditionally fail on 32-bit architectures?
> 
> On 32-bit systems, unsigned long is 32 bits, causing ((unsigned long)UINT_MAX + 1)
> to wrap to 0. This makes aggr_interval = 0.
> 
> >  
> > -	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
> > +	KUNIT_EXPECT_EQ(test, damon_sample_count_to_bp(123, &attrs), 0);
> >  }
> 
> Because aggr_interval is 0, damon_nr_samples_per_aggr() safely returns 1.
> The call to damon_sample_count_to_bp(123, &attrs) then computes
> 123 * 10000 / 1, which evaluates to 1,230,000. This would fail the
> KUNIT_EXPECT_EQ assertion that expects 0.

As I replied to earlier review, I will remove the test entirely.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707135038.90068-1-sj@kernel.org?part=4


Thanks,
SJ
