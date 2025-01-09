Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082561ACEB2;
	Thu,  9 Jan 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445103; cv=none; b=hZD6UmKBUYKJrLX+iUz0NztI+ry1COfW/amPntuk4LovjhfbqBNv9zLPgOoyYMuDcJ6eNj5ejJz2WrZUhmNimJ4usFlGzHfULIO0OQqQ6SVUb5EIdvDhqgtg/0aX1WuRsYDYWiTgmGFDmXbJltXcm1h3xvec8Z6Em37/4HzKZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445103; c=relaxed/simple;
	bh=VTPumCjyOZzpcnH5UkJNLIwC7RykeAkPieOWziLnSjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuimbcuASEUSLfpc/GSdKf94c2aCUVXk/5tWP9DSKObZE4nDdJCYM8wmwmEV7Y+1MKhVfoWm/cp7QlaedoOEwC64EECRH6Yyaf39kI81kk6wmtRuwiKBvtrqZe2pDIlbyc8iLnSmSl4GB/ZOiR4/mcn771WmyF8C6CnEqzurDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSj+cWsJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSj+cWsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C31C4CEEA;
	Thu,  9 Jan 2025 17:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445102;
	bh=VTPumCjyOZzpcnH5UkJNLIwC7RykeAkPieOWziLnSjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSj+cWsJLxLYLKIerVnKmUOKM4kdgjseSjeI8f9V7mRbskhrL5TAk4RFZRQXcZfiQ
	 LN7g8yMoqdqifi4p5cyyYwifg3EcoiwCQ7ioHusB1wN9VcsNGfEZjR+1VDJyz5fW3W
	 Qa5MY/JaiSPH6D6RLU5XRpYMdcFSj1V+v6AdVJzMty5/7avSWb+daBp14+J9eW7AH7
	 PD7YAiQyJjWADMlon0yZqvdeclzCnkeqADaRVeBg4/kI6jjz1Ukkt3eky9CdWfaeN3
	 RIEcmXy4BTz3la+Yp4OpJfMxwusNmakZsMIQk/jOqsLW7w+p/WPXS6ynYT4qjmWMNa
	 iu+qLWHg6eleQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 05/10] mm/damon: add 'allow' argument to damos_new_filter()
Date: Thu,  9 Jan 2025 09:51:21 -0800
Message-Id: <20250109175126.57878-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON API users should set damos_filter->allow manually to use a DAMOS
allow-filter, since damos_new_filter() unsets the field always.  It is
cumbersome and easy to mistake.  Add an arugment for setting the field
to damos_new_filter().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h       | 2 +-
 mm/damon/core.c             | 7 ++++---
 mm/damon/paddr.c            | 3 ++-
 mm/damon/reclaim.c          | 2 +-
 mm/damon/sysfs-schemes.c    | 2 +-
 mm/damon/tests/core-kunit.h | 4 ++--
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8a2d104df5a3..0834d7ffcb84 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -801,7 +801,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching);
+		bool matching, bool allow);
 void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 76707b0635d6..55a435bdd89d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -266,7 +266,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 }
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching)
+		bool matching, bool allow)
 {
 	struct damos_filter *filter;
 
@@ -275,7 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
-	filter->allow = false;
+	filter->allow = allow;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
@@ -806,7 +806,8 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 			continue;
 
 		new_filter = damos_new_filter(
-				src_filter->type, src_filter->matching);
+				src_filter->type, src_filter->matching,
+				src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
 		damos_commit_filter_arg(new_filter, src_filter);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 817acfd4f8a2..6b4397de4199 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -259,7 +259,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		}
 	}
 	if (install_young_filter) {
-		filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true);
+		filter = damos_new_filter(
+				DAMOS_FILTER_TYPE_YOUNG, true, false);
 		if (!filter)
 			return 0;
 		damos_add_filter(s, filter);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9e0077a9404e..a675150965e0 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -221,7 +221,7 @@ static int damon_reclaim_apply_parameters(void)
 	}
 
 	if (skip_anon) {
-		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
 		if (!filter)
 			goto out;
 		damos_add_filter(scheme, filter);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index deeaf23c1fcf..9a883e8aea1c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1901,7 +1901,7 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			sysfs_filters->filters_arr[i];
 		struct damos_filter *filter =
 			damos_new_filter(sysfs_filter->type,
-					sysfs_filter->matching);
+					sysfs_filter->matching, false);
 		int err;
 
 		if (!filter)
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 8f58d3424c21..532c6a6f21f9 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -411,7 +411,7 @@ static void damos_test_new_filter(struct kunit *test)
 {
 	struct damos_filter *filter;
 
-	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
@@ -425,7 +425,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
 
-	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
+	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	f->addr_range = (struct damon_addr_range){
 		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
 
-- 
2.39.5
