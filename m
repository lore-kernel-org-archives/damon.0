Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E0B25774
	for <damon@lists.linux.dev>; Fri,  5 Apr 2024 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297357; cv=none; b=bHXl7jNb4sKNuu5H8ucVOdQc6XgY/iaElKpLWTWJViUv2+TYCdBR4v6Ds/pExSHIlS/NkhkQuJtsKdZD1Tw65gkjy1IvMa0+uvAez/wpHrvdnxZtpxtkcUhMS1MrceCOezPaNCwi93xE2ZKf0m8MYxUYNjlGfc5lv6kNV65tkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297357; c=relaxed/simple;
	bh=Ig1CU3NKL8/cdJN+rmc1e4GaDBcrnBkfyq6QFF/1g7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEH/04k0Vqrj4CO/+QtskkmIKOOrj6N+tHFjKol8rkNwyydLtDfAxn8FmkbJ9Jjxu2lg4hDsGsu/Xl9PnYyJnMlkqu25rljdgjf3sqJOsC//emkbC4MzpH7WUtCtFN7jKHl4BwN931ZkYLuEaCO93/xuF92gYhpM0LVR0U3TFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-86-660f957f95fe
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: [RFC PATCH v3 1/7] mm/damon/paddr: refactor DAMOS_PAGEOUT with migration_mode
Date: Fri,  5 Apr 2024 15:08:50 +0900
Message-ID: <20240405060858.2818-2-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240405060858.2818-1-honggyu.kim@sk.com>
References: <20240405060858.2818-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnkW79VP40g0kXlS0m9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBlzGjYwF7TwVsz7sYatgfEKVxcjJ4eEgIlE94t9jF2MHGD27WdaIGE2
	ATWJKy8nMYGERQQcJFZ9Vehi5OJgFvjPLHG59xcrSI2wQJhE0/JXYDaLgKrE2n13WUBsXgEz
	if1HXzJBjNeUeLz9JzuIzSlgLjHv8QYwWwio5tPBY+wQ9YISJ2c+AetlFpCXaN46mxlkmYTA
	KXaJzzua2SAGSUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERh1
	y2r/RO9g/HQh+BCjAAejEg+vx1y+NCHWxLLiytxDjBIczEoivN0OvGlCvCmJlVWpRfnxRaU5
	qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGNme7eV0WT0z7nfAmw2pXAvTP8Vu
	CT4TmjfVRrQ3T+R5eFryrkTPFsOtAtE8t7+/Yj03c8H2Q6wzjf+pZ6o/VkgyuF7yM2rhmy1b
	nUv8Wh6n3f9UEZi6mF3/9bF/M1xeJAQynvCJ810UGajY/y5m/ecPG1MkW1YeSlYRtf3w4TaP
	+yKRSfa2k5VYijMSDbWYi4oTASXCDe+2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCNUNLT7d+Kn+awd2dohYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLD4/e81s0fnkO6PF4bknWS06vy9lsbi8aw6bxb01
	/1ktjqw/y2Kx+ewZZovFy9UsDl17zmqxr+MBk8Xhr2+YLCZfWsBm8WLKGUaLk7Mms1jMPnqP
	3UHcY+npN2weG5qAxM5Zd9k9WvbdYvdYsKnUo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN4
	7Hxo6fFi80xGj97md2we3257eCx+8YHJ4/MmuQCBKC6blNSczLLUIn27BK6MOQ0bmAtaeCvm
	/VjD1sB4hauLkYNDQsBE4vYzrS5GTg42ATWJKy8nMYGERQQcJFZ9Vehi5OJgFvjPLHG59xcr
	SI2wQJhE0/JXYDaLgKrE2n13WUBsXgEzif1HXzKB2BICmhKPt/9kB7E5Bcwl5j3eAGYLAdV8
	OniMHaJeUOLkzCdgvcwC8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq9
	5PzcTYzASFtW+2fiDsYvl90PMQpwMCrx8HrM5UsTYk0sK67MPcQowcGsJMLb7cCbJsSbklhZ
	lVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cC4e7Y008H3Puvn802q
	KLBwYKqy+vuxWH3tMi73NL1wTbvn/h7l23ofn17MY7ciq/dfWHvN5Ztz96c+j6jVe141oa7V
	TanTctfMV50q3bOyr9jJ3JUvuflup6jOxUVSO+1jJnOFVwrx3fBly9J+/6hNOyshcXX1WYkp
	R14Y7LGYEbY0iJU/r1qJpTgj0VCLuag4EQAvLqFpsAIAAA==
X-CFilter-Loop: Reflected

This is a preparation patch that introduces migration modes.

The damon_pa_pageout is renamed to damon_pa_migrate and it receives an
extra argument for migration_mode.

No functional changes applied.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/paddr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 081e2a325778..277a1c4d833c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -224,7 +224,12 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
+enum migration_mode {
+	MIG_PAGEOUT,
+};
+
+static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
+				      enum migration_mode mm)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
@@ -249,7 +254,14 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	switch (mm) {
+	case MIG_PAGEOUT:
+		applied = reclaim_pages(&folio_list);
+		break;
+	default:
+		/* Unexpected migration mode. */
+		return 0;
+	}
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
@@ -297,7 +309,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme);
+		return damon_pa_migrate(r, scheme, MIG_PAGEOUT);
 	case DAMOS_LRU_PRIO:
 		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
-- 
2.34.1

