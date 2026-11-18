Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968557;
	b=xiACIY280CEkRnM/FTthCzJYf4luX9OwL3l2ZRuZGQy/wLgqNbrgdqpKd7OtXQrZHXci
	 GOJ0EevIOIX55HCZPBRICEYC6HtgWUpK9bC+H+nGNxjf2nNpRklgst3BnT6gTxCl9eN1t
	 CJkrmIqZ+AQWDzSwYfs4Sn5GIlaBbVfycWzou4sI6yvIB2QqZgkPW8H5yWjU/9Ec89/WO
	 lpNJZn620I6QKQK0TZZPKs0scCriXP8RPUln7Ut+UiAdxiHv3/PDUNKKUz8KMQNlucAaR
	 nxi3IlcOf5J8x7+sQdc9FWrfoRdpOCsdr5fkFuO9n9Tyat9iA71KwDpQGW6CFzrLUAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=X2CJN5Z4knyWoRn+4HcxQAux1m0Ndp9v4aXp0+mY1es=;
	b=VJ5JfVhZ210Grs+a1hsDIQhQyXi7b8G4o1nS9UZSwPMKk5P2x7z/d7JpcDpIEclikxYJ
	 Eu11oZAJkIlSHYVPjE1/zvO9hGr5BLYEuX3c4+m1ZS917uLCxKYv7N8hZNYoMlBYd7Px7
	 Z9OxZnaL6XCJeirq2Ifp1lBInwmeY27cPjsc9tAtWwBjKGo1uEbsqTxvWgIUrt7chtV1I
	 mMFg+A4MuakHjh13CffIbrSZEW0Gs4+oNNF+ILxqmkIoSvcLJjdWloGm9Ci8LmCz5PsEs
	 t9RK8xWt4fPgIrLznaRZqBI6AYLhiSQCEUzKJLZptYaJRBNUEay80dCK4mcXGWCPZ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBm1PT2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343C60A263A;
	Wed, 18 Nov 2026 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBm1PT2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ADE1F000D2;
	Wed, 18 Nov 2026 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968557;
	bh=X2CJN5Z4knyWoRn+4HcxQAux1m0Ndp9v4aXp0+mY1es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBm1PT2CZVlNnta4Yjgf2hz8Rhy1eICxrk9vhUOOR5D0IDgx/LDc/TUZfCaFQJFQj
	 wNFuXL8Rp5LhsOUzMkO9XrfC6H5oIxdvBQj4Pu3Q2I+5XIbggwskFwFDY9XXK1bOmL
	 A9BbepvVMFw2aMhq7l704S/1Q+DC1lIacrC1EX9mZLAP3UMfFhaMMslZZj/6Xniu1n
	 zEvgR/tf8o6gpTSrJlKbvHL4utgggelCtlKwiEHTU2xQAauK3qI7OflE0mJ4lkBcPK
	 2DdbIOvxHP+AbFLMWTdO/RpHC72TP2ErwvcRIZpRed5qC8vkujC0OVtKevUgpNDBFf
	 ETilah6IwObJQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 13/27] mm/damon/core: introduce damon_report_exist()
Date: Tue, 17 Nov 2026 18:22:08 -0800
Message-ID: <20261118022225.100659-14-sj@kernel.org>
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
index 24729be5ec4e6..4aa4852f51035 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2389,6 +2389,52 @@ int damon_submit_report(struct damon_report *report)
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
