Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8E2DB78B
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609425; cv=none; b=Xe6kzcDcmfalqtM95u+mi7F8tREona62eHIdbF7wYVp4ZjqpZFxwFaIepd5uA0cpyaK4ADgAhFGDyKt0teyffVFs8UQhfn3+S6x/hQWWsXn2tvimeue9PmpC31vCbo+qpDyDCk5EfDFo6OSZR0LsyKffJNFA/9N5Y8CAtj2JBDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609425; c=relaxed/simple;
	bh=8399ATeaGVaF1KoMVqbyzCVQv5c3Gs4IJXUsk0Mep+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAm2fOAKXzc6PhBb5MRRXjp2zlflQvWxE1lXjOoboy2g2UJKtxF/dQIle1NYACjnL7zT3naR0v/PuedNcASSy0/bjjWKVAlptGSw65mTchIJ6C6IE2R/2kG1PzZglEMUk8B70KZuwwWMf4tAqR0QmlLwFMQBy3JtXHb8owps2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu64psNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu64psNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FD71F000E9;
	Thu,  9 Jul 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609424;
	bh=4kOQAI9BzMR4dG2o4NKVuRI/580PFDJWCsdkV8kZT48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eu64psNPwRXUufFJMbl2GDJKiM+tQBKOvrS8rzq1mISEiYQ/9iAdXExRYKBURPBtd
	 XxDaSvUB+NC10yHIdBH0RRDftGeKmkv4hw9Kcaz7DkdDp+ajsYSqnypbdAxwWKzBf8
	 HW55QZfH2HYQfvyY0Xp6u5ZUJBQ/+9L1wgZwEgvDRwBgyDHV5yIvh27HfDYCUJ8eeM
	 hB9Gykj1JR6bnWbwZjDltjtw/lp2/un6YlcpJyubIjPR4fFlKYmKH9wWVHuOJwYc6r
	 uwsmS77fhMe52IWw3/6ToCwP6RboneNc/dvDuu0903oh37NYo1wUQiqUOXoQIfaRq6
	 eXjNbq4tQK4mw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 15/19] mm/damon/core: implement damon_has_probe_weight()
Date: Thu,  9 Jul 2026 08:03:34 -0700
Message-ID: <20260709150335.97180-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709145652.BD7CC1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 09 Jul 2026 14:56:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Enabling probe weights for DAMON operations that do not implement `apply_probes` (e.g., VADDR and FVADDR) silently disables memory monitoring and region aggregation.
> --
> 
> --- Patch [15]: [RFC PATCH v1.2 15/19] mm/damon/core: implement damon_has_probe_weight() ---
> commit 13bb6c9724d49615512e0e4f353c5d02210d2c11
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_has_probe_weight()
> 
> This commit completes the implementation of damon_has_probe_weights()
> to return true if any probe has a non-zero weight. This allows DAMON
> to detect probe weights and use them for monitoring.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 12c66edecd783..6661d4bfab5b9 100644
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
> > +	}
> 
> [Severity: High]
> Does this silently break monitoring for operation sets that do not implement
> apply_probes?
> 
> When this function returns true, access_check_disabled evaluates to true in
> kdamond_fn():
> 
> mm/damon/core.c:kdamond_fn() {
>     ...
>     bool access_check_disabled = damon_has_probe_weights(ctx);
>     ...
>     if (!access_check_disabled && ctx->ops.prepare_access_checks)
>         ctx->ops.prepare_access_checks(ctx);
>     ...
>     if (!access_check_disabled && ctx->ops.check_accesses)
>         max_merge_score = ctx->ops.check_accesses(ctx);
> 
>     if (ctx->ops.apply_probes) {
>         ...
>     }
>     ...
> }
> 
> If a user configures probe weights for operation sets that lack apply_probes,
> all access checks are skipped. Since apply_probes is NULL, no memory access
> information is gathered at all. This causes regions to endlessly report 0
> accesses and incorrectly merge up to the maximum limit.
> 
> Should __damon_commit_ctx() or damon_valid_probe_params() validate that
> ctx->ops.apply_probes is non-NULL when probe weights are used, returning
> -EINVAL to prevent this failure?

This is an intentional design.  Users should correctly set DAMON.

> 
> >  	return false;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260709140600.90950-1-sj@kernel.org?part=15


Thanks,
SJ
