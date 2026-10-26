Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027312;
	b=NYlnp29FH5cy1uY2YlA1CaQ0FXlY3YfSFIPMYkj9pa+0jiubFMDfbX1SJBAX9I49lgpA
	 WW25bjmpPd/Yq4W+kSToPHTG2DQpSu72gG4WPvSLJwQgyy6LIuhnMhQVLrjCSw1+SRUD6
	 6wbrPAaZdjh3dzN3ByKfelnrZxLk3lI9B3Cxn8iYofO4fFyKjxdsIrl3zMrhODnMRJfvS
	 Pf/MjRm3Kplwa/QikG2rl3vNHNatdXXPa8E2OmNzBVtcGZ3bKeAHp+7QKEZznkb4hl3NS
	 YFDp48pkW5tsIN7FgUmsg3+ie7njdaTMJnl9X4dS7bLtAn+BsBWWxJL4U26pwiU52uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027312;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nNXUTVFn4ste1wqd8vmAxSpwftg5otrNRXmIT6BWIlw=;
	b=eQ1dRY7Z2krgbsFbXTC+YuguagmvBsQ6AUcIQJx+2T2OAUBj9IYCbMDLBrfYFE54RzLV
	 L4zfvGPphMtk8aUYLISMtvmQOIrnyoSmvvUDw5jYUgrqQ+6/e0n5QM9DJoGLAPHeyPGEu
	 pflF/y9TrF84lkYCrOQ3X7KtsS2+Bu88YxnmzLTJDNv/s23xdDBYTmHptGdQJ7vz9OWE6
	 2a5I2nNEsGKuYeKqaGa+NP6RKaDSCv9TpBnmIJsc+u4hu/hNBsgLTsKX6yBzrpX2UXH2R
	 2jfbpTFr/E0B4rwhLmFeQhZAh0T9PxIwm3ouyM4mQdkQ7E3PCiHBTzk/XbaECkVwY9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCcwr8l9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F8606A31E
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCcwr8l9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8731F01825;
	Mon, 26 Oct 2026 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793027312;
	bh=nNXUTVFn4ste1wqd8vmAxSpwftg5otrNRXmIT6BWIlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCcwr8l9A+OwZ3fur1MZwljx7AVLXFA8Jfla3QPDnCJBLp8cBIjtUBqz0sgPoIok9
	 YVW9ArL+npfG9DTPxSueUFV2wDO8Xsdvrxs2Bfa60xo8ZvzsAmucH++Aww1gOXNO2g
	 0Ciz21JONsjlHYm/Hw9K1/ctQZElaFVhE7IuHUy+ch43+el9b2pQs6YIFT7kLdFQYy
	 jZOf/QmOA4Ut1EEVxouaHofHQWqOCkP+zqEJDk8cXVq03OOY/p3Jq++BPAD2DdiCyk
	 FlftrmtrdN+TUQqa0ndaC8LvYiwtzKVFAXuT0uNIbLLpiiTSH9rB18Sfe4eZZoO4Sg
	 bWEnz3BRSvR/g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6.12.y v2] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 08:08:23 -0700
Message-ID: <20261026150825.152576-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-185379@kernel.org>
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

On Mon, 26 Oct 2026 14:11:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm/damon/sysfs: pid leak in damon_sysfs_turn_damon_on() on invalid start ctx
> --
> 
> commit dc23c827b1a01b5ed768b0a218bb6a67def40106
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: error damos_commit_quota_goal() for zero target_value
> 
> This commit validates that DAMOS quota goal target_value is non-zero in
> damos_commit_quota_goal() and damos_commit_quota_goals() to prevent a
> division-by-zero error. For the stable backport, it also adds
> damon_sysfs_valid_start_ctx() to reject zero target_value before starting
> DAMON in damon_sysfs_turn_damon_on().
> 
> Link: https://lore.kernel.org/20260903010722.94244-1-sj@kernel.org
> Link: https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org
> Link: https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org [1]
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 5aa23c6545cb8..2c8749b62c621 100644
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
> > +		damos_for_each_quota_goal(g, (&s->quota)) {
> > +			if (!g->target_value)
> > +				return false;
> > +		}
> > +	}
> > +	return true;
> > +}
> > +
> >  static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
> >  {
> >  	struct damon_ctx *ctx;
> > @@ -1517,6 +1531,10 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
> >  	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
> >  	if (IS_ERR(ctx))
> >  		return PTR_ERR(ctx);
> > +	if (!damon_sysfs_valid_start_ctx(ctx)) {
> > +		damon_destroy_ctx(ctx);
> > +		return -EINVAL;
> > +	}
> 
> [Severity: Medium]
> Does this error path leak the target struct pid references (t->pid) when
> damon_target_has_pid(ctx) is true?
> 
> When damon_sysfs_build_ctx() constructs ctx via damon_sysfs_apply_inputs() ->
> damon_sysfs_add_targets() -> damon_sysfs_add_target(), it acquires a struct
> pid reference for each target:
> 
> mm/damon/sysfs.c:damon_sysfs_add_target() {
> 	...
> 	if (damon_target_has_pid(ctx)) {
> 		t->pid = find_get_pid(sys_target->pid);
> 		if (!t->pid)
> 			goto destroy_targets_out;
> 	}
> 	...
> }
> 
> Because damon_sysfs_valid_start_ctx(ctx) fails before damon_start() is
> called, kdamond never runs and ctx->callback.before_terminate
> (damon_sysfs_before_terminate()) is never invoked to release those
> references. Calling damon_destroy_ctx(ctx) invokes damon_destroy_targets(ctx),
> which frees each target without calling put_pid(t->pid):
> 
> mm/damon/core.c:damon_destroy_targets() {
> 	struct damon_target *t, *next_t;
> 
> 	if (ctx->ops.cleanup) {
> 		ctx->ops.cleanup(ctx);
> 		return;
> 	}
> 
> 	damon_for_each_target_safe(t, next_t, ctx)
> 		damon_destroy_target(t);
> }
> 
> In comparison, damon_sysfs_commit_input() cleans up an unstarted context from
> damon_sysfs_build_ctx() by calling damon_sysfs_destroy_targets() before
> damon_destroy_ctx():
> 
> mm/damon/sysfs.c:damon_sysfs_commit_input() {
> 	...
> 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
> 	damon_sysfs_destroy_targets(param_ctx);
> 	damon_destroy_ctx(param_ctx);
> 	return err;
> }
> 
> Should damon_sysfs_turn_damon_on() also call damon_sysfs_destroy_targets(ctx)
> before damon_destroy_ctx(ctx) here?

Nice catch.  I will fix this in the next revision.

FYI, this patch for 6.18 and later kernels doesn't have this problem, since
they have commit 7114bc5e01cf ("mm/damon/core: add cleanup_target() ops
callback").  The commit made damon_destroy_ctx() to do the pid reference drop
by itself, and merged into 6.17.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261026135555.149244-1-sj@kernel.org?part=1


Thanks,
SJ
