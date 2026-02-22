Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36223817E
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750179; cv=none; b=g6yl5ZM5JE2bZraweFte40EynCaUWdocJ2iVepf+u1iuDHePol/BqFcSPkSof1Y6dHs6brSPL3tlxpBVEIsv22bW3AZg/fKEaAI4giPqxTGFmp7U9J3sY1nscSoenv0TKsmpnRuYLvD3IIuAUrTVAP90ZsNdzEEPkmpbglmuJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750179; c=relaxed/simple;
	bh=iAyfZHGom5QIZEtYKc+A9YZYnBeGnAnI+yMmjM4jWRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQxGTPbcH4CRUBrgRz2eJ96edvCLD6HsKxYqROOYa7jUVpZ9ZaO9OySPBGeiDcvvdbonSavMST8ThRvh6l872HJK0IzKtekjsPY7CDnuasLW++OBZYbJ8ZmEGrRJy6E1nxpb6VcML5ZslSoPZxDDvEkVz10YxXrN+4r5gwz7IAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MsBXRy28; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MsBXRy28"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a7bbe9d0so29134471cf.0
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750177; x=1772354977; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yj+ZkijP1F57uDkd+kIZ1Nriaysy+Ep+EgiXsVeVTU=;
        b=MsBXRy28eIh65Zuyea9l/tJkO5wAtwOMe78VwnfnUD4HArzB+m3WuB3VrWtkmL/6LR
         gZ8EVdfZULp9eltQ8kPniCNNiT9Cmg9ER5E5tnexbBBEpJtzuCky3JmnljAJN2ZJ94hX
         5jGkGWh2+b7Yn7DODqqnQJtbqjSyl60mciDDERLTQQK5HCrGhbzmFuADwIBGDBzLYo2S
         65XVC8PMyNX886oA0zr2ldBrmbHp4BqC58azm+GuE+ykjq5TXUAl5JOt5FLPNCMiE+Hh
         9Yc3dBC3Ge5VU3MDOf49BwPgQ8FkmH3+VxFkv1whT+EpsoSl8gmaYaItb9iHoVN18r0H
         wcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750177; x=1772354977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/yj+ZkijP1F57uDkd+kIZ1Nriaysy+Ep+EgiXsVeVTU=;
        b=c2BIXchhzF3/ZTyVtGVrgyafD0Gxu1kv0SBMftoChro8poUMLcntS+pWT1wxUF5Des
         5z8aVeV+QG2s1/pbFfdXamfLjqhYOBjMRdsPcKGaeHaver7kXdJpDblTKbleXlv91Ity
         SPcezMSp+5M4jfCXOoJKJJN8pm5N87d9a8S6J3SlXyFtnIxLwg1er9byqhnm4UeJzbEs
         zcx1fbGEu3+PvGBJXG/YobtV281MnVPX/gQdKeUPdVlQ6znbJv9rR790xxOgnn7xPAIw
         uxw861MmqYcvN8Nxx1+otrFt+IUikj0XV0sV//S4FAMyVdXbuNla3JgWJfSfcZsyTETF
         D39g==
X-Forwarded-Encrypted: i=1; AJvYcCUIh7EwozIltOB7pa3uSFerf4X0myInUY0IBDGsfn5J+yZWoiOSTWgzB8hNtXPVp8l4006HkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/JFbl2/PFurhroUL7jp+HaaDtQU6HTlQ/xX1rhWJ2pbcMzrqF
	jRLic8l76qQei5EONwG2DssyMsuPVyw3VQqUHmfvNuGO6L6VxCqERSkJK0PlH+IacbYdxUM6dpo
	XG2Hf
X-Gm-Gg: AZuq6aKKwfOVbqlVwGPYzXJ2EOzDhrYENR+ylb+UtnGl18O3YsKIyUxN5x0CdfCWgF+
	0TV8/JTWO4ewutRJPNMwflIYw/FD5MQUuRLSzkb9GUiWmcw5rX4Zmlv7zbQur6N+RE50NJWyYtP
	l2tIW1fmym+qXuO6153Pdm6aP1/dSKBvv5WovUe0SjlIJHt8PlaLGBI13g7Kj8yLsrhddut5vDC
	18izLTIPWiv4n/iYqka1u3C0lujOue7va+vD6mIJZ7mxUFKW7J1p0Ip2fgRdcyBG8x3IMkjLUcM
	KXgzXTSqEq6FFy5g+zJrDGq+UXCe1pu5OPEG9PjQ/x0SH5e9oyX5mu0Y/EJp/qJcdr/pWGKKsWO
	KkKjvRAFiJKO+3J1g3qDK9b4HLPp14Ugdxdc6+zyuNeqamtyku6nEJe7AZPO66j+HswUNldpfYB
	1vaQQQyY+biRjLnRQ2QQtcG+7pSuIOaD+lB6QEmxMifrf/k3KzUm/2nIQdNSNns6XJU4RzZPRxG
	SlmikzQr1yERM4=
X-Received: by 2002:ac8:5f52:0:b0:4f1:b712:364a with SMTP id d75a77b69052e-5070bc84890mr75076581cf.56.1771750177109;
        Sun, 22 Feb 2026 00:49:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:36 -0800 (PST)
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
Subject: [RFC PATCH v4 11/27] mm/huge_memory.c: add private node folio split notification callback
Date: Sun, 22 Feb 2026 03:48:26 -0500
Message-ID: <20260222084842.1824063-12-gourry@gourry.net>
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

Some private node services may need to update internal metadata when
a THP folio is split.  ZONE_DEVICE already has a split callback via
pgmap->ops; private nodes can provide the same capability.

Just like zone_device, some private node services may want to know
about a folio being split.  Add this optional callback to the ops
struct and add a wrapper for zone_device and private node callback
dispatch to be consolidated.

Wire this into __folio_split() where the zone_device check was made.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h | 33 +++++++++++++++++++++++++++++++++
 mm/huge_memory.c             |  6 ++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 09ea7c4cb13c..f9dd2d25c8a5 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -3,6 +3,7 @@
 #define _LINUX_NODE_PRIVATE_H
 
 #include <linux/completion.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
 #include <linux/rcupdate.h>
@@ -44,11 +45,19 @@ struct vm_fault;
  *   Returns: true if handled (skip return to buddy)
  *            false if no op (return to buddy)
  *
+ * @folio_split: Notification that a folio on this private node is being split.
+ *    [folio-referenced callback]
+ *     Called from the folio split path via folio_managed_split_cb().
+ *     @folio is the original folio; @new_folio is the newly created folio,
+ *     or NULL when called for the final (original) folio after all sub-folios
+ *     have been split off.
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
 struct node_private_ops {
 	bool (*free_folio)(struct folio *folio);
+	void (*folio_split)(struct folio *folio, struct folio *new_folio);
 	unsigned long flags;
 };
 
@@ -150,6 +159,24 @@ static inline bool zone_private_flags(struct zone *z, unsigned long flag)
 	return node_private_flags(zone_to_nid(z)) & flag;
 }
 
+static inline void node_private_split_cb(struct folio *folio,
+					 struct folio *new_folio)
+{
+	const struct node_private_ops *ops = folio_node_private_ops(folio);
+
+	if (ops && ops->folio_split)
+		ops->folio_split(folio, new_folio);
+}
+
+static inline void folio_managed_split_cb(struct folio *original_folio,
+					  struct folio *new_folio)
+{
+	if (folio_is_zone_device(original_folio))
+		zone_device_private_split_cb(original_folio, new_folio);
+	else if (folio_is_private_node(original_folio))
+		node_private_split_cb(original_folio, new_folio);
+}
+
 #else /* !CONFIG_NUMA */
 
 static inline bool folio_is_private_node(struct folio *folio)
@@ -198,6 +225,12 @@ static inline bool zone_private_flags(struct zone *z, unsigned long flag)
 	return false;
 }
 
+static inline void folio_managed_split_cb(struct folio *original_folio,
+					  struct folio *new_folio)
+{
+	if (folio_is_zone_device(original_folio))
+		zone_device_private_split_cb(original_folio, new_folio);
+}
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40cf59301c21..2ecae494291a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -24,6 +24,7 @@
 #include <linux/freezer.h>
 #include <linux/mman.h>
 #include <linux/memremap.h>
+#include <linux/node_private.h>
 #include <linux/pagemap.h>
 #include <linux/debugfs.h>
 #include <linux/migrate.h>
@@ -3850,7 +3851,7 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 
 			next = folio_next(new_folio);
 
-			zone_device_private_split_cb(folio, new_folio);
+			folio_managed_split_cb(folio, new_folio);
 
 			folio_ref_unfreeze(new_folio,
 					   folio_cache_ref_count(new_folio) + 1);
@@ -3889,7 +3890,8 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 			folio_put_refs(new_folio, nr_pages);
 		}
 
-		zone_device_private_split_cb(folio, NULL);
+		folio_managed_split_cb(folio, NULL);
+
 		/*
 		 * Unfreeze @folio only after all page cache entries, which
 		 * used to point to it, have been updated with new folios.
-- 
2.53.0

