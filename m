Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B719DF75;
	Thu, 19 Dec 2024 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581026; cv=none; b=ohWfih+hvKbQAbJbtRA7fQz4IJ6+mjcWHVfCxUx9D+y64V9gEoNQDXKRk6lsjvY7OSotg2iToUBDWRbAoeQd+UWeUvifPGLp6UE1TtcUbq1Pky6k167CFm8gYNuTfpIXXzqoyR+UqB2LqAtbQt4U6kTLsDrd1capBGeS0rRMo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581026; c=relaxed/simple;
	bh=qRmiCMizOQQeo+/I858Y/f5o5hnl0HiSgoRowr7L2/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxBpXTxAHEmlnAf+zzTa8L6sNeB3gST9HGvfTPg0+k7CRB9p0yuXP2hBSwWQ3QJL0VXm8tlUEQKwDCnUpL8J3ZvTLaXLJEBlFvUu7E/XOvg2vlAnoYRXOVcbB58BuqMvecFv/mj+8dcmeen4VcSorB+oVaa3EB1V+ycOUq6RVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUXxuYoz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUXxuYoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841BEC4CED4;
	Thu, 19 Dec 2024 04:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581025;
	bh=qRmiCMizOQQeo+/I858Y/f5o5hnl0HiSgoRowr7L2/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUXxuYoz0GNi9lf9CHZM18zuewqVRNsYobwBykPHSYrMV9AgbT2ibgoGTL7yCHIs4
	 viP8pP4alQGmgJSLHf/I5LsPUACsFYRzpQicIDxhcro7F8wUnWsW0QJrKrCo8NgoEk
	 HUscxtnN3hWLtn3zVIU4krkMQI0vt2dDIKyl6z1/+gNxTaVQamtpETRyvHw3MeDDUQ
	 JG0qHKEokMfFer8zvAjHZZ7iuDhZgllJPQNKHeJp47L2I30y/9tFFNYIYx6/XbXuCJ
	 5+Szxy6CAkRdObErvHvP4QfbdqQHcpOeXfMxFVtN3yJgfhJubzqYydJoFvAg7koQuU
	 F7bPo+Gki1G/w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/18] mm/damon/paddr: report filter-passed bytes back for normal actions
Date: Wed, 18 Dec 2024 20:03:15 -0800
Message-Id: <20241219040327.61902-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
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

