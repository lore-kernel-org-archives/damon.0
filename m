Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABD37647A
	for <damon@lists.linux.dev>; Mon,  2 Feb 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044257; cv=none; b=dWLrWBmRLpMv5LifNAXvgYI7RbWMcxCEGeTGhrwDwqsr9ks3NC83od0dtaJx/1xjCTK1TvsIpKX/L/4jI6pSKDwqSQPawRj/mr8eXMWNGD3wMMLXs0DBuz5NUqidz0cNTZ7QbE84KWjVTk7UjjTeKvFSymLboQLVBCw78LFylHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044257; c=relaxed/simple;
	bh=M9aIX50H57oCX25mt1AlnsOavPdb1afHkaJpeelUWRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q45RzkRomptZhEXTsHORtDkhuigeeTV4tZVJBA6A/7AQqfBeqY+bt47tr1W1D0MzYeKDVVmZpKa/xdteSlOeoZL8O3lyLRyMnKo7xBznU5HbS8Ann6Hk45ZUJKOJbjT10x+xH7m2QxtMsl+WpHKman9PsdL4oF5xk4qkeQpofKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4V7g0ZwwzJ46cb;
	Mon,  2 Feb 2026 22:56:47 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id EF3A740539;
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
Subject: [RFC PATCH v1 4/4] documentation/mm/damon: Documentation for the dynamic_hugepages module
Date: Mon, 2 Feb 2026 14:56:49 +0000
Message-ID: <20260202145650.1795854-5-gutierrez.asier@huawei-partners.com>
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

Documentation for dynamic_hugepage DAMON module.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Co-developed-by: Anatoly Stepanov <stepanov.anatoly@huawei.com>
---
 .../mm/damon/dynamic_hugepages.rst (new)      | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/dynamic_hugepages.rst b/Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
new file mode 100644
index 000000000000..a6afb0910661
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/dynamic_hugepages.rst
@@ -0,0 +1,173 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+DAMON-based Dynamic Huge Pages Collapsing
+=========================================
+
+
+DAMON-based dynamic hugepages collapsing (DAMON_HOT_HUGEPAGE) is a kernel module
+that monitors the system and picks the 3 most active tasks. Then, it starts a
+new DAMON thread for each of those 3 tasks, which will collapse hot regions into
+huge pages.
+
+Where Dynamic Huge Pages Collapsing is Required?
+================================================
+
+As main memory availability increases, the number of TLB entries does not
+increase proportionally. This adds more pressure to TLB. Huge pages are a
+solution. However, since turning on transparent huge pages globally may lead to
+fragmentation and memory waste, it is usually turned off.
+
+This module allows to automatically detect hot applications and collapse VMA
+that are hot.
+
+How It Works?
+=============
+
+DAMON_HOT_HUGEPAGE spawns a new kthread which will monitor the applications in
+the system. The monitor thread will calculate the moving average of the sum of
+utimes of all the threads for all the processes. Then, pick the top three and
+launch a damon process to monitor the hot regions in those tasks.
+
+Since we don't know the minaccess number in advance, we set it to 90 initially,
+and we keep decreasing that minaccess until a collapse happens.
+
+If a task turns cold, the monitor thread will detect it (it will not fall in the
+top three hot tasks), and stop the damon thread for that task.
+
+Interface: Module Parameters
+============================
+
+To use this feature, you should first ensure your system is running on a kernel
+that is built with CONFIG_DAMON_HOT_HUGEPAGE=y.
+
+To let sysadmins enable or disable it and tune for the given system,
+DAMON_HOT_HUGEPAGE utilizes module parameters. That is, you can put
+damon_dynamic_hotpages.<parameter>=<value> on the kernel boot command line or
+write proper values to /sys/module/damon_dynamic_hotpages/parameters/<parameter>
+files.
+
+Below are the description of each parameter.
+
+enabled
+-------
+
+Enable or disable DAMON_HOT_HUGEPAGE.
+
+You can enable DAMON_HOT_HUGEPAGE by setting the value of this parameter as Y.
+Setting it as N disables DAMON_HOT_HUGEPAGE. Note that, although
+DAMON_HOT_HUGEPAGE monitors the system and starts damon threads, those threads
+could do no real monitoring due to the watermarks-based activation condition.
+Refer to below descriptions for the watermarks parameter for this.
+
+quota_ms
+--------
+
+Limit of time for collapsing memory regions in milliseconds.
+
+DAMON_HOT_HUGEPAGE tries to use only up to this time within a time window
+(quota_reset_interval_ms) for trying memory collapse. This can be used for
+limiting CPU consumption of DAMONHOT_HUGEPAGE. If the value is zero, the limit
+is disabled.
+
+10 ms by default.
+
+quota_reset_interval_ms
+-----------------------
+
+The time quota charge reset interval in milliseconds.
+
+The charge reset interval for the quota of time (quota_ms). That is,
+DAMON_HOT_HUGEPAGE does not collapse memory for more than quota_ms milliseconds
+or quotasz bytes within quota_reset_interval_ms milliseconds.
+
+1 second by default.
+
+wmarks_interval
+---------------
+
+The watermarks check time interval in microseconds.
+
+Minimal time to wait before checking the watermarks, when DAMON_HOT_HUGEPAGE is
+enabled but inactive due to its watermarks rule. 5 seconds by default.
+
+wmarks_high
+-----------
+
+Free memory rate (per thousand) for the high watermark.
+
+If free memory of the system in bytes per thousand bytes is higher than this,
+DAMON_HOT_HUGEPAGE becomes inactive, so it does nothing but periodically checks
+the watermarks. 200 (20%) by default.
+
+wmarks_mid
+----------
+
+Free memory rate (per thousand) for the middle watermark.
+
+If free memory of the system in bytes per thousand bytes is between this and the
+low watermark, DAMON_HOT_HUGEPAGE becomes active, so starts the monitoring and
+the memory collapsing. 150 (15%) by default.
+
+wmarks_low
+----------
+
+Free memory rate (per thousand) for the low watermark.
+
+If free memory of the system in bytes per thousand bytes is lower than this,
+DAMON_HOT_HUGEPAGE becomes inactive, so it does nothing but periodically checks
+the watermarks. 50 (5%) by default.
+
+sample_interval
+---------------
+
+Sampling interval for the monitoring in microseconds.
+
+The sampling interval of DAMON for the cold memory monitoring. Please refer to
+the DAMON documentation (:doc:usage) for more detail. 5ms by default.
+
+aggr_interval
+-------------
+
+Aggregation interval for the monitoring in microseconds.
+
+The aggregation interval of DAMON for the cold memory monitoring. Please refer
+to the DAMON documentation (:doc:usage) for more detail. 100ms by default.
+
+min_nr_regions
+--------------
+
+Minimum number of monitoring regions.
+
+The minimal number of monitoring regions of DAMON for the cold memory
+monitoring. This can be used to set lower-bound of the monitoring quality. But,
+setting this too high could result in increased monitoring overhead. Please
+refer to the DAMON documentation (:doc:usage) for more detail. 10 by default.
+
+max_nr_regions
+--------------
+
+Maximum number of monitoring regions.
+
+The maximum number of monitoring regions of DAMON for the cold memory
+monitoring. This can be used to set upper-bound of the monitoring overhead.
+However, setting this too low could result in bad monitoring quality. Please
+refer to the DAMON documentation (:doc:usage) for more detail. 1000 by defaults.
+
+monitored_pids The PIDs of the tasks that are being actively monitored by DAMON
+threads
+
+Example
+=======
+Below runtime example commands make DAMON_HOT_HUGEPAGE to find memory regions in
+the 3 most active tasks. It also asks DAMON_HOT_HUGEPAGE to do nothing if the
+system's free memory rate is more than 50%, but start the real works if it
+becomes lower than 40%.
+
+    # cd /sys/module/damon_dynamic_hotpages/parameters/
+    # echo 10 > quota_ms
+    # echo 1000 > quota_reset_interval_ms
+    # echo 500 > wmarks_high
+    # echo 400 > wmarks_mid
+    # echo 200 > wmarks_low
+    # echo Y > enabled
\ No newline at end of file
-- 
2.43.0

