Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1E3F8253;
	Wed,  8 Jul 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518863; cv=none; b=uwp7R+wgJPIFzIfnWsrB662OvLLH4NqfSQL+JaeryzfxPXnzkuUqfa42kdYcOp9Q/7uBsQysi5YNa1Ze/a7gVT82lgHi4NuZ2ycwC9/8BA3SanBSfu6L0+LOaiLs9k6M+i8uat/unAC5FYtiu/7oT0Uqr5NrPXCRgTH3xc/JCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518863; c=relaxed/simple;
	bh=7/JGs7ifWyWJkqAyuI2Me9MP9dtiT+pMxGqdQ0KqkDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+2tpRTjdY7jbAjiZ59pIUFPxT7hOVQp7Ej3DchMyYd3Vg+JNol+wQSlu3rH6x2rn88KkwHnodvgd9TAKoGkFziUe/t67RtVKc+DJsoNfQzexXz78twMdZSdazFUja83dODQ0gfVZq6TH0vw/P5vz6urK4H9dmequJwar0TQUAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAFZ8Sj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAFZ8Sj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B51F00ACA;
	Wed,  8 Jul 2026 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518847;
	bh=ICUXWtwPA7N0zgAtv6Rd+r+IHx0h0YoQN07O3wyVQi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAFZ8Sj1qWW3cLSKV/qcACmPCYLQg9p2LJLHoTRkjpeEXL5MD1N+0htJQGjslM+hE
	 /3BGo3uNcaa0eyILOC+2JtQn8vhn/1vGnZ8wDSxsZNCecEUTJ6EjzIClVqXLHyMzfp
	 QyfMLAygMZq355N8VQViE4vpua7I14y7P0dLQDIlOh/uL7l0e6r2ca2LNRXzwWPoz6
	 uy9OxRQwsIOJwjLxzUjtTAW4GBjncljTGlvanVTvYLz3hSjjw2qYFS4x6JBTW1lGAG
	 CpxOCYzmKoP7hNz8gUjZy/Kvh1H2V1NMNRRBb4qVcW7fatkXJr11VyuLVjTIopcYds
	 rCnwvoQyAJJHw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] mm/damon/core: update probe hits for new parameter commit
Date: Wed,  8 Jul 2026 06:53:56 -0700
Message-ID: <20260708135359.122587-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708135359.122587-1-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
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
index 800ff6b6d2473..15d31285515d6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -897,10 +897,32 @@ static unsigned int damon_nr_samples_for_new_attrs(unsigned int nr,
 			damon_sample_count_to_bp(nr, old_attrs), new_attrs);
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
@@ -940,8 +962,8 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
 
 	damon_for_each_target(t, ctx)
 		damon_for_each_region(r, t)
-			damon_update_monitoring_result(
-					r, old_attrs, new_attrs, aggregating);
+			damon_update_monitoring_result(r, old_attrs, new_attrs,
+					aggregating, ctx);
 }
 
 /*
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 278d46632eff4..d97280270c27b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -581,32 +581,39 @@ static void damon_test_update_monitoring_result(struct kunit *test)
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
