Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A92441B8
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091537; cv=none; b=jd79av9lg1prV39cIztchdhgSYGEXuLqeF3SmguDxkwiAsgGWPwuN6d4hEE3S3YlmXQpl2B9e39vQXiEitZziJ3PMCQwhvXpPC0zZjmKSJARx7kGg12kfBPkfLMROF4+sl1YyoWi4batsDKIj8Ek5Zu6WxvdPiQdlF2hG+uBOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091537; c=relaxed/simple;
	bh=yZOhnHUEKpijGqyTGgVsot3HzYZoPpFnAHqRk6+gtDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdb8tbDs02fjcMM4olDjutlYuMIxjggPcGimIj/qREzeL+BzEptWeUYCRiC0/Wq0iAbGL3harUBqo7FgFnbNp6wg8XcP81V8WH6heQ97SPo+ADjxyx1/PFSWIZzKY69y58A1rjVLhjmQvNXswK13eDp5tgPHW66EiSmIpXbuwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyS0fIj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyS0fIj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEC91F000E9;
	Sun, 26 Jul 2026 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785091535;
	bh=sQY1rB68FOJesXE8EJ9gs76SEq773vuOc46wA+z4GEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dyS0fIj0XZAxpoAjs+235KR01Fq0LhLh3IV7XnuwPT045RoOyCQfO0yasKhyOKOqe
	 1FF0+r1rPrJZfE/2OTGSzQOlMYkEQg+sHMH3AgYJ1THj9hGEBebiXOCSB9G2MMp6q2
	 QqqhTi94Pr0H1C+LUO4uiP19+Qdsi04Gm6ndOBWFAbA3/pSSAaVgVl6WY6UTDTTZdy
	 N3dQA06lJIOXjytsnDZnVfx6lTXFIGx7jN2dg1fSZJnJ08Wn4RFfCclT1DtHx7qYr5
	 nxjMexHD6/C9TLP1GlXPqdZzaIMLmpDDMo16pFrWQ9gJtQy2t4GmSBVJgyzeMPEeMj
	 +abOgjQYcOgVQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 05/17] mm/damon/core: introduce damon_prep struct
Date: Sun, 26 Jul 2026 11:45:26 -0700
Message-ID: <20260726184527.1622-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726175228.3CD7A1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:52:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing synchronization of the `preps` list during DAMON context commit operations.
> - [Low] The parameter names in `damon_for_each_prep` and `damon_for_each_prep_safe` are reversed compared to their semantic meaning.
> --
> 
> --- Patch [5]: [RFC PATCH v2 05/17] mm/damon/core: introduce damon_prep struct ---
> commit 9f7bafc6bbe2ee2b7391d751512d413fcf3bdf98
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_prep struct
> 
> This commit introduces a new data type damon_prep to specify preparation
> actions for DAMON probes. It adds lists and iteration macros for these
> actions, as well as an initial action DAMON_PREP_SET_PGIDLE.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index a8bb9ee6979e3..24b362fcf53b1 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -780,6 +801,8 @@ struct damon_filter {
> >  struct damon_probe {
> >  	unsigned int weight;
> >  /* private: */
> > +	/* Preparation actions to apply to each probing memory. */
> > +	struct list_head preps;
> >  	/* Filters for assessing if a given region is for this probe. */
> >  	struct list_head filters;
> >  	/* Siblings list. */
> 
> [Severity: Medium]
> Since this patch introduces the preps list to struct damon_probe, should
> damon_commit_probes() in mm/damon/core.c be updated to synchronize this new
> list?
> 
> Currently, damon_commit_probes() copies probe parameters and filters, but
> it appears to omit the preps list. If a context is updated via
> damon_commit_ctx(), wouldn't any configured preparation actions be silently
> dropped for new probes, and existing probes fail to update their preps lists?
> 
> For example:
> 
> mm/damon/core.c:damon_commit_probes() {
>     ...
>     damon_for_each_probe_safe(dst_probe, next, dst) {
>         ...
>         err = damon_commit_filters(dst_probe, src_probe);
>         ...
>     }
> 
>     damon_for_each_probe_safe(src_probe, next, src) {
>         ...
>         new_probe = damon_new_probe();
>         ...
>         err = damon_commit_filters(new_probe, src_probe);
>     }
>     return 0;
> }

A later patch of this series does that.

> 
> [ ... ]
> 
> > @@ -959,6 +982,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
> >  	return r->ar.end - r->ar.start;
> >  }
> >  
> > +#define damon_for_each_prep(p, prep) \
> > +	list_for_each_entry(p, &(prep)->preps, list)
> > +
> > +#define damon_for_each_prep_safe(p, next, prep) \
> > +	list_for_each_entry_safe(p, next, &(prep)->preps, list)
> > +
> 
> [Severity: Low]
> Are the macro parameter names here reversed compared to their semantic meaning?
> 
> The parameter 'p' is used as the list iterator (which represents a prep), and
> 'prep' is used as the parent structure (which represents a probe). This differs
> from the convention used in damon_for_each_filter(f, p). 
> 
> Will this force usage like damon_for_each_prep_safe(prep, prep_next, p), which
> could be confusing to callers?

Good catch!  I will s/prep/probe/ like below.

'''
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1123,11 +1123,11 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
        return r->ar.end - r->ar.start;
 }

-#define damon_for_each_prep(p, prep) \
-       list_for_each_entry(p, &(prep)->preps, list)
+#define damon_for_each_prep(p, probe) \
+       list_for_each_entry(p, &(probe)->preps, list)

-#define damon_for_each_prep_safe(p, next, prep) \
-       list_for_each_entry_safe(p, next, &(prep)->preps, list)
+#define damon_for_each_prep_safe(p, next, probe) \
+       list_for_each_entry_safe(p, next, &(probe)->preps, list)

 #define damon_for_each_filter(f, p) \
        list_for_each_entry(f, &(p)->filters, list)
'''

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=5


Thanks,
SJ
