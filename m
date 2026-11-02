Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633882;
	b=gNioyG2+peOtzu0Fpf0g8//Pp5AJa4Ssvko5S7NaJoWljgpNfnnW2h7t33Tcr6FVsk3K
	 O7XlcHRZJfLttIDDd9arFPJSE4fH59EWqReww+jqFDYiiQw+IfuHnOVV3GFMEzE5uk6zJ
	 iUNliRtakWxvR8hWbJ/W7reh0sY9JAhlGFicoKXXUQyEZ2AiMmWyjm9zdOt2hxPhiW62Q
	 RjoSCWCrL7eNaaU4a96WfJuT5rNTPP6e8+1gfFsj+LJcTHdwuAavj7lI58imAscUZSLeM
	 +97MVOLP3OJBRHxVoW2msx/pukNDH60+Q7vHH2ocwEQSad3Hc15NiKhhyInikTRcm0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RDxKZCrFjBdbqjmhaMnboUOhPibC6AsFu5GphLVZVgw=;
	b=J9sQNFZtHmu3qKhJEkDUpg7DAPonpx5XKxNaEmHNL7gHjW2NpoTr2AVAKfj9jzIbhSoV
	 i2mixmYVDeEhWCyLLvOs3PY0TOUwZT1/Blz07Y+K2DCSovB1e569FxsvHooF422E+2UJD
	 ycvRur7NNf03d0jgigNdmpqGBmEYzMUroohc6jKKD6feHj3EOLwoJuwYOLyAkutWqaxBG
	 a5t6afRF72zySUSZGZOpHKY0ccTQGXZACBrUyVnNesmCFz02vwZ8y4uzD3SX63aOeiQ2n
	 SsvGmkCcV2oKDViqsYZE2Iu1OtNyXDE6u+xy03BauBWii363UNY0hHWhmHq+sHUAtNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIf+VxNt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0760A885A;
	Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIf+VxNt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A131F00A1C;
	Mon,  2 Nov 2026 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633881;
	bh=RDxKZCrFjBdbqjmhaMnboUOhPibC6AsFu5GphLVZVgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIf+VxNt6vX8WK4EkXYcXeo2KdBpiptVru3E3/Wu43cz8k9dnAELy96Dh/Aqf/Kvs
	 ALsbp5CYcUpxp81TRPE6s6FWLh/0SWGhIW4fQdPCmT1hibpgAjOCJBcnuqacbjUWgo
	 diMVHyzgdSgH0xg9aj+6iqx+JSDrRhlMHAQ3frWLvdHsy/kBubcHToa7rbGXqa8skC
	 xgWhzmjPeT80Z01e+4pu8t0j9L9iWAIcROC84Wnx6SDTF4380bR+yODaGs+C0M/yra
	 ZDJxrYjO5lb+khLvZsznoKCXS6Pokksjwec9ZU2AgjL0H43uRj0wT+XdCYGt1QYVLe
	 I3u1AUUtrZcEA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suhaas Joshi <suhaas@s-joshi.in>
Subject: [PATCH v5 2/2] mm/damon/core: copy only installed probe in damon_split_region_at()
Date: Mon,  2 Nov 2026 07:37:52 -0800
Message-ID: <20261102153753.97769-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102153753.97769-1-sj@kernel.org>
References: <20261102153753.97769-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In damon_split_region_at(), we copy the entire probe_hits[] and
last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
that the number of probes installed is less than DAMON_MAX_PROBES, in which
case one or more iterations is/are redundant. To remedy this, iterate over
only as many times as the number of installed probes. To do so, accept a
struct damon_ctx pointer in damon_split_region_at(), and update all
invocations of the function to pass the new argument.

Also update damon_test_split_at() and damos_test_filter_out() in
core-kunit.h to supply a context to function paths that call
damon_split_region_at().

Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c             | 42 +++++++++++++-----------
 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 28 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 36d60f3e1de62..d36823f4d0928 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2046,8 +2046,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 	return sz;
 }
 
-static int damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r);
+static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, unsigned long sz_r);
 
 /*
  * damon_apply_min_nr_regions() - Make effect of min_nr_regions parameter.
@@ -2072,7 +2072,7 @@ static unsigned long damon_apply_min_nr_regions(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region_safe(r, next, t) {
 			while (damon_sz_region(r) > max_region_sz) {
-				if (damon_split_region_at(t, r, max_region_sz))
+				if (damon_split_region_at(ctx, t, r, max_region_sz))
 					goto out;
 				r = damon_next_region(r);
 			}
@@ -2469,6 +2469,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
 /*
  * damos_skip_charged_region() - Check if the given region or starting part of
  * it is already charged for the DAMOS quota.
+ * @ctx: The pointer to the context.
  * @t:	The target of the region.
  * @rp:	The pointer to the region.
  * @s:	The scheme to be applied.
@@ -2491,8 +2492,8 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_region *r,
  *
  * Return: true if the region should be skipped, false otherwise.
  */
-static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region *r, struct damos *s,
+static bool damos_skip_charged_region(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r, struct damos *s,
 		unsigned long min_region_sz)
 {
 	struct damos_quota *quota = &s->quota;
@@ -2520,7 +2521,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
 				}
 				sz_to_skip = min_region_sz;
 			}
-			damon_split_region_at(t, r, sz_to_skip);
+			damon_split_region_at(ctx, t, r, sz_to_skip);
 			skip = true;
 		}
 	}
@@ -2579,13 +2580,13 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		}
 		/* start before the range and overlap */
 		if (r->ar.start < start) {
-			*err = damon_split_region_at(t, r,
+			*err = damon_split_region_at(ctx, t, r,
 					start - r->ar.start);
 			matched = false;
 			break;
 		}
 		/* start inside the range */
-		*err = damon_split_region_at(t, r, end - r->ar.start);
+		*err = damon_split_region_at(ctx, t, r, end - r->ar.start);
 		matched = true;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
@@ -2784,7 +2785,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
-			if (damon_split_region_at(t, r, sz))
+			if (damon_split_region_at(c, t, r, sz))
 				goto update_stat;
 		}
 		if (damos_core_filter_out(c, t, r, s))
@@ -2831,7 +2832,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
 
-		if (damos_skip_charged_region(t, r, s, c->min_region_sz))
+		if (damos_skip_charged_region(c, t, r, s, c->min_region_sz))
 			continue;
 
 		if (s->max_nr_snapshots &&
@@ -3690,15 +3691,18 @@ static void damon_verify_split_region_at(struct damon_region *r,
 /*
  * Split a region in two
  *
+ * ctx		pointer to the region's context
  * r		the region to be split
  * sz_r		size of the first sub-region that will be made
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int damon_split_region_at(struct damon_target *t,
-				  struct damon_region *r, unsigned long sz_r)
+static int damon_split_region_at(struct damon_ctx *ctx, struct damon_target *t,
+		struct damon_region *r, unsigned long sz_r)
 {
 	struct damon_region *new;
+	struct damon_probe *p;
+	int i;
 
 	damon_verify_split_region_at(r, sz_r);
 	new = damon_new_region(r->ar.start + sz_r, r->ar.end);
@@ -3710,11 +3714,13 @@ static int damon_split_region_at(struct damon_target *t,
 	new->age = r->age;
 	new->last_nr_accesses = r->last_nr_accesses;
 	new->nr_accesses = r->nr_accesses;
-	/* todo: do this for only installed probes */
-	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
-	memcpy(new->last_probe_hits, r->last_probe_hits,
-			sizeof(r->last_probe_hits));
 
+	i = 0;
+	damon_for_each_probe(p, ctx) {
+		new->probe_hits[i] = r->probe_hits[i];
+		new->last_probe_hits[i] = r->last_probe_hits[i];
+		++i;
+	}
 	damon_insert_region(new, r, damon_next_region(r), t);
 	return 0;
 }
@@ -3743,7 +3749,7 @@ static void damon_split_regions_of(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(t, r, sz_sub);
+			damon_split_region_at(ctx, t, r, sz_sub);
 			sz_region = sz_sub;
 		}
 	}
@@ -3776,7 +3782,7 @@ static void damon_split_some_regions(struct damon_ctx *ctx,
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
 
-			damon_split_region_at(t, r, sz_sub);
+			damon_split_region_at(ctx, t, r, sz_sub);
 		}
 	}
 }
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ca10d450f7e23..a5ca4bfe2f0db 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -141,6 +141,8 @@ static void damon_test_split_at(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r, *r_new;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
 
 	t = damon_new_target();
 	if (!t)
@@ -150,13 +152,29 @@ static void damon_test_split_at(struct kunit *test)
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
+	p = damon_new_probe();
+	if (!p) {
+		damon_free_region(r);
+		damon_free_target(t);
+		kunit_skip(test, "probe alloc fail");
+	}
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_region(r);
+		damon_free_target(t);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
+	damon_add_target(ctx, t);
+
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
 	r->probe_hits[0] = 7;
 	r->last_probe_hits[0] = 3;
 	r->age = 10;
 	damon_add_region(r, t);
-	damon_split_region_at(t, r, 25);
+	damon_split_region_at(ctx, t, r, 25);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	if (damon_nr_regions(t) != 2)
 		goto out;
@@ -175,7 +193,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 out:
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static void damon_test_merge_two(struct kunit *test)
@@ -1799,6 +1817,8 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
+	struct damon_ctx *ctx;
+	struct damon_probe *p;
 	int err;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
@@ -1819,28 +1839,44 @@ static void damos_test_filter_out(struct kunit *test)
 	}
 	damon_add_region(r, t);
 
+	p = damon_new_probe();
+	if (!p) {
+		damon_free_target(t);
+		damos_destroy_filter(f);
+		kunit_skip(test, "probe alloc fail");
+	}
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_target(t);
+		damos_destroy_filter(f);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
+	damon_add_target(ctx, t);
+
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1, &err));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = 1;
 	r->ar.end = 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1, &err));
+			damos_filter_match(ctx, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = 6;
 	r->ar.end = 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, 1, &err));
+			damos_filter_match(ctx, t, r, f, 1, &err));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = 1;
 	r->ar.end = 4;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1, &err));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, f, 1, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
@@ -1856,7 +1892,7 @@ static void damos_test_filter_out(struct kunit *test)
 	r->ar.start = 2;
 	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, 1, &err));
+			damos_filter_match(ctx, t, r, f, 1, &err));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
@@ -1869,7 +1905,7 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_destroy_region(r2, t);
 
 out:
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 	damos_free_filter(f);
 }
 
@@ -2459,6 +2495,7 @@ static void damos_test_esz_goal_temporal(struct kunit *test)
 static void damon_test_last_region_quota_reset(struct kunit *test)
 {
 	struct damos s = {0};
+	struct damon_ctx *ctx;
 	struct damon_target *t;
 	struct damon_region *r1, *r2;
 	unsigned long min_region_sz = 1;
@@ -2485,7 +2522,14 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	s.quota.charge_target_from = t;
 	s.quota.charge_addr_from = r1->ar.end;
 
-	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_free_target(t);
+		kunit_skip(test, "ctx alloc failed");
+	}
+	damon_add_target(ctx, t);
+
+	skipped = damos_skip_charged_region(ctx, t, r2, &s, min_region_sz);
 
 	/* 'r2' is not processed, it should not skip */
 	KUNIT_EXPECT_EQ(test, skipped, false);
@@ -2494,7 +2538,7 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
 	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
 
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static struct kunit_case damon_test_cases[] = {
-- 
2.47.3
