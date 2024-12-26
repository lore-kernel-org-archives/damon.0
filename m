Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5011C8FB4;
	Thu, 26 Dec 2024 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251304; cv=none; b=F6TpyPBLo9BsIVRJnTE7c7hHN29dZHs7OdlEYeEjsCby0Itd3gvIYBokoYwzQeoga0I0qaOpDBx0KvNuAei9yFIE2HsPwc/F8f3+nYqYyzZv5XuBKC4KcXjI+H41GsGTwLzja2l76yhnqP/nMExaQ71qDenbTJCcUrJqbskUYd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251304; c=relaxed/simple;
	bh=xPDKx+cgGKS4vL2pTXGyaq2E/e6yLYc/uyg/ecrFVG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9mqUxOIZpFdCxa7sGAAkALhGDyOYaWPL9fgQsaM6u33FqAxzcMeTmFsd1HRdYiHsGUr7TptDlVXerq1ICrn1rMeRO4s5IpcD2fdxQvKligG7i7zec9m1/zT8DbP8fJ8tpE8jbhu/rAkVGF2Dp1umohawCMfAwBkKOAdQv5kNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsdVucsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsdVucsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AC5C4CEDD;
	Thu, 26 Dec 2024 22:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251304;
	bh=xPDKx+cgGKS4vL2pTXGyaq2E/e6yLYc/uyg/ecrFVG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsdVucsV8Wau5wOaeCDCDIUEIxj140sC2qCi314hJXw9NQSbgGwj80fp7tQAft9vO
	 FyiLvn1wUUepP3anXtz8n+hsHp1zruw76xWlrUMqR9EWFGXkWTGGAQcVzhgcJ98XYq
	 rbEKcYuplAYaD3mt0knO7evq+zCwUUJu0Vwq7+ozUKo/L5h4jPcR18+bo3q47yE2Pj
	 DoLdhzRHoPVAwVzgK2/r5I6O5wF+l/YcYL9Ot7tutCoh3Q4Dblcgv4J/ly7U3pDE3U
	 8khMFW39XMka8uPqzIq9oExKuWSQ5I5qoF6Jwf0BfLKvW8DtHeo9WKGsvClh7EU+Un
	 tPoPa5rI5ZfjQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/10] mm/damon: add pass argument to damos_new_filter()
Date: Thu, 26 Dec 2024 14:14:40 -0800
Message-Id: <20241226221445.78433-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_new_filter() sets damos_filter->pass as false always.  The API
users hence should manually set the field to use the filter as a pass
filter.  It is cumbersome and easy to mistake.  Add an arugment for
setting the field to damos_new_filter().

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
index 122c30e4ce19..ad0360711aca 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -801,7 +801,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching);
+		bool matching, bool pass);
 void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 71db2c754e6d..13f12d82de5f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -266,7 +266,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 }
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching)
+		bool matching, bool pass)
 {
 	struct damos_filter *filter;
 
@@ -275,7 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
-	filter->pass = false;
+	filter->pass = pass;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
@@ -806,7 +806,8 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 			continue;
 
 		new_filter = damos_new_filter(
-				src_filter->type, src_filter->matching);
+				src_filter->type, src_filter->matching,
+				src_filter->pass);
 		if (!new_filter)
 			return -ENOMEM;
 		damos_commit_filter_arg(new_filter, src_filter);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 71cb02128b46..cd89500efc22 100644
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
