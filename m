Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0776298994
	for <damon@lists.linux.dev>; Thu,  3 Jul 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751528673; cv=none; b=BV6wsyRXm4pakhxFMTZVjooagdWH7HqeR9qSzRLAv7NxGIl875LMllzuRa8IBjE1Plj0FgtaZKhzcEFRStlSYMfBic+CR4udquiRO+TS2eJqFWv8xp4n5G2XknLLwdKbZLFuSkQXZlnQ77Z8xS6GT0ZS1MgfFV9o8Fhaw+fHp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751528673; c=relaxed/simple;
	bh=HuV4dUjWZcpBPz2c+z1siCPYRCnL7RLudPhnu8CDck0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9V/TFWscy9+oG2PDRhSxqm8Xwx9YEGSOIP8D4XxR//oTB5NkMje5MtRKAXh11/8GSIJ31vZmKlbQ1eFipfXFaNbymP2ziOwebM1TsIiGw06vo8uN3tyd9rbklGPUMW1GldyKWoVzi9RXx1+YAM71JXwSNtq/x+w/s/Xr+NCPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-5b-686634dad43e
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: [RFC PATCH v2] samples/damon: support automatic node address detection
Date: Thu,  3 Jul 2025 16:44:22 +0900
Message-ID: <20250703074423.1771-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsXC9ZZnoe4tk7QMgwfNChZz1q9hs3jy/zer
	xeVdc9gs7q35z2px+OsbJgdWj02rOtk8Nn2axO5xYsZvFo8Xm2cyenzeJBfAGsVlk5Kak1mW
	WqRvl8CVMeFIL2vBb9GKD9tZGxgXC3UxcnJICJhI3Fs8gR3Gbrx+mhnEZhPQkDh46CSYLSIg
	KNH/eAZrFyMXB7PAXEaJI2feM4IkhAX8JZavn8MKYrMIqEpsmX2VDcTmFTCXmHf5CiPEUE2J
	hkv3mCDighInZz5hAbGZBeQlmrfOZgYZKiHwl1Xi5oUZUA2SEgdX3GCZwMg7C0nPLCQ9CxiZ
	VjEKZeaV5SZm5pjoZVTmZVboJefnbmIEhtqy2j/ROxg/XQg+xCjAwajEw+sgn5ohxJpYVlyZ
	e4hRgoNZSYSXTzY5Q4g3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgs
	EwenVAPj1B4ZGYd5/dLnbPZuyhXYN9HNY8euby3G5a/ONCy4pFQzYXbKpeS45RM70mP7mm48
	W3FVZCrrpdmtsuayzx/tP/LiT+ol3bpkiRCufZVrsngvXEkWDjcTlbs5o7U4bsaP7RHXXtrr
	13o9MUopvq4txD2BK/PLYkb9E68/il7T9Jdt/PBwSluNEktxRqKhFnNRcSIAGenK3zECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LhmiGro3vLJC3D4OcNTos569ewWTz5/5vV
	4vOz18wWh+eeZLW4vGsOm8W9Nf9ZLQ5/fcPkwO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGhCO9rAW/RSs+bGdtYFws1MXIySEhYCLReP00
	M4jNJqAhcfDQSTBbREBQov/xDNYuRi4OZoG5jBJHzrxnBEkIC/hLLF8/hxXEZhFQldgy+yob
	iM0rYC4x7/IVRoihmhINl+4xQcQFJU7OfMICYjMLyEs0b53NPIGRaxaS1CwkqQWMTKsYRTLz
	ynITM3NM9YqzMyrzMiv0kvNzNzECQ2lZ7Z+JOxi/XHY/xCjAwajEw+sgn5ohxJpYVlyZe4hR
	goNZSYSXTzY5Q4g3JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNT
	qoHx+p+Nsgm9k6NvtolLxHU9UPYo42XPk3O//u5CVkvOj9MH8lee5Jo/R5TNzNH6u+O9qQxN
	cg9eGzLnqwf0bT/uvKOg/febM4rhfm1WJuuWTC+Vaf61kuOy1PNDvpzmPKumf1SU2L9Ob0Fg
	i5Dc7ep721iPbZh3WXRzzTHD4htr7zpsvSatvixDiaU4I9FQi7moOBEAOmBjXCECAAA=
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
 samples/damon/mtier.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index f3220d6e6739..3570ebe10fab 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -42,8 +42,34 @@ static bool enable __read_mostly;
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
+	range->start = PFN_PHYS(start_pfn);
+	range->end  = PFN_PHYS(end_pfn);
+
+	return 0;
+}
+
 static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 {
 	struct damon_ctx *ctx;
@@ -53,6 +79,8 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
 	struct damos *scheme;
 	struct damos_quota_goal *quota_goal;
 	struct damos_filter *filter;
+	struct region_range addr;
+	int ret;
 
 	ctx = damon_new_ctx();
 	if (!ctx)
@@ -82,9 +110,17 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
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

