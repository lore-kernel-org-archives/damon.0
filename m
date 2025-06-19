Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BE28DF3F;
	Thu, 19 Jun 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370432; cv=none; b=UlzrAtxZRMPN0TTDiOJcz0t/wSio3MpsTO7ougLQ3TfuveV6KCPx/O5R+ONh9CoQAOK/LHAYR/1PK2ef+An0Xv+Hq+AinyBIR6gxljbPqw74BU5rOgAAnhTKPhBHcvfcSue4jJSymin3l1J61r/HGjdEPfE4tDbMOoUZsvE7ucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370432; c=relaxed/simple;
	bh=ruhTjHTMSB8Frh5X86EoKCSKXfbBH40pNj+dni3HQq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KROiDWR/2pwO91/pyCP4bYxP1UqjH68Gvs4bkGDzcsvy+aUP7LEypXgUyZxJO1fUSgUSKI+PeNBWTixyP9qmY1YaU+IzdDZ4ofUzCvazEB5c8NYFgiubxNxL7WZ+LXGfmWYAtpXqIZurFbTpJ/bIo8y4wniSdbRs4hSeB3obR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfG/klgG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfG/klgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0497AC4CEEE;
	Thu, 19 Jun 2025 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370432;
	bh=ruhTjHTMSB8Frh5X86EoKCSKXfbBH40pNj+dni3HQq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfG/klgGxqXrLNWew9LBj2e/nPIoTPalafzZNhcp5HHVKp3iKRRBIKkCWni+DGv0N
	 0Qi4/5YUWVavIluMjGGfBilOoxFMa/oxaniOd/mFbpKwZL+xPcyDyr3S4JIwT8QUtG
	 CWVpyijK7Kf71gE10l5V9dHg5zh8cD6WW5gY7bwsUA0WtxLspMBnFc7Oi7zxMyfldk
	 4ZsdXXNAxy5US69ahqQEwBf2dK47GeLKlOOkkaRHawCaUysqJaMfMtO34yVs/8jKML
	 fSh8drtWw48On8wB2lHgXhOt74KwLRi3xEqtChhkszltN5kV1fRVJ/IAz3Sd5hkw1t
	 ScbDALkDkkNSQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/11] mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Thu, 19 Jun 2025 15:00:15 -0700
Message-Id: <20250619220023.24023-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the behavior of DAMOS_QUOTA_NODE_MEMCG_USED_BP.  It uses sum
of active/inactive anon/file pages of a given cgroup on a given NUMA
node as the value of the metric.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d675dd932a23..1481b43f2710 100644
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
@@ -2021,12 +2022,40 @@ static __kernel_ulong_t damos_get_node_mem_bp(
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
+	mem_cgroup_flush_stats(memcg);
+	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
+	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
+	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_ANON);
+	used_pages += lruvec_page_state(lruvec, NR_ACTIVE_FILE);
+	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_FILE);
+	rcu_read_unlock();
+
+	si_meminfo_node(&i, goal->nid);
+	return used_pages * PAGE_SIZE * 10000 / i.totalram;
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
 
 /*
@@ -2062,6 +2091,9 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		goal->current_value = damos_get_node_mem_bp(goal);
 		break;
+	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+		goal->current_value = damos_get_node_memcg_used_bp(goal);
+		break;
 	case DAMOS_QUOTA_ACTIVE_MEM_BP:
 		goal->current_value = damos_get_active_inactive_mem_bp();
 		break;
-- 
2.39.5
