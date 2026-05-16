Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10302C859
	for <damon@lists.linux.dev>; Sat, 16 May 2026 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891004; cv=none; b=DSTVkX1jsfht7XkjF/wZTKlCl75qw2uxx08Njoshb3kt6ITLvDzZSDjLDPVX1alARxE3VHTfYwmAAw4xspf4noK0/Y8b6mIyv0+78bQSFu05F52kQAs+4rE/kgsVxgDeC8uaAkELEtAHcFrLPp8WEBPW90O3EmQZxFbQL3PWU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891004; c=relaxed/simple;
	bh=j4lMpTT0K+ckxnLb6dL7BP1yPU0WdlvV9EsnCcbt3XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdJ6fKgxCSg7tzlosAYIW6NjbQn0pFmj0CJk8Q+OoV2hFNJ/BE5Z/As9n+hShtHztgXKxnN3TCF2bTH7aThfBB8iwl/wOaAwZly6dNwCZEPweWWfyA0a6mzJkcQv/4YHSLypJM+x2bB4VxHmLTeueHsbf1iz8INadTxx6O5JFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGKZ3q/L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGKZ3q/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45841C2BCB0;
	Sat, 16 May 2026 00:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891004;
	bh=j4lMpTT0K+ckxnLb6dL7BP1yPU0WdlvV9EsnCcbt3XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGKZ3q/LRepAZl4huPnHjfTjnMRZgiq/5MCZWC4BHRWjjSKnwT5bpovTPRB5ozndl
	 2+6GgVo84YSwDGwrQdCH5Ee15/cpry7gOvFZPwQaYZQXH5BoWRg2Q766dtoeKHm0N3
	 hfKLWDnkWj+OpihMDEGa3eIA6oBuPeCnzb/NlE9cqTLfEhCJ8Z0SMG4Zo4dMOSaUQJ
	 FQg4ReWgMussbyus1fX8KuoR1FRS4KKBWBh7C+GEMuaATOAi0a7dHmgpz4us1r+q/a
	 vHwISST2BxqCkpgemUMMNnmWfn8z+dcpkroMUkpwHWoIesCYBy+aKo64/XwtP+z2Ul
	 6yVyuklXO2W7A==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 04/28] mm/damon/core: commit probes
Date: Fri, 15 May 2026 17:23:14 -0700
Message-ID: <20260516002315.138017-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515010529.05E7EC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:05:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] In `damon_commit_probes()`, a newly allocated `new_probe` is added to the destination context before its filters are committed, leaving a partially constructed object on failure.
> --
> 
> commit 2686f1a22f9199eacddb5ee3b2612cd585a68b00
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: commit probes
> 
> This commit updates damon_commit_ctx() to additionally commit any installed
> data probes to the destination context.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 44943d654dcce..15f2795a1156f 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1378,6 +1413,72 @@ static int damon_commit_targets(
> [ ... ]
> > +static int damon_commit_probes(struct damon_ctx *dst, struct damon_ctx *src)
> > +{
> > +	struct damon_probe *dst_probe, *next, *src_probe, *new_probe;
> > +	int i = 0, j = 0, err;
> [ ... ]
> > +	damon_for_each_probe_safe(src_probe, next, src) {
> > +		if (j++ < i)
> > +			continue;
> > +
> > +		new_probe = damon_new_probe();
> > +		if (!new_probe)
> > +			return -ENOMEM;
> > +		damon_add_probe(dst, new_probe);
> > +		err = damon_commit_filters(new_probe, src_probe);
> > +		if (err)
> > +			return err;
> 
> Does this leave a partially constructed probe in the destination context on
> failure?
> 
> If damon_commit_filters() returns an error, the function returns immediately,
> but new_probe has already been added to dst via damon_add_probe().

Yes, it leaves the partially constructed probe.  And the caller will destroy it
when the error is returned.  If the destination is a running DAMON context,
kdamond_fn() stops, using 'maybe_corrupted' field.

> 
> This differs from the pattern in damon_commit_targets(), where new objects
> are only added to the destination list upon success, and are destroyed if
> the commit step fails.

No, the function also returns error immediately leaving partially committed
targets on the context.


Thanks,
SJ

[...]
