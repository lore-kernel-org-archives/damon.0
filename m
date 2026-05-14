Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C68322C88
	for <damon@lists.linux.dev>; Thu, 14 May 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723473; cv=none; b=i3Lur8jMYv6/53HRTb9Q11utHt2f8Lzamtg0TRpi+jQuRVCvKVDjqa4GNF4UNJ2tIcvbV98Af/dq8anJqOTvkgSyVw64qZ4zc0sEykQBS1XGGEfq42Xt79AHIdGys++1n80LPkQnfNQ71wjveo2bY9CJ3UAp6TcbpvRm4dB+3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723473; c=relaxed/simple;
	bh=7+RERo0xWMaLLJFcvYZj6Lf9liM5jjgi7yIJVLn44XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFX98maSHJ6OII+5UMMx+05M6a32LfhrfimgQ1gaF33gecpOf7SKJC/fqF9VOtJmuaLeq0Zm0fhmFyQxxwaZSUq7qd91B0xNCqCMnNhRvDczRz+LTxwX9WI/CfmX4bbDNKnGJL1nP8mgummk4LuGXv2JjoeWYBqNdUGac8B+EPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNWZ9A6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNWZ9A6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15357C19425;
	Thu, 14 May 2026 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723473;
	bh=7+RERo0xWMaLLJFcvYZj6Lf9liM5jjgi7yIJVLn44XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNWZ9A6OWv368WP3tzxRRroWWVEiaYgw4eHuSmikYOmF4tVFp/SoS8XCyje5I5nIs
	 789JoGNU0V8EKaQJspkPGMUwCV+J9/qjesUSO40JKgvxKxK/2cITtfThvjrt3UmtLq
	 RqvRLdTXIP6EOTrHWIIgmt7nsFnYCkg8tdu1r7zJbgNv77g9wu2dZwvKjz4czpuIDy
	 OUTiN8la+BwKKmKZDnwbihr9TS0/IgNoaEt3r+DOtiR9cDLkGepZKlHqngZYH9fP8C
	 efzukO32T3nV/0ktO2JyD2oiPPZBEaTI9xPXqvlSdHl/hdaFxwo3DT8WMRRHVcOwW6
	 javYwD/iq7GeA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Kefeng Wang" <wangkefeng.wang@huawei.com>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/damon/vaddr: attempt per-vma lock during page table walk
Date: Wed, 13 May 2026 18:50:52 -0700
Message-ID: <20260514015053.149396-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513225204.4157FC19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 13 May 2026 22:52:03 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] `damos_va_migrate_pmd_entry` and `damos_va_stat_pmd_entry` incorrectly advance iteration by the full folio size, skipping unrelated PTEs for mTHP.
> --
> 
> commit 25c04a646a951de8c86c5c718af6cfc459b7b5e0
> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> mm/damon/vaddr: attempt per-vma lock during page table walk
> 
> Currently, DAMON virtual address operations use mmap_read_lock
> during page table walks, which can cause unnecessary contention
> under high concurrency.
> 
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 1b0ebe3b6951e..d271476035641 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> [ ... ]
> > @@ -750,7 +773,6 @@ static unsigned long damos_va_migrate(struct damon_target *target,
> >  	struct mm_walk_ops walk_ops = {
> >  		.pmd_entry = damos_va_migrate_pmd_entry,
> >  		.pte_entry = NULL,
> > -		.walk_lock = PGWALK_RDLOCK,
> >  	};
> 
> This isn't a regression from this patch,

Yes, no blocker for this patch.

> but there appears to be a pre-existing
> issue in damos_va_migrate_pmd_entry() and damos_va_stat_pmd_entry() when
> handling large folios.
> 
> In the PTE iteration loops, when a large folio is found, the code sets
> nr = folio_nr_pages(folio) and updates pte += nr and addr += nr * PAGE_SIZE.
> 
> Could this skip unrelated PTEs if the iteration started on a tail page of this
> folio (e.g., halfway into an mTHP)?
> 
> Advancing by the full folio size could overshoot the end of the folio and skip
> unrelated PTEs mapped immediately after it within the same PMD.
> 
> Would it be better to subtract the offset within the folio to safely skip only
> the remaining pages of the current folio?

The user impact should be minor, but makes sense.  I will work on this.


Thanks,
SJ

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260512151523.2092638-1-wangkefeng.wang@huawei.com?part=1
