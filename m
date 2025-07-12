Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F32980D4;
	Sat, 12 Jul 2025 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349831; cv=none; b=RJvoT1ZVv95nlNLTlAt0WwCCmvqX5dUWnzKZqhA/sjzJKEZZ+YvI/TPcBPHRyisUrvqBKwlAG4QWO1mmcLRPw5D+Sl1uYaRLE4cuFH2TjZ8pD4B/nw7Tat2JBEGxkvMp46QF7Sn+5HToVewfz9qGni2KpwtlcCWxQFnu26YCOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349831; c=relaxed/simple;
	bh=fckFdBccHNMeF+WTVksjus+tZiKmAgrc4GdBEfhl2Po=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f60sopzdv0LnrJZsR3xS92e2AWduxwI8Kp19ihvtwpl0VP62dqzKLZVrMG4csE1Dq/GTAStNvSpcYJdj8tUp01or3E8GGiNx8MCQY4os12T30EwB/UFI7nTzpgpfxgQ0Lm2ggmJZSWqDWrkuNM+GouQo3EaTM3KAa/XepkTnVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtrVhYwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtrVhYwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96C9C4CEEF;
	Sat, 12 Jul 2025 19:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349830;
	bh=fckFdBccHNMeF+WTVksjus+tZiKmAgrc4GdBEfhl2Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtrVhYweZizfT32E7ls+t1kchwrgFxHUjb9c1BbmL95Qfm01XXrbctAVIj/9mpm26
	 XkmAmqA0yHJ9mowqc6gc/ANfsas9iKQdViE+R/wDMws+3RzEVLgigA2LH426inpdYt
	 HVyYCPpKmvRU1L/bbD3Uh7i5h6fgTZIk8Ihx2NbTd6BcciXIdEL4WwegqdbZV1uBNV
	 2Oo9qxoZitDEOt5ZU0u8z27lKspWUVUU0DXEhvumCUfAfURynO77TeMe7vt7+YY2YG
	 3D023D8dBh9nYvl5ieMIK+4jpYk4i7NCz3n+cqaVGxc7JowoxIc1UJ5KdyzgJ/c7B6
	 ew3ThgVFJl+4w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/14] mm/damon/core: add cleanup_target() ops callback
Date: Sat, 12 Jul 2025 12:50:11 -0700
Message-Id: <20250712195016.151108-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712195016.151108-1-sj@kernel.org>
References: <20250712195016.151108-1-sj@kernel.org>
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
index b83987275ff9..27305d39f600 100644
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
index b82a838b5a0e..678c9b4e038c 100644
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
@@ -1137,7 +1141,7 @@ static int damon_commit_targets(
 
 			if (damon_target_has_pid(dst))
 				put_pid(dst_target->pid);
-			damon_destroy_target(dst_target);
+			damon_destroy_target(dst_target, dst);
 			damon_for_each_scheme(s, dst) {
 				if (s->quota.charge_target_from == dst_target) {
 					s->quota.charge_target_from = NULL;
@@ -1156,7 +1160,7 @@ static int damon_commit_targets(
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
