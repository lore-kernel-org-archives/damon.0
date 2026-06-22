Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77730F7F7
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140018; cv=none; b=O2tuQSqrcySdXC2PyWxpVSGQOWz0IdtabhJF/H7UNPgyi+5cC/HT9gJ2rv6B209AMbcVLrHLhCHqrPdXZYi5pqymjR51ItVSTH0G2HZojYEgi70DAyjxdL0pOYIuaKITjl0jPTCtcZVrPjB3BW5dWk6mqkFxzNRSnZfnjX01WXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140018; c=relaxed/simple;
	bh=3XQvtP9G6kMVdoa0SDcsYvLcA+Smtb8LRohkBETGb8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNzE5xZhgcN6lg1UH8fJQR/O0EUVQxtbwICGhDnPrUA53QRdmStJ6PoXMYuSq7+X6hlK3lOenzvb6EwqEHxZPLZ3/deUarATLzBO5opkOTaA8DXxhxTVkqDHB1wevoxeUOkgmfd8WoOsagVWgvTcOBTW+sej0XbW/eOh4qSsfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta7sDrtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta7sDrtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512031F000E9;
	Mon, 22 Jun 2026 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782140017;
	bh=JSCf837z55768NT9pPnNeadMVHFosgBKJTj9gMoyxyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ta7sDrtcpbd9Unkiq15zdG2Yp6CSjZjDn6Swvzk761BWUCG7EDwvU3eSDa66lOYNm
	 oCkNLH21PRCyNor5B7qzYaq3rl3gL+ERrfQecGWfyk3M/GDA9bbyFSlABiL3ISKDZr
	 shnEUWNsXiMHXdQHwbbTINLCMEheIlj6V5fq7ilF6eFk3FYFWfpruTDM+A4ritovz1
	 i3UTyjRlK8bOuTfO5gG1cPC9hR5kY+REf0kFuz4IitWXl3nnjGkfB//OJ8dHDo4oW4
	 hEacOyti2GYYTJRsn+RTtUQWLrdSeLkDefI0QNc24JdvjJB4rFuK6xBdqzsPedmrCr
	 m5NPxqOsIAdow==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 2/2] mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore
Date: Mon, 22 Jun 2026 07:53:27 -0700
Message-ID: <20260622145328.32421-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622144234.31725-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 07:42:43 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 22 Jun 2026 14:24:27 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [Critical] The patch attempts to fix an out-of-bounds array access by capping `freq_subscore`, but fails to account for integer overflow, leaving the vulnerability fully exploitable.
> > - [Critical] The `hotness` weighted average calculation is vulnerable to integer overflows via unchecked user-provided weights, leading to an arbitrary out-of-bounds array write.
> > --
> > 
> > commit 0014f07b693432d299630c4586e19c0cad5fbec9
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore
> > 
> > When a zero sampling interval and a zero aggregation interval are
> > online-committed, some regions could have nr_acceses values that are
> > larger than damon_max_nr_accesses() for the remaining aggregation window.
> > This commit attempts to fix out-of-bounds array accesses by applying an
> > upper bound of DAMON_MAX_SUBSCORE to the freq_subscore.
> > 
> > Link: https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > > index 5c93ef2bb8a97..8d516851a69e4 100644
> > > --- a/mm/damon/ops-common.c
> > > +++ b/mm/damon/ops-common.c
> > > @@ -115,6 +115,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> > >  
> > >  	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
> > >  		damon_max_nr_accesses(&c->attrs);
> > > +	/* TODO: update monitoring results always to avoid this. */
> > > +	if (freq_subscore > DAMON_MAX_SUBSCORE)
> > > +		freq_subscore = DAMON_MAX_SUBSCORE;
> > 
> > [Severity: Critical]
> > This is a pre-existing issue, but does the new bounds check fully prevent the
> > out-of-bounds access if freq_subscore overflows and becomes negative?
> > 
> > Since r->nr_accesses is an unsigned int and DAMON_MAX_SUBSCORE is 100,
> > r->nr_accesses * DAMON_MAX_SUBSCORE is evaluated as an unsigned int.
> > 
> > If a user previously configured a large aggregation interval, r->nr_accesses
> > can grow up to ~22,000,000. If intervals are then online-committed to 0,
> > damon_update_monitoring_results() skips scaling, leaving nr_accesses at
> > its large value, while damon_max_nr_accesses() returns 1.
> > 
> > When r->nr_accesses * 100 exceeds 2^31 - 1, the division result assigned
> > to the signed int freq_subscore overflows and becomes a large negative value.
> > 
> > The newly added check if (freq_subscore > DAMON_MAX_SUBSCORE) uses signed
> > comparison, evaluates to false for negative values, and entirely bypasses
> > the clamp.
> > 
> > This negative value propagates to the hotness score. Finally,
> > damos_adjust_quota() implicitly casts this negative score to an unsigned int
> > array index, resulting in a huge offset causing an arbitrary out-of-bounds
> > memory write on c->regions_score_histogram.
> 
> Nice finding.  I will fix this in the next revision.

Hmm, no.  This is not related to zero interval.  I will fix this out of this
series.


Thanks,
SJ

[...]
