Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.247.232.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677261;
	b=P7/BPLYUolYiEpVWFDAmzob68zfZjaHMmEOHo3LBJKEmoLFc8F482DcMq03qOIGE86KQ
	 A1M/Cr0NTb4F1+1OQtR/LF5hDjN7OpeKLPP2e3TqNBxeAd6u052NXI5i5RPtuABmfNgV3
	 JNvO8oPP0cQPbXhrDswkmwf2p+KnPBBDpJ/ghqBrmp4VmFuZA+m1lpt53VW9/iG4eGc21
	 NM2pEignNnDf+4nNvcFC81yKxF3ZGyPib8oBxf/xmex3SPuh+pKsZ5zkcmrd0dap83GuS
	 RRTNA/1JXVhI5nan09x5LVnoowua8dxhUqEHb1OwzX5YdE2dhxY/mgulgzG5+u4NHlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677261;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VSTrktgGZ8s9uEUboO9uuASria0PEjkILQvjOya3gqE=;
	b=dJDxUQhaEfpWZcLot1l7EDpxLHEGUjEmN7hjFRsZhXNasx49Vqqe36Ih1o993Z8wmPIa
	 QBsQFb76LuBc/Ja3q2i0Yx2Pj36k7C7kfFUpD058SseAT9AQXul+9quErAqs8tnAKSKZ8
	 JWkiI6xMzT1Xnm7ZrWgmUlU/cKPgN9diTDKjGJm99oUBFgNjoR4zpsekIaJznEGoOKbrv
	 2xdOBiQre/golVpDcBhmmTyBWMQM5WfvOHadaG1fKHPsLL1uy9rgvmRzvzQAMs7HRKvj7
	 qBiMrsQUaD7Rjx7eijisnJv2fQmsrEdaaP8k3YAOU9S9ILil5rNjpzHW4BfnxXpxW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linx-info.com;
	spf=pass smtp.mailfrom=linx-info.com;
	arc=none smtp.remote-ip=114.247.232.78
Received: from mail.linx-info.com (mail.linx-info.com [114.247.232.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5CF606A32C
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 03:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC5CF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linx-info.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linx-info.com
Received: from localhost (localhost [127.0.0.1])
	by mail.linx-info.com (Postfix) with ESMTP id 761E53211C5;
	Tue,  3 Nov 2026 11:40:51 +0800 (CST)
Received: from mail.linx-info.com ([127.0.0.1])
	by localhost (mail.linx-info.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0X34993ex3hU; Tue,  3 Nov 2026 11:40:51 +0800 (CST)
Received: from localhost.localdomain (unknown [172.22.21.200])
	by mail.linx-info.com (Postfix) with ESMTPSA id 5DBB232119D;
	Tue,  3 Nov 2026 11:40:51 +0800 (CST)
From: Wang Guangke <gkwang@linx-info.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wang Guangke <gkwang@linx-info.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/stat: avoid overflow in estimated_memory_bandwidth calculation
Date: Tue,  3 Nov 2026 11:40:34 +0800
Message-ID: <20261103034034.7978-1-gkwang@linx-info.com>
X-Mailer: git-send-email 2.47.3
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

estimated_memory_bandwidth is calculated by access_bytes *
USEC_PER_MSEC * MSEC_PER_SEC (= USEC_PER_SEC) / aggr_interval,
and users read it via
/sys/module/damon_stat/parameters/estimated_memory_bandwidth.

On 32-bit systems, access_bytes * USEC_PER_SEC overflows unsigned
long once access_bytes exceeds about 4294 (U32_MAX / USEC_PER_SEC),
so users get a wrong value.

Fix it by doing the calculation in 64-bit and splitting the division
into quotient and remainder.

The issue was reproduced on a 32-bit system (qemu-system-i386): the
parameter estimated_memory_bandwidth reported 362 instead of the
expected 1926150; with the fix, the value matches the expectation.

Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wang Guangke <gkwang@linx-info.com>
---
Changes in v2:
- v1: https://lore.kernel.org/all/20261101180001.167198-1-gkwang@linx-info.com
- Clarify the issue and its impact on users.
- Add Cc: stable@.
- Rename variable bytes_per_interval to bytes_per_us.
- Use USEC_PER_SEC instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.
---
 mm/damon/stat.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10..e44f5bf3645c 100644
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
 
@@ -55,15 +55,18 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long access_bytes = 0;
+	u64 access_bytes = 0;
+	u64 remainder, bytes_per_us;
 
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t)
-			access_bytes += (r->ar.end - r->ar.start) *
+			access_bytes += (u64)(r->ar.end - r->ar.start) *
 				r->nr_accesses;
 	}
-	estimated_memory_bandwidth = access_bytes * USEC_PER_MSEC *
-		MSEC_PER_SEC / c->attrs.aggr_interval;
+	bytes_per_us = div64_u64_rem(access_bytes,
+			c->attrs.aggr_interval, &remainder);
+	estimated_memory_bandwidth = bytes_per_us * USEC_PER_SEC +
+		div64_u64(remainder * USEC_PER_SEC, c->attrs.aggr_interval);
 }
 
 static int damon_stat_idletime(const struct damon_region *r)
-- 
2.47.3

