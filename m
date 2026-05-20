Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177C3E834F
	for <damon@lists.linux.dev>; Wed, 20 May 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285898; cv=none; b=ME8mTkHHW0I5cCMXgVkZEGbutB9U6fV4t4MzoBFlNIvGtmlwiOma+kI/G5GkxoZSN8l3HRKDRqPdJugy6USGmXLD7RiP/0bAkse+zmo0DS86KVlCecpTiOI8JB8jvDmojUvCp+jKAGKb7jgp4Xn2BL1ITt24MHJZI2DRs0vdOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285898; c=relaxed/simple;
	bh=36JjRBsGaD0LaD0JrqGoGZ7Nu0vCfIbfl9jfbCEeROk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMavqpuiewD+oyCW9wxYuljX35OIwtO4IWzG+MP1SJFeiJ6GP45KNO3LhqP0scnIxXEXWSrxPxZNHfVlnyFMLPtj2cTSpHaV8HcyjIYBLZH/WcW4sky+4dw1glDHwYXakPw4nsG2f2TysujHxHhC6Xb9Qf9ieMgSJSwiRh8U7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jza7z2JB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jza7z2JB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB181F000E9;
	Wed, 20 May 2026 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779285896;
	bh=wN2mVCP8TMkOZiTt11E4JmIQL9CD3q3WrSzD+0TMhYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jza7z2JBa8CsJPhYbreyCxVn4xXhw1E2Pfkie53unjISAoLjAZ68j++YVo2SWEB1p
	 muWPUBsKEyC7OSWeBc3oc134iWLX7vaS4e8nmHdCsx2nqSf3/tm5JC8hVSspBIbY2n
	 glNwPJnIuVdKwO6+ZUNaglbzgGm5dTETTKQrjTs3m/xnY/EFJhi5ZHoQtTQ0wRhW3M
	 l5cGsj1vy55RTIpwygxcQ4StzSixCp9jZ/ownqMYbXOYShtUrHX06gsN77xI0vi/KM
	 u7rEBpIvNSFLjArvMLUj9ul4Ww+O7mQ9nHZ5hdUTWtCHGffNJD2HsdCnFNuXnr2zRW
	 F18cnqlf8h2jg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 08/14] mm/damon/core: add kdamond_call() debug_sanity check
Date: Wed, 20 May 2026 07:04:33 -0700
Message-ID: <20260520140435.169811-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520065300.A51591F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 20 May 2026 06:52:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The sanity check for region bounds in `damon_verify_ctx` uses an inverted condition, causing it to falsely trigger a kernel warning on all valid regions and fail to catch invalid ones.
> --
> 
> commit 7d803208aef5bc4f95dd9c37657de5b62618e8e6
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: add kdamond_call() debug_sanity check
> 
> This commit introduces a debug sanity check for the DAMON context state
> before handling damon_call_control objects in kdamond_call(). The check
> verifies region boundaries, overlaps, and the total region count under
> CONFIG_DAMON_DEBUG_SANITY.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3326,6 +3326,37 @@ static void kdamond_usleep(unsigned long usecs)
> >  		usleep_range_idle(usecs, usecs + 1);
> >  }
> >  
> > +#ifdef CONFIG_DAMON_DEBUG_SANITY
> > +static void damon_verify_ctx(struct damon_ctx *c)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +
> > +	damon_for_each_target(t, c) {
> > +		struct damon_region *prev_r = NULL;
> > +		unsigned int nr_regions = 0;
> > +
> > +		damon_for_each_region(r, t) {
> > +			WARN_ONCE(r->ar.start <= r->ar.end,
> > +					"region start (%lu) <= end (%lu)\n",
> > +					r->ar.start, r->ar.end);
> 
> [Severity: High]
> Should this condition be inverted? WARN_ONCE triggers when the condition
> evaluates to true. Since a valid memory region typically has a start address
> strictly less than its end address, this evaluates to true for normal
> regions.
> 
> Could this trigger a spurious warning on the very first valid region
> encountered, and because it uses WARN_ONCE, prevent any actual regressions
> where start > end from being reported?

Good catch.  start == end should also trigger warning though, because DAMON
disallows empty regions.  I will fix this in the next revision.

> 
> > +			WARN_ONCE(prev_r && prev_r->ar.end > r->ar.start,
> > +					"region overlap (%lu > %lu)\n",
> > +					prev_r->ar.end, r->ar.start);
> > +			prev_r = r;
> > +			nr_regions++;
> > +		}
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520062858.167011-1-sj@kernel.org?part=8


Thanks,
SJ
