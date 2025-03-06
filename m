Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A387927426C;
	Thu,  6 Mar 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283965; cv=none; b=jPChwwLpbBmaNeyF/W1XfPNNW13dRroKnIhZ/SLYtN4kpmvn3Ij/p2S5dwudQSgl9E2hCIDr029zPfyqkiUpcX1N4XKEBPf+b6zzd2OL34sL1E91m+S88IL3vDIyrm/C75nHaqelyq1coCEIgdHs9Z3hn1W4+d5/vl6fZzipDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283965; c=relaxed/simple;
	bh=I/JHvzw57UoJPSQTgW4gksymyJzz98SL8NUvb1KKOF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHDjZGkfK2+GdJ/Zip86Sk5nXB/oHPyt3L3SD5scxGLoJ3r/l2JCKDIfiDANM0ooht76J39OrvWbZR2QtWoAmvMaqY88UF8QT4Bg882J/lb7cqMtSFx5OKoNf5l9R0JjMgZ3BK7N2LDFD4ZkJJ1i6rRBrsYNmudeDFSY6qLmBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t43p2Qrd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t43p2Qrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B46C4CEE9;
	Thu,  6 Mar 2025 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283965;
	bh=I/JHvzw57UoJPSQTgW4gksymyJzz98SL8NUvb1KKOF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t43p2Qrd5Bb7hd33jVdLTrPc3yYngQWh01UWIUXiyNaUQsIeXBmLhrndvro9mNHv2
	 zfYl/VNQsqQJu0YBC9jinTCv46wgeHwLPdii9KyhU2jcPmfRG6y2LcrX2uvE4TEbA5
	 /oN5lHeLwafXy7EMGqRii5igXdClJvOyse25zjqBjKief9JXj9/AszDV4bcSHwSs34
	 RYnmA0VahnP38wsXOymiSLn9KTZvrou8KkPEIqHOIi3gfAQJQBMyX9cod5fMyeIedR
	 vdLmClx/gxJoJLGVb0B2OpPlU2i88kWJzEG5BgOglyKaE8EmtibgkEq+DG67WP2bAW
	 rMfnSYuiw1a3w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/13] mm/damon: remove damon_callback->after_sampling
Date: Thu,  6 Mar 2025 09:59:06 -0800
Message-Id: <20250306175908.66300-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
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
index 043de2408c65..5aa277f4c948 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -604,7 +604,6 @@ struct damon_operations {
  * struct damon_callback - Monitoring events notification callbacks.
  *
  * @after_wmarks_check:	Called after each schemes' watermarks check.
- * @after_sampling:	Called after each sampling.
  * @after_aggregation:	Called after each aggregation.
  * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
@@ -617,17 +616,15 @@ struct damon_operations {
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
index 8904b3c079e6..726e581904e5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2431,9 +2431,6 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
-		if (ctx->callback.after_sampling &&
-				ctx->callback.after_sampling(ctx))
-			break;
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
-- 
2.39.5
