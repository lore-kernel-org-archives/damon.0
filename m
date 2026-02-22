Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF3267386
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750220; cv=none; b=E+W9A0CrliQoHVDuISIUop82ib6QMR+uEz7GftGpv7WalPAMablPVy+Px2T13sscktqzWJEnqCoyeTmGhjD/AgBqZ0pGqkT4BhIanqV0HIFZwy46dFhkImxu0DSuBQya7pqBRi1ujGMOZ4+r4V4mWcI2/rF9BJbbLOMpgzGblf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750220; c=relaxed/simple;
	bh=/a+f//T1z+yn2dz1PV28izkUs5nWkvuoG5mEzGFWCgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6CjFDZ0yUxCdFcm0dYMgmIqskWhVH+ATMGhKjDTJ2TTmWEnQ1gbkK3Q3GST42RGWRKIWWM9WV78AJQDc9OYchWRltVtO0CWAx6U4cEkqZrDQWZIYZETsxfjMWNuUHe5z0uz97P7Jghg2OFO+oJb4VCU0bSQj2hn03BFlhBd1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aKi1i1E+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aKi1i1E+"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-896f9397ecdso36875626d6.3
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750218; x=1772355018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qurhf8VxnZAam+8t9KEHmJsyHZdR8IkiLqv08LH4QHY=;
        b=aKi1i1E+FhD3mISfz7Wc8EiQ1g58oiRTZ3Fjfznse1Q2qYTu7gqJIGvlmT4oe9WgY2
         wi+DBkgD32K3gNqmlIwmBSoLebgZ5FODr9AvC5M8m0y4gKpml965rh5Nzy8+eFlElhDq
         YyctJ9/2jXRHxh1vZS/DywmXf4I9qNp9ir7/D4Q9uPEwYwD1P4Q2U2xX6Ze4R663qTAx
         AlFfpBiR3xd4/5ucpfYus/dQFXWHU3WzI3WHLnBgkLDpcZsk691Iz1pIATTXu+4IaH4g
         qiqgWJlICAC1ppLaiD4CotuBa0aswSW0FvFdumyyIdOu6byOa5HM4JKcyFfzOLkdxtPW
         erZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750218; x=1772355018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qurhf8VxnZAam+8t9KEHmJsyHZdR8IkiLqv08LH4QHY=;
        b=K8RzDYzKpn8LIGqYMBnhqSP731T1AybRXNK0iiF4kuCRHp9RuFtDMtyiOAYheS4xd1
         ppyjBNuW2YH3FhtUg2ROVIT/ljWSAwf7VqLayYGXmmCu5xK8IcrllL3ZKiK2CmHl9eBa
         8KdPgDsuCARwhkbRymtAgEhDbRjstdeaT8k3xnVP7d33GRBgqmNoLz4c9So6HzF3FmCH
         g9Np/YFV5UjaFeoPcdjHN0WGDsbTa1ovYPFsbqztjZfHs9SqhOlIHndkIzqq+dymt5e3
         62k9R7JpVeW6AveYiKt3CYDsMlBoTM9K69XcUvbG18vLft86Fei9JW5mfCYKBP0SovSH
         5eBA==
X-Forwarded-Encrypted: i=1; AJvYcCW0F2hQLHBiSN+s29RPUlYfEJJeE4fxlx/BIOkiwteceBs2ovUAdw/xIwusO/Qw0acdSIA/NA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6adXqvCt1/Vy3fDvlWfKtuQvvIsoUJZrEUz4egGIvIU/O9tU0
	kaWSes2QIr7+nMzDv0ivrlbWY7bfj0UeQ1aEKK4CqmNSCyOF6LtOhMX0ge5BZsupYh4=
X-Gm-Gg: AZuq6aKAr/RdrUHTJ7VC9dIyMXfp+qiqTvbL1qMb6EyskQVCrBUeaOgq0Vz+PNB858C
	J+O89QSTnYkQg2aq4kJS6YNDNKJfFbSS35bllHT9bwdAbK/Oa8mNQW5IOlQMMgmOesczPJfArTQ
	HpfyS1/JjuPGOSUICktdjpd5aIXNzZ8XRrB06zDNhRbBCFL/FfZY94Z3UdqamtC0SaeEAk6ot94
	CHQEyhlu1BvfvGJRh+V6kzS17U/292tjR3fJwIXQ5f+z2yHTuF9MyHhC1BTX14fM5RDhICu03u3
	2uSxRQYHaSBUkcKgzT6ROQzWx/HCgvsY2dHnGalDHGBMb+c4Gjd2MLWLK8KQC+oSlqIL6AmArtJ
	/D8RHzRf7r2gDcM1ZdQAzP6DXwte6QmYsxH5PzYEhyYLyORslE+M5ORoYu6Q4DFCjGVKQrvl5rP
	IjRg2TFCsFbX8zYNWyGRiNkz7NfxeR0wrDajwZO2O7IXaj3DLvh7/f9DhGBVFcPIKv4HcY1Jae6
	WIVMEQqwRmpw7M=
X-Received: by 2002:a05:622a:15c9:b0:501:4e87:70b2 with SMTP id d75a77b69052e-5070bd20e4amr73625991cf.69.1771750217875;
        Sun, 22 Feb 2026 00:50:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:17 -0800 (PST)
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
Subject: [RFC PATCH v4 22/27] mm/memory_hotplug: add add_private_memory_driver_managed()
Date: Sun, 22 Feb 2026 03:48:37 -0500
Message-ID: <20260222084842.1824063-23-gourry@gourry.net>
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

Add a new function for drivers to hotplug memory as N_MEMORY_PRIVATE.

This function combines node_private_region_register() with
__add_memory_driver_managed() to ensure proper ordering:

1. Register the private region first (sets private node context)
2. Then hotplug the memory (sets N_MEMORY_PRIVATE)
3. On failure, unregister the private region to avoid leaving the
   node in an inconsistent state.

When the last of memory is removed, hotplug also removes the private
node context. If migration is not supported and the node is still
online, fire a warning (likely bug in the driver).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h |  11 +++
 include/linux/mmzone.h         |  12 ++++
 mm/memory_hotplug.c            | 122 ++++++++++++++++++++++++++++++---
 3 files changed, 135 insertions(+), 10 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 1f19f08552ea..e5abade9450a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -293,6 +293,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
+extern int offline_and_remove_private_memory(int nid, u64 start, u64 size);
 
 #else
 static inline void try_offline_node(int nid) {}
@@ -309,6 +310,12 @@ static inline int remove_memory(u64 start, u64 size)
 }
 
 static inline void __remove_memory(u64 start, u64 size) {}
+
+static inline int offline_and_remove_private_memory(int nid, u64 start,
+						    u64 size)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -326,6 +333,10 @@ int __add_memory_driver_managed(int nid, u64 start, u64 size,
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
 				     mhp_t mhp_flags);
+int add_private_memory_driver_managed(int nid, u64 start, u64 size,
+				      const char *resource_name,
+				      mhp_t mhp_flags, enum mmop online_type,
+				      struct node_private *np);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 				   unsigned long nr_pages,
 				   struct vmem_altmap *altmap, int migratetype,
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 992eb1c5a2c6..cc532b67ad3f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1524,6 +1524,18 @@ typedef struct pglist_data {
 #endif
 } pg_data_t;
 
+#ifdef CONFIG_NUMA
+static inline bool pgdat_is_private(pg_data_t *pgdat)
+{
+	return pgdat->private;
+}
+#else
+static inline bool pgdat_is_private(pg_data_t *pgdat)
+{
+	return false;
+}
+#endif
+
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
 #define node_spanned_pages(nid)	(NODE_DATA(nid)->node_spanned_pages)
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d2dc527bd5b0..9d72f44a30dc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -36,6 +36,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/node.h>
+#include <linux/node_private.h>
 
 #include <asm/tlbflush.h>
 
@@ -1173,8 +1174,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_MOVABLE,
 			       true);
 
-	if (!node_state(nid, N_MEMORY)) {
-		/* Adding memory to the node for the first time */
+	if (!node_state(nid, N_MEMORY) && !node_state(nid, N_MEMORY_PRIVATE)) {
 		node_arg.nid = nid;
 		ret = node_notify(NODE_ADDING_FIRST_MEMORY, &node_arg);
 		ret = notifier_to_errno(ret);
@@ -1208,8 +1208,12 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	if (node_arg.nid >= 0)
-		node_set_state(nid, N_MEMORY);
+	if (node_arg.nid >= 0) {
+		if (pgdat_is_private(NODE_DATA(nid)))
+			node_set_state(nid, N_MEMORY_PRIVATE);
+		else
+			node_set_state(nid, N_MEMORY);
+	}
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
 
@@ -1227,8 +1231,14 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
-	kcompactd_run(nid);
+	/*
+	 * Don't start reclaim/compaction daemons for private nodes.
+	 * Private node services will decide whether to start these services.
+	 */
+	if (!pgdat_is_private(NODE_DATA(nid))) {
+		kswapd_run(nid);
+		kcompactd_run(nid);
+	}
 
 	if (node_arg.nid >= 0)
 		/* First memory added successfully. Notify consumers. */
@@ -1722,6 +1732,54 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 }
 EXPORT_SYMBOL_GPL(add_memory_driver_managed);
 
+/**
+ * add_private_memory_driver_managed - add driver-managed N_MEMORY_PRIVATE memory
+ * @nid: NUMA node ID (or memory group ID when MHP_NID_IS_MGID is set)
+ * @start: Start physical address
+ * @size: Size in bytes
+ * @resource_name: "System RAM ($DRIVER)" format
+ * @mhp_flags: Memory hotplug flags
+ * @online_type: MMOP_* online type
+ * @np: Driver-owned node_private structure (owner, refcount)
+ *
+ * Registers node_private first, then hotplugs the memory.
+ *
+ * On failure, unregisters the node_private.
+ */
+int add_private_memory_driver_managed(int nid, u64 start, u64 size,
+				      const char *resource_name,
+				      mhp_t mhp_flags, enum mmop online_type,
+				      struct node_private *np)
+{
+	struct memory_group *group;
+	int real_nid = nid;
+	int rc;
+
+	if (!np)
+		return -EINVAL;
+
+	if (mhp_flags & MHP_NID_IS_MGID) {
+		group = memory_group_find_by_id(nid);
+		if (!group)
+			return -EINVAL;
+		real_nid = group->nid;
+	}
+
+	rc = node_private_register(real_nid, np);
+	if (rc)
+		return rc;
+
+	rc = __add_memory_driver_managed(nid, start, size, resource_name,
+					 mhp_flags, online_type);
+	if (rc) {
+		node_private_unregister(real_nid);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(add_private_memory_driver_managed);
+
 /*
  * Platforms should define arch_get_mappable_range() that provides
  * maximum possible addressable physical memory range for which the
@@ -1872,6 +1930,15 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			goto put_folio;
 		}
 
+		/* Private nodes w/o migration must ensure folios are offline */
+		if (folio_is_private_node(folio) &&
+		    !folio_private_flags(folio, NP_OPS_MIGRATION)) {
+			WARN_ONCE(1, "hot-unplug on non-migratable node %d pfn %lx\n",
+				  folio_nid(folio), pfn);
+			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
+			goto put_folio;
+		}
+
 		if (!isolate_folio_to_list(folio, &source)) {
 			if (__ratelimit(&migrate_rs)) {
 				pr_warn("failed to isolate pfn %lx\n",
@@ -2014,8 +2081,8 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 	/*
 	 * Check whether the node will have no present pages after we offline
-	 * 'nr_pages' more. If so, we know that the node will become empty, and
-	 * so we will clear N_MEMORY for it.
+	 * 'nr_pages' more. If so, send pre-notification for last memory removal.
+	 * We will clear N_MEMORY(_PRIVATE) if this is the case.
 	 */
 	if (nr_pages >= pgdat->node_present_pages) {
 		node_arg.nid = node;
@@ -2108,8 +2175,12 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * Make sure to mark the node as memory-less before rebuilding the zone
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
-	if (node_arg.nid >= 0)
-		node_clear_state(node, N_MEMORY);
+	if (node_arg.nid >= 0) {
+		if (node_state(node, N_MEMORY))
+			node_clear_state(node, N_MEMORY);
+		else if (node_state(node, N_MEMORY_PRIVATE))
+			node_clear_state(node, N_MEMORY_PRIVATE);
+	}
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
@@ -2461,4 +2532,35 @@ int offline_and_remove_memory(u64 start, u64 size)
 	return rc;
 }
 EXPORT_SYMBOL_GPL(offline_and_remove_memory);
+
+/**
+ * offline_and_remove_private_memory - offline, remove, and unregister private memory
+ * @nid: NUMA node ID of the private memory
+ * @start: Start physical address
+ * @size: Size in bytes
+ *
+ * Counterpart to add_private_memory_driver_managed().  Offlines and removes
+ * the memory range, then attempts to unregister the node_private.
+ *
+ * offline_and_remove_memory() clears N_MEMORY_PRIVATE when the last block
+ * is offlined, which allows node_private_unregister() to clear the
+ * pgdat->node_private pointer.  If other private memory ranges remain on
+ * the node, node_private_unregister() returns -EBUSY (N_MEMORY_PRIVATE
+ * is still set) and the node_private remains registered.
+ *
+ * Return: 0 on full success (memory removed and node_private unregistered),
+ *         -EBUSY if memory was removed but node still has other private memory,
+ *         other negative error code if offline/remove failed.
+ */
+int offline_and_remove_private_memory(int nid, u64 start, u64 size)
+{
+	int rc;
+
+	rc = offline_and_remove_memory(start, size);
+	if (rc)
+		return rc;
+
+	return node_private_unregister(nid);
+}
+EXPORT_SYMBOL_GPL(offline_and_remove_private_memory);
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-- 
2.53.0

