Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3623958D;
	Sun, 29 Jun 2025 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751228088; cv=none; b=U0Rvjq8kXsT0kuLcUGCLQ4e/QBB8aw/l/+b2Di8ADTmsWCdXg5Zi4c0uGnn/qwOJvbnmOLnvpuiPt3C+ebyfSmUAQpAkFaaAz1wyzwJfGOBO4EiO9hRWrbnm+XD8A8lzXz0tMId/13vho0cZ5gnpkzJM0RN1u+6oHCAox7DKxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751228088; c=relaxed/simple;
	bh=MU2ihuhRbcRf1fDg3XPwZVg/5ZSe+hiAlUpj1S6bhJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrrGV03a1RuXaq/UZLMT54I5RPYTz/d2apP7MW+L47sOAHMzMYgq4nYqe8gcx/0FYcN1l96vRzgcPBxlYNwx4YDJtlL9pUbRCQA1hcWizxN42sYP4JsuLOd0OyVYhvg0Ec4cra1Wa1idLJqN07JWQljnLMpHLNSH/S3KrEFDE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXMIQhz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXMIQhz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF6C4CEEB;
	Sun, 29 Jun 2025 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751228087;
	bh=MU2ihuhRbcRf1fDg3XPwZVg/5ZSe+hiAlUpj1S6bhJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXMIQhz8xwv2iKYzuyO6NqQHPvp3tlMkOsUXw5R/QGyqAl2iAlN4JIEMU8GMeQMJY
	 ukicEefMFlMqdhHowBFKTGzsRhv6b9txOfBsp77unrsIcLL61fr/kqVpumaHJtqoty
	 eMJdXnWCWlU+zQzgFZv2p+F0ysPLTtkTvLprxaUFP/oILF0yh1kpHnISwpQAYL/1xw
	 GBj0GDJBc3fGIwDLtin/lM6WY1pHk+Dpa+6CvqRWc0ERxRTbPYUItmy6YwBllqvIcy
	 Q/9jRrVCdODH6O4+2AVo0WZSMKuDWsmCPAYGzntR4o5SrG/caK/0QYt4eGY9uMHIRl
	 cZYKJmA7wSRFw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/6] mm/damon/core: introduce damon_report_access()
Date: Sun, 29 Jun 2025 13:14:38 -0700
Message-Id: <20250629201443.52569-2-sj@kernel.org>
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

DAMON core layer asks operations set layer about past access
information, on core layer's schedule.  In other words, core layer
"pulls" the information from the operations set layer.  This is
problematic for a case that the operations set layer have no time and
space to save the information until the core layer queries.

Add a new DAMON API function for reporting identified data accesses to
DAMON, on the identifiers' schedule.  In other words, it lets the
operations set layer to "push" the information to the core layer.  The
function internally uses mutex, so reporting kernel code should be safe
to sleep.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 21 +++++++++++++++++++++
 mm/damon/core.c       | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6370cf44486f..a2198909c903 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -104,6 +104,25 @@ struct damon_target {
 	struct list_head list;
 };
 
+/**
+ * struct damon_access_report - Represent single acces report information.
+ * @pid:		The PID of the virtual address space of the address.
+ *			NULL if it is of the physical address.
+ * @addr:		The start address of the reporting region.
+ * @size:		The size of the reporting region.
+ * @nr_accesses:	Number of detected accesses to the region.
+ *
+ * @pid could be stale, and hence shouldn't be de-referenced.
+ */
+struct damon_access_report {
+	struct pid *pid;
+	unsigned long addr;
+	unsigned long size;
+	int nr_accesses;
+/* private: */
+	unsigned long report_jiffies;	/* when this report is made */
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
@@ -961,6 +980,8 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+void damon_report_access(struct damon_access_report *report);
+
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ea2a17b2dee7..b54ed91f2dce 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -24,6 +24,8 @@
 #define DAMON_MIN_REGION 1
 #endif
 
+#define DAMON_ACCESS_REPORTS_CAP 1000
+
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 static bool running_exclusive_ctxs;
@@ -33,6 +35,11 @@ static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
 static struct kmem_cache *damon_region_cache __ro_after_init;
 
+static DEFINE_MUTEX(damon_access_reports_lock);
+static struct damon_access_report damon_access_reports[
+	DAMON_ACCESS_REPORTS_CAP];
+static int damon_access_reports_len;
+
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
 static bool __damon_is_registered_ops(enum damon_ops_id id)
 {
@@ -1403,6 +1410,34 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
+ * this simple implementation, though.
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
2.39.5
