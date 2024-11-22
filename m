Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5042A9F
	for <damon@lists.linux.dev>; Fri, 22 Nov 2024 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264436; cv=none; b=akkIn0k+/8p6xovELcCLRbrcVxbBJxDhMaASgnIDtDg0dAwJcAJ37Dw9jK8iz0J3zFCCUd5OVOZ7gTMQYkoWB62igZEjyKPMYV5LDueXUbeIkB2SOXhWgr9HjJeEq5VCKAggj/uS4K+NwUCSfVQ5vv6h+suW8rkcs2vKC91pcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264436; c=relaxed/simple;
	bh=aqIe7EMQ5jxgZsmhcnAb9OH2Q6M1zSL00UFgC1zNUAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Co6dsMVUM4Pnyic9LWVyHNThjkKNcrmV5qE9ulA7AYBG9b4B7PrMxwypWgdVowz6TcIBFDe2MxBZNstouliAVBb71tS01ILl6jr9reQvMhmNeKov9pUqx8RPe6SrBwz4OGAfdnk5RLAIBZt2BSF0vnP+eUhi2o5Ukkb2p2DcQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-74-67403e601b85
From: Honggyu Kim <honggyu.kim@sk.com>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH] mm/damon/core: Refactor damos_set_effective_quota
Date: Fri, 22 Nov 2024 17:18:34 +0900
Message-ID: <20241122081834.1344-1-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgluLIzCtJLcpLzFFi42LhesuzSDfBziHd4Nk1PYsn/3+zWhz++obJ
	gclj06pONo8Xm2cyBjBFcdmkpOZklqUW6dslcGV83XWWsWA5Z0XL9mesDYwn2LsYOTkkBEwk
	ulddgrNnnj3HAmKzCahJXHk5iQnEFhGQlPhzpxWshlkgQeLx3UWMILawgJPEzHsdQDYHB4uA
	qsSP92ogYV4BM4nHN64wQYzUlHi8/Sc7RFxQ4uTMJywQY+QlmrfOZu5i5AKqOcsqcWzDeUaI
	BkmJgytusExg5J2FpGcWkp4FjEyrGIUy88pyEzNzTPQyKvMyK/SS83M3MQLDZVntn+gdjJ8u
	BB9iFOBgVOLhPaFuny7EmlhWXJl7iFGCg1lJhNdBCSjEm5JYWZValB9fVJqTWnyIUZqDRUmc
	1+hbeYqQQHpiSWp2ampBahFMlomDU6qBcdnxKO2oFwJMfUmsP8s7WrYLSPrqsHz2rXvW6Dzn
	NwOXwL5C7aVu/A6NM37nL6iROfPzAe8bh3uxktd1NjIacei2cl8LnL9eRPbqohTDgIKTC9bU
	f1q5pWi252bNhvCTT5T/WO60iDi3hWVG8pqnTxliLnzfOXfp8uXlC6OuCGlV11Wa+B2qVWIp
	zkg01GIuKk4EAIiG4KUTAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsXCNUNLTzfBziHd4N8vZYsn/3+zWnx+9prZ
	4vDck6wWh7++YXJg8di0qpPN48XmmYwe3257eCx+8YEpgCWKyyYlNSezLLVI3y6BK+PrrrOM
	Bcs5K1q2P2NtYDzB3sXIySEhYCIx8+w5FhCbTUBN4srLSUwgtoiApMSfO61gNcwCCRKP7y5i
	BLGFBZwkZt7rALI5OFgEVCV+vFcDCfMKmEk8vnGFCWKkpsTj7T/ZIeKCEidnPmGBGCMv0bx1
	NvMERq5ZSFKzkKQWMDKtYhTJzCvLTczMMdUrzs6ozMus0EvOz93ECAyHZbV/Ju5g/HLZ/RCj
	AAejEg/vCXX7dCHWxLLiytxDjBIczEoivA5KQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGp
	CUIC6YklqdmpqQWpRTBZJg5OqQbG61dfT3d3O3lqY+Z90xbzR3/u5LKmvlEWSzn6tFb1WJDK
	V/6z9ktiWVK4VCZLC0oJ3/Mr/FeZdvtx/9XJn/7Mb9f9vuTR/EsGfEeEXgakhjN8M1QvVkoV
	vtAhcX/q7LtTeA+siF7y0dMhXttZuH7rlB1tPM/iH+4/Ounnp70CjMo155d6VP16ocRSnJFo
	qMVcVJwIAHvsfmIDAgAA
X-CFilter-Loop: Reflected

The damos_set_effective_quota checks quota contidions but there are some
duplicate checks for quota->goals inside.

This patch reduces one of if statement to simplify the esz calculation
logic.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 511c3f61ab44..eb2761866dda 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1542,7 +1542,7 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
 	unsigned long throughput;
-	unsigned long esz;
+	unsigned long esz = UINT_MAX;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -1564,10 +1564,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 				quota->total_charged_ns;
 		else
 			throughput = PAGE_SIZE * 1024;
-		if (!list_empty(&quota->goals))
-			esz = min(throughput * quota->ms, esz);
-		else
-			esz = throughput * quota->ms;
+		esz = min(throughput * quota->ms, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)
-- 
2.34.1

