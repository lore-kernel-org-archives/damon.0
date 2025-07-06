Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F962BCF7C;
	Sun,  6 Jul 2025 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832037; cv=none; b=tu/YV21ajyt8Dvm+d2uN4YFbc+gbXm3s6Xl80Bs4zzysBadyFUAZkWF+y2+GW7AgjEXrPgsA4nljVJzzpZcYHqxla96wZGkCGbfzmfVTy++0QcvCcJKviOJYRWLIdak5b4RmFoE06UKhkfljTIz10QJMfXrMM7TcRRNZ79ZPsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832037; c=relaxed/simple;
	bh=4kAaXCChET6SPUEFVOVLQUp7PQZ6yAFwNr2FE2D6vJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZVcot+Cms1xR3TOdgkcRsuYeZhEURh9Wl4/XHZqOvw3uwF1RrT02au3iPdVdUOlgVdMhZgXFqu9RVj3BMFKh5OW5aC4uvoQjbDGl1S3nSV7eICRF8v3plFOsrIf0VML7B3hJREHWdqs2EEK/e07oAYItfct7pNk5uWxv4FG6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAqi3+RJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAqi3+RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B2C4CEF2;
	Sun,  6 Jul 2025 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832034;
	bh=4kAaXCChET6SPUEFVOVLQUp7PQZ6yAFwNr2FE2D6vJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAqi3+RJgJAWDhlMgSPcliDtIJL40yZvJcgwtX5kaJs0AznUwEru+Z8DgE5ftQ3J7
	 arBc5jSCbrracd0a1Ug7Y7fCpiutotnskeue42bVVxSR0motuBS4+COHM7rmlYDkYa
	 oy/aKiOrtgM/5YiktRpTfBeh1yk5aDktt5T7ws/aIDZOWaEoJv88MQ/7bR9wWlkpsE
	 gevViW2N6C4H2TZLECWN9U4lyxUU3/swTSG0+v3QovQkVtvrpNH0kC6k5Xo0UOkarW
	 GCMoY6Yc5vv0tIrjKOBQvs1xIrYBmdPxs826ekV4NQzfclkbcI11BzoHudP3WauSsn
	 plpXkvAC7Ze7Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/14] mm/damon/core: add cleanup_target() ops callback
Date: Sun,  6 Jul 2025 13:00:13 -0700
Message-Id: <20250706200018.42704-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some DAMON operation sets may need additional cleanup per target.  For
example, [f]vaddr need to put pids of each target.  Each user and core
logic is doing that redundantly.  Add another DAMON ops callback that
will be used for doing such cleanups in operations set layer.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h        |  4 +++-
 mm/damon/core.c              | 12 ++++++++----
 mm/damon/sysfs.c             |  4 ++--
 mm/damon/tests/core-kunit.h  |  4 ++--
 mm/damon/tests/vaddr-kunit.h |  2 +-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2d51b575d660..52b307db63de 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -608,6 +608,7 @@ enum damon_ops_id {
  * filters (&struct damos_filter) that handled by itself.
  * @target_valid should check whether the target is still valid for the
  * monitoring.
+ * @cleanup_target is called before the target will be deallocated.
  * @cleanup is called from @kdamond just before its termination.
  */
 struct damon_operations {
@@ -623,6 +624,7 @@ struct damon_operations {
 			struct damon_target *t, struct damon_region *r,
 			struct damos *scheme, unsigned long *sz_filter_passed);
 	bool (*target_valid)(struct damon_target *t);
+	void (*cleanup_target)(struct damon_target *t);
 	void (*cleanup)(struct damon_ctx *context);
 };
 
@@ -933,7 +935,7 @@ struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
 bool damon_targets_empty(struct damon_ctx *ctx);
 void damon_free_target(struct damon_target *t);
-void damon_destroy_target(struct damon_target *t);
+void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
 unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index eaa2306ff324..ce1087b5436f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -502,8 +502,12 @@ void damon_free_target(struct damon_target *t)
 	kfree(t);
 }
 
-void damon_destroy_target(struct damon_target *t)
+void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx)
 {
+
+	if (ctx && ctx->ops.cleanup_target)
+		ctx->ops.cleanup_target(t);
+
 	damon_del_target(t);
 	damon_free_target(t);
 }
@@ -551,7 +555,7 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 	struct damon_target *t, *next_t;
 
 	damon_for_each_target_safe(t, next_t, ctx)
-		damon_destroy_target(t);
+		damon_destroy_target(t, ctx);
 }
 
 void damon_destroy_ctx(struct damon_ctx *ctx)
@@ -1097,7 +1101,7 @@ static int damon_commit_targets(
 
 			if (damon_target_has_pid(dst))
 				put_pid(dst_target->pid);
-			damon_destroy_target(dst_target);
+			damon_destroy_target(dst_target, dst);
 			damon_for_each_scheme(s, dst) {
 				if (s->quota.charge_target_from == dst_target) {
 					s->quota.charge_target_from = NULL;
@@ -1116,7 +1120,7 @@ static int damon_commit_targets(
 		err = damon_commit_target(new_target, false,
 				src_target, damon_target_has_pid(src));
 		if (err) {
-			damon_destroy_target(new_target);
+			damon_destroy_target(new_target, NULL);
 			return err;
 		}
 		damon_add_target(dst, new_target);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c0193de6fb9a..f2f9f756f5a2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1303,7 +1303,7 @@ static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 	damon_for_each_target_safe(t, next, ctx) {
 		if (has_pid)
 			put_pid(t->pid);
-		damon_destroy_target(t);
+		damon_destroy_target(t, ctx);
 	}
 }
 
@@ -1389,7 +1389,7 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 
 	damon_for_each_target_safe(t, next, ctx) {
 		put_pid(t->pid);
-		damon_destroy_target(t);
+		damon_destroy_target(t, ctx);
 	}
 }
 
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 298c67557fae..dfedfff19940 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -58,7 +58,7 @@ static void damon_test_target(struct kunit *test)
 	damon_add_target(c, t);
 	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(c));
 
-	damon_destroy_target(t);
+	damon_destroy_target(t, c);
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
 	damon_destroy_ctx(c);
@@ -310,7 +310,7 @@ static void damon_test_set_regions(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, r->ar.start, expects[expect_idx++]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expects[expect_idx++]);
 	}
-	damon_destroy_target(t);
+	damon_destroy_target(t, NULL);
 }
 
 static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 7cd944266a92..d2b37ccf2cc0 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -149,7 +149,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
-	damon_destroy_target(t);
+	damon_destroy_target(t, NULL);
 }
 
 /*
-- 
2.39.5
