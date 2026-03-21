Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338C37104C;
	Sat, 21 Mar 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774124946; cv=none; b=d35zN6LcLSMjd2hym8hUogojQYQQXlP1KGO/8kfJdyY6KulQ7NWjkvuxFnh+1Sqkw5RURolpcRNTlUyxxXNwZn+xRWTr49ORj0Fgc27BZjGR/QvRV7AK2Cut42VDOUssFLQfq/1cwFsKYqb7IDS1IZd0bApogBCcnqP3dGQTfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774124946; c=relaxed/simple;
	bh=pRwILIX3KtOIImm5AyQGnriwJEWKQev29KIeh07Ao6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0RRk2j4evchqRkGXvkrXVWkkYLIxXwKpqb7kJOrGlQl5mINkizodYY2+9NJBhKnSW9lru+zeibfMtSFX4/sV7tofdBPl8Pk1QUzbW090DCDv3UUITegiJxbDolidIhuLRE0XjpJQwPeblyMpS1HibjsK7XNjMovQ2WPfvAuBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FouJrfed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FouJrfed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3EBC19421;
	Sat, 21 Mar 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774124946;
	bh=pRwILIX3KtOIImm5AyQGnriwJEWKQev29KIeh07Ao6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FouJrfed1pwy9nvl1DRzj+ufp45PuWXfDkQimBm/hshPMIm6fgqjbMAriM1WZYe2w
	 JupM2Q2mN6abupwc4p49LDMV3qLvwefIB1ZBXu5GxaBru2PJ11nkzJDFRJgFG1eCDg
	 gvUfze+1Z6X8gmZcvLunMctuI5O/Jvdu6Xzl/bpvxbaPAcq81y+qZxf74L+k8nD5+S
	 fkym5RbEaEmKy7FHH7Z3Nkye8a3pOQv1MpJRrO8+frEajwM3YenGa/vkf4j7COEhyU
	 TBeMHhJdCFedNv37of8mLrGUejCU6y87iC9JmunxKpCjxduK7ScjTjQvtzieKoZeIN
	 E+iW3Os9BEGiQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko) [PATCH 01/10] mm/damon/core: introduce damon_ctx->paused
Date: Sat, 21 Mar 2026 13:28:57 -0700
Message-ID: <20260321202858.98091-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321201205.95756-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: I think this needs a few changes.  That can be a fixup (picked by
Andrew) or respin for v2.

On Sat, 21 Mar 2026 13:12:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding Sashiko review for doing discussions via mails.
> 
> # review url: https://sashiko.dev/#/patchset/20260321181343.93971-2-sj@kernel.org
> # start of sashiko.dev inline review
> commit b56d17c42c1dc6d883f3a75d785a05ba53b5c35b
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_ctx->paused
> 
> This commit introduces a paused parameter to the DAMON context API.
> It allows users to pause and resume kdamond execution while preserving
> self-trained data. The main loop is updated to perform limited work
> and sleep when the context is paused.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index db6c67e52d2b..ce010009ca13 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3003,6 +3004,14 @@ static int kdamond_fn(void *data)
> >  		kdamond_call(ctx, false);
> >  		if (ctx->maybe_corrupted)
> >  			break;
> > +		while (ctx->pause) {
> > +			if (kdamond_need_stop(ctx))
> > +				goto done;
> > +			kdamond_usleep(ctx->attrs.sample_interval);
> 
> This isn't a bug, but polling with kdamond_usleep() using the sample
> interval could cause many wakeups per second even while the context is
> paused. Would it be more efficient to use a waitqueue here to consume
> near-zero CPU until the thread is explicitly woken?

sample internval is 5ms by default and recommended auto-tuning setup makes it
hundreds of milliseconds.  So I don't think such change is required.

> 
> > +			/* allow caller unset pause via damon_call() */
> > +			kdamond_call(ctx, false);
> 
> If a parameter update fails during kdamond_call() and sets
> ctx->maybe_corrupted to true, the loop will continue to run or exit the
> pause loop and proceed to kdamond_apply_schemes() with corrupted
> structures.
> 
> Is it possible to bypass the corruption safeguard here? Should we check
> ctx->maybe_corrupted inside this loop to safely terminate the thread?

Good finding.  I will add that in the next spin.

> 
> > +			damos_walk_cancel(ctx);
> 
> If kdamond_call() processes a request that unpauses the context, this
> will immediately cancel any pending or concurrent damos_walk() requests
> before the loop condition is re-evaluated.
> 
> Could this cause spurious cancellations of walk requests when unpausing
> the context?

As I replied in the previous patch, that can happen and fine.  Users can do the
walk again in the case.  But, now I agree it may better to reduce such spurious
failures if it can be done in a simple way.  And seems it can be.  Just doing
this before the sleep.

> 
> > +		}
> >  		if (!list_empty(&ctx->schemes))
> >  			kdamond_apply_schemes(ctx);
> >  		else
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260321181343.93971-2-sj@kernel.org

So, I think below attaching fixup is needed.  Unless Andrew picks it up
together, I will post v2 tomorrow.


Thanks,
SJ
=== >8 ===
From 9b07cde80e61bb4cc7a559a62465dd0ee6e2b945 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 21 Mar 2026 13:22:52 -0700
Subject: [PATCH] mm/damon/core: fixup: care corruption and cancel damos_walk()
 immediately

As Sashiko suggested and I agreed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce010009ca136..0ab2cfa848e69 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3005,12 +3005,12 @@ static int kdamond_fn(void *data)
 		if (ctx->maybe_corrupted)
 			break;
 		while (ctx->pause) {
-			if (kdamond_need_stop(ctx))
-				goto done;
+			damos_walk_cancel(ctx);
 			kdamond_usleep(ctx->attrs.sample_interval);
 			/* allow caller unset pause via damon_call() */
 			kdamond_call(ctx, false);
-			damos_walk_cancel(ctx);
+			if (kdamond_need_stop(ctx) || ctx->maybe_corrupted)
+				goto done;
 		}
 		if (!list_empty(&ctx->schemes))
 			kdamond_apply_schemes(ctx);
-- 
2.47.3


