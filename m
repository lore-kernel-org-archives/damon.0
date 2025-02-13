Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3414831C;
	Thu, 13 Feb 2025 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411094; cv=none; b=J4e8vThXFzR9HkGra4XVo7laMRSV34Ayqv1V/SjbYUOvoAWlx2zIgBtNnvxJY4Sv5W6+d26s/0ofojzaEUhviqAa3/gooA4dxT8rFsp8McQaStaYEKQz/lAyxjJJaiFh9ACHKcJidy9kPQaMpvU+TgMo3aVDW9xA2VE0N/BPWb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411094; c=relaxed/simple;
	bh=arXNwNIDEYcgGA/brmhPPjep2BFLaCq5xAx61jsI2xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8ZKlCMHZiiI2sz8NVGJMYD64gb9gBpIbjMwSMDi8wexZOlllEqbH/L+REWIKDj04UXGmBL1vkb6cMIdk5j/oTfYbbfiIe2K++qWdAgPImzrdNA/lojXvFQQ9Ij+FZL3ZZRUNIEuiwfU+kWBRpVOz9VZfTm/DMO7WavwiQfuOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuYKw5jJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuYKw5jJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADF7C4CEDF;
	Thu, 13 Feb 2025 01:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411093;
	bh=arXNwNIDEYcgGA/brmhPPjep2BFLaCq5xAx61jsI2xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuYKw5jJlR25muh8wVK2pry1wN4l/DWJ0jtawj7gFkgmiL+9dbg3kS4tD/lHB1rel
	 7kq7C6/8kMhiA2OW/vK+4lROGpGPBv4kJ0lVnV1bt/CASC7pqe3V8yjG6FevH9lbRX
	 K+pluuuu9jAhKIXzxdrOb2t5vgUO6BEwOm05c3TTyg7Q7wezO9eK3utE/YJTuLNsKh
	 +LPYAzkfy6FJXvkr5JiTQIJDC3hD+9YHzWFkPAucTJjcZ+LJWCcdyQHqsysw1q4p2c
	 bkZ2DbeNjpxcWj1zbsJmWshpOLEqeXX8e8hnxZOFw81uFpbrpy8DweK1URE57qInHV
	 ou8me2kx3aAwg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/8] mm/damon: add data structure for monitoring intervals auto-tuning
Date: Wed, 12 Feb 2025 17:44:31 -0800
Message-Id: <20250213014438.145611-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add data structures for using DAMON sampling and aggregation intervals
automatic tuning aiming specific amount of access events per snapshot.
Specificaslly, define a data structure to define the tuning goal, namely
target ratio of positive access check samples, link it to monitoring
attributes data structure so that DAMON kernel API users can make the
request, and update parameters setup DAMON function to respect the new
data.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 27 +++++++++++++++++++++++++++
 mm/damon/core.c       | 22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0adfc2f4ca75..4368ba1a942f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -651,12 +651,38 @@ struct damon_call_control {
 	bool canceled;
 };
 
+/**
+ * struct damon_intervals_goal - Monitoring intervals auto-tuning goal.
+ *
+ * @samples_bp:		Positive access check samples ratio to achieve.
+ * @aggrs:		Number of aggregations to acheive @samples_bp within.
+ * @min_sample_us:	Minimum resulting sampling interval in microseconds.
+ * @max_sample_us:	Maximum resulting sampling interval in microseconds.
+ *
+ * DAMON automatically tunes &damon_attrs->sample_interval and
+ * &damon_attrs->aggr_interval aiming the ratio in bp (1/10,000) of access
+ * check samples that shown positive result (was accessed) to total samples
+ * within @aggrs aggregations be same to @samples_bp.  The logic increases
+ * &damon_attrs->aggr_interval and &damon_attrs->sampling_interval in same
+ * ratio if the current positive access samples ratio is lower than the target
+ * for each @aggrs aggregations, and vice versa.
+ *
+ * If @aggrs is zero, the tuning is disabled and hence this struct is ignored.
+ */
+struct damon_intervals_goal {
+	unsigned long samples_bp;
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
@@ -676,6 +702,7 @@ struct damon_attrs {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
 	unsigned long ops_update_interval;
+	struct damon_intervals_goal intervals_goal;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 38f545fea585..2fad800271a4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -614,6 +614,25 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
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
@@ -634,6 +653,9 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
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
