Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB931159C
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783646313; cv=none; b=tVVDuFYG43LuGriRqUZ9RjSkdgU6Di3kKjZZwxPC5deKGSy3yOmAuFR5F9erG7d5P9syNiKZ+7TH1hzpdwKOTNramkr6NRMa8Yh7QgFU8r+GWB/yTBYeuA8AjJpCa5jBe+iHdOPT68zsOeO9+LkRwLaBvG0G651bw7APFxtVdI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783646313; c=relaxed/simple;
	bh=MYye5mbXBrVnJJI/HUFwgTpfg77BErm6lVwtv2WUA5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaaMoOaljL9ak0MSYkIku/JWo/gjn/AtcTeTvjWjaquxAWbFGEbQ3+ULDbkXUDmWtoD9ifc5ugG2O7EetAWOtRyFKrYAqneq8Nr95BuSifR1H2w+FHKp/AB9vO5ijdhaCdHEnMEq/MnbT/571LUi4z8P7GhoLiyBvsQLq0JRWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBnaVhdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBnaVhdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6CA1F000E9;
	Fri, 10 Jul 2026 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783646309;
	bh=IgsVGW/WAoSwO4YrycC4XUCkswbKi4xhXFQzN4TUvjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBnaVhdMHFX4aSN3VfozUGig4o2lcnWSCY+kEHVrS1UMGxmERwBfkSF7PkGhl7kr3
	 zMfzufaXMpYOGd9qF6433y3e0Igh225XwB9yl60pbUGxHpSRXGe0t0gCS76ifft6+j
	 HKNXuYGCQ2FCMkxpiakqKkIQSk2/Pjpf7aM57uA2iDVokhSMSZMuzy19KYwjUedqVl
	 oHjZGztRehmmtbkME8cj9QIhG5A9+4gp5OLFoXeq2f4vxyvleEEv9+GXFQTXcRLTx4
	 4feaFK49myfRPerIdO6GmsI+iXG7AifWroi18NLjTX43t5CQq6f3qRLVRw5EkbdGtt
	 qG+6j21tR1sGQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.3 15/19] mm/damon/core: implement damon_has_probe_weight()
Date: Thu,  9 Jul 2026 18:18:25 -0700
Message-ID: <20260710011826.113252-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710004650.B09281F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 00:46:50 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] When probe weights are enabled, `damos_apply_target()` aggressively merges adjacent regions regardless of their `probe_hits`, permanently losing monitoring data.
> - [High] Setting probe weights on unsupported operations backends (like DAMON_OPS_VADDR) silently disables all memory monitoring, breaking the DAMON core logic.
> 
> Pre-existing issues:
> - [High] Calling `damon_call()` on an inactive DAMON context leads to an indefinite hang in `wait_for_completion()`, allowing a local DoS via sysfs.
> --
> 
> --- Patch [15]: [RFC PATCH v1.3 15/19] mm/damon/core: implement damon_has_probe_weight() ---
> commit 55c8b58c370f614fee60cf04b8ed7e90eb167302
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_has_probe_weight()
> 
> damon monitors only data attributes when probe weights are set.
> However, the function for detecting it is intentionally returning false
> always. Complete the mode detection function so that the mode can really
> start working.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 91964336ce31e..806a67d02a6e9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -211,6 +211,12 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
> >  
> >  static bool damon_has_probe_weights(struct damon_ctx *c)
> >  {
> > +	struct damon_probe *p;
> > +
> > +	damon_for_each_probe(p, c) {
> > +		if (p->weight)
> > +			return true;
> 
> [Severity: High]
> Does returning true here cause adjacent regions to be aggressively merged in
> damos_apply_target(), resulting in the loss of monitoring data?
> 
> When access_check_disabled becomes true, nr_accesses remains 0. In
> damos_apply_target(), regions with identical nr_accesses and age are merged
> to repair quota-induced splits:
> 
> mm/damon/core.c:damos_apply_target() {
>     ...
>     prev_r->ar.end = r->ar.end;
>     damon_destroy_region(r, t);
>     ...
> }
> 
> Since damos_apply_target() unconditionally merges these regions without
> combining the probe_hits arrays, does this permanently destroy the
> fine-grained probe_hits data?

No issue.  Sane users shouldn't run DAMOS in attrs only monitoring mode.

> 
> [Severity: High]
> Can returning true here also silently disable memory monitoring if the
> operations backend does not support probes?
> 
> If a backend like vaddr or fvaddr is used, damon_valid_probe_params() does
> not verify if ctx->ops.apply_probes is implemented before allowing probe
> weights.
> 
> When this function returns true, standard access checks are bypassed:
> 
> mm/damon/core.c:kdamond_fn() {
>     bool access_check_disabled = damon_has_probe_weights(ctx);
>     ...
>     if (!access_check_disabled && ctx->ops.prepare_access_checks)
>         ctx->ops.prepare_access_checks(ctx);
> }
> 
> Because ctx->ops.apply_probes is null, neither standard accesses nor probe
> accesses are evaluated. Will the kdamond worker thread spin without
> recording any memory activity?

Intended behavior.

> 
> > +	}
> >  	return false;
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but is there a risk of an indefinite hang when
> calling damon_call() from sysfs?
> 
> Looking at the sysfs store functions for reclaim and lru_sort, they invoke
> damon_call() without verifying if the kdamond thread is actively running:
> 
> mm/damon/reclaim.c:damon_reclaim_commit_inputs_store() {
>     ...
>     if (!ctx)
>         return -EINVAL;
> 
>     err = damon_call(ctx, &control);
>     ...
> }
> 
> If commit_inputs is written to while the module is disabled, damon_call()
> will enqueue the request and block indefinitely on wait_for_completion()
> because there is no kdamond thread to process the queue. Could we check
> damon_is_running() before calling damon_call()?

No.  call_controls_obsolete avoids this problem.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710002349.111414-1-sj@kernel.org?part=15


Thanks,
SJ
