Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E291F9A87;
	Fri, 27 Dec 2024 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333712; cv=none; b=fhZQ8oQUG1XTWSl3m9F8QoLS9M2XINzM1dT1TQrEjNSjYuLIKOE0AectlsZNjMpDLeJoBxdqT6Lplcdg1aldYubRzd+/+YzWmlRt76icNBiUoMWzKNZlsictQidZfMYEsKf3EP/yN77BV+XoZmkCQH3Jqiep38SLrPwyvYFYygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333712; c=relaxed/simple;
	bh=xPDKx+cgGKS4vL2pTXGyaq2E/e6yLYc/uyg/ecrFVG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrymIiWbHwwLdpPR09rDGCQik+8nuhp/7wqYyK07/9uS3EaRNDZxE+zKoLU0MuagGpYFuDX7eJPHp5nrLT7WtlyTGdEaYO4lbMS1zWQT+fINzZH53cfGrR/pl8sDKZJjRIa0re50W931sLJ4Ouywa9Ab3VFElfWm3Y1QSjI/EYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FULY2tdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FULY2tdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFC0C4CED4;
	Fri, 27 Dec 2024 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333712;
	bh=xPDKx+cgGKS4vL2pTXGyaq2E/e6yLYc/uyg/ecrFVG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FULY2tdgi1VaO4rrf16MKP58oixHQI2N2jJn/F/gnUlRh3zifCIZDSg+EO6KzQdaj
	 3GGh53n0FQNy8mV2be3B1SdfQpVgCKLXkieHaUKXKwzKDfZTTK9S80krp4qqnSZjrU
	 1ZyOge3igtQM/3kvplwrHdGCFPUNTcMv6cPUINRZHh+vd4Hf6bKp+wbRD26nIjC/uB
	 Rz9DMNNmuvr3aArpTA+t56Ghi+9EasW8BIelI1Ti7Lu10SXXMmhj80Oq+YQqbfwOYM
	 mEyo0DS+QQMz4ryu7p3XPrHF+lTLxIu3oGGwzDIP4i/1P/ag0YEw+/YOSCCVMp3hK7
	 IOZIOD943H1Lg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/10] mm/damon: add pass argument to damos_new_filter()
Date: Fri, 27 Dec 2024 13:08:14 -0800
Message-Id: <20241227210819.63776-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
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
