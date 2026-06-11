Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B35395ADA
	for <damon@lists.linux.dev>; Thu, 11 Jun 2026 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154115; cv=none; b=W7ulBORdlnMXTnOpGI1q0EeYuU/paN71Xu9a767MtTY2nzK0L4Iy/dwIBDgAMiI2CSdzkqpzgcIoNtaXiGgLdiJRhhKEcBWqRKwH1CE4hlyeGBByCNJSrUFzcj5IdSbxSop6fbV1Xhf4mlnurdPbMFi9sjgbmp1b/+xZFtDORzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154115; c=relaxed/simple;
	bh=BvV5PJDsBHyzM3gmn4vJosrh4j9efA7d6l5fm+1c0sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3GdwHCFEM/f/uBjdWlkoc1oucUvz01vdgFfoUBcD4Cm4uw7SeTB/BkoDgv3CHlGPdOh3HUTZl3Mz6IfRMdgK4/lCDUdYVtO88MG/6029RlNN9SmQjVZ5nwxpJKDp4vMhi20KUx9ynRnNJ6/ljL218pVptt72ATpu1hUtdlQhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QX/NJ2Zw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QX/NJ2Zw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65761F00893;
	Thu, 11 Jun 2026 05:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781154109;
	bh=GPowqWpJy8qq+WnI7qFy6HW1NuvCrsfFhW8V3BwUdhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QX/NJ2ZwBr0a+QmuDQ3Yl8/3kMD5/+ng/ub3n/QbxOY9byVUpBsgt5gSPBgNWiyOr
	 YZ1E/iplHRT40hbbl2+wjdlTp4oAogoaGm0GuXDt2KtM+99qMhlSODWDAPOmOjYrHC
	 tK2F1u+i6+l8K3PwZM/D0ZH/GxVbbLdsAMI74ZxjVarItP4kMhvoXLhTiYDfjgSJ3J
	 rWWB8mjb75HVYa2pkQnddL1mTLN/OLEP7IiQHl+TutDyyBX8VdPOYiP2GyO0hnxMQn
	 B/4Yq4dCjqnguxtlVJZLyU6jHVu0MlP91f1k3Z7eQb0JicBWVbbg697pTXmEGHEodl
	 Udf0poHMVPuAA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: sashiko-bot@kernel.org,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Wed, 10 Jun 2026 22:01:42 -0700
Message-ID: <20260611050142.62825-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522021642.87089-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 May 2026 19:16:42 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Thu, 21 May 2026 15:19:28 +0000 sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [Critical] The ALIGN() macro can overflow when processing malicious or overly large user-provided region 'end' values, creating invalid regions where start > end.
> > - [High] min_region_sz can be a non-power-of-2 value, which corrupts region boundary calculations when passed to ALIGN() and ALIGN_DOWN().
> > - [High] Userspace can maliciously trigger a kernel warning (WARN_ONCE) by providing a region where start == end via sysfs.
> > - [High] A memory allocation failure during region creation results in a partial state update without a rollback, potentially leaving the running DAMON context corrupted.
> 
> No one is caused by this patch, so no blocker for this patch.
> 
> The last finding seems worthy to separately work for.  I will work on it.
> 
> Please read below for more details.
> 
> > --
> > 
> > commit fa588352eaf7b151171cca8c2acb0bb710a71c75
> > Author: SeongJae Park <sj@kernel.org>
> > 
> > mm/damon/core: safely handle no region case in damon_set_regions()
> > 
> > This commit refactors damon_set_regions() to explicitly handle the empty
> > region list case without depending on the internal implementation of
> > list_first_entry().
> > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 4e223857a0f99..d0bdf6e01dff8 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
[...]
> > > +			if (!r)
> > > +				return -ENOMEM;
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does this allocation failure leave the
> > DAMON context in a corrupted state?
> > 
> > If damon_new_region() returns NULL due to memory pressure, the function
> > immediately returns -ENOMEM without rolling back the regions that were
> > already removed or added in the previous loop.
> > 
> > Could this leave the running kdamond thread with a partially modified list
> > of regions?
> 
> Yes, and the caller should do damon_destroy_ctx() of the ctx.  And DAMON_SYSFS
> does that, while vaddr doesn't.  I will work on this.

Hmm, but the vaddr's damon_set_regions() calls are only for the automated
mapping detection based monitoring target address rangs setup.  In the mode,
the monitoring target address ranges setup is only the best effort, and
continuously retried for every operation set update interval.  Hence, ignoring
the error is actually intentional and fine.  So this is not a real issue and
therefore no fix is needed.

Let me know if I'm missing something, though.


Thanks,
SJ

[...]
