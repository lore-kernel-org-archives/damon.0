Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FE2DA763;
	Mon,  8 Sep 2025 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362525; cv=none; b=uDFMluWv9jA5iB1bixYgq/FLIV3rCNfBRQ4lSosSKi7z/I90NgA4TRFFUslmwUBxAq8vPm5qhtAcO9lvmHzfqm5vP+UtTWM+auHhLK/IJ7+qNBzRL76HV1pKGWiChHti9sYu7kc3t3+J18niRWgepXY7lyKW5jSEHbjDYXiVd74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362525; c=relaxed/simple;
	bh=6l7sUsMc9BUwJH1VJJlKFxxbsFLqRRCzdv+tU76g6rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNNhZQp3G0IGyo4ZEHYTWfeWPfsoLOxUSxDaiqtMWarcNJb6vWG+xYzQrp4wZ2a9HHuzmxtLRMCuwS9lIGlD0KhRokkpdoWeS+NuM+YP4q9aAeQ12wEWPmVH391D6uzrFEZstWkRpPjq8kSc7QQgyjNOLOMkPORh1wcw2iLc5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrBc+wGj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrBc+wGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFA6C4CEF7;
	Mon,  8 Sep 2025 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362524;
	bh=6l7sUsMc9BUwJH1VJJlKFxxbsFLqRRCzdv+tU76g6rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SrBc+wGjdeb3bfhohHg3bEloUhKBNKdHkU9+qFMzkgmwvhaq+OsXq0d/U339DHNoG
	 OELZJYEE674XxT7iaSSL/PdFMr1+uVh3e00VRLGIxqHYfnDkGTgBSVirfszRotWCY8
	 qQX2Ulef6K5E+/MZ4SjGFIw4t2LQNujS3Jxn89vMdZBnJhG5AdbRXoOvAF1dbx5xb+
	 zrSfhxb2UMX2s3MrYElBcVWqMcUy3+Dw3Ds8u8Pb9INtcaz2NOFS8NLjP2ovFIzkDs
	 8HjB6zaPQIq/JD/8Ll98eQYh0svSqH0eHOUCO+2kcJ89qJHc0RY9CFsDhJcRwn6wH4
	 2G4lWdGdaiCzA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damon/sysfs: use dynamically allocated repeat mode damon_call_control
Date: Mon,  8 Sep 2025 13:15:13 -0700
Message-Id: <20250908201513.60802-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908201513.60802-1-sj@kernel.org>
References: <20250908201513.60802-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is using a single global repeat mode
damon_call_control variable for refresh_ms handling, for all DAMON
contexts.  As a result, when there are more than one context, the single
global damon_call_control is unexpectedly over-written (corrupted).
Particularly the ->link field is overwritten by the multiple contexts
and this can cause a user hangup, and/or a kernel crash.  Fix it by
using dynamically allocated damon_call_control object per DAMON context.

Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work") # v6.17-rc1
Reported-by: Yunjeong Mun <yunjeong.mun@sk.com>
Closes: https://lore.kernel.org/20250904011738.930-1-yunjeong.mun@sk.com
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6625fb718195..fe4e73d0ebbb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1569,14 +1569,10 @@ static int damon_sysfs_repeat_call_fn(void *data)
 	return 0;
 }
 
-static struct damon_call_control damon_sysfs_repeat_call_control = {
-	.fn = damon_sysfs_repeat_call_fn,
-	.repeat = true,
-};
-
 static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_ctx *ctx;
+	struct damon_call_control *repeat_call_control;
 	int err;
 
 	if (damon_sysfs_kdamond_running(kdamond))
@@ -1589,18 +1585,29 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 		damon_destroy_ctx(kdamond->damon_ctx);
 	kdamond->damon_ctx = NULL;
 
+	repeat_call_control = kmalloc(sizeof(*repeat_call_control),
+			GFP_KERNEL);
+	if (!repeat_call_control)
+		return -ENOMEM;
+
 	ctx = damon_sysfs_build_ctx(kdamond->contexts->contexts_arr[0]);
-	if (IS_ERR(ctx))
+	if (IS_ERR(ctx)) {
+		kfree(repeat_call_control);
 		return PTR_ERR(ctx);
+	}
 	err = damon_start(&ctx, 1, false);
 	if (err) {
+		kfree(repeat_call_control);
 		damon_destroy_ctx(ctx);
 		return err;
 	}
 	kdamond->damon_ctx = ctx;
 
-	damon_sysfs_repeat_call_control.data = kdamond;
-	damon_call(ctx, &damon_sysfs_repeat_call_control);
+	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
+	repeat_call_control->data = kdamond;
+	repeat_call_control->repeat = true;
+	repeat_call_control->dealloc_on_cancel = true;
+	damon_call(ctx, repeat_call_control);
 	return err;
 }
 
-- 
2.39.5
