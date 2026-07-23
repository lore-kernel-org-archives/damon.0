Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E93B0AEA
	for <damon@lists.linux.dev>; Thu, 23 Jul 2026 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785523; cv=none; b=baJqp/QyDdAih3w40lMcqyVFO5P6C3bNT5M8cKh+IcShv0+9k6dDtL7IYqBKYuOZjLAi7Z/dJfNn/Jsd0FB/dVS1kZJSiH1g51J6qldiRPysuCvKA2emSiUp7fbagTR66ziikv1YcjvZQjdJo2gejkhQ2UqVnXwlVUbeoFA4q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785523; c=relaxed/simple;
	bh=6tqpmC1EOyR8ZEQ+cQj6JvPi1lH3eY799/NS6rBRyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7uSsFGdn1sTMRs/wLoL/K1KHY5OzynmfjFhsswoUTVwjuRZWg0LB+3zQSr3x7QVLmUu6zf1PCwUmVgns+ApycFlKQVNhJqlVnnIBCL0u+mq91EQWQ+V0XByzG/RKUG/RaGWJguguE6Yq51fAKHrFuBY2WTqVzZKCLp90Y14CYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220C61F000E9;
	Thu, 23 Jul 2026 05:45:21 +0000 (UTC)
From: SJ Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/3] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 22 Jul 2026 22:45:17 -0700
Message-ID: <20260723054518.84664-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418153656.834-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 08:36:55 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Sat, 18 Apr 2026 05:30:59 +0000 sashiko-bot@kernel.org wrote:
> 
> > Sashiko AI review found 3 potential issue(s):
> > - [Critical] Missing `.set` callback in `kdamond_pid_param_ops` will cause a kernel panic if the parameter is passed at boot or via modprobe.
> 
> I will fix this in the next revision.
> 
> > - [High] Loading the module with `enabled=Y` causes a NULL pointer dereference on `ctx`.
> > - [High] Concurrent calls to `damon_lru_sort_turn()` lack locking, leading to list corruption and kernel panics.
> 
> Above two are valid points but not caused by this patch.  I will separately
> work for those.
> 
> > --
> > 
> > commit 905c8d84b8daa6d4ddb6fc214e81e98101608d53
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
> > 
> > This commit updates DAMON_LRU_SORT to dynamically check the running status
> > of kdamond instead of relying on cached parameter values. This ensures the
> > status correctly reflects when kdamond stops due to events other than
> > explicit user requests.
> > 
> > > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > > index 554559d729760..d284cb336b662 100644
> > > --- a/mm/damon/lru_sort.c
> > > +++ b/mm/damon/lru_sort.c
> > [ ... ]
> > > @@ -386,12 +377,8 @@ static int damon_lru_sort_turn(bool on)
> > >  {
> > >  	int err;
> > >  
> > > -	if (!on) {
> > > -		err = damon_stop(&ctx, 1);
> > > -		if (!err)
> > > -			kdamond_pid = -1;
> > > -		return err;
> > > -	}
> > > +	if (!on)
> > > +		return damon_stop(&ctx, 1);
> > 
> > Could concurrent calls to this function lead to list corruption? 
> > 
> > If a user writes 'Y' to the enabled parameter via sysfs at the same
> > time damon_lru_sort_init() calls damon_lru_sort_turn(true) during module
> > initialization, damon_commit_ctx() might concurrently modify ctx->schemes
> > and ctx->targets without internal locking.
> 
> Hmm, good finding.  But the race existis even before this patch.  I will
> separately work on this.

Seems I was hallucinated.  DAMON_LRU_SORT is not loadable, so this race cannot
happen.  I will ignore this report.

> 
> > 
> > [ ... ]
> > > @@ -430,10 +414,16 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> > >  MODULE_PARM_DESC(addr_unit,
> > >  	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)");
> > >  
> > > +static bool damon_lru_sort_enabled(void)
> > > +{
> > > +	if (!ctx)
> > > +		return false;
> > > +	return damon_is_running(ctx);
> > > +}
> > > +
> > >  static int damon_lru_sort_enabled_store(const char *val,
> > >  		const struct kernel_param *kp)
> > >  {
> > > -	bool is_enabled = enabled;
> > >  	bool enable;
> > >  	int err;
> > 
> > Is it possible to hit a NULL pointer dereference on ctx when loading the
> > module with enabled=Y? 
> > 
> > If the DAMON core is already initialized (e.g. built-in), damon_initialized()
> > would return true, bypassing the early exit in this function. This could
> > lead to calling damon_lru_sort_turn(true) before damon_lru_sort_init() has
> > run, causing damon_commit_ctx() to operate on a NULL ctx pointer.
> 
> Hmm, good finding.  This is a race of a type that is same to the above one.
> And again the race exists even before this patch.  I will separately work on
> this.

I will ignore the above report for the same reason.


Thanks,
SJ

[...]
