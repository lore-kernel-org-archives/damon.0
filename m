Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7D2C235E;
	Wed,  2 Sep 2026 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788325564; cv=none; b=PIqArz5IDPH0YYlUJ2qBgx6gBcmdWPtrx9DE3CBQPAGnotKn4ZbOaaf+ahNB06HtagfeEm9yNkdAmOgIiHAnEO5s2Fk3SB6UKf9lqYawmBywvMRB9Yw8zDQtc1jQpbynTl1gTkWtKs3/KbdXG56EXKx/T/4mKgryVHAyjXXonJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788325564; c=relaxed/simple;
	bh=cHFQC3aCKStcGe4s1Lwq7J1RKARQq88MNSeYrog3csI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXn89E1eYhnnye9/hARh0zbs9AHWCtzD55qS3T0shxBm2Tgm0anoMqPgP3RsvqhYdF68kPZsFzFWgMMzjB5pllpETY0VUfubs70Sm//VQJecJxKbv+pU81J5GnhSNpacjJ0uncVgLCMozAMgYqc+hTneCFsijm1u+H20Sp/s8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THyxJrYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THyxJrYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5134B1F000E9;
	Wed,  2 Sep 2026 05:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788325562;
	bh=kZqRtga/N01MzEm2VIK8xWzcS/KXDNFvjEktvJJ4jbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=THyxJrYUAKI1ujF3wzlgGNVxWYaD0HfSyfSyFQ7/lGFr/74XPbm5C2ygoxiV5l8pg
	 W3FtDsDX2ZoVTCbeAqytFtUQxxynOXWnY1W+HgQr0RK1oLMEi5H57tmRurBMvZZnkz
	 TVSzLT4d4MurHoeRHYabmqlRR72mmm62FsmWaeQjTE89wQ+EloWPh6eM1BMxTuccR0
	 r8I7j/eRzfuAPxbHPDdlT39eZjqlHUdgJuPs7ZylQR2tZhuDiIDaE1hqN1+CZEUqdW
	 JVCCB4safmOCEXPfrAxAFLtoz40tt5hy1b6hm6txB7uI5ZIJpYGbk66Tt3jHAoMmIt
	 FYqZqU7xrQwjQ==
From: SJ Park <sj@kernel.org>
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/ops-common: handle hugetlb folios in folio mkold/young rmap walkers
Date: Tue,  1 Sep 2026 22:05:54 -0700
Message-ID: <20260902050555.89912-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902025700.17975-3-kiyer@crusoe.ai>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 19:56:59 -0700 Krishna Iyer <kiyer@crusoe.ai> wrote:

> damon_folio_mkold_one() and damon_folio_young_one() assume the folios
> they walk are mapped by normal PTEs or THP PMDs.  When the folio is a
> hugetlb folio, page_vma_mapped_walk() returns the huge PTE in pvmw.pte
> with its page table lock held, but the walkers treat it as a normal
> PTE: they read and age it with PAGE_SIZE-granularity helpers, which is
> wrong for huge PTEs (up to PUD level), and notify secondary MMUs for
> only PAGE_SIZE of the mapping.
> 
> Add hugetlb branches to both walkers.  The mkold walker reuses
> damon_hugetlb_mkold(), which the virtual address space operations set
> has been using for hugetlb aging: it clears the young bit of the huge
> PTE via set_huge_pte_at() and calls mmu_notifier_clear_young() spanning
> the whole huge page size.  The young walker gets an equivalent new
> helper, damon_hugetlb_young(), which reads the huge PTE with
> huge_ptep_get() and consults the page idle flag and
> mmu_notifier_test_young() like the existing PTE branch.
> 
> Locking mirrors what page_vma_mapped_walk() provides: the huge PTE's
> page table lock is held inside the walk, and for shared hugetlb
> mappings (the only ones subject to huge PMD sharing), rmap_walk_file()
> already holds i_mmap_rwsem, satisfying hugetlb_walk()'s locking
> requirements.
> 
> This is currently dead code: both rmap walkers are only reachable
> through damon_get_folio(), which rejects hugetlb folios since they are
> not on the LRU lists.  A following commit will let the physical address
> space monitoring primitives opt in to hugetlb folios.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
