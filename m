Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445A271261;
	Wed, 26 Feb 2025 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551827; cv=none; b=FbpeW9nNGoTRe1w7N5N+TbFLiiAQtKrt4gUo4mocEnF12foMVkSGg3vyQPRSh2dd2lgAynDH/75+l6beRV9x40skpGKws760I1q5rz2oR7zSwGJiFFAWNeu/Yh4dn2nKtOG7ea43pTAasdYmbygPFU52iHNFwqtY2RhdpI1fWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551827; c=relaxed/simple;
	bh=PfFmM0ne7oeiliHHlhMvk+NOJkvWZ9fZ49v2P+Pn3V8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qX8Sd/YpkRN3WF1x46DOuMTd42PpM6osPLG2P5VmHy197/13SmET8qWv4384u1gtPTIJIy3ycbv1AKU5c6WEPU8Mm+wlSZ5Q6rxvhf/vZMm4kOZeq0zcgdEJQ0tSDlMsL3anWhgD74GH3/xMv6qfcw4/QDlhRzqygAhzUcyyM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+hMAQS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+hMAQS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1517EC4CEE2;
	Wed, 26 Feb 2025 06:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551827;
	bh=PfFmM0ne7oeiliHHlhMvk+NOJkvWZ9fZ49v2P+Pn3V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+hMAQS9IZUUNzjcxBCFzvAu6e86w60J/OsSVl7SoXFMus4d9TQBOdA38tv76FXlk
	 kw4INrISe/ou+9pU8qcv+As2O2REveghPG5mSAeSfhWK/XEBcT0GOfP41fI9bvGI//
	 0vleAx8Tzorcq/SKPmmTDV73koXV1J64xp9SscUbgZnF3SEeE8DyIPfrbe58dVmfHK
	 tPq7bxuvwuPcFGbCp0Vx7nzHO2i/PLFG3jekRQBzPT/2ZyATYY/uwYiBhO8cULjONS
	 vnM+w+IIDAQADnGOeVdKin+e3vO+nf8/h4sWAsmLsJblwz9RC+x0Gv3wpX8dIGQNaL
	 rMtg4tSW/IJEQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/13] mm/damon: remove damon_callback->after_sampling
Date: Tue, 25 Feb 2025 22:36:49 -0800
Message-Id: <20250226063651.513178-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callback was used by DAMON sysfs interface for reading DAMON
internal data.  But it is no more being used, and damon_call() can do
similar works in a better way.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 ++++-------
 mm/damon/core.c       |  3 ---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 11cd916b41fb..c9abacf16d88 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -599,7 +599,6 @@ struct damon_operations {
  * struct damon_callback - Monitoring events notification callbacks.
  *
  * @after_wmarks_check:	Called after each schemes' watermarks check.
- * @after_sampling:	Called after each sampling.
  * @after_aggregation:	Called after each aggregation.
  * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
@@ -612,17 +611,15 @@ struct damon_operations {
  * attributes of the monitoring context while it's deactivated due to the
  * watermarks, this is the good place to do.
  *
- * The monitoring thread calls @after_sampling and @after_aggregation for each
- * of the sampling intervals and aggregation intervals, respectively.
- * Therefore, users can safely access the monitoring results without additional
- * protection.  For the reason, users are recommended to use these callback for
- * the accesses to the results.
+ * The monitoring thread calls @after_aggregation for each of the aggregation
+ * intervals.  Therefore, users can safely access the monitoring results
+ * without additional protection.  For the reason, users are recommended to use
+ * these callback for the accesses to the results.
  *
  * If any callback returns non-zero, monitoring stops.
  */
 struct damon_callback {
 	int (*after_wmarks_check)(struct damon_ctx *context);
-	int (*after_sampling)(struct damon_ctx *context);
 	int (*after_aggregation)(struct damon_ctx *context);
 	int (*before_damos_apply)(struct damon_ctx *context,
 			struct damon_target *target,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8efb249be855..14e4122464a1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2423,9 +2423,6 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
-		if (ctx->callback.after_sampling &&
-				ctx->callback.after_sampling(ctx))
-			break;
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
-- 
2.39.5
