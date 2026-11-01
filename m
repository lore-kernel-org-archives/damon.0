Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.247.232.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556035;
	b=drWD3hPmwEWL6pnO2r3RXeWyz+XQQYYtjmRPc0cYbAXmSdita4AD2bGnrOmLhp52ni6W
	 ROXtlGPd94UsN7wQotBHmL3CsVW8TkFrzbj0HOn2HMyXnfkBYByyOcW8r70iLsCgvCW6v
	 tWFpXOE7ic784gh9nlOmF3bbfkMl4zNp0bcgUhti6l4w/1FZ7vCR7Md8koESuDoSGaNRw
	 2qdKF7VDsyl1RTIVeTlrPFwzBDu96T59d3i4zLXPyrdW1IgA3a0zNBNuECtR3jEIiytCp
	 VMVyl7AzjcKlta9jkTDH7GQWU9lYHZXGYwrR1YmtaEvr+i3t52CwM5ttBYY00RP9b/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556035;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sQF5AaRAqJJwPNtFv8d82MWcPLAgvRqmvTygJZxjDWE=;
	b=AC1qSrV3R0v7/9wsxXBYgdQhqb3qQpl0eW9cjE6/jwHcL3hUcqMcGkwEytneLdpbi6gv
	 gjNG6JhrYofQIN3OVWAthrdZhc9gafBPPHI5QPSJBuNcr3/KaTqZP1PPPbOezOGtNExBG
	 NxhWuMCFhXKkhOOQo/q0hSXlyqnmdcZ0GdInHsu7O9XoekpXpkKuZILnxmyCf8Aljq/Rn
	 65x2f1xtifa8X0VJmSzGKUJFUEPFm/aAfANj/pki9Z1uekk5S3f0j/WDWTj7JTwCiQ8AF
	 G5U4lVthgCRZCnreiwyU7uzYz/alyfjaqJFfvUuo6co/GbjtdZ2IxK+Tp8Em1m2Slgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linx-info.com;
	spf=pass smtp.mailfrom=linx-info.com;
	arc=none smtp.remote-ip=114.247.232.78
Received: from mail.linx-info.com (mail.linx-info.com [114.247.232.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D883606A327
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 18:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D883606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linx-info.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linx-info.com
Received: from localhost (localhost [127.0.0.1])
	by mail.linx-info.com (Postfix) with ESMTP id E2697321215;
	Mon,  2 Nov 2026 02:00:24 +0800 (CST)
Received: from mail.linx-info.com ([127.0.0.1])
	by localhost (mail.linx-info.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6jflpuqa_Xy; Mon,  2 Nov 2026 02:00:24 +0800 (CST)
Received: from DiGouShu (unknown [172.31.255.20])
	by mail.linx-info.com (Postfix) with ESMTPSA id 8498432116A;
	Mon,  2 Nov 2026 02:00:24 +0800 (CST)
From: Wang Guangke <gkwang@linx-info.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wang Guangke <gkwang@linx-info.com>
Subject: [PATCH] mm/damon/stat: avoid overflow in estimated_memory_bandwidth calculation
Date: Mon,  2 Nov 2026 02:00:01 +0800
Message-ID: <20261101180001.167198-1-gkwang@linx-info.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calculation of estimated_memory_bandwidth computes
access_bytes * USEC_PER_MSEC * MSEC_PER_SEC / aggr_interval directly.
On 32-bit systems, the intermediate product
access_bytes * USEC_PER_MSEC * MSEC_PER_SEC may overflow before the
division is performed.

Fix it by splitting the division into quotient and remainder,
multiplying each part separately.

Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated
memory bandwidth")

Signed-off-by: Wang Guangke <gkwang@linx-info.com>
---
 mm/damon/stat.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10..7cfa3a8d6801 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -32,8 +32,8 @@ static bool enabled __read_mostly = IS_ENABLED(
 module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
 
-static unsigned long estimated_memory_bandwidth __read_mostly;
-module_param(estimated_memory_bandwidth, ulong, 0400);
+static u64 estimated_memory_bandwidth __read_mostly;
+module_param(estimated_memory_bandwidth, ullong, 0400);
 MODULE_PARM_DESC(estimated_memory_bandwidth,
 		"Estimated memory bandwidth usage in bytes per second");
 
@@ -55,15 +55,20 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long access_bytes = 0;
+	u64 access_bytes = 0;
+	u64 remainder, bytes_per_interval;
 
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t)
-			access_bytes += (r->ar.end - r->ar.start) *
+			access_bytes += (u64)(r->ar.end - r->ar.start) *
 				r->nr_accesses;
 	}
-	estimated_memory_bandwidth = access_bytes * USEC_PER_MSEC *
-		MSEC_PER_SEC / c->attrs.aggr_interval;
+	bytes_per_interval = div64_u64_rem(access_bytes,
+			c->attrs.aggr_interval, &remainder);
+	estimated_memory_bandwidth =
+		bytes_per_interval * USEC_PER_MSEC * MSEC_PER_SEC +
+		div64_u64(remainder * USEC_PER_MSEC * MSEC_PER_SEC,
+				c->attrs.aggr_interval);
 }
 
 static int damon_stat_idletime(const struct damon_region *r)
-- 
2.47.3

