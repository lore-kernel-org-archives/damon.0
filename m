Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C74908D5
	for <damon@lists.linux.dev>; Sat, 25 Jul 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785016359; cv=none; b=bLiZjOll3UxtVJJ8gmROt6prZkHguMQ9HIvG1cJxPnh8OefyhUTWMS4ExV3NA0EWwOhvt/rT8LqwFxng09Ytjfgto5aBeRXfTMh3a9Zj7TqpJAIicWvdct0rlengZ9EuwQCs/27gchA6uvf7a1DB6kSIFxI30lu0cw42xJhet8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785016359; c=relaxed/simple;
	bh=h8mckCgan5zs1Vu4TqMmkLFiEF0RNhX3qgm32CM6ORo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0A1Bv7vlux+0jLI4ZeLhWMy5ye/B5tPpTtPVpURYlj6bnhpkM9fni5gr1onABbNX3ryOAJnUuYOH6y/ShE9EX35ujdkrzMW9qsdxHcdAgJuk/c+OgHRsrSsO3XHCgCWtRWPAhRAzibHWBTw60Eet1hbPmJ+CmZeEbSJCQpiQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZrXlUef; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZrXlUef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A851F000E9;
	Sat, 25 Jul 2026 21:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785016358;
	bh=8GJwiQdxqB6w/7li4Yr/F7HazRQziSCanO3/QiOQEG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZrXlUefDmnh6irNgZZydQ8DyR8AUikQEi7ejBkq+CZ/HNFlgyN+cVz1dbG2W6vRX
	 d0GY7fFrNAFr6lRRpJJvYgjJh8Fm4viu7ek3XF3+NcNj6gN1Ve1KeiO0hyi5TByK5J
	 6FdslTQXizrkMFtcA/QZ8ReBKOAiSezxA6CveJqXdA6GYvcgwQZz285wGtEqozMfI0
	 fOYXb7+C+ZKjbcj9dg36xyFGad6enKVs5JSTSPWpG2JBjrGUZPiKPePFjTugF0VULw
	 HrQQV+gDSZfANqDlCiVAQgD5XLeVj8wbn90M/sycwPYzXmd9/gh1McsMowsOZuFHxT
	 rUVbWr2leRoiA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 07/17] mm/damon/core: introduce damon_operations->prep_probes()
Date: Sat, 25 Jul 2026 14:52:28 -0700
Message-ID: <20260725215230.131687-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725211414.8ED581F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 25 Jul 2026 21:14:14 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] prep_probes receives has_prep instead of access_check_disabled && has_prep, causing it to overwrite sampling_addr during normal access checking.
> - [Medium] Uninitialized sampling_addr usage in apply_probes if prep_probes is not implemented.
> --
> 
> --- Patch [7]: [RFC PATCH 07/17] mm/damon/core: introduce damon_operations->prep_probes() ---
> commit 62e96fea7e813101fb4353abda03a93a90ef358a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_operations->prep_probes()
>     
> damon_prep needs to be executed by the underlying DAMON operation set.
> Extend the operation set callback list for the execution of damon_prep
> actions.  If the underlying operation set implements the callback, DAMON
> core executes it in the monitoring preparation time.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 127d3a7c27280..d5b1e0b5851a1 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -3878,6 +3891,8 @@ static int kdamond_fn(void *data)
> >  
> >  		if (!access_check_disabled && ctx->ops.prepare_access_checks)
> >  			ctx->ops.prepare_access_checks(ctx);
> > +		if (ctx->ops.prep_probes)
> > +			ctx->ops.prep_probes(ctx, has_prep);
> 
> [Severity: Medium]
> Could this overwrite the tracked sampling_addr during normal access checking?
> 
> If a configuration has a prep without probe weights, access_check_disabled
> is false and has_prep is true. prepare_access_checks() sets sampling_addr 
> and marks it for tracking. 
> 
> If prep_probes() is implemented by a backend, passing has_prep (true) here
> instead of access_check_disabled && has_prep would cause it to generate
> a new, unprepared sampling_addr that silently overwrites the tracked one.

Good check.

> 
> >  
> >  		kdamond_usleep(sample_interval);
> >  		ctx->passed_sample_intervals++;
> > @@ -3892,7 +3907,8 @@ static int kdamond_fn(void *data)
> >  			else
> >  				get_max_wsum = false;
> >  			max_wsum = ctx->ops.apply_probes(ctx,
> > -					access_check_disabled, get_max_wsum);
> > +					access_check_disabled && !has_prep,
> > +					get_max_wsum);
> 
> [Severity: Medium]
> Does this result in uninitialized sampling_addr usage in apply_probes() if
> the backend doesn't implement prep_probes?
> 
> If a probe has a weight and a prep, both access_check_disabled and has_prep
> evaluate to true, which skips prepare_access_checks().
> 
> If the current operations do not implement prep_probes
> (ctx->ops.prep_probes == NULL), that callback is also skipped.
> 
> When apply_probes() is called, set_samples evaluates to false (because
> access_check_disabled && !has_prep is false). As a result, no function
> initializes r->sampling_addr, and the uninitialized memory could be read
> by apply_probes().

Again, good finding.

I will fix above two like below.

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4251,7 +4251,7 @@ static int kdamond_fn(void *data)
                unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
                unsigned long sample_interval = ctx->attrs.sample_interval;
                bool access_check_disabled = damon_has_probe_weights(ctx);
-               bool has_prep = damon_has_prep(ctx);
+               bool do_prep = damon_has_prep(ctx) && ctx->ops.prep_probes;
                unsigned int max_merge_score = 0, max_wsum;
                bool get_max_wsum;

@@ -4260,8 +4260,8 @@ static int kdamond_fn(void *data)

                if (!access_check_disabled && ctx->ops.prepare_access_checks)
                        ctx->ops.prepare_access_checks(ctx);
-               if (ctx->ops.prep_probes)
-                       ctx->ops.prep_probes(ctx, has_prep);
+               if (do_prep)
+                       ctx->ops.prep_probes(ctx, access_check_disabled);

                kdamond_usleep(sample_interval);
                ctx->passed_sample_intervals++;
@@ -4283,7 +4283,7 @@ static int kdamond_fn(void *data)
                        else
                                get_max_wsum = false;
                        max_wsum = ctx->ops.apply_probes(ctx,
-                                       access_check_disabled && !has_prep,
+                                       access_check_disabled && !do_prep,
                                        get_max_wsum);
                        if (get_max_wsum)
                                max_merge_score = max_wsum;
'''

> 
> >  			if (get_max_wsum)
> >  				max_merge_score = max_wsum;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260725210225.129944-1-sj@kernel.org?part=7


Thanks,
SJ
