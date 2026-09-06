Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDE34A3A5
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788721914; cv=none; b=VkJrnduQnxlnV0UJRjqlCfZ8fnNIQ2fwwamMcNZ5G3Ex5Tt7N3VLWfznrUlr0W5Yx22rnpFJQ8kmCu8tA9b+X0AZQYBYYTLCOc5RLkbS7FVx/NuumFh5LwIn0G+k/4OgQr3YJQOSs8FflkLJG+ZG4HRPXh2Bnj5xAI3yX9iBv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788721914; c=relaxed/simple;
	bh=U8tv9lBNtlK8qCQAOiGkel4mAZqm3Bsm542PlSZR03U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpddHU7gDmkKGorOyHUqN4BPAmToqbVdjNSQ1HxQYsNKrATOB5/iKCPK64/nGF8PZnZFaWf4PHzWUF1kXmfbq9k8LFYGdjqhxSmVG4ntpgH3i2jLzujzdi510lDULqTIE4E4QSgmAUiaadbYa06vzbxA4nGMlnBJQpe/OD2eboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHN41jLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHN41jLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE62B1F00A3A;
	Sun,  6 Sep 2026 19:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788721912;
	bh=mWiTmh/TKTWO4zZHJKiA5n2jKG+DjBUgNhfGZmYtI6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHN41jLl+2vVAagFb/J35e8MmfNgW01ZZVQvAKJgUG7jiNL18Q/HtZ5VMFHtimHYR
	 34ou0HnmWNCWtWulqMb+2wa5Hlh7kdWnjX5QZ3PpEgd/ov5ty2OruESbYM91VD3cW0
	 6+v9IZwGaELW8fJE+3G0Vt0omGnLQKtTmHmQcFHmE4MxYBEi1/EmyW8CNKAfaM2s1I
	 ROfdW6EvdvcDvtAxQN82QZgLHoBZHdvYGRkeMcT2wxmXf9/OVxV8h16VQrct90xvEN
	 CQzXcFGAxiVInnqrEJzGQW0lHs+5/3WOQp7jKCA4A19WoFos1dSqjlV4Qg3mltzSgJ
	 vCIjhtWRI2zfg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/core: reset invalid quota->charge_target_from
Date: Sun,  6 Sep 2026 12:11:44 -0700
Message-ID: <20260906191146.98522-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906185831.535EB1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 06 Sep 2026 18:58:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The new `damos_reset_invalid_charge_target_from()` function fails to reset dangling `charge_target_from` pointers for PADDR operations, permanently breaking `damon_reclaim` functionality across restarts.
> --
> 
> commit 6f10f4f2fc1ae76229671b5157f9aa34aed9227b
> Author: SJ Park <sj@kernel.org>
> 
>     mm/damon/core: reset invalid quota->charge_target_from
> 
> This commit fixes an issue where DAMOS suddenly stops working if a target
> process that a quota just fully charged in is terminated. It catches this
> corner case and resets the invalid quota->charge_target_from pointer.
> 
> Link: https://lore.kernel.org/20260830064708.40CA61F000E9@smtp.kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ce8c6f99106ed..2c58be9edbde4 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3283,6 +3283,22 @@ static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
> >  	trace_damos_esz(cidx, sidx, quota->esz);
> >  }
> >  
> > +static void damos_reset_invalid_charge_target_from(struct damos_quota *quota,
> > +		struct damon_ctx *c)
> > +{
> > +	struct damon_target *t;
> > +
> > +	t = quota->charge_target_from;
> > +	if (!t)
> > +		return;
> > +	if (!c->ops.target_valid)
> > +		return;
> 
> [Severity: High]
> This is a pre-existing issue, but by returning early here, does this new
> function fail to clear dangling charge_target_from pointers for PADDR
> operations (like damon_reclaim)?
> 
> If damon_reclaim is enabled with quotas and hits quota exhaustion,
> quota->charge_target_from is set. If damon_reclaim is then disabled,
> damon_stop() destroys the targets, leaving charge_target_from as a dangling
> pointer.
> 
> When damon_reclaim is re-enabled, a new target is created. Because
> target_valid is NULL for PADDR operations, this new function returns early.
> 
> Could this lead to damos_skip_charged_region() comparing the new target
> against the dangling pointer, evaluating to true, and permanently skipping
> all memory reclaim actions?

The problem doesn't exist.  DAMON_RECLAIM does not reuse the last scheme.  Same
for all DAMON API callers.

> 
> > +	if (c->ops.target_valid(t))
> > +		return;
> > +	quota->charge_target_from = NULL;
> > +	quota->charge_addr_from = 0;
> > +}
> >
> >  static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260906183654.95634-1-sj@kernel.org?part=1


Thanks,
SJ
