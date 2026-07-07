Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439F2BE035;
	Tue,  7 Jul 2026 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399150; cv=none; b=G77NjnXW8BgLQu3wm5UHjpbSQ/Gpm/Otl1MBoHDCfTSW92K7Qt8mZFiTdSKL1uD27EV8X13ixhuaglWBuFHttbNfSs929W8TZsagrr9xg6BVEXWG2ZefpVjDbQbOyEw1SpKbOzwRSYPOymcjwIPRnkrdKJ5C+9Tv/uJsCBqR99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399150; c=relaxed/simple;
	bh=1+MbMzYlLkhEA3NeZZa+gDG9Sw5GvwEtJ/xoaDgPGLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKFs0cp8REVaxBx52K9ZNrasDtUvWlgVDvoqNsKW3LNfxmQnYRJxx6EgDFT07juJKx0xLub1qnQejeG99v4jLfiq0cs+nHbKYLYpbkYyINe1qw6laGRNHJEHeUtY9HpElDgoeMgD1TI0fIbugPr4Ok5TeDmfGGQhLhI5FxgHR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouIrKoiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouIrKoiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D31F000E9;
	Tue,  7 Jul 2026 04:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399148;
	bh=+XSDJAwa5tXme4d9cp7HNanm6CROUB+NOag32I1le3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouIrKoiU9wgucKy3Mox6BiQ0RDq1VRQORbJxp3J5XvsGwT9XxiMClXsae+fz27ZEY
	 0yQ5NF9QFJYJZXDxBpmWLS0hYJnby1gpY88HT8DmAN3T4myvAvcUtsp7JyeOZvW9Yg
	 LFzd1zubKI0JOTdgrDKygsY4ijD/k9fn6uEx2ZiK0SJTUC1XaerZvh/3dDW/qj157D
	 qQaHVzfusjRud5HetQ02epHcanYXMqSUWOPFsMa0IsPzewlEST51kWB4Eex7Peiyk1
	 Re9D/LexNfmU+Z3XcZINE+dkk+t/AKf5ePsKiguUjMjGyGvkLALQ/m1S//629gObsd
	 TKNi0M4TeeG+A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/6] mm/damon/core: update probe hits for new parameter commit
Date: Mon,  6 Jul 2026 21:38:25 -0700
Message-ID: <20260707043828.97900-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707043828.97900-1-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can update DAMON parameters at runtime.  If the samples and/or
aggregation intervals are updated in this way, monitoring results
depending on the intervals should also be updated for a more accurate
snapshot.  The age and nr_accesses are properly updated, while
probe_hits are not updated in the way.  Do the update.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 28 +++++++++++++++++++++++++---
 mm/damon/tests/core-kunit.h | 13 ++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cda318806b65b..9a3ff0fe55a61 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -898,10 +898,32 @@ static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr_accesses,
 			new_attrs);
 }
 
+static void damon_update_probe_hits(struct damon_region *r,
+		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
+		bool aggregating, struct damon_ctx *ctx)
+{
+	struct damon_probe *p;
+	int i = 0;
+
+	damon_for_each_probe(p, ctx) {
+		r->last_probe_hits[i] = damon_nr_samples_for_new_attrs(
+				r->last_probe_hits[i], old_attrs, new_attrs);
+		if (!aggregating)
+			r->probe_hits[i] = damon_nr_samples_for_new_attrs(
+					r->probe_hits[i], old_attrs,
+					new_attrs);
+		else
+			r->probe_hits[i] = 0;
+		i++;
+	}
+}
+
 static void damon_update_monitoring_result(struct damon_region *r,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
-		bool aggregating)
+		bool aggregating, struct damon_ctx *ctx)
 {
+	damon_update_probe_hits(r, old_attrs, new_attrs, aggregating, ctx);
+
 	r->last_nr_accesses = damon_nr_samples_for_new_attrs(
 			r->last_nr_accesses, old_attrs, new_attrs);
 	if (!aggregating)
@@ -941,8 +963,8 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
 
 	damon_for_each_target(t, ctx)
 		damon_for_each_region(r, t)
-			damon_update_monitoring_result(
-					r, old_attrs, new_attrs, aggregating);
+			damon_update_monitoring_result(r, old_attrs, new_attrs,
+					aggregating, ctx);
 }
 
 /*
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 86eae3a590354..8e01437eb5ea8 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -603,32 +603,39 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 		.sample_interval = 10, .aggr_interval = 1000,};
 	struct damon_attrs new_attrs;
 	struct damon_region *r = damon_new_region(3, 7);
+	struct damon_ctx *ctx;
 
 	if (!r)
 		kunit_skip(test, "region alloc fail");
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_free_region(r);
+		kunit_skip(test, "ctx alloc fail");
+	}
 
 	r->nr_accesses = 15;
 	r->age = 20;
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 100, .aggr_interval = 10000,};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false, ctx);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 1, .aggr_interval = 1000};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false, ctx);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 1, .aggr_interval = 100};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false, ctx);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 20);
 
 	damon_free_region(r);
+	damon_destroy_ctx(ctx);
 }
 
 static void damon_test_set_attrs(struct kunit *test)
-- 
2.47.3
