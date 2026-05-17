Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838611F4176;
	Sun, 17 May 2026 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061084; cv=none; b=ZqL3bolNiMk8CawQFP7nnbwYTXAI9riNIMvnTxYR5TsASWIG1aowQDF45txev7NgoqVoC5oY+cE/N244eAmyhBIfvORgDTmFhWuP85VzvfaYB/7+sylHxTEJKB6lMgqsk1qrzGJzPWJZaRrOXiCrNnCpmczmugrlYkkRk1mcxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061084; c=relaxed/simple;
	bh=ECiqAt9xoPWZmUznHtBSPzT0B3FSpo2D0BKG4KeiTuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApXjPAU45SbW9uBHQyYcjCVwE5XgcCty3MBhtmN3V9v+2Od489lJFgvCIzA8V1VKa3nzSlc+YKS/SDccsU2A+ifGdetmAi4cyYsBMNlQILMdIwuIkTGNo7mJjPnwEfu08Tp3b/z39mxQiLh92flQ3Fzy+Ixz5r4sVLA1/P00oOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQTWjja0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQTWjja0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52B2C2BCB0;
	Sun, 17 May 2026 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779061084;
	bh=ECiqAt9xoPWZmUznHtBSPzT0B3FSpo2D0BKG4KeiTuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQTWjja0ecUoGO/loHB3HhbJeqUM/pZzgcF12hl02M8frXScwwP2R3fvZfIrbkdwF
	 iDUW4Zb6oB41e7IHxI/Dn/5z8SBIh4UbpdiqYefz6C6paU/SYs24GavAgv1VLBUNdR
	 oBtM6BuMdWrvCUnD3zisuSWe6UVPhuZGazjx442tV+WPOGfTpmgzSSQRUKKLdRVsgd
	 QDZhxIwKaV8756gBdX3zfqMQZIdieIHC80nQlZmHRlM0mx0yNLSOp580WbcXit53sG
	 S9eMmLoK37dsUh/u5pDZMQXS3/PnXylV2NEhW/zbS7jjFEUlqq8f6WemOC5SkdmDcc
	 UnTqcXvNjeWTw==
From: SeongJae Park <sj@kernel.org>
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [RFC PATCH 4/5] mm/damon/paddr: skip free pageblocks in migration walk
Date: Sun, 17 May 2026 16:37:55 -0700
Message-ID: <20260517233756.89097-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516210357.2247-5-ravis.opensrc@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 14:03:56 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail.com> wrote:

> damon_pa_migrate() walks every PFN in a region linearly, calling
> damon_get_folio() for each one.  On sparse physical address spaces
> (e.g., CXL-attached memory), a single DAMON region can span hundreds
> of gigabytes where most memory is free and sitting in the buddy
> allocator.  Most page lookups are fruitless and dominate kdamond
> tick time.

On sparse address spaces, the problem would be large DAMON regions of offlined
memory.  The large DAMON regions that nearly all freed memory is another
problem that doesn't require the sparse address spaces.  If I'm not wrong, the
above paragraph could better clarified in my opinion.

> 
> Check at pageblock boundaries (2MB on x86_64) whether the block is
> entirely free.  If the first page of a pageblock is a buddy page at
> pageblock_order or higher, the entire block is free and can be
> skipped.
> Similarly skip pageblocks where pfn_to_online_page() returns
> NULL.
> 
> This reduces the iteration from O(region_sz / PAGE_SIZE) to
> O(region_sz / pageblock_sz) + O(populated_pages).
> 
> buddy_order_unsafe() is used without zone->lock.  A transient false
> positive (block becomes non-free between the PageBuddy and order
> checks) costs at most one tick of missed candidates on that block;
> the next tick re-scans.  No correctness consequence as DAMON walks
> are best-effort.

I was initially thinking this is a good and reasonable optimization approach.
But on the second thought I get below questions.

For large offlined memory space problem, couldn't we simply tune DAMON's
monitoring regions boundary to ignore the holes?

For large free memory area, is it reasonable to assume such situations?  In
production, users will try to utilize as much memory of the system as possible.
Then, wouldn't there be such problematically large free memory area?

Could you please enlighten me?

I will hold digging deep until this high level questions are answered.


Thanks,
SJ

[...]
