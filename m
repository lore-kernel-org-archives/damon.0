Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5973845AA
	for <damon@lists.linux.dev>; Mon, 27 Apr 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301619; cv=none; b=QLbxIMl7BSi7YJKjRad5dL4rQ66JfbFxscdMikX/ugSjezV5IhDu5KlyP2MxA0trUgSX6dkA91fhavG2D5bicd4Di/UiRH4cJbz29/95SfiySM5lMRov95tevMLZp4/96zjCLWkKfIyokXtbxnMXPp3eM5xcxo+OGay8cKgGoGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301619; c=relaxed/simple;
	bh=8gy4dB8X3pomLm+5r7inaMEDKI2U49MnSWlF+NjuoLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdZ7+k4JgIpilV4OcArAJXts1tE14yNKsOefGK7G/JXcQk1bGfacJ67IXpT/sem8FNg7Cx7FyH8nBGKMbMkLpRKBfzZnXXcGpxefINeIaFX69RSKvdQ0LmhPchz64h4cf+jWLTU1ImQAoxZmKWnL6IuZQpnpwZzv0suQWALGrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD+/akJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD+/akJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95401C19425;
	Mon, 27 Apr 2026 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301618;
	bh=8gy4dB8X3pomLm+5r7inaMEDKI2U49MnSWlF+NjuoLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DD+/akJX/V4+gsnJIpCSnCLLsp7TpfqDUNUpSQekmtf6KBY2+HmWAkX6wRhi/mcVX
	 Ddu3VwitGdh2OrxbsG/XJTvBBl/mubOwR1IhVnWAxmOQwf82fZ6OlEdksCMi+1JCBJ
	 o/4uugjvfRezSKkvyAtUZoEDSesoPF4hV9dzCYcyudms6F3x1jTMb+deNp6v6hrdxA
	 hTdm91qoFjeE8sYuMrVqYygpigzJbb56VPhbBpjJ13lm+1IbI8TTV2nXobbHuP/I3C
	 VAT45wAXWVWJq+YsPHyKrG9oVWB1SHmL58k/wfUVEYm4cO9qeW+8rG78Lionl2CyH4
	 Rpm3edPb39niA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v9.1] mm/damon: add node_eligible_mem_bp goal metric
Date: Mon, 27 Apr 2026 07:53:30 -0700
Message-ID: <20260427145331.112239-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427012429.D25C2C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 01:24:29 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 3 potential issue(s):
> - [High] Data truncation and arithmetic overflow in metric calculation on 32-bit systems.
> - [High] Missing `cond_resched()` inside the inner PFN-walking loop causes CPU soft lockups.

Not new Sashiko findings.  Above two issues are not real problems or better to
see if the issue can really happen.  I explained detailed reason on previous
Sashiko reviews.

> - [High] Address advancement logic is vulnerable to wrap-around infinite loops.

This is a new and good finding.  I asked a fix on my reply to the patch.

> --
> 
> commit 10100659661304515a414f3a15324e8278667f42
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> 
> mm/damon: add node_eligible_mem_bp goal metric
> 
> This commit introduces the DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal metric to
> track the ratio of scheme-eligible memory on a specific NUMA node, allowing
> the quota autotuner to adjust based on spatial memory distribution.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3dbbbfdeff71..22d6eb3a974d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > +static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
> > +		struct damos *s, int nid, phys_addr_t *total)
> > +{
> [ ... ]
> > +			/* Convert from core address units to physical bytes */
> > +			addr = (phys_addr_t)r->ar.start * c->addr_unit;
> > +			end_addr = (phys_addr_t)r->ar.end * c->addr_unit;
> > +			while (addr < end_addr) {
> > +				struct folio *folio;
> > +				phys_addr_t folio_start, folio_end;
> > +				phys_addr_t overlap_start, overlap_end;
> > +				phys_addr_t counted;
> > +
> > +				folio = damon_get_folio(PHYS_PFN(addr));
> > +				if (!folio) {
> > +					addr = PAGE_ALIGN_DOWN(addr + PAGE_SIZE);
> 
> If a DAMON region extends to the upper boundary of the physical address space,
> could addr + PAGE_SIZE overflow and wrap around to 0?
> 
> If addr wraps to 0, addr < end_addr would remain true, which might cause an
> unrecoverable infinite loop.

Good finding.  I asked another version for fix of this, on my reply to the
original patch.


Thanks,
SJ

[...]
