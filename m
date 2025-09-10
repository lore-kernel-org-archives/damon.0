Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD4279DCB
	for <damon@lists.linux.dev>; Wed, 10 Sep 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503969; cv=none; b=vA0lUwcaBPEPBye7QjKQZLG9EVFbHi/2VGye3wyjrMWP8q+Hmfgr+aUx15Zr/8kCKSseASC7K0q2PJ2WsdSqpFp5UumgVoeiKvNocH878S4E7iqFBHobY/WTbR6BTrnLK4+Iv+7/sOpy2757fDVAw1VvAV88AJLfbZMssMO5QrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503969; c=relaxed/simple;
	bh=Ja7PAgzmHDVgBjj6atkrpbGcY591UCwYQWmi49TvYyE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaWJAiCRNF3e8vhYZH0YHyN6DPCac1u/RDae/DDEg8mG1EOhvn8mc7YpkeVn+Bbx2ltIWuQnIDVG/J5UEWk+I0JxtlVr3Pn6lpewb50WIilEWqYS4byk58KaTDpin0t0/9KrWyEi2sil4S1XqhrDQ0Ds+m3oonV0M/Sfs1mO0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cMJNQ5gbqz13NGg;
	Wed, 10 Sep 2025 19:28:38 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F02F18048E;
	Wed, 10 Sep 2025 19:32:39 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Sep
 2025 19:32:38 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 1/2] mm/damon/lru_sort: support addr_unit for DAMON_LRU_SORT
Date: Wed, 10 Sep 2025 19:32:20 +0800
Message-ID: <20250910113221.1065764-2-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910113221.1065764-1-yanquanmin1@huawei.com>
References: <20250910113221.1065764-1-yanquanmin1@huawei.com>
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

Implement a sysfs file to expose addr_unit for DAMON_LRU_SORT
users. During parameter application, use the configured
addr_unit parameter to perform the necessary initialization.
Similar to the core layer, prevent setting addr_unit to zero.

It is worth noting that when monitor_region_start and
monitor_region_end are unset (i.e., 0), their values will
later be set to biggest_system_ram. At that point, addr_unit
may not be the default value 1. Although we could divide the
biggest_system_ram value by addr_unit, changing addr_unit
without setting monitor_region_start/end should be considered
a user misoperation. And biggest_system_ram is only within
the 0~ULONG_MAX range, system can clearly work correctly with
addr_unit=1. Therefore, if monitor_region_start/end are unset,
always silently reset addr_unit to 1.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/lru_sort.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index b5a5ed16a7a5..14d31009c09e 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -111,6 +111,13 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
+/*
+ * Scale factor for DAMON_LRU_SORT to ops address conversion.
+ *
+ * This parameter must not be set to 0.
+ */
+static unsigned long addr_unit __read_mostly = 1;
+
 /*
  * PID of the DAMON thread
  *
@@ -198,6 +205,15 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
+	/*
+	 * If monitor_region_start/end are unset, always silently
+	 * reset addr_unit to 1.
+	 */
+	if (!monitor_region_start && !monitor_region_end)
+		addr_unit = 1;
+	param_ctx->addr_unit = addr_unit;
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
 		goto out;
@@ -290,6 +306,30 @@ static int damon_lru_sort_turn(bool on)
 	return damon_call(ctx, &call_control);
 }
 
+static int damon_lru_sort_addr_unit_store(const char *val,
+		const struct kernel_param *kp)
+{
+	unsigned long input_addr_unit;
+	int err = kstrtoul(val, 0, &input_addr_unit);
+
+	if (err)
+		return err;
+	if (!input_addr_unit)
+		return -EINVAL;
+
+	addr_unit = input_addr_unit;
+	return 0;
+}
+
+static const struct kernel_param_ops addr_unit_param_ops = {
+	.set = damon_lru_sort_addr_unit_store,
+	.get = param_get_ulong,
+};
+
+module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
+MODULE_PARM_DESC(addr_unit,
+	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)");
+
 static int damon_lru_sort_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-- 
2.43.0

