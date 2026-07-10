Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771B223DE7
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695335; cv=none; b=SbV46CpCY0o3cSWop1VNg1LH8IeO6t54W9k9A6Y7O7J0D8VIkkhuAczUTBkOAQzjTlolh348vljrpzQZ2ERv0iP9gkmLBUeTE3JU3rCM0YdFTy+HEL9DWtHjLajUWlK3E72NOEaHX7pLrwnIs6pRJOfBJhyW4y5qlBVs+bxkHfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695335; c=relaxed/simple;
	bh=UK9h95HBt1KeJL97rnC61hBZm08uJkO6pgXw3+sVbv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UK+kjGiCwfPOvGrYambi8vsH/LoJBXgAzuNXfPuj2nqYt/ujtMaJn8oYj1sMWjNSa46FZjQ2dQrWBynsTUSoG39bqyaVgF0bxgUMb23qNKrCkzp+amBYesRtC5yZuNk/9fIzv49mjN6EA12qkiZ+qKGepjSWFjf2qnb69a51zOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEHt/RCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEHt/RCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75871F000E9;
	Fri, 10 Jul 2026 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695333;
	bh=Y5BeGqv8lOD+D8MAS/Tw7RCeUilkSfQtu4S1gga17TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eEHt/RCw8DiEpWAoLKNQy9A9vsfPi0hjFsa5iTow/FLXa3osFpP8u2ZozB7jwEUlu
	 Z6elUo8OXX2EZMLJWhFn0IqVf/IVLLrTb0cOzdM5LmXpQmlzOOAawFcJpfuVew2a3I
	 OtcoWLE0G1FtpnhQiLUzCC3fad2kEHgVWu0kMfVgHc+suD93XgJeDRtKeGtJod13Ge
	 7YGzaCjr5jLV0+y5mW9ZUyHE19PK6/F25Ht8mWaAAl3aZjcA5csOjU3W0n0lhTnh8K
	 J+SCDuS60dYjatl/Ejen9UgtUC/xmL7756yoQf2UHeLrnLM3CMqwZtyP+rOD6ORxCB
	 mWI+vkiFaAWDw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 15/19] mm/damon/core: implement damon_has_probe_weight()
Date: Fri, 10 Jul 2026 07:55:29 -0700
Message-ID: <20260710145530.27524-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710141100.AADA91F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:11:00 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Setting probe weights unconditionally disables access checks without validating if the active operation set supports data attribute probes (`apply_probes`), silently breaking monitoring.
> --
> 
> --- Patch [15]: [PATCH 15/19] mm/damon/core: implement damon_has_probe_weight() ---
> commit 7b3dfd9b2d27b35cdf18598b48bc4927675cb47a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: implement damon_has_probe_weight()
> 
> This commit updates damon_has_probe_weights() to properly iterate over the
> probes and return true if any probe has a weight configured. This enables the
> data attribute monitoring mode that previously returned false intentionally
> during incremental development.
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
> > +	}
> 
> [Severity: High]
> If a user configures a DAMON context with an operation set that does not
> implement apply_probes (e.g. vaddr operations) and adds a probe with a
> non-zero weight, will this silently break monitoring?
> 
> With this change, damon_has_probe_weights() returning true will skip
> standard access monitoring in kdamond_fn():
> 
> mm/damon/core.c:kdamond_fn() {
> ...
> 	bool access_check_disabled = damon_has_probe_weights(ctx);
> 	unsigned int max_merge_score = 0;
> ...
> 	if (!access_check_disabled && ctx->ops.check_accesses)
> 		max_merge_score = ctx->ops.check_accesses(ctx);
> 
> 	if (ctx->ops.apply_probes) {
> 		/* bypassed if apply_probes is not implemented */
> 		...
> 	}
> ...
> 	/* max_merge_score remains 0 */
> 	if (time_after_eq(ctx->passed_sample_intervals,
> 				next_aggregation_sis)) {
> 		kdamond_merge_regions(ctx, max_merge_score / 10, sz_limit);
> ...
> }
> 
> Should damon_valid_probe_params() or damon_has_probe_weights() also verify
> that ctx->ops.apply_probes is implemented before allowing this mode, to
> prevent kdamond_merge_regions() from unconditionally merging regions with
> a threshold of 0?

No issue.  This is an intentional behavior.

> 
> >  	return false;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=15


Thanks,
SJ
