Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18024143C5F
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284694; cv=none; b=fEI4MaB+JXq2tjEl3x5FX1xSHv1436vqaXlk60SWSelB9YG2RpO1FlFqCCqZE47t4AjURmhiI1Pud+A7b4Qy//+UAqwRPTi7Htaga1JtjDuI3pG8vgwjE8351H1Os2xDmY311cnITCMjX1s/EnGfo65jPgWusi/PBRZvUOmI2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284694; c=relaxed/simple;
	bh=XvF3onmWBMWQWugNW8Z1iLXXDxXiy19uPxMTn7rLCYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6o7PvvK2CLyX2KE5XV+ouDx5XPcrQeYpaPgjIfJ29NGN+d0Q+NpiVp8FC/tMW+AOaum8/OztRoxft9Z1qEGgHfCF/vFb101YuFV+51O3+15Ksi6WufyjdMBziO9eKo6zSa8ktl+iFr621b/ASje3m/VjTm7f2iV+1zMMSUjh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-30-666af18dbc35
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gregory Price <gregory.price@memverge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 2/8] mm: rename alloc_demote_folio to alloc_migrate_folio
Date: Thu, 13 Jun 2024 22:17:33 +0900
Message-ID: <20240613131741.513-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613131741.513-1-honggyu.kim@sk.com>
References: <20240613131741.513-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnkW7vx6w0gzXXZCwm9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6Ml4u7WQvu8VXc3fiarYFxDU8XIyeHhICJxNktB5hh7MdnFrGD2GwCahJXXk5i
	6mLk4BARsJKYtiO2i5GLg1lgA7PEpHMvmEBqhAU8JRov94HVswioSixb2Aw2h1fAVOL+t5Us
	EDM1JR5v/wlWwylgJrHu231GEFsIqKbj/zOoekGJkzOfgNUzC8hLNG+dDXXPczaJ0/+MIGxJ
	iYMrbrBMYOSfhaRlFpKWBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECY2BZ7Z/oHYyfLgQf
	YhTgYFTi4fV4lpUmxJpYVlyZe4hRgoNZSYR31kKgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6j
	b+UpQgLpiSWp2ampBalFMFkmDk6pBsaYmXzCRzMbSz63NCgZpNjkaOsou3aX2HtqSy2ZVenY
	qMbsa+WRJKVhGHjdctIUi3WlFpNkp/j5d/htVp9ikLg20Sv+cpqQz6xnyxLkv5n2z7Y04jn/
	v/Xf43VHZKKm7RUy/FF8uDRx3noV+VvFRb/4lmRksTYsmng9v/9h9eL5u7b9sAuercRSnJFo
	qMVcVJwIAPglvkF9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNLT7f3Y1aawYlz3BYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDJeLu5mLbjHV3F342u2BsY1PF2MnBwSAiYS
	j88sYgex2QTUJK68nMTUxcjBISJgJTFtR2wXIxcHs8AGZolJ514wgdQIC3hKNF7uA6tnEVCV
	WLawmRnE5hUwlbj/bSULxExNicfbf4LVcAqYSaz7dp8RxBYCqun4/wyqXlDi5MwnYPXMAvIS
	zVtnM09g5JmFJDULSWoBI9MqRpHMvLLcxMwcU73i7IzKvMwKveT83E2MwCBfVvtn4g7GL5fd
	DzEKcDAq8fB6PMtKE2JNLCuuzD3EKMHBrCTCO2shUIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv
	V3hqgpBAemJJanZqakFqEUyWiYNTqoExy3Iyi+vNoHLmLeGyyTmWH7Y/d1wb8jc0eNaSpR7X
	nz+dG+FeOHHHv8KlU5T2fTNbvs88wOZW86wYlksbczL23fnCMF2SbZeZ3X6Ju9ohvstMdp/e
	7bbz3l0LQSfN0x2Ox5ZVhhY2hv62jZQT/nimQIVr9/GHZ1lrde9oXmTbw26gcFzK5d5uJZbi
	jERDLeai4kQAO1n+524CAAA=
X-CFilter-Loop: Reflected

The alloc_demote_folio can also be used for general migration including
both demotion and promotion so it'd be better to rename it from
alloc_demote_folio to alloc_migrate_folio.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/internal.h | 2 +-
 mm/vmscan.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b3ca996a4efc..9f967842f636 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,7 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
+struct folio *alloc_migrate_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2f4406872f43..f5414b101909 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -916,7 +916,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
+struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
@@ -979,7 +979,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	node_get_allowed_targets(pgdat, &allowed_mask);
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_folios, alloc_demote_folio, NULL,
+	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-- 
2.34.1

