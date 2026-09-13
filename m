Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273337473A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789321150; cv=none; b=T1WZQUWVZ8OE+2qrRaCXmxbw98luLKs4QHc7yHKweGHegL/RvrmoBaRj7qn1xTxF9sUpPyeyOQJ7I0O6tNMfp8uEw1V/WdqIFw/rnGbBA/7m+0c40Q/WGV/l7Zcy7OiTE+2z4Mg6PDQ2NUQ+GVKpN5jaMgHWF4cPxbPfikEQhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789321150; c=relaxed/simple;
	bh=BowDprRS8OgpvDr2tuAhbvm2zcpkuOZx2Jazkaz11iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icJuWBwBK9AAs+zzH2VfAe5lyho8/7g2DCtD7N9RgOGlkRTPazKVOsfACwUkheRAq2bFOZsDK7Bzs8KiODRoygRdP/4hjiL89JtzgaIMp0wC+9BKcpusidhk56swfCOFiWH4AoZGuFbUM793P1v82mFU5Go1Vd4bVWGYDrOTFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNe/5mdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNe/5mdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E12F1F000FF;
	Sun, 13 Sep 2026 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789321148;
	bh=r+mqcegtvqqPA8WBEKGLNlu40+X8gvkt8F0G2UbsMRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iNe/5mdvoY91/jwCkZkwI1OZVYps3zDH+flOu0jVzVOLxXla7VLEjUDQJh0U8sDTt
	 IZFkgInbfuiIfvLugWMP5im7q3KVKRmT+92Y+qcurQN3SxjxeOj2keQTpRW3vSZbGa
	 4570VKBo4dt9sedkgp078c7nG6f2CT4Y8Wcwekju2VLhR166yfcddQhENnAqPIpfsV
	 uhTPtHwqojc3mWdWsh2KjCH8g1mJbmHBmFO8D5hIszy8wyWXWj6SR6QcauG2/V+zRQ
	 hAAxPaaDbAJITq8BDnfQZfrSswb9twOa4Ag7eMIRgsyks9ExB9HH80W9eX+dcBRgWU
	 vAGqb54D1vqQg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Sun, 13 Sep 2026 10:38:59 -0700
Message-ID: <20260913173901.104559-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913173023.394EF1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 17:30:22 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Missing bounds validation for hugepage_size filter in damon_sysfs_set_filters().
> 
> Pre-existing issues:
> - [High] Newly created hugepage_size filters lack range bounds initialization in damon_commit_filters(), causing the DAMON core to evaluate folios against uninitialized kernel heap memory.
> --
> 
> commit 42f3666a978b5b2934ebb23daaee8fd5163c7793
> Author: SJ Park <sj@kernel.org>
> Subject: mm/damon/sysfs: support hugepage_size probe filter
> 
> This commit extends the DAMON sysfs interface to support the hugepage_size
> probe filter. It allows users to set hugepage_size via sysfs min/max files
> and passes these arguments to the DAMON core.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 8e8d89b8ed981..43519afb9eb7f 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > @@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
> >  				damon_destroy_filter(filter);
> >  				return err;
> >  			}
> > +		} else if (filter->type = DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
> > +			filter->range_min = sys_filter->range_min;
> > +			filter->range_max = sys_filter->range_max;
> 
> [Severity: Medium]
> Are bounds checks needed here to ensure range_min is less than or equal to
> range_max?
> 
> Because DAMON's initial startup via damon_start() bypasses the bounds check
> in damon_commit_filter(), turning DAMON on with inverted bounds in sysfs
> silently accepts the configuration. The filter then unconditionally fails to
> match any folios, resulting in a silent functional failure instead of an
> expected -EINVAL rejection.

No.  damon_start() does test purpose commit, so the bound check is done.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed that newly created
> hugepage_size filters lack range bounds initialization in
> damon_commit_filters().
> 
> If a user configures a new hugepage_size filter via sysfs on an already
> running DAMON context and writes 'commit' to the state file, the newly
> added filter is allocated without initializing the range:
> 
> mm/damon/core.c:damon_commit_filters() {
> ...
> 		new_filter = damon_new_filter(src_filter->type,
> 				src_filter->matching, src_filter->allow);
> 		if (!new_filter)
> 			return -ENOMEM;
> 		switch (src_filter->type) {
> 		case DAMON_FILTER_TYPE_MEMCG:
> 			new_filter->memcg_id = src_filter->memcg_id;
> 			break;
> 		default:
> 			break;
> 		}
> ...
> }
> 
> Because damon_new_filter() allocates memory without zeroing, and the switch
> statement explicitly omits DAMON_FILTER_TYPE_HUGEPAGE_SIZE, range_min and
> range_max are populated with uninitialized kernel heap memory. Could this
> cause the DAMON core to evaluate folios against erratic heap garbage?

Good catch.  I will fix in the next spin.

> 
> > +		}
> >  		damon_add_filter(probe, filter);
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=5
> 


Thanks,
SJ
