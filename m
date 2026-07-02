Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35941C71
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782951567; cv=none; b=iqwmZJcMNzZBzlduxFCt9m+Io6i94rQtMMYvD2ZZa3ohFB89ja+XIDXlxuYgThfHT9mbWjkbCgU2wNtI5coUsHL14KkWRwGyjCtckMvF0PuFFinT6beZc4Xep+W+Yf2ZPZeckeFa6kjif3WCBE+KXV68KsZsMthNTXH8WdWnOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782951567; c=relaxed/simple;
	bh=+PKQ99YIYBsmFp7hJLcZffsGGZk31yyaBq1czYaL7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szOZGqtrqeRXxx3jkAf//vOMiUiL5qNYRWo1yOrsC3X5RYFnRya8LnXtS+STPiIywuYXmLsYI4MuEhjPdyBZ3Pdclw8hm+2tYtw56ConZInAYqR1HCxG1dl9ub8KwF8rnju0Ry0loQeoU1r6pvuz6dnSa+2qJLEkwf0Bz4B8cTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqb4qDDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqb4qDDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCD91F000E9;
	Thu,  2 Jul 2026 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782951566;
	bh=edkBjuSVgJF8vsgH+jdxdlNAf3iqPBy+yr5nURQRY/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqb4qDDxewysUFVy/76SHLtzzKLk7TuoJvCvdRw6TWmoC/8MDsQx4t0w3deBkEhkR
	 DBrPWHZ5WFKq8gHUnz9HMkCBPwpKpNTXwsSaWOHWoufGG9Gx128BayMrlILsVchgCy
	 nHakYJREQkenf485dVf39COo2lkWNKxOQcW/W0YciH7MBE7vl8mYABAhsaYTjnh0Vt
	 wtnSWOJrYlFoIFS74CGOCmxYg7Z7SfV5tt3CJm5I9yf5qgl2DkEwGitFY/u72yQ6gU
	 +mqKKMub8TBSKO0azdJ3rwydHu0dh35pJdNeQ3ZCufPyQTQ7PGNgDv/3gMA07zcmyD
	 qqFpJudrsq0Cg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 8/8] mm/damon/sysfs: remove region size validation
Date: Wed,  1 Jul 2026 17:19:18 -0700
Message-ID: <20260702001919.87095-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260701163455.526421F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 01 Jul 2026 16:34:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing the `start > end` validation allows users to configure monitoring regions with negative sizes, causing integer underflow in region size calculations. This leads to infinite memory allocation loops (OOM), potential list corruption, and CPU soft lockups during DAMON region splitting and scheme operations.
> --
> 
> commit 013d66b2108372ca2ada7fc6fcfd5e07f93fd78c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: remove region size validation
> 
> This commit removes the region size validation in DAMON sysfs that checks
> for negative size regions. The commit message states that the validation is
> incomplete and that damon_set_regions() already performs complete
> validation.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index e666dddf1feba..b65651498e0d1 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1987,9 +1987,6 @@ static int damon_sysfs_set_regions(struct damon_target *t,
> >  		struct damon_sysfs_region *sys_region >  			sysfs_regions->regions_arr[i];
> >  
> > -		if (sys_region->ar.start > sys_region->ar.end)
> > -			goto out;
> > -
> 
> [Severity: High]
> The commit message mentions that damon_set_regions() does the complete
> validation, but looking at damon_set_regions() in mm/damon/core.c, does it
> actually validate that start <= end?
> 
> mm/damon/core.c:damon_set_regions() {
> 	...
> 	r = damon_new_region(
> 		ALIGN_DOWN(ranges[i].start, min_region_sz),
> 		ALIGN(ranges[i].end, min_region_sz));
> 	...
> }
> 
> If a user configures a region where start > end, wouldn't this cause an
> integer underflow when calculating the region size later? 
> 
> For example, could this underflow lead to an infinite memory allocation loop
> in mm/damon/core.c:damon_apply_min_nr_regions():
> 
> 	while (damon_sz_region(r) > max_region_sz) {
> 		damon_split_region_at(t, r, max_region_sz);
> 		r = damon_next_region(r);
> 	}
> 
> Could this loop evaluate the underflowed size and attempt to allocate new
> regions repeatedly until an OOM occurs?
> 
> Additionally, for newly split regions where start < end locally, could this
> spin over a massive address range without yielding and cause a CPU soft
> lockup in mm/damon/paddr.c:damon_pa_pageout():
> 
> 	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
> 		...
> 	}

My previous reply [1] should again be applied here.

[1] https://lore.kernel.org/20260702001650.86841-1-sj@kernel.org


Thanks,
SJ

[...]
