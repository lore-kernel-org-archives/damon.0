Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534614;
	b=Md1eaiK6DxnirMcv/cxAdW6LutFfo/0vJtc9u1ej8LPMZH5/DQzMGv9bJpxJu0xtclBU
	 R2CAUicRDLiP3GJeclyk6vZvlC5pKl3AY8C2hRDQ9tlnjgYcUWlBR5K+Me5QuiZbeqfB4
	 5cxCNe0biV2mdg/emjVD2OmErvT56PuPvpCN2h6O24seT3hlWdJe9YA5jLbvgszEZqeHY
	 wl/GoUV4Owzf/gWRRhcLRWdXftNz0wPOQE588WV9pPYXAcPdjxREFOpcGLtS/Qaxxz5HQ
	 wBp8uDBhCMewov1uGoJZ4LTl5lBmYFoVSFbPhgQb2liD+d5wvWOttz/ZvNeP9rYiM3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534614;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jmuJ9Iv+Y2OebgTPBnuX4lcS/RA/z9b2R8kNSGeSvs0=;
	b=Wiyab+VzODlr2+oFpvTbSj7Opumhc+MAyRfOQBFbWbsKjj01aUJKgqnYYachPYiKLtsk
	 sULVOMbNWL41QrLW0ncjf3AyC8j0oUqG0lJ+MYUppDw1QKckQ5Q2mpumTi+NrbrFO1kz1
	 E1CVJuw3uCfkruE8gbjMK+JEWlvWZmOV0FQqCQvMw6IOH5BKeF7Qdc3LjGF/vEply0S7U
	 /Tps/sj8M0MazXMLfLg2p0ZAdsExEMLsPjMF39grP8Nn4bCADUojn8keIODhTnGHA0P2S
	 CyPbYmLntL8Ogx+H7B0btx0Uws4wfzM1GU0qAj9Pd29RRr+6DEtciqvGycmZHU5+lLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyRfAap0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6C606A321
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyRfAap0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4E91F000CF;
	Tue, 24 Nov 2026 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534613;
	bh=jmuJ9Iv+Y2OebgTPBnuX4lcS/RA/z9b2R8kNSGeSvs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyRfAap0A8L/LEIQXuaPvqvCJJXmBfce9s5HRgtnImaTQYDcikV4AVBzGjr+Orxyc
	 p0WaC1dkD0TFLyh/noPb8Svz4XltcfcmK4yYv6GxDwWOcOrgsQP4vubHa1XIeHuVHG
	 tJZamSUjIlWlbRQG+/Qmy3SRxGiH0iqXxRFAu7rDco0zTSeQVuL/4ZllqKOEKWQJgI
	 V5YzlWQz0jzg/qHZkLnqUVbSil7mqAQaW04S6VJSQapGnKlLkOi4TwI/QCDUB8G8mc
	 ezB6z9NbwlQRwWg6uGyispwvNLXEjC9NJxqSt5JRch0gH1WSJWdcUMY4F9dwSAgE11
	 6B9bkEo/Y1tgg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH v2 13/27] mm/damon/core: introduce damon_report_exist()
Date: Tue, 24 Nov 2026 07:36:19 -0800
Message-ID: <20261124153636.91854-14-sj@kernel.org>
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

Implement and expose a new DAMON API function for searching data
attribute reports from the report queue.  The purpose is to let
operation sets use it for supporting the REPORT_MADE type probe filters.

The caller can specify the type, associated memory address range, and
the creation time range of reports to search.

The function uses CAS-based try-locking for the mutual-exclusive
synchronization.  If any parallel access to the queue is detected, it
forgives searching.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  3 +++
 mm/damon/core.c       | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9f48f17969d03..38efa41b3d1ab 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1199,6 +1199,9 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_submit_report(struct damon_report *report);
+bool damon_report_exist(enum damon_report_type report_type,
+		struct damon_addr_range *addr_range,
+		unsigned long jiffies_old);
 
 int damon_set_region_system_rams_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d4a4aca4a831b..9e4c2f7fb5aa8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2392,6 +2392,52 @@ int damon_submit_report(struct damon_report *report)
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
