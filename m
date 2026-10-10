Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94823BD06
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616288; cv=none; b=P6C/7BtJGcFmCze4JKgaDGs92A7qmZm7ekslh8Is4K0uu/JWer+ys1jGHO7P+fnnB6XN6+km2T0zoOemHvppRYwDnvaNkh2soSqhDGMsvxFDnrNCmzccfmDh2K+HnrdW5eyYwnPodK2nZYhdW9lFJHrpIgnR9DOJjN6S+YNbBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616288; c=relaxed/simple;
	bh=D1lIiaBjrie0g8jwQfJgmIm3p22u196WzRz4Mhl2FW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgdJTHGEEY2P8V18jp9EHu9STZ/bo/1U4F7DF3ROnWDXir29AP7SOKf0Q8dfTCq6vxFwxNdUBf6q+0S4u8hG0zSkjxYcGUwATT4mS6gYUr7pBUGogev8ROBnZWFp865Fc0Jat5P03gTP6Vz3Bcm0BB6z2z4UXvwCFuqtvvTiwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMyHzWNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMyHzWNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931111F000FF;
	Sat, 10 Oct 2026 07:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791616287;
	bh=54Iga7RbTyQC6zCYPbyxR1EkDF3phc/ZaHrZE6sQ32c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NMyHzWNikk5Bgl2aj7prgmLfmald+a2O0JJAC9F+4eDVRllvz5k33bWKyQ6vwyyDR
	 C2KC0T1Vv2rcM0TFJW1rTrzXVvSQyrLioHE23lMXMzvyA5zr5Ax4Lmd0cT1dM1B7t0
	 q+l+ffZGXJ14pBKBKEiDas/Yl6aTGAzza58wVrqDBKt1pfoWEYTFh9K9ejTrR75Ji4
	 kusNIVSuigFtcF/b6NyZUNgrcBoCk+PGb5SyM6E3/EV/GDaCzZW9NoKm36YbjsAl1f
	 6TUuUvJLE48umn+GtkHAVIzxvJSRMTiUFc5vp/xQOB46VNLp2XUcoOjVYASJ+I/jQ+
	 sPMc+cMTz71QA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y v3 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Sat, 10 Oct 2026 00:11:22 -0700
Message-ID: <20261010071123.8894-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-166283@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 10 Oct 2026 06:41:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: double-application of earlier schemes to newly split regions
> --
> 
> commit 01d768c4d318527360ef5913771d20f22a99984a
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
> 
> kdamond_apply_schemes() is using damon_for_each_region_safe(), which is
> safe for deallocation of the region inside the loop. However, the loop
> internal logic does not deallocate regions. Hence it is only wasting the
> next pointer.
> 
> Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 7afbc20833ea4..b5c85e6488596 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -912,7 +911,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  	}
> >  
> >  	damon_for_each_target(t, c) {
> > -		damon_for_each_region_safe(r, next_r, t)
> > +		damon_for_each_region(r, t)
> >  			damon_do_apply_schemes(c, t, r);
> 
> [Severity: High]
> Does this code cause earlier schemes to be applied twice to newly split
> regions?
> 
> If multiple schemes are configured, an earlier scheme (e.g. Scheme 0) might
> apply its action to a full, un-split region. If a later scheme (e.g.
> Scheme 1) then decides to split the region, damon_split_region_at() inserts
> the newly split part into the list immediately after the current region.
> 
> Because this loop in kdamond_apply_schemes() now uses
> damon_for_each_region() instead of the safe variant, the outer loop will
> advance to this newly split region and call damon_do_apply_schemes() on it
> again.
> 
> Will this cause damon_do_apply_schemes() to evaluate the new region from
> the beginning of the scheme list, resulting in Scheme 0 executing its
> memory management actions (like madvise) and counting statistics a second
> time on the same memory range?

The same issue exists in the mainline.  The user impact is minor.  No blocker
of this patch in my opinion.  I will separately work on it.

> 
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261010063042.8611-1-sj@kernel.org?part=1


Thanks,
SJ
