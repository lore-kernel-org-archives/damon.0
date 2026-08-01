Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F233C22576E
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785616286; cv=none; b=aqPo7c+/pXx51K5C2INXvDY3h6HwG7I1OyhrLpBUIcYh6y+alfP39WK9g+NsEXrHsDA+ow8Nh8TT2nM/9u85Cx/eJF/2x3dL+9WfF1VPW+AP15izWJErtQHsO3guQtCxuhJRKEsxsRoqT7WE4mSYEAjMjzlS6jwwz9LmwIALy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785616286; c=relaxed/simple;
	bh=euiHLnhG1mKc0T4hDsWDYNpeaiGoFJcgBE20s8rrha4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8MZ+7Wdgsw98D9prL9kKfjhggLw7iYm10XseU2DARnEnO0LCOGwCrDuTB3zu3Ka7gObsy/imTJgeoTTzJBN3HBowbYrQwLnknVp18KRotVaqxV8wrIJuYMJn7S/vRotqVixISO6ZTlVVzGFNWgljmCOdbbTILpdBxfQ9v9K7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASNNubEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASNNubEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE8D1F00AC4;
	Sat,  1 Aug 2026 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785616284;
	bh=rXT7dddf6BDwCWvUT9BXN+PI6SMgqrrvpEqxGgCg2Wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASNNubEJ8pVBKG9MQoXTm8pVjbVcmbXmzeJL1eF5hwUprY04VCJ4PxiY5gvJ0UbIp
	 jkWi4TP3E1UVy2FIc6ENle2Ole7mmJPP+Y0/OR0ve75YaUrv6tuGmf5e4GNQlN9Qo/
	 8ngAc997FiNdBp9GmggcGfGQUNAevplq/Y2YqgJ+tHz6avcmmGMtXArzd2XO7BurZN
	 4ZMLOhJOExhkL+rIl54neM64+kdfkbk3tZzgN0e5dsVigLrgcTNkkpOQEy7/9Kg5aQ
	 tSR1wPRo08HHNo5zhbOKc+KBi9UT8Sx799MIJVxRkD0O1Mx43DGkFFrxwW+OmjaIXY
	 1SK/5JRfYYOZQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if region split for quota fails
Date: Sat,  1 Aug 2026 13:31:20 -0700
Message-ID: <20260801203121.117449-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801200200.114003-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 01 Aug 2026 13:02:08 -0700 SJ Park <sj@kernel.org> wrote:

> On Sat, 01 Aug 2026 17:53:34 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Unhandled failure of damon_split_region_at() in damos_filter_match() leads to bypassing or incorrectly applying address filters.
> > --
> > 
> > --- Patch [1]: [RFC PATCH 1/9] mm/damon/core: skip applying scheme if region split for quota fails ---
> > commit 812934b542c69c596afadb66403f8c9c11c5bf91
> > Author: SJ Park <sj@kernel.org>
> > 
> > mm/damon/core: skip applying scheme if region split for quota fails
> > 
> > damos_apply_scheme() splits a region and apply the action to the
> > subregion if it is needed for not violating the quota.  The split
> > operation (damon_split_region_at()) could fail for allocation failure.
> > In the case, the quota could be violated.  From the user's perspective,
> > DAMOS becomes more aggressive than expected under the extreme situation.
> > Handle the failure.
> > 
> > Link: https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 644daf5a16560..e2900d0c984c9 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2613,7 +2613,8 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> > >  					c->min_region_sz);
> > >  			if (!sz)
> > >  				goto update_stat;
> > > -			damon_split_region_at(t, r, sz);
> > > +			if (damon_split_region_at(t, r, sz))
> > > +				goto update_stat;
> > 
> > [Severity: High]
> > This is a pre-existing issue, but since we are handling the failure of
> > damon_split_region_at() here, should we also handle it in
> > damos_filter_match()?
> > 
> > If a memory region partially overlaps a filter range and the split
> > allocation fails in damos_filter_match(), the return value is ignored:
> > 
> > mm/damon/core.c:damos_filter_match() {
> >     ...
> > 		/* start before the range and overlap */
> > 		if (r->ar.start < start) {
> > 			damon_split_region_at(t, r, start - r->ar.start);
> > 			matched = false;
> > 			break;
> > 		}
> > 		/* start inside the range */
> > 		damon_split_region_at(t, r, end - r->ar.start);
> > 		matched = true;
> > 		break;
> >     ...
> > }
> > 
> > If the split fails, the intact region spanning both outside and inside the
> > filter range is unconditionally evaluated as 'matched = false' or
> > 'matched = true', incorrectly bypassing the filter or applying it to unrelated
> > memory outside the intended range.
> > 
> > Could this lead to destructive actions (e.g., PAGEOUT) being applied to
> > explicitly protected memory?
> 
> Nice catch.  I will fix this together.

But, it is unclear what to do in this case.  Maybe it is better to just back
off and cancel the DAMOS action.  And that would be no small change.  I will
work on it separately.

> 
> > 
> > >  		}
> > >  		if (damos_core_filter_out(c, t, r, s))
> > >  			return;
> > 
> > -- 
> > Sashiko AI review · https://sashiko.dev/#/patchset/20260801173554.94710-1-sj@kernel.org?part=1
> 
> 
> Thanks,
> SJ
> 


Thanks,
SJ
