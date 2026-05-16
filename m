Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABEF1B6D08
	for <damon@lists.linux.dev>; Sat, 16 May 2026 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778895919; cv=none; b=KDQ0vID2vPbhr1rgVBbvkjmMa9da5Y5VVeW/xPea4b+VCwXKE31eZclmgrB3XLo6BXBNtQVz2gS4s9VmaB8fp0PT7uE9NTQbMQ6kMDoow/f3O06JwRZb217z8oM1rcjqDgS7Q4kI8RkGWfa4NI49ZrpQEubC17Pc9mEC4CAxptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778895919; c=relaxed/simple;
	bh=FrwLCaiG5iEnjSEpxnayirLCHlqrzfT48nwRXfC/dP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxGMvLxtuL0CkO0JisOn9FAR4sDyEpT2e75XHTgXs0fOorbrHD8wSnVjFop08ZJYfbwfZBTVEDE08j+r2vR5LkTRvYZE2aN4WHA+zOwtmYh1eyRcoj79TxLJMFcTA4yKrcLSPp+s2bgxfh842tCNOZIe+fH+tW2C0hlEytiKmlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPNYxhd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPNYxhd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43EBC2BCB0;
	Sat, 16 May 2026 01:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778895919;
	bh=FrwLCaiG5iEnjSEpxnayirLCHlqrzfT48nwRXfC/dP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPNYxhd2mObnW1NG8kD0vAy/iqPhSdfG3bCH8aPS4VBj2RPHQAuQYlWR9OJsy4QEN
	 zk7kVuBkSlwKwz4/H/ZsXeZ7S2WZC/kDCM9c6Ghe3hMD7NgKg+xOFoqJbWl+pzgTwL
	 JvQqM4of1sVVvnIy76+mxjGTSm0MJCaUAG1XexaAN7gCKSC0Pe/LPRwx0V6FxB/AHk
	 wAGqQx9N4LxcQTQ32TKL60e+TF63YL2S5pltGn2TWLn2PnS2FWTUNYCHePdUqip+Sh
	 nhZjs0QmCzh7I63BukUiEX3aP+3Ln30IyW2bWgoxyaMNEv3rd72+TGYsKX2gDcyDhz
	 ZmEMoLhR8xrlA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 22/28] mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
Date: Fri, 15 May 2026 18:45:03 -0700
Message-ID: <20260516014503.147089-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515012222.72F47C2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 May 2026 01:22:21 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Newly appended DAMON filters in `damon_commit_filters()` fail to copy the `memcg_id` field, leaving it uninitialized.
> --
> 
> commit 01e48275cc904a624a318c3fbc6c7313978207ef
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: introduce DAMON_FILTER_TYPE_MEMCG
> 
> This commit introduces a new DAMON filter type, DAMON_FILTER_TYPE_MEMCG,
> which allows monitoring and filtering based on specific memory cgroups.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ab8ac9ec8450d..2d4a63dcc47fe 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1422,6 +1422,13 @@ static void damon_commit_filter(struct damon_filter *dst,
> >  	dst->type = src->type;
> >  	dst->matching = src->matching;
> >  	dst->allow = src->allow;
> > +	switch (dst->type) {
> > +	case DAMON_FILTER_TYPE_MEMCG:
> > +		dst->memcg_id = src->memcg_id;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> >  }
> >  
> >  static int damon_commit_filters(struct damon_probe *dst,
> 
> When new filters are appended during probe synchronization, does the
> memcg_id field remain uninitialized?
> 
> Looking at damon_commit_filters() which immediately follows this function,
> it creates new filters for any remaining source filters:
> 
> static int damon_commit_filters(...)
> {
> ...
> 	damon_for_each_filter_safe(src_filter, next, src) {
> 		if (j++ < i)
> 			continue;
> 
> 		new_filter = damon_new_filter(src_filter->type,
> 				src_filter->matching, src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		damon_add_filter(dst, new_filter);
> 	}
> ...
> }
> 
> Since damon_new_filter() only initializes the type, matching, and allow
> fields, and memcg_id is not manually copied here like it is in
> damon_commit_filter(), could this leave the newly appended filter's
> memcg_id with uninitialized memory?

Good finding.  I will set the new_filter->memcg_id as src_filter->memcg_id when
the type is DAMON_FILTER_TYPE_MEMCG.


Thanks,
SJ

[...]
