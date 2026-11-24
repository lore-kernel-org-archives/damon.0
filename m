Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534606;
	b=D/IbIbjkmcP4SDhde7/QBOrNDCMUiokFh5t093CucgdI4kjpqNw4DXQbP4DJpkZy3vEz
	 2ZrXh8b28EAU6OhtX6ehbn4AkJBsRaTqzXrUTHXAJi71sqKDWbnrPqpMDy4pvcM4mt2Vo
	 cyjgwdTFnRVdvXU/UT61L0vSfeBPBUNu3pbyB1WG9L2qLPhlj6FGhMfwFsuXfs2vHrhzx
	 WxHDv1pcX2iclN/oCpKmQE08nb17UQiJny2oM7kPKw3vVE2cpElBqFVrJ5BQ025+YoMYA
	 vJWAUyIc/NmMJXfL+TRVzrxKL2U2tYqt4jHI4KDOuu/ioPgPmDr4LoMcZG1IUDPVMZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NN8lp+t1lC6QgLK9X7uxeIzD+QXEer2g4STJ701UeWA=;
	b=s9AIlL2bO+fbDdus1H7+Ytn3MiTy74M+mbgP+0eN7MZ9msZEbe18nX/1G2G3KsrqX79S
	 TcEUse9St2wgx2dkI85T6NaVP/Tas781sIZgYV9ziWokwMQeDI2St4q2Bitqcl1W1PqpO
	 bHM8v9iUiIS208CQSeVx0EKpndqYYmXX0isP7+o/3B7l6Aykkj0m/bz4IS4JmOOVr7DbU
	 bYpuuVZ08DOfCWpBV46Y0PcZ00C94a5QprZ3jkSruz4Do26swq7lW5HMSr+DmiLKtVDDs
	 tGTUExIhP9d26AnSVnHWrwc+gQMnGqi5ue2giBAhPVDfsKj4SJ6ydpXitMXkBrQvb4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es5g3dCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB9606A32C
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Es5g3dCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0FD1F000D0;
	Tue, 24 Nov 2026 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534606;
	bh=NN8lp+t1lC6QgLK9X7uxeIzD+QXEer2g4STJ701UeWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Es5g3dCGyNbb6SVfb4nZ8JLDh1p5N/4vOPcQbpi67NCwAH12zP/TZc1WwlO0VPFrg
	 dwpj2qWyfQlukkcg3HvqoH1UHQ3wv6w79QCCE/YYANfq6nF1UR68iyi9kCV9OjLRcB
	 dP8wi1zv3iBewFbhOAPe7ofz5PGqa+y7d3MRfTGho+Z39Kgjm14Cfgc+Yr7tpcukyU
	 GU24qg8aHB5EiLcrnclSyUjEEqSlzYuDwN0CQs8vbyd44sGOAmzzUl9kkBCggDYLAL
	 Qv68yc7qWoVmnF+lN7KDvjIfdtEaf6OKjnUeQGpXn7KPWpNMJBxpfdtqN6nlOMko5F
	 UuDCJQWY8JBNQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 03/27] mm/damon/core: introduce damon_submit_report()
Date: Tue, 24 Nov 2026 07:36:09 -0800
Message-ID: <20261124153636.91854-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement and expose a new DAMON API function for submitting a data
attribute report.  Any kernel component in any context including NMI
context can use it to report their finding of data attribute information
for a given memory.

The function copies the content of the report into the DAMON-internal
report queue.  The copy is done in a ring buffer-like manner, without
being blocked for consumption.  As a result, the queue keeps the latest
reports up to its capacity.

Use simple CAS-based try-locking.  If any parallel submission is
detected, simply forgive the submission.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 2520c036306f3..30c0ab8d88c2c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1193,6 +1193,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+int damon_submit_report(struct damon_report *report);
+
 int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
 				unsigned long addr_unit,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8293b69169856..ae6ef43e5653f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2356,6 +2356,36 @@ struct damon_report_queue {
 
 static struct damon_report_queue damon_report_queue;
 
+/**
+ * damon_submit_report() - Enqueue a given report to DAMON internal buffer.
+ * @report:	The report to enqueue.
+ *
+ * This function can be called from any context including the NMI context.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int damon_submit_report(struct damon_report *report)
+{
+	struct damon_report_queue *queue;
+	int lock_old_val;
+
+	queue = &damon_report_queue;
+	report->jiffies = jiffies;
+	lock_old_val = atomic_cmpxchg(&queue->lock, 0, 1);
+	if (lock_old_val)
+		return -EBUSY;
+
+	if (queue->tail == queue->size)
+		queue->tail = 0;
+	queue->reports[queue->tail] = *report;
+	queue->tail++;
+	if (queue->nr_reports < queue->size)
+		queue->nr_reports++;
+	/* cmpxchg is known to be faster than xchg */
+	atomic_cmpxchg(&queue->lock, 1, 0);
+	return 0;
+}
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
-- 
2.47.3
