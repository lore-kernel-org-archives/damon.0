Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC023BB9FA
	for <damon@lists.linux.dev>; Mon, 22 Jun 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139366; cv=none; b=u+hvtVYaq5Xoo/E+2MGF3/goQ7wJBENXZZ0NDIPm6r/wOpw8IO/aWgJsrt5yWksJoL0ws5wUkmJ/cKQEK5HtKINLuFpehyD2K6hFvZAIrHKaxIvH0lQk1P7DBpQcJqx3SPA3S7+geEwgkOD4yOTeVuBoEj/2MxfvS5lVsmHs/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139366; c=relaxed/simple;
	bh=03K94X4UMSG79ylNrYz0NZHFAhZL3TH0d9rc9BbUcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZyIumZdlRcObeVVzMMWYgN3Ehc7oZ+2lUX4QutNlZdSixgo+M4xhmJ8I86YKzGlmA/acNOR/pwWJ4MvCOVLHF+8iX0y4ZH9sw95UDdO8lv+JS4XbV8qaXTjCNuBGYdwceLTcOMCnmGT3mt5SOfwyEOI4j7zYwDfX2/CAMIGn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv5Oz1e9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv5Oz1e9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214E31F000E9;
	Mon, 22 Jun 2026 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139363;
	bh=YezYGtkryiZLgXkaNugLl+IWvfuR7+c1gh//oa7gclU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kv5Oz1e9GykFG874v+PReChENy1j+zpSvo2BLhn12UyF679BpACoCaNYxLxK/WOpp
	 TIGmm5QcGWabIylcqVv37fWSuQZX7/Jg8HHrXE++K3MtN5qba+IX7uZYzSR9Ts0IOt
	 3uDFhGnwf80Ux88A5xYIPCJOkHjE5LiSEp6NtLEE6jhd5RPwxWgXBoeWKEtp5Pj5nZ
	 G7Nm7G45CGme0jKbnhtyjwAj75T5GUCdudIt6wCNx5oWbUbDk11jWdXkfhkol2Lmq/
	 HemEW3K2+NaZktvKEc8/1lNtSgtXIn6Uv15p0ccqICjG1LsfiRhbB084tygzHgTQIS
	 XXm2BHNXit+tQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 2/2] mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore
Date: Mon, 22 Jun 2026 07:42:33 -0700
Message-ID: <20260622144234.31725-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142428.157D61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Jun 2026 14:24:27 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] The patch attempts to fix an out-of-bounds array access by capping `freq_subscore`, but fails to account for integer overflow, leaving the vulnerability fully exploitable.
> - [Critical] The `hotness` weighted average calculation is vulnerable to integer overflows via unchecked user-provided weights, leading to an arbitrary out-of-bounds array write.
> --
> 
> commit 0014f07b693432d299630c4586e19c0cad5fbec9
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore
> 
> When a zero sampling interval and a zero aggregation interval are
> online-committed, some regions could have nr_acceses values that are
> larger than damon_max_nr_accesses() for the remaining aggregation window.
> This commit attempts to fix out-of-bounds array accesses by applying an
> upper bound of DAMON_MAX_SUBSCORE to the freq_subscore.
> 
> Link: https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index 5c93ef2bb8a97..8d516851a69e4 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -115,6 +115,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
> >  
> >  	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
> >  		damon_max_nr_accesses(&c->attrs);
> > +	/* TODO: update monitoring results always to avoid this. */
> > +	if (freq_subscore > DAMON_MAX_SUBSCORE)
> > +		freq_subscore = DAMON_MAX_SUBSCORE;
> 
> [Severity: Critical]
> This is a pre-existing issue, but does the new bounds check fully prevent the
> out-of-bounds access if freq_subscore overflows and becomes negative?
> 
> Since r->nr_accesses is an unsigned int and DAMON_MAX_SUBSCORE is 100,
> r->nr_accesses * DAMON_MAX_SUBSCORE is evaluated as an unsigned int.
> 
> If a user previously configured a large aggregation interval, r->nr_accesses
> can grow up to ~22,000,000. If intervals are then online-committed to 0,
> damon_update_monitoring_results() skips scaling, leaving nr_accesses at
> its large value, while damon_max_nr_accesses() returns 1.
> 
> When r->nr_accesses * 100 exceeds 2^31 - 1, the division result assigned
> to the signed int freq_subscore overflows and becomes a large negative value.
> 
> The newly added check if (freq_subscore > DAMON_MAX_SUBSCORE) uses signed
> comparison, evaluates to false for negative values, and entirely bypasses
> the clamp.
> 
> This negative value propagates to the hotness score. Finally,
> damos_adjust_quota() implicitly casts this negative score to an unsigned int
> array index, resulting in a huge offset causing an arbitrary out-of-bounds
> memory write on c->regions_score_histogram.

Nice finding.  I will fix this in the next revision.

> 
> [Severity: Critical]
> This is a pre-existing issue, but can the hotness weighted average calculation
> overflow and bypass the DAMOS_MAX_SCORE bounds?
> 
> The user-configurable weights freq_weight (s->quota.weight_nr_accesses) and
> age_weight (s->quota.weight_age) are set via sysfs without upper bounds,
> allowing them to be arbitrarily large.
> 
> In damon_hot_score(), the hotness is computed in 32-bit unsigned arithmetic:
> 
> mm/damon/ops-common.c:damon_hot_score() {
> 	...
> 	hotness = (freq_weight * freq_subscore + age_weight * age_subscore);
> 	if (freq_weight + age_weight)
> 		hotness /= freq_weight + age_weight;
> 	...
> }
> 
> If the weights are chosen such that freq_weight + age_weight wraps around
> UINT_MAX to a small value (e.g., 2), the numerator also wraps.
> 
> When the wrapped numerator is cast to the signed int hotness and divided by
> the small unsigned sum, C's usual arithmetic conversions promote the negative
> int hotness to a huge unsigned int before division.
> 
> The final scaled result entirely evades the intended DAMOS_MAX_SCORE bound,
> returning an arbitrary out-of-bounds index that damos_adjust_quota() uses
> for an unsafe write on c->regions_score_histogram.

Nice finding, but not necessarily part of this series.  I will separately work
on this.


Thanks,
SJ

[...]
