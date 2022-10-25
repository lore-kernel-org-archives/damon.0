Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB17491
	for <damon@lists.linux.dev>; Tue, 25 Oct 2022 17:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59972C433D7;
	Tue, 25 Oct 2022 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666719415;
	bh=TdXFXcgq2EM24y0mmvXtXkdjHMEmMaCZawqMFxCOKU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKpdkSIrpvAqCeR5vix1iWp5kJrdJW19Utrml/Ra41U7LQX2zLCZqhdbJQieGIepi
	 HFNsWZm4WYDd3CYCDDOoe0suLK4DFct0N9bLT4XHzDy8tJnastMR7kQxduDavDmJ0Z
	 iX7W9T4FUObqrP/8Ah67Uo0elgleXvQzhWQjv1y7rKwhSgK3cTmAsUck/bWI4M1L2G
	 mrOSA8PWFFXUkJaPZ+y2a1WyTpJ1cAW5hXFoQ0/AMtHdNYuNax116Muy19KAgRftt5
	 0dCmyY8FBeMHh95i2iQdvHFC5TAo94VHGcO7aFZOJk9F29zCuEti4Xke78jyL30PxH
	 oNQeEqFD0KNZw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/4] mm/damon/reclaim: enable and disable synchronously
Date: Tue, 25 Oct 2022 17:36:47 +0000
Message-Id: <20221025173650.90624-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025173650.90624-1-sj@kernel.org>
References: <20221025173650.90624-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing a value to DAMON_RECLAIM's 'enabled' parameter turns on or off
DAMON in an ansychronous way.  This means the parameter cannot be used
to read the current status of DAMON_RECLAIM.  'kdamond_pid' parameter
should be used instead for the purpose.  The documentation is easy to be
read as it works in a synchronous way, so it is a little bit confusing.
It also makes the user space tooling dirty.

There's no real reason to have the asynchronous behavior, though.
Simply make the parameter works synchronously, rather than updating the
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 53 ++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index e14eb30c01f4..e57604bec06d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -9,7 +9,6 @@
 
 #include <linux/damon.h>
 #include <linux/module.h>
-#include <linux/workqueue.h>
 
 #include "modules-common.h"
 
@@ -181,38 +180,31 @@ static int damon_reclaim_turn(bool on)
 	return 0;
 }
 
-static struct delayed_work damon_reclaim_timer;
-static void damon_reclaim_timer_fn(struct work_struct *work)
-{
-	static bool last_enabled;
-	bool now_enabled;
-
-	now_enabled = enabled;
-	if (last_enabled != now_enabled) {
-		if (!damon_reclaim_turn(now_enabled))
-			last_enabled = now_enabled;
-		else
-			enabled = last_enabled;
-	}
-}
-static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
-
-static bool damon_reclaim_initialized;
-
 static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	int rc = param_set_bool(val, kp);
+	bool is_enabled = enabled;
+	bool enable;
+	int err;
 
-	if (rc < 0)
-		return rc;
+	err = strtobool(val, &enable);
+	if (err)
+		return err;
 
-	/* system_wq might not initialized yet */
-	if (!damon_reclaim_initialized)
-		return rc;
+	if (is_enabled == enable)
+		return 0;
 
-	schedule_delayed_work(&damon_reclaim_timer, 0);
-	return 0;
+	/* Called before init function.  The function will handle this. */
+	if (!ctx)
+		goto set_param_out;
+
+	err = damon_reclaim_turn(enable);
+	if (err)
+		return err;
+
+set_param_out:
+	enabled = enable;
+	return err;
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
@@ -262,10 +254,11 @@ static int __init damon_reclaim_init(void)
 	ctx->callback.after_wmarks_check = damon_reclaim_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
-	schedule_delayed_work(&damon_reclaim_timer, 0);
+	/* 'enabled' has set before this function, probably via command line */
+	if (enabled)
+		err = damon_reclaim_turn(true);
 
-	damon_reclaim_initialized = true;
-	return 0;
+	return err;
 }
 
 module_init(damon_reclaim_init);
-- 
2.25.1

