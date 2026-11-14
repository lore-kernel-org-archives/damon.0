Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640213;
	b=ZLsB9vkhovWA+Re1b8zBIjM78V3UAVXESUh/aLvs+kXcmfXUPd+BDaCkEzEBEodhY08M
	 atysjL2fpTvB21mG63iIqwpdwVCyyyPjVUbmNA//gjDHXEgdpLBqt17HYV4dDGaDOwyC6
	 OyALM2EaQTdiE7EO/lwjQHFjUYUtK12ptfjKRtwnnre+z2MMqtr/xv/h4tkU28YaZEGZh
	 M+xWIid5ROHyzoS+DPldZ0WwwqHBSNbeeXkPQnAsOKDVLJy1cxO2kjYklOIygwQ1jLb9M
	 WXLAZcaV4Lk7X32uVda0ZzwsYGpZsUXB3z39A0wMyCijNTmSujCZvAxv+vVazrnL5LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2lEa1LIQv4RtVFSRolNpT9VAJCtG2n7xXC0f3lXhF2k=;
	b=wd/gwyxa6thpztgoC//7yQz3G9aOsvYq86+e9QyLuQskRE+g+K3incnxT/sz+fWMuWs6
	 WvxNfPOFo6eN9BPYfnlayDelG+fIuTgEN4y/90S6HBTolF0lWvYNrXIf/bEDU3n5aF8pV
	 IEU9pC+Kij2xrHh+7uxGccAL1QIstE/mfNiw6Xqp1vuXAhoZu5i8RRyPi/to5J9fDW75D
	 V7V8tnWT+RIUgd2S5CUdz+fJ25TVex8Unj9LUCLie+maBF9OIGQb6I+VpfHJ7gEvDhXnq
	 Tz1UXLo1k2o1wTUCahclqqao5gGk54fVLGor1dW4Lpk6RAMaoKJQz5zczbhJSIaIo9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WJ5Es01F;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A340606A8BA
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A340606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=WJ5Es01F
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55c38cdd5b7so8407681cf.2
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640211; x=1795245011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2lEa1LIQv4RtVFSRolNpT9VAJCtG2n7xXC0f3lXhF2k=;
        b=WJ5Es01FE/XOKlwQ3knDZGuJhDhs832ZkGGGpOEw1d7SiyFaRGZYb6OBwiNn6qD+sL
         AcVE/9r6RDrnV7lJOPytXo608c0HaVeBxivhJXO51tJgu0wuCOOaX/1B89e6bB9AdPmT
         28hGKTQ0WpFn/nn4MxOTS2/O82+rU0TjKsexJiJAyrE753z26alSOLhWasE6WV/RK7l+
         wYhnHQoOwKXiwnM+lH61at8LsI/nGN7pmZ3oWMyGfoE4ybu9Wn6AimgOVdh1DjB2f/vQ
         B9M3LpWj/n4xyhXxAxjg9lmkgXyjss29XU5WS0XGtcI+slH3VRugEMUSDUAhTER+LMhy
         BoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640211; x=1795245011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2lEa1LIQv4RtVFSRolNpT9VAJCtG2n7xXC0f3lXhF2k=;
        b=vi8U9RCMUrUmdUxFmsAIE24AbUHiR/PZqPqdjzP6NcKGe2bm1bBR0gFblNdF9jDlH8
         IJXeb1sPXeJgAudRw7F1Edfo/q989GYb86KL+M5Y1h1LVkuhIO9hMNqptLsNXLQft7qC
         n9KPyCHeKGyVY9es6fEsERblLeLbBuqDb4z2DuVuD0pyqWM2qpSZgSIeWzJS+ymH5UhS
         bi3033JR+pCCX4AVOiL2UE+b4DjaT789EepnBmUXi2JI2nk6UN+uw4/ZbLqm8B0kf5hJ
         elsWRHf/X/b9zJ2fmksN6wi9NLZfSpZne/z3zXp2uO8nMx70xT8VnUZNWQV60U8mwGOy
         MI2w==
X-Forwarded-Encrypted: i=1; AL+hErH2bxslk3jxbzTq4i3dI7WVypJQGGa36vYugla3t+WiHFtwspYiiG38PMH4Mh9P4V2bXTq3pA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jAytofj+kUxsqQU02zvZsuBGsh5VLa1mCM0BV085iJ8vgH6Ig
	YqZ+Wzi9BfPzZqnI3aHBZjVcnW4/uAkqDlr9zcO96IlJPbV/SXWy6Auxb3nEoS4311A=
X-Gm-Gg: AYBFou0Tch5gVEwxvbxkg0punuyy+Plh6Pb1D7fZeCzGGlFB3bw1Nu5Jg1XpYP5oKJL
	wVv6f+tJ0h++N/lhtxRm2Ke+WZWi4dJxS2Xd5UztCHM2c2w1gzwLLZqpv25fsUuSU1n2WRB7Ny4
	nUnwTOxizSeIfJnqSfj59r7veP78FC04R41HexKPaYyr6gIss2oxNFruitBp2lJkdLLwQURoAcR
	GOBfcovjMlrhvC4vGPoeeyKLXce/Gr6PK7ooJOCBl0rlAsKqNNrcRoeRfJSlfZ35kfwrP6tVErD
	uczzT5o2A1stSbCL6bj1RVeA0femkrU740/bRWXX4Hdyx7z26GIumfG9mW9BnD4q2pLJzkwYpTe
	LFMa6k1Q721f51PdBxEwll+pXt72zLlX5rixcF0HeK7ncH18Cpshb301jEqEwet80gcUZ29CHv2
	Lvbe2pYaYHdJ9Bq7v+lSTI90zkCOoYDGvUo7YrW3VrNpsU9bMKjl78kMs7sDmUTOgEpllpdOzlI
	wYQnICFX/7EvBp7Wb1EcphyYcI8Y87F7PuoxShZsMtO054/d5413j9xZJGpUH5BYKWc3MIpHz9f
	2WaD3/NfKlV/666HGu12Kn8QBOxq7S2kiEtoPvc2LT3rbsyzgrdxXrXtMx5W6HVRC16fl7xeUt0
	hUw+jlOGSIa+SHgDEfXWx8+Y/Y/dz4IUUl/X6
X-Received: by 2002:a05:622a:355:b0:535:f9dd:cb9b with SMTP id d75a77b69052e-55ac817ffbemr80325101cf.26.1794640211080;
        Fri, 13 Nov 2026 23:10:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:10 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	johan@kernel.org,
	jirislaby@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	pavel@kernel.org,
	lenb@kernel.org,
	hannes@cmpxchg.org,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	sj@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	matthew.brost@intel.com,
	byungchul@sk.com,
	apopple@nvidia.com,
	rientjes@google.com
Subject: [PATCH 03/22] mm: introduce the common-memory node state
Date: Sat, 14 Nov 2026 02:09:40 -0500
Message-ID: <20261114070959.3490008-4-gourry@gourry.net>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114070959.3490008-1-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

N_MEMORY is overloaded with two meanings:
  1) a node has memory.
  2) a node's memory is reachable via ordinary allocation or
     an arbitrary MM service may use that memory.

Allow N_MEMORY to mean #1, and introduce N_MEMORY_COMMON to mean #2.

N_MEMORY_COMMON nodes contain "common memory" capable of being managed
arbitrarily by the kernel MM based solely on zone membership. Following
commits convert relevant N_MEMORY users to N_MEMORY_COMMON.

Add folio_is_common_memory() and page_is_common_memory() for MM services
that walk folios. Following commits convert folio_is_zone_device() and
page_is_zone_device() callers accordingly.

Expose the state via `has_common_memory` so userspace can identify
the memory available to ordinary allocations and common MM services.

Add has_memory to the docs while we're here.

Every node with memory is common, so N_MEMORY_COMMON equals N_MEMORY
and there is no behavioral change.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 Documentation/ABI/stable/sysfs-devices-node | 16 ++++++++++++++++
 Documentation/mm/physical_memory.rst        |  8 +++++++-
 drivers/base/node.c                         |  2 ++
 include/linux/nodemask.h                    |  9 ++++++++-
 mm/internal.h                               | 15 +++++++++++++++
 mm/page_alloc.c                             |  3 +++
 6 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 2d0e023f22a71..a93de328f8fe8 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -10,6 +10,15 @@ Contact:	Linux Memory Management list <linux-mm@kvack.org>
 Description:
 		Nodes that are online.
 
+What:		/sys/devices/system/node/has_memory
+Date:		December 2012
+Contact:	Linux Memory Management list <linux-mm@kvack.org>
+Description:
+		Nodes that have memory.
+
+		This memory may or may not be reachable via standard
+		allocations, see has_common_memory for details.
+
 What:		/sys/devices/system/node/has_normal_memory
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
@@ -29,6 +38,13 @@ Description:
 		Nodes that have regular or high memory.
 		Depends on CONFIG_HIGHMEM.
 
+What:		/sys/devices/system/node/has_common_memory
+Date:		November 2026
+Contact:	Linux Memory Management list <linux-mm@kvack.org>
+Description:
+		Nodes whose memory ordinary allocations may use without
+		requesting the node explicitly.
+
 What:		/sys/devices/system/node/nodeX
 Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 2e67e8b23a994..fd5c5d136180f 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -168,7 +168,12 @@ nodes with particular properties as defined by ``enum node_states``:
   The node has regular or high memory. When ``CONFIG_HIGHMEM`` is disabled
   aliased to ``N_NORMAL_MEMORY``.
 ``N_MEMORY``
-  The node has memory(regular, high, movable)
+  The node has online memory (regular, high, movable).  This is a topology and
+  accounting state. Presence in this mask does not mean ordinary allocations
+  can use the node's memory; see ``N_MEMORY_COMMON``.
+``N_MEMORY_COMMON``
+  The node is on the page allocator's fallback zonelists, so an allocation
+  that named no node can be satisfied from it.
 ``N_CPU``
   The node has one or more CPUs
 ``N_GENERIC_INITIATOR``
@@ -184,6 +189,7 @@ For example, for node 2 with normal memory and CPUs, bit 2 will be set in ::
   node_states[N_NORMAL_MEMORY]
   node_states[N_HIGH_MEMORY]
   node_states[N_MEMORY]
+  node_states[N_MEMORY_COMMON]
   node_states[N_CPU]
 
 For various operations possible with nodemasks please refer to
diff --git a/drivers/base/node.c b/drivers/base/node.c
index dcdc8626627a8..cc6696d1390f3 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -965,6 +965,7 @@ static struct node_attr node_state_attr[] = {
 	[N_HIGH_MEMORY] = _NODE_ATTR(has_high_memory, N_HIGH_MEMORY),
 #endif
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
+	[N_MEMORY_COMMON] = _NODE_ATTR(has_common_memory, N_MEMORY_COMMON),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
 	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
 					   N_GENERIC_INITIATOR),
@@ -978,6 +979,7 @@ static struct attribute *node_state_attrs[] = {
 	&node_state_attr[N_HIGH_MEMORY].attr.attr,
 #endif
 	&node_state_attr[N_MEMORY].attr.attr,
+	&node_state_attr[N_MEMORY_COMMON].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
 	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
 	NULL
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 28a456c3f5964..7ace610bdd654 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -402,7 +402,14 @@ enum node_states {
 #else
 	N_HIGH_MEMORY = N_NORMAL_MEMORY,
 #endif
-	N_MEMORY,		/* The node has memory(regular, high, movable) */
+	/*
+	 * N_MEMORY indicates online memory exists on the node - it is used
+	 * to manage per-node meta-data and topology decisions.
+	 * N_MEMORY_COMMON indicates whether the node can satisfy arbitrary
+	 * allocations and whether a service should manage that node's folios.
+	 */
+	N_MEMORY,		/* the node has memory */
+	N_MEMORY_COMMON,	/* common pool (fallback zonelist) */
 	N_CPU,		/* The node has one or more cpus */
 	N_GENERIC_INITIATOR,	/* The node has one or more Generic Initiators */
 	NR_NODE_STATES
diff --git a/mm/internal.h b/mm/internal.h
index 608a83c34c224..af6fc27a9fc98 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -65,6 +65,21 @@ void folio_mark_lazyfree(struct folio *folio);
 void node_set_memory_state(int nid, bool high, bool normal);
 void node_clear_memory_state(int nid);
 
+/*
+ * Common memory is available to generic MM services. ZONE_DEVICE folios do
+ * not qualify even when their NUMA node is common.
+ */
+static inline bool folio_is_common_memory(struct folio *folio)
+{
+	return !folio_is_zone_device(folio) &&
+	       node_state(folio_nid(folio), N_MEMORY_COMMON);
+}
+
+static inline bool page_is_common_memory(struct page *page)
+{
+	return folio_is_common_memory(page_folio(page));
+}
+
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 834d199ff8429..6ffa972811462 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -203,6 +203,7 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 	[N_HIGH_MEMORY] = { { [0] = 1UL } },
 #endif
 	[N_MEMORY] = { { [0] = 1UL } },
+	[N_MEMORY_COMMON] = { { [0] = 1UL } },
 	[N_CPU] = { { [0] = 1UL } },
 #endif	/* NUMA */
 };
@@ -215,10 +216,12 @@ void __meminit node_set_memory_state(int nid, bool high, bool normal)
 		node_set_state(nid, N_HIGH_MEMORY);
 	if (normal)
 		node_set_state(nid, N_NORMAL_MEMORY);
+	node_set_state(nid, N_MEMORY_COMMON);
 }
 
 void __meminit node_clear_memory_state(int nid)
 {
+	node_clear_state(nid, N_MEMORY_COMMON);
 	node_clear_state(nid, N_NORMAL_MEMORY);
 	node_clear_state(nid, N_MEMORY);
 }
-- 
2.53.1-Meta

