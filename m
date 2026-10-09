Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358446AA68
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553367; cv=none; b=Q7d49k7URGvW9Ki2uOU2gnMUwEvoWQMDxukw+uUcVXSMy/5WTa4L8OrAxh6nbR43ME11LvTdojS+Dl4MdX0qcAkNugct9r8x5tuG0frSR8ip5UhDgB/S8rYfwDW0K6Ujv3NhcafmTw5SxbSMQZalDqU/DcUsjBytAWMeVAdIHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553367; c=relaxed/simple;
	bh=9/r43+fKD6OuOqAFAz1S0sizcY77VyG2S9eQcolIesc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPt11tWmNz1ASxoa84fR85eOe8IDFIgd7Z1pEAuq1CM5yFb19YQ4pjspv4oMyWlOjEAUXUKiDvuEKENDfamlVC5bvMx54ZxrxenEnD1TX6GI5SwrLtizyqjf5/snhG0RLCUoXKlp7ISf+0fvO2vuc3spPEQEnSt6QWyK6XAL2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edy9EVUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edy9EVUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FBB1F000FF;
	Fri,  9 Oct 2026 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553364;
	bh=XaoTeFeS0vaNk5c9UKe8uNK+zqoQnphT0y6GdFskI1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edy9EVUZgY63gyGPFQXpH0z9EDOh8TzgoQfOChNacD7Bkyh5HSRX2hZEcKs3R8W40
	 9XVjd41GEb5Jok0NbNGD11rzFo+bmKtW9mB75xpUMKu5A1N3L629LibaTaLPXqVqaK
	 gsP8KsP6mdn7uFzyTA+KckS18b0Tk0wcfsQ8r9ffFlHWwT2QW6UR7d2JDcMfCpSCNV
	 D/NkozA+6mZ1+dP2xTufecc+sxErQk2TQQUvI+PymBca2miKLdO5rP3WedV10zF4A0
	 4LQAbax2C1oL1GhtMmc2OFdiyBEKmIzk9cMGpjamneMv7n6bQb7/gYswR6eL+OiPw8
	 mTE5tj3+6384Q==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y v3 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Fri,  9 Oct 2026 06:42:40 -0700
Message-ID: <20261009134241.7294-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-165573@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 12:55:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: damon: double application of DAMOS schemes due to non-safe region walk
> --
> 
> commit 7c60a2f66acad38f06b09b2a9e484519168800bc
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
> 
> This commit changes kdamond_apply_schemes() to use the non-safe
> damon_for_each_region() iterator instead of damon_for_each_region_safe().
> It also drops the double-pointer workaround in damos_skip_charged_region()
> to let newly split regions be seen on the next iteration of the region walk.
> 
> Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 32737cc5f877b..76f23c1d2f56b 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1749,7 +1749,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  		return;
> >  
> >  	damon_for_each_target(t, c) {
> > -		damon_for_each_region_safe(r, next_r, t)
> > +		damon_for_each_region(r, t)
> >  			damon_do_apply_schemes(c, t, r);
> >  	}
> 
> [Severity: High]
> Does this change cause earlier schemes to double-apply their actions when a
> subsequent scheme splits the region?
> 
> In kdamond_apply_schemes(), changing to the non-safe iterator means the loop
> dynamically visits newly created fragments on the very next iteration.
> 
> When damon_do_apply_schemes() runs, it evaluates all schemes sequentially on
> the region:
> 
> mm/damon/core.c:damon_do_apply_schemes() {
> 	...
> 	damon_for_each_scheme(s, c) {
> 		...
> 		if (damos_skip_charged_region(t, r, s))
> 			continue;
> 		...
> 		damos_apply_scheme(c, t, r, s);
> 	}
> }
> 
> If an earlier scheme evaluates the region, it may apply its action and update
> its statistics for the full size of the region.
> 
> If a subsequent scheme then evaluates the same region and splits it (for
> example via damos_skip_charged_region()), it shrinks the original region and
> inserts a new region immediately after it.
> 
> Because damon_for_each_region() is no longer safe against modifications to the
> list, the next iteration of the outer loop will process the newly inserted
> region across all schemes.
> 
> Since the newly inserted region retains the exact properties (age, access
> counts) of the original region, will the earlier scheme re-evaluate it and
> apply its action a second time, double-charging its statistics and applying
> redundant actions to the memory?

Good finding.  But the issue is also in the mainline.  Also, because DAMOS
quota is a sort of best effort, the user impact is minor.  I think this is not
a blocker of this backport patch.  I will separately work on it.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009123651.6585-1-sj@kernel.org?part=1
> 


Thanks,
SJ
