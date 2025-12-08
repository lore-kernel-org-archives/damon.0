Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1448319615;
	Mon,  8 Dec 2025 06:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175391; cv=none; b=bB0+GnWVbQ+O2pHD8AAtRRuPpRPc0B24FGL9NMBjRRMFjkWbAC5ZUOgs8Ve68xR+wT0Epto+XdctTJkHXQs+ojcBeVpidk+a4Mo/0s1X/NShj88pBoNwUm4hFreT3JSdQCNeJj6QuIucReAFoVY5OeVlpLIGC4kdQk7EwqbxuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175391; c=relaxed/simple;
	bh=ZxPuOve16IrlwUTG5ESII4iH+1SrqZ6IkyUiguVkjLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8hOmim2fDIy2pvBTejjOJ5u74yZq9pL6uwTTxv1nyRHX0CeW7WJeKG4dJlebk1CHxKe+tI9xTA9SRfqCTCcsP2wvRGJZiVp1Ep16Q68D6yW5KZDs3cNB1jsNGlAtdYyhUhlsmjKlaZ6i0z5oymOsddRcayKmC5nj05ErV67ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVfo/zWF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVfo/zWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD43C116B1;
	Mon,  8 Dec 2025 06:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175390;
	bh=ZxPuOve16IrlwUTG5ESII4iH+1SrqZ6IkyUiguVkjLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVfo/zWFzj33IhJkSn+EyozYUUTyO623/XtYnG369BniJsYKzB4HGum70XDruWtdN
	 ojCFPbh0qcnhxVBagiY2tJE0oL4lrOLicZTXRC89eew0ch4PnE+j4YZYtK+ILS8/kQ
	 CxBv2zBRlHx4FqOTslKi7vkvI+tx+h5jJRNg+BAukN/0A3kHAJzUsxYZNHXlTd85k6
	 W9xdhrHRmqTSD86en4WZMI/e8McaIUmwqpgXCxeJul/RB2DOzfi537YDBOQ4oawV++
	 mG8vVzKh1IMbPE1N6kj8UvVU+FbD2dyM7rGJxDRekmosWf58pUq16xKx/g+cQKUwaL
	 cWkwZNoS/3WKA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 01/37] mm/damon/core: implement damon_report_access()
Date: Sun,  7 Dec 2025 22:29:05 -0800
Message-ID: <20251208062943.68824-2-sj@kernel.org>
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

To report access information to DAMON, DAMON API callers should
implement their DAMON operation set and register that to the DAMON core
layer.  It is a burden to do such implementation and registration,
especially when existing kernel components want to simply report their
observed access information.

Add a new DAMON API function for simply reporting identified data
accesses to DAMON, on the reporter' schedule.  The function internally
uses mutex, so reporting kernel code should be safe to sleep.

This API was also discussed at LSFMMBPF'25:
https://lwn.net/Articles/1016525/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 24 ++++++++++++++++++++++++
 mm/damon/core.c       | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a67292a2f09d..1bee6e7fed1d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -110,6 +110,22 @@ struct damon_target {
 	bool obsolete;
 };
 
+/**
+ * struct damon_access_report - Represent single acces report information.
+ * @addr:		The start address of the accessed address range.
+ * @size:		The size of the accessed address range.
+ *
+ * Any DAMON API callers that notified access events can report the information
+ * to DAMON using damon_report_access().  This struct contains the reporting
+ * infomration.  Refer to damon_report_access() for more details.
+ */
+struct damon_access_report {
+	unsigned long addr;
+	unsigned long size;
+/* private: */
+	unsigned long report_jiffies;	/* when this report is made */
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
@@ -972,10 +988,18 @@ bool damon_is_running(struct damon_ctx *ctx);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+void damon_report_access(struct damon_access_report *report);
+
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
 				unsigned long min_sz_region);
 
+#else	/* CONFIG_DAMON */
+
+static inline void damon_report_access(struct damon_access_report *report)
+{
+}
+
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index cc15d8ec9dce..7abd8c550c60 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -20,6 +20,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
+#define DAMON_ACCESS_REPORTS_CAP 1000
+
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 static bool running_exclusive_ctxs;
@@ -29,6 +31,11 @@ static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
 static struct kmem_cache *damon_region_cache __ro_after_init;
 
+static DEFINE_MUTEX(damon_access_reports_lock);
+static struct damon_access_report damon_access_reports[
+	DAMON_ACCESS_REPORTS_CAP];
+static int damon_access_reports_len;
+
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
 static bool __damon_is_registered_ops(enum damon_ops_id id)
 {
@@ -1271,6 +1278,8 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 			return err;
 	}
 	dst->ops = src->ops;
+	if (err)
+		return err;
 	dst->addr_unit = src->addr_unit;
 	dst->min_sz_region = src->min_sz_region;
 
@@ -1521,6 +1530,34 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
+/**
+ * damon_report_access() - Report identified access events to DAMON.
+ * @report:	The reporting access information.
+ *
+ * Report access events to DAMON.
+ *
+ * Context: May sleep.
+ *
+ * NOTE: we may be able to implement this as a lockless queue, and allow any
+ * context.  As the overhead is unknown, and region-based DAMON logics would
+ * guarantee the reports would be not made that frequently, let's start with
+ * this simple implementation.
+ */
+void damon_report_access(struct damon_access_report *report)
+{
+	struct damon_access_report *dst;
+
+	/* silently fail for races */
+	if (!mutex_trylock(&damon_access_reports_lock))
+		return;
+	dst = &damon_access_reports[damon_access_reports_len++];
+	if (damon_access_reports_len == DAMON_ACCESS_REPORTS_CAP)
+		damon_access_reports_len = 0;
+	*dst = *report;
+	dst->report_jiffies = jiffies;
+	mutex_unlock(&damon_access_reports_lock);
+}
+
 /*
  * Warn and fix corrupted ->nr_accesses[_bp] for investigations and preventing
  * the problem being propagated.
-- 
2.47.3
