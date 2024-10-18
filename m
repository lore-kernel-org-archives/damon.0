Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3120E31D
	for <damon@lists.linux.dev>; Fri, 18 Oct 2024 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223597; cv=none; b=sXN4dFeBEK0pWuQKNOMOID+Ub+UBkFBrhQpbSW3ZiXinr0L5koqMk+Yvc3Wo/uAcAI3Wf+19u64e6bBXTXBfY0crlNs3eUJnomMqT+bqnYT1hqWoS5Qt5fmICUFn/dGhjBI0fbqIBYLl4exq0KAXdMUpPvyhx7I+za3VG5Eu+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223597; c=relaxed/simple;
	bh=aL1rpSk9iBYKqX6OobmV5wF1n/2bl5omZy4g377wNDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrCFumnx4Ltwyhg5XV9FAAJkmO9ogPZ9boVLUkwF2xFeehlqN+2EOJhdkZTGq+u9OjM1go1lGbHboRuLIeZrmhxRMxDvw/NDzP5n0qZIPLNJyclZ63VkAny9w8pcnAh1IwD6Gcgb9Hxy3Oh+IHYQNwCPQKH5HNY+X95fBmQOATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XV9lN1mCkz4f3jYW
	for <damon@lists.linux.dev>; Fri, 18 Oct 2024 11:52:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 717B71A018D
	for <damon@lists.linux.dev>; Fri, 18 Oct 2024 11:53:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgDnacac2xFn3SagEQ--.674S2;
	Fri, 18 Oct 2024 11:53:05 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	sieberf@amazon.com,
	shakeel.butt@linux.dev,
	foersleo@amazon.de
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Fri, 18 Oct 2024 11:53:04 +0800
Message-Id: <20241018035304.1050135-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnacac2xFn3SagEQ--.674S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4UZrWruFWfXF4DGF4DJwb_yoWrWF1Up3
	93WrWfKrWDtFy2vw13Zan8ZrnxArW8tF1UCryfJF1qyFnYg34DtFWUJ345tFyrCayxZ34f
	Zw10vrW3GFZ8Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj8pnPUUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

According to the logic of damon_va_evenly_split_region(), currently at
least following split cases would not meet the expectation:

  Suppose DAMON_MIN_REGION=0x1000,
  Case1: Split [0x0, 0x1100) into 1 pieces, then the result would be
         acutually [0x0, 0x1000), but NOT the expected [0x0, 0x1100) !!!
  Case2: Split [0x0, 0x3000) into 2 pieces, then the result would be
         acutually 3 regions:
           [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
         but NOT the expected 2 regions:
           [0x0, 0x1000), [0x1000, 0x3000) !!!

The root cause is that when calculating size of each split piece in
damon_va_evenly_split_region():

  `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`

both the dividing and the ALIGN_DOWN may cause loss of precision,
then each time split one piece of size 'sz_piece' from origin 'start' to
'end' would cause:
  1. For the above Case1, the 'end' value of the split 1 piece is
     aligned but not updated!!!
  2. For the above Case2, more pieces are split out than expected!!!

To fix it, in this patch:
- As for the expect to split 1 piece, just return 0;
- Count for each piece split and make sure no more than 'nr_pieces';
- Add above two cases into damon_test_split_evenly().

BTW, currently when running kunit test, DAMON_MIN_REGION is redefined
as 1, then above ALIGN_DOWN cases may not be test, since every int
value is ALIGN-ed to 1.

After this patch, damon-operations test passed:

 # ./tools/testing/kunit/kunit.py run damon-operations
 [...]
 ============== damon-operations (6 subtests) ===============
 [PASSED] damon_test_three_regions_in_vmas
 [PASSED] damon_test_apply_three_regions1
 [PASSED] damon_test_apply_three_regions2
 [PASSED] damon_test_apply_three_regions3
 [PASSED] damon_test_apply_three_regions4
 [PASSED] damon_test_split_evenly
 ================ [PASSED] damon-operations =================

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 mm/damon/tests/vaddr-kunit.h |  2 ++
 mm/damon/vaddr.c             | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a339d117150f..b9a03e4e29e5 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -300,6 +300,8 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_fail(test, 0, 100, 0);
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_succ(test, 4, 6, 1);
+	damon_test_split_evenly_succ(test, 0, 3, 2);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 08cfd22b5249..1f3cebd20829 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -67,10 +67,14 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	unsigned long sz_orig, sz_piece, orig_end;
 	struct damon_region *n = NULL, *next;
 	unsigned long start;
+	int i;
 
 	if (!r || !nr_pieces)
 		return -EINVAL;
 
+	if (nr_pieces == 1)
+		return 0;
+
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
 	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
@@ -79,9 +83,11 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 		return -EINVAL;
 
 	r->ar.end = r->ar.start + sz_piece;
+	/* origin region will be updated as the first one after splitting */
+	i = 1;
+	n = r;
 	next = damon_next_region(r);
-	for (start = r->ar.end; start + sz_piece <= orig_end;
-			start += sz_piece) {
+	for (start = r->ar.end; i < nr_pieces; start += sz_piece, i++) {
 		n = damon_new_region(start, start + sz_piece);
 		if (!n)
 			return -ENOMEM;
@@ -89,8 +95,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 		r = n;
 	}
 	/* complement last region for possible rounding error */
-	if (n)
-		n->ar.end = orig_end;
+	n->ar.end = orig_end;
 
 	return 0;
 }
-- 
2.25.1

