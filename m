Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660361448D4
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284877; cv=none; b=LeeiFrTVDUwdFTFQwV8DzgqjsDX5F7+wlG0Kb57iLOshMMc1nHKQ2dIJxte4sVCXQAU7rripq+4ROgwdb9zwb1EDZzQhX4jcMinpKB3oxAKT+eCToTlT9CVu4ZamnwylHx6g07dUYfgpWSAgK5eAD6qtEEu6igD6pUQzuIJPNUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284877; c=relaxed/simple;
	bh=XvF3onmWBMWQWugNW8Z1iLXXDxXiy19uPxMTn7rLCYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCGbB6hmdTjWeb/lnszPjXQ6hsKW7bI9P+E0QhOD7DAJ2uwO5ZSIMdc9yDoalpLnLRWFMZfAUoB+v5taszT9J2NQy/OzBrIJBH4bS/cEP9284Ztu0XcGGfyje9rG2O7e8BRaYXW6FFwrTGXV+dwWFl+xVbhWFp222XMfs3+S1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3d-666af247e6b7
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
Subject: [PATCH v5 2/8] mm: rename alloc_demote_folio to alloc_migrate_folio
Date: Thu, 13 Jun 2024 22:20:49 +0900
Message-ID: <20240613132056.608-3-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240613132056.608-1-honggyu.kim@sk.com>
References: <20240613132056.608-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnoa77p6w0g4mrlC0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6Ml4u7WQvu8VXc3fiarYFxDU8XIyeHhICJxPcH81lg7NmL7rGB2GwCahJXXk5i
	6mLk4BARsJKYtiO2i5GLg1lgA7PEpHMvwOLCAj4SPd+iQcpZBFQlHnw6xgpi8wqYSjSuu8EO
	MVJT4vH2n2A2p4CZxKO5r8DGCwHVzPhxlRmiXlDi5MwnYCcwC8hLNG+dzQyyS0LgOZvEu5ZV
	rBCDJCUOrrjBMoGRfxaSnllIehYwMq1iFMrMK8tNzMwx0cuozMus0EvOz93ECIyBZbV/oncw
	froQfIhRgINRiYfX41lWmhBrYllxZe4hRgkOZiUR3lkLgUK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYXdP9rs7YvfOYF0uky6FqA7kFcjcT/73t+NW0
	K0JQ98EVU/aXZzrmHzujMccxf++6Nytd97X8ffTiuHODZcVGi/ipKWfCrqs0aPA1VMvvPWx5
	PuvgdN4n7s5/zXkWmx7panE0rTkruc6ts4ltIfOZtCC7R7N+uxg1Mp7cF+6c8+z5OfO0X/v3
	K7EUZyQaajEXFScCABaeCxZ9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNLT9f9U1aawc2ZohYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDJeLu5mLbjHV3F342u2BsY1PF2MnBwSAiYS
	sxfdYwOx2QTUJK68nMTUxcjBISJgJTFtR2wXIxcHs8AGZolJ516AxYUFfCR6vkWDlLMIqEo8
	+HSMFcTmFTCVaFx3gx1ipKbE4+0/wWxOATOJR3NfgY0XAqqZ8eMqM0S9oMTJmU9YQGxmAXmJ
	5q2zmScw8sxCkpqFJLWAkWkVo0hmXlluYmaOqV5xdkZlXmaFXnJ+7iZGYIgvq/0zcQfjl8vu
	hxgFOBiVeHg9nmWlCbEmlhVX5h5ilOBgVhLhnbUQKMSbklhZlVqUH19UmpNafIhRmoNFSZzX
	Kzw1QUggPbEkNTs1tSC1CCbLxMEp1cDo8k86db7l06nT/ffvfuH61bufSfuI/Op9XdoPFK4b
	rTvm5C+UFGRRsEP7OftyRje5TczzFefPOS20/anDgevb/zNevd9hbTjvhbvtccbTxvn9IWGd
	33r31DzkuOj/X6kmPzc86HhPsmPORx3DiWLfHi8US95sLX/UN2fShdNHFzJ7dclfMOBUYinO
	SDTUYi4qTgQAVhBVg20CAAA=
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

