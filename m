Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF632DCF6A
	for <damon@lists.linux.dev>; Wed, 20 Aug 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678019; cv=none; b=UUGAfFwzDhtn3SmZHRT//ZDpNsJm6S6l0JY3UiXrqKADzBAFZSUC3+twin810DqjMiuwbHdl4n/nSUCYCcbc1Bx8pdVatYFNu1xZH+aO0iJlBdVLbfL24MNrLt3R+SeJDS+WzT+87XK67nYD6d467L+w3GODM1GbHHglfCUjJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678019; c=relaxed/simple;
	bh=Skjk9d2Jo+2kTcV2TufJV9hpbv12yHx3U9ijuNo4n/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gq25JhiJIy1qXumCJFKOnVjPfEMmsKfYwhr+AZ9vJwoWAWwyhiyHVcesDmAy0KZX1GgJ+ybS7GV2B6vAZa1ippHVDzwSpEvWMeWNeCS+RnDsYln3p2Xtg4SYyagakag2LtaeERxejDB/AslwLqz9PJrMz8upQxbh8Ijf37qJ4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6K7P2Lnyz2TTFP;
	Wed, 20 Aug 2025 16:17:21 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 63597140277;
	Wed, 20 Aug 2025 16:20:10 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 16:20:09 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH mm-next v2 12/12] mm/damon/core: prevent unnecessary overflow in damos_set_effective_quota()
Date: Wed, 20 Aug 2025 16:06:22 +0800
Message-ID: <20250820080623.3799131-13-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820080623.3799131-1-yanquanmin1@huawei.com>
References: <20250820080623.3799131-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200018.china.huawei.com (7.185.36.31)

On 32-bit systems, the throughput calculation in function
damos_set_effective_quota() is prone to unnecessary
multiplication overflow. Using mult_frac() to fix it.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 980e271e42e9..38b5f842ef30 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2102,8 +2102,8 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (quota->ms) {
 		if (quota->total_charged_ns)
-			throughput = quota->total_charged_sz * 1000000 /
-				quota->total_charged_ns;
+			throughput = mult_frac(quota->total_charged_sz, 1000000,
+							quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
-- 
2.43.0

