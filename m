Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A864428463
	for <damon@lists.linux.dev>; Thu, 30 Apr 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556525; cv=none; b=mLr2e0m8twtSqXzpA6ksxjTD+n6EHn3QCjQwM7OohJaDZifYuOg17Yif9+0eaV6wXo/ARI+C3WnNemY9le2mOhOApYuxkK1MEROQiTEhaXTgLD7x7C6QNT1DFQ+fxWFJsd6V12+NOK2eneToEFNXBaEiCfI+5pq7mAZ/JDeUwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556525; c=relaxed/simple;
	bh=AAL8E3/NfZrKAYY+KhME7Nr97k7PJhJGRLlZPeRxTYc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTGsS200A9k9ciXDLTxtBS8dAm0EEZcduQyyJ2fW3phX2dYCAeuz7jAcwA9EbY/W+ekgHFbC9MwR9bkolk15IdCN92IHfUfh/7jbGdxrA5fN0A6E0z+5eH61mMId7BX2tJiXkK0+Rtwj1J9kEwAIWQJNsFsmNHipFawsQpo4ELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5wM010yKzJ46ZY;
	Thu, 30 Apr 2026 21:41:48 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 665044058B;
	Thu, 30 Apr 2026 21:41:55 +0800 (CST)
Received: from mscphis01197.huawei.com (10.123.65.218) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 16:41:54 +0300
From: <gutierrez.asier@huawei-partners.com>
To: <gutierrez.asier@huawei-partners.com>, <artem.kuzin@huawei.com>,
	<stepanov.anatoly@huawei.com>, <wangkefeng.wang@huawei.com>,
	<yanquanmin1@huawei.com>, <zuoze1@huawei.com>, <damon@lists.linux.dev>,
	<sj@kernel.org>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v1 4/4] Documentation/admin-guide/mm/damon: add DAMON-based Hugepage Management documentation
Date: Thu, 30 Apr 2026 13:41:39 +0000
Message-ID: <20260430134139.2446417-5-gutierrez.asier@huawei-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
References: <20260430134139.2446417-1-gutierrez.asier@huawei-partners.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500003.china.huawei.com (7.188.49.51)

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Add documentation for the DAMON-based Hugepage Management (DAMON_HUGEPAGE)
feature, which automatically manages huge pages by identifying cold memory
regions and collapsing them back to regular pages. The documentation covers
the module's features, operation, and all available module parameters.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
---
 .../admin-guide/mm/damon/hugepage.rst (new)   | 258 ++++++++++++++++++
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 2 files changed, 259 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/hugepage.rst b/Documentation/admin-guide/mm/damon/hugepage.rst
new file mode 100644
index 000000000000..ee50cfa79281
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/hugepage.rst
@@ -0,0 +1,258 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+DAMON-based huge page collapsing
+=======================
+
+DAMON-based huge page collapsing (DAMON_HUGEPAGE) is a static kernel module
+that aimed to collapse hot regions into huge pages.
+
+Where Proactive huge page collapsing is Required?
+========================================
+
+The amount of available memory grows faster than the amount of TLB entries.
+This leads to higher amount of TLB misses and excesive cycle wastes. Huge
+pages are meant to solve this problem. However, huge pages usually lead to
+memory fragmentation and memory waste.
+
+Collapsing selectively hot regions in a specific process can avoid big
+memory fragmentation, while increasing TLB performance.
+
+DAMON_HUGEPAGE solves this by:
+
+- Identifying hot regions that have been accessed for a configured time
+- Automatically collapsing the regions into huge pages back
+- Auto tune the huge page usage ratio to meet desired targets
+- Controlling the collapse rate with configurable quotas to avoid performance
+  degradation
+
+
+How It Works?
+=============
+
+DAMON_HUGEPAGE uses kdamond to identify anonymous memory regions that are:
+
+1. Large enough to be backed by huge pages (``PMD_SIZE`` or larger)
+2. Have been accessed for a configured time period
+
+Once identified, DAMON_HUGEPAGE triggers synchronous partial collapse of those
+regions. The collapse operation is controlled by quotas to limit the impact on
+system performance.
+
+The module also supports automatic tuning of the collapse rate to achieve a
+desired huge page usage ratio. Administrators can configure a target percentage
+of huge page usage vs total anonymous memory usage.
+
+Additionally, the module accepts manual feedback from system administrators to
+adjust the effective quota level based on observed system behavior.
+
+Interface: Module Parameters
+============================
+
+To use this feature, you should first ensure your system is running on a kernel
+that is built with ``CONFIG_DAMON_HUGEPAGE=y``.
+
+To let sysadmins enable or disable it and tune for the given system,
+DAMON_HUGEPAGE utilizes module parameters.  That is, you can put
+``damon_hugepage.<parameter>=<value>`` on the kernel boot command line or write
+proper values to ``/sys/module/damon_hugepage/parameters/<parameter>`` files.
+
+Below are the description of each parameter.
+
+enabled
+-------
+
+Enable or disable DAMON_HUGEPAGE.
+
+You can enable DAMON_HUGEPAGE by setting the value of this parameter as ``Y``.
+Setting it as ``N`` disables DAMON_HUGEPAGE.  Note that DAMON_HUGEPAGE could do
+no real monitoring and collapse due to the activation condition.
+
+commit_inputs
+-------------
+
+Make DAMON_HUGEPAGE reads the input parameters again, except ``enabled``.
+
+Input parameters that updated while DAMON_HUGEPAGE is running are not applied
+by default.  Once this parameter is set as ``Y``, DAMON_HUGEPAGE reads values
+of parametrs except ``enabled`` again.  Once the re-reading is done, this
+parameter is set as ``N``.  If invalid parameters are found while the
+re-reading, DAMON_HUGEPAGE will be disabled.
+
+Once ``Y`` is written to this parameter, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel may exhibit undefined behavior.
+
+min_age
+-------
+
+Time threshold for hot memory regions identification in microseconds.
+
+100 milliseconds by default.
+
+quota_ms
+--------
+
+Limit of time for the collapse in milliseconds.
+
+DAMON_HUGEPAGE tries to use only up to this time within a time window
+(quota_reset_interval_ms) for trying collapse hot pages.  This can be
+used for limiting CPU consumption of DAMON_HUGEPAGE.  If the value is zero, the
+limit is disabled.
+
+10 ms by default.
+
+quota_reset_interval_ms
+-----------------------
+
+The time/size quota charge reset interval in milliseconds.
+
+The charget reset interval for the quota of time (quota_ms) and size
+(quota_sz).  That is, DAMON_HUGEPAGE does not try collapsing for more than
+quota_ms milliseconds or quota_sz bytes within quota_reset_interval_ms
+milliseconds.
+
+1 second by default.
+
+quota_autotune_feedback
+-----------------------
+
+User-specifiable feedback for auto-tuning of the effective quota.
+
+While keeping the caps that set by other quotas, DAMON_HUGEPAGE automatically
+increases and decreases the effective level of the quota aiming receiving this
+feedback of value ``10,000`` from the user.  DAMON_HUGEPAGE assumes the feedback
+value and the quota are positively proportional.  Value zero means disabling
+this auto-tuning feature.
+
+Disabled by default.
+
+monitored_pid
+----------------
+
+PID of the task that is going to be monitored for hot regions.
+
+quota_percentage_hugepage
+----------------
+
+Huge page consumption to total memory anonymous memory consumption ratio goal
+in bp ``(10,000)``. DAMON_HUGEPAGE automatically increases and decreases page
+collapse aggressiveness in order to achieve the given value.
+
+sample_interval
+---------------
+
+Sampling interval for the monitoring in microseconds.
+
+The sampling interval of DAMON for the cold memory monitoring.  Please refer to
+the DAMON documentation (:doc:`usage`) for more detail.
+
+aggr_interval
+-------------
+
+Aggregation interval for the monitoring in microseconds.
+
+The aggregation interval of DAMON for the cold memory monitoring.  Please
+refer to the DAMON documentation (:doc:`usage`) for more detail.
+
+min_nr_regions
+--------------
+
+Minimum number of monitoring regions.
+
+The minimal number of monitoring regions of DAMON for the cold memory
+monitoring.  This can be used to set lower-bound of the monitoring quality.
+But, setting this too high could result in increased monitoring overhead.
+Please refer to the DAMON documentation (:doc:`usage`) for more detail.
+
+Note that this must be 3 or higher. Please refer to the :ref:`Monitoring
+<damon_design_monitoring>` section of the design document for the rationale
+behind this lower bound.
+
+max_nr_regions
+--------------
+
+Maximum number of monitoring regions.
+
+The maximum number of monitoring regions of DAMON for the cold memory
+monitoring.  This can be used to set upper-bound of the monitoring overhead.
+However, setting this too low could result in bad monitoring quality.  Please
+refer to the DAMON documentation (:doc:`usage`) for more detail.
+
+addr_unit
+---------
+
+A scale factor for memory addresses and bytes.
+
+This parameter is for setting and getting the :ref:`address unit
+<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_HUGEPAGE.
+
+``monitor_region_start`` and ``monitor_region_end`` should be provided in this
+unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
+``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+Then DAMON_HUGEPAGE will work for 10 KiB length of physical address range that
+starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
+
+``bytes_hugepage_tried_regions`` and ``bytes_hugepage_regions`` are also in
+this unit.  For example, let's suppose values of ``addr_unit``,
+``bytes_hugepage_tried_regions`` and ``bytes_hugepage_regions`` are
+``1048576``, ``42``, and ``32``, respectively.  Then it means DAMON_HUGEPAGE
+tried to collapse 42 MiB memory and successfully collapse 32 MiB memory in
+total.
+
+If unsure, use only the default value (``1``) and forget about this.
+
+
+kdamond_pid
+-----------
+
+PID of the DAMON thread.
+
+If DAMON_HUGEPAGE is enabled, this becomes the PID of the worker thread.  Else,
+-1.
+
+nr_hugepage_tried_regions
+------------------------
+
+Number of memory regions that tried to be collapsed by DAMON_HUGEPAGE.
+
+bytes_hugepage_tried_regions
+---------------------------
+
+Total bytes of memory regions that tried to be collapsed by DAMON_HUGEPAGE.
+
+nr_hugepage_regions
+--------------------
+
+Number of memory regions that successfully be collapsed by DAMON_HUGEPAGE.
+
+bytes_hugepage_regions
+-----------------------
+
+Total bytes of memory regions that successfully be collapsed by DAMON_HUGEPAGE.
+
+nr_quota_exceeds
+----------------
+
+Number of times that the time/space quota limits have exceeded.
+
+Example
+=======
+
+Below runtime example commands make DAMON_HUGEPAGE to find memory regions of 
+the task with PID 1234 that have been accessed in the last 100 millseconds or
+more and pages out. The pagecollapsing is limited to be done only up to 1 GiB
+per second to avoid DAMON_HUGEPAGE consuming too much CPU time for the collapse
+operation. ::
+
+    # cd /sys/module/damon_hugepage/parameters
+    # echo 100000 > min_age
+    # echo $((1 * 1024 * 1024 * 1024)) > quota_sz
+    # echo 1000 > quota_reset_interval_ms
+    # echo 1234 > monitored_pid
+    # echo Y > enabled
+
+Note that this module (damon_hugepage) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 3ce3164480c7..6f2cad21a2da 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -15,3 +15,4 @@ access monitoring and access-aware system operations.
    reclaim
    lru_sort
    stat
+   hugepage
-- 
2.43.0

