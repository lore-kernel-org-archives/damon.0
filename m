Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54928936B;
	Mon, 16 Jun 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094634; cv=none; b=ozV/cGJ5nfI2LjPTKRiw8tx/7XoeUwuFw5nkUimW3+c7PDSNVpO/5IqOBRSBubXxLdFDdFq2vgMuK6YwAkMI3L9/J47mg2UHX34RoqPi31IQ59kI8+FgxnWiDBGlOXDD4LxfklF7ulUHb9IdsjpbVSn2g8q5oMB1DpC9XlLlsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094634; c=relaxed/simple;
	bh=/jZrQ9S1/qKDrhEa24isAWnQHzj9GQjAjLTNE9pKE2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFvmisgn7s9TNpCm7X8l5Ecxv+PCw0MjgG83wlreB38vl0PNy60YL6SkR0ullYIIvRy6EiwMgV0IQeHmgYkxCpV37fVn0UUFlmKmblkWP3tvtLq61reWwBeWM5gme8rv2UHH25zTvSwZS/f0tqQ0wXQDFFTRphy6jvZh3eKKIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWTjQjS9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWTjQjS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBC8C4CEF4;
	Mon, 16 Jun 2025 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750094633;
	bh=/jZrQ9S1/qKDrhEa24isAWnQHzj9GQjAjLTNE9pKE2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWTjQjS9OREK8EWUzjoQa7VWHP+QHa8ZXxQ/EMPS1ieWcV0CxI0SlDnsuojqQqgGN
	 zY6dSApgSD08wg5HPYrDIV4TNwSyI929S7qSj+filcsX+r8s5PlKtErBM4nRmSH2gL
	 ZQwzCiDwzLJSdAErNStpbvvejPBySymv9zO72+e/vUcCzgyFrEqgZJlRZGjeBH69dU
	 /gZFvr8xNPwzO6+Yxup0D3x41hFxITQer7aT0rPZ7bIuruVJJSklKoi9WV71Z3wBq6
	 +fBbE7g5EHtTjh4scICSo0jew4Of8R7ItRWW6o2GJPiwlkL1/6jF7wnbp21HKESpCl
	 XRmNxXpYC16DA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] Revert "mm: make alloc_demote_folio externally invokable for migration"
Date: Mon, 16 Jun 2025 10:23:46 -0700
Message-Id: <20250616172346.67659-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616172346.67659-1-sj@kernel.org>
References: <20250616172346.67659-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a00ce85af2a1be494d3b0c9457e8e81cdcce2a89.

Commit a00ce85af2a1 ("mm: make alloc_demote_folio externally invokable
for migration") was made to let DAMOS_MIGRATE_{HOT,COLD} call the
function.  But a previous commit made DAMOS_MIGRATE_{HOT,COLD} call
alloc_migration_target() instead.  Hence there are no more callers of
the function outside of vmscan.c.  Revert the commit to make the
function static again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/internal.h | 1 -
 mm/vmscan.c   | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index aedcf95737ed..746fa4187e9e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1227,7 +1227,6 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-struct folio *alloc_demote_folio(struct folio *src, unsigned long private);
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6bebc91cbf2f..620dce753b64 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1006,7 +1006,8 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-struct folio *alloc_demote_folio(struct folio *src, unsigned long private)
+static struct folio *alloc_demote_folio(struct folio *src,
+		unsigned long private)
 {
 	struct folio *dst;
 	nodemask_t *allowed_mask;
-- 
2.39.5
