Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968553;
	b=p3AUAtLfRyarhc6z+YHZ1FsLXvuMWD/B8Qo40QY9sHOKHNJK0/aFujPQdyN/hnnZclOV
	 tAsbNd1s+Jvusno8xlM6bNYnr/RZtP7oJzjce2qxsAKpoPb0ywEdHCtDK3GvyDyVPsPAw
	 hIU5pKaWD0SdBafA5knQAOsJ8NQjTBYI3+v2xXim72Rc09VKj0YjbVTNTpFHXLv44ynDq
	 Krao5mTjAyb6inVr7WTZfKJS1K1RqUsQPuyaxXsaOUeMgbh4IgbkNPrO4Q1+npQYse7Am
	 wmzdYpZFPAKoRWpPc7rM0WDd33miEJPp9CmVbiL80cIGQYy71zfJmWFCoNWwuAvns5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968553;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ki1YfSbeSA9MKlcLCTk/glJl7KkUIkyI9Al2InfuFgI=;
	b=tX/f6QGwFKYzLvCW5/qpFh9gXPSqd4x0xRjmUT1gXFbsm95he2mGZwuzfPyTxtMzXo/A
	 GXSxKtaSrdFh3eRxZhyR7sjlwdbU7BlX8kp8z6csxcgyH8+PMhSba2D9buti1Eeqh9ETq
	 QEewejAVUjm1kkiIIdqWesI4aWgL7pstGtz/eAqwAv7UmtgP3TuaM6NTvGoJTvkQ3Xbew
	 D+dFEIyXIa0mVrxyNLEvEFi0RJ7nYOTghgD5IiGJagp7UB9wHsDfYrupdiuhJxH4SoZQP
	 euiRBq9L5kmhIqv8eOfmgwOSeJ2genrcttBHyoaZR8+YnSGn4FycVCp9H4JY7lxvIZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7ogZmjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC21606A882;
	Wed, 18 Nov 2026 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7ogZmjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CE81F000C9;
	Wed, 18 Nov 2026 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968553;
	bh=Ki1YfSbeSA9MKlcLCTk/glJl7KkUIkyI9Al2InfuFgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m7ogZmjJ/ZB8aJR3Q7GUxTz0cb4qh3s/GFbJK2USDaOILuJeglry3P/iYVr1W8F4r
	 NUZJ/FDH6lyEmvs9xIa/QAhMAIIJssMzQnTsaUqA0u73qGJOO7UqGkd38aj78ZMkbr
	 5t4FfIlk1VrBI8coL4XSlHIyJDp++bkeuIS/FaXT5WlsTS7w2ZkmcB30vZOvIYeTXx
	 PVOWpPwI15q2qnWHzEsl2NP/hB+6YRlbdgaGFz8fR8+hSzn4eI0ynTMQLdAwTMAM1P
	 cETWpsBM96y7qcZAQykBg2tnsR5dLbxAfgBEBWlhvavTb2Kj1WApiNHZmv/pAVNSuM
	 n5+856BDBrZbA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 03/27] mm/damon/core: introduce damon_submit_report()
Date: Tue, 17 Nov 2026 18:21:58 -0800
Message-ID: <20261118022225.100659-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
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
index cac1329397a4f..35ad002d1536c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1187,6 +1187,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx);
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
+int damon_submit_report(struct damon_report *report);
+
 int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
 				unsigned long addr_unit,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e9c1079fdb22..9d492a9aaf550 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2353,6 +2353,36 @@ struct damon_report_queue {
 
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
