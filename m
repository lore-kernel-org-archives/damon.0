Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1274E532F
	for <damon@lists.linux.dev>; Fri,  9 Oct 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558668; cv=none; b=rYBntsJP84PSHG1UE0CVH8SmGqka5ezawAgjhjKbOV6Lu05Qh7Yd4gG4657p+n3EGwK6piwAXfTzaFc9lcWXD5xOj6PlEZ/0v2rtAKFOvm/x7LsPKuPkvAEoCZQf4JHBZ2x6P3pN7wUfOXgVYkDzkdnjgAaonbXBamwFBO076SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558668; c=relaxed/simple;
	bh=eYiCqx/HFkzE0Se5IunNtqYsZV5Ig1LOnYyui9fX9YM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYDs9CM88yCjAIvF4ICZKOzu3Z2+4c7u7rysneDIAw5bhG/JF4gdKd3NKUtr9C3kUwGTvOLRuQ4L9XYdwJZip6XosP0TkfbrEZqL2hcOQblhNCZFVHtd1IxBdBdM+TKyxjae12BrjiJEKJUnfNpD/bw1mb5VFkPOjc2yEl4tOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mhj0+jZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mhj0+jZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940321F000FF;
	Fri,  9 Oct 2026 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558665;
	bh=Jyqebpk9e16O/Jb2XOl+klHyElm652RdlZr0Gnc9oF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mhj0+jZUk19+29N4oE2NjgtVhs4vDERHIZPVP2M08tR5MQJJMEVb6QATA7w6Qy8SJ
	 CGE5jaZ3C/eY4SX372iKDS5XHIBQxO3KKb5nreD5n7lomJ2pXwmeYrPBm5Y1IqaxyT
	 lWP2y6pLHD3lPoMdvK7ovsiN7IIazSU1RCxEb3QWtw+E9rW2cA5ZYnUEqlh1vPWQ6N
	 ioP2gDYFokju5VlBeUDZGj/nw2IImVf5p9Yj09toeDqzEbaMTS2JEpy6AogKRNF/da
	 BuPkFHN/R1VXSJl1vRzwj4XlVXboyRdk+0fFH3PJgv4M2F3H0onPfhZjfOOWCF6+Mm
	 vV06qlzuRlffQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y v2 2/2] mm/damon/core: fix unconditionally skip last region
Date: Fri,  9 Oct 2026 08:11:01 -0700
Message-ID: <20261009151102.2792-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-165748@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 09 Oct 2026 15:04:56 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/damon: Out-of-bounds access due to unchecked split failure on last region
> --
> 
> commit aacf3c387b1624c2944e2e5044dad18623db3d5f
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> This commit modifies the quota mechanism in DAMON to only reset the charge
> target and address from when the last region is reached. It ensures the last
> region is not skipped if it has not been processed.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c65d2cbeea6b5..f2f6f125c09b1 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -768,14 +769,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  		if (quota->charge_target_from) {
> >  			if (t != quota->charge_target_from)
> >  				continue;
> > -			if (r == damon_last_region(t)) {
> > -				quota->charge_target_from = NULL;
> > -				quota->charge_addr_from = 0;
> > -				continue;
> > -			}
> >  			if (quota->charge_addr_from &&
> > -					r->ar.end <= quota->charge_addr_from)
> > -				continue;
> > +					r->ar.end <= quota->charge_addr_from) {
> > +				skip = true;
> > +				goto clean_charge_from_skip;
> > +			}
> >  
> >  			if (quota->charge_addr_from && r->ar.start <
> >  					quota->charge_addr_from) {
> > @@ -783,17 +781,25 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  						r->ar.start, DAMON_MIN_REGION);
> >  				if (!sz) {
> >  					if (damon_sz_region(r) <=
> > -					    DAMON_MIN_REGION)
> > -						continue;
> > +					    DAMON_MIN_REGION) {
> > +						skip = true;
> > +						goto clean_charge_from_skip;
> > +					}
> >  					sz = DAMON_MIN_REGION;
> >  				}
> >  				damon_split_region_at(t, r, sz);
> >  				r = damon_next_region(r);
> >  				sz = damon_sz_region(r);
> 
> [Severity: High]
> Since this commit removes the check that bypassed damon_split_region_at() for
> the target's last region, does this introduce an out-of-bounds access if
> memory allocation fails?
> 
> If the last region overlaps the charge boundary, it is now passed to
> damon_split_region_at(). This function performs a non-blocking memory
> allocation that can fail under memory pressure and return silently without
> splitting the region:
> 
> mm/damon/core.c:damon_split_region_at() {
>     new = damon_new_region(r->ar.start + sz_r, r->ar.end);
>     if (!new)
>         return;
>     ...
> }
> 
> If the allocation fails when processing the last region, the region is not
> split. The code then unconditionally executes:
> 
>     r = damon_next_region(r);
>     sz = damon_sz_region(r);
> 
> Because r was the last region and wasn't split, damon_next_region() reads
> the list.next pointer which points back to the list head:
> 
> include/linux/damon.h:damon_next_region() {
>     return container_of(r->list.next, struct damon_region, list);
> }
> 
> This produces an out-of-bounds pointer derived from the list head. When this
> pointer is immediately dereferenced by damon_sz_region(r), could this
> regression result in out-of-bounds memory reads?

Good finding.  Patch 1 should avoided this issue by removing the safe iterator
workaround, but I mistakenly didn't remove the workaround.  I will fix it in
the next spin.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261009144808.18317-1-sj@kernel.org?part=2


Thanks,
SJ
