Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8326175D26
	for <damon@lists.linux.dev>; Tue, 22 Oct 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586373; cv=none; b=shN8J6OG8yDfEyCyUyfnuLpmoUmQI92ALdbAaYPyeo0wJIRkxMeKi2263rRNKIqn2HLjpr4JpLIVUL7FGPNIqsQe/M+6EcCCxoWwWZpRfx6vi3nIdFz9SjMRab8Y6Np5tm1As2r89FaNy14WRGFC6YvBF+Dna5dBv7waWHtENZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586373; c=relaxed/simple;
	bh=EJbeT8XXX3nsUwF5i2KCmHW+hitfEZb0aE7J4M52HIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2nONmgYNH63dDqAA8W9ZNf7AlLs5hLLPt/GEhL+Nlmom9xlpbhYdOBidK3l0VRwHfsYuQM5M9lOAaw6aT3O5XZOMvBkL6NSc1AEsyL7BkOhQ42Ok/7OIGEMJcuakb8QU6X8UvkrBHv5gcv2ydnsEqDnVpRvvzZgOh8/70sNHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXlw2319rz4f3k6W
	for <damon@lists.linux.dev>; Tue, 22 Oct 2024 16:39:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id AF3F11A018D
	for <damon@lists.linux.dev>; Tue, 22 Oct 2024 16:39:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP3 (Coremail) with SMTP id _Ch0CgCnRoO3ZBdndQiQEg--.6910S3;
	Tue, 22 Oct 2024 16:39:25 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	foersleo@amazon.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	sieberf@amazon.com,
	yeweihua4@huawei.com,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2 1/2] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 16:39:26 +0800
Message-Id: <20241022083927.3592237-2-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022083927.3592237-1-zhengyejian@huaweicloud.com>
References: <20241021163316.12443-1-sj@kernel.org>
 <20241022083927.3592237-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnRoO3ZBdndQiQEg--.6910S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4UZrWDCr45Xw13uFW8Xrb_yoW5urWrp3
	93WrWfKFWDtFy2vw15Z3Z5ZrnFyrW8tF1UGryfJF1vyF1vg34UtFW3J345tryrCFWxZw1f
	Zw4xtrWfGF9rCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

According to the logic of damon_va_evenly_split_region(), currently
following split case would not meet the expectation:

  Suppose DAMON_MIN_REGION=0x1000,
  Case: Split [0x0, 0x3000) into 2 pieces, then the result would be
        acutually 3 regions:
          [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
        but NOT the expected 2 regions:
          [0x0, 0x1000), [0x1000, 0x3000) !!!

The root cause is that when calculating size of each split piece in
damon_va_evenly_split_region():

  `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`

both the dividing and the ALIGN_DOWN may cause loss of precision,
then each time split one piece of size 'sz_piece' from origin 'start' to
'end' would cause more pieces are split out than expected!!!

To fix it, count for each piece split and make sure no more than
'nr_pieces'. In addition, add above case into damon_test_split_evenly().

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

v1 -> v2:
- Move 'nr_pieces == 1' check into separate patch and update commit messages;
- Change type of variable 'i' to be 'unsigned int';
- Remove a puzzling comment;

v1: https://lore.kernel.org/all/20241018035304.1050135-1-zhengyejian@huaweicloud.com/

 mm/damon/tests/vaddr-kunit.h | 1 +
 mm/damon/vaddr.c             | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a339d117150f..a149e354bb26 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -300,6 +300,7 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_fail(test, 0, 100, 0);
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_succ(test, 0, 3, 2);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 08cfd22b5249..dba3b2f4d758 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -67,6 +67,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	unsigned long sz_orig, sz_piece, orig_end;
 	struct damon_region *n = NULL, *next;
 	unsigned long start;
+	unsigned int i;
 
 	if (!r || !nr_pieces)
 		return -EINVAL;
@@ -80,8 +81,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	r->ar.end = r->ar.start + sz_piece;
 	next = damon_next_region(r);
-	for (start = r->ar.end; start + sz_piece <= orig_end;
-			start += sz_piece) {
+	for (start = r->ar.end, i = 1; i < nr_pieces; start += sz_piece, i++) {
 		n = damon_new_region(start, start + sz_piece);
 		if (!n)
 			return -ENOMEM;
-- 
2.25.1

