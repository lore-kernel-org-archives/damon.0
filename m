Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC54346A07
	for <damon@lists.linux.dev>; Mon, 15 Dec 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808529; cv=none; b=Iv1O7Ykn05TSEJSPcAUrdH8BH7HvZVMaMYLQL53hffS53fW5hE9GuJj/aZYUG0xVjO84oZvMz5fGoQ9F0lAIRYNRF8K2hgCh2lRdKUBmRostwkz41NmcAgeFqZsAjEpmKr70WckBSHr/zlxEifahrLounUsVJM2JEZQpzxeg5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808529; c=relaxed/simple;
	bh=py2v5MKib+GKeY391dUGPebOchD2kxXp8yt+/fuT7uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ditJqox2FpUgC29qDO9b3HOHrlWGEcPJHRtos+VP2IEsX0Lokg+EJ87NnpHbcD7klr+57+zwSiuKX8/94izBS+qFjCnCY2B+xgPXbvj8/y/+p3ByHuXa+INaTFzAuhV+2ZMWE+YZy9HwIKTkanqr0U3HgqMv7lpazh372EXEHSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 67bb94d8d9c111f0a38c85956e01ac42-20251215
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8abab183-4bb2-4442-8ae4-bef3fe811402,IP:10,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:8abab183-4bb2-4442-8ae4-bef3fe811402,IP:10,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:dedc5b405b7bcdbfc9e97a30cca6564e,BulkI
	D:251215222157H0QJE6TK,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 67bb94d8d9c111f0a38c85956e01ac42-20251215
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.214.33)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1848338231; Mon, 15 Dec 2025 22:21:54 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH 2/2] mm/damon/modules: introduce prdm module for DAMON
Date: Mon, 15 Dec 2025 22:20:57 +0800
Message-ID: <20251215142057.588500-3-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215142057.588500-1-lienze@kylinos.cn>
References: <20251215142057.588500-1-lienze@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces the 'prdm' module, an acronym for Proactive
Reclamation DAMON-based Module.  The development of this module was
inspired by the existing DAMON sample code (prcl.c), extending its core
idea into a production-ready, user-friendly module.

The key enhancement over the original sample is the capability to
concurrently monitor and perform proactive reclamation for multiple
user-specified processes.  This addresses a significant limitation for
practical deployment, where system-wide memory pressure often originates
from several processes rather than a single one.

While achieving similar proactive reclamation is possible through the
existing damo tool with complex manual configuration, the 'prdm'
module significantly reduces the barrier to entry.  Its primary
advantage is simplicity: users only need to provide the PIDs of the
target processes and enable the module.  This "set PIDs and turn on"
approach encapsulates the intricate DAMON and DAMOS configurations,
making advanced memory optimization accessible to non-expert users
without requiring deep knowledge of the underlying framework.

The module leverages the DAMON framework to track memory access patterns
and utilizes the DAMOS subsystem to trigger reclamation actions on
identified cold memory regions across all monitored processes.

By building upon the proven concept from the DAMON samples, adding
crucial multi-target support, and prioritizing ease of use, 'prdm'
provides a robust and accessible tool for optimizing memory usage in
real-world scenarios.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 mm/damon/Kconfig          |   2 +
 mm/damon/Makefile         |   1 +
 mm/damon/modules/Kconfig  |  19 +++
 mm/damon/modules/Makefile |   3 +
 mm/damon/modules/prdm.c   | 254 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 279 insertions(+)
 create mode 100644 mm/damon/modules/Kconfig
 create mode 100644 mm/damon/modules/Makefile
 create mode 100644 mm/damon/modules/prdm.c

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 8c868f7035fc..12e437d3158c 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -110,4 +110,6 @@ config DAMON_STAT_ENABLED_DEFAULT
 	  Whether to enable DAMON_STAT by default.  Users can disable it in
 	  boot or runtime using its 'enabled' parameter.
 
+source "mm/damon/modules/Kconfig"
+
 endmenu
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index d8d6bf5f8bff..6bfabf546c26 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_DAMON_SYSFS)	+= sysfs-common.o sysfs-schemes.o sysfs.o
 obj-$(CONFIG_DAMON_RECLAIM)	+= modules-common.o reclaim.o
 obj-$(CONFIG_DAMON_LRU_SORT)	+= modules-common.o lru_sort.o
 obj-$(CONFIG_DAMON_STAT)	+= modules-common.o stat.o
+obj-$(CONFIG_DAMON_PRDM)	+= modules/
diff --git a/mm/damon/modules/Kconfig b/mm/damon/modules/Kconfig
new file mode 100644
index 000000000000..bce29c0f7224
--- /dev/null
+++ b/mm/damon/modules/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "DAMON ready-to-use modules"
+
+config DAMON_PRDM
+	tristate "Build proactive reclamation DAMON-based module"
+	depends on DAMON && DAMON_VADDR && m
+	default n
+	help
+	  This builds DAMON module for access-aware proactive reclamation of
+	  multiple processes.
+
+	  The module receives pids, monitor access to the virtual address space
+	  of these processes, find memory regions that not accessed, and
+	  proactively reclaim the regions.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/mm/damon/modules/Makefile b/mm/damon/modules/Makefile
new file mode 100644
index 000000000000..f6ae727410ba
--- /dev/null
+++ b/mm/damon/modules/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DAMON_PRDM) += prdm.o
diff --git a/mm/damon/modules/prdm.c b/mm/damon/modules/prdm.c
new file mode 100644
index 000000000000..c107902f07c7
--- /dev/null
+++ b/mm/damon/modules/prdm.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The Proactive Reclamation DAMON-based Module (prdm) is a loadable kernel
+ * module that provides out-of-the-box proactive memory reclamation.  It
+ * monitors the access patterns of specified processes, finds regions that seem
+ * infrequently accessed, and proactively pages out those regions.
+ *
+ * Based on samples/damon/prcl.c written by SeongJae Park <sj@kernel.org>.
+ * This module extends the original by adding support for monitoring multiple
+ * target processes concurrently.
+ *
+ * Author: Enze Li <lienze@kylinos.cn>
+ * Copyright (C) 2025 KylinSoft Corporation.
+ */
+
+#define pr_fmt(fmt) "damon-prdm: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_prdm."
+
+static struct damon_ctx *ctx;
+static LIST_HEAD(target_list);
+static int target_count;
+
+struct prdm_target {
+	struct pid *ppid;
+	int pid;
+	struct list_head list;
+};
+
+static int damon_prdm_target_pid_store(const char *val,
+				       const struct kernel_param *kp);
+static int damon_prdm_target_pid_show(char *buffer,
+				      const struct kernel_param *kp);
+
+static const struct kernel_param_ops target_pid_param_ops = {
+	.set = damon_prdm_target_pid_store,
+	.get = damon_prdm_target_pid_show,
+};
+
+static int target_pid __read_mostly;
+module_param_cb(target_pid, &target_pid_param_ops, &target_pid, 0600);
+MODULE_PARM_DESC(target_pid, "Specifies the pids of the target processes to be monitored");
+
+static int damon_prdm_enable_store(const char *val,
+				   const struct kernel_param *kp);
+
+static const struct kernel_param_ops enabled_param_ops = {
+	.set = damon_prdm_enable_store,
+	.get = param_get_bool,
+};
+
+static bool enabled __read_mostly;
+module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+MODULE_PARM_DESC(enabled, "Enable or disable DAMON_PRDM");
+
+static int damon_prdm_start(void)
+{
+	struct damon_target *target;
+	struct damos *scheme;
+	struct prdm_target *t;
+	struct list_head *pos;
+	struct task_struct *task;
+	int err, exist_target_num;
+
+	pr_info("start\n");
+
+	if (target_count <= 0)
+		return -EINVAL;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	exist_target_num = 0;
+	list_for_each(pos, &target_list) {
+		t = list_entry(pos, struct prdm_target, list);
+		task = get_pid_task(t->ppid, PIDTYPE_PID);
+		if (task) {
+			target = damon_new_target();
+			if (!target) {
+				damon_destroy_ctx(ctx);
+				return -ENOMEM;
+			}
+			target->pid = t->ppid;
+			damon_add_target(ctx, target);
+			exist_target_num++;
+			put_task_struct(task);
+		}
+	}
+
+	if (exist_target_num <= 0)
+		return -EINVAL;
+
+	scheme = damon_new_scheme(
+			&(struct damos_access_pattern) {
+			.min_sz_region = PAGE_SIZE,
+			.max_sz_region = ULONG_MAX,
+			.min_nr_accesses = 0,
+			.max_nr_accesses = 0,
+			.min_age_region = 50,
+			.max_age_region = UINT_MAX},
+			DAMOS_PAGEOUT,
+			0,
+			&(struct damos_quota){},
+			&(struct damos_watermarks){},
+			NUMA_NO_NODE);
+	if (!scheme) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_set_schemes(ctx, &scheme, 1);
+
+	err = damon_start(&ctx, 1, true);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void damon_prdm_stop(void)
+{
+	pr_info("stop\n");
+	if (ctx) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+		ctx = NULL;
+	}
+}
+
+static int damon_prdm_target_pid_store(const char *val,
+				       const struct kernel_param *kp)
+{
+	int err;
+	struct prdm_target *pt;
+
+	if (!damon_initialized())
+		return 0;
+
+	err = kstrtoint(val, 0, &target_pid);
+	if (err)
+		return err;
+
+	pt = kmalloc(sizeof(*pt), GFP_KERNEL);
+	if (!pt)
+		return -ENOMEM;
+
+	pt->ppid = find_get_pid(target_pid);
+	pt->pid = target_pid;
+	INIT_LIST_HEAD(&pt->list);
+	list_add_tail(&pt->list, &target_list);
+	target_count++;
+
+	return 0;
+}
+
+static int damon_prdm_target_pid_show(char *buffer,
+				      const struct kernel_param *kp)
+{
+	char buf[1024];
+	struct list_head *pos;
+	struct prdm_target *t;
+	struct task_struct *task;
+	int len = 0;
+
+	if (!damon_initialized())
+		return 0;
+
+	len = snprintf(buf, sizeof(buf), "%s:", "Tasks");
+	list_for_each(pos, &target_list) {
+		t = list_entry(pos, struct prdm_target, list);
+		task = get_pid_task(t->ppid, PIDTYPE_PID);
+		if (task) {
+			len += snprintf(buf + len, sizeof(buf) - len, " %d",
+					t->pid);
+			put_task_struct(task);
+		} else {
+			len += snprintf(buf + len, sizeof(buf) - len,
+					" %d(exited)", t->pid);
+		}
+	}
+
+	return scnprintf(buffer, 1024, "%s\n", buf);
+}
+
+static int damon_prdm_enable_store(const char *val,
+				   const struct kernel_param *kp)
+{
+	bool is_enabled = enabled;
+	int err;
+
+	if (!damon_initialized())
+		return 0;
+
+	err = kstrtobool(val, &enabled);
+	if (err)
+		return err;
+
+	if (enabled == is_enabled)
+		return 0;
+
+	if (enabled) {
+		err = damon_prdm_start();
+		if (err)
+			enabled = false;
+		return err;
+	}
+	damon_prdm_stop();
+	return 0;
+}
+
+static void __exit damon_prdm_exit(void)
+{
+	struct prdm_target *entry, *tmp;
+
+	pr_debug("%s", __func__);
+	damon_prdm_stop();
+
+	list_for_each_entry_safe(entry, tmp, &target_list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	INIT_LIST_HEAD(&target_list);
+	target_count = 0;
+}
+
+static int __init damon_prdm_init(void)
+{
+	if (!damon_initialized()) {
+		if (enabled)
+			enabled = false;
+		return -ENOMEM;
+	}
+
+	pr_debug("%s", __func__);
+	return 0;
+}
+
+module_init(damon_prdm_init);
+module_exit(damon_prdm_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("A DAMON module for proactive reclamation of multiple processes");
+MODULE_AUTHOR("SeongJae Park <sj@kernel.org>, Enze Li <lienze@kylinos.cn>");
-- 
2.43.0

