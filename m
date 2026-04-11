Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1404181334;
	Sat, 11 Apr 2026 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930615; cv=none; b=erDMjETpLqU6HUq8dipvkmIS4ll5k2ODimh8J4x4ro2SO6ZRUcC9ap+lMM3w1W9AE0D22pXvAUdjrGxNsop7EyXNHneYic2+79fOW9JInGiuSGYloEdhEbxlW8qSQL3jgDGq7+TP1wGSjMHl/we4EJVEX6NdW2aaApHOaamt4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930615; c=relaxed/simple;
	bh=DBCgDKz+lnsk8HdK5nYVKKWSxqPwPqoy8Cf/9pXeUhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzYTdnAFv2N94yjefYY6Uld1mOnJXjIoSq6ppqPQplafkx9AoADiBZ1PqupELXANsg39m8LpS/YvN13evqqo6UsbgKQLImOYJQjkC+1qQ0CnN7iHdOMA5QGqgdbvMvz+LxNyPpMjKZ7YSnuR+9uG8pWM6PPtxz6IFAb/n8fcaX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGHlTDeB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGHlTDeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52866C2BCAF;
	Sat, 11 Apr 2026 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775930615;
	bh=DBCgDKz+lnsk8HdK5nYVKKWSxqPwPqoy8Cf/9pXeUhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGHlTDeBJv8aIl5PRXUvhhoIvAfsZz0o1q/g7s8Tokd7fdo6E4hZhA5GTXNulfIOt
	 addZt98NFQ/M93/VMLKgvVRujpQTkDJHYnteW5eg3583RLJHaHSWv8vCBVERpHeIXP
	 IACPZ9UXa/VrxQb0O6PlIzZDKoQVPLwb5HsdJomszqlCPFak7WPFjfFd4R9meec29m
	 FFYTbZw1Han3B6t4FTpPa7d10rN2vI20G8G9dg6QgLcouTuGOIdOZMa6kd3KecBEqG
	 p7Ieti/WjikUiPEuJuGDqd0pT6nhpOo0G3pexqAH/IvAueN+bJdvBCHuG0xy8MYtRp
	 oaELcSv906k6Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [RFC PATCH v5.1 02/11] mm/damon/core: merge regions after applying DAMOS schemes
Date: Sat, 11 Apr 2026 11:03:32 -0700
Message-ID: <20260411180333.79709-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: sashiko found a typo and a fact that I forgot adding a fixup that I
promised on the previous version.  I will fix those in the next spin.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260411164908.77189-3-sj@kernel.org
> # start of sashiko.dev inline review
> commit 1a56d6af604a3fc86a23180a9619447641294a2f
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: merge regions after applying DAMOS schemes
> 
> This commit introduces a mechanism to merge regions after applying schemes
> to avoid overhead from regions split during quota-limited scheme application.
> 
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > +static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
> > +{
> > +	struct damon_region *r;
> > +
> > +	damon_for_each_region(r, t) {
> 
> Is this list iteration pattern safe for long-term maintenance? 
> 
> This loop uses damon_for_each_region(), which is an unsafe list iterator,
> but destroys r inside the loop and reassigns r = prev_r to safely continue.
> 
> While this works by relying on internal macro expansion mechanics, if a future
> developer converts this to use damon_for_each_region_safe(), the cached
> next pointer would be evaluated before damon_do_apply_schemes() potentially
> splits the region.
> 
> Could this cause the loop to silently skip the newly inserted slices entirely?

Yes, such mistake could happen in future, and this code could be better written
for long term maitenance.  But that seems better to be revisited as a future
cleanup work.

> 
> > +		struct damon_region *prev_r;
> > +
> > +		damon_do_apply_schemes(c, t, r);
> > +		/*
> > +		 * damon_do_apply_scheems() could split the region for the
> 
> This isn't a bug, but there is a typo in the comment (scheems).

Good eyes!  I will fix this in the next spin.

> 
> > +		 * quota.  Keeping the new slices is an overhead.  Merge back
> > +		 * the slices into the previous region if it doesn't lose any
> > +		 * information.
> > +		 */
> > +		if (damon_first_region(t) == r)
> > +			continue;
> > +		prev_r = damon_prev_region(r);
> > +		if (prev_r->ar.end != r->ar.start)
> > +			continue;
> > +		if (prev_r->age != r->age)
> > +			continue;
> > +		if (prev_r->last_nr_accesses != r->last_nr_accesses)
> > +			continue;
> > +		if (prev_r->nr_accesses != r->nr_accesses)
> > +			continue;
> > +		prev_r->ar.end = r->ar.end;
> > +		damon_destroy_region(r, t);
> > +		r = prev_r;
> > +	}
> > +}
> 
> The commit message explicitly states the merge operation is made only if it
> keeps the min_nr_regions constraint. Does this inline merge logic bypass
> that constraint?

Argh, I forgot adding the fixup [1] to this patch.  I will add that in the next
version.

> 
> Earlier in the execution, damon_apply_min_nr_regions() enforces the limit by
> calculating a size limit and splitting any region larger than this limit into
> smaller sub-regions. These newly created sub-regions naturally inherit
> identical age and nr_accesses values from their parent.
> 
> When kdamond_apply_schemes() subsequently calls damos_apply_target(), this
> logic will immediately merge those freshly split regions back together
> because their age and nr_accesses match, entirely omitting the size limit
> check. 
> 
> Does this unintentionally destroy the spatial monitoring granularity every
> sample interval?
> 
> Additionally, when merging the regions, this code expands prev_r->ar.end and
> destroys r without accounting for r->nr_accesses_bp.
> 
> Since standard functions like damon_merge_two_regions() re-average metrics
> including nr_accesses_bp, could this inline discard of the fractional
> nr_accesses_bp tracking result in a slight precision loss, contrary to the
> commit message's goal of not losing monitoring information?

Yes, that's valid.
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260411164908.77189-3-sj@kernel.org

[1] https://lore.kernel.org/20260411163340.46397-1-sj@kernel.org


Thanks,
SJ
