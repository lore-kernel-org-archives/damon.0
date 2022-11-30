Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD288464
	for <damon@lists.linux.dev>; Wed, 30 Nov 2022 20:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE37C433B5;
	Wed, 30 Nov 2022 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669838982;
	bh=A+37s6JJXYN+1C0NX4ExPJftU7PAKfFK4zc/BA9nVsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJTehjTN01AwdSRZIxWRXChbipb5IKA2UrcYJAqmQnUdb5pA7EkkQLdyPI/PW3qUc
	 Qls2bOUz1Q6sdDSEhKow2+/4fVZroN/glCQClVUhMUgdQ5t3VoS83iiS/w8Yxo09nn
	 CdJivAV8keHFdBzQHinNkD/ZyOeIS/Kozcs0CRE8jzQwi2YFH2IpLR3GEsO6vTYYNS
	 GIQLQM6qqbOH1kuilz+GLI933zjCbDE+t8GezmKmu/txjY3YhO0xZPj676hBtTqIWR
	 flgLSStWY1Z+c6TMRHuEws/WpWXPLO/hXtAkjr/q9tFcRgLumXS5AJ9GE6RxdctOS6
	 TyNjam9ZAGCPA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 02/11] mm/damon/paddr: support DAMOS filters
Date: Wed, 30 Nov 2022 20:09:28 +0000
Message-Id: <20221130200937.118005-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200937.118005-1-sj@kernel.org>
References: <20221130200937.118005-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support of the DAMOS filters in the physical address space
monitoring operations set, for all DAMOS actions that it supports
including 'pageout', 'lru_prio', and 'lru_deprio'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 71 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..ebd1905eed6f 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -202,7 +202,47 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static unsigned long damon_pa_pageout(struct damon_region *r)
+static bool __damos_pa_filter_out(struct damos_filter *filter,
+		struct page *page)
+{
+	bool matched = false;
+	struct mem_cgroup *memcg;
+
+	switch (filter->type) {
+	case DAMOS_FILTER_TYPE_ANON:
+		matched = PageAnon(page);
+		break;
+	case DAMOS_FILTER_TYPE_MEMCG:
+		rcu_read_lock();
+		memcg = page_memcg_check(page);
+		if (!memcg)
+			matched = false;
+		else
+			matched = filter->memcg_id == mem_cgroup_id(memcg);
+		rcu_read_unlock();
+		break;
+	default:
+		break;
+	}
+
+	return matched == filter->matching;
+}
+
+/*
+ * damos_pa_filter_out - Return true if the page should be filtered out.
+ */
+static bool damos_pa_filter_out(struct damos *scheme, struct page *page)
+{
+	struct damos_filter *filter;
+
+	damos_for_each_filter(filter, scheme) {
+		if (__damos_pa_filter_out(filter, page))
+			return true;
+	}
+	return false;
+}
+
+static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(page_list);
@@ -213,6 +253,11 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 		if (!page)
 			continue;
 
+		if (damos_pa_filter_out(s, page)) {
+			put_page(page);
+			continue;
+		}
+
 		ClearPageReferenced(page);
 		test_and_clear_page_young(page);
 		if (isolate_lru_page(page)) {
@@ -232,7 +277,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 }
 
 static inline unsigned long damon_pa_mark_accessed_or_deactivate(
-		struct damon_region *r, bool mark_accessed)
+		struct damon_region *r, struct damos *s, bool mark_accessed)
 {
 	unsigned long addr, applied = 0;
 
@@ -241,6 +286,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 		if (!page)
 			continue;
+
+		if (damos_pa_filter_out(s, page)) {
+			put_page(page);
+			continue;
+		}
+
 		if (mark_accessed)
 			mark_page_accessed(page);
 		else
@@ -251,14 +302,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	return applied * PAGE_SIZE;
 }
 
-static unsigned long damon_pa_mark_accessed(struct damon_region *r)
+static unsigned long damon_pa_mark_accessed(struct damon_region *r,
+	struct damos *s)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, true);
+	return damon_pa_mark_accessed_or_deactivate(r, s, true);
 }
 
-static unsigned long damon_pa_deactivate_pages(struct damon_region *r)
+static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
+	struct damos *s)
 {
-	return damon_pa_mark_accessed_or_deactivate(r, false);
+	return damon_pa_mark_accessed_or_deactivate(r, s, false);
 }
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
@@ -267,11 +320,11 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 {
 	switch (scheme->action) {
 	case DAMOS_PAGEOUT:
-		return damon_pa_pageout(r);
+		return damon_pa_pageout(r, scheme);
 	case DAMOS_LRU_PRIO:
-		return damon_pa_mark_accessed(r);
+		return damon_pa_mark_accessed(r, scheme);
 	case DAMOS_LRU_DEPRIO:
-		return damon_pa_deactivate_pages(r);
+		return damon_pa_deactivate_pages(r, scheme);
 	case DAMOS_STAT:
 		break;
 	default:
-- 
2.25.1

