Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294822;
	b=uSj9d0VcLILSYWj/1ulVNo5MmA69t7tXgUGW5KGjAiXSrUwRv9m6a1EaCtmZvpQKF9FB
	 tTGaRLJxUYHECcfWI+orXXUYnmPRDuvfbqJyqFAEhXJ0d4uWFPFnvfptvKri6QwaFvQw4
	 dw7j5rNbA7IME+TUW2pRCjBkWDT2Itv6wNCeS05sU42qdWRZraEJT9pMiUN/GZW+sdCG/
	 jcNMSrnY0vTWVsnK7sqMCb8AHD9Vqa2slYaFMwksbIJjV15FCfx/Nq8Qm269zPHXbQMJK
	 L6xC1tDOxy/ax+tc8zx48/6fMjjpGqu6EjQh5Tu9jD4CfUjqdG7wM5fvbng2ulTJoTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LrlcgoNsiHbXM316FFVBzg88Tme7dmxEQRaz41WAXvo=;
	b=lkUCgduGrnnirDogeDwcUI1CiaSnlehJIZlgX05NFA7AFWPHR8o9wiIMQoF1N0kzIiVu
	 88hntTl663rKH64JHD/A/v+xG4rmwjnT8enKCt0sM9UmVZyuSWB5x87r4jBXY+vCX+ABQ
	 abxjMGMbJqko13tVar2xsg4XGqyrSyFx/P15Uf0BXPbNtFq3A7yfOQCvJYVpS57eoMpWW
	 ZSGGTBu++vyOgPQWvwdARiTAHQ9zASb/tRvxyfcRsF5xBUrNIktvsSVJm1pEXOUkb5Fbj
	 sGV+MkIYRKhJXm3O1eWvQ3c+gz0JupBA/UfCTAXISSy8XMnTqoT0If4vTPIyQMsOS3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LP+9/YQT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B332606A330
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LP+9/YQT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2839E1F000CA;
	Sat, 21 Nov 2026 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294822;
	bh=LrlcgoNsiHbXM316FFVBzg88Tme7dmxEQRaz41WAXvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LP+9/YQTwNjUojdvaPg8a1cItTq11n9fYIZ1tRroa83a+rHCeCakUW5Px9gxLfqCT
	 Z6SkF3yQohknQSrSMyBM1impB3lPaEt4RA7Ov7iOorr1RR2yCoHPGvvjzSw1hUMGHh
	 B20FQSX2pV2+FY/CAW+y1UNozT0Zt8fMX0g15mHW95fHKh9DgvNsJR4eHT1e5QAMST
	 ZByV90x+DdynMb6j0rOowkDViOi6x+gAtp2A4HoxvVAIY82oUOafD7YZ/2FUhP+xdb
	 /v/fR3zVqoiiPWlMDkFtzNI3n0cBk4EP8bXChzQJtrl2UdaffU61SWFqrwGcw9OhYu
	 VUiMfW+FOmmjw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 03/27] mm/damon/core: introduce damon_submit_report()
Date: Sat, 21 Nov 2026 12:59:47 -0800
Message-ID: <20261121210013.130397-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
index b51741bb60e26..61ff3adcc69f4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2352,6 +2352,36 @@ struct damon_report_queue {
 
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
