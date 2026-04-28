Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334640DFD7
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348684; cv=none; b=YH5LeWHJcgo8/wUKJPI+rbdq1aAmWjekRkRyOtXRBV/9n6t69bBIIeTmSZ7seXie+3HwgiRKUabiZXCvbZQvUkpcqtJq4zJT/vCscjly2g21+ulPjjKN7RwtDy1B+5m9f4nmZV1h9teiohKTGIBskEYt5hOdEsQ7dqZDgnGBH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348684; c=relaxed/simple;
	bh=LZXWkrSOWPKnByw1e47lka23jslz4Run1/onV9jU3+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bw4CsgXoR1/dS7xPzyFEwXq+L1lBTIupb/+g2pZV8WJzcYJHM79g1AZ6Qpa2FlO248zkhM85zocorMw5C+RSVkgUYTnh9mf9wdDg9zbGDDMX8tvg61Xr3KqFs+DkxdciacYmAcmWs3jVCeNFMG+yIY3JXinUu1gORSJNXa38Vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLX3Iv+A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLX3Iv+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65E6C2BCAF;
	Tue, 28 Apr 2026 03:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777348683;
	bh=LZXWkrSOWPKnByw1e47lka23jslz4Run1/onV9jU3+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLX3Iv+AJ2Y4Qvmrbv5XILKylrB9O3x02pZfhKJH3MD6D6hSrExsyHpooGYTIYoqu
	 Ws2hdIzE6PwktwuHQ9wJGDk9jCUF6amL/GfYeTTT+xOkBYUvmD7VHTRKp9nVC9gsNl
	 i40krKK19CcvtpUQGh141wXR/iNIHX2TvZHMggsYTIwXWN7EzAC5HCB8Qj8FfkIZtv
	 68Taev2MDUUCMTlFCG9760bqEdCxmk9JtXiFFClC3BfT+Ml3vWkLBeGzugqwX2bbYD
	 GMi9liDl2j9d0tSTO8nwiVHff7JrhWmCtXMSLsh1yfjklERLtID6MZHFEbxklKMS92
	 NEIJixo5b4fvg==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Ravi Jonnalagadda" <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v9.2] mm/damon: add node_eligible_mem_bp goal metric
Date: Mon, 27 Apr 2026 20:57:53 -0700
Message-ID: <20260428035754.116202-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428032542.98E37C2BCAF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 03:25:42 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 4 potential issue(s):
> - [High] Missing `cond_resched()` inside the inner PFN-scanning loop causes CPU soft lockups.
> - [High] Casting 64-bit `phys_addr_t` to 32-bit `unsigned long` causes massive quota calculation errors on 32-bit PAE systems.
> - [High] Physical address wraparound of `folio_end` causes an infinite loop and system hang.
> - [High] Pre-existing `VM_BUG_ON` in speculative folio access within `damon_get_folio()`.

I find none of above as a blocker of this patch.  Please read below for more
details.

> --
> 
> commit 377bf0664129c87741fa640c563456b379c8a816
> Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
> 
> mm/damon: add node_eligible_mem_bp goal metric
> 
> This patch enables system-wide page distribution with target-state goals
> using PA-mode DAMON schemes. It tracks the ratio of scheme-eligible memory
> on a target node to adjust migration aggressiveness. The implementation
> calculates the current memory distribution across regions that match the
> scheme's access pattern.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 3dbbbfdeff71..9a4220174a61 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -2287,7 +2306,115 @@ static unsigned long damos_get_node_memcg_used_bp(
> [ ... ]
> > +			while (addr < end_addr) {
> > +				struct folio *folio;
> > +				phys_addr_t folio_start, folio_end;
> > +				phys_addr_t overlap_start, overlap_end;
> > +				phys_addr_t counted;
> > +
> > +				folio = damon_get_folio(PHYS_PFN(addr));
> 
> Since this code heavily invokes damon_get_folio() in a new PFN scanner, could
> the speculative folio access inside damon_get_folio() trigger a VM_BUG_ON? If
> damon_get_folio() tests folio_test_lru() before acquiring a reference with
> folio_try_get(), the page could be concurrently split or reallocated as a tail
> page.

I'm not sure what VM_BUG_ON() Sashiko is saying about.  Even if Sashiko is
correct, seems Sashiko argues the issue is inside damon_get_folio(), which is
not modified by this patch.  So this is not a blocker of this patch.

> 
> > +				if (!folio) {
> > +					addr = PAGE_ALIGN_DOWN(addr +
> > +							PAGE_SIZE);
> > +					if (!addr)
> > +						break;
> > +					continue;
> > +				}
> > +
> > +				/*
> > +				 * Calculate exact overlap between the region
> > +				 * [addr, end_addr) and the folio range.
> > +				 * The folio may start before addr if addr is
> > +				 * in the middle of a large folio.
> > +				 */
> > +				folio_start = PFN_PHYS(folio_pfn(folio));
> > +				folio_end = folio_start + folio_size(folio);
> > +
> > +				overlap_start = max(addr, folio_start);
> > +				overlap_end = min(end_addr, folio_end);
> > +
> > +				if (overlap_end > overlap_start) {
> > +					counted = overlap_end - overlap_start;
> > +					total_eligible += counted;
> > +					if (folio_nid(folio) == nid)
> > +						node_eligible += counted;
> > +				}
> > +
> > +				/* Advance past the entire folio */
> > +				addr = folio_end;
> 
> If a folio is located at the very end of the physical address space, could
> folio_end wrap around to 0? If addr becomes 0, could it cause an infinite
> loop since addr < end_addr would remain true?

The folio is a valid one, so should located on a valid physical address range.
And to my understanding, no real world machine allows 2**64 - 1 address.  So
this should be no blocker of this patch.

> 
> > +				folio_put(folio);
> > +			}
> > +			cond_resched();
> 
> Could scanning a large DAMON region without yielding the CPU in the inner loop
> cause soft lockups? Moving the cond_resched() inside the while loop would
> prevent it from monopolizing the processor.

As replied on previous versions, this is unlikely to happen.  We can revisit if
this really causes such issue.

> 
> > +		}
> > +	}
> > +
> > +	*total = total_eligible;
> > +	return node_eligible;
> > +}
> > +
> > +static unsigned long damos_get_node_eligible_mem_bp(struct damon_ctx *c,
> > +		struct damos *s, int nid)
> > +{
> > +	phys_addr_t total_eligible = 0;
> > +	phys_addr_t node_eligible;
> > +
> > +	if (c->ops.id != DAMON_OPS_PADDR)
> > +		return 0;
> > +
> > +	if (nid < 0 || nid >= MAX_NUMNODES || !node_online(nid))
> > +		return 0;
> > +
> > +	node_eligible = damos_calc_eligible_bytes(c, s, nid, &total_eligible);
> > +
> > +	if (!(unsigned long)total_eligible)
> > +		return 0;
> > +
> > +	return mult_frac((unsigned long)node_eligible, 10000,
> > +			(unsigned long)total_eligible);
> 
> Does casting these phys_addr_t variables to unsigned long cause truncation
> errors on 32-bit PAE systems where physical addresses are 64-bit? For
> example, if the eligible memory size exceeds 4GB, the truncation could
> corrupt the ratio metrics and break the quota autotuner. Would converting
> byte counts to page counts before casting avoid this?

As replied on previous versions, the user impact is trivial.  No blocker.


Thanks,
SJ

[...]
