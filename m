Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB13328E9;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736435; cv=none; b=OK/gW1TWz8DwX5mmSRnQ6PtX15nxZgbl8dXi3uiI8otmCK43WJihgnFFhtG7FUBpwobyVC5445Bzj4vStyR5ZcEMk1iwmur82IIvFEFG2oNAlrm1H2a7T+6+ovmvZreueRWxWlOFC27ZF4F8Zq3DgLVS+y7QSc08KuLU1f1LH7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736435; c=relaxed/simple;
	bh=iAAhOa8iHX+RisUCri+NFUUzCjC4h64hfHQYSXDZ2Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGhNV2ZJwy1FKdAqpTT22ceiSmIA8q4nuPsdeq0cG6vC2DZfsBJp21aZttT79aP4Gf1h0PXytPPnQ5NOj2Am1kIM6RwpJz0P6Y4I8KYNQrv6uzctf3hgowCWRGgl+R+b/voCnhReK3EO0XauwtJtv+mG9pa5xVOxLaQjDi6+CJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClO42DOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClO42DOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D79EC16AAE;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736434;
	bh=iAAhOa8iHX+RisUCri+NFUUzCjC4h64hfHQYSXDZ2Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClO42DObtIDHCkighHiBPIiqG1Y9t1yUD0ZftzL3bpXV0fu1iIq6O8AWBs0LzK/r+
	 ibat0Nu5ckvHV+7FS9MbJ7OnU68VGC2GH6TO9uxb449RPNahkSUZ+CB91jLH6VqpmV
	 TFmQ0MG/rUkj7H790bGAUrHG5BuhOHJA4ZIGLBQ3HM3i1ZeFbw2NcuIFzCTmIANMZ2
	 Gdhg7NTkL4Aadq9MuV6C7UMAjDhcQXv/4O+WZYjav9pvKpZ3aXYhzsyUHqxn67DJSZ
	 UgP+NHEAHV6vhiKd6EKMFwYedkzxiHJyH5u2xeEZggrqJXEgG9thQNcms1OVPJN4cZ
	 Yap3I7wPv4x1g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/10] mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Fri, 17 Oct 2025 14:26:55 -0700
Message-ID: <20251017212706.183502-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the handling of the new DAMOS quota goal metric for per-memcg
per-node memory usage, namely DAMOS_QUOTA_NODE_MEMCG_USED_BP.  The
metric value is calculated as the sum of active/inactive anon/file pages
of the given cgroup for a given NUMA node.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dbe48e43682b..00f1686d767f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -10,6 +10,7 @@
 #include <linux/damon.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/memcontrol.h>
 #include <linux/mm.h>
 #include <linux/psi.h>
 #include <linux/slab.h>
@@ -788,6 +789,10 @@ static void damos_commit_quota_goal_union(
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
 		break;
+	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+		dst->nid = src->nid;
+		dst->memcg_id = src->memcg_id;
+		break;
 	default:
 		break;
 	}
@@ -2035,12 +2040,46 @@ static __kernel_ulong_t damos_get_node_mem_bp(
 		numerator = i.freeram;
 	return numerator * 10000 / i.totalram;
 }
+
+static unsigned long damos_get_node_memcg_used_bp(
+		struct damos_quota_goal *goal)
+{
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+	unsigned long used_pages;
+	struct sysinfo i;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_id(goal->memcg_id);
+	rcu_read_unlock();
+	if (!memcg) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+			return 0;
+		else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+			return 10000;
+	}
+	mem_cgroup_flush_stats(memcg);
+	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
+	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
+	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_ANON);
+	used_pages += lruvec_page_state(lruvec, NR_ACTIVE_FILE);
+	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
+
+	si_meminfo_node(&i, goal->nid);
+	return used_pages * 10000 / i.totalram;
+}
 #else
 static __kernel_ulong_t damos_get_node_mem_bp(
 		struct damos_quota_goal *goal)
 {
 	return 0;
 }
+
+static unsigned long damos_get_node_memcg_used_bp(
+		struct damos_quota_goal *goal)
+{
+	return 0;
+}
 #endif
 
 
@@ -2061,6 +2100,9 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		goal->current_value = damos_get_node_mem_bp(goal);
 		break;
+	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+		goal->current_value = damos_get_node_memcg_used_bp(goal);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
