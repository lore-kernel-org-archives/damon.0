Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774547;
	b=AJ6Tg2EdKa7aiiPtXLRn3QFG40CWc9XTBgsx+7KPsf1hgwvFJWLuB4de0tN0SE/AGB5K
	 GcJkKj7pVPzlhwAHeIeSdsvJ2uDWIOAIkgCXziDn1PZl5Zb23cbWlJcmkRYwKktLd4N0p
	 Llzikvf1f/6m4FWzEAPazEOFyxK336jj1/teackpm0vYF1/Gj86SGbPEAVjly9cEQGGxX
	 AfVXy+PEcBUUrDtBBZCZSegIgTUtuQ8rpCWelaLhN+qIU6+uyNJTEa67USvQAkDXocy7f
	 Fi3DMh/xGmtZOa3bNHOZwo/GTovf3vhBaYqW+MaKzGETxYV2m2OlB2juDq4bxDiDBHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UD++Ozuyu/iWISz61QHAnkrLOx0dOy248fDd7IudnkI=;
	b=3Azq3ClUujr+lRW8AEuOcvi1huT602SU042zZzd/CN6Mn3PRVEN62n2w3a/EV8seSzo1
	 Dw1w/Yss1kJey+4T9PPbHFieCWYswVxcr53Z1NHiL2IUAoYAVYtvJ5Quw1+A1QBQyYBAI
	 sTvWffvXdAL5kTfULx8m5MKQqnUyhkah5GAEhc6pBsol9zqERFQ3V4GXtMNKw2BVo4TfI
	 PsgVbVercJ3AJ52eDS2oprkYXFe1F1CtdBtKhun56h4nVDO3QJWqzcU2SoJR3in3QH+CM
	 Ui+3iaRdTUdw1Z2yKBYu3e9xxAwv9HF8lTYt+C3aT/ImccL3cfDtnAkQ7IfWKBM+XYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ym04wGz1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081660A3839;
	Sun, 15 Nov 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ym04wGz1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7531F000D1;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774546;
	bh=UD++Ozuyu/iWISz61QHAnkrLOx0dOy248fDd7IudnkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ym04wGz17gKjtf7xt+k0YxBVblaCQX8DJGWWHHIrKwMjz3E9fwzjh9KC/4UYPeozv
	 bpVAonJI+hSeFcTZo3DidLCvpFrLQhSmNDgo+/Oakrnmm1V1dMLsqmRBQCO9wTGkoP
	 o9ujbNkeXGyKIEda4YzfYv5j+2Cli7H46mqnSIzHDBm1m4jQlYdf/oHFbbNk82aPYB
	 01uXCLmdZWAfJgN8z/5aVE40Ft4QWab8MBeIO9ks/Ir4ss2L1irp9pFdkbxwTAsSId
	 nxjFENt0/RrGXdzLcTqrAQHel5v0D3a0W+UtVEEhC1BsItHu+0kkOrBO3m/0h4fmw4
	 6R6uDglQv9PQA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 13/27] mm/damon/core: introduce damon_report_exist()
Date: Sun, 15 Nov 2026 12:28:31 -0800
Message-ID: <20261115202849.99134-14-sj@kernel.org>
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

Implement and expose a new DAMON API function for searching data
attribute reports from the report queue.  The purpose is to let
operation sets use it for supporting the REPORT_MADE type probe filters.

The caller can specify the type, associated memory address range, and
the creation time range of reports to search.

The function uses CAS-based try-locking for the mutual-exclusive
synchronization.  If any parallel access to the queue is detected, it
forgives searching.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  3 +++
 mm/damon/core.c       | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cce7d344c585b..0e43b669dfc49 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1193,6 +1193,9 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_submit_report(struct damon_report *report);
+bool damon_report_exist(enum damon_report_type report_type,
+		struct damon_addr_range *addr_range,
+		unsigned long jiffies_old);
 
 int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c02c7fbc1d864..c60a6504d0a15 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2386,6 +2386,52 @@ int damon_submit_report(struct damon_report *report)
 	return 0;
 }
 
+/**
+ * damon_report_exist() - Find if a report of a given condition exists.
+ *
+ * @report_type:	Type of the report.
+ * @addr_range:		Address range of the report.
+ * @jiffies_old:	Oldest jiffies to find the report for.
+ *
+ * Returns true if the report is found, false otherwise.
+ */
+bool damon_report_exist(enum damon_report_type report_type,
+		struct damon_addr_range *addr_range, unsigned long jiffies_old)
+{
+	struct damon_report_queue *queue;
+	int lock_old_val;
+	unsigned int idx, nr_read;
+	struct damon_report *report;
+	bool found = false;
+
+	queue = &damon_report_queue;
+	lock_old_val = atomic_cmpxchg(&queue->lock, 0, 1);
+
+	if (lock_old_val)
+		return false;
+	idx = queue->tail;
+	for (nr_read = 0; nr_read < queue->nr_reports; nr_read++) {
+		report = &queue->reports[idx];
+		if (idx)
+			idx--;
+		else
+			idx = queue->size - 1;
+
+		if (time_before(report->jiffies, jiffies_old))
+			break;
+		if (report->type != report_type)
+			continue;
+		if (addr_range->end <= report->addr_range.start ||
+				report->addr_range.end <= addr_range->start)
+			continue;
+		found = true;
+		break;
+	}
+
+	atomic_cmpxchg(&queue->lock, 1, 0);
+	return found;
+}
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
-- 
2.47.3
