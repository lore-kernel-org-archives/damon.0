Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D51E0B61;
	Mon,  6 Jan 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192054; cv=none; b=jOTE0vNcV2xeIEXQYY7wujlXHAY1rE5e89d6hQBmW8BY1BIOW/+mgjbZKXFGM8ms8rOGivK/JqVPnkzMCCKjoA34T420OKLbG69egtvsllX5ACcYiA678MdK5a0Vc8GVD2sSPxeCHLpcd+Fv1+kiPr4cp4CYXxMPF0G99pAlKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192054; c=relaxed/simple;
	bh=qRmiCMizOQQeo+/I858Y/f5o5hnl0HiSgoRowr7L2/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0Rh12zMkDNDUmyuHenscGft0YDjRwMUKM6Ns/mpLY0lc9AESD2/BdnPcQXKL1E8FrnpUETItRcYFNnLc+lh4HQs5LkkIKcXUOCs+44Gwjw49k1eCbk+UEu/jB9iXxJ5/D85t9EAGmG5XJ5YjgHKAJldkk4E7LQA8xRAQuhktoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA9EK67v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA9EK67v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2255AC4CEE1;
	Mon,  6 Jan 2025 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192053;
	bh=qRmiCMizOQQeo+/I858Y/f5o5hnl0HiSgoRowr7L2/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA9EK67v2YtDPIKvr5mAQaNXyERVAGH9DAeSw7HlU3+SnipZEqPU6LZF6KliRbYOP
	 I79h9ZLxSPiSD/EB3IHMigjvY1Ov1yW+6CVCj0WlsvwGagWkH4uzAlOd4+S8Pm39cZ
	 Br7cJp0yzFpV41sTA9sg5yw5SwwIXdQIJF2ZNoiDNX5tssjc6dZbuAlPlmxbkwkH4Q
	 HAXF8OjZH7oLTDiQ2Kxe6AwKMbYLl/gVPUkIXQecu55SwRPUvIEmGpaTop9G2/inlU
	 x8yBSdjdkYaHJcd8ICqtI777erM3yFwCWORnnwEPc0Cf87i1oRAMPD+MQxqBX8iUFg
	 VeH8Scq0iQ/Yg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/16] mm/damon/paddr: report filter-passed bytes back for normal actions
Date: Mon,  6 Jan 2025 11:33:50 -0800
Message-Id: <20250106193401.109161-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_operations->apply_scheme() implementations are requested to report
back how many bytes of the given region has passed DAMOS filter.
'paddr' operations set implementation supports some of region-internal
DAMOS filter handling for normal DAMOS actions except DAMOS_STAT action.
But, those are not respecting the request.  Report the region-internal
DAMOS filter-passed bytes back for the actions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 3530ef9c80bd..5944316a0b4c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -243,7 +243,8 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	return false;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
+static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
@@ -272,6 +273,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
+		else
+			*sz_filter_passed += folio_size(folio);
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
@@ -292,7 +295,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 }
 
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
-		struct damon_region *r, struct damos *s, bool mark_accessed)
+		struct damon_region *r, struct damos *s, bool mark_accessed,
+		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied = 0;
 
@@ -304,6 +308,8 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
+		else
+			*sz_filter_passed += folio_size(folio);
 
 		if (mark_accessed)
 			folio_mark_accessed(folio);
@@ -317,15 +323,17 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 }
 
 static unsigned long damon_pa_mark_accessed(struct damon_region *r,
-	struct damos *s)
+	struct damos *s, unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, s, true);
+	return damon_pa_mark_accessed_or_deactivate(r, s, true,
+			sz_filter_passed);
 }
 
 static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
-	struct damos *s)
+	struct damos *s, unsigned long *sz_filter_passed)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, s, false);
+	return damon_pa_mark_accessed_or_deactivate(r, s, false,
+			sz_filter_passed);
 }
 
 static unsigned int __damon_pa_migrate_folio_list(
@@ -449,7 +457,8 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 	return nr_migrated;
 }
 
-static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
+static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
+		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
@@ -462,6 +471,8 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s)
 
 		if (damos_pa_filter_out(s, folio))
 			goto put_folio;
+		else
+			*sz_filter_passed += folio_size(folio);
 
 		if (!folio_isolate_lru(folio))
 			goto put_folio;
@@ -481,14 +492,14 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r, scheme);
+		return damon_pa_pageout(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_PRIO:
-		return damon_pa_mark_accessed(r, scheme);
+		return damon_pa_mark_accessed(r, scheme, sz_filter_passed);
 	case DAMOS_LRU_DEPRIO:
-		return damon_pa_deactivate_pages(r, scheme);
+		return damon_pa_deactivate_pages(r, scheme, sz_filter_passed);
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
-		return damon_pa_migrate(r, scheme);
+		return damon_pa_migrate(r, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		break;
 	default:
-- 
2.39.5
