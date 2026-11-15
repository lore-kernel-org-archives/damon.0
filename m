Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774543;
	b=qZ1v3vFftbadYogVYd6If0YbcYOjbs4kPuVGpYNsYCt/32DlkY8PzsHmdAZuz5Ib9qXx
	 a/EvJV3lbuf1f48G+34fgQaB5y/Hti4BNUER9DcAND01JYy3l0gg9UOjOeI++9L30kN57
	 eB/Kxj9LGRIhL+GZ65Lc7TpArZTUrq4toqBmiyQqiIRs8FuyZSuDbHs1/q5/QnvPR0LLJ
	 Q1hvoqW4ye29zTxrDm5TSBhsrk/C+PJtBgeizgxmUAhle9pSNqMzwGewzuI+FS2UlQw+u
	 +OIhaxU/VuzPoXsjBd/dCnGMNdmhyzXbGnIW90D8WQPv5qROAvkXsWRe2F/vPTNu/iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774543;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lOEWifhQB1QprRyloMm/qb+7W0HlNjxuF07T5a4HNeo=;
	b=gSXemSruCs6iXDUwygf8kvxgLy4nY3lXv1zzkENdAizBP1jPCLRhoxuyHjlUKpAYegS7
	 zsYLWbbtXRNi3PjwxNgyk+7b3kY52JDKJ/aMtXS3Sa6PfO1hmkt3Vjf/5UGJuGirJcdcn
	 7FPHKPshVL1f3RFkbINxpcnuA1Adq42XjcVNkAu0USSlaZmK9Irt/PWRokVaMRsW+cP4q
	 7EjSuVbLiYKjKRuoJpA32CXRqIwEMIyoYayMchWEOQbvo3LsIlFOSnHgvyRZEYWYieMIa
	 nTMxK4DM+ITgVueMbC2W2UNAEXYb7w4smx3ay/Ql5Jj2tsxzhCx60cPWNJAMFd0kSMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owhdubng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA71606A332;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owhdubng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C811F000C9;
	Sun, 15 Nov 2026 20:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774543;
	bh=lOEWifhQB1QprRyloMm/qb+7W0HlNjxuF07T5a4HNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=owhdubngAEBRyye7lsJBXZuHgYIy+DIrcSCdyAYNSz2tYJHRJmpsbMgfD/uPupBdq
	 gcL3ft/+KD4rTiTWbIo+KlNnuIFX3wq41Sv0eadPZwYRbOolQeX3YjffcV3zuUh0fL
	 LGXxTZFJ6v1EX1fMCMQD5pfrkm9HAc8DZd/D2UgYHILUuK2C3PsfDrn6f3+61cjW12
	 Jf8/C/F/9sr7G65oYL6dtHBMSGxOgTRvhe3CM7RFZdTMTH3viBzPM/dABXsCk2J3AP
	 cCw+8YltMidzOox6IPZs5lHyX7wIyJvgw7DQ5coEG9+3ktxOMy6tL2d4LlIR7dIyNK
	 c1zMf0LZ8SYkw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/27] mm/damon/core: introduce damon_submit_report()
Date: Sun, 15 Nov 2026 12:28:21 -0800
Message-ID: <20261115202849.99134-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5c32ddebf4625..ca0135c6f6700 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1189,6 +1189,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+int damon_submit_report(struct damon_report *report);
+
 int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
 				unsigned long addr_unit,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3f87a7eec442e..06b85d00e38d9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2353,6 +2353,36 @@ struct damon_report_queue {
 
 struct damon_report_queue damon_report_queue;
 
+/**
+ * damon_submit_report() - Enqueue a given report to DAMON internal buffer.
+ * @report:	The report to enqueue.
+ *
+ * This function can be called from any context including the NMI context.
+ */
+int damon_submit_report(struct damon_report *report)
+{
+	struct damon_report_queue *queue;
+	int lock_old_val;
+	unsigned int tail;
+
+	queue = &damon_report_queue;
+	report->jiffies = jiffies;
+	lock_old_val = atomic_cmpxchg(&queue->lock, 0, 1);
+	if (lock_old_val)
+		return -EBUSY;
+
+	tail = queue->tail;
+	if (tail == queue->size)
+		tail = 0;
+	queue->reports[tail] = *report;
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
