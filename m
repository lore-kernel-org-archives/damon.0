Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57EB37472B
	for <damon@lists.linux.dev>; Mon,  2 Feb 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044259; cv=none; b=eDO3nEuT/phMSJ8/bqu/HzEgHFZuXG8RlrCa+p/G0QoO7ccqEDpUgtzhmFew1RkVoNXpC2OmR/L7Bt7VW+GUgtnCCEjfqbAOBblaLnquv3mNR+1IauMz4cRUf6IMBvAzSfzFiB6sIMOdAhC3CcumL67mvPD7EP5B6bkXcK8FcOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044259; c=relaxed/simple;
	bh=euhHPSZ9q7E3JiioOhSZA/Ja91LbAlC/CfrqmqmJEdo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XL3kn8a1I23UoCZd54x6mabUsjv7/hHZcIajSR7YVS6qpjJ+MIipdXe9a2YihlV19YsA6qQQfAvKU0kfIKBwgcaLvYRmeiI2rAo2vfC4ban6YtMkwCVvUGFujs1CeQxiWbXn84Ruf6SKo7yh8rk8bwAiTsvOn3a2u8woWkx0Fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4V7f4Z18zJ46cY;
	Mon,  2 Feb 2026 22:56:46 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 8438C40571;
	Mon,  2 Feb 2026 22:57:32 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Feb 2026 17:57:32 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <sj@kernel.org>,
	<damon@lists.linux.dev>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 2/4] mm/damon: Support for synchrounous huge pages collapse
Date: Mon, 2 Feb 2026 14:56:47 +0000
Message-ID: <20260202145650.1795854-3-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
References: <20260202145650.1795854-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

* Support for huge pages collapse, which will be used by
  dynamic_hugepages module.

* Include the new module for compilation

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
---
 include/linux/damon.h | 1 +
 mm/damon/Kconfig      | 7 +++++++
 mm/damon/Makefile     | 1 +
 mm/damon/vaddr.c      | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200..de5a994f92c2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -142,6 +142,7 @@ enum damos_action {
 	DAMOS_LRU_DEPRIO,
 	DAMOS_MIGRATE_HOT,
 	DAMOS_MIGRATE_COLD,
+	DAMOS_COLLAPSE,
 	DAMOS_STAT,		/* Do nothing but only record the stat */
 	NR_DAMOS_ACTIONS,
 };
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 8c868f7035fc..2355aacb6d12 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -110,4 +110,11 @@ config DAMON_STAT_ENABLED_DEFAULT
 	  Whether to enable DAMON_STAT by default.  Users can disable it in
 	  boot or runtime using its 'enabled' parameter.
 
+config DAMON_HOT_HUGEPAGE
+	bool "Build DAMON-based collapse of hot regions (DAMON_HOT_HUGEPAGES)"
+	depends on DAMON_VADDR
+	help
+	 Collapse hot region into huge pages. Hot regions are determined by
+	 DAMON-based sampling
+
 endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index d8d6bf5f8bff..998bddc17819 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
+obj-$(CONFIG_DAMON_HOT_HUGEPAGE)	+= modules-common.o dynamic_hugepages.o
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 23ed738a0bd6..4acbc1a6a5be 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -970,6 +970,9 @@ static unsigned long damon_va_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_NOHUGEPAGE:
 		madv_action = MADV_NOHUGEPAGE;
 		break;
+	case DAMOS_COLLAPSE:
+		madv_action = MADV_COLLAPSE;
+		break;
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
 		return damos_va_migrate(t, r, scheme, sz_filter_passed);
-- 
2.43.0

