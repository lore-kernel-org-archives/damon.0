Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043B379C5D
	for <damon@lists.linux.dev>; Fri, 22 May 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779480674; cv=none; b=N+cHnWnZEmDEFVfTqi4Ebf/q65q1X7TYwyMEnUcsP2lNaVqtAtjQVA8BTRDvJUKcYzVXcsReYPnEyHqS7Wl7fqeuXZbXazndO0d5ZrF9BGha6IlcCGL4Mma9rAI+pLfCj1jdWUPu2dD3gPD0BWjcXP+l0NAlrDXZDtbpdmvQJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779480674; c=relaxed/simple;
	bh=LL5TaqSX19yN5YAi6+vEFjAdv7huR9JYIAj7UtLKwN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRlQF+xQWbGA4pmCcu/L6MuolDm3T3SrjM0ZOfBII1B/W5LfumRZvhF5UXZAAC2tv9+Rnk3erA8yO0GgfWqTxYmWl+D6RUL7Sf4vENLXZLFp99HnY5qa9kgy1o1Cp/Mm0IwrbAxNoGFiQAQUy3BVvja3H/NXrgcwXQ4/sWZR/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RadBjBGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RadBjBGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC681F000E9;
	Fri, 22 May 2026 20:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779480672;
	bh=TO+0KMjxIGjqqlVaovs0ksC7t2d729Fd+EfklEJ9FiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RadBjBGkG2MyDZbrUSVn5DpWd8hzebcXnJWISkiMeGpHnWdIiCsKkOdWcfkfg0SqJ
	 Rsy+pyTT8ANf8G7Z0FLhAToBuE2nziNMM3u9y7FTDCrtE3nQtuqZjvp9Xw6QsuKOrw
	 qNjUv84aMvKnpnSvWgzt2OF/HO8u2Ero2aIl/67h9bWV4Eh6bAo4caZFE3efVJ1pgR
	 UmZmCZq0w3Deu33Qtx43A7sRj7AGi3zee81Ci4J86rll/ekMvX0jN9FU8dl602kmbU
	 jldeRpjvQe6LibOgAAqygKdYC4xmbb0hRg5AyxgaBJl3+blUnEPTph2XhLzEQ0mVVi
	 dV4tRLh69n/fQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 08/14] mm/damon/core: add kdamond_call() debug_sanity check
Date: Fri, 22 May 2026 13:11:10 -0700
Message-ID: <20260522201111.3319-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522175515.0CADA1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 May 2026 17:55:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Calling damon_nr_regions() instead of accessing t->nr_regions directly causes completely redundant O(N) list traversals and duplicate warnings.

No blocker.  Read below for more details.

> --
> 
> commit 97b7c0b9ade3ed697ef1eba39c981f58994bd0bd
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: add kdamond_call() debug_sanity check
> 
> This commit introduces a new debugging check, damon_verify_ctx(), which
> runs under CONFIG_DAMON_DEBUG_SANITY. It is called from kdamond_call() to
> ensure the DAMON context state is valid before proceeding.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index d816679dd7020..00e2997524ece 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3329,6 +3329,37 @@ static void kdamond_usleep(unsigned long usecs)
> >  		usleep_range_idle(usecs, usecs + 1);
> >  }
> >  
> > +#ifdef CONFIG_DAMON_DEBUG_SANITY
> > +static void damon_verify_ctx(struct damon_ctx *c)
> > +{
> > +	struct damon_target *t;
> > +	struct damon_region *r;
> > +
> > +	damon_for_each_target(t, c) {
> > +		struct damon_region *prev_r = NULL;
> > +		unsigned int nr_regions = 0;
> > +
> > +		damon_for_each_region(r, t) {
> > +			WARN_ONCE(r->ar.start >= r->ar.end,
> > +					"region start (%lu) >= end (%lu)\n",
> > +					r->ar.start, r->ar.end);
> > +			WARN_ONCE(prev_r && prev_r->ar.end > r->ar.start,
> > +					"region overlap (%lu > %lu)\n",
> > +					prev_r->ar.end, r->ar.start);
> > +			prev_r = r;
> > +			nr_regions++;
> > +		}
> > +		WARN_ONCE(damon_nr_regions(t) != nr_regions,
> > +				"nr_regions mismatch: %u != %u\n",
> > +				damon_nr_regions(t), nr_regions);
> 
> [Severity: Low]
> Does this code perform unnecessary list traversals and cause duplicate warnings?
> 
> Since damon_nr_regions() internally calls damon_verify_nr_regions() which
> performs its own O(N) list traversal and issues its own WARN_ONCE on mismatch,
> using it here results in traversing the list multiple times.
> 
> It also causes multiple warnings for the exact same mismatch.

Correct.  And therefore the next patch is removing damon_verify_nr_regions().

> 
> Would it be better to compare against t->nr_regions directly to avoid the
> redundant traversals and duplicate warnings?

For the above reason, no.


Thanks,
SJ

[...]
