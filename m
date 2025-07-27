Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CE2356C0;
	Sun, 27 Jul 2025 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647502; cv=none; b=VfXD3FEKPkElhjjgW99yG8eE2M6/glh+lSZsFDeVR+NBRrukzhQelc/f6dhS0nnAUWkkiEfnmltHfhcGbX7AZzLmnfClYaKMn6AuxXZjyTsDAz8CrtzRmycXbtpTTwNLVE3CENhtklncbDy1N8IXGewiUuYBxNgpXsmhBulc97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647502; c=relaxed/simple;
	bh=3yxuU0XQzbUfmqOxngAFD/wzk8Fov7BuHvufkENc1Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKnibw7G+w4gW7Oge+GROE/j1n6rP6yL7P76PKOepyQy6nsdVyMryMKbBtZ0PooLZUwvsy9ZCsEQTQOjr9/mL99VNg6muNsxcR9We2JjVujbAAaY/zzqDPSX+DGPBG3mUVphQ/I8xXeGfUW0BzJ/RhBQeYMD6LuR33lWRe6VU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb43SF+4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb43SF+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0BDC4CEF7;
	Sun, 27 Jul 2025 20:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647502;
	bh=3yxuU0XQzbUfmqOxngAFD/wzk8Fov7BuHvufkENc1Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bb43SF+4/x6PxpUFYRnY7Va/Dus59O6I/kDuN5DbBrKHFG6Dpo4/TOdUmPY4GEtMd
	 tWGacLr/fxtnXvK8Lyry7QnrR7qp6bYDT+gGfa1Qgl2rTrAkTNwTcTFyI+p34hjpSR
	 GJUeVDZ2U/JN2ED6Qgi9JUg1KJgCrKxFz2p7TtJtmR18eN8KTs6nCTk3OeusD6cJ9X
	 QdoY3JqwGct1q99PIlZtLVIMX7L0lhVZqwAxnaFhwdqGwX8zLGr1yQh7oLDB+p3KRj
	 uf4bODK9O0BUK1L6t0tshazTj6xjuHCyCbjhOgl+b/jKipBip4Es2B5YQLN8cVS8vL
	 oPFcUvAYYaIJA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 4/7] mm/damon/core: read received access reports
Date: Sun, 27 Jul 2025 13:18:10 -0700
Message-Id: <20250727201813.53858-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported access information is only saved in the core layer's internal
data structure.  Those are not really being used for final monitoring
results.  Update core layer access information (DAMON regions) using the
reported access information.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f3e5c585b5f1..8ec49beac573 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -83,6 +83,7 @@ struct damon_region {
 	unsigned int age;
 /* private: Internal value for age calculation. */
 	unsigned int last_nr_accesses;
+	bool access_reported;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4e25fe100b56..428ac1b83118 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -141,6 +141,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 
 	region->age = 0;
 	region->last_nr_accesses = 0;
+	region->access_reported = false;
 
 	return region;
 }
@@ -2560,6 +2561,69 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	}
 }
 
+static void kdamond_apply_access_report(struct damon_access_report *report,
+		struct damon_target *t, struct damon_ctx *ctx)
+{
+	struct damon_region *r;
+
+	if (ctx->ops.eligible_report && !ctx->ops.eligible_report(report, t))
+		return;
+
+	/* todo: make search faster, e.g., binary search? */
+	damon_for_each_region(r, t) {
+		if (report->addr < r->ar.start)
+			continue;
+		if (r->ar.end < report->addr + report->size)
+			continue;
+		if (!r->access_reported)
+			damon_update_region_access_rate(r, true, &ctx->attrs);
+		r->access_reported = true;
+	}
+}
+
+static unsigned int kdamond_apply_zero_access_report(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			if (r->access_reported)
+				r->access_reported = false;
+			else
+				damon_update_region_access_rate(r, false,
+						&ctx->attrs);
+			max_nr_accesses = max(max_nr_accesses, r->nr_accesses);
+		}
+	}
+	return max_nr_accesses;
+}
+
+static unsigned int kdamond_check_reported_accesses(struct damon_ctx *ctx)
+{
+	int i;
+	struct damon_access_report *report;
+	struct damon_target *t;
+
+	mutex_lock(&damon_access_reports_lock);
+	for (i = 0; i < damon_access_reports_len; i++) {
+		report = &damon_access_reports[i];
+		if (time_before(report->report_jiffies,
+					jiffies -
+					usecs_to_jiffies(
+						ctx->attrs.sample_interval)))
+			continue;
+		if (report->pid && !damon_target_has_pid(ctx))
+			continue;
+		damon_for_each_target(t, ctx)
+			kdamond_apply_access_report(report, t, ctx);
+	}
+	mutex_unlock(&damon_access_reports_lock);
+	/* For nr_accesses_bp, absence of access should also be reported. */
+	return kdamond_apply_zero_access_report(ctx);
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -2607,6 +2671,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		else
+			max_nr_accesses = kdamond_check_reported_accesses(ctx);
 
 		if (ctx->passed_sample_intervals >= next_aggregation_sis)
 			kdamond_merge_regions(ctx,
-- 
2.39.5
