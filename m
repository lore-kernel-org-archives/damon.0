Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39481142E83
	for <damon@lists.linux.dev>; Sat, 18 Apr 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776526625; cv=none; b=W3piNTjN2IV+pWqc3XK4aA4KlHO+aGrHozPJ+yr4xEffJyw2I9PaQRshsy/O9GIPWDPvAhOnqcMra8qdQB7nfydyzsal9s3YIc0xMg4JbV6E7tXTUzfpHhdxPzePMnTWlL5yEi/KBzwSi/lThD2fEyuAutI6DvD6s1UzQjEg/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776526625; c=relaxed/simple;
	bh=tC+J4W6RtwR2t3yNcRxiFt905cB4YuFvO9IfB2DSEI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoSNzmr38CBp5KjCbQwlFNL+383xULq4QHNMdMSrGDa/iWm+pRgmQmeKwsd5QiBRm8jMYeAxzntT0r5E3Mna5U7PK36pbUHpKocCWxnFjjdratgwNSlB3usyfINrEcNVhJ6tGy8odRNJtAV9ELo3MgaA/WQkZrigrDtPUz7D5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkeZcxFy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkeZcxFy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C53C19424;
	Sat, 18 Apr 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776526624;
	bh=tC+J4W6RtwR2t3yNcRxiFt905cB4YuFvO9IfB2DSEI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TkeZcxFy7sqSwbmr7xCNmnUXXqf+7UI9MX9jd577/QgnUT5SkGMFXCdZB0cdQQ+8s
	 LLs/DetL0Ph+lG8hEdnMDl4AQDiUNTEsgehohS5iQYo7s5izG4jz4J6RBxwkjURnGv
	 ygc1pgcraZxTw/WVICmr1VspGvaia522pOsnW0TTXGBYtFBJr0BcmGdjAmeDXBRT1q
	 BWCA4TKhSWfjDBwuZ4IOtxV+Ok6zQ3iR8CDU2kmoa9L0L/pNEQcbChTpj4U5SIlykt
	 5fwL2P1ikAae5gqdDxpoj8q0lEIN1V97cng/qC8deNNcrA0PYceuufE8fO0QZdyn25
	 oE9RPdEaXxVSw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 2/3] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Sat, 18 Apr 2026 08:36:55 -0700
Message-ID: <20260418153656.834-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418053059.E80C6C2BCB0@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 Apr 2026 05:30:59 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 3 potential issue(s):
> - [Critical] Missing `.set` callback in `kdamond_pid_param_ops` will cause a kernel panic if the parameter is passed at boot or via modprobe.

I will fix this in the next revision.

> - [High] Loading the module with `enabled=Y` causes a NULL pointer dereference on `ctx`.
> - [High] Concurrent calls to `damon_lru_sort_turn()` lack locking, leading to list corruption and kernel panics.

Above two are valid points but not caused by this patch.  I will separately
work for those.

> --
> 
> commit 905c8d84b8daa6d4ddb6fc214e81e98101608d53
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
> 
> This commit updates DAMON_LRU_SORT to dynamically check the running status
> of kdamond instead of relying on cached parameter values. This ensures the
> status correctly reflects when kdamond stops due to events other than
> explicit user requests.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d729760..d284cb336b662 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> [ ... ]
> > @@ -386,12 +377,8 @@ static int damon_lru_sort_turn(bool on)
> >  {
> >  	int err;
> >  
> > -	if (!on) {
> > -		err = damon_stop(&ctx, 1);
> > -		if (!err)
> > -			kdamond_pid = -1;
> > -		return err;
> > -	}
> > +	if (!on)
> > +		return damon_stop(&ctx, 1);
> 
> Could concurrent calls to this function lead to list corruption? 
> 
> If a user writes 'Y' to the enabled parameter via sysfs at the same
> time damon_lru_sort_init() calls damon_lru_sort_turn(true) during module
> initialization, damon_commit_ctx() might concurrently modify ctx->schemes
> and ctx->targets without internal locking.

Hmm, good finding.  But the race existis even before this patch.  I will
separately work on this.

> 
> [ ... ]
> > @@ -430,10 +414,16 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
> >  MODULE_PARM_DESC(addr_unit,
> >  	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)");
> >  
> > +static bool damon_lru_sort_enabled(void)
> > +{
> > +	if (!ctx)
> > +		return false;
> > +	return damon_is_running(ctx);
> > +}
> > +
> >  static int damon_lru_sort_enabled_store(const char *val,
> >  		const struct kernel_param *kp)
> >  {
> > -	bool is_enabled = enabled;
> >  	bool enable;
> >  	int err;
> 
> Is it possible to hit a NULL pointer dereference on ctx when loading the
> module with enabled=Y? 
> 
> If the DAMON core is already initialized (e.g. built-in), damon_initialized()
> would return true, bypassing the early exit in this function. This could
> lead to calling damon_lru_sort_turn(true) before damon_lru_sort_init() has
> run, causing damon_commit_ctx() to operate on a NULL ctx pointer.

Hmm, good finding.  This is a race of a type that is same to the above one.
And again the race exists even before this patch.  I will separately work on
this.

> 
> [ ... ]
> > +static const struct kernel_param_ops kdamond_pid_param_ops = {
> > +	.get = damon_lru_sort_kdamond_pid_load,
> > +};
> > +
> > +/*
> > + * PID of the DAMON thread
> > + *
> > + * If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.
> > + * Else, -1.
> > + */
> > +module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
> 
> Does this cause a NULL pointer dereference if the parameter is passed at
> boot or via modprobe?
> 
> The kernel parameter parsing code in parse_one() doesn't check if .set is
> NULL before invoking it:
> 
>     err = params[i].ops->set(val, &params[i]);
> 
> A dummy .set function returning an error might be needed to prevent a NULL
> pointer dereference when parsing command line arguments.

Good point.  I will fix this in the next revision like below.

'''
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -412,6 +412,16 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
        "Enable or disable DAMON_RECLAIM (default: disabled)");

+static int damon_reclaim_kdamond_pid_store(const char *val,
+               const struct kernel_param *kp)
+{
+       /*
+        * kdamond_pid is read-only, but kernel command line could write it.
+        * Do nothing here.
+        */
+       return 0;
+}
+
 static int damon_reclaim_kdamond_pid_load(char *buffer,
                const struct kernel_param *kp)
 {
@@ -426,6 +436,7 @@ static int damon_reclaim_kdamond_pid_load(char *buffer,
 }

 static const struct kernel_param_ops kdamond_pid_param_ops = {
+       .set = damon_reclaim_kdamond_pid_store,
        .get = damon_reclaim_kdamond_pid_load,
 };
'''


Thanks,
SJ

[...]
