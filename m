Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034B484880
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764453; cv=none; b=JzV9G80nqFOVQmDjyq+sv/nM7UxFLq1sPNoKL95uw992lPXxedhcrXwZNd3+GxrKCNBYacdfvHkqYsKU5Houvs4Fj1RqU2FoxdYL5zqlVAaH5CJB0PSToOnfvLKxR50Z9y+PYsBtOh6ZUsHZk/y0sDP3ev1WZ+sMWKl6xIYEvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764453; c=relaxed/simple;
	bh=1bfy/y/Y3gXAIrwtD28le0TM7xqg3zspbUdtaotjq5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXog4nuDCrLDVIPXiiqs0Kj9Ys+XK65PTxXDcISEat2tkTD0A/IvWAeThCVJGel3WgBn4XR7NsNJa5P7+Hdt4pRdkHlk7i3q6YgljwPzGCP7hOKzjUcKZtV1cunipVuZy9/npDXbflLrnxshdlzAW50Zo5DcorFbWv8ZoYk/5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK1VwZB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK1VwZB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADCE1F00898;
	Wed, 30 Sep 2026 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764451;
	bh=WBR/KGIBzWQxi5xcXFstFTTuaakmunlg5er0/H/XffY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LK1VwZB6HLgQjNqSfMQ6tXmreJds5al0seqVPji00xN28SznEZU5uav/1o5EFPyWP
	 qfc1zcHBCDSdyjDPXFkHp0QNIUjKGdENmk29vW90Rwfuj/qlz0mtfv8W9EtTnlZav8
	 swhwcXucmyfLZM3eWpXOnd/WgwUnp49jvIMx3GzuKhhGJp49i+8+qIxCt5ZXmQTmKa
	 XpCRtyP+kkFganDHWbuF9SHUeKzbComHQe4QgzE9MtifVNInF04SySK6iLDwPt/HTa
	 TTBFY6+xrJoBZb4OoKqGEki00fVm4En6C9MDoBFhoS1+Y8PeqvMahzFlBvaIPVIMC/
	 NQh2Uq91qWCNg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: fix unconditionally skip last region
Date: Wed, 30 Sep 2026 03:34:07 -0700
Message-ID: <20260930103408.59035-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930102649.7B2AE1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 10:26:49 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: OOB dereference in damon_do_apply_schemes() on split failure
> --
> 
> commit 61e0ff2e7385bb544355d1f3aa3598f7f8e9e1d0
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit changes the logic in damos_skip_charged_region() to only reset
> charge_{target,addr}_from when the last region is reached. This is intended to
> ensure the last region is not skipped if it has not been fully processed.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 32737cc5f877b..cc7250f0936af 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1322,37 +1322,41 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  	struct damon_region *r = *rp;
> >  	struct damos_quota *quota = &s->quota;
> >  	unsigned long sz_to_skip;
> > +	bool skip = false;
> >  
> >  	/* Skip previously charged regions */
> >  	if (quota->charge_target_from) {
> >  		if (t != quota->charge_target_from)
> >  			return true;
> > -		if (r == damon_last_region(t)) {
> > -			quota->charge_target_from = NULL;
> > -			quota->charge_addr_from = 0;
> > -			return true;
> > -		}
> >  		if (quota->charge_addr_from &&
> > -				r->ar.end <= quota->charge_addr_from)
> > -			return true;
> > +				r->ar.end <= quota->charge_addr_from) {
> > +			skip = true;
> > +			goto out;
> > +		}
> >  
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
> >  		}
> > +	}
> > +out:
> > +	if (r == damon_last_region(t)) {
> 
> [Severity: High]
> If damon_split_region_at() fails to allocate memory, it returns silently and
> the region remains unmodified. If r happens to be the last region in the list,
> could damon_next_region(r) evaluate past the list boundary and return an
> invalid pointer?
> 
> Since this invalid pointer is assigned to *rp and the function continues to
> the out label, could it fail this (r == damon_last_region(t)) check, bypass
> the intended quota reset, and return false?
> 
> If so, could the caller damon_do_apply_schemes() then receive this invalid
> pointer and pass it to damos_valid_target():
> 
> mm/damon/core.c:damon_do_apply_schemes() {
>     ...
> 		if (damos_skip_charged_region(t, &r, s))
> 			continue;
> 
> 		if (!damos_valid_target(c, t, r, s))
> 			continue;
>     ...
> }
> 
> causing it to dereference garbage data (such as r->ar.start and r->ar.end) and
> potentially lead to an out-of-bounds memory access?

I will separately work on this.  Refer to my other reply to same issue report
for details.

[1] https://lore.kernel.org/20260930102333.58847-1-sj@kernel.org

> 
> >  		quota->charge_target_from = NULL;
> >  		quota->charge_addr_from = 0;
> >  	}
> > -	return false;
> > +	return skip;
> >  }
> >  
> >  static void damos_update_stat(struct damos *s,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260930101459.56041-1-sj@kernel.org?part=1


Thanks,
SJ
