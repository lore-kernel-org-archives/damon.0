Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAE15EFAF;
	Tue, 18 Jun 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734700; cv=none; b=VYbeqzwwJef5SF1IWwnOW7Z31zSnOrX9VDe665/uIaf1Rt0H4ko4US0si2rOyZe5wCGuelWN+o9+goFx4dDerZ+uDJMlrcIEqDgZ2GK44d0V7giznP983RRhY0MVSK2GCdB8aCWX9Li6iQwbRy8uInA2cHyop8GfnCztqafBb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734700; c=relaxed/simple;
	bh=kQhv3CeO5+UCw9SJSn7ZxV5sAw44NEd/krZ6l962Oqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjKbRwOsNXubLGc4cvzNDYiKfhE05XplQn7BXu68RlveeLOWznxtjTKd962V10uk+prkYp05NBozhTkJpHY5acbAhMTMuTgl/6P7uLhaH+hAT/gs+PfQb+1L8lC7+tTW1F7cHVZoG/V+iGnuNvHPZbPcDKfairosDh5KQo95lOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ/CB4r0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ/CB4r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66037C4AF64;
	Tue, 18 Jun 2024 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734699;
	bh=kQhv3CeO5+UCw9SJSn7ZxV5sAw44NEd/krZ6l962Oqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQ/CB4r01A0ClGT+QwDaT7ylpWMw3N+dob/wzVdm7wJD9HDuPo57XRBVku1+5BZZf
	 k3KE4bLPtcIAsUXjZo670ljF89YMHona8451FMZ4mkRU0iCVHxswVKcO2vt6BEX98O
	 /hnQh6TPCFAvWEHUNflOSLMe0hpR4jPahbJJKcHwmBVcWD3Lqa7WgKWlD/LKud4EYT
	 sth87vbfVIsgkevcpxrNdwA7VVIsqeJWdAvvt+bPPmSN0Ap1KHOC9+DI3gJ/2T2LXL
	 ymXCzvt+u91KmVkLalchFgH5miTU3BoCS9AXS1b0NVnnJCMM5fiTHaxV+BMjWJDZuq
	 XbtAtMPFPO3kA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] mm/damon/sysfs: remove unnecessary online tuning handling code
Date: Tue, 18 Jun 2024 11:18:02 -0700
Message-Id: <20240618181809.82078-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon/sysfs.c contains code for handling of online DAMON parameters
update edge cases.  It is no more necessary since damon_commit_ctx()
takes care of the cases.  Remove the unnecessary code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-test.h |  2 +-
 mm/damon/sysfs.c      | 60 ++-----------------------------------------
 2 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/mm/damon/sysfs-test.h b/mm/damon/sysfs-test.h
index 73bdce2452c1..43a15156a7c3 100644
--- a/mm/damon/sysfs-test.h
+++ b/mm/damon/sysfs-test.h
@@ -62,7 +62,7 @@ static void damon_sysfs_test_set_targets(struct kunit *test)
 	sysfs_target->pid = __damon_sysfs_test_get_any_pid(
 			sysfs_target->pid + 1, 200);
 	damon_sysfs_set_targets(ctx, sysfs_targets);
-	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
+	KUNIT_EXPECT_EQ(test, 2u, nr_damon_targets(ctx));
 
 	damon_destroy_ctx(ctx);
 	kfree(sysfs_targets->targets_arr);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 0f9fe18beb40..c729222797b8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1162,72 +1162,16 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 	return err;
 }
 
-static int damon_sysfs_update_target_pid(struct damon_target *target, int pid)
-{
-	struct pid *pid_new;
-
-	pid_new = find_get_pid(pid);
-	if (!pid_new)
-		return -EINVAL;
-
-	if (pid_new == target->pid) {
-		put_pid(pid_new);
-		return 0;
-	}
-
-	put_pid(target->pid);
-	target->pid = pid_new;
-	return 0;
-}
-
-static int damon_sysfs_update_target(struct damon_target *target,
-		struct damon_ctx *ctx,
-		struct damon_sysfs_target *sys_target)
-{
-	int err = 0;
-
-	if (damon_target_has_pid(ctx)) {
-		err = damon_sysfs_update_target_pid(target, sys_target->pid);
-		if (err)
-			return err;
-	}
-
-	/*
-	 * Do monitoring target region boundary update only if one or more
-	 * regions are set by the user.  This is for keeping current monitoring
-	 * target results and range easier, especially for dynamic monitoring
-	 * target regions update ops like 'vaddr'.
-	 */
-	if (sys_target->regions->nr)
-		err = damon_sysfs_set_regions(target, sys_target->regions);
-	return err;
-}
-
 static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 		struct damon_sysfs_targets *sysfs_targets)
 {
-	struct damon_target *t, *next;
-	int i = 0, err;
+	int i, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
 	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
 		return -EINVAL;
 
-	damon_for_each_target_safe(t, next, ctx) {
-		if (i < sysfs_targets->nr) {
-			err = damon_sysfs_update_target(t, ctx,
-					sysfs_targets->targets_arr[i]);
-			if (err)
-				return err;
-		} else {
-			if (damon_target_has_pid(ctx))
-				put_pid(t->pid);
-			damon_destroy_target(t);
-		}
-		i++;
-	}
-
-	for (; i < sysfs_targets->nr; i++) {
+	for (i = 0; i < sysfs_targets->nr; i++) {
 		struct damon_sysfs_target *st = sysfs_targets->targets_arr[i];
 
 		err = damon_sysfs_add_target(st, ctx);
-- 
2.39.2

