Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868C368D7F;
	Mon, 31 Aug 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187663; cv=none; b=FMQFnNSglfSbUy8d7S4K1kQRi1NGqoJBt97bXSL43QPnZrAj4TXVm0rF4iPbz2nGndsROQX32VEfSJxLgqi5gFhuy14xWQzOYfbuCntkaUFrjhdvlCQgQQi6GaTFBimABH2XNOMECCQ/in4Gf5e8gQYGpRQpA9VEAE8z08R18UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187663; c=relaxed/simple;
	bh=kEAyNHXTwDod8NgXdlV0AcwVMl/JMrysTsxpbtY9aCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thzlgH3BmkVnQMSfG7hkFUwkUHBjU0jhaQRijp8s/99GV9oFQmr8YhKd9++/ZQ7XLKOI1sM/7LG5YzHBFfed1s56lr2Tgu3cvFJB1H5eZ66bu3aRFVN8HC2w6JYI5QOZDtDMBw7vpKqRf2FWImpsgDX7ZXuA2IO36X5o1+16rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayKS20LB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayKS20LB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCA11F00A3D;
	Mon, 31 Aug 2026 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187661;
	bh=y7QxbQi+gC20oHgrgxjKQCFyg8T7bvReTsftzDUfUgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayKS20LBXIFl8eNB8eN8Ldo+Xx6A76IS7z/PhNTKyHRafXBFPrVQRCb5g/RSPghgQ
	 HRUqWyhztebBCMmmrxbWjs4B+ZNnQuNdtkVGFWkSv2RTJ23zJC8/v66iHXb436s7Ft
	 FttTfy6Y/XFrVrznJBcvlpNj6xkSe9uaCmabeVB6FSYSQ+BmeGRcYbJe28X6yk6gWB
	 oRHEJ5iSDX11osGi+YUCxlNtKx4/VVJvHORmAd1IDkXjw9Wlm3gejpibC8c/2ZGzmf
	 71RfK4ZigJQvcPRq2NqCD2njbNgCxxI0FgKE+HMCzmigvQnE2JkExguDLrQ4Cdting
	 lRWNHznwyaOFQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 1/3] mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
Date: Mon, 31 Aug 2026 07:47:28 -0700
Message-ID: <20260831144732.80910-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831144732.80910-1-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new DAMOS quota
goal metric to measure the amount of huge page consumption to total
memory consumption ratio.

Vmstat may lag, which in some cases may lead to NR_FREE_PAGES being
greater than or equal to the amount of RAM in the system. A guard is
added to avoid the extremely unlikely case [1]. In the case, return 100%
(10000 bp).

[1] https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5607f98ec6306..310509455db13 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -153,6 +153,7 @@ enum damos_action {
  * @DAMOS_QUOTA_INACTIVE_MEM_BP:	Inactive to total LRU memory ratio.
  * @DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP:	Scheme-eligible memory ratio of a
  *					node in basis points (0-10000).
+ * @DAMOS_QUOTA_HUGEPAGE_MEM_BP:	Huge page to total used memory ratio.
  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
  *
  * Metrics equal to larger than @NR_DAMOS_QUOTA_GOAL_METRICS are unsupported.
@@ -167,6 +168,7 @@ enum damos_quota_goal_metric {
 	DAMOS_QUOTA_ACTIVE_MEM_BP,
 	DAMOS_QUOTA_INACTIVE_MEM_BP,
 	DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
+	DAMOS_QUOTA_HUGEPAGE_MEM_BP,
 	NR_DAMOS_QUOTA_GOAL_METRICS,
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a5ea3e61e7f41..3fa1b096c8330 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3038,6 +3038,22 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
 	return mult_frac(inactive, 10000, total);
 }
 
+static unsigned int damos_hugepage_mem_bp(void)
+{
+	unsigned long thp, total_pages, free_pages;
+
+	total_pages = totalram_pages();
+	free_pages = global_zone_page_state(NR_FREE_PAGES);
+
+	if (total_pages <= free_pages)
+		return 10000;
+
+	thp = global_node_page_state(NR_ANON_THPS) +
+				global_node_page_state(NR_SHMEM_THPS) +
+				global_node_page_state(NR_FILE_THPS);
+	return mult_frac(thp, 10000, total_pages - free_pages);
+}
+
 static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		struct damos *s, struct damos_quota_goal *goal)
 {
@@ -3074,6 +3090,9 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 		goal->current_value = damos_get_node_eligible_mem_bp(c, s,
 				goal->nid);
 		break;
+	case DAMOS_QUOTA_HUGEPAGE_MEM_BP:
+		goal->current_value = damos_hugepage_mem_bp();
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
