Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78B486E40
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553214; cv=none; b=uS6JHn0oLICp24xAIHy2l95z31ajPU2vGarRwPAd/zgtdO9IB0QGKED1WGOgU9RQLznYSMwjfvlLUDrzqkQKmMl/tPn4776HE1E0/hr5mK+G1rkEm0r3dDxgDnQMWlo6pM90UKUtzz6tZXbXTXAyjXpdpMUsKWaJEQHWQEUZbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553214; c=relaxed/simple;
	bh=tP0M0/r27UgtAu7woevlWDvC/ufsjLfqdjH/nZE2NPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2aW7ZzKiSYUfMA5DqxGbJsE2kL1HeD5qCQv58e5WE3rd9Bh07TlF01JJ0D4MM22unkMj6PvYdJ1NrwKtHyMTHZThOHDi4CHl9QZKw4ch3NwAwNhdEjDrjF5x6r7y5Pvn2YhvpmNzIcsMvS+isJDghV37xip2Ftla1o2utG5Fuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg4sl20Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg4sl20Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708DE1F000FF;
	Fri,  9 Oct 2026 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791553213;
	bh=apBe7SDjisFjk3yJcV8VcVwHeJQDZw6/eCzoyi1xeS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cg4sl20Q7B2Ij0BJffTbue2wy+ikJa5VGsyCgQ82m74nglJa+07uJ9DO0q0Fqrp/7
	 UVnBpjIs9C+Hc/HUNGUk5bQjuYPBmjM7ckbCKnS/Mu+B7zBseuGOYqeAv9DAk6cgL0
	 d0GUVDGMhAdwhThZ1ASmc5jFxodTJ8XbQDpVT/LId0f3oRszPGL3HDC5vSWJCCu2Lm
	 Rg+p+GUa8Irrfd+7qrP3wFKTWv5+z2GPMFfX8YB8pLQSCkxvx8PGDF8yfiN1CJHYuP
	 JFrSN4nd43mnrx6qSCzH13z2+1NWwY4Sc5RiWEIKkwsBN1HL5wnIU7AVNrtCoCnwX3
	 AovVJp9ssf2hg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y v3 2/2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  9 Oct 2026 06:40:07 -0700
Message-ID: <20261009134008.7127-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-165593@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 13:06:32 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: dangling charge_target_from pointer permanently freezes schemes
> --
> 
> commit a9baf64370898b2dec04fa2f17e4061166d6d27a
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit modifies damos_skip_charged_region() to clear the quota's
> charge_target_from pointer only when the last region of a target is
> reached, rather than clearing it unconditionally during previous charge
> checks.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1323,36 +1323,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  		struct damon_region *r, struct damos *s)
> >  {
> >  	struct damos_quota *quota = &s->quota;
> >  	unsigned long sz_to_skip;
> > +	bool skip = false;
> >  
> >  	/* Skip previously charged regions */
> >  	if (quota->charge_target_from) {
> >  		if (t != quota->charge_target_from)
> >  			return true;
> 
> [ ... ]
> 
> > +	}
> > +out:
> > +	if (r = damon_last_region(t)) {
> >  		quota->charge_target_from = NULL;
> >  		quota->charge_addr_from = 0;
> >  	}
> 
> [Severity: High]
> If the target tracked by quota->charge_target_from is dynamically
> destroyed via sysfs, or if it loses all of its regions, will this
> clearing logic ever be reached?

Good finding.  But this is pre-existing issue that also exist in the mainline
tree.  So not a blocker of this patch in my opinion.  I will separately working
on this.

> 
> If the saved target is removed or has zero regions, the region loop will
> be empty, meaning r = damon_last_region(t) is never evaluated for
> that target.
> 
> Since charge_target_from is never cleared in these scenarios, wouldn't
> this cause the condition earlier in this function:
> 
>         if (t != quota->charge_target_from)
>                 return true;
> 
> to remain true indefinitely for all other valid targets, permanently
> freezing the scheme? Additionally, if the target is freed, does this
> leave a dangling pointer comparison for future checks?
> 
> > -	return false;
> > +	return skip;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009123651.6585-1-sj@kernel.org?part=2
> 


Thanks,
SJ
