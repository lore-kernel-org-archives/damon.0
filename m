Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3544C4FC
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542150; cv=none; b=ShK+dj9LHplj0XlOl+v2NztZ0XHxsPScTQR2G23XnkNbpAlwYjkQQl6ND0cE6d8LyiHPsBGLRtVPpqD9fWAO3PKdQf4DywAehKuoAOIdOPAI7iakxVFtYoWEpG46fnjV7SsjhF4mqy170rdgWQewO46Bl87EfSmTba/l52XyXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542150; c=relaxed/simple;
	bh=8VCb3o8p7d1i0ussM8J0cI2yuz6LFcWhCylbVLKOaTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lesYSTYvn4sn3z82HI/DmhinEOXIIRxQkbQxK72vwcuGlQqG0hQfsIumlL4d2dEjEHpUzOVQXt9DQkXNpeFWqj0FP1/Cvk0Jar11eJsQ2mUUX+vxWQSvHDBXfRwtc72KNG6WMt3nR7qV7wY9iR1Z0VJ1u4eoayCAl3YmSwaehS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpVV2hIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpVV2hIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824EA1F00A3A;
	Wed, 12 Aug 2026 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786542148;
	bh=TEPRUZ0t81BxzwBAiKjBNf4i+EmsztPZ/0aaEv0v6hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XpVV2hIff6E8NS34TVWcbUyiZlcq+6udFPE1hZUDgRxz4+YINUz9kRNRgUKyzp/m8
	 uNkJYksX9UJwlP0ek3TYQ2OcCuELQfdzyTMjeBntM/o07cnvhrGPuQE6UVCIppulIy
	 6XBBW89t7SwXYcE5e23+XUhbnWrxk4agFfJngi+DyKkrDq3anSVHUd8ajHhxbtfRAo
	 LCKKR9KfMG+TQP46hx761J2IqvfLpPDDHr1DAqwR0T544aeamYudaa0o8+cjTwInXb
	 Li8SldZZBuj465sQWeA7NAIMBSm4LxBFv4m+QDMmZNSF3EDtYZZl2L8otmA41NoHFi
	 MYYAou25VmDNA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Liew Rui Yan" <aethernet65535@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v2 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots
Date: Wed, 12 Aug 2026 06:42:19 -0700
Message-ID: <20260812134220.86424-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812104719.D72F81F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 10:47:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The commit updates documentation to match buggy code behavior rather than fixing the underlying logical flaws in the `nr_snapshots` counter. `nr_snapshots` incorrectly increments per target instead of per snapshot, and skips entirely when quotas are full.
> --
> 
> --- Patch [1]: [PATCH v2 1/3] docs/mm/damon/design: accurate semantics of nr_snapshots ---
> commit 11b4a9c760b881c063ff5e1eec0248b087d6a31f
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> docs/mm/damon/design: accurate semantics of nr_snapshots
> 
> This commit updates the DAMON design documentation and header comments
> to align the description of nr_snapshots with the current behavior
> implemented in the code.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index aed6cb1cf4831..1739aeec6eb95 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -846,8 +846,8 @@ scheme's execution.
> [ ... ]
> >  - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
> > -- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
> > -  be applied.
> > +- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is
> > +  completely tried to be applied.
> >  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
> 
> [Severity: High]
> This is a pre-existing issue, but does updating the documentation to match
> the code behavior paper over an underlying logical flaw in the nr_snapshots
> counter?
> 
> Looking at damon_do_apply_schemes() in mm/damon/core.c, the counter updates
> like this:
> 
> mm/damon/core.c:damon_do_apply_schemes() {
>     ...
>         /* Check the quota */
>         if (damos_quota_is_full(quota, c->min_region_sz))
>             continue;
>     ...
>         if (damon_is_last_region(r, t))
>             s->stat.nr_snapshots++;
>     ...
> }
> 
> Because this increments at the last region of a target, if multiple targets
> are present, does the counter incorrectly increment per target instead of
> per snapshot?
> 
> Additionally, if a restrictive quota fills up before the last region of a
> target is processed, the early continue skips the counter increment entirely.
> This could mean a scheme configured with a max_nr_snapshots limit might
> never reach its limit.
> 
> Should the underlying code be fixed to increment once per snapshot regardless
> of quotas and targets, rather than updating the documentation to reflect this
> behavior?

I show no problem at the current behavior.  Let's keep it.  If it really
confuses some real human, we could add clarifications to documents.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812104002.15225-1-aethernet65535@gmail.com?part=1


Thanks,
SJ
