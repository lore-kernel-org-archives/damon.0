Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9831F9A6
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471381; cv=pass; b=XQYrroXmSDsh3bTEpY1ap85xbohk/zOQNrqgdmhnQX+PtUqsBfVv7/zlrgLtCQdQT7101J6Ca32BqWGuOw/30GqTHICWYWB7fyqmvqMZoX2j4+Xofmmo+PRunIgVfeOZqjEzvEC9A4p/4k+eEsJDFUt0LFjtUtgu6qz/W+Q2fkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471381; c=relaxed/simple;
	bh=MYSq1b/1RCe8a+wIePFg+/BNrgeU4hiR86pzYSgOOLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l8Y9/DSRH56zpHaLfxHbpMFMD+XLPE943ueY59SYiqTCFeKpjLaxf/vnf3IN6Xemrlkh5lCNYxCxjRdrbNVc1kh85z/X9JCJGT6DbftxfG6tlI52vjbMzXgHMTwSSgy4Bg/qkVtm6qBZ5uPfb1xWPaj1TmXJIrd6rwtDLwHj9Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=NBHrDKPd; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="NBHrDKPd"
ARC-Seal: i=1; a=rsa-sha256; t=1774471375; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LPnT5EDHRufeL/fzhJOZs/J8fRx1hwnI/xGglnKq4JbyRPvQcLGgf/H+3TDDHFrsoi9zHBg660/6y/wfHV5sH3bjcDr6h0wYiEfmoQvbml03UNIDDVlphUgtvu+VAvipKJa0irtmsmuFs0FPbWhdcc05eLbG5zlWYeUG0R0hKQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774471375; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DqD0QMQyj/JtA9ctoxv8NCs/SYg/0cI+dhJe9LakKXA=; 
	b=AfCrwe1CNwN5xdA7lavEEgJJ3bD7nb/fdFrniekGV7uA9nYn6K1nCO/tUx/JlZDh5/PlkXqjVryMImY0AGAXGHUueYo3eqvU9ttjOehzyHctSy8U/ehBQsBdmGXGBXjgerYzq2JaW/yPuPbqybUS6UEYPM9Uf4o8Zv93u9E2E0U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774471375;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=DqD0QMQyj/JtA9ctoxv8NCs/SYg/0cI+dhJe9LakKXA=;
	b=NBHrDKPdkgx5qRt5+k+/GI/ws4gn1iB/heXIcwWwDVAQqt1T/Jh+l09cxl0ZUuej
	cYufcYRKaDCXKByc0OdUhq3CxKtgjYtEvgEZvD0DPciUhMU6YXxdDoDt+wCLK2HCqTe
	0Pj/OVQbvNq0HWh40WZJvECihdgRkQKjgH8NzFXw=
Received: by mx.zoho.eu with SMTPS id 1774471371990300.90080239564634;
	Wed, 25 Mar 2026 21:42:51 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] mm/damon/core: deduplicate core and ops filter commit functions
Date: Wed, 25 Mar 2026 20:42:50 +0000
Message-Id: <20260325204250.254364-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

damos_commit_core_filters() and damos_commit_ops_filters() are
identical except for which filter list they operate on.  The same
duplication exists in damos_nth_core_filter() and
damos_nth_ops_filter().

Unify each pair into a single function that takes the list_head
directly: damos_nth_filter() and damos_commit_filters_of().  This
follows the same pattern already used by damos_filters_default_reject()
in the same file.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 61 +++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b2361dbf78d1..83b0542f4d76 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -919,24 +919,13 @@ static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
 	return 0;
 }
 
-static struct damos_filter *damos_nth_core_filter(int n, struct damos *s)
+static struct damos_filter *damos_nth_filter(int n,
+		struct list_head *filters)
 {
 	struct damos_filter *filter;
 	int i = 0;
 
-	damos_for_each_core_filter(filter, s) {
-		if (i++ == n)
-			return filter;
-	}
-	return NULL;
-}
-
-static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
-{
-	struct damos_filter *filter;
-	int i = 0;
-
-	damos_for_each_ops_filter(filter, s) {
+	list_for_each_entry(filter, filters, list) {
 		if (i++ == n)
 			return filter;
 	}
@@ -973,48 +962,22 @@ static void damos_commit_filter(
 	damos_commit_filter_arg(dst, src);
 }
 
-static int damos_commit_core_filters(struct damos *dst, struct damos *src)
-{
-	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
-
-	damos_for_each_core_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_core_filter(i++, src);
-		if (src_filter)
-			damos_commit_filter(dst_filter, src_filter);
-		else
-			damos_destroy_filter(dst_filter);
-	}
-
-	damos_for_each_core_filter_safe(src_filter, next, src) {
-		if (j++ < i)
-			continue;
-
-		new_filter = damos_new_filter(
-				src_filter->type, src_filter->matching,
-				src_filter->allow);
-		if (!new_filter)
-			return -ENOMEM;
-		damos_commit_filter_arg(new_filter, src_filter);
-		damos_add_filter(dst, new_filter);
-	}
-	return 0;
-}
-
-static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
+static int damos_commit_filters_of(struct damos *dst,
+		struct list_head *dst_filters,
+		struct list_head *src_filters)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
 	int i = 0, j = 0;
 
-	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_ops_filter(i++, src);
+	list_for_each_entry_safe(dst_filter, next, dst_filters, list) {
+		src_filter = damos_nth_filter(i++, src_filters);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
 			damos_destroy_filter(dst_filter);
 	}
 
-	damos_for_each_ops_filter_safe(src_filter, next, src) {
+	list_for_each_entry_safe(src_filter, next, src_filters, list) {
 		if (j++ < i)
 			continue;
 
@@ -1108,10 +1071,12 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 {
 	int err;
 
-	err = damos_commit_core_filters(dst, src);
+	err = damos_commit_filters_of(dst, &dst->core_filters,
+			&src->core_filters);
 	if (err)
 		return err;
-	err = damos_commit_ops_filters(dst, src);
+	err = damos_commit_filters_of(dst, &dst->ops_filters,
+			&src->ops_filters);
 	if (err)
 		return err;
 	damos_set_filters_default_reject(dst);
-- 
2.34.1

