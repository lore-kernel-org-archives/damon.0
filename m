Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3440DFDF
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777346612; cv=none; b=hE93FICtiQa7YzJ6m7v4SS5Ns677c5H+4OMUuHRpI4bXwT3iqb2AQNkMtfa9JSzwST16i3v7+DTsI+qw8BqpFVKqkyY22Tin7eW6cG3RCx4B2ybFQMpNYruucqMxN03hO6QyKWtYdB9DpiFiX1bnCSNA33TbP06y0B66gY1dHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777346612; c=relaxed/simple;
	bh=oL99vOKe7vBum1ybKrSCCt+F0hLxzjAquweLkcc25r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF46MWPvCGHHESuW/Ao/fc7+3jixglUp8uWbbSRq2NWYTF/7GFSiRe/WHp5O3A2ZntDVV8flrFqA5ii3Fp/9CwAvq6b73njzjw0Yn5tKY+CckvD26plY6q4FpGyqRmbsp45LYcDyscaF+LhDVh8Px0zqxdpf6Yc8TeqhEmQ9ypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFF95YBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFF95YBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8038CC2BCAF;
	Tue, 28 Apr 2026 03:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777346611;
	bh=oL99vOKe7vBum1ybKrSCCt+F0hLxzjAquweLkcc25r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFF95YBmtEJLrjTj5rNkKQbeKxQAa6AYdjzaTRQM3Dvsw6RIkBaxtjuvSNcZQ3B4E
	 Boe7MQvyP+3VaaGifSEF4NVD/fgQD5E063NJ2YCcGhKj83nm/ssKqMrpCQ5OfzY0Jx
	 yAPKRUmLWXqlxWGTzi/ZDYs/yxrYF4DvkG6icXgOeltzuKZB4gaWfLjJ7oITAHLGWg
	 mnpBwK9Zl1pSDL6tLKBeffD0xnr+Bxwj9P+5CuSSOGp8u9wij77ofCZH0234vnaXQC
	 7Jac++y6nuEv7/AG7+2201Dq0F1gvoYZbyTOMoS5SpTqO18mYY/2X/7/xTXN/Tt+QT
	 UBGmFCxalCwpw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
Date: Mon, 27 Apr 2026 20:23:23 -0700
Message-ID: <20260428032324.115663-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428020025.BDC94C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 02:00:25 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [High] The patch unmasks an existing off-by-one bug in the DAMOS quota checkpoint logic, which permanently starves memory regions following a quota boundary.

Not a blocker for this patch.  Please read below for details.

> --
> 
> commit 6b38ae7237b3de6636c6c420fb6a8b80b4e7eb87
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: handle <min_region_sz remaining quota as empty
>     
> This commit updates the DAMOS quota logic to treat quotas with less than
> min_region_sz remaining as fully charged. This ensures that charge_target_from
> and charge_addr_from are updated appropriately to prevent DAMOS actions from
> being applied too frequently to specific memory areas.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -2103,8 +2117,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
> >  		quota->total_charged_ns += timespec64_to_ns(&end) -
> >  			timespec64_to_ns(&begin);
> >  		quota->charged_sz += sz;
> > -		if (damos_quota_is_set(quota) &&
> > -				quota->charged_sz >= quota->esz) {
> > +		if (damos_quota_is_full(quota, c->min_region_sz)) {
> >  			quota->charge_target_from = t;
> >  			quota->charge_addr_from = r->ar.end + 1;
> 
> Does this reliably unmask an existing off-by-one bug here?
> 
> Since DAMON ranges [start, end) are exclusive at the end, r->ar.end is
> exactly the start of the next region. By adding 1, the checkpoint
> address advances 1 byte into the next uncharged region.
> 
> During the subsequent charge window, damos_skip_charged_region()
> evaluates the next region and checks if it falls within the skipped area:
> 
> mm/damon/core.c:damos_skip_charged_region() {
>     ...
>     if (quota->charge_addr_from && r->ar.start <
>             quota->charge_addr_from) {
>         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
>                 r->ar.start, min_region_sz);
>         if (!sz_to_skip) {
>             if (damon_sz_region(r) <= min_region_sz)
>                 return true;
>             sz_to_skip = min_region_sz;
>         }
>     ...
> }
> 
> Because the checkpoint is 1 byte inside the next region, sz_to_skip
> evaluates to ALIGN_DOWN(1, min_region_sz), which becomes 0. The
> fallback logic then forcefully skips min_region_sz bytes and returns true
> without clearing the checkpoint.
> 
> Could this cause the min_region_sz bytes immediately following a quota
> boundary to be permanently starved of DAMOS actions?
> 
> Should the assignment be changed to quota->charge_addr_from = r->ar.end
> instead?

Good finding.  But the user impact is quite small, and anyway this bug is not
introduced by this patch.  I will separately work on fixing the bug.  But this
cannot be a blocker of this patch.


Thanks,
SJ

[...]
