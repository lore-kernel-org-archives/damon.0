Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CB274B4D
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750237; cv=none; b=f9CRvrTxSQQL3x5t29jGMfSrJUwuzeGFZmDrKzHveEJ9Nydin/kUAKOF/xk8Qegltp8CNj43oQiigsLFdlDJf86wcEKXycPkVgun33d4aoML9w2QvbQgo3v5xlVWzKcTrMvp8QnMN45KQoX67iJhEqUs+gVPK+J5DjGV1wetrtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750237; c=relaxed/simple;
	bh=BD1MVTGwTR55TmPK5/rBN1KO8hZFn4MwwvbhIkc9tdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG8Nh+B9bXfBF9uqQFhlrXrC4YuTUveeFFJ7+RhXuRYYEdAJxvaf6JBqj1GnWJ07hQRm2a8defmqzdRX1YZ5sUqTUDMhFCkKigIMWvY3EKjByR9wlJG3QhUEHJ7KRTJ/SLapHzm2qhPIDs0q1HpPDI5g51yCJpvcIeZJ5k9lgBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ma5wNYpL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ma5wNYpL"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506a6cf8242so28982871cf.1
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750234; x=1772355034; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYiMdgFVvusXEx98vFRcNZk0pTiGBH9Jq4UQYwtGtaw=;
        b=ma5wNYpL6936qy6MYm9UrI8G4Zi03GvlrXH53o+3MQWCMkPrrxQTT4NXN47+uf3dym
         tslJ5gNEJdDx+yoTf7/bHIy4W6v/w9Jsx+FZ1KCb1ZLQB6OECd2pG+h/W+xasXSOjm8P
         ntKIEuwuh9R7CQgdwjZjYTqvMwJYnIw/rgwBiXlw8JCpzRnk3r7YWaefeSS7sVy6Fjne
         6YnmL3gfq9pDcm6jW3rJQ2O/aEGD98EhaFKXDI74F2zFnM5dx1IBn6ejoIjVb9aclmzr
         gbQ1+r8YHBChgkpLA+2ElHtmb0aL9uIhlfgsNMhsx1SGru9+cgDYRjYhg5NRp+yD7Tfd
         unMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750234; x=1772355034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYiMdgFVvusXEx98vFRcNZk0pTiGBH9Jq4UQYwtGtaw=;
        b=ClU2CFCF5c0dmqDJMnEPsxGlz/eFtaLHYoyRbnHiq1Ko2+Q1mHgo1lq3vW7xkRYsi+
         w2qy+dogL5FQn9/larOj5jHAMFJ7AygpsJWnhEGCC8Hnlf0WWt8xqeBjHmO6Jfc7fy3r
         hs7DNzE1ornZOR5tns1qn7MIo+Ips2Gb2B6EiPrQsbnn8x0QfKcudLLXm6nlUO2nbk5n
         nPrg8ztxjIV/hpAIGOz1JgZSj7fkDh15+xrAJBSkcXn03U9fsBI4IS+iFmLWz7rW1FhP
         Vd9QgRHU9GGY8VyqE1J80Bwn6/nzkd2/uAScbdVhzpEENcUt11OE1EAbLmjRulISwzBM
         /EQw==
X-Forwarded-Encrypted: i=1; AJvYcCWUTCpBzAfkvsfijjVLo5j4DZTqa/Iw6m/i8Y8aawC5qGD2qjDE/BJJXZbC7URmf29Q99ZyGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjDMs0aWj4aX3rhR2scNqWSpz+UXVrt19Ww26ioivn+lxANpD3
	PlXmtSdXr/82jZa+BEXJ6T+4G/KsRJbdpAStNobYO5gXUjLubHHSq8oaLmEOrTUpWT4=
X-Gm-Gg: AZuq6aIq/BqqDwNYfkp9RjrYuRyEvxJAWm02Z8x1KujFLrLKHBaAG/qkK5YmTrAbUJk
	uMEgdyX5kT6IQEDt1ysenhQqMxL/XxvrrW0P4jy5SIHJ+p5Iaz6mWBRfCXze7u5Zy+3ZMaEiDXV
	1CInutWcAgz17t/GqfMrsJs0SaXy6+zdhcsqpCkjk6NVNFk0Af+M58GMNFch4vmlP8PFE9TGOyA
	U7f+ku3IGRaq+DuFaRmlrl5rnW7G4tnCm24CG3vj3N+9fnwpZbbaXYvhmPaBRBkZQLnox4/rkN6
	nPKwM2An95pSjkIQE4v4OzsiQGq/P1Fby+Jr60yaSP21LA6M9+wYs1bW/E3yEVA8qkpGRqUUl9F
	xfmPbOsgUz5QHBmObfxMUvVGD9xYb+PBhqPFTzn++ENfnJcGkfo+eFfeZAelbQn+LJJ7N1/y68u
	6CNMgau6Oi/3mXmMif3upemqjZIFzwYlDbYxcAU3Camo8en5Qj4quF8MsJxIzdj+e2zzfUVTY/Q
	S4Bwn2hTCCHVD8=
X-Received: by 2002:ac8:5711:0:b0:506:21ff:af13 with SMTP id d75a77b69052e-5070bba24cemr71385411cf.1.1771750233590;
        Sun, 22 Feb 2026 00:50:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:33 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 26/27] cxl: add cxl_mempolicy sample PCI driver
Date: Sun, 22 Feb 2026 03:48:41 -0500
Message-ID: <20260222084842.1824063-27-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sample CXL type-3 driver that registers device memory as
private-node NUMA memory reachable only via explicit mempolicy
(set_mempolicy / mbind).

Probe flow:
  1. Call cxl_pci_type3_probe_init() for standard CXL device setup
  2. Look for pre-committed RAM regions; if none exist, create one
     using cxl_get_hpa_freespace() + cxl_request_dpa() +
     cxl_create_region()
  3. Convert the region to sysram via devm_cxl_add_sysram() with
     private=true and MMOP_ONLINE_MOVABLE
  4. Register node_private_ops with NP_OPS_MIGRATION | NP_OPS_MEMPOLICY
     so the node is excluded from default allocations

The migrate_to callback uses alloc_migration_target() with
__GFP_THISNODE | __GFP_PRIVATE to keep pages on the target node.

Move struct migration_target_control from mm/internal.h to
include/linux/migrate.h so the driver can use alloc_migration_target()
without depending on mm-internal headers.

Usage:
   echo $PCI_DEV > /sys/bus/pci/drivers/cxl_pci/unbind
   echo $PCI_DEV > /sys/bus/pci/drivers/cxl_mempolicy/bind

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/Kconfig                           |   2 +
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/type3_drivers/Kconfig             |   2 +
 drivers/cxl/type3_drivers/Makefile            |   2 +
 .../cxl/type3_drivers/cxl_mempolicy/Kconfig   |  16 +
 .../cxl/type3_drivers/cxl_mempolicy/Makefile  |   4 +
 .../type3_drivers/cxl_mempolicy/mempolicy.c   | 297 ++++++++++++++++++
 include/linux/migrate.h                       |   7 +-
 mm/internal.h                                 |   7 -
 9 files changed, 331 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cxl/type3_drivers/Kconfig
 create mode 100644 drivers/cxl/type3_drivers/Makefile
 create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
 create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
 create mode 100644 drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index f99aa7274d12..1648cdeaa0c9 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -278,4 +278,6 @@ config CXL_ATL
 	depends on CXL_REGION
 	depends on ACPI_PRMT && AMD_NB
 
+source "drivers/cxl/type3_drivers/Kconfig"
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..94d2b2233bf8 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -19,3 +19,5 @@ cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+
+obj-y += type3_drivers/
diff --git a/drivers/cxl/type3_drivers/Kconfig b/drivers/cxl/type3_drivers/Kconfig
new file mode 100644
index 000000000000..369b21763856
--- /dev/null
+++ b/drivers/cxl/type3_drivers/Kconfig
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+source "drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig"
diff --git a/drivers/cxl/type3_drivers/Makefile b/drivers/cxl/type3_drivers/Makefile
new file mode 100644
index 000000000000..2b82265ff118
--- /dev/null
+++ b/drivers/cxl/type3_drivers/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_MEMPOLICY) += cxl_mempolicy/
diff --git a/drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig b/drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
new file mode 100644
index 000000000000..3c45da237b9f
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_mempolicy/Kconfig
@@ -0,0 +1,16 @@
+config CXL_MEMPOLICY
+	tristate "CXL Private Memory with Mempolicy Support"
+	depends on CXL_PCI
+	depends on CXL_REGION
+	depends on NUMA
+	depends on MIGRATION
+	help
+	  Minimal driver for CXL memory devices that registers memory as
+	  N_MEMORY_PRIVATE with mempolicy support.  The memory is isolated
+	  from default allocations and can only be reached via explicit
+	  mempolicy (set_mempolicy or mbind).
+
+	  No compression, no PTE controls, the memory behaves like normal
+	  DRAM but is excluded from fallback allocations.
+
+	  If unsure say 'n'.
diff --git a/drivers/cxl/type3_drivers/cxl_mempolicy/Makefile b/drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
new file mode 100644
index 000000000000..dfb58fc88ad9
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_mempolicy/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_MEMPOLICY) += cxl_mempolicy.o
+cxl_mempolicy-y := mempolicy.o
+ccflags-y += -I$(srctree)/drivers/cxl
diff --git a/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c b/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c
new file mode 100644
index 000000000000..1c19818eb268
--- /dev/null
+++ b/drivers/cxl/type3_drivers/cxl_mempolicy/mempolicy.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 Meta Platforms, Inc. All rights reserved. */
+/*
+ * CXL Mempolicy Driver
+ *
+ * Minimal driver for CXL memory devices that registers memory as
+ * N_MEMORY_PRIVATE with mempolicy support but no PTE controls.  The
+ * memory behaves like normal DRAM but is isolated from default allocations,
+ * it can only be reached via explicit mempolicy (set_mempolicy/mbind).
+ *
+ * Usage:
+ *   1. Unbind device from cxl_pci:
+ *        echo $PCI_DEV > /sys/bus/pci/drivers/cxl_pci/unbind
+ *   2. Bind to cxl_mempolicy:
+ *        echo $PCI_DEV > /sys/bus/pci/drivers/cxl_mempolicy/bind
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/xarray.h>
+#include <linux/node_private.h>
+#include <linux/migrate.h>
+#include <cxl/mailbox.h>
+#include "cxlmem.h"
+#include "cxl.h"
+
+struct cxl_mempolicy_ctx {
+	struct cxl_region *cxlr;
+	struct cxl_endpoint_decoder *cxled;
+	int nid;
+};
+
+static DEFINE_XARRAY(ctx_xa);
+
+static struct cxl_mempolicy_ctx *memdev_to_ctx(struct cxl_memdev *cxlmd)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlmd->dev.parent);
+
+	return xa_load(&ctx_xa, (unsigned long)pdev);
+}
+
+static int cxl_mempolicy_migrate_to(struct list_head *folios, int nid,
+				    enum migrate_mode mode,
+				    enum migrate_reason reason,
+				    unsigned int *nr_succeeded)
+{
+	struct migration_target_control mtc = {
+		.nid = nid,
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE |
+			    __GFP_PRIVATE,
+		.reason = reason,
+	};
+
+	return migrate_pages(folios, alloc_migration_target, NULL,
+			     (unsigned long)&mtc, mode, reason, nr_succeeded);
+}
+
+static void cxl_mempolicy_folio_migrate(struct folio *src, struct folio *dst)
+{
+}
+
+static const struct node_private_ops cxl_mempolicy_ops = {
+	.migrate_to	= cxl_mempolicy_migrate_to,
+	.folio_migrate	= cxl_mempolicy_folio_migrate,
+	.flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
+};
+
+static struct cxl_region *create_ram_region(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mempolicy_ctx *ctx = memdev_to_ctx(cxlmd);
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *cxlr;
+	resource_size_t ram_size, avail;
+
+	ram_size = cxl_ram_size(cxlmd->cxlds);
+	if (ram_size == 0) {
+		dev_info(&cxlmd->dev, "no RAM capacity available\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ram_size = ALIGN_DOWN(ram_size, SZ_256M);
+	if (ram_size == 0) {
+		dev_info(&cxlmd->dev,
+			 "RAM capacity too small (< 256M)\n");
+		return ERR_PTR(-ENOSPC);
+	}
+
+	dev_info(&cxlmd->dev, "creating RAM region for %lld MB\n",
+		 ram_size >> 20);
+
+	cxlrd = cxl_get_hpa_freespace(cxlmd, ram_size, &avail);
+	if (IS_ERR(cxlrd)) {
+		dev_err(&cxlmd->dev, "no HPA freespace: %ld\n",
+			PTR_ERR(cxlrd));
+		return ERR_CAST(cxlrd);
+	}
+
+	cxled = cxl_request_dpa(cxlmd, CXL_PARTMODE_RAM, ram_size);
+	if (IS_ERR(cxled)) {
+		dev_err(&cxlmd->dev, "failed to request DPA: %ld\n",
+			PTR_ERR(cxled));
+		cxl_put_root_decoder(cxlrd);
+		return ERR_CAST(cxled);
+	}
+
+	cxlr = cxl_create_region(cxlrd, &cxled, 1);
+	cxl_put_root_decoder(cxlrd);
+	if (IS_ERR(cxlr)) {
+		dev_err(&cxlmd->dev, "failed to create region: %ld\n",
+			PTR_ERR(cxlr));
+		cxl_dpa_free(cxled);
+		return cxlr;
+	}
+
+	ctx->cxled = cxled;
+	dev_info(&cxlmd->dev, "created region %s\n",
+		 dev_name(cxl_region_dev(cxlr)));
+	return cxlr;
+}
+
+static int setup_private_node(struct cxl_memdev *cxlmd,
+			      struct cxl_region *cxlr)
+{
+	struct cxl_mempolicy_ctx *ctx = memdev_to_ctx(cxlmd);
+	struct range hpa_range;
+	int rc;
+
+	device_release_driver(cxl_region_dev(cxlr));
+
+	rc = devm_cxl_add_sysram(cxlr, true, MMOP_ONLINE_MOVABLE);
+	if (rc) {
+		dev_err(cxl_region_dev(cxlr),
+			"failed to add sysram: %d\n", rc);
+		if (device_attach(cxl_region_dev(cxlr)) < 0)
+			dev_warn(cxl_region_dev(cxlr),
+				 "failed to re-attach driver\n");
+		return rc;
+	}
+
+	rc = cxl_get_region_range(cxlr, &hpa_range);
+	if (rc) {
+		dev_err(cxl_region_dev(cxlr),
+			"failed to get region range: %d\n", rc);
+		return rc;
+	}
+
+	ctx->nid = phys_to_target_node(hpa_range.start);
+	if (ctx->nid == NUMA_NO_NODE)
+		ctx->nid = memory_add_physaddr_to_nid(hpa_range.start);
+
+	rc = node_private_set_ops(ctx->nid, &cxl_mempolicy_ops);
+	if (rc) {
+		dev_err(cxl_region_dev(cxlr),
+			"failed to set ops on node %d: %d\n", ctx->nid, rc);
+		ctx->nid = NUMA_NO_NODE;
+		return rc;
+	}
+
+	dev_info(&cxlmd->dev,
+		 "node %d registered as private mempolicy memory\n", ctx->nid);
+	return 0;
+}
+
+static int cxl_mempolicy_attach_probe(struct cxl_memdev *cxlmd)
+{
+	struct cxl_region *regions[8];
+	struct cxl_region *cxlr;
+	int nr, i;
+	int rc;
+
+	dev_info(&cxlmd->dev,
+		 "cxl_mempolicy attach: looking for regions\n");
+
+	/* Phase 1: look for pre-committed RAM regions */
+	nr = cxl_get_committed_regions(cxlmd, regions, ARRAY_SIZE(regions));
+	for (i = 0; i < nr; i++) {
+		if (cxl_region_mode(regions[i]) != CXL_PARTMODE_RAM) {
+			put_device(cxl_region_dev(regions[i]));
+			continue;
+		}
+
+		cxlr = regions[i];
+		rc = setup_private_node(cxlmd, cxlr);
+		put_device(cxl_region_dev(cxlr));
+		if (rc == 0) {
+			/* Release remaining region references */
+			for (i++; i < nr; i++)
+				put_device(cxl_region_dev(regions[i]));
+			return 0;
+		}
+	}
+
+	/* Phase 2: no committed regions, create one */
+	dev_info(&cxlmd->dev,
+		 "no existing regions, creating RAM region\n");
+
+	cxlr = create_ram_region(cxlmd);
+	if (IS_ERR(cxlr)) {
+		rc = PTR_ERR(cxlr);
+		if (rc == -ENODEV) {
+			dev_info(&cxlmd->dev,
+				 "no RAM capacity: %d\n", rc);
+			return 0;
+		}
+		return rc;
+	}
+
+	rc = setup_private_node(cxlmd, cxlr);
+	if (rc) {
+		dev_err(&cxlmd->dev,
+			"failed to setup private node: %d\n", rc);
+		return rc;
+	}
+
+	/* Only take ownership of regions we created (Phase 2) */
+	memdev_to_ctx(cxlmd)->cxlr = cxlr;
+
+	return 0;
+}
+
+static const struct cxl_memdev_attach cxl_mempolicy_attach = {
+	.probe = cxl_mempolicy_attach_probe,
+};
+
+static int cxl_mempolicy_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct cxl_mempolicy_ctx *ctx;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	dev_info(&pdev->dev, "cxl_mempolicy: probing device\n");
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->nid = NUMA_NO_NODE;
+
+	rc = xa_insert(&ctx_xa, (unsigned long)pdev, ctx, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	cxlmd = cxl_pci_type3_probe_init(pdev, &cxl_mempolicy_attach);
+	if (IS_ERR(cxlmd)) {
+		xa_erase(&ctx_xa, (unsigned long)pdev);
+		return PTR_ERR(cxlmd);
+	}
+
+	dev_info(&pdev->dev, "cxl_mempolicy: probe complete\n");
+	return 0;
+}
+
+static void cxl_mempolicy_remove(struct pci_dev *pdev)
+{
+	struct cxl_mempolicy_ctx *ctx = xa_erase(&ctx_xa, (unsigned long)pdev);
+
+	dev_info(&pdev->dev, "cxl_mempolicy: removing device\n");
+
+	if (!ctx)
+		return;
+
+	if (ctx->nid != NUMA_NO_NODE)
+		WARN_ON(node_private_clear_ops(ctx->nid, &cxl_mempolicy_ops));
+
+	if (ctx->cxlr) {
+		cxl_destroy_region(ctx->cxlr);
+		ctx->cxlr = NULL;
+	}
+
+	if (ctx->cxled) {
+		cxl_dpa_free(ctx->cxled);
+		ctx->cxled = NULL;
+	}
+}
+
+static const struct pci_device_id cxl_mempolicy_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0d93) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, cxl_mempolicy_pci_tbl);
+
+static struct pci_driver cxl_mempolicy_driver = {
+	.name		= KBUILD_MODNAME,
+	.id_table	= cxl_mempolicy_pci_tbl,
+	.probe		= cxl_mempolicy_probe,
+	.remove		= cxl_mempolicy_remove,
+	.driver	= {
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+
+module_pci_driver(cxl_mempolicy_driver);
+
+MODULE_DESCRIPTION("CXL: Private Memory with Mempolicy Support");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("CXL");
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 7b2da3875ff2..1f9fb61f3932 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -10,7 +10,12 @@
 typedef struct folio *new_folio_t(struct folio *folio, unsigned long private);
 typedef void free_folio_t(struct folio *folio, unsigned long private);
 
-struct migration_target_control;
+struct migration_target_control {
+	int nid;		/* preferred node id */
+	nodemask_t *nmask;
+	gfp_t gfp_mask;
+	enum migrate_reason reason;
+};
 
 /**
  * struct movable_operations - Driver page migration
diff --git a/mm/internal.h b/mm/internal.h
index 64467ca774f1..85cd11189854 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1352,13 +1352,6 @@ extern const struct trace_print_flags gfpflag_names[];
 
 void setup_zone_pageset(struct zone *zone);
 
-struct migration_target_control {
-	int nid;		/* preferred node id */
-	nodemask_t *nmask;
-	gfp_t gfp_mask;
-	enum migrate_reason reason;
-};
-
 /*
  * mm/filemap.c
  */
-- 
2.53.0

