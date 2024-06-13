Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBCD1448D4
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284875; cv=none; b=NoMjDr/AHuMom11f+d90JAD/vuoG4C83Qt12/te4rME9apNsJPBt0hwAVzULqEML+tVs2QpDGgFbv4xI4FiTVXfiWSbsWBL7kzI2Fj/pBc776+LtLewlU5ClZQCPN6M6PcPv4X0Iq5zPxjAon+XjpBweeLOCM2JGGHu+6fR7zHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284875; c=relaxed/simple;
	bh=zH9/26bCnqQ1D4kgrGaATCsRHHQL0Yv8+lKkx1Ua+NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcw8/JkqoGOIv+GB1ScHh937zo0rXwaSMO/zDOHiOHMGgcbrc3GI2wKnbKPHXoEXq91IjbJ1KWU8bo4sCBNkXQ8tHKnSb1rkQMSaugZytjHuU819oYi68AnV1BJpBq20j5rLuF62pGYqAEVoTBNtp058989BYkLtRrI3elcI8Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-39-666af2465f9e
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
Subject: [PATCH v5 1/8] mm: make alloc_demote_folio externally invokable for migration
Date: Thu, 13 Jun 2024 22:20:48 +0900
Message-ID: <20240613132056.608-2-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsXC9ZZnoa7bp6w0gz9t2hYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKxuLxrDpvFvTX/WS2OrD/LYrH57Blmi8XL1Sz2dTxgsjj89Q2TA4/H
	0tNv2Dx2zrrL7tGy7xa7x6ZVnWwemz5NYvc4MeM3i8eLzTMZPTZ+/M/u8XmTXABnFJdNSmpO
	Zllqkb5dAlfGlNMHmQs6uSv+Tl3N3sA4n7OLkZNDQsBEYsG+LkYYu3n+AVYQm01ATeLKy0lM
	XYwcHCICVhLTdsR2MXJxMAtsYJaYdO4FE0iNsECYxP2rq8B6WQRUJZbfeMUGUs8rYCrxdW4A
	xEhNicfbf7KD2JwCZhKP5oKUcHIIAZXM+HGVGcTmFRCUODnzCQuIzSwgL9G8dTYzyC4Jgdds
	Eht+bYC6TVLi4IobLBMY+Wch6ZmFpGcBI9MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjMAYWFb7
	J3oH46cLwYcYBTgYlXh4PZ5lpQmxJpYVV+YeYpTgYFYS4Z21ECjEm5JYWZValB9fVJqTWnyI
	UZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qBkXvCj/NF55TF3vOxZF/jE1c8tkl8WueX
	OI7eJy9jQi3OfnC+8uXNfm/JzauOxm5h+1zY18S3LmHTPbtVt/esNs0yuxC7v4LjnFBgo3fI
	FbtPDudyrgf58KdFvQ818i9Ydm2H9uveyyUcosd3cx6b7hcawvWs81/E1qTsi7wXDMxSBLkr
	9q2/psRSnJFoqMVcVJwIAPvxNUh9AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCNUNLT9ftU1aawa4WWYuJPQYWc9avYbO4
	/+A1u8WT/79ZLRqaHrFYfH72mtni8NyTrBaXd81hs7i35j+rxZH1Z1ksNp89w2yxeLmaxb6O
	B0wWh7++YXLg81h6+g2bx85Zd9k9WvbdYvfYtKqTzWPTp0nsHidm/GbxeLF5JqPHxo//2T2+
	3fbwWPziA5PH501yAdxRXDYpqTmZZalF+nYJXBlTTh9kLujkrvg7dTV7A+N8zi5GTg4JAROJ
	5vkHWEFsNgE1iSsvJzF1MXJwiAhYSUzbEdvFyMXBLLCBWWLSuRdMIDXCAmES96+uYgSxWQRU
	JZbfeMUGUs8rYCrxdW4AxEhNicfbf7KD2JwCZhKP5oKUcHIIAZXM+HGVGcTmFRCUODnzCQuI
	zSwgL9G8dTbzBEaeWUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM8WW1fybu
	YPxy2f0QowAHoxIPr8ezrDQh1sSy4srcQ4wSHMxKIryzFgKFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUaGM8kb+bQs/ZmPe3XwMzcsfKXg/q2zCOm9+uU
	HveU29wu/eDzwzhvn7bUG5/r3KK9Pzw9n6Y4yP6dvkhlYojUkVXi8iWzv0edjMr9d3iH6ePr
	orv2LkkRM5WNE81/nr5+2nWPWw4/klevO/XOZREXz6PoOeYXNVNlkn5d7Z7Fw9bUyL73CN+v
	NiWW4oxEQy3mouJEAAuC0cFtAgAA
X-CFilter-Loop: Reflected

The alloc_demote_folio can be used out of vmscan.c so it'd be better to
remove static keyword from it.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 1 +
 mm/vmscan.c   | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..b3ca996a4efc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1052,6 +1052,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..2f4406872f43 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -916,8 +916,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-static struct folio *alloc_demote_folio(struct folio *src,
-		unsigned long private)
+struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
-- 
2.34.1

