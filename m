Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF4140E38
	for <damon@lists.linux.dev>; Tue, 22 Oct 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586370; cv=none; b=ETEgzc4Dtaz2yH9zx6yrI8Eob+fRKxyGBduZAVA0diAIPFFdtrrdHwmNrESYRlB0LhjR3pa/+ZU69ivj/fQDtq+zxk13EMo5YqTRQyIyNyBs0ohXqIJbh0lHBpUTphoO2oYrs2a24uDjFAT4BMrHSq5V80Fq7s2Yegm6o65lYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586370; c=relaxed/simple;
	bh=/39Qe/P5cSaW5cZYrOZN1mnYWBJfyx9L3y74EOD7STQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEDRYeBebMqkF3XmH9iX/kmkhMgMq3lgMc6A79wIkASPk8Bu+Xmg9h1rwi1Pa0yooKJ3ijj5s/+Jx4ohcAzxAWN5W2JeNUBMtF/+5dE/PXqNJHYNWS2dS9b00/aTvhsC55sHHpESu2net2BDjskLZvlv2evmb3hvBIHeAaYks+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XXlvt6xzjz4f3m76
	for <damon@lists.linux.dev>; Tue, 22 Oct 2024 16:39:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2C5251A0568
	for <damon@lists.linux.dev>; Tue, 22 Oct 2024 16:39:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP3 (Coremail) with SMTP id _Ch0CgCnRoO3ZBdndQiQEg--.6910S2;
	Tue, 22 Oct 2024 16:39:24 +0800 (CST)
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
Subject: [PATCH v2 0/2] mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
Date: Tue, 22 Oct 2024 16:39:25 +0800
Message-Id: <20241022083927.3592237-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021163316.12443-1-sj@kernel.org>
References: <20241021163316.12443-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnRoO3ZBdndQiQEg--.6910S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryUKr4kKF4rWF4fCF45ZFb_yoW8Jw43p3
	WfWr45GF4vkryav3Z3u3WYvwn0yrW8Jr1DGry3JF1Yka4vga4YyFy7tr90yFyUCFWfJ34S
	93W8XrW3CF93uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
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

And add 'nr_piece == 1' check in damon_va_evenly_split_region()
for better code readability and add a corresponding kunit testcase.

Zheng Yejian (2):
  mm/damon/vaddr: Fix issue in damon_va_evenly_split_region()
  mm/damon/vaddr: Check 'nr_piece == 1' case in
    damon_va_evenly_split_region()

 mm/damon/tests/vaddr-kunit.h | 2 ++
 mm/damon/vaddr.c             | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.25.1

