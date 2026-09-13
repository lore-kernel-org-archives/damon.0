Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C337C927;
	Sun, 13 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319504; cv=none; b=kYqVE3D8CbR9/kW3Ht7XNkdVucDB8fqcVrqwjvXTvxpQnE23A+cagFT+lIt5vTGZl4TOSBB1sJVXFtdw7LR8Bvv0CRrzCVtLY5XzePfpQgHwNLF2KVb9bmpDjfy7H2hZeiIPwUIoDNu2pZqoxGmJoPDMYpTN9VTrk2NVOnyp3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319504; c=relaxed/simple;
	bh=D6BHBRxeaxnmXjOk/qO0eNxWnxIZGdfq5CY6QwIgMmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IejMv/O/egeyQplpMxu+kPe0f54TOYD6BOL/xUxmKltVDuUxkos8aCjbl7FpK0IHOuywMYd7g52BtxM+ib9gVimlHdb534jaFnTB+GjCzi4qhqlet9cECihJxGn5r9bJVAQBSDLNZ4aPNUPLXCNvUenSMYI7FOYc/upqptDg+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtpSJuGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtpSJuGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3931F00898;
	Sun, 13 Sep 2026 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319503;
	bh=WsrL2oFK9840WoIrM7QJPBsnHu9HVCMK1ZcOyqnJN44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CtpSJuGTPgqTlFmj05Uz0j8VHGqk2zb3TqX9YBZ1LJs8dgeSMQoqsxMQTrEiSVHJd
	 oskQcoOPLIJzBYIVOPfGFwIbteGteElEN4qaABZ3KK6WUoXy56rwVsMSlRfHK/l4d4
	 0T8lkofqxYK48n0Nj+jJxv/75zFEP+gmLLYEEn67AO1dnB6CWCOfwbE7pAx/yV+v56
	 a5W5+HcLAdeCzBlV6v7I3AtvLRbYr4QTdqp3kTi3yIaaApNbDkBROGxXLY/hFXb9MB
	 Nyr/+tn0womjaocaw7Hg5e4myo4WsM5P1sABle6dqmQZjzM6k9RZkrAIf/CZumeu/w
	 j2/Irfe8hNaRA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Sun, 13 Sep 2026 10:11:25 -0700
Message-ID: <20260913171133.102366-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ops-common data attribute filter matching logic to support
hugepage_size filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index c36cc39cd2c70..77366f42b3e5b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -536,6 +536,7 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 {
 	bool matched = false;
 	struct mem_cgroup *memcg;
+	size_t folio_sz;
 
 	switch (filter->type) {
 	case DAMON_FILTER_TYPE_ANON:
@@ -558,6 +559,15 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		folio_sz = folio_size(folio);
+		matched = filter->range_min <= folio_sz &&
+			folio_sz <= filter->range_max;
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
