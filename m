Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E71EB5CE
	for <damon@lists.linux.dev>; Sat, 10 Oct 2026 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791616359; cv=none; b=Nv7D7ETxcjKqUu4UGCoWQ4OxPPhlGhOy4UPO7LpFwsEypwgS2dGRtq3l8JA0uRIZLuIMkbuXvyX5X6zEvA6MjBn/676GPe0Nsf9OqoO9Dj4E4E5b4J31nAGHUiXqTaVeg2h3Rgt4YUmi2VoYfWCgdLkoKPyFg2SYOcbheFr1whA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791616359; c=relaxed/simple;
	bh=92cJgH57l6KPANafQRhoaj7cGqPWCyyTk/4yckUA9V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H23p4IBrGmpaQIhqZ+lHAsVZZzHftcV5UvoShB/NZmWb/U8ItpQOQrmfk7CLvE0lnouPz+/Zpn9vYkj1I8XvYQtsxOBLqRfoJfR5SP0XFl/pBnID5QtRBCUNH+/80h/sqh85V3ONXCCm74Z6reKmo55AIAh1J/taE2zg9ve0w5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYKKSAME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYKKSAME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D41F000FF;
	Sat, 10 Oct 2026 07:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791616357;
	bh=2uvZqISOIdtwlRbYj1HEXEe8sJv31Xpvqd8kRSBYyH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HYKKSAMEYr4TQxPP1Zzx4RUiCT9S33v7h1lpCYKeEO8sYRBFdtiCJfxA+3UCtdUq3
	 nMXLOmnQm+JR5NjUjElQ9P4oyiKuuEgGwIhVzniWAQgePJSqpx9dXsnbB/z2bd5X1t
	 EUdEaunBlQXDPr2bChI5tNwJyv++AIrC3fef3JwDwKIvaTBRwWDgLWoprY2i1NoicB
	 0bbZw/+WObksVELCYwIWWsGkjk35wkNIorGFOxJElYN4okyE1dTGxFQ0LHmU0tCDwn
	 LifOqx73pgwu89lEv6iJ8AMcSwhXrw9seP3SfMH7n+Jc0AqHJzA2z7jS9ltfnp208x
	 Dioo9TqJxkuUA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 6.1.y v3 2/2] mm/damon/core: fix unconditionally skip last region
Date: Sat, 10 Oct 2026 00:12:33 -0700
Message-ID: <20261010071234.9041-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-166285@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 10 Oct 2026 06:46:00 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: damon: use-after-free and permanent scheme disablement on target destroy
> --
> 
> commit c97d3ff78284ee81310d99deee85b79f32b561d5
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: fix unconditionally skip last region
> 
> Once quota set, the charge_{target,addr}_from unconditionally skips and
> resets at the last region of the tracked target, so the last region can be
> skipped even when it has not been processed.
> 
> Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index b5c85e6488596..1b9fb00405cfb 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -768,14 +769,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
> >  		if (quota->charge_target_from) {
> >  			if (t != quota->charge_target_from)
> >  				continue;
> 
> [Severity: High]
> Does this code have a use-after-free and permanent scheme disablement issue
> when a target is destroyed?
> 
> If the user dynamically removes a target via sysfs, damon_sysfs_set_targets()
> calls damon_destroy_target() which frees the target memory:
> 
> mm/damon/sysfs.c:damon_sysfs_set_targets() {
>         ...
> 		} else {
> 			if (damon_target_has_pid(ctx))
> 				put_pid(t->pid);
> 			damon_destroy_target(t);
> 		}
>         ...
> }
> 
> mm/damon/core.c:damon_destroy_target() {
> 	damon_del_target(t);
> 	damon_free_target(t);
> }
> 
> Existing schemes are updated in-place via damon_sysfs_update_scheme(), which
> does not clear the charge_target_from pointer, leaving a dangling pointer in
> the scheme.
> 
> Immediately after, when kdamond_apply_schemes() runs in the same thread,
> damon_do_apply_schemes() compares the valid remaining targets against this
> dangling pointer (if (t != quota->charge_target_from)). Since it does not
> match the remaining targets, it unconditionally executes continue, skipping
> the scheme for all regions.
> 
> Because a matching target is never reached, the pointer is never reset (the
> code cannot reach the clean_charge_from_skip label). This results in
> permanent disablement of the scheme and persistent use-after-free comparisons
> against the dangling pointer.

This is a pre-existing issue that also exists in the mainline.  I will
separately work on this.

> 
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
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261010063042.8611-1-sj@kernel.org?part=2


Thanks,
SJ
