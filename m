Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C71F4F1
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395047; cv=none; b=MMUKOOUsiuiY7KQEfiVnJ7S+R6K/052sqSU5NH0NkeHz22XxTij34XrmCSJeD15JkKIXES0sYchj/GkCYqt1qR66NFAKekNL2YPw7Ac1I2TErDuJLdrts8JRhuBcQcSDHACBg6rHimTzKuGdJsO3VNOnqdnvHfo2piXfb40ogIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395047; c=relaxed/simple;
	bh=H8ydP1yko4nyzYxX3j0us5ZmIlUxEDOjm+WszIK0upY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmBx0GdCnpjIPmhVQkpM9CGt8k10DvGvcAS1ty6FXbSC2cNfEl2XoZwWTYuvbrU6hPgSXA87X+dXbaQIQNmRjPRUh0pItgLJioamgOOWJc/JJm8BDM4/H65iyVg+SVuDvYvtxnb6r0xRrt+o8cEpLOGUkXhD1r8asGbjwU6rjrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8zI+KTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8zI+KTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C6C1F00A3A;
	Tue,  7 Jul 2026 03:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783395045;
	bh=M75izGIAD67lwfhzLq4dsZs5fs4NmJeoksxiQ+OgA5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8zI+KTXe2A2FaG2axNDJR4jYttChRd/SSA8W9BNxSOHZX67hh3pw3+eeH9Aa8kp0
	 CfPWZV8zfUPHlPro1US2awjiQfdfASeSSMJ8CpyXKOMnoaDbVu0p9mD6pM9UvUmDI0
	 3DlEdMtMiVKJa0VCVsidzimJXaV+zvfpwg1mmKA/QVTgAStyP6sf+OKGXuJn7ZcvVk
	 BlBryVvraN4wFxDl1LsYloaodkoMXWrG0jxlj1jR9qO2OeAswOsLgN43yLSmlRObRZ
	 VNsM28wnxKcrP73+82iWCyYe0NmFyFVbDoRe+aFtsRi5QriO5nB7gkpQOaVwAFvUfU
	 WouzT0uXddlyw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 07/16] mm/damon/core: extend merge function to work with probe hits
Date: Mon,  6 Jul 2026 20:30:23 -0700
Message-ID: <20260707033024.91856-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706235215.97085-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  6 Jul 2026 16:52:00 -0700 SJ Park <sj@kernel.org> wrote:

> On Mon, 06 Jul 2026 14:55:38 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] API Misuse / Silent Overflow: Using `abs()` on the difference of two large unsigned integers causes incorrect results.
> > - [High] Integer Overflow: `damon_probe_hits_wsum()` wraps around the 32-bit boundary when large weights are used.
> > --
> > 
> > commit b2b82783307a6d10c78010502dd30f5168036627
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/core: extend merge function to work with probe hits
> > 
> > When probe weights are set, this commit extends damon_merge_regions_of() to
> > work with the weighted sum of probe hits. It also introduces a placeholder
> > detection function to allow safe incremental changes.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 42f27849af722..7aff741d43bd4 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > 
> > [ ... ]
> > 
> > > @@ -3230,6 +3235,16 @@ static void damon_merge_two_regions(struct damon_target *t,
> > >  	damon_destroy_region(r, t);
> > >  }
> > >  
> > > +static unsigned int damon_merge_score(struct damon_region *r, bool last,
> > > +		struct damon_ctx *ctx, bool use_probe_hits)
> > > +{
> > > +	if (use_probe_hits)
> > > +		return damon_probe_hits_wsum(r, last, ctx);
> >                  ^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > [Severity: High]
> > Does this code wrap around the 32-bit boundary when large weights are used?
> > 
> > Looking at damon_probe_hits_wsum(), it accumulates probe_hits[i] * probe->weight
> > into a 32-bit unsigned int sum:
> > 
> > mm/damon/core.c:damon_probe_hits_wsum() {
> >     ...
> >     unsigned int sum = 0;
> >     ...
> >         if (last)
> >             sum += r->last_probe_hits[i++] * probe->weight;
> >         else
> >             sum += r->probe_hits[i++] * probe->weight;
> >     ...
> >     return sum;
> > }
> > 
> > If a user configures a large weight (e.g., > 16,843,000) for a probe via
> > sysfs, this could wrap around (e.g., 255 hits * 40,000,000 weight = 10.2
> > billion, which wraps to ~1.6 billion).
> > 
> > Could this break the scoring mechanism, causing damon_merge_regions_of() to
> > merge active and inactive regions incorrectly?
> 
> Known low priority issue.  No blocker.
> 
> > 
> > > +	if (last)
> > > +		return r->last_nr_accesses;
> > > +	return r->nr_accesses;
> > > +}
> > > +
> > 
> > [ ... ]
> > 
> > > @@ -3238,24 +3253,37 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
> > > -				   unsigned long sz_limit)
> > > +		unsigned long sz_limit, struct damon_ctx *ctx)
> > >  {
> > >  	struct damon_region *r, *prev = NULL, *next;
> > > +	bool use_probe_hits = damon_has_probe_weights(ctx);
> > >  
> > >  	damon_for_each_region_safe(r, next, t) {
> > > -		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
> > > +		unsigned int score, last_score;
> > > +
> > > +		score = damon_merge_score(r, false, ctx, use_probe_hits);
> > > +		last_score = damon_merge_score(r, true, ctx, use_probe_hits);
> > > +
> > > +		if (abs(score - last_score) > thres)
> >                    ^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > [Severity: High]
> > Can this call to abs() cause incorrect results due to silent overflow?
> > 
> > Since score and last_score are unsigned integers, abs(score - last_score)
> > casts the unsigned difference to a signed int.
> > 
> > If the actual difference exceeds the maximum signed integer value, it wraps
> > to a negative value, which abs() then negates into a smaller positive value.
> > 
> > Could this falsely small difference cause the threshold check > thres to fail
> > incorrectly, allowing vastly different regions to be merged and affecting the
> > accuracy of the monitor?
> 
> Same issue exists for the above abs() call.  User impact is minor and I'm
> separately working [1] on it.

Now I think this has no reason to fix right now.  I'll fix it in the next
revision.


Thanks,
SJ

[...]
