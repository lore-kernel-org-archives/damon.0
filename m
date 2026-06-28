Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5F40D579
	for <damon@lists.linux.dev>; Sun, 28 Jun 2026 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782609226; cv=none; b=DXytPIU2kf8WVXMtUW8lnuTwm/bEKKwUhIYSglOtrHabsm+KhxgKOmt4q63q2u00cLDY8IouV59rUrEviqas32Mp2Rzldb+Eiu7edy1CgmMnhXpwC/bSCuKcNBVihzpYrw7yorefi9mlJ2nNmgxVZdcRZWh4K37hkp+oI2ugNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782609226; c=relaxed/simple;
	bh=vRdiUVRrYyI2WlStp/rmccNGiW6Ai/PHJHe+EABmEsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvSy2icbOIARu5z0HLQRQTzWTS/wo+BwGV9EfuWK2Rq9WlNsv7+dFofE6o1c1ssjOEz143F+r9SmpcogTkAhrZ5W6r1/rCluDN+RncaX+iwkUuQamT/doOQzbGqddxNimAmDVG8pDzNQzIv526Wp3g21kFlA0iP+2RVu3s5rAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4GNsmX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4GNsmX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F1E1F000E9;
	Sun, 28 Jun 2026 01:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782609225;
	bh=lynx3vAr44SR/p+dLNsbbTic9r5451GIDfLWqOgaFQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4GNsmX3PtT3+kd/xGyFuXaXr0cJ66janSAHaBJGlWSEWpUeFCu/IaNqP4X37WL++
	 im8ZD8xINIVI4BrsfEyhkCnjJ2CaBaCzbwcrHPm8ie5xIBXMjTgsw5rxULf2E5h/1/
	 5bTxrzy/G0iCQfg9MnKcvBXg4iszTGqdpARzB6rTnajeXWRicdnXQQnmJSB9L/DAxz
	 NIwlTL3j/lT9mfe4CMhZKuG1yEy0ag4fxHdp1LnHxJ+y5LvAiovK7mc9iIZmzoc4FX
	 aXKOwWuRa2Zc2Hoah2Wxj+qCcRDVfye8729LFfAAKX5EoikBHo5b+8mJmkA6b3RpfV
	 xlbT4EyNioF+Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 18:13:30 -0700
Message-ID: <20260628011331.30349-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628010631.797E21F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 28 Jun 2026 01:06:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Critical] The new validation logic incorrectly uses `ALIGN_DOWN` for the region's end address, falsely rejecting valid sub-block monitoring regions and breaking the user API.
> - [High] Integer overflow in `ALIGN()` bypasses the newly added validation check, failing to prevent the creation of zero-length regions.
> 
> Pre-existing issues:
> - [High] sysfs interface allows `addr_unit` to be set such that `min_region_sz` is not a power of two, breaking alignment macros and corrupting boundaries.
> --
> 
> commit a7d14189013c68fcb3a5a9644321f7f319e6fe5f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: validate ranges in damon_set_regions()
> 
> DAMON core logic assumes zero length regions don't exist, but API callers allow
> empty monitoring target regions. This patch adds validation in
> damon_set_regions() to ensure start is strictly less than end after alignment.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7e4b9affc5b06..cbdf29d119c93 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -358,6 +358,12 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
> >  	unsigned int i;
> >  	int err;
> >  
> > +	for (i = 0; i < nr_ranges; i++) {
> > +		if (ALIGN_DOWN(ranges[i].start, min_region_sz) >=
> > +				ALIGN_DOWN(ranges[i].end, min_region_sz))
> 
> [Severity: Critical]
> Does this ALIGN_DOWN() on the end address incorrectly reject valid regions?
> 
> If a user configures a target region with start and end within the same
> alignment boundary (for example, start=4096 and end=8191 with a
> min_region_sz=4096), the check evaluates to 4096 >= 4096 and returns
> -EINVAL. The previous behavior successfully expanded this to [4096, 8192)
> using ALIGN(end). This seems to reject previously valid inputs.

Correct.  I mistakenly used ALIGN_DOWN() instead of ALIGN() for the end
address.  I will fix this in the next revision.

> 
> [Severity: High]
> Can an integer overflow here bypass the new validation check?
> 
> If a user specifies a region with an end address near ULONG_MAX,
> ALIGN_DOWN(ULONG_MAX, min_region_sz) will evaluate to a large positive
> value, which passes the start >= end check.
> 
> However, the region creation logic later uses ALIGN() on the end address:
> 
> mm/damon/core.c:damon_set_regions() {
>     ...
> 		for (i = 0; i < nr_ranges; i++) {
> 			r = damon_new_region(
> 					ALIGN_DOWN(ranges[i].start,
> 						min_region_sz),
> 					ALIGN(ranges[i].end, min_region_sz));
>     ...
> }
> 
> ALIGN(ULONG_MAX, min_region_sz) overflows to 0, which means damon_new_region()
> is still called with an end address of 0, bypassing this validation and
> creating the exact zero-length region this patch intends to stop.

Use of ALIGN_DOWN() for the end address was a mistake.  I will use ALIGN() for
the end address in the next spin.

> 
> [Severity: High]
> This is a pre-existing issue, but can min_region_sz be a non-power-of-two,
> corrupting boundaries when passed to ALIGN_DOWN here?
> 
> The ALIGN and ALIGN_DOWN macros rely on bitwise masking, which requires
> the alignment value to be a power of two.
> 
> Looking at how min_region_sz is calculated in damon_sysfs_apply_inputs():
> 
> mm/damon/sysfs.c:damon_sysfs_apply_inputs() {
>     ...
> 		ctx->min_region_sz = max(
> 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
>     ...
> }
> 
> If a user writes a value like 3 to addr_unit via sysfs, min_region_sz
> becomes 1365 (4096 / 3). When 1365 is passed to ALIGN_DOWN here, the
> macro produces garbage addresses.

Wrong.  We have the power of 2 check in damon_commit_ctx() and damon_start().
So this issue cannot happen.


Thanks,
SJ

[...]
