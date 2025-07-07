Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1A91DE89B
	for <damon@lists.linux.dev>; Mon,  7 Jul 2025 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932772; cv=none; b=QAtaiADR4zDNXtVywZ+ETZIvof1nyrJPUVr9F3/vq1H8P9fOw2htv+fxj9dOrwZgUVmyDgPXsEcwD7dbZkPSPmF7VCOyeQKGbzA9nmGfGwEj1O/ud6GIJhgP7iTnBxVJNIQ1IQbzVdMMIkVdXNp5EZEoDn6n9grcmRVbKz1nbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932772; c=relaxed/simple;
	bh=9TPB+g+JoPTu4/JK69/M1AVaIPgci0HbXXG4H96heEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiquHMTLZpqsG1ND9/J5gkg4fSKF5dSPjGtot7hGlbTCU0870OfhDnJXpa+p6DkQJKeSHtCLsjotAZuZfi5k4jbWBSciHlB3Z7rbjtOx6mWLuBsRJz9DUjZ8VMjdGr5lJ7dXQi5evXaqQRkjvYLI8Q3QYeSynuHoaABcfhst+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c0-686c5f599e4b
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: [PATCH v4] samples/damon: support automatic node address detection
Date: Tue,  8 Jul 2025 08:59:18 +0900
Message-ID: <20250707235919.513-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsXC9ZZnoW5MfE6Gwe8zhhZz1q9hs3jy/zer
	xeVdc9gs7q35z2px+OsbJgdWj02rOtk8Nn2axO5xYsZvFo8Xm2cyenzeJBfAGsVlk5Kak1mW
	WqRvl8CV8WPfCeaCdsmK5g7+BsYm0S5GDg4JAROJHR8tuxg5wcxTZ14yg9hsAhoSBw+dBLNF
	BAQl+h/PYO1i5OJgFpjLKHHkzHtGkISwgLfEwb+32UBsFgFViZ5Js1lBbF4BM4krRzYzQwzV
	lGi4dI8JIi4ocXLmExYQm1lAXqJ562xmkKESAn9ZJeZMfsoG0SApcXDFDZYJjLyzkPTMQtKz
	gJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgoC2r/RO9g/HTheBDjAIcjEo8vAe2ZWcIsSaW
	FVfmHmKU4GBWEuH9EZGTIcSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFq
	EUyWiYNTqoFRM2a3ykpJpRsbnrzdtjD5+P6TbxZ71orPW3zydFq853WOLc3vvY7NqX1w/lMS
	1085hz1LLiU9mVVaFFW7x/r3ja7N0mfuaTA3PIrXXvfB4qdy5e5jtzOc4vtTDz59tT571q6m
	Jpa//78bb6ue+CGgXydJzuDLVL22BWkPHxnarm6M/vd5uu/uYCWW4oxEQy3mouJEAALfdpAw
	AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LhmiGroxsZn5Nh0DPPyGLO+jVsFk/+/2a1
	+PzsNbPF4bknWS0u75rDZnFvzX9Wi8Nf3zA5sHtsWtXJ5rHp0yR2jxMzfrN4vNg8k9Hj220P
	j8UvPjB5fN4kF8AexWWTkpqTWZZapG+XwJXxY98J5oJ2yYrmDv4GxibRLkZODgkBE4lTZ14y
	g9hsAhoSBw+dBLNFBAQl+h/PYO1i5OJgFpjLKHHkzHtGkISwgLfEwb+32UBsFgFViZ5Js1lB
	bF4BM4krRzYzQwzVlGi4dI8JIi4ocXLmExYQm1lAXqJ562zmCYxcs5CkZiFJLWBkWsUokplX
	lpuYmWOqV5ydUZmXWaGXnJ+7iREYSstq/0zcwfjlsvshRgEORiUe3gPbsjOEWBPLiitzDzFK
	cDArifD+iMjJEOJNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCU
	amA8uNWsNVD1pq3UBF6Dnd0tKWodFlsMpacfXZCl+8rG2KrisOG+0AluEwLenXdV0/6zNuVv
	DrPLimaZ6tkGudX9GUtfNE23YU2265RT+yrocmWOyJT/lyaKr1yozKn09dRqh9MCJptP758r
	8zSHse2qlhTT4t16Gx88XrJh04LmGtkpCRNP1scqsRRnJBpqMRcVJwIAT1G90SECAAA=
X-CFilter-Loop: Reflected

This patch adds a new knob `detect_node_addresses`, which determines
whether the physical address range is set manually using the existing
knobs or automatically by the mtier module. When `detect_node_addresses`
set to 'Y', mtier automatically converts node0 and node1 to their
physical addresses. If set to 'N', it uses the existing
'node#_start_addr' and 'node#_end_addr' to define regions as before.

Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
---
v3 -> v4: Cleand up the 'nid_to_phys' function code
RFC v2 -> v3: removed an unusable comment
RFC v1 -> RFC v2
- dropped the second patch as the newly added knob is no longer needed.
- added a new knob 'detect_node_addresses'
- renamed the function for clarity: numa_info_init -> nid_to_phys
- cleaned up code

v3:
https://lore.kernel.org/all/20250707023135.453-1-yunjeong.mun@sk.com
RFC v2:
https://lore.kernel.org/20250703074423.1771-1-yunjeong.mun@sk.com
RFC v1:
https://lore.kernel.org/20250701085417.1734-1-yunjeong.mun@sk.com
---
 samples/damon/mtier.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index f3220d6e6739..2513f0707986 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -42,8 +42,29 @@ static bool enable __read_mostly;
 module_param_cb(enable, &enable_param_ops, &enable, 0600);
 MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
 
+static bool detect_node_addresses __read_mostly;
+module_param(detect_node_addresses, bool, 0600);
+
 static struct damon_ctx *ctxs[2];
 
+struct region_range {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+static int nid_to_phys(int target_node, struct region_range *range)
+{
+	if (!node_online(target_node)) {
+		pr_err("NUMA node %d is not online\n", target_node);
+		return -EINVAL;
+	}
+
+	range->start = PFN_PHYS(node_start_pfn(target_node));
+	range->end  = PFN_PHYS(node_end_pfn(target_node));
+
+	return 0;
+}
+
 static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 {
 	struct damon_ctx *ctx;
@@ -53,6 +74,8 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
+	struct region_range addr;
+	int ret;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -82,9 +105,17 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	region = damon_new_region(
-			promote ? node1_start_addr : node0_start_addr,
-			promote ? node1_end_addr : node0_end_addr);
+
+	if (detect_node_addresses) {
+		ret = promote ? nid_to_phys(1, &addr) : nid_to_phys(0, &addr);
+		if (ret)
+			goto free_out;
+	} else {
+		addr.start = promote ? node1_start_addr : node0_start_addr;
+		addr.end = promote ? node1_end_addr : node0_end_addr;
+	}
+
+	region = damon_new_region(addr.start, addr.end);
 	if (!region)
 		goto free_out;
 	damon_add_region(region, target);

base-commit: db16fe88cdf83a1e7fdf75de282025b6ad61d08f
-- 
2.34.1

