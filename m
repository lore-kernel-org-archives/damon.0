Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E547FB00;
	Mon, 31 Aug 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186386; cv=none; b=qw3JI7SdbFhg26YUUnBnP1uadWUxmdmhfFdNST/jUarCoLxquMTAjzDx0k8sImd8n+sDZzmxnF0eSfdMDQPq3Wdb+Bq7dNmXzHBhPeDhQvztLxIsXNCurNg/0TU8w1WKuUeGzhw5kL7q8MwzNdVyB9goxLMFpL+yPuZtfT2WmAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186386; c=relaxed/simple;
	bh=Wz8lAfnxNB0fjX33N+sTEhww9kVKTOuYQ90cifUw4mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuYk5byvPHHQXP+dSTPfQpyRoBVmec92UQJPtoABPrWtmcV3z2CjRLQ/u14cw40wrjc7poUZuchDf3E4Wesen0vY0wuLq1aX54R2VKnyowT9xwK59TgVVZx/PtgT8mv3sdIGCkPg3ZNUGSqI/rHqZ13soW2grLlGTzyjOv9OCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXISkcR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXISkcR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C211F00ACA;
	Mon, 31 Aug 2026 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186384;
	bh=LxE82nkNHWov4YHh70ccGFi1HMEiweXojbw3QLwGVKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXISkcR21FUdW6a/GHUr4gjTlrQNC5SepoKIMDlA8PCrso0C3aUK0Y4Vc4twXVww6
	 mKIgxHAcMOhLn9V/ud5FTRgPbej+8aPVnwIx8jQyxbkNQXZHuQ636PFQkO4e9kNAKX
	 pAqtEDmhrRUmzod6BmtXnzcsPiGPeriWGM1P8TpqarpDXWk/r30UV/CC38i2iizggF
	 ot6ihp+foSRcxRccDiLAdTqp08QI7uWSKVOMYKuRY+JO9lpcTKuqK2ew6cBfFs9w/8
	 zUjl+p8JBTiX4iVOheHvGFfeYSgoCNa3JjmS188DObHYGqtAW7qwt+vtsqEcM2lNwM
	 S6UVL+CZp9Crg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH 2/7] mm/damon/core: introduce damon_set_target_pid()
Date: Mon, 31 Aug 2026 07:26:04 -0700
Message-ID: <20260831142611.77572-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic that finds the struct pid for a given pid number and assigns
it to a damon_target is duplicated in multiple places.  Including
damon_sysfs_add_target() of mm/damon/sysfs.c and the start functions
of the two sample modules, samples/damon/wsse.c and
samples/damon/prcl.c.  Add a function that does the work, and replace
the duplicated code in the places with calls to the function.

Signed-off-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260817125319.888994-1-lienze@kylinos.cn
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 12 ++++++++++++
 mm/damon/sysfs.c      |  6 ++----
 samples/damon/prcl.c  |  5 +----
 samples/damon/wsse.c  |  5 +----
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0c8b7ddef9abb..5607f98ec6306 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1055,6 +1055,7 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
 struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
 bool damon_targets_empty(struct damon_ctx *ctx);
+int damon_set_target_pid(struct damon_target *t, int pid);
 void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
 unsigned int damon_nr_regions(struct damon_target *t);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 79515ef03fc2a..a5ea3e61e7f41 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/mm.h>
+#include <linux/pid.h>
 #include <linux/psi.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -802,6 +803,17 @@ bool damon_targets_empty(struct damon_ctx *ctx)
 	return list_empty(&ctx->adaptive_targets);
 }
 
+/*
+ * Assign the struct pid of the given pid number to the given target.
+ */
+int damon_set_target_pid(struct damon_target *t, int pid)
+{
+	t->pid = find_get_pid(pid);
+	if (!t->pid)
+		return -EINVAL;
+	return 0;
+}
+
 static void damon_del_target(struct damon_target *t)
 {
 	list_del(&t->list);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f05b256c90ee7..dcb739ce0a729 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -3,7 +3,6 @@
  * DAMON sysfs Interface
  */
 
-#include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -2036,9 +2035,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 		return -ENOMEM;
 	damon_add_target(ctx, t);
 	if (damon_target_has_pid(ctx)) {
-		t->pid = find_get_pid(sys_target->pid);
-		if (!t->pid)
-			/* caller will destroy targets */
+		/* caller will destroy targets */
+		if (damon_set_target_pid(t, sys_target->pid))
 			return -EINVAL;
 	}
 	t->obsolete = sys_target->obsolete;
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 842099bd62286..83ddf12811d57 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -32,7 +32,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_PRCL");
 
 static struct damon_ctx *ctx;
-static struct pid *target_pidp;
 
 static int damon_sample_prcl_repeat_call_fn(void *data)
 {
@@ -79,12 +78,10 @@ static int damon_sample_prcl_start(void)
 		return -ENOMEM;
 	}
 	damon_add_target(ctx, target);
-	target_pidp = find_get_pid(target_pid);
-	if (!target_pidp) {
+	if (damon_set_target_pid(target, target_pid)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
-	target->pid = target_pidp;
 
 	scheme = damon_new_scheme(
 			&(struct damos_access_pattern) {
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 37fd5da201588..53944aea8428e 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -33,7 +33,6 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled, "Enable or disable DAMON_SAMPLE_WSSE");
 
 static struct damon_ctx *ctx;
-static struct pid *target_pidp;
 
 static int damon_sample_wsse_repeat_call_fn(void *data)
 {
@@ -79,12 +78,10 @@ static int damon_sample_wsse_start(void)
 		return -ENOMEM;
 	}
 	damon_add_target(ctx, target);
-	target_pidp = find_get_pid(target_pid);
-	if (!target_pidp) {
+	if (damon_set_target_pid(target, target_pid)) {
 		damon_destroy_ctx(ctx);
 		return -EINVAL;
 	}
-	target->pid = target_pidp;
 
 	err = damon_start(&ctx, 1, true);
 	if (err) {
-- 
2.47.3
