Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D891DE2DF;
	Fri, 28 Feb 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780213; cv=none; b=CyKE7jnvagJrEE1pmD2u1IyIkZnxehHkXSped+t3pZPuQDNomKUWiX/IlqJWaPsELna2zrQ0nCKgsts3VilKMHkBmhkbszUP65W3rBQ++vGz4zNPmpCbypYEt3tXMaLmxHxC9oJykU2Es7eTxzilH+lql+uR2yghI2Rkf4dDwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780213; c=relaxed/simple;
	bh=WFfBywqImxG6v/56XXskkWPj4/LAxcRbv+8nhLsSUtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mg3hdgurwceyviKnk08PSUDv4XJ5ny02srXBiTlU2kKVl3DAoNt35f57XCTEPuTzsOqxDgI1G3DdcoC0WK34QY3trm7nekjsTJ4Zo6Q6/urvsCkGUzYchtLeI4CFyG43/rk/B4N6ch3W5QQ6dJ+kG6PM8KF+E7KcT0jqePXmQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qolasen7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qolasen7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DD2C4CEE2;
	Fri, 28 Feb 2025 22:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780212;
	bh=WFfBywqImxG6v/56XXskkWPj4/LAxcRbv+8nhLsSUtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qolasen77R4AKPul7302i/J/jc8m4WE1xtdK4RjnK3EFxeh9+4t71+pj9Z2eSeEdT
	 woOrrZeEfGUNT2vNx7Gb4lkglQ8b4ISsvdsp/GEW/mG6ru7MgqV4z8JcaKmY2ElFgl
	 6MwBJQ6yxN+kyFlfctzeiQk0632wQ+iiBriNfSTVX/vy3042/Zg5KS/5v7hGCGS+1r
	 uTRbplH9kcsuqWh5CC2AxegMw8s2Bs3ZrrfnVrWGyDIk1JnP7tVOMoFBP7/FmsNlNF
	 l+4A8q1lKR6HjvEaxmwVujZkk/bHiReBrHC5gUsX37bU6D1LztW1c4Go5Ro/05v2HW
	 RdIpeOQy5BPwQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/8] mm/damon: add data structure for monitoring intervals auto-tuning
Date: Fri, 28 Feb 2025 14:03:21 -0800
Message-Id: <20250228220328.49438-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
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
index 8264e9f1db7e..130c3e01089c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -664,12 +664,38 @@ struct damon_call_control {
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
@@ -689,6 +715,7 @@ struct damon_attrs {
 	unsigned long sample_interval;
 	unsigned long aggr_interval;
 	unsigned long ops_update_interval;
+	struct damon_intervals_goal intervals_goal;
 	unsigned long min_nr_regions;
 	unsigned long max_nr_regions;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4bf8fb4e7ab2..b11595c01c37 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -638,6 +638,25 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
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
@@ -658,6 +677,9 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
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
