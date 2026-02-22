Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808A21254B
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750145; cv=none; b=c2PNEBGWhMU0NU30pS0XeS1UTsPyY4Edd9kn326aiP4iGTvdTa+nqPPpEsZpg7gGcK7cAL5ckEq0kVOGO73yNIw+xtGV/Wt5Uo62P9jOa3zKhKRJhmIAG2dFQSm4IkponIBxiOZuUsD16yXQApSmaDtB1IBWbmk969oAKz7G5SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750145; c=relaxed/simple;
	bh=am2tCajpeHis0FzaYns/D3UH06rPDuGxOYhl4tv1KTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRk6b7Tpkz72XfY786KMiIe/603o244yRIHSdpTaaO+E6uUVDNouwIV9SVyXRwl5Ms2zJa0RGDz7dhDV1Rua1X8q837SxB0mGV2eqhrhXHEnS+5E7d3EOzBAJAGrUJpCan/bnVod5JArRzt37CAVxQ5DABJRG8uEFPwkkwHUtCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rM8XgGU9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rM8XgGU9"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50697d6a69cso17828051cf.2
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750141; x=1772354941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itvSMpOqGG7PqHHjVhXbDUHp+0Ke3fJUKOX/SDJBBVY=;
        b=rM8XgGU9uVatOQTLWOtVJvEEhO3g2+V1kMrPdjFX6at3d2gpWJVra0ZPn20VO+T6XV
         vXhqaIij17wwh2+BWF37LGjIDW/0V5qw3wonlszMHUE+KgKETPuBi2wisTWqJD21leAY
         Zy6QR+hDa12+9DaIwr03qxRZjjCLnXCxZc5RT6pY8DCjayU2iEXHbiwzFCkS6GY8KrCI
         gCWDZ61YuMB0iIoFn5Hp/h1o+UZx3iZipcaYYhMOggZ08YLIceDOR4S6witRuGTyK7bf
         CX63O931wO9R6n+OOgsYVGPzbFfFFv/ySBl7TQYvqw9FwZtG34EPev4SxFteblpk+fHg
         WulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750141; x=1772354941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itvSMpOqGG7PqHHjVhXbDUHp+0Ke3fJUKOX/SDJBBVY=;
        b=kPEOwKa/HzZ340L8WUcAI1XTN2SPRG0njYmjToWjIWlbtie7VCNGhl4SGLetjXjH4d
         Su5rhlmfP5psRygzHQefbqbtXFYa4UYLXeKEA5Iuvmw/WSghvQncClSHN3XsppFP3AuO
         Q+v/Uzcsc/uyGyKuGH6t9u41TkTy0xCpUrpfKSrI/klycZfQ0GAXRBmr4ay7k23KuJS9
         uuD/useWqfr7el1p2TbhtsNr1ir8wTBHjG3B1YPKhRASz9nKb4CYNljCvrEH2jLNHRwX
         g8ZIS5cYV7BGSk20ASJctEg/aD7ZuThM7pBSUDh7S5pLsKx9NWcO5WvT+5bGYhj77PSW
         W4kw==
X-Forwarded-Encrypted: i=1; AJvYcCXfu+Nf60JAqUx9/YOhjyA7ABpswiJ1JGg9B1fjMp/LW5UGyy6nSr7ZPZPWxKY0y31YZBjv7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRMXlDbTB592fxLFVjIcWevrCi3ZEHvdJ4aLDNV3GWZmu1XBdr
	kwNwttB3CjefzCDVjiKyDv0w7wYbAHsyNlo3qEAEz5C8zU9sXpF84JovNN/Z79GuQHA=
X-Gm-Gg: AZuq6aJMf/+r3Q2XMiXaO01gaN7vN1EyAcvSMWO5Ug9Q8RT0zTP8h5oOPP4eo3/4Vjt
	nDhgxaokqhCaQ2pmZS6g1qtUM3f74vPyWemHpnBdgpCsH5zyHY47471HIi2zKXRfjLQmYxWQqgM
	hHOKMy+Eurz1nhdg4QaJWVmGtRwkXCIV1va/uuyS+yFY7fMiptSveIEgFBZa3gnHx6dUFOeg6zC
	4x2CVZ9QR/C7TWDVRRvKP6tsDnt6q5wt4ZAS6xyNCh7TpsOVgJupbHV0d3Jk64yI66fUyMSGW2L
	HzQHScDTW65tyWwayztDgouHIAr+V/nzGJSzoU/mgCYn8AULsn6kpASko0LpZfzIk0J8vPi8D8H
	6QGnhXFVOs+G+rCs+Rg0HZfi2ckxqxEKCml8q17q6aK+L7Y+7+FD9Fz+ANEl+932OxDycKuvjW0
	4QoNrSKDW5xMjXl5JWCq9ak5EYmfM/axJ4hlyiG5LFaSnk8tHqQVbXcc/19FlGGPkvzAtMpTlQZ
	DWPazBXClH1WgE=
X-Received: by 2002:a05:622a:1355:b0:4ec:f26f:5aea with SMTP id d75a77b69052e-5070bce327dmr60794421cf.68.1771750140761;
        Sun, 22 Feb 2026 00:49:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:48:59 -0800 (PST)
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
Subject: [RFC PATCH v4 02/27] mm,cpuset: gate allocations from N_MEMORY_PRIVATE behind __GFP_PRIVATE
Date: Sun, 22 Feb 2026 03:48:17 -0500
Message-ID: <20260222084842.1824063-3-gourry@gourry.net>
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

N_MEMORY_PRIVATE nodes hold device-managed memory that should not be
used for general allocations. Without a gating mechanism, any allocation
could land on a private node if it appears in the task's mems_allowed.

Introduce __GFP_PRIVATE that explicitly opts in to allocation from
N_MEMORY_PRIVATE nodes.

Add the GFP_PRIVATE compound mask (__GFP_PRIVATE | __GFP_THISNODE)
for callers that explicitly target private nodes to help prevent
fallback allocations from DRAM.

Update cpuset_current_node_allowed() to filter out N_MEMORY_PRIVATE
nodes unless __GFP_PRIVATE is set.

In interrupt context, only N_MEMORY nodes are valid.

Update cpuset_handle_hotplug() to include N_MEMORY_PRIVATE nodes in
the effective mems set, allowing cgroup-level control over private
node access.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp_types.h      | 15 +++++++++++++--
 include/trace/events/mmflags.h |  4 ++--
 kernel/cgroup/cpuset.c         | 32 ++++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 3de43b12209e..ac375f9a0fc2 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -33,7 +33,7 @@ enum {
 	___GFP_IO_BIT,
 	___GFP_FS_BIT,
 	___GFP_ZERO_BIT,
-	___GFP_UNUSED_BIT,	/* 0x200u unused */
+	___GFP_PRIVATE_BIT,
 	___GFP_DIRECT_RECLAIM_BIT,
 	___GFP_KSWAPD_RECLAIM_BIT,
 	___GFP_WRITE_BIT,
@@ -69,7 +69,7 @@ enum {
 #define ___GFP_IO		BIT(___GFP_IO_BIT)
 #define ___GFP_FS		BIT(___GFP_FS_BIT)
 #define ___GFP_ZERO		BIT(___GFP_ZERO_BIT)
-/* 0x200u unused */
+#define ___GFP_PRIVATE		BIT(___GFP_PRIVATE_BIT)
 #define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
 #define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
 #define ___GFP_WRITE		BIT(___GFP_WRITE_BIT)
@@ -139,6 +139,11 @@ enum {
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
  *
  * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
+ *
+ * %__GFP_PRIVATE allows allocation from N_MEMORY_PRIVATE nodes (e.g., compressed
+ * memory, accelerator memory). Without this flag, allocations are restricted
+ * to N_MEMORY nodes only. Used by migration/demotion paths when explicitly
+ * targeting private nodes.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
@@ -146,6 +151,7 @@ enum {
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
 #define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
+#define __GFP_PRIVATE	((__force gfp_t)___GFP_PRIVATE)
 
 /**
  * DOC: Watermark modifiers
@@ -367,6 +373,10 @@ enum {
  * available and will not wake kswapd/kcompactd on failure. The _LIGHT
  * version does not attempt reclaim/compaction at all and is by default used
  * in page fault path, while the non-light is used by khugepaged.
+ *
+ * %GFP_PRIVATE adds %__GFP_THISNODE by default to prevent any fallback
+ * allocations to other nodes, given that the caller was already attempting
+ * to access driver-managed memory explicitly.
  */
 #define GFP_ATOMIC	(__GFP_HIGH|__GFP_KSWAPD_RECLAIM)
 #define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
@@ -382,5 +392,6 @@ enum {
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
+#define GFP_PRIVATE	(__GFP_PRIVATE | __GFP_THISNODE)
 
 #endif /* __LINUX_GFP_TYPES_H */
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a6e5a44c9b42..f042cd848451 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -37,7 +37,8 @@
 	TRACE_GFP_EM(HARDWALL)			\
 	TRACE_GFP_EM(THISNODE)			\
 	TRACE_GFP_EM(ACCOUNT)			\
-	TRACE_GFP_EM(ZEROTAGS)
+	TRACE_GFP_EM(ZEROTAGS)			\
+	TRACE_GFP_EM(PRIVATE)
 
 #ifdef CONFIG_KASAN_HW_TAGS
 # define TRACE_GFP_FLAGS_KASAN			\
@@ -73,7 +74,6 @@
 TRACE_GFP_FLAGS
 
 /* Just in case these are ever used */
-TRACE_DEFINE_ENUM(___GFP_UNUSED_BIT);
 TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
 
 #define gfpflag_string(flag) {(__force unsigned long)flag, #flag}
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 473aa9261e16..1a597f0c7c6c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -444,21 +444,32 @@ static void guarantee_active_cpus(struct task_struct *tsk,
 }
 
 /*
- * Return in *pmask the portion of a cpusets's mems_allowed that
+ * Return in *pmask the portion of a cpuset's mems_allowed that
  * are online, with memory.  If none are online with memory, walk
  * up the cpuset hierarchy until we find one that does have some
  * online mems.  The top cpuset always has some mems online.
  *
  * One way or another, we guarantee to return some non-empty subset
- * of node_states[N_MEMORY].
+ * of node_states[N_MEMORY].  N_MEMORY_PRIVATE nodes from the
+ * original cpuset are preserved, but only N_MEMORY nodes are
+ * pulled from ancestors.
  *
  * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
+	struct cpuset *orig_cs = cs;
+	int nid;
+
 	while (!nodes_intersects(cs->effective_mems, node_states[N_MEMORY]))
 		cs = parent_cs(cs);
+
 	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
+
+	for_each_node_state(nid, N_MEMORY_PRIVATE) {
+		if (node_isset(nid, orig_cs->effective_mems))
+			node_set(nid, *pmask);
+	}
 }
 
 /**
@@ -4075,7 +4086,9 @@ static void cpuset_handle_hotplug(void)
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
-	new_mems = node_states[N_MEMORY];
+
+	/* Include N_MEMORY_PRIVATE so cpuset controls access the same way */
+	nodes_or(new_mems, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
 
 	/*
 	 * If subpartitions_cpus is populated, it is likely that the check
@@ -4488,10 +4501,21 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
  * __alloc_pages() will include all nodes.  If the slab allocator
  * is passed an offline node, it will fall back to the local node.
  * See kmem_cache_alloc_node().
+ *
+ *
+ * Private nodes aren't eligible for these allocations, so skip them.
+ * guarantee_online_mems guaranttes at least one N_MEMORY node is set.
  */
 static int cpuset_spread_node(int *rotor)
 {
-	return *rotor = next_node_in(*rotor, current->mems_allowed);
+	int node;
+
+	do {
+		node = next_node_in(*rotor, current->mems_allowed);
+		*rotor = node;
+	} while (node_state(node, N_MEMORY_PRIVATE));
+
+	return node;
 }
 
 /**
-- 
2.53.0

