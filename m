Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE93783C0;
	Tue, 21 Jul 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642182; cv=none; b=u05oXymyzJ41S/7exxQOE60MEzsdFSttP9pZ+YdJJ/j/taQJ0+UNerysCSpmt1YFXVJ+Y7cmPg0yjzlEP+v5yvlks72u34IJKQBquh4Vw520IVY4xWrclhb3MgiplXBvAE+KoHm/vUtDmAR4uZk9ilk1e13kS4Vr8tdXisJeIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642182; c=relaxed/simple;
	bh=w/vVqbaqqJy0J6y1OJBZkEuvzCz4Yfj7iZkD98+O2+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3R81kZ85FQMgbPkELNa21chORkupM2ZNenslDZIKqC9gjgJecq7nE3+z3AnHmkF9nzzaxyCMFhyVcljPFI8DLwCzTjBtb9MTxhxlrt0D873N3QxptYDkIbyzw8Qb2e6CHiY0cVBa328lvPqeQyhX9ZWIxOqm6A9YG4HbfeNY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1MxEouC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1MxEouC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F521F000E9;
	Tue, 21 Jul 2026 13:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642180;
	bh=wx1gw6+GLyRkHpuisMzwe8oKVgfcuzn07HyWYBTylME=;
	h=From:To:Cc:Subject:Date;
	b=E1MxEouCn0tQO0qIvUIxCc4Srw81qZl/tXHF42jtBKAUf3G6f1MyWjNpVxJFaiR1q
	 03z3tjrgIzEgkzBe+dYBDRWKqaL6K/VMb5p8bRJN68W1riaM5QtBNetqwbOOTUt6Xc
	 NcRstO2h6xuU3y8NkSSK2ouVf6Ixg37uwVMZcR4xwITYgSgtb0XEyCsyZh0su974Y0
	 4W01kYWVpC6kywRwk8SMwi6EZ24+KALq0zLZTLiE3X/ngMGG9h4jZY4cjcgyzPSIWT
	 2wyxcYbQQam46KtdRw9OmbPGoSKsS8IPjUMgp/a6yGZzYcDZZbcuosxCJ24wuAtxcs
	 srkR/GMEzelOQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiahui Zhang <jiahuitry@outlook.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3] mm/damon/ops-common: prevent migration fallback to non-target nodes
Date: Tue, 21 Jul 2026 06:56:05 -0700
Message-ID: <20260721135607.251869-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiahui Zhang <jiahuitry@outlook.com>

DAMOS_MIGRATE_{HOT,COLD} passes a target NUMA node to migrate_pages().
But alloc_migration_target() only treats mtc->nid as a preferred node
unless __GFP_THISNODE is set.  Hence target allocation can fall back
to another node, and migrate_pages() can report success without placing
the folio on the requested target node.

Consider a two-node tiered system where node 0 is a fast tier and node 1
is a CPU-less slow tier such as CXL memory, and the user wants to promote
hot regions from node 1 to node 0 with a command like:

  sudo damo start --ops vaddr --target_pid ${workload_pid} \
      --damos_action migrate_hot 0 \
      --damos_access_rate 70% max

Without the __GFP_THISNODE flag, when the memory allocator finds that
node 0 is nearly full, it can fall back to node 1 without waking up
kswapd.  Then the pages allocated for migrate_pages() are still on node 1,
and the regions that are expected to be promoted to node 0 are only moved
to different physical pages on node 1.

Meanwhile, both the mm_migrate_pages tracepoint and DAMOS's own
sz_applied statistics (reported via the damos_stat_after_apply_interval
tracepoint) show the migrations as successful, which makes the failure
practically invisible and hard to investigate.

Running a demotion-purpose DAMOS scheme alongside the promotion scheme
does not fully avoid this either. If demotion cannot keep up with the
promotion rate, allocation can still fall back to node 1 during
promotion, and the same misleading statistics show up.

Make DAMON's migration target allocation strict by setting
__GFP_THISNODE, so that a failed allocation on the target node is
reported as a failure instead of silently landing on a different node.
This is consistent with alloc_misplaced_dst_folio(), alloc_demote_folio(),
and with do_move_pages_to_node(), which all use __GFP_THISNODE for
migrations to an explicit destination node.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Jiahui Zhang <jiahuitry@outlook.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/ <MN2PR02MB665479119535A1235D69F125B5F92@MN2PR02MB6654.namprd02.prod.outlook.com>
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
Changes since v1:
- Use the mm/damon/ops-common subject prefix.
- Describe the observed misleading migration accounting and how strict
  target-node allocation resolves it.
- Use the formal author name.
- No functional/code change from v1
- Link to v1: https://lore.kernel.org/damon/BY5PR02MB6642F4D1A8BA92BFF3A034B4B5FF2@BY5PR02MB6642.namprd02

 mm/damon/ops-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index d7d7f100389b0..e59f77eca83b2 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -312,7 +312,7 @@ static unsigned int __damon_migrate_folio_list(
 		 * instead of migrated.
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
-			__GFP_NOMEMALLOC | GFP_NOWAIT,
+			__GFP_NOMEMALLOC | GFP_NOWAIT | __GFP_THISNODE,
 		.nid = target_nid,
 	};
 

base-commit: 86e9ddaf85a3e872e81e1946ed410ef7f5341e16
-- 
2.47.3
