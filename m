Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FB3CD8B5
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439390; cv=none; b=bCtzK/XLnpPY0Wp6LpVrVWOW3WgY9ZXAaHeGZYzUAUzEexIZ0Tc4prPfh7Q+bunMx3kSwExLRUKgBSzTsJ5ZtEDGPa+hs7fXT8XXtN9345WbIuUbCFRfx/StfCrdvoxTxAz9w86qOrPxZbDq3/qizVTqEC+Y9v59Zas3ynaEF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439390; c=relaxed/simple;
	bh=JmAq1Pz7QdsJAl79LpaqkeHmZkt+Ov860B1V0mi8+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPpY3CbDDePfgxHkXq5GOK9ixdv/cAYabzyYZOnFqRRVfoaXlFX00M26/eD/tY+dx7i8BzV9xzqAqptZbouRt6XOji1rvUZmnSMuaKtbXnsZo6ye6J7WXiDjIRYkTqL1cgQw9flO8pnxIZr9wQtBjo6DGvEkmHExK75PJGuuwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSHQcooL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSHQcooL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88CB1F000FF;
	Tue, 15 Sep 2026 02:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439388;
	bh=VDHkYThn8IQwAuGroIhjtKpwgQJLizXuPKdeZn8f9M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CSHQcooLkuRh96Nnq4H8vFiYa2ql9HvoG9qN1ny8WdKlKdEl9a3l/H0McI6ml0qMj
	 9bgmxlzZrHe10lVwyyYqhyoAlr5W/TUZbmkFZFGXTUnXRys3WZZ6PGE1vVTr0Kmd9M
	 wU1SLWrPRUT1CnS9uzvQxVE6y8PZh8P+GxEaWCxQo5ltDLfepQ24mJ+OUV46+EYm2V
	 /TiBqaIH47FIWJyE5y5htjaqn90TkURAe6pm6cGxWETvsJFtZnw1MpbKFewSpGCJEq
	 sjyfxtafAYwusLPFOhtC/7WRf4OHT0fvw8cWcBr6/XHKmXguO+aRWLhnpMIAyro2xX
	 jz+KOegbSIjnw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Mon, 14 Sep 2026 19:29:40 -0700
Message-ID: <20260915022941.104003-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915022430.961FA1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 15 Sep 2026 02:24:30 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: partial commit failure in damon_commit_filter() causes DAMON context state corruption
> --
> 
> commit bba894847aad85f23c968a2f306ec06c6e1b1a8c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: support hugepage_size probe filter
>     
> Extend DAMON sysfs interface to support hugepage_size probe filter.
> Allows hugepage_size user string input to the filter type file.  Pass
> the size range argument that users set via min/max files under the probe
> filter directory to the DAMON core.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 8e8d89b8ed981..43519afb9eb7f 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> [ ... ]
> > @@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
> >  				damon_destroy_filter(filter);
> >  				return err;
> >  			}
> > +		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
> > +			filter->range_min = sys_filter->range_min;
> > +			filter->range_max = sys_filter->range_max;
> >  		}
> 
> [Severity: High]
> Can an invalid hugepage_size range (where range_min > range_max) cause state
> corruption in the DAMON context?
> 
> When a user configures a hugepage_size filter with range_min > range_max,
> the values are copied blindly here into the intermediate context without
> validation.
> 
> During the subsequent commit, damon_commit_filter() in mm/damon/core.c
> updates the destination filter:
> 
> mm/damon/core.c:damon_commit_filter() {
> 	dst->type = src->type;
> 	dst->matching = src->matching;
> 	dst->allow = src->allow;
> 	switch (dst->type) {
> 	case DAMON_FILTER_TYPE_MEMCG:
> 		dst->memcg_id = src->memcg_id;
> 		break;
> 	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> 		if (src->range_max < src->range_min)
> 			return -EINVAL;
> ...
> }
> 
> Because the validation fails and returns -EINVAL after dst->type,
> dst->matching, and dst->allow have already been updated, the commit aborts
> midway. This leaves the active DAMON context's filter partially mutated,
> interpreting its previous union field (like memcg_id) as the new range
> bounds.
> 
> Could validation be added to damon_sysfs_set_filters() in mm/damon/sysfs.c
> to prevent invalid bounds from reaching the core commit logic?

No issue.  damon_ctx->maybe_corrupted is there to avoid using such corrupted
state.

> 
> >  		damon_add_filter(probe, filter);
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915020929.102953-1-sj@kernel.org?part=5


Thanks,
SJ
