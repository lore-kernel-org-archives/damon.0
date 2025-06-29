Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894923C51B;
	Sun, 29 Jun 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228090; cv=none; b=lIybYEUa5UyZhXdNC85L8fKrxTVI3NrkslBiETNIh7MyJAyzFW5k8M2kDGDAu3w4f4g901EZ6gQlq9wzQRFgRMPYU5PH1wfPrXgguEf6f3Df0TrnDsJto6lvKp9bL6vgsIg7Rs1Ia5eHmq1C2MzPxdWTI40MSPxW9ZM0cnwvf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228090; c=relaxed/simple;
	bh=mDWuVxXJ4aMqmgAerywNkRA8beEUvDecOP2ZcDOEVbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3pVSgLRTleav7BLbeFB+YpWw2rKlS0P2cVANAA6MAhfgBdolVYhKaQp6DHUtFX+CehNzm8LViLd2Ha1kD571TlqBcG+rrjMHrzfMlLFDvCSPw04X9uOEuaikqt7JBsiarlgcqdxTuFuQPeJ0OkiMwUmpy/RsA168FEdDGKuOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgwmRQ4o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgwmRQ4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89743C4CEEB;
	Sun, 29 Jun 2025 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228089;
	bh=mDWuVxXJ4aMqmgAerywNkRA8beEUvDecOP2ZcDOEVbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YgwmRQ4oNhfzfFDiJHFGVTzyKosuM3x0W/IzFPslQOBcdymUZyOKMnETQXHZBBMOv
	 MWIsy882JWriU8dYfMmmkTnHKS2dakwp85zzx8NzngbzFhLPsKFZbw9jmX+ZuXAi4Y
	 eUAO1KRXBdxyIHO00lYNrH2QHe6GORMPDO/E/6Lv5gZmlxwQzrUcB1PmtZAs3OWXle
	 K+7GFOsnsmD3dPz6ceT51X/PXt1F/qVAFvDu/ZOdEsVxdE/jBSnuxaVLfGB7WajabW
	 USrDR6tV6+B46HLFblzgwFrZVjLBKhOQyLKs+EsSzoPmTt6gjToN7gTpjyGj43cagt
	 4oSdTIbRSTo8w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/6] mm/damon/core: check received access reports
Date: Sun, 29 Jun 2025 13:14:40 -0700
Message-Id: <20250629201443.52569-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250629201443.52569-1-sj@kernel.org>
References: <20250629201443.52569-1-sj@kernel.org>
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
 mm/damon/core.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b54ed91f2dce..59567d79af99 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2472,6 +2472,46 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
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
+		r->nr_accesses += report->nr_accesses;
+	}
+}
+
+static void kdamond_check_reported_accesses(struct damon_ctx *ctx)
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
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -2518,6 +2558,7 @@ static int kdamond_fn(void *data)
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
 
+		kdamond_check_reported_accesses(ctx);
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-- 
2.39.5
