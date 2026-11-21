Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294825;
	b=wzMqShxY9daldB5/aVVyBKj0c5VqENz12BCfxwaQ9Ck2wpfir3LWwt+Ad8EbL3xYM/M9
	 2BgPsbPQ3qZWhQHxraH1Yo0OIaIVQkbyLK7aP/zi/brarbs6DeX8wQSz5lC4gLxVUx/qv
	 GnywenlChjPmHtNTYNNYFA8JdelM/1FC/Sdp2KnFI7Up9+uWQ13U2C4B2aGiyboflQ9zr
	 dbxofYpFZT+vz93Gc/QPbR/YFZg2ZjZoc1Qm1Wr7czkvWk8jpIcysVbnIha3rL835/Pt8
	 Dmo3o3ocDTzxjoSjW6GUEVK7kuPvHhKrGHUZgU2yRVnWN13pPgnE4oQgC6ufQFvNHig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RMY1w6zCdZbZED46otQNO9VCdx7EIsblDhOC0YAAboA=;
	b=IDG68VjIM1KRBSodYOxB2CF5NlR4Bc2fEFK/OIeheBXCtXWE/F6g8f8wwLI4jLqrQuaP
	 O3vZ4dQl34FbocmO6C5vkpCr0YhZlS6FiNayOpLu7BnB9iU9H4xh7LSsVChFHNyf9sjt6
	 y0LqFbi7rU57opCkTM8KHp6d6+2uGC1LquDbgUFCe3ySESX3jEqnHGOQC7V3SOqD7kHfM
	 UerxWWprF5EVJUibwEcSssZaQAQ6WZsuFYtRtycIeqX5ojFSkJ1Z4Zudx2EslNdv8Y3Rr
	 0EoU5lvuqPEOQSHkw9D0Fxe8stwuFr1ZciSWfbhYqI8dC6TqAIIrMdpG4zq2uZOEMvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UFZ/WE6K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30B606A331
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFZ/WE6K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7522D1F000C6;
	Sat, 21 Nov 2026 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294825;
	bh=RMY1w6zCdZbZED46otQNO9VCdx7EIsblDhOC0YAAboA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UFZ/WE6KhWtr9VybeKBqUIhhNCBUTgstyBIGbyOxgpFC960bXs5izLL/7toxJ3UM3
	 Ks/1xK6+gjdGqdFkMBF7V6DaEBPG8R2lJCBVOPgl238jkwNh5FDRJkDXon/rJQujmA
	 ldirllh7ZqxtIwH2GarZlme8Bt1oWg6+bP4Nb3C3CYUxOVOu8jIJjSfC2McnkGdlg8
	 NWahdZobWKc5jNsGRUX3KzDQt8HlAPhmcscQLKX+VD6bslHoJ1G82uhkCuel/0arWw
	 eiT2ZOW3DyWcd0VIFxiR8wSjOrvwHcYS64BQ67zkGwU9I9vkUWpVp0Fl2EprI575ha
	 An17lWc5uz85w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 13/27] mm/damon/core: introduce damon_report_exist()
Date: Sat, 21 Nov 2026 12:59:57 -0800
Message-ID: <20261121210013.130397-14-sj@kernel.org>
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
index 09f0dfbde8966..fc84cb9cf5bd9 100644
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
index 54e0ed6561c05..22028cdc0f03b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2388,6 +2388,52 @@ int damon_submit_report(struct damon_report *report)
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
+		if (idx)
+			idx--;
+		else
+			idx = queue->size - 1;
+		report = &queue->reports[idx];
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
