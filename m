Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632087;
	b=3DBZkIoXa08LvkjVnEWzWZUjH8qN07Cd9aKS+GhzYxSqVhbfLB+YuJRi8QqGS03Bmd3X
	 aNNX3bBlwO64gOKaA5CRoj6ZIRy9y8pIrIj3BcOgm1PQhcthXmtdkIWdDCXiu8Gmxzd8o
	 8IjGlPJyvvdEfCdm5XJl6DBRooylpkjr8kddloueIofU3ELCx2zDm+WpgPBMfFFEZpC33
	 mO7y431tnWKflrX4AJoe63BpxSPrDKHYTYN0jd/Dw5hoIK7SIv//QDCtj/UGBu+lffPif
	 wQvycdEOKcarpK4HQDYCWEk8CVbq7lMD+J7h+hAAVBteTOvDtOQ7xh1wQRrAmJcQhtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XuK4d1M7JKzxtXkmylZMVK8sWXtnLYK8j0M8Pc5ofm8=;
	b=GSXrm62KFo/IW+AwdYLm+rJm+pQS97zNXqRU0ilRDdfnEyyblaR4qJHVdSLmkGt80zQ5
	 5YY0DNGFPi1cSrVyNoaMA/EjzK8Y2aT2Fiyh3af2uAb/WKQxslWi/Crm8v3jgD/fRkd0T
	 cxEH1lr2qsdN15V6FxSnPFoYIxbBygEtFD743u3c4/SJZ8zS5ZUEjoZOaxv9DTb7nAgg6
	 yMkR0CrLzRcObWkdeH3cX0Vs+ryPjeEVifQsPu9CBSwIp616L89nVoiPaHnvIaQkgeoZw
	 2M8GPPNpzXzyRSpoe8Wt1IA2R7A5+RQGQofR6OpZFTTURKFIqXp/KuLyZmQ/RM34OZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d56wof6w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19860A0FFB;
	Mon,  2 Nov 2026 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d56wof6w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C9C1F00A20;
	Mon,  2 Nov 2026 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632086;
	bh=XuK4d1M7JKzxtXkmylZMVK8sWXtnLYK8j0M8Pc5ofm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d56wof6wqHSC2Jccrt0KXPAZZ0jJKKYM00WPVl2hPJUHl9eN14VIGfdC2IRKS6nbu
	 BtPpN4eIrjpqoH8ndJeCNB7CGsPFZ+X9Ph52EOIO5t+CedTH7GujSQdpoMHBEpcmlV
	 cSUp6jDpQ1UdTG2a+UMjrEAQbnTTqYu4eH8muFuWrg4XnaSDr2uUHl5PFm/yaPkBLu
	 YXYqRSrd+GVvivAm3bswv5XNQEARb5XJ7RSXHnv5zIzIYy8k1vL7yOWAbMt85ENR6G
	 9b4Bf36Rs8J6bikuYA7OuvvLN6us5qAvOI0s3S2DkN66zuyOiykckfS1JNUa9gDyO6
	 6K976YpcikCFA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/9] mm/damon/stat: avoid 32-bit overflow in idle percentiles
Date: Mon,  2 Nov 2026 07:07:51 -0800
Message-ID: <20261102150757.93058-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102150757.93058-1-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

On 32-bit, accounted_bytes * 100 can wrap before division by total_sz.
Some entries in memory_idle_ms_percentiles then keep their old values
instead of being updated.

For example, a 256 MiB i386 QEMU guest reported p0=19200 ms, but p50 and
p100 were both zero.  The issue was also shared with another mail [1].

Cast accounted_bytes to u64 before multiplying and use div64_ul() for
the division. Compute the percentage once per region.

Link: https://lore.kernel.org/r/CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com [1]
Link: https://lore.kernel.org/179207592479.3.11595453180868898703@gmail.com
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/179207592479.3.11595453180868898703@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index b05b68f73e10d..eccd372810d04 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -114,7 +114,7 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 {
 	struct damon_region **sorted_regions, *region;
 	int nr_regions;
-	unsigned long total_sz, accounted_bytes = 0;
+	unsigned long total_sz, accounted_bytes = 0, percentile;
 	int err, i, next_percentile = 0;
 
 	err = damon_stat_sort_regions(c, &sorted_regions, &nr_regions,
@@ -124,7 +124,8 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 	for (i = 0; i < nr_regions; i++) {
 		region = sorted_regions[i];
 		accounted_bytes += region->ar.end - region->ar.start;
-		while (next_percentile <= accounted_bytes * 100 / total_sz)
+		percentile = div64_ul((u64)accounted_bytes * 100, total_sz);
+		while (next_percentile <= percentile)
 			memory_idle_ms_percentiles[next_percentile++] =
 				damon_stat_idletime(region) *
 				(long)c->attrs.aggr_interval / USEC_PER_MSEC;
-- 
2.47.3
