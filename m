Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195F0378818
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400921; cv=none; b=WPthfP6zTL1Uim8PaQd7BiFlw+dT/I9OfAl1uJgz6VtK/84A91MJpvckMbGSBebvUToc19SEl6/7ulx8ElaYkLgroFCeekGlszEqv2/uZX0GwDfq/8+jARgCZN4BgzEmv1u3I/fckmOLhO330W+EpZYL4W03L7jPFZRdlLsnnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400921; c=relaxed/simple;
	bh=c+py1qwHsLYCfx9vGbxdiAsFwGZjQ6YnpXoq2YO/L/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a83jVM5DmkacvQSovjVBjh5/WOzC9NTQPUS6TV/ZvtHwExjcMzSN13LrgooWo1OWHv7T6xsrGuElSfHESqKuhv79HJVVdMghkaTfn4UeX83MGibL1TzKcZyEJjJP764klIAP3BjrXnZ5NGbyjsNhp/u10HN438qDMhv7DWA6ll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK7GSXLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK7GSXLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808EA1F000E9;
	Tue,  7 Jul 2026 05:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783400919;
	bh=VDofJN/6lKEC6QhaYQBwkj+oXLJfZ0gvmKa8XcOR8BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZK7GSXLdPs0/6ByE3rgAvp39ff012csEWJ4Iffpz28aD+0ZV0zO4FfLi+NtWsoCC4
	 gQpHmYbkz7g/qtrqNuoHJwYL67yxZ/qfBBcdeU7txiBbhcb/ACZlTBReNbSQHPq1dF
	 8aHjZCW9b/XI85UIyLIDevyXR4u9qNzt/nIRyRYavhx6yLJsvs6Y9jNCaIDgqPngs3
	 kyQmm8yw/ZwBiW5tfZH4HItytZGjRuBqgB0ewmHH3SsoS+BYYDCnGcv2JMFe/pXo5T
	 cqbmQl3LmsB+FT1a4nSpr6JWa9LWmwfDYgkKeu9k+P4ztecF8Opv2tlAh7tD2V8Ag9
	 GwfXmhhLjjJtQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/6] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
Date: Mon,  6 Jul 2026 22:08:23 -0700
Message-ID: <20260707050825.102567-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707045018.C227B1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 07 Jul 2026 04:50:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] 32-bit integer overflow in damon_sample_bp_to_count() and damon_sample_count_to_bp() corrupts memory access tracking.
> --
> 
> --- Patch [4]: [RFC PATCH 4/6] mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/ ---
> commit cb8a54b34f772f70862ab31ccf30eea4a5cb2263
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/nr_accesses_for_new_attrs/nr_samples_for_new_attrs/
> 
> This commit renames damon_nr_accesses_for_new_attrs() to
> damon_nr_samples_for_new_attrs() to clarify its general use for any
> positive sample count.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 718268df27fa7..cda318806b65b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -890,7 +890,7 @@ static unsigned int damon_sample_count_to_bp(
> >  	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
> >  }
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but can this math silently overflow when the
> sample count is large?
> 
> In mm/damon/core.c:damon_sample_count_to_bp(), the mult_frac() macro inherits
> the 32-bit precision of 'count'. If the user configures sysfs such that max
> samples exceeds ~429,496, the intermediate remainder multiplication can wrap
> around UINT_MAX.
> 
> For instance, 450,000 accesses out of 500,000 maximum samples will silently
> overflow during mult_frac() calculation, resulting in a basis point of 410
> (4.1% hot) instead of 9000 (90% hot).
> 
> Similarly, in mm/damon/core.c:damon_sample_bp_to_count():
> 
>     static unsigned int damon_sample_bp_to_count(
>             unsigned int bp, struct damon_attrs *attrs)
>     {
>         return bp * damon_nr_samples_per_aggr(attrs) / 10000;
>     }
> 
> The multiplication occurs in 32-bit precision before the division by 10000.
> If damon_nr_samples_per_aggr() exceeds ~429,496, this will also overflow.
> 
> This drastic corruption could cause DAMOS to incorrectly evaluate region
> hotness, potentially swapping out highly accessed memory. Would it make sense
> to cast these to a 64-bit type before multiplication to avoid the overflow?

Known low priority issue.

> 
> > -static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
> > +static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_accesses,
> >  		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
> >  {
> >  	return damon_sample_bp_to_count(
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260707043828.97900-1-sj@kernel.org?part=4


Thanks,
SJ

[...]
