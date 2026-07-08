Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C621A6822
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520808; cv=none; b=hlxSsEUsFc1uLtyreGUA+LomsJhZol0F0uZ6ruG4BneDQmqoq7LJY5bcueYH9mN5imTJtT+6Ietyat63I1kvTs6Tv+a35D2WmOrDz4q6dhJg2BY+Ok73pepkkpyBaPBue2OxzzlcT5UVdUHGa8Ux4DsznomaxzBcMh7pZ9VKiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520808; c=relaxed/simple;
	bh=EeRLkuO0piL6nJODAJl69iZagnEcRwP5OTpMTckUQIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMsq2x62Su7MjoZHLeEAsdcQbRQVl3zWYcxnF1aTB1K4WuQ6nkQQPvrb1Nx34hhEkJac/UUm/u43OikaNIv3RB9Q43043jXYBk3en5iafumNNmnyUYr6Kuxfw9w/0k2z7MASM5VKpQg3YUqcUVAKrguYaO8JAEKvukUlJw3/3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4zLI1Z/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4zLI1Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C21F000E9;
	Wed,  8 Jul 2026 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520806;
	bh=KgpcQWJhxjipI8iwU1MCRqSndsJDv/Xzwir4mVV35iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4zLI1Z/j52XHjAqh9EzuulfES7tpXsnA06jgQJXalvEj7s6u55h40ucv9tBUPHB6
	 a2FwUz8G4Kp6HQc5UMHKYz/6L4Cjyfln3uCSw7CcfHizRHAAZCAfkUTsgpht9ItOYc
	 +pxp4tY+myuo8N5F90t3SKtbnDATGBAOpbfDwU0J2P18xSiwtB5WSrbBHYrb9DK1pU
	 fVPYQU0H2dAvCirXyhqrGsSfCGOjSbUDXEvs93kGuodbdEz7+SPNtBMxciymqBmwe1
	 jR0JxLbmJE9F3zAahTVc6vhU1aRyJ7QgPsBZru8lSnO2ekn78qtlruJh+dGA/SGZAf
	 rbcBzPCYDnYRA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Wed,  8 Jul 2026 07:26:43 -0700
Message-ID: <20260708142644.124034-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708140348.4A4F91F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 14:03:47 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The functions `damon_sample_bp_to_count` and `damon_sample_count_to_bp` are susceptible to 32-bit integer overflows when evaluating large aggregation intervals.
> --
> 
> --- Patch [4]: [PATCH 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/ ---
> commit 75d19025f9846da2b8b1718a4f36d8064a4aa832
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
> 
> This commit renames damon_nr_accesses_to_accesses_bp to
> damon_sample_count_to_bp to better describe its actual behavior of
> converting a positive sample count to a ratio.
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
> This is a pre-existing issue, but does this multiplication overflow if the
> total samples in an aggregation interval is large?
> 
> If an administrator configures a large aggr_interval compared to
> sample_interval, making the sample ratio exceed 429,496, multiplying bp
> (up to 10,000) by the number of samples could exceed the 32-bit limit of
> unsigned int, causing incorrect bound calculations.

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
> This is also a pre-existing issue, but can this use of mult_frac result in
> an integer overflow?
> 
> The mult_frac macro evaluates (count % samples) * 10000 in 32-bit
> arithmetic, which might overflow and produce an incorrect basis point
> ratio when the sample count is very large.

Known low priorrity issue.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260708135359.122587-1-sj@kernel.org?part=4


Thanks,
SJ
