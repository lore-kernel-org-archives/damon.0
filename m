Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9912BE63A
	for <damon@lists.linux.dev>; Wed, 13 Aug 2025 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057165; cv=none; b=dqBe1jVeUmoDfcvhliwpbOod778fLiG0zHdL6F3c2FK5o314XMoCncYHH4PGvQtidZ9VYwTp5uQze1jCHsK1+QMKcy8wFOZV6B2jhNwS9nOk/f2PKRcaRa1L//shz9J3MUcWp1r8RsFyDKMa3JSPS/khhNk0h/J6+Pg8kDjzUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057165; c=relaxed/simple;
	bh=NFkQ0BjAyA9lbIoCn/gcSJKu0cBcu4WTTcpeERtypeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHFqULm/X9/wrpMUVgxdVigzbOgcI56Hdi32V58L95Z6+SuCls6Eioi5RzwboC16Kq3EDu6dy74LcSX0EPlOzw7Pz+r9oHJHSsUC88JKz0sR30KDBv+HI+h2ykNpoNdOhEvi2jh/TC87jlAa2YNMcuHn0S+olw5oLEK/IqhRYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1vWy6pGfz1R91H;
	Wed, 13 Aug 2025 11:49:50 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id CAB9B1401F2;
	Wed, 13 Aug 2025 11:52:40 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:40 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 15/16] mm/damon: the byte statistics data type in damos_stat uses unsigned long long
Date: Wed, 13 Aug 2025 13:07:05 +0800
Message-ID: <20250813050706.1564229-16-yanquanmin1@huawei.com>
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

For 32-bit systems, damos_stat now uses unsigned long long for byte
statistics data to avoid integer overflow risks inherent in the
previous design.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 include/linux/damon.h     |  6 +++---
 mm/damon/modules-common.h |  4 ++--
 mm/damon/sysfs-schemes.c  | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index aa045dcb5b5d..d85850cf06c5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -333,10 +333,10 @@ struct damos_watermarks {
  */
 struct damos_stat {
 	unsigned long nr_tried;
-	unsigned long sz_tried;
+	unsigned long long sz_tried;
 	unsigned long nr_applied;
-	unsigned long sz_applied;
-	unsigned long sz_ops_filter_passed;
+	unsigned long long sz_applied;
+	unsigned long long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
diff --git a/mm/damon/modules-common.h b/mm/damon/modules-common.h
index c7048a449321..ae45d0eb960e 100644
--- a/mm/damon/modules-common.h
+++ b/mm/damon/modules-common.h
@@ -36,11 +36,11 @@
 #define DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(stat, try_name,		\
 		succ_name, qt_exceed_name)				\
 	module_param_named(nr_##try_name, stat.nr_tried, ulong, 0400);	\
-	module_param_named(bytes_##try_name, stat.sz_tried, ulong,	\
+	module_param_named(bytes_##try_name, stat.sz_tried, ullong,	\
 			0400);						\
 	module_param_named(nr_##succ_name, stat.nr_applied, ulong,	\
 			0400);						\
-	module_param_named(bytes_##succ_name, stat.sz_applied, ulong,	\
+	module_param_named(bytes_##succ_name, stat.sz_applied, ullong,	\
 			0400);						\
 	module_param_named(nr_##qt_exceed_name, stat.qt_exceeds, ulong,	\
 			0400);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 74056bcd6a2c..3c4882549a28 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -199,10 +199,10 @@ static const struct kobj_type damon_sysfs_scheme_regions_ktype = {
 struct damon_sysfs_stats {
 	struct kobject kobj;
 	unsigned long nr_tried;
-	unsigned long sz_tried;
+	unsigned long long sz_tried;
 	unsigned long nr_applied;
-	unsigned long sz_applied;
-	unsigned long sz_ops_filter_passed;
+	unsigned long long sz_applied;
+	unsigned long long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
@@ -226,7 +226,7 @@ static ssize_t sz_tried_show(struct kobject *kobj, struct kobj_attribute *attr,
 	struct damon_sysfs_stats *stats = container_of(kobj,
 			struct damon_sysfs_stats, kobj);
 
-	return sysfs_emit(buf, "%lu\n", stats->sz_tried);
+	return sysfs_emit(buf, "%llu\n", stats->sz_tried);
 }
 
 static ssize_t nr_applied_show(struct kobject *kobj,
@@ -244,7 +244,7 @@ static ssize_t sz_applied_show(struct kobject *kobj,
 	struct damon_sysfs_stats *stats = container_of(kobj,
 			struct damon_sysfs_stats, kobj);
 
-	return sysfs_emit(buf, "%lu\n", stats->sz_applied);
+	return sysfs_emit(buf, "%llu\n", stats->sz_applied);
 }
 
 static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
@@ -253,7 +253,7 @@ static ssize_t sz_ops_filter_passed_show(struct kobject *kobj,
 	struct damon_sysfs_stats *stats = container_of(kobj,
 			struct damon_sysfs_stats, kobj);
 
-	return sysfs_emit(buf, "%lu\n", stats->sz_ops_filter_passed);
+	return sysfs_emit(buf, "%llu\n", stats->sz_ops_filter_passed);
 }
 
 static ssize_t qt_exceeds_show(struct kobject *kobj,
-- 
2.34.1

