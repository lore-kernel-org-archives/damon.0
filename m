Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5709463;
	Sun, 27 Jul 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647499; cv=none; b=LHjuhLsBwYuBwwo0Lnbgc8djUD3mJwhqENENw7cCV0TbaY3UF3Pv09Ug8Hwus+2hJHCrDASZaAxuyFdL17UAa8OC5gQL6KLSmShoPX7EwdD19Oii6DKAtO+uPsq6fXTjyFD6z9p/rPXIfJuGGxWNSTGHU4XZ6bSbkQadctKAlw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647499; c=relaxed/simple;
	bh=HqUvAgrhD+ZVNsGThR4W3V9E1/zbZYx/FHOFDYmdj58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTCzK5bym6qPE5ww20itBVZc7D/HTupBW50lIDYByTropJsGNoVfsri0iOtXRBCmDd1P5sVf9ThudfYt2BKPQYG8zDrtfimodx2qbymje9IAX1wcfu4xh500gZFCMGZZn06Y85ruKyK/aDc4hhx6i1hKuQMU1fVe7GiAx17VQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQijjcRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQijjcRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3A1C4CEEF;
	Sun, 27 Jul 2025 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647499;
	bh=HqUvAgrhD+ZVNsGThR4W3V9E1/zbZYx/FHOFDYmdj58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQijjcRc2uGNxF3ZV2oGZ3kGwkNsro6aw8jQX9xkOJFU36vTddqeevRmebA1/jTpa
	 mAg48nqTRpMUIqSR1FNP2zE7og5SkioWdmv8ZP4C0OGAz/h06AtOs3amG//Q1ZbEIq
	 Aj2khGAnzV7oJIdWgvoQS+H4/AJtm5o2xElqvP6dYAC/dZZDeZE+9xZ9RbwfHufvYd
	 JkyUcUX0fHJB5O9Ur39tgOmbJnU2mIP2Y166eRMV42C/fyGPVqnIjL2rL/GAFgiVA5
	 HQIu7zzcdGn/zrP2SDqhru2E3C6upMrE1/9xcRDVnIPQsvTI32rey5qyM+CmFtESGb
	 BtXrwFiIcbPVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 1/7] mm/damon/core: introduce damon_report_access()
Date: Sun, 27 Jul 2025 13:18:07 -0700
Message-Id: <20250727201813.53858-2-sj@kernel.org>
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

DAMON core layer asks operations set layer about past access
information, on core layer's schedule.  In other words, core layer
"pulls" the information from the operations set layer.  This is
problematic for a case where the operations set layer has no time and
space to save the information until the core layer queries.

Add a new DAMON API function for reporting identified data accesses to
DAMON, on the identifiers' schedule.  In other words, it lets the
operations set layer to "push" the information to the core layer.  The
function internally uses mutex, so reporting kernel code should be safe
to sleep.

This API was also discussed at LSFMM'25: https://lwn.net/Articles/1016525/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 25 +++++++++++++++++++++++++
 mm/damon/core.c       | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 479ee52b79e1..1f7592147d92 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -104,6 +104,23 @@ struct damon_target {
 	struct list_head list;
 };
 
+/**
+ * struct damon_access_report - Represent single acces report information.
+ * @pid:		The PID of the virtual address space of the address.
+ *			NULL if it is of the physical address.
+ * @addr:		The start address of the reporting region.
+ * @size:		The size of the reporting region.
+ *
+ * @pid could be stale, and hence shouldn't be de-referenced.
+ */
+struct damon_access_report {
+	struct pid *pid;
+	unsigned long addr;
+	unsigned long size;
+/* private: */
+	unsigned long report_jiffies;	/* when this report is made */
+};
+
 /**
  * enum damos_action - Represents an action of a Data Access Monitoring-based
  * Operation Scheme.
@@ -941,9 +958,17 @@ bool damon_is_running(struct damon_ctx *ctx);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+void damon_report_access(struct damon_access_report *report);
+
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
 
+#else	/* CONFIG_DAMON */
+
+static inline void damon_report_access(struct damon_access_report *report)
+{
+}
+
 #endif	/* CONFIG_DAMON */
 
 #endif	/* _DAMON_H */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 64e59d15043a..4e25fe100b56 100644
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
@@ -1461,6 +1468,34 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
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
2.39.5
