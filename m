Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEC3A254D
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614530; cv=none; b=umFf5ZoyNk9PvMXW7EhQsQ04dwaYvGLcIw8WlQwpQIZNEZp+Zjsw1d5hTL3FnlOd1Q9MhgNcc63JDa+RPTtw9vDyXtORdaCwMc33Af2gnNiPOuzTBanSx5oYXCf6ElYJzWe8UwJQv1hXNMNcdYzce9pOuN52mGX1A06atapqH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614530; c=relaxed/simple;
	bh=QaF5Sc0USMk9CkzkzO9aa5GQ6rByT36Y1qng+sOq+cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+Ff0hAY0+w4A7wI7hlLri2qjFW1TZNMS3VIXoUXAABm5tjiGZcv+R/0xFPfgQv8ulQzrnzwm57+DjLXEwT28KZLz90xL9Y0V3UtJDq0QAl7GoZDgTVqIiRL/9Jk/KIuHi1hStuIg1OthFUhCrr/UENQ0KYblg7dbnjFlF8epOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntoHYsyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntoHYsyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8915A1F00AC4;
	Sat,  1 Aug 2026 20:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785614528;
	bh=iH179kg7ONDwIFSBaMgekfikAlg2RvRr7jkm6ciUK18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntoHYsyGvd0cTVFRViD5RCRTRfep1gNd6T8OS5qfPrp8tm7dPJlKIpS1giO8HEZxo
	 KW8yhRGxxbmW+W6roPHm20O7sGIypg4G2sNhCaxcbHHaJ65hid2/lBQfZ1wXn6BhKW
	 H/BMERlwA0JHA//P5H1gzlPxmbAhcVcw50GfibvICuANMqeZaOS33h60PfeK+7gnAr
	 Hkz8OFEVrosWUwRp7O7qDRv6ZaNZJbbmO2UnvqrWc4yD5UlwhDXpZsi2kabR6evGn4
	 Y0Yo4exx4AhoKzpxPfiMxmGCJwxWuA8Ue6+VM3ODTSpexU01XYC/2VkK37+PghTU7k
	 ZQKF13XwhGqHg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  1 Aug 2026 13:01:59 -0700
Message-ID: <20260801200200.114003-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801175335.2D7E21F00AC4@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 17:53:34 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unhandled failure of damon_split_region_at() in damos_filter_match() leads to bypassing or incorrectly applying address filters.
> --
> 
> --- Patch [1]: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if region split for quota fails ---
> commit 812934b542c69c596afadb66403f8c9c11c5bf91
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: skip applying scheme if region split for quota fails
> 
> damos_apply_scheme() splits a region and apply the action to the
> subregion if it is needed for not violating the quota.  The split
> operation (damon_split_region_at()) could fail for allocation failure.
> In the case, the quota could be violated.  From the user's perspective,
> DAMOS becomes more aggressive than expected under the extreme situation.
> Handle the failure.
> 
> Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..e2900d0c984c9 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2613,7 +2613,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  					c->min_region_sz);
> >  			if (!sz)
> >  				goto update_stat;
> > -			damon_split_region_at(t, r, sz);
> > +			if (damon_split_region_at(t, r, sz))
> > +				goto update_stat;
> 
> [Severity: High]
> This is a pre-existing issue, but since we are handling the failure of
> damon_split_region_at() here, should we also handle it in
> damos_filter_match()?
> 
> If a memory region partially overlaps a filter range and the split
> allocation fails in damos_filter_match(), the return value is ignored:
> 
> mm/damon/core.c:damos_filter_match() {
>     ...
> 		/* start before the range and overlap */
> 		if (r->ar.start < start) {
> 			damon_split_region_at(t, r, start - r->ar.start);
> 			matched = false;
> 			break;
> 		}
> 		/* start inside the range */
> 		damon_split_region_at(t, r, end - r->ar.start);
> 		matched = true;
> 		break;
>     ...
> }
> 
> If the split fails, the intact region spanning both outside and inside the
> filter range is unconditionally evaluated as 'matched = false' or
> 'matched = true', incorrectly bypassing the filter or applying it to unrelated
> memory outside the intended range.
> 
> Could this lead to destructive actions (e.g., PAGEOUT) being applied to
> explicitly protected memory?

Nice catch.  I will fix this together.

> 
> >  		}
> >  		if (damos_core_filter_out(c, t, r, s))
> >  			return;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=1


Thanks,
SJ
