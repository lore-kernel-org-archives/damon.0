Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1931AAB3;
	Mon,  8 Dec 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175400; cv=none; b=ORBuvpDLqi+UJG/ZBCNrZMRHBq0lHHKhEcQZq0u5alTPO+pySGtco7JElqxfu270gSCxXDHb2JBchIdGi3NAk1X4Dlll0TUhLB215tP2Ln2IpOf17gzeiEYPRhfl2ccps3Uh/1e8NSwJCSIVEI1YvPN/lnWVYargeEo2VtWdv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175400; c=relaxed/simple;
	bh=kw63posGt47cF3PzxW8YgBTIV3frYoxoD81lOplefX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab1+xVOkBVEAOyTd5srVdp//r4BbjDML7R42e+Tp91G/i1kJ9jOw9qstELZSXVRFoKqehYcIOyHM1iYB6PD5Bx45PuWHWtDCrt2ULjfMCFYFUnbu7woretLXsWLXrw0uiAnFRcGZc08NwitqYx/iWjC2AsJ2NBAp/D6A+3vL5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBWtheks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBWtheks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4B2C4CEF1;
	Mon,  8 Dec 2025 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175399;
	bh=kw63posGt47cF3PzxW8YgBTIV3frYoxoD81lOplefX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBWtheksOgHWBstZsj7GigQ1TcugWneeQURbZ71ey2h+Ojpj12DQybju+3H4WjIaO
	 8oXwugeidzsjW8kCg3bXXZVOPcB44WgQsLlE+TZbM9Fq9J934FBXgLEaTRgZzSW7BL
	 2kb3lbw5g+TzzRC9SFzPsEL9ndBuajBI52JFKMYAyk9uusLf1jOOfgrIO2xJXvJTEn
	 r+IWVn9PyF/M5FJmGc2aMTqNu/ceeAxcMvgIU+YPnI1JDdG2MsCxXCz8Q1OeS94nSr
	 JXnvBWRlMqGrzYj6/pAYNxdw4YFQEhmB0Z8eiWLJJrUG96ZIFmIZtYblqvFQ7KUXZm
	 o5deaTstAHt7g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 07/37] mm/damon/core: apply access reports to high level snapshot
Date: Sun,  7 Dec 2025 22:29:11 -0800
Message-ID: <20251208062943.68824-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now any DAMON API callers can report their observed access information.
The DAMON core layer is just ignoring those, though.  Update the core to
use the reported information at building the high level access pattern
snapshot.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 68 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b8ebb2aa02c8..b04c2e36833a 100644
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
index 296117d5e7f7..a14754a47c7f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -137,6 +137,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 
 	region->age = 0;
 	region->last_nr_accesses = 0;
+	region->access_reported = false;
 
 	return region;
 }
@@ -2745,6 +2746,68 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	}
 }
 
+static void kdamond_apply_access_report(struct damon_access_report *report,
+		struct damon_target *t, struct damon_ctx *ctx)
+{
+	struct damon_region *r;
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
+	/* currently damon_access_report supports only physical address */
+	if (damon_target_has_pid(ctx))
+		return 0;
+
+	mutex_lock(&damon_access_reports_lock);
+	for (i = 0; i < damon_access_reports_len; i++) {
+		report = &damon_access_reports[i];
+		if (time_before(report->report_jiffies,
+					jiffies -
+					usecs_to_jiffies(
+						ctx->attrs.sample_interval)))
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
@@ -2790,7 +2853,10 @@ static int kdamond_fn(void *data)
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
 
-		if (ctx->ops.check_accesses)
+		/* todo: make these non-exclusive */
+		if (ctx->sample_control.primitives_enabled.page_fault)
+			max_nr_accesses = kdamond_check_reported_accesses(ctx);
+		else if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
 		if (ctx->passed_sample_intervals >= next_aggregation_sis)
-- 
2.47.3
