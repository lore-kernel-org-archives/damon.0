Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792954133;
	b=MqIyhqz+l2mLIxO1kRxpD7vGGxWB/FWcjGwfZ1s61ZGosI46tlDeA4EItyr8HIpAiPjF
	 5NVGLos2YPRxOxSIUa2Gxs+Mr4kBQZKNwKbL3+7ENHPp6VtK87xhKc7AMk7HxIPhxuAS3
	 89a4AlUPdBxaLIHBVUEFBKT4frVoWavF4chlU7piTPxikdUJxtMB9mWziYfVxv9Ci3PfM
	 +6O1kfVPPJJEIhSzzXbz/uOO8lkL2NfLbP+JHjJcFVwPOsrKu4FPh5OeWhLwDgIUps+xk
	 ChlN4qqJfHdU7M43vhdaybzTF/x17V1b2zxxI9WwPSjYI94wa88v35Tlem/lY0te9GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792954133;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pznFzyD5BxdTzOagRh9mbfazQSSMPDVThvsWbVF1d2o=;
	b=5lRoJ0PbHA3naQgH2b4Wg3bowbPnP2QZemniJNEw3gZo8o0yDjiv4nyWZtnR7mClK64K
	 t2qIawgVPzq7e24sUyiOjXpFZwLxUc0OthfCg8pgcEik3n1IS7pZneoBa6I37iZMCMydb
	 NKYqsvSX75YAbwyeZoSxrpic17OwNZIRPL+tP4+AQevsMwtN9oGNI5CwwXNMyMMpB9pjn
	 opTB2ixgIzENAw+80OBV0YHjTlfaMQoYz+g/Hi+k4cSwDVpvysm4hlcAlUOKJDbKB+N2/
	 HSPOaNZmG3HlGoSa7HkfuJPP5KJ8kcmerK+adMHzhsSl3DI4D3ButZ/ut4/z0z/WZGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EckPO1La;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1FC606A31A
	for <damon@lists.linux.dev>; Sun, 25 Oct 2026 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EckPO1La
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440141F01825;
	Sun, 25 Oct 2026 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792954132;
	bh=pznFzyD5BxdTzOagRh9mbfazQSSMPDVThvsWbVF1d2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EckPO1LaGYCz5T1lsTmZB4ujCWnoneGjVwZa4Fzod0L6bvuhXJfas33aw9cVtrB5Y
	 HDzedltEPbA3IhM3selq/hdYJt+dJ+mWyKfTya3s6u4xcbBHPoZUuO47Op5IRkRYKu
	 kX58KeQNFraZQTfKmfTgSF2twEAdzTL1WCWoMJgs/flJjDcN+lAyPt8duadT8Zkz6/
	 Nb8ePXKPhdnZ+GJ9qZ01vyAMgiotG8PGKIskZ3U8uGn9WsO3I1H/a7Dv30JRp7uwbH
	 tIIrnVXxu858Jte3vz4qDIB/NkYan8V5lOM/IZqcf1jXeWe6/umWffMz/FjiAnNs/z
	 kGPSjjEujF6uw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.12.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Sun, 25 Oct 2026 11:48:43 -0700
Message-ID: <20261025184845.190103-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-184343@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 25 Oct 2026 18:33:53 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] mm/damon/sysfs: ctx memory leak in damon_sysfs_turn_damon_on()
> - [Low] mm/damon/sysfs: unknown member targe_value in damon_sysfs_valid_start_ctx()
> --
> 
> commit 1635d9f393d64d22688141e9540fde6f98f5d6bb
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: error damos_commit_quota_goal() for zero target_value
> 
> This patch rejects zero target_value in DAMOS quota goals during parameter
> commit in damos_commit_quota_goal() and damos_commit_quota_goals() to avoid
> division-by-zero errors. For this stable backport, it also adds a validation
> helper before damon_start() in damon_sysfs_turn_damon_on().
> 
> Link: https://lore.kernel.org/20260903010722.94244-1-sj@kernel.org
> Link: https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org
> Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 5aa23c6545cb8..7895b11555d06 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1497,6 +1497,20 @@ static struct damon_ctx *damon_sysfs_build_ctx(
> >  	return ctx;
> >  }
> >  
> > +static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
> > +{
> > +	struct damos *s;
> > +	struct damos_quota_goal *g;
> > +
> > +	damon_for_each_scheme(s, ctx) {
> > +		damos_for_each_quota_goal(g, &s->quota) {
> > +			if (!g->targe_value)
> > +				return false;
> > +		}
> > +	}
> > +	return true;
> > +}
> 
> [Severity: Low]
> Will mm/damon/sysfs.c fail to build in damon_sysfs_valid_start_ctx() due to
> referencing g->targe_value instead of g->target_value?

Nice catch.  My build test was somehow configured to disable DAMON_SYSFS.  I
will fix this in the next spin.

Also, my build test found an issue in macro expansion after fixing the config.
I will add below change for the two build issues.

'''
@@ -1503,8 +1503,8 @@ static bool damon_sysfs_valid_start_ctx(struct damon_ctx *ctx)
        struct damos_quota_goal *g;

        damon_for_each_scheme(s, ctx) {
-               damos_for_each_quota_goal(g, &s->quota) {
-                       if (!g->targe_value)
+               damos_for_each_quota_goal(g, (&s->quota)) {
+                       if (!g->target_value)
                                return false;
                }
        }
'''

> 
> In include/linux/damon.h, struct damos_quota_goal defines this field as:
> 
> struct damos_quota_goal {
> 	enum damos_quota_goal_metric metric;
> 	unsigned long target_value;
> 	unsigned long current_value;
> 
> > +
> >  static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
> >  {
> >  	struct damon_ctx *ctx;
> > @@ -1517,6 +1531,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
> >  	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
> >  	if (IS_ERR(ctx))
> >  		return PTR_ERR(ctx);
> > +	if (!damon_sysfs_valid_start_ctx(ctx))
> > +		return -EINVAL;
> 
> [Severity: Medium]
> Does damon_sysfs_turn_damon_on() leak ctx and its associated allocations when
> damon_sysfs_valid_start_ctx(ctx) returns false?

Good catch.  I will destroy the ctx in the error case in the next version, like
below:

'''
@@ -1531,8 +1531,10 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
        ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
        if (IS_ERR(ctx))
                return PTR_ERR(ctx);
-       if (!damon_sysfs_valid_start_ctx(ctx))
+       if (!damon_sysfs_valid_start_ctx(ctx)) {
+               damon_destroy_ctx(ctx);
                return -EINVAL;
+       }
        err = damon_start(&ctx, 1, false);
        if (err) {
                damon_destroy_ctx(ctx);
'''

> 
> When userspace writes "on" to the kdamond state sysfs file with a scheme
> quota goal whose target_value is zero, damon_sysfs_build_ctx() allocates ctx
> along with its targets, regions, schemes, quota goals, filters, and any
> target struct pid references. Returning -EINVAL directly here skips
> damon_destroy_ctx(ctx) (and target pid cleanup via
> damon_sysfs_destroy_targets(ctx)), whereas the damon_start() error path right
> below destroys ctx before returning:
> 
> 	err = damon_start(&ctx, 1, false);
> 	if (err) {
> 		damon_destroy_ctx(ctx);
> 		return err;
> 	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261025182326.178326-1-sj@kernel.org?part=1


Thanks,
SJ
