Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA402848BA;
	Thu,  9 Oct 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044851; cv=none; b=WcQX5bTrokqZ6EN9gP5d45tGTuPnM+p0O+kyl+I6XGPyttIyodVpjg5c4mKDkNt6eHAoau1S4VC30EkCXeQfSf2/sv1AjRY5HpVhzlhzkg8Q5x48kh+AOS/i57WFdfHlUgu0ym+Czm77lamob2E+LB6WTFCveSmkuB5VPaRrNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044851; c=relaxed/simple;
	bh=MELVaEdB76EUyKbmw0NbQ1QbyTF6YUPeLThLKL8ekdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayIWcSAU4e/yYOl9v0KM2aX+cwcA/pZX0aasmP4bipkH6EaafioAUPqjDr47smhGConBoTa1XHZVAaIsxjMIb24k4ZWUmPnsdLOb9nABXZymOSIPs3Euj+X3x0brebck7ARRCTd/hVsb/Kux6by5LxaYgz2SF59kWzRmBs6Zvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ2h/KzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ2h/KzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DA5C4CEF5;
	Thu,  9 Oct 2025 21:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044851;
	bh=MELVaEdB76EUyKbmw0NbQ1QbyTF6YUPeLThLKL8ekdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZ2h/KzWkitVsziIxgaErvpPM9viuTpu0shAGsztfn/w1g7LyXyWlYKhhdz5QPSa7
	 qORE1jFoMNu7CtMBFlwtcu7CzXU4nc4FCaFs2xUBnclVOpdOb8AeIwe2mgJgPX7mha
	 197naWxHrdYB1uxa7Lr9cPe0bIUluaWJK0jU3rf+nHrwpUy/6SNlExHp1l6eiDwXQl
	 Ujo30TV9LJPaaQ50xinRxP8TXoReG7+YYOrkXHcBZ8LuAdLGn2BvQdX0Tg4pGDvw+j
	 43W2tj0aAnNgMFp/Pqjc/nPdKoAAU9i78kGGVNzwIHUvI6bANiF5RSBLmd0WyR3IIO
	 WMRnrlpDXHdGw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 03/10] mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Thu,  9 Oct 2025 14:20:35 -0700
Message-Id: <20251009212042.60084-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
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
 mm/damon/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 93848b4c6944..1eacf78aa358 100644
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
@@ -2032,12 +2033,46 @@ static __kernel_ulong_t damos_get_node_mem_bp(
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
 
 
@@ -2058,6 +2093,9 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
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
2.39.5
