Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89DF15CB
	for <damon@lists.linux.dev>; Thu, 13 Jun 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284692; cv=none; b=CErxaKiZwQrFc5VSIZ1F4YeN/uuvDgwQ9WWy6LvLCCTPkaYTKhuPkIda0v3fBGbDEOHdcw8FzFKE10h+ABwN60sgdlaudtlqBh+IWEh+Gx1RVj3SQf+PccDRp4Jb80f+zxB5DNcbHXjjdu0l9SWAXDu1bwbb3J8lxB+XG3NZRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284692; c=relaxed/simple;
	bh=zH9/26bCnqQ1D4kgrGaATCsRHHQL0Yv8+lKkx1Ua+NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=patxtIekVv6ujzA5Jj3/efwjrCqDGRJSHVCzguLK8axRXtp/EOs3SyHh2c+Zj2vEjsSsecGn5UDLqjQ0i+76kgogd6u5nAFrZxWGHzLCbipjda0yiT8G20h7ZsZhcANUt7RERXZvGit8DDkpAKyQHrKUAo19vnoXcdWruEZFtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-2b-666af18c52e4
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
Subject: [PATCH 1/8] mm: make alloc_demote_folio externally invokable for migration
Date: Thu, 13 Jun 2024 22:17:32 +0900
Message-ID: <20240613131741.513-2-honggyu.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsXC9ZZnkW7Px6w0g/2T5S0m9hhYzFm/hs3i
	/oPX7BZP/v9mtWhoesRicXnXHDaLe2v+s1ocWX+WxWLz2TPMFouXq1ns63jAZHH46xsmBx6P
	paffsHnsnHWX3aNl3y12j02rOtk8Nn2axO5xYsZvFo8Xm2cyemz8+J/d4/MmuQDOKC6blNSc
	zLLUIn27BK6MKacPMhd0clf8nbqavYFxPmcXIyeHhICJxK8JR9lg7FtNRxhBbDYBNYkrLycx
	dTFycIgIWElM2xHbxcjFwSywgVli0rkXTCA1wgLBElt6O5hBbBYBVYnuRYvAenkFTCXmfl3L
	AjFTU+Lx9p/sIDangJnEum/3wWqEgGo6/j9jhqgXlDg58wlYPbOAvETz1tnMIMskBJ6zSSyd
	vh7qOEmJgytusExg5J+FpGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQKjYFntn+gd
	jJ8uBB9iFOBgVOLh9XiWlSbEmlhWXJl7iFGCg1lJhHfWQqAQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGxgmbT4lXGsstDDgw6UuL2YoF6yd8jTLLK3dt
	O17lLnrE7YX+/IoTc24tC5Jr3nh8mVzz9vNvtiw0i566hcmqqyZp0dftbgncqpbcebz3fIqf
	3RZpmdhcqv71ULHp8mPSJVyO2jbdKbtXra9fvXa6qJXD2qip2m/y9axDlcq53LdEVm16+c+s
	VImlOCPRUIu5qDgRADNYT1t+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsXCNUNLT7fnY1aawdtLghYTewws5qxfw2Zx
	/8Frdosn/3+zWjQ0PWKx+PzsNbPF4bknWS0u75rDZnFvzX9WiyPrz7JYbD57htli8XI1i30d
	D5gsDn99w+TA57H09Bs2j52z7rJ7tOy7xe6xaVUnm8emT5PYPU7M+M3i8WLzTEaPjR//s3t8
	u+3hsfjFByaPz5vkArijuGxSUnMyy1KL9O0SuDKmnD7IXNDJXfF36mr2Bsb5nF2MnBwSAiYS
	t5qOMILYbAJqEldeTmLqYuTgEBGwkpi2I7aLkYuDWWADs8Skcy+YQGqEBYIltvR2MIPYLAKq
	Et2LFoH18gqYSsz9upYFYqamxOPtP9lBbE4BM4l13+6D1QgB1XT8f8YMUS8ocXLmE7B6ZgF5
	ieats5knMPLMQpKahSS1gJFpFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4mRmCQL6v9M3EH45fL
	7ocYBTgYlXh4PZ5lpQmxJpYVV+YeYpTgYFYS4Z21ECjEm5JYWZValB9fVJqTWnyIUZqDRUmc
	1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAuGcS/8F7a1WXezHoi9Wa+XJIXWbeGlhkM3ma+vV+
	zQ9zWwUvLjzJqrD80YGJBgVCXYx7ngd4Fa7dmnji0M1ZQjcYD+cfKXqSumNq5dlOOz+DZXNn
	dshqrHdnyd24Y43Z8xTByVnHFjW5zFM9spfTIHbxr41aXwpDUo9YL2Isn2D1cIaEscu5AiWW
	4oxEQy3mouJEAJ586qJuAgAA
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

