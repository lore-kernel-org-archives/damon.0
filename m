Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F292BCF75;
	Sun,  6 Jul 2025 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832037; cv=none; b=T560T4Qoq4jm2O8R6dgdOoCl+cZ4qx5ojj3vW8NSHGI6d7U0d0Kw5qXhwudBPkj7DO9+Ohj5msTYp5oSDFuuBdNZyvJmu7Qwk2FVn3/8e3QpcRZ4OAYC3oey5FAlKeSzU5jsH7talhQReQXevaZvE9BrQ9s9qyMb9hLJr9A0N/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832037; c=relaxed/simple;
	bh=arW9HamBDNLK1yN3sYPk8GcM8z+8LRLU5gO/RN527TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgxvML/MLM95AYSEEppI+Ke+3jdOhTaa+iaBqeu0L9TCagqG+WfvVB0+C03V26yrzA7o35UTmjoxPe4XlTe2GpOLSdavqhrj8f7q7Db4smxo95XboIq72vZ6ls4L63r4Wotk/H5EnkiRBtQegMep32FhZgybP3SedL0Ftufr1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToRJq6fY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToRJq6fY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC5CC4CEF1;
	Sun,  6 Jul 2025 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832035;
	bh=arW9HamBDNLK1yN3sYPk8GcM8z+8LRLU5gO/RN527TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToRJq6fY2uHmmSXBV+y5yfAj4+RYgewQgtMYQI9cnh/YJJ35fO8AbtImb2cAiFPbq
	 Y/8O+/vMt3ALjdNk7L3JbN2Qy4NPFrWv2JivT+LctVl+s9nf8LPH1BagIRI8OWz8fK
	 p52tHZYlc4kzP+0S85hV1JtmzuS+PNciFusmjtPyjdCa95I4bVobY2qP0NOD+Mngp+
	 01+SEHAufJrEGkFYSGJkQjRTuZr15O+myKC0FcE8ZQxgRX4N1KvAbi5Cdgf92dNTqx
	 P1eD40XDQAWzN8JUv0G2a+GNbUxZLeOCZZDCqXq7rV5bGapONn6ke2Uq0c8Zbr5vkA
	 Q3z+TavRLsyEQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/14] mm/damon/vaddr: put pid in cleanup_target()
Date: Sun,  6 Jul 2025 13:00:14 -0700
Message-Id: <20250706200018.42704-11-sj@kernel.org>
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

Implement cleanup_target() callback for [f]vaddr, which calls put_pid()
for each target that will be destroyed.  Also remove redundant put_pid()
calls in core and sysfs, which was required to be done redundantly due
to the lack of such self cleanup in vaddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c  |  2 --
 mm/damon/sysfs.c | 10 ++--------
 mm/damon/vaddr.c |  6 ++++++
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce1087b5436f..6d526c5263d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1099,8 +1099,6 @@ static int damon_commit_targets(
 		} else {
 			struct damos *s;
 
-			if (damon_target_has_pid(dst))
-				put_pid(dst_target->pid);
 			damon_destroy_target(dst_target, dst);
 			damon_for_each_scheme(s, dst) {
 				if (s->quota.charge_target_from == dst_target) {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f2f9f756f5a2..5eba6ac53939 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1298,13 +1298,9 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
-	bool has_pid = damon_target_has_pid(ctx);
 
-	damon_for_each_target_safe(t, next, ctx) {
-		if (has_pid)
-			put_pid(t->pid);
+	damon_for_each_target_safe(t, next, ctx)
 		damon_destroy_target(t, ctx);
-	}
 }
 
 static int damon_sysfs_set_regions(struct damon_target *t,
@@ -1387,10 +1383,8 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	if (!damon_target_has_pid(ctx))
 		return;
 
-	damon_for_each_target_safe(t, next, ctx) {
-		put_pid(t->pid);
+	damon_for_each_target_safe(t, next, ctx)
 		damon_destroy_target(t, ctx);
-	}
 }
 
 /*
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 46554e49a478..5c992317ee4c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -627,6 +627,11 @@ static bool damon_va_target_valid(struct damon_target *t)
 	return false;
 }
 
+static void damon_va_cleanup_target(struct damon_target *t)
+{
+	put_pid(t->pid);
+}
+
 #ifndef CONFIG_ADVISE_SYSCALLS
 static unsigned long damos_madvise(struct damon_target *target,
 		struct damon_region *r, int behavior)
@@ -711,6 +716,7 @@ static int __init damon_va_initcall(void)
 		.prepare_access_checks = damon_va_prepare_access_checks,
 		.check_accesses = damon_va_check_accesses,
 		.target_valid = damon_va_target_valid,
+		.cleanup_target = damon_va_cleanup_target,
 		.cleanup = NULL,
 		.apply_scheme = damon_va_apply_scheme,
 		.get_scheme_score = damon_va_scheme_score,
-- 
2.39.5
