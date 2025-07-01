Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B761F09B6
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360069; cv=none; b=dC9H5FSr/6CR2OYYdpKyVQVwWlxb0weUXPIq5i75dH9EbEPkN1WTLLcicgn1D8xXlenvOwaTyIkUJt+rlH686gtTA1KYt72UZ45KrwMKpJleiYDZPChJ34F5gCLDl0cvQ5aPwm5pd2O4KBbsP+R+iv8N+s1C8NOQfXvkOWuIF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360069; c=relaxed/simple;
	bh=xjsDLviCMZ90RGdFmxb8JDPchjfBIj2HcS+DC4HKAvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaLvLKPL3/L5EZs1Vce7gpqoujuzy1w6iOwusFFd65I8EBCYDA9tzK9aE4d5GU3YHQjBmkFYvneD10jCQ1NrTq7o4I+Zu9VaOEFs6461kHji5F5XjYUDiml/iSYN+DrILRINdOajGRFKBlQzn1SUpHxPiGWkxCZr4gxF+y9ee+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-77-6863a23d4bd5
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: [RFC PATCH 1/2] samples/damon: convert node id to physical address
Date: Tue,  1 Jul 2025 17:54:16 +0900
Message-ID: <20250701085417.1734-2-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250701085417.1734-1-yunjeong.mun@sk.com>
References: <20250701085417.1734-1-yunjeong.mun@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsXC9ZZnka7touQMgzWd0hZz1q9hs3jy/zer
	xeVdc9gs7q35z2px+OsbJgdWj02rOtk8Nn2axO5xYsZvFo8Xm2cyenzeJBfAGsVlk5Kak1mW
	WqRvl8CVcWn/JcaCKxIVe48uYWlgvCvSxcjBISFgIjF9g3QXIyeYuXzNHUYQm01AQ+LgoZPM
	ILaIgKBE/+MZrF2MXBzMAnMZJY6ceQ9WJCzgLXHm8j0mEJtFQFViQ9NPZpCZvALmEjOuSkHM
	1JRouARRwilgIXFi5jOwViGgkvt/57OD2LxA80/OfMICYjMLyEs0b53NDLJLQmAGm8SlPXvZ
	IQZJShxccYNlAiP/LCQ9s5D0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGJjLav9E72D8
	dCH4EKMAB6MSD++Mk0kZQqyJZcWVuYcYJTiYlUR4+WSTM4R4UxIrq1KL8uOLSnNSiw8xSnOw
	KInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUw5mxrd3mjeZ17gmUMS/q2Cxu2OvjvViyY5fCZ
	+90eZw3ju/wbPK8K1YqsY6xr5Pdpumy8TOEfe0hMXyC3yPLQfxwnnuf+mK/8Qrzzkthtr+9F
	/t0Lbv0R339+kXT2ZPYllSVpfxsfBD0+8VZUxuKE2PJ3HIx9p6bqtqa6dPzeI9/Fm/PYcmOe
	EktxRqKhFnNRcSIAeg4lF0gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXCNUNWR9dmUXKGwZIOC4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4vGsOm8W9Nf9ZLQ5/fcPkwO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGpf2XGAuuSFTsPbqEpYHxrkgXIyeHhICJxPI1
	dxhBbDYBDYmDh04yg9giAoIS/Y9nsHYxcnEwC8xllDhy5j1YkbCAt8SZy/eYQGwWAVWJDU0/
	gRo4OHgFzCVmXJWCmKkp0XAJooRTwELixMxnYK1CQCX3/85nB7F5geafnPmEBcRmFpCXaN46
	m3kCI88sJKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIbesto/E3cwfrnsfohR
	gINRiYfXIC8pQ4g1say4MvcQowQHs5IIL59scoYQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w
	1AQhgfTEktTs1NSC1CKYLBMHp1QDo/LsG0uFvXTzv5a3Kt67enHD547zS2aVJM1PmNCdrhgw
	69qqyHB+C4EHeR7bNSZ1xnlfd7k6+eXnktMOhX5y7oynvkQc+y2SdH03x1ThWRp7nquG8Vvw
	P/40u+zatL5bMmq2b7Mnxa049LHDQIPbirlFd5YQp+pjs4RqhnavsGWftXJclA6oKbEUZyQa
	ajEXFScCAFC0k705AgAA
X-CFilter-Loop: Reflected

This patch removes the `node#_start_addr` and `node#_end_addr` knobs,
and introduces logic for converting numa node id to physical address.
It only checks whether a numa node is online and calculates the
start and end addresses of the node. It does not verify whether each
memory block within the numa node is `usable` or part of `System RAM`,
as performed by `damo` [1],[2].

[1]
https://github.com/damonitor/damo/blob/v2.8.5/src/damo_pa_layout.py#L72-L90
[2]
https://github.com/damonitor/damo/blob/v2.8.5/src/damo_pa_layout.py#L92-L10

Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
---
 samples/damon/mtier.c | 44 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index f3220d6e6739..ba6938a89c21 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -12,18 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-static unsigned long node0_start_addr __read_mostly;
-module_param(node0_start_addr, ulong, 0600);
-
-static unsigned long node0_end_addr __read_mostly;
-module_param(node0_end_addr, ulong, 0600);
-
-static unsigned long node1_start_addr __read_mostly;
-module_param(node1_start_addr, ulong, 0600);
-
-static unsigned long node1_end_addr __read_mostly;
-module_param(node1_end_addr, ulong, 0600);
-
 static unsigned long node0_mem_used_bp __read_mostly = 9970;
 module_param(node0_mem_used_bp, ulong, 0600);
 
@@ -44,6 +32,28 @@ MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
 
 static struct damon_ctx *ctxs[2];
 
+struct region_range {
+	phys_addr_t start;
+	phys_addr_t end;
+};
+
+static int numa_info_init(int target_node, struct region_range *range) {
+
+	if (!node_online(target_node)) {
+		pr_err("NUMA node %d is not online\n", target_node);
+		return -EINVAL;
+	}
+
+	/* TODO: Do we need to support more accurate region range?  */
+	unsigned long start_pfn = node_start_pfn(target_node);
+	unsigned long end_pfn   = node_end_pfn(target_node);
+
+	range->start = (phys_addr_t)start_pfn << PAGE_SHIFT;
+	range->end  = (phys_addr_t)end_pfn << PAGE_SHIFT;
+
+	return 0;
+}
+
 static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 {
 	struct damon_ctx *ctx;
@@ -53,6 +63,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
+	struct region_range addr;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -82,9 +93,12 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	if (!target)
 		goto free_out;
 	damon_add_target(ctx, target);
-	region = damon_new_region(
-			promote ? node1_start_addr : node0_start_addr,
-			promote ? node1_end_addr : node0_end_addr);
+
+	int ret = promote ? numa_info_init(1, &addr) : numa_info_init(0, &addr);
+	if (ret)
+		goto free_out;
+
+	region = damon_new_region(addr.start, addr.end);
 	if (!region)
 		goto free_out;
 	damon_add_region(region, target);
-- 
2.34.1

