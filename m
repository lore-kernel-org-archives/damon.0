Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3722C158F
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057165; cv=none; b=Syb03YgYrh9ut4pTnt77gijfG765QcxWeuqQ2SEoj9WrzDU2AXO5y9t+0pXmInPUxkwOaOJ84Faf8Kmu+/ywhUjfTlJuj4hR8ooEoadQWIXcc49tJHbpNLItXAjMw5PdxkCHC6aq+A4GyjeAxCDELspQZyUzARQIEFE75sW2now=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057165; c=relaxed/simple;
	bh=+TtvvtkfcdQbySxJLg/HYRDdGbJtc9HKEZuMK+x1i0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxyZ239K3cqgG88+WjTG3elSDENvWDMSEv4im+A81Wl7PaH8yIWBfvTkm/qFu77ZcIeOZAYQWYG1S91zH1XbG4F4Sku6Nm8Nvs3SluAJx31QtcGsn7AQpaJoSZW6EGpwE40xouh1flQxj8E+8qAolE9JeZdFBkC5gyuLeJyk66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c1vVG0VLFz2Cg7V;
	Wed, 13 Aug 2025 11:48:22 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 92E2A14027A;
	Wed, 13 Aug 2025 11:52:41 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:40 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 16/16] mm/damon/core: handle quota->esz overflow issues
Date: Wed, 13 Aug 2025 13:07:06 +0800
Message-ID: <20250813050706.1564229-17-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: <20250813050706.1564229-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

In the original quota enforcement implementation, the traffic
calculation multiplied A by 1000000 due to time unit conversion,
making it highly prone to overflow on 32-bit systems:

damos_set_effective_quota
  if (quota->total_charged_ns)
    throughput = quota->total_charged_sz * 1000000 /
		quota->total_charged_ns;

Requiring total_charged_sz to be less than 4GB/1000000 is unreasonable.
Additionally, when overflow occurs and causes quota->esz to become
extremely small, the subsequent damos_apply_scheme logic permanently
sets sz to 0, while quota stop updating, ultimately leading to complete
functional failure:

damos_apply_scheme
  if (quota->esz && quota->charged_sz + sz > quota->esz)
    sz = ALIGN_DOWN(quota->esz - quota->charged_sz, DAMON_MIN_REGION);

Total charged stats use the unsigned long long data type to reduce
overflow risk, with data reset capability after overflow occurs.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 include/linux/damon.h |  4 ++--
 mm/damon/core.c       | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d85850cf06c5..45aab331dfb7 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -247,8 +247,8 @@ struct damos_quota {
 
 /* private: */
 	/* For throughput estimation */
-	unsigned long total_charged_sz;
-	unsigned long total_charged_ns;
+	unsigned long long total_charged_sz;
+	unsigned long long total_charged_ns;
 
 	/* For charging the quota */
 	unsigned long charged_sz;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index bc764f9dc5c5..5e05fdd91c12 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/string_choices.h>
+#include <linux/math64.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
@@ -2059,8 +2060,8 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
  */
 static void damos_set_effective_quota(struct damos_quota *quota)
 {
-	unsigned long throughput;
-	unsigned long esz = ULONG_MAX;
+	unsigned long long throughput;
+	unsigned long long esz = ULLONG_MAX;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -2077,11 +2078,16 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 	}
 
 	if (quota->ms) {
-		if (quota->total_charged_ns)
-			throughput = quota->total_charged_sz * 1000000 /
-				quota->total_charged_ns;
-		else
+		if (quota->total_charged_ns &&
+			likely(quota->total_charged_sz < ULLONG_MAX / 1000000)) {
+			throughput = div64_u64(quota->total_charged_sz * 1000000,
+					quota->total_charged_ns);
+		} else {
 			throughput = PAGE_SIZE * 1024;
+			/* Reset the variable when an overflow occurs */
+			quota->total_charged_ns = 0;
+			quota->total_charged_sz = 0;
+		}
 		esz = min(throughput * quota->ms, esz);
 	}
 
-- 
2.34.1

