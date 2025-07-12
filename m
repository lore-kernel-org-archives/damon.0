Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD30029A307;
	Sat, 12 Jul 2025 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349833; cv=none; b=tBTfVYLZQ/zM9eJHyDd7RJ8iOz8NjWgrjX7rdat8PWMMQqpBLzCByZmJaKmKOuiGnwUfp8tHHrA4iY8BXM5hhJ7Ptm1L3PNhyXbUYbVPBUxpVDIq2IopMBeKVb8ktqrmrrbZ7YHHTadoKAV0s7LXgMhd5s5PD1ZbzcavBdRVXns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349833; c=relaxed/simple;
	bh=dnbBIoiWMyEPhOBD2O+z/mHI1a/WsMzxyryGAQlSQsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0V3eH4r1V16ORSLd35xYS6uA+WwLRCgbwCDKXjlZ+YgqtwCNyBp1WjyxMgxPDiPEOlXGen4iqHMWgQMfEm1DC6red7DffRYvaYf5WfyqtXDgFt17e5111zybNbve7ssXf9wRmnz8zunmgMz4E/wm029l/4j3jeKNhsnYO+hM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8v/haOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8v/haOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E031AC4CEF1;
	Sat, 12 Jul 2025 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752349833;
	bh=dnbBIoiWMyEPhOBD2O+z/mHI1a/WsMzxyryGAQlSQsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8v/haOo/sr/cW7UzHViSG7jG2NDvn3mEJydrAguNE2pADocNYFn9UqCJKcBwyNYc
	 DbW+E8jFph9RJ+xwhaS81tMh6GfFXF55QN6vdbha+7vsoZX+DS5kOoPLaaUozcMFV/
	 MZSzvKvyYQPgQY7n6P/yF6e92QddeSAtXzkz/nafa/wMYIWiaPHCHixhlF0KUuJskG
	 nLFSRJGHlqd4L5oNz27q0Lm3ZiQjVJbVBas7v4qyvQJhdwmjGelSqcaCqRCvBSJyOd
	 mxK+DZHpBCZ9fBsWXkUbl7PEqAqDNZCDMRSXUFtcu6nkbkf/YOZ7JViK7FQ/MbUZaJ
	 6tnFruKRpNN9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/14] mm/damon/sysfs: remove damon_sysfs_destroy_targets()
Date: Sat, 12 Jul 2025 12:50:13 -0700
Message-Id: <20250712195016.151108-12-sj@kernel.org>
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

The function was introduced for putting pids and deallocating
unnecessary targets.  Hence it is called before damon_destroy_ctx().
Now vaddr puts pid for each target destruction (cleanup_target()).
damon_destroy_ctx() deallocates the targets anyway.  So
damon_sysfs_destroy_targets() has no reason to exist.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5eba6ac53939..b0f7c60d655a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1295,14 +1295,6 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 	return damon_set_attrs(ctx, &attrs);
 }
 
-static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
-{
-	struct damon_target *t, *next;
-
-	damon_for_each_target_safe(t, next, ctx)
-		damon_destroy_target(t, ctx);
-}
-
 static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_regions *sysfs_regions)
 {
@@ -1337,7 +1329,6 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 		struct damon_ctx *ctx)
 {
 	struct damon_target *t = damon_new_target();
-	int err = -EINVAL;
 
 	if (!t)
 		return -ENOMEM;
@@ -1345,16 +1336,10 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	if (damon_target_has_pid(ctx)) {
 		t->pid = find_get_pid(sys_target->pid);
 		if (!t->pid)
-			goto destroy_targets_out;
+			/* caller will destroy targets */
+			return -EINVAL;
 	}
-	err = damon_sysfs_set_regions(t, sys_target->regions);
-	if (err)
-		goto destroy_targets_out;
-	return 0;
-
-destroy_targets_out:
-	damon_sysfs_destroy_targets(ctx);
-	return err;
+	return damon_sysfs_set_regions(t, sys_target->regions);
 }
 
 static int damon_sysfs_add_targets(struct damon_ctx *ctx,
@@ -1458,13 +1443,11 @@ static int damon_sysfs_commit_input(void *data)
 	test_ctx = damon_new_ctx();
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err) {
-		damon_sysfs_destroy_targets(test_ctx);
 		damon_destroy_ctx(test_ctx);
 		goto out;
 	}
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
 out:
-	damon_sysfs_destroy_targets(param_ctx);
 	damon_destroy_ctx(param_ctx);
 	return err;
 }
-- 
2.39.5
