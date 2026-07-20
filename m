Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363004BCAAE
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576150; cv=none; b=Xf0yPoqXYHLH9FvVRSY81DNwc5QYf5NQ7g/+BMS8d6yPqN3DxiOuf5A+G5iIABlK14sJCwpYHDUJ55GkEuCzyVyrSxmfrJdg/id/9Vjky5Wdrw6HjlMFpswDO5lMU6gM/JigNjYhAjHRiUiTUus0cI9a+E6MhnaYfTzOTHhrTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576150; c=relaxed/simple;
	bh=kLv92eDtwBpGUme5tB6HwrZM61Cr5ohZ2u4l1k/vs+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUupi5zTErK1U/Dk5Ee4dYfz+Wpx+E0F6uIivafoBtKv6hgPxFDS7lsBMkqLfhsXERri21sYxu9Ox324PLlNL3ZoFUzzkWSGJLyvE/ZW0wHuLSMG4Y8Ma4uTRsBacjxDfI1NDV0xJznHs1wawjzavvEnbyj9TZWw0GzviHs3xqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NG/uaV1e; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NG/uaV1e"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5cb052edso567193285a.2
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576144; x=1785180944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0sYpFeVf27+jOruO49PHN55cKYyhatP0JJwzbq2uG7o=;
        b=NG/uaV1eZ7k2mmngFcKjDVkxUIDFidxUSmbXXjaDtnkJwcEkg+2fiUzjevmAq8CMs0
         q6NAPtk5Eh3PH28VVPvUM80jp+EWXimM7Z4Yn5Z3NIFV3SogEZxv4mSHClAnOVd8KWUW
         74VfJOT9OApuHROgoqoyOTJFJTmlpif6cwct6+ludhksVumcbLu9ZONYYwftyJSyc0AH
         Qo9qAoiQr4GO4Wgosmr4pSIuWYaI+pQZt3FdrvcJ+ar690YqD86l91H0tTsuzvy+gYr8
         Pbm/N1Qxus5AayHkgry2DqYbgJi3dx4Qhp+qzRmcl4EcZFiz+hPD2VE0+tz3251HIkhM
         5Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576144; x=1785180944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0sYpFeVf27+jOruO49PHN55cKYyhatP0JJwzbq2uG7o=;
        b=f+i8OYGfjN/7JXqLbmpWyYZCvAX8DWsQ0Iognm/FadKw9KzowqxTHAsdFPE1r/etNm
         kFvCrXHRUZf7cteftH2GagJfOkhZl3Vhusd7K8bF2lOI9oe8srcMcL0AVePbEvokLrgZ
         zFriLB5ucZtivpUy11lFrPApvmSGzd7w4PUMgSsN3tPEki7i3r5dadyfcyi87mFLo0xa
         Aknq1Rj9MlI5buJMwqdXV+f+cSauEU0Z2YutNXm0XL0XsMCPqo+0LCEfSoHG/21KjM7h
         RhP1Oyr3WavfzuFGRn5nhr2So3Gk8FweJvb6LKYZO+KkAp3Y/ugQu2MkOwwsQbZbqiCZ
         kVYA==
X-Forwarded-Encrypted: i=1; AHgh+Rrlw+0AO6jb+Oq6BroNkGqInYpPGY3h3Aom0PeT7sq9AFkT4M7qJRiXFjw2KcKKjPdm87s5HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVOX4WyZjiFthadT6X8QKbDhn2o+hcmauYNHbKnOqvKufcOqyF
	eZhRBwOfJf5gTGvzFEn6dhj6LLDy1s1hKGNqfkiDDhUU3i1f2zRO5TiLOGWUUaTnT4I=
X-Gm-Gg: AfdE7clvZHaUZdBvr6Zu8k/c/gs/QhOwTIJKZrP4GWzXHOf/FUR10NTb4pgNCWYwiMk
	5A8qX/4Uvnkmwt6UdMDmyoMgvsi9mdAUQ8c3gOZkmWVviy/6xaUx/L2KHANIFD9CZL1ZpGYaoeH
	nZzeLOH757M73LTcUqR8x8gWu5sbu9k2zZFdnfBQuOr7dXjoURJviip8UGMZqqb6M25mznQkXYe
	5cGJ9XTZqt7t7xoXCVROQX6J7Ct/wEsRlo4aSchJ5vuJZvfS0DFAY1/n5IUrVxCvZzpXTEAOD5S
	18yYoFQv2b82i9hcPDB2pucPth+YuGqx4UEyBaEH7s4ni7SGklljWtvIJXI95DJ5sZrZJhk3rNQ
	G8Cws5msyYQonHNyifuxp+z6JYMV88wLm5oEIUyYwrsT6TZh0ww7J5bxxFoBSQfC/whfIRV/nTd
	JuYzdPqGnVostRnVl0LJkepMCl1cffWuXdFPvnC2sVtwphnEUz++G+MjsABOXeDNc=
X-Received: by 2002:a05:620a:471f:b0:916:10f6:780f with SMTP id af79cd13be357-930b3ec94cbmr1617831585a.27.1784576143523;
        Mon, 20 Jul 2026 12:35:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:43 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 25/36] mm/memory_hotplug: support N_MEMORY_PRIVATE node hotplug
Date: Mon, 20 Jul 2026 15:34:19 -0400
Message-ID: <20260720193431.3841992-26-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add add_private_memory_driver_managed() to let modules hotplug
memory onto an N_MEMORY_PRIVATE node they control.

Ownership is denoted via `struct node_private` and a private node
can only have a single owner.

The common __add_memory_driver_managed function is only exported to
in-tree modules that allow hotplug of N_MEMORY nodes. The new private
wrapper does not allow N_MEMORY hotplug, only N_MEMORY_PRIVATE.

When node_private is NULL hotplug behaviour is unchanged.

When node_private is non-NULL the node owner is registered before any
memory is added.  Later during hotplug, when memory is actually onlined,
hotplug marks the node N_MEMORY_PRIVATE instead of N_MEMORY.

If the add fails the registration is undone.

offline_pages() clears N_MEMORY_PRIVATE the same as N_MEMORY, and
offline_and_remove_memory_ranges() drops private node registration
once the last node's memory is removed.

Private nodes are opted out of starting kswapd/kcompactd by default.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c             |  2 +-
 include/linux/memory_hotplug.h |  5 +-
 mm/memory_hotplug.c            | 99 ++++++++++++++++++++++++++++++----
 3 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a48d699cf344c..c3faf18e7f85d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -126,7 +126,7 @@ static int dax_kmem_do_hotplug(struct dev_dax *dev_dax,
 		 */
 		rc = __add_memory_driver_managed(data->mgid, range.start,
 				range_len(&range), kmem_name, mhp_flags,
-				online_type);
+				online_type, NULL);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index b39605d308963..fcceb0a423579 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -305,7 +305,10 @@ extern int add_memory_resource(int nid, struct resource *resource,
 			       mhp_t mhp_flags);
 int __add_memory_driver_managed(int nid, u64 start, u64 size,
 				const char *resource_name, mhp_t mhp_flags,
-				enum mmop online_type);
+				enum mmop online_type, struct node_private *np);
+int add_private_memory_driver_managed(int nid, u64 start, u64 size,
+				      const char *resource_name, mhp_t mhp_flags,
+				      enum mmop online_type, struct node_private *np);
 extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     const char *resource_name,
 				     mhp_t mhp_flags);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2b9c0830821e6..be230ac9efe5a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1169,7 +1169,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_MOVABLE,
 			       true);
 
-	if (!node_state(nid, N_MEMORY)) {
+	if (!node_state(nid, N_MEMORY) && !node_is_private(nid)) {
 		/* Adding memory to the node for the first time */
 		node_arg.nid = nid;
 		ret = node_notify(NODE_ADDING_FIRST_MEMORY, &node_arg);
@@ -1204,13 +1204,20 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
+	/*
+	 * N_MEMORY and N_MEMORY_PRIVATE are mutually exclusive, determine
+	 * which is correct based on whether the pgdat->private is set.
+	 */
 	if (node_arg.nid >= 0)
-		node_set_state(nid, N_MEMORY);
+		node_set_state(nid, pgdat_is_private(NODE_DATA(nid)) ?
+				    N_MEMORY_PRIVATE : N_MEMORY);
 	/*
 	 * Check whether we are adding normal memory to the node for the first
 	 * time.
 	 */
-	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
+	if (!node_is_private(nid) &&
+	    !node_state(nid, N_NORMAL_MEMORY) &&
+	    zone_idx(zone) <= ZONE_NORMAL)
 		node_set_state(nid, N_NORMAL_MEMORY);
 
 	if (need_zonelists_rebuild)
@@ -1230,8 +1237,11 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
-	kcompactd_run(nid);
+	/* Private nodes opt-out of reclaim/compaction by default */
+	if (!node_is_private(nid)) {
+		kswapd_run(nid);
+		kcompactd_run(nid);
+	}
 
 	if (node_arg.nid >= 0)
 		/* First memory added successfully. Notify consumers. */
@@ -1649,6 +1659,8 @@ EXPORT_SYMBOL_GPL(add_memory);
  * @resource_name: Resource name in format "System RAM ($DRIVER)"
  * @mhp_flags: Memory hotplug flags
  * @online_type: Auto-Online behavior (offline, online, kernel, movable)
+ * @np: driver-owned node_private to online the node as N_MEMORY_PRIVATE, or
+ *	NULL for ordinary system RAM
  *
  * Add special, driver-managed memory to the system as system RAM. Such
  * memory is not exposed via the raw firmware-provided memmap as system
@@ -1675,9 +1687,11 @@ EXPORT_SYMBOL_GPL(add_memory);
  */
 int __add_memory_driver_managed(int nid, u64 start, u64 size,
 		const char *resource_name, mhp_t mhp_flags,
-		enum mmop online_type)
+		enum mmop online_type, struct node_private *np)
 {
+	int real_nid = nid;
 	struct resource *res;
+	struct memory_group *group;
 	int rc;
 
 	if (!resource_name ||
@@ -1688,6 +1702,19 @@ int __add_memory_driver_managed(int nid, u64 start, u64 size,
 	if (online_type < MMOP_OFFLINE || online_type > MMOP_ONLINE_MOVABLE)
 		return -EINVAL;
 
+	/* Register a private-node owner before adding memory. */
+	if (np) {
+		if (mhp_flags & MHP_NID_IS_MGID) {
+			group = memory_group_find_by_id(nid);
+			if (!group)
+				return -EINVAL;
+			real_nid = group->nid;
+		}
+		rc = node_private_register(real_nid, np);
+		if (rc)
+			return rc;
+	}
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
@@ -1702,10 +1729,41 @@ int __add_memory_driver_managed(int nid, u64 start, u64 size,
 
 out_unlock:
 	unlock_device_hotplug();
+	if (rc < 0 && np)
+		node_private_unregister(real_nid);
 	return rc;
 }
 EXPORT_SYMBOL_FOR_MODULES(__add_memory_driver_managed, "kmem");
 
+/**
+ * add_private_memory_driver_managed - add private driver-managed memory
+ * @nid: NUMA node ID where the memory will be added
+ * @start: Start physical address of the memory range
+ * @size: Size of the memory range in bytes
+ * @resource_name: Resource name in format "System RAM ($DRIVER)"
+ * @mhp_flags: Memory hotplug flags
+ * @online_type: Auto-Online behavior (offline, online, kernel, movable)
+ * @np: private node context for the owner - mandatory.
+ *
+ * Add private driver-managed memory.  Private node context is required to
+ * avoid the memory being added as a normal N_MEMORY node.
+ *
+ * See __add_memory_driver_managed for more details.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int add_private_memory_driver_managed(int nid, u64 start, u64 size,
+				      const char *resource_name, mhp_t mhp_flags,
+				      enum mmop online_type, struct node_private *np)
+{
+	if (!np)
+		return -EINVAL;
+
+	return __add_memory_driver_managed(nid, start, size, resource_name,
+					   mhp_flags, online_type, np);
+}
+EXPORT_SYMBOL_GPL(add_private_memory_driver_managed);
+
 /**
  * add_memory_driver_managed - add driver-managed memory
  * @nid: NUMA node ID where the memory will be added
@@ -1726,7 +1784,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 {
 	return __add_memory_driver_managed(nid, start, size, resource_name,
 			mhp_flags,
-			mhp_get_default_online_type());
+			mhp_get_default_online_type(), NULL);
 }
 EXPORT_SYMBOL_GPL(add_memory_driver_managed);
 
@@ -2041,7 +2099,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/*
 	 * Check whether the node will have no present pages after we offline
 	 * 'nr_pages' more. If so, we know that the node will become empty, and
-	 * so we will clear N_MEMORY for it.
+	 * so we will clear N_MEMORY(_PRIVATE) for it.
 	 */
 	if (nr_pages >= pgdat->node_present_pages) {
 		node_arg.nid = node;
@@ -2146,8 +2204,10 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * Make sure to mark the node as memory-less before rebuilding the zone
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
-	if (node_arg.nid >= 0)
+	if (node_arg.nid >= 0) {
 		node_clear_state(node, N_MEMORY);
+		node_clear_state(node, N_MEMORY_PRIVATE);
+	}
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
@@ -2211,6 +2271,15 @@ static int count_memory_range_altmaps_cb(struct memory_block *mem, void *arg)
 	return 0;
 }
 
+static int collect_memblock_nodes_cb(struct memory_block *mem, void *arg)
+{
+	nodemask_t *nodes = arg;
+
+	if (mem->nid != NUMA_NO_NODE)
+		node_set(mem->nid, *nodes);
+	return 0;
+}
+
 static int check_cpu_on_node(int nid)
 {
 	int cpu;
@@ -2474,10 +2543,11 @@ EXPORT_SYMBOL_GPL(offline_and_remove_memory);
 int offline_and_remove_memory_ranges(const struct range *ranges,
 		unsigned int nr_ranges)
 {
+	nodemask_t nodes = NODE_MASK_NONE;
 	unsigned long mb_count = 0;
 	uint8_t *online_types, *tmp;
 	unsigned int i;
-	int rc = 0;
+	int nid, rc = 0;
 
 	if (!ranges || !nr_ranges)
 		return -EINVAL;
@@ -2505,6 +2575,11 @@ int offline_and_remove_memory_ranges(const struct range *ranges,
 
 	lock_device_hotplug();
 
+	/* Record the nodes for the blocks to drop private-node data after */
+	for (i = 0; i < nr_ranges; i++)
+		walk_memory_blocks(ranges[i].start, range_len(&ranges[i]),
+				   &nodes, collect_memblock_nodes_cb);
+
 	/*
 	 * Phase 1: offline every block in every range.  An already-offline
 	 * block folds to success, so out-of-band offlining never blocks unplug.
@@ -2535,6 +2610,10 @@ int offline_and_remove_memory_ranges(const struct range *ranges,
 out_unlock:
 	unlock_device_hotplug();
 
+	/* Drop private node registration if they are now memoryless */
+	for_each_node_mask(nid, nodes)
+		node_private_unregister(nid);
+
 	kfree(online_types);
 	return rc;
 }
-- 
2.53.0-Meta

