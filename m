Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F81A9FBC;
	Sun, 30 Aug 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788115141; cv=none; b=JdbKNM1QT0+i0E3vvCgQKohQClJ61MOhBxLDn3tG9CbbnWw7QPzGdQYnRFyZoRaPvyjBSjPmE1DN7vNRWJVDj+l0YG9nWDulcU8AiJ/qYY3r9hALtRCc8bLuaCT9mEv56OUdaNvX5Ed6to6/qhxDMoA1BrS2YYD9EiZWQRUGBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788115141; c=relaxed/simple;
	bh=5+kMpCgaKPSF3S5rboa5bIFVDlKw122brlojSY68E6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqhzvNR62NgQju3vaEkuU9WdgMYgk5oeMcAhfQEHM5i7WCmAdtt7MHygDgnSiwz8Bo7o7XClrp908CPlz+c2EwLbjpyU6rlcPZItlvq85k1IyoMMLCT87F1THof/67UVUgc2al2BYa1n5A7fF9P++wThTR2wWGCckgFhD9an5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6hjMYwd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6hjMYwd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BDF1F000E9;
	Sun, 30 Aug 2026 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788115139;
	bh=E3bBZzmOMZCA2M4AQFe7Y+81H39aGr1Oh/9zopZqbiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D6hjMYwd+oKzSBJk9n9d9WYX3Z4VDuegnX5OreStuxUQo+U93MFlQv/+YlVVx2Hjr
	 dRZzw9DTJ7wHm2mzWWOdz/v0uSfs2IncYsmVev7rR9OhJnLGG4WwFYGIEowSEJnSLR
	 0IBV9ZMfXVelcYX96A/M2qerjIO5KtbJ28G7jbylMl5jBTHnZcuamLV/Lh32c7Frkz
	 mP2VWIUm4PJrXA5e8FM00eovwmcRL2Gv8vwmwl4sndpDiVbpwG4fU0JcxQQyGQJgbi
	 XIOyOgEily8i3nRajpj4D2M2ncDZPvH+O744kAmsjNjc/ukhqwNb101vHpcR/uJ4hx
	 KPNcrzM5ckQEQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	sashiko-bot@kernel.org,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Sun, 30 Aug 2026 11:38:51 -0700
Message-ID: <20260830183851.106396-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830082948.18940-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 16:29:46 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sun, 30 Aug 2026 06:47:07 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] A preexisting bug causes DAMOS scheme application to permanently stall for all subsequent targets if `quota->charge_target_from` points to a target that becomes invalid or loses all its regions.
> > --
> > 
> > commit 630d73d512e66245612cbdfe5c49647aa6ed2874
> > Author: Liew Rui Yan <aethernet65535@gmail.com>
> > 
> > mm/damon/core: fix unconditionally skip last region
> > 
> > This patch fixes an issue where the last region of a tracked target could
> > be unconditionally skipped and reset without being processed when a scheme
> > quota is exhausted. By modifying the reset logic, it ensures the last region
> > is appropriately handled rather than always skipped.
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 644daf5a16560..fb76b530bbc68 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2342,36 +2342,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
> > >  {
> > >  	struct damos_quota *quota = &s->quota;
> > >  	unsigned long sz_to_skip;
> > > +	bool skip = false;
> > >  
> > >  	/* Skip previously charged regions */
> > >  	if (quota->charge_target_from) {
> > >  		if (t != quota->charge_target_from)
> > >  			return true;
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does this logic cause all
> > subsequent targets to permanently stall if the target currently stored in
> > quota->charge_target_from becomes invalid?
> > 
> > If the monitored process dies before the next window, kdamond_apply_schemes()
> > appears to bypass it without clearing the saved target:
> > 
> > mm/damon/core.c:kdamond_apply_schemes() {
> >     ...
> > 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
> > 			continue;
> > 		damos_apply_target(c, t, max_region_sz);
> >     ...
> > }
> > 
> > Because the target is skipped entirely, we never call damos_apply_target()
> > and never reach the clearing mechanism inside damos_skip_charged_region().
> > 
> > When this happens, wouldn't all other valid targets continue to evaluate
> > (t != quota->charge_target_from) as true here, permanently skipping scheme
> > applications?
> > 
> > It appears a local user could reliably trigger this by setting a restrictive
> > quota on a memory-intensive process they own, waiting for the quota to
> > exhaust, and then terminating the process.
> 
> Thank you for pointing this out!  Yes, this can happens.
> 
> I just wrote a simple fix, this fix introduces damon_target->'bool
> has_charged', which was added to prevent entering the
> damon_target_remove_ref() (new function introduces by this fix) loop
> every time an invalid target is encountered.  However, adding this field
> may be unnecessary, or it might better to use something like 'unsigned
> int charged_ref_count' instead.
> 
> '''
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 0c8b7ddef9ab..19d46d792858 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -93,6 +93,7 @@ struct damon_region {
>  struct damon_target {
>  	struct pid *pid;
>  	bool obsolete;
> +	bool has_charged;

I'd prefer not introducing new field.

>  /* private: */
>  	/* Number of monitoring target regions of this target. */
>  	unsigned int nr_regions;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a1656..6c14b2d4e9cd 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2630,6 +2630,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
>  		if (damos_quota_is_full(quota, c->min_region_sz)) {
>  			quota->charge_target_from = t;
>  			quota->charge_addr_from = r->ar.end;
> +			t->has_charged = true;
>  		}
>  	}
>  	if (s->action != DAMOS_STAT)
> @@ -3216,6 +3217,26 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
>  	trace_call__damos_stat_after_apply_interval(cidx, sidx, &s->stat);
>  }
>  
> +static void damon_target_remove_ref(struct damon_ctx *c,
> +					 struct damon_target *t)
> +{
> +	struct damos *s;
> +
> +	damon_for_each_scheme(s, c) {
> +		struct damos_quota *quota = &s->quota;
> +
> +		if (!quota->charge_target_from)
> +			continue;
> +
> +		if (quota->charge_target_from == t) {
> +			quota->charge_target_from = NULL;
> +			quota->charge_addr_from = 0;
> +		}
> +	}
> +
> +	t->has_charged = false;
> +}
> +
>  static void kdamond_apply_schemes(struct damon_ctx *c)
>  {
>  	struct damon_target *t;
> @@ -3241,8 +3262,11 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
>  	max_region_sz = damon_region_sz_limit(c);
>  	mutex_lock(&c->walk_control_lock);
>  	damon_for_each_target(t, c) {
> -		if (c->ops.target_valid && c->ops.target_valid(t) == false)
> +		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
> +			if (t->has_charged)
> +				damon_target_remove_ref(c, t);
>  			continue;
> +		}
>  		damos_apply_target(c, t, max_region_sz);
>  	}

I think damos_adjust_quota() is a better place to do this.  For example,

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3530,6 +3530,22 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
        trace_damos_esz(cidx, sidx, quota->esz);
 }

+static void damos_reset_invalid_charge_target_from(struct damos_quota *quota,
+               struct damon_ctx *c)
+{
+       struct damon_target *t;
+
+       t = quota->charge_target_from;
+       if (!t)
+               return;
+       if (!c->ops.target_valid)
+               return;
+       if (c->ops.target_valid(t))
+               return;
+       quota->charge_target_from = NULL;
+       quota->charge_addr_from = 0;
+}
+
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 {
        struct damos_quota *quota = &s->quota;
@@ -3570,6 +3586,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
                        damos_trace_esz(c, s, quota);
        }

+       damos_reset_invalid_charge_target_from(quota, c);
+
        if (!c->ops.get_scheme_score)
                return;
'''

> '''
> 
> SJ, when should this bug be fixed?  Along with this patch, or before
> this patch?

Whenever the fix is ready.  If you don't mind, I will take this.


Thanks,
SJ

[...]
