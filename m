Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387C22C325;
	Mon,  3 Mar 2025 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040253; cv=none; b=s/BbyPyCquEEfjOu5dEE4lKVBvmQyJWbCGiPUXVZ5mrhBvVfNVQ39RQk/W9yHENRAK0UK4jvUgGB87reiMgVQ9utanuAE6QHDdCIjiLwWR6JWquObhqsg8KL8DVVDAKKVL59BxbmWYs+ZyPx6XYCti3921OIkLUtRF1ndZG1Kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040253; c=relaxed/simple;
	bh=iSBVb6PukRtPBydpg/2aD8QyTDEBPd4vfWzy9ndeL3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTKMI78Ts+uLrNgM89sWmImBKCqemn0IGII+956Im3km2pVGF4S79trcwQzugfBZbE5ZuIXJz56YaM55fi/uWgjFFxcqFrIAy1pUOFYr4rgiXaihrDBqUkpHpipzNKJKCBJTCges0DUuN3XsW1GIIbhrWd1c6aBF5LsPBV6q7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orStVIpc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orStVIpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34F0C4CED6;
	Mon,  3 Mar 2025 22:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040253;
	bh=iSBVb6PukRtPBydpg/2aD8QyTDEBPd4vfWzy9ndeL3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=orStVIpcjoJT1F6q/41W0z31q4TLWCnp1EuAFrsPs+gh9TtHFH/XXTbQx2bhxl8ql
	 4tcYU6baJ/m1Eh/86PgFc44ZT6xqCDUqcKWp73qgpz1lW47mOqJ1ssHY7MzjgSP5hl
	 cKEmNtyT5XCs8Ex54DEOpsE4J/KuAwfqlXfzldCEYOGyxcoRX138EpkuXOnrdkWhqh
	 MLVE6+9Sx1jWwBaF8zhMiVxjSszYhKBawGweYEHRvTPy+pRhlsa678qLsyr0bduuQE
	 e1ZBmlvS+Zw+NpnMPuQEheCovxLF129gH1ra6fGo5Jum7LER4LhNFfw5C/oq1CED8q
	 YLt5O+Ce5GMLw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon: add data structure for monitoring intervals auto-tuning
Date: Mon,  3 Mar 2025 14:17:19 -0800
Message-Id: <20250303221726.484227-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add data structures for DAMON sampling and aggregation intervals
automatic tuning that aims specific amount of DAMON-observed access
events per snapshot.  In more detail, define the data structure for the
tuning goal, link it to the monitoring attributes data structure so that
DAMON kernel API callers can make the request, and update parameters
setup DAMON function to respect the new parameter.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 27 +++++++++++++++++++++++++++
 mm/damon/core.c       | 22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 242910b190c9..5f2609f24761 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -659,12 +659,38 @@ struct damon_call_control {
 	bool canceled;
 };
 
+/**
+ * struct damon_intervals_goal - Monitoring intervals auto-tuning goal.
+ *
+ * @access_bp:		Access events observation ratio to achieve in bp.
+ * @aggrs:		Number of aggregations to acheive @access_bp within.
+ * @min_sample_us:	Minimum resulting sampling interval in microseconds.
+ * @max_sample_us:	Maximum resulting sampling interval in microseconds.
+ *
+ * DAMON automatically tunes &damon_attrs->sample_interval and
+ * &damon_attrs->aggr_interval aiming the ratio in bp (1/10,000) of
+ * DAMON-observed access events to theoretical maximum amount within @aggrs
+ * aggregations be same to @access_bp.  The logic increases
+ * &damon_attrs->aggr_interval and &damon_attrs->sampling_interval in same
+ * ratio if the current access events observation ratio is lower than the
+ * target for each @aggrs aggregations, and vice versa.
+ *
+ * If @aggrs is zero, the tuning is disabled and hence this struct is ignored.
+ */
+struct damon_intervals_goal {
+	unsigned long access_bp;
+	unsigned long aggrs;
+	unsigned long min_sample_us;
+	unsigned long max_sample_us;
+};
+
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
  * @sample_interval:		The time between access samplings.
  * @aggr_interval:		The time between monitor results aggregations.
  * @ops_update_interval:	The time between monitoring operations updates.
+ * @intervals_goal:		Intervals auto-tuning goal.
  * @min_nr_regions:		The minimum number of adaptive monitoring
  *				regions.
  * @max_nr_regions:		The maximum number of adaptive monitoring
@@ -684,6 +710,7 @@ struct damon_attrs {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
 	unsigned long ops_update_interval;
+	struct damon_intervals_goal intervals_goal;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b1ce072b56f2..ad3b5c065cb8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -615,6 +615,25 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
 					r, old_attrs, new_attrs);
 }
 
+/*
+ * damon_valid_intervals_goal() - return if the intervals goal of @attrs is
+ * valid.
+ */
+static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
+{
+	struct damon_intervals_goal *goal = &attrs->intervals_goal;
+
+	/* tuning is disabled */
+	if (!goal->aggrs)
+		return true;
+	if (goal->min_sample_us > goal->max_sample_us)
+		return false;
+	if (attrs->sample_interval < goal->min_sample_us ||
+			goal->max_sample_us < attrs->sample_interval)
+		return false;
+	return true;
+}
+
 /**
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
@@ -635,6 +654,9 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		attrs->sample_interval : 1;
 	struct damos *s;
 
+	if (!damon_valid_intervals_goal(attrs))
+		return -EINVAL;
+
 	if (attrs->min_nr_regions < 3)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
-- 
2.39.5
