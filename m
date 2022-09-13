Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206ED66E9
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1C5C43140;
	Tue, 13 Sep 2022 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091104;
	bh=gmkQIvgsS3o7E0kw20g1nY/rU6PdiC7nZb5s3NkPL2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JylOBtODAgJiw9eaH6HLYcsFje7zpwtzLk/brt56MBMuN1KWnaiYrbiYtAN8ohXAf
	 H4FiJjzVDV9FJfQlLvtBh2KXVkd4dluSslzGUFFR1fVlIo7XxNIoyWkIh1YygmOmXq
	 9uLhAtMYgy3CTVSuP/dQ7AAxkK3KIf7W1kzmceKmDKQqop0PB8YP+PdWdax9AddBO3
	 W/saUg7P7HTcjQSK3Em4AF6VR+lNWj38CPeNLXAkiI/iRt9woF23okgQsmUtvP5po2
	 kXtnKUsX38Zfvj2Ha45qqMl7F7+4E8uDA9rh9EHWgNRXcwKUGTphaGaR6+epC4LcWi
	 XsXwjjqBnjxJw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/22] mm/damon/reclaim: use watermarks parameters generator macro
Date: Tue, 13 Sep 2022 17:44:41 +0000
Message-Id: <20220913174449.50645-15-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes DAMON_RECLAIM to generate the module parameters for
DAMOS watermarks using the generator macro to simplify the code and
reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 56 ++++++++--------------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 48326bef20f5..7f845f617dc5 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -91,45 +91,14 @@ module_param(quota_sz, ulong, 0600);
 static unsigned long quota_reset_interval_ms __read_mostly = 1000;
 module_param(quota_reset_interval_ms, ulong, 0600);
 
-/*
- * The watermarks check time interval in microseconds.
- *
- * Minimal time to wait before checking the watermarks, when DAMON_RECLAIM is
- * enabled but inactive due to its watermarks rule.  5 seconds by default.
- */
-static unsigned long wmarks_interval __read_mostly = 5000000;
-module_param(wmarks_interval, ulong, 0600);
-
-/*
- * Free memory rate (per thousand) for the high watermark.
- *
- * If free memory of the system in bytes per thousand bytes is higher than
- * this, DAMON_RECLAIM becomes inactive, so it does nothing but periodically
- * checks the watermarks.  500 (50%) by default.
- */
-static unsigned long wmarks_high __read_mostly = 500;
-module_param(wmarks_high, ulong, 0600);
-
-/*
- * Free memory rate (per thousand) for the middle watermark.
- *
- * If free memory of the system in bytes per thousand bytes is between this and
- * the low watermark, DAMON_RECLAIM becomes active, so starts the monitoring
- * and the reclaiming.  400 (40%) by default.
- */
-static unsigned long wmarks_mid __read_mostly = 400;
-module_param(wmarks_mid, ulong, 0600);
-
-/*
- * Free memory rate (per thousand) for the low watermark.
- *
- * If free memory of the system in bytes per thousand bytes is lower than this,
- * DAMON_RECLAIM becomes inactive, so it does nothing but periodically checks
- * the watermarks.  In the case, the system falls back to the LRU-based page
- * granularity reclamation logic.  200 (20%) by default.
- */
-static unsigned long wmarks_low __read_mostly = 200;
-module_param(wmarks_low, ulong, 0600);
+struct damos_watermarks damon_reclaim_wmarks = {
+	.metric = DAMOS_WMARK_FREE_MEM_RATE,
+	.interval = 5000000,	/* 5 seconds */
+	.high = 500,		/* 50 percent */
+	.mid = 400,		/* 40 percent */
+	.low = 200,		/* 20 percent */
+};
+DEFINE_DAMON_MODULES_WMARKS_PARAMS(damon_reclaim_wmarks);
 
 static struct damon_attrs damon_reclaim_mon_attrs = {
 	.sample_interval = 5000,	/* 5 ms */
@@ -214,13 +183,6 @@ static struct damos *damon_reclaim_new_scheme(void)
 			damon_reclaim_mon_attrs.aggr_interval,
 		.max_age_region = UINT_MAX,
 	};
-	struct damos_watermarks wmarks = {
-		.metric = DAMOS_WMARK_FREE_MEM_RATE,
-		.interval = wmarks_interval,
-		.high = wmarks_high,
-		.mid = wmarks_mid,
-		.low = wmarks_low,
-	};
 	struct damos_quota quota = {
 		/*
 		 * Do not try reclamation for more than quota_ms milliseconds
@@ -242,7 +204,7 @@ static struct damos *damon_reclaim_new_scheme(void)
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
-			&wmarks);
+			&damon_reclaim_wmarks);
 }
 
 static int damon_reclaim_apply_parameters(void)
-- 
2.25.1

