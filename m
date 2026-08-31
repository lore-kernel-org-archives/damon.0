Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259F2E62A9
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788137907; cv=none; b=lj1PKTJNSmSRLjGRWgijtqjcmBgh/2hwsJ0RxfulyfmzwuTOn1oi55woQjKQ7SaLMmSdfudsMmybMGFtvMNspYCbGJyc3XeA9iyDSppm3IW0PoRC5bliGL1SjTO4DL4zh4SRKel0qpqJHxh7o/ZqtdBFQrMVP6zJGeqe2pnFpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788137907; c=relaxed/simple;
	bh=xDrToFTxMizEvfjrSm0CQkl5StWE6tmGzCHRfUUoOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZhu9nJyYW4hWr/0mi/y3/bcxvwaF4SzawbQdqynxn5HeDI219Dbmzn8gc09j2rDmXOiLo1fxyy5FEgAbhXN8qHmDW6+ROlATNt+aQjaULZ3H6K+m1P4zktvHGpOieXttUdKEjzWXgcLsYISGaPtP0rpTFWcZSN0pVW3WZIqspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ62Dx6q; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ62Dx6q"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so2179976a91.3
        for <damon@lists.linux.dev>; Sun, 30 Aug 2026 17:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788137905; x=1788742705; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e/jH7rAxcdrwS4CyOEI+sguLbWI5WKj0tmm2sr7tsXM=;
        b=pJ62Dx6qeEcGxuz+Y+q16L/pnqjbotKGJQ0sVbHcsWkJGBTaVBu5jFvJUqY3BEfQ5o
         7HSpZm85b3qcJMJIQrL72sqcXs0vFfG5YkgOnbcwz4kEtC5pJjf1WnS2tlQ5FodsYL0E
         X6YVrpjUqopSbCubzgK70Bor7r0s52kGmyqXSVFjBJZ6NtKX0jSLG15P2wbJXaTG1bzF
         4EjBnzgZ4EN52FUZ72sek1vNHjT2zsz2qHj+Eutb5B/CR0L2SIrZGdQKzIUifjS+Bb+P
         HWe+hbEcV6mF8GyXk6JPdbSdOimzZIikNHdFxA4yiVTuT6xJntaBMpNtPAHJmPl7Bq0Y
         jq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788137905; x=1788742705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e/jH7rAxcdrwS4CyOEI+sguLbWI5WKj0tmm2sr7tsXM=;
        b=e/YRTxSB/hWX4MioEp/3O55uRyYTk6LcS47B1JgjHhc+s/Lqz0nDmZNA7b4n2CmaK/
         oN02V7vbCPZMuhJ9JlN7F1J13QyrKiucQaplBiCjHqm6dwYhGkjbxRULUtC5xVxBCKCa
         YvnU/0KeVStYPJVcxhMfqKEL19o2lEDhDHT3wHElOlSgv7vrq2wlIQ9AHN5p7i5n5k6Q
         K2JvFc/7mMACClrGR6lTLr8UVJOU7uuxcMfPi4YXB4wEf00OsAhC/yyzR2Kgg5YLJUvB
         IDgJOjbNoxkcw8iMiTo2GIK9jMWdQE/rZKM44mUt3btcZZaektZ0grqWpojdcVcmPWO5
         +5Qg==
X-Forwarded-Encrypted: i=1; AKwUvByhy33v8MaruhA1dXC8GflujCunVIne0DEny3ieRIbA2yDaM0e5S8+YWM10ieeukkh99U3TBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kNEUY5i4cAgbmVMfT4VIXIwStZMsFWRthN353fkMNb55yqh6k9
	Z9Vb3wWfJQoCa2Kn79bTnZ5zWDJW1L9Gaqcubg8+LbzajHa1f8GWQW3F
X-Gm-Gg: AYBFou1BhO7iXeX4YYOnKaEFgSALaoA9C2szz1KPxLa0Z1RfyOdFpWxl6FKUI/m3b94
	yFEZrfWE16V1d79xsmgDJ0T6laWlbGNNpwz+JFuc5/vntT+Chv3D2S1/zZAF/tM7wnoAHYAwc6W
	T6TCeT/PGB6CmOABHYprB1wD04K9TJyZsOJHjJBza7y9BM+LGAXmHRhrYHgwQYMXIf7z8pT4YM+
	36ZECPO/rHTZwFJ5gxDktnKGqkH0eaxVh1V+BQb9OUNHlQyKj4xYgM/HtikqGcA1GR2JKALBflT
	wEcllju2eWAxHFTWpqVoz9bqyot9UrI0j/T853vdzAGBavSiApezzgLVWXbc+09Z5XtU85mWyzA
	LTb7Z9yGcNg6Lp+ObVH+RkeIG4XUyw5L2EjhM0K+DuWxDla3vrIPFzRKSYaFyjJ6HNZdSXmN9JP
	FBhm6NoZGuPY7/WrBNL0tUKNuycWs+bjzmicpri9wau82N5jAbZGMh+0t1cTBrfOxz0pCgPua5D
	hf+R2EF2uo1t0XU
X-Received: by 2002:a17:90a:120f:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-398ba0e9e53mr9669382a91.23.1788137904715;
        Sun, 30 Aug 2026 17:58:24 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea7fa9sm18758777a91.4.2026.08.30.17.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 17:58:24 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] mm/damon/core: fix unconditionally skip last region
Date: Mon, 31 Aug 2026 08:57:56 +0800
Message-ID: <20260831005834.5270-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830183851.106396-1-sj@kernel.org>
References: <20260830183851.106396-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 30 Aug 2026 11:38:51 -0700 SJ Park <sj@kernel.org> wrote:

> On Sun, 30 Aug 2026 16:29:46 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Sun, 30 Aug 2026 06:47:07 +0000 sashiko-bot@kernel.org wrote:
> > 
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> > > - [High] A preexisting bug causes DAMOS scheme application to permanently stall for all subsequent targets if `quota->charge_target_from` points to a target that becomes invalid or loses all its regions.
> > > --
> > > 
> > > commit 630d73d512e66245612cbdfe5c49647aa6ed2874
> > > Author: Liew Rui Yan <aethernet65535@gmail.com>
> > > 
> > > mm/damon/core: fix unconditionally skip last region
> > > 
> > > This patch fixes an issue where the last region of a tracked target could
> > > be unconditionally skipped and reset without being processed when a scheme
> > > quota is exhausted. By modifying the reset logic, it ensures the last region
> > > is appropriately handled rather than always skipped.
> > > 
> > > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > > index 644daf5a16560..fb76b530bbc68 100644
> > > > --- a/mm/damon/core.c
> > > > +++ b/mm/damon/core.c
> > > > @@ -2342,36 +2342,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
> > > >  {
> > > >  	struct damos_quota *quota = &s->quota;
> > > >  	unsigned long sz_to_skip;
> > > > +	bool skip = false;
> > > >  
> > > >  	/* Skip previously charged regions */
> > > >  	if (quota->charge_target_from) {
> > > >  		if (t != quota->charge_target_from)
> > > >  			return true;
> > > 
> > > [Severity: High]
> > > This isn't a bug introduced by this patch, but does this logic cause all
> > > subsequent targets to permanently stall if the target currently stored in
> > > quota->charge_target_from becomes invalid?
> > > 
> > > If the monitored process dies before the next window, kdamond_apply_schemes()
> > > appears to bypass it without clearing the saved target:
> > > 
> > > mm/damon/core.c:kdamond_apply_schemes() {
> > >     ...
> > > 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
> > > 			continue;
> > > 		damos_apply_target(c, t, max_region_sz);
> > >     ...
> > > }
> > > 
> > > Because the target is skipped entirely, we never call damos_apply_target()
> > > and never reach the clearing mechanism inside damos_skip_charged_region().
> > > 
> > > When this happens, wouldn't all other valid targets continue to evaluate
> > > (t != quota->charge_target_from) as true here, permanently skipping scheme
> > > applications?
> > > 
> > > It appears a local user could reliably trigger this by setting a restrictive
> > > quota on a memory-intensive process they own, waiting for the quota to
> > > exhaust, and then terminating the process.
> > 
> > Thank you for pointing this out!  Yes, this can happens.
> > 
> > I just wrote a simple fix, this fix introduces damon_target->'bool
> > has_charged', which was added to prevent entering the
> > damon_target_remove_ref() (new function introduces by this fix) loop
> > every time an invalid target is encountered.  However, adding this field
> > may be unnecessary, or it might better to use something like 'unsigned
> > int charged_ref_count' instead.
> > 
> > '''
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 0c8b7ddef9ab..19d46d792858 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -93,6 +93,7 @@ struct damon_region {
> >  struct damon_target {
> >  	struct pid *pid;
> >  	bool obsolete;
> > +	bool has_charged;
> 
> I'd prefer not introducing new field.
> 
> >  /* private: */
> >  	/* Number of monitoring target regions of this target. */
> >  	unsigned int nr_regions;
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a1656..6c14b2d4e9cd 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2630,6 +2630,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		if (damos_quota_is_full(quota, c->min_region_sz)) {
> >  			quota->charge_target_from = t;
> >  			quota->charge_addr_from = r->ar.end;
> > +			t->has_charged = true;
> >  		}
> >  	}
> >  	if (s->action != DAMOS_STAT)
> > @@ -3216,6 +3217,26 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
> >  	trace_call__damos_stat_after_apply_interval(cidx, sidx, &s->stat);
> >  }
> >  
> > +static void damon_target_remove_ref(struct damon_ctx *c,
> > +					 struct damon_target *t)
> > +{
> > +	struct damos *s;
> > +
> > +	damon_for_each_scheme(s, c) {
> > +		struct damos_quota *quota = &s->quota;
> > +
> > +		if (!quota->charge_target_from)
> > +			continue;
> > +
> > +		if (quota->charge_target_from == t) {
> > +			quota->charge_target_from = NULL;
> > +			quota->charge_addr_from = 0;
> > +		}
> > +	}
> > +
> > +	t->has_charged = false;
> > +}
> > +
> >  static void kdamond_apply_schemes(struct damon_ctx *c)
> >  {
> >  	struct damon_target *t;
> > @@ -3241,8 +3262,11 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  	max_region_sz = damon_region_sz_limit(c);
> >  	mutex_lock(&c->walk_control_lock);
> >  	damon_for_each_target(t, c) {
> > -		if (c->ops.target_valid && c->ops.target_valid(t) == false)
> > +		if (c->ops.target_valid && c->ops.target_valid(t) == false) {
> > +			if (t->has_charged)
> > +				damon_target_remove_ref(c, t);
> >  			continue;
> > +		}
> >  		damos_apply_target(c, t, max_region_sz);
> >  	}
> 
> I think damos_adjust_quota() is a better place to do this.  For example,
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3530,6 +3530,22 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
>         trace_damos_esz(cidx, sidx, quota->esz);
>  }
> 
> +static void damos_reset_invalid_charge_target_from(struct damos_quota *quota,
> +               struct damon_ctx *c)
> +{
> +       struct damon_target *t;
> +
> +       t = quota->charge_target_from;
> +       if (!t)
> +               return;
> +       if (!c->ops.target_valid)
> +               return;
> +       if (c->ops.target_valid(t))
> +               return;
> +       quota->charge_target_from = NULL;
> +       quota->charge_addr_from = 0;
> +}
> +
>  static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>  {
>         struct damos_quota *quota = &s->quota;
> @@ -3570,6 +3586,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
>                         damos_trace_esz(c, s, quota);
>         }
> 
> +       damos_reset_invalid_charge_target_from(quota, c);
> +
>         if (!c->ops.get_scheme_score)
>                 return;
> '''
> 
> > '''
> > 
> > SJ, when should this bug be fixed?  Along with this patch, or before
> > this patch?
> 
> Whenever the fix is ready.  If you don't mind, I will take this.

I do not mind, thank you :>

Best regards,
Rui Yan
