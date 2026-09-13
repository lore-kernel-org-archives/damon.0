Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A33361DD0
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320711; cv=none; b=XUGGUi25vOHV6l1R2yahGUSVp25quf6TYllhnJujXxkdlZe2VqFwDZWy8FYsnwKLFjWFCRPT2sjrhR+R2xCUuKh33DJVmWMD6tXVA1MlXmKum+CXIxroQPhPcPUnfGtnAndobFfPH0t673AveTNkmko57Q2QN+mfwoOttxXtbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320711; c=relaxed/simple;
	bh=Iuc8sDH6/N4d5kZ1vmAJXRfpRjUKEEWwU9fBxlo28CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rl/Qyrrkz5jXf6AQNoCHZLU8YR4Ijr8UheEUcPYz81k5arbRQbdmuZrwUlue8mabeqwxpreowy0k7j8LlFme7mFejMuFP/T+NzwXqv2ypFvdxqBEL+l9S9bE3UzueRCfkrO8ndtmADpb0gLF71rDNxaMvkhi66D118DFT57No5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQa7bkoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQa7bkoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811831F000FF;
	Sun, 13 Sep 2026 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320710;
	bh=rAO96OgDDnE9IQUDzrf/TmvsNo79mv2gpF/JNrekpH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQa7bkoWV8NMhftWC1iMyZXMQF/ohHdC0OevY/82fh2YF6FnXEcizmeiXvaHGFQRU
	 bsXo3lZJVzJ+CFM/WUbweSCkIpps31d3ZcTfDUlZAGAjAugp5GpKh9GMrTesJ+0r7k
	 htnCPb8iZk+En7iaZq7spai085le1pJL1twHeFshQN8yOViURA+ronOzL92rPWs3zv
	 No7SKNcoUi//CIvKVMmUtkuDtMUjg2P8Ed4+ja+KJSq0tWt+JieASnZkoO5PMHWeBW
	 7lnVeirEZ/LJqjzyWZYYONbBFPsx2yRSyraSiZBPnHsJHYTKRkE8VGUrR4qcHQkemj
	 FyuevZr5YtLYw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/8] mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Date: Sun, 13 Sep 2026 10:31:42 -0700
Message-ID: <20260913173143.104105-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913172204.E5CF51F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 17:22:04 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Uninitialized memory usage for new `DAMON_FILTER_TYPE_HUGEPAGE_SIZE` filters.
> --
> 
> commit 1e4870705ac75e710966e11c09d2b8438d7b1bb1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
> 
> Introduce a new data attribute probe filter type, hugepage_size. It will
> work for memory that is backed by a hugepage of a given size range. Add a
> new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to identify the
> type.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 4be7d1df8e71f..bbb190b474015 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -798,6 +800,8 @@ enum damon_filter_type {
> >   * @matching:	Whether this filter is for the type-matching ones.
> >   * @allow:	Whether the @type-@matching ones should pass this filter.
> >   * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
> > + * @range_min:	Minimum value of range arguments.
> > + * @range_max:	Maximum value of range arguments.
> >   */
> >  struct damon_filter {
> >  	enum damon_filter_type type;
> > @@ -805,6 +809,10 @@ struct damon_filter {
> >  	bool allow;
> >  	union {
> >  		u64 memcg_id;
> > +		struct {
> > +			unsigned long range_min;
> > +			unsigned long range_max;
> > +		};
> 
> [Severity: High]
> Will the range_min and range_max fields remain uninitialized when a filter
> of type DAMON_FILTER_TYPE_HUGEPAGE_SIZE is committed?
> 
> Looking at damon_commit_filters() in mm/damon/core.c, new filters are allocated
> but the switch statement doesn't have a case to copy the new size fields:
> 
> mm/damon/core.c:damon_commit_filters() {
> 	...
> 	new_filter = damon_new_filter(src_filter->type,
> 			src_filter->matching, src_filter->allow);
> 	if (!new_filter)
> 		return -ENOMEM;
> 	switch (src_filter->type) {
> 	case DAMON_FILTER_TYPE_MEMCG:
> 		new_filter->memcg_id = src_filter->memcg_id;
> 		break;
> 	default:
> 		break;
> 	}
> 	...
> }
> 
> Since the switch falls through to default, range_min and range_max are not
> copied from the source filter, leaving them as random heap garbage. Later,
> when damon_ops_filter_match() evaluates the filter, it checks the page size
> against these uninitialized bounds.
> 
> Also, the unit test for committing filters seems to omit checking this new
> type as well, which is why it didn't catch the missing copy:
> 
> mm/damon/tests/core-kunit.h:damon_test_commit_filter_for() {
> 	...
> 	switch (src->type) {
> 	case DAMON_FILTER_TYPE_MEMCG:
> 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
> 		break;
> 	default:
> 		break;
> 	}
> 	...
> }
> 
> Should these switch statements be updated to explicitly handle
> DAMON_FILTER_TYPE_HUGEPAGE_SIZE?

Yes, and that is what the next patch of this series is doing.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=1


Thanks,
SJ
