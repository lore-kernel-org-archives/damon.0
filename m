Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BA484239
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764507; cv=none; b=bNc9n5pH7krngGvJQ8gsVM1hDyivJ9Bgf/X2oOJDpSaLQvn+FyVLfEteVoDnPsoyPWzGsj8gPFSzzRMqx9Ce7RAKpmQnc8ygzUhq4b7NsG80vzpsGUiw/+fBPfOiPaqU9qWJr7o0QSf9UagoyB2gEMkZHSMWN2Rmllzl6Z7r5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764507; c=relaxed/simple;
	bh=LR7gcfSZP1NpgNK6Y5r3NFioqjCYW7sKBX20nPW1AHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXypm1k0RcLrK0hjLSxXV30AQelf3fv7pGLxVdIWJHDlahGa9+HniSyYGqFj7ZtmPfaF0LexuvgCGLUNoV2fss74XwhAU3+puAOHAw+91QNRCrQTVxJfVIVvBJHXhX+VPp6g6NydKSv25UrE4SEiHc9gATRu7j7ktF9azRHAwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPpIJddi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPpIJddi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF71F000FF;
	Wed, 30 Sep 2026 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764506;
	bh=X67v4u1IhsDYEJZxQau1A61TNlKhjwuZg6iU1t2k6tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gPpIJddinz3kgtinvxst1UvzbOmyKIGLkHQzIFW4zL2bYWXkL+18EmaPQPdtFU8zX
	 CUJSY2by/787vvA3Usl7qQ8UId3RQ1ViS9TBK1CUUCzI2ueMCnQtn74ETyU6PWu2UF
	 XzHrYa4p3o844T38JkaTjGtHYji3GdnB3HX1ceEXx3u3EW9nWlgiq8sshwDOptqxtp
	 kZpHLLODNwtk3tO/yv5hv5mRPYqJyjmuo3/UV9e/zrNNS6lSAQSLHHMlcPyETZ9+IK
	 Qhkj1eLn0C5yd1vmgCwxcF2kiTyexWAP5P24CrjIMXqwl9PadEHyuaPc+q708eofBe
	 VskKDKpMKZ0CA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.6.y v2] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:35:01 -0700
Message-ID: <20260930103502.59178-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930103150.9890A1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 10:31:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: list head type confusion and memory corruption on allocation failure
> --
> 
> commit 47762d8f5b1f74489d2b1ca149de65b77ac867a2
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> Once quota set, the charge_{target,addr}_from unconditionally skips and
> resets at the last region of the tracked target, so the last region can be
> skipped even when it has not been processed. Fix this by only resetting
> the charge_{target,addr}_from when last region is reached, only skipping
> when it is applied or cannot split.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0713fda22682c..c31683c12dd48 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -883,37 +883,41 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  	struct damon_region *r = *rp;
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
> >  		if (quota->charge_addr_from && r->ar.start <
> >  				quota->charge_addr_from) {
> >  			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> >  					r->ar.start, DAMON_MIN_REGION);
> >  			if (!sz_to_skip) {
> > -				if (damon_sz_region(r) <= DAMON_MIN_REGION)
> > -					return true;
> > +				if (damon_sz_region(r) <= DAMON_MIN_REGION) {
> > +					skip = true;
> > +					goto out;
> > +				}
> >  				sz_to_skip = DAMON_MIN_REGION;
> >  			}
> >  			damon_split_region_at(t, r, sz_to_skip);
> >  			r = damon_next_region(r);
> >  			*rp = r;
> > +			skip = false;
> 
> [Severity: High]
> If damon_split_region_at() fails to allocate memory for the new region, it
> silently returns without splitting. When r is the last region,
> damon_next_region() wraps around to the list head, resulting in an invalid
> struct damon_region pointer. Can this cause an invalid pointer to be
> assigned to *rp?
> 
> >  		}
> > +	}
> > +out:
> > +	if (r == damon_last_region(t)) {
> >  		quota->charge_target_from = NULL;
> >  		quota->charge_addr_from = 0;
> >  	}
> > -	return false;
> > +	return skip;
> >  }
> 
> [Severity: High]
> If the allocation failed and r evaluates to a bogus list head pointer, this
> check for damon_last_region() will fail. The function will then return
> skip = false, causing the caller in damon_do_apply_schemes() to proceed
> with the invalid pointer.
> 
> Could this lead to out-of-bounds reads in damos_valid_target() and
> out-of-bounds writes in damos_apply_scheme() when the pointer is
> dereferenced?

I will separately work on this.  Refer to my other reply to same issue report
for details.

[1] https://lore.kernel.org/20260930102333.58847-1-sj@kernel.org

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930101853.58786-1-sj@kernel.org?part=1


Thanks,
SJ
