Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640222;
	b=mIm1shD3VklHDDeYkEiHUNcVPenZEE8cVa83342CizmS5T0HoOmIsU5AErw5frr6VaQy
	 dlqLOJ8eyP5NRrUvQeF4UaYhRJJAGpgALBoaPa+KCg+WSfrsIebTArvv5YQRKIuhr9dLw
	 B2LE76tk+GmrvCrPY2LG71WSqH4KdMeQJhNDOTKgtJA5RxGRYSw++08dyFRbIY+UVneM2
	 67lkFy3kP/c0XZgAbYaDIGwlUN6ZGYkfTf0GRKTIU2vVFkef/Y3lm2Ct1QmSYRU5LCWTU
	 ehGPiT/Bus4o35Ylq19fpPr/+e8/DrLCWJt0heNOs/qMZd/7cS4pAo+6WNhT67n7ZOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DOXRgiF+CNyVqkJbhOIwPMg67CTmwFoCbwz1N9b8GHg=;
	b=hH8yHLa7r9fWL6qSESwkEfb4AQbE1hZQJwUYnEZeozasSm3N+G2uK8n37QAeo46T+oaR
	 2rDtqhpVLTUYmk3JXetyvWxvDw3QUI/VlqOtNeTJy3Ur9PDsemEj4u3RlE0U6SZw97rYI
	 Ft3KUd4Abvl/ocGH5Vw8v9ft+tcKQ9Yoq+lXGH3PU1X5FWd8Qf3KAHUfmA08SZWaisyR8
	 cg8J9XlHhijWLMwfF2OlK2uGR1USN6C1aTccG02ZJrAPS2UHaeHELVdYXNeBVht4fh8zK
	 7PRSQund0Xs1XVsGOPJuqmUl9Sz8lQ5WC5iKleMQJCsbltgTMSx5eccyoipEv4Cea6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jm0Yuk6K;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7C60A3832
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF7C60A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=jm0Yuk6K
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ec396c93dso42906256d6.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640221; x=1795245021; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOXRgiF+CNyVqkJbhOIwPMg67CTmwFoCbwz1N9b8GHg=;
        b=jm0Yuk6KF9WGOWT81mszApAZVTRc355RYTEspuIQLQ4KgQULtkpjkppFBZ2WwDc+Ml
         RGy/WaZj7U5EXv48pQa90bWYYM3CNIPDzHjGVOHIzCu67UdDULaloIJomuEJmyNURE7O
         8EAcYMfJreLdu+0tEiPgTjaPrxtXZUJksvQFgPtagKf2RcLMLfpth/2aXI+cKGLx76aX
         5IWjCDJnvfnrVDH1LSW4aPPznas5r7ttc3HdsFc9Ns/Zym6CiPYQPE9H5dJ1rPp/5hFE
         SoGn+X2PfYnQss35Xu+ZqPGEnx+a/YoIDaRodgvjyZdtBRE1baABdvBpK29RCL7T0JBy
         fFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640221; x=1795245021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DOXRgiF+CNyVqkJbhOIwPMg67CTmwFoCbwz1N9b8GHg=;
        b=lfihVn2eqllYdetGtizBkpuW6orfxXVvH2rVGxIEsP2lyaMXHJnRAhw/wFILPdD9CW
         qEU161OIpD5A0v4w7THNzHzZwsQup7QI71aKLH47Y/6C/hhuyxxeYA27sbr5ogJFe/G7
         IsoaJgFfArxVbxn80kfAIWvJXViV67lMWZZnJcRYIWvzEXCtMUt40bquwyoDCNgCTI59
         RhTDGdxz2eqDIy18nRwi1mYbdAuTaSEGiQbAmvgBkHEFNGA0w8lA+HT84zz7E++JSY9e
         M+KE3svkCd27lkUOnBogDe+R1u6lx7SOeFGA6ZMyJhEyXsLLGeZ0uKdrP3UyVl4mHk7E
         DtDw==
X-Forwarded-Encrypted: i=1; AL+hErHKQC6znRblxlvHW2RnOh4udWXgZmPzEArpCil7ZYIwlZcqcsTSUFeQ37tpQpvk53wIzOWiSg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8p4p4b4q8AsX1v4nyaA19PSaM3+rIeGFSZsCTfj7dDeDEFMz3F
	/cgZ23EooUP+2ghxS304d4eELvxNXzs8WEcD6/IhwfvaYB7V7t0QxkKWP0lJV69hTis=
X-Gm-Gg: AYBFou1vf175ZanYumaJiB8KIS2QFA5xFJw+MYViVB4+1R3pEhtcJqYQ+9eM18JhZVi
	yHHOnmSWvKHSkLqM8/Xyo3PFVTS7iVgc4twB+TibGSoLZf09mIGtnC4IDiv/zv2NBkYo6KVrThB
	WqRnsfG1ms0Bu5SD5GwXNBmkO1O/3yEpRqMri0Gpsanc/tdCru3TzwiNyaKokr9Xf7iZTmOXTNh
	hfNOYzgqXLGHFZLSDERtBgQ1PSm0WIPINXypsSU6C4TFbMdWxEtWlw1hunSG5uJIyZpuC7Se2Ep
	pMZ2YXwpoWg/cMf8y5Dfe7KvJ/48O7HYSsahLEHxl2jKehkvGHILWkRSMpV74NMc7sFux+S5unm
	ZqrzskpptiyCj39hEGPNbT2PSG1v9TOpvHhFocmnKgeyY+l4PVhOzsPg/2VbolllRooRXUS3Eek
	IMUxzN+zx/Prf5zIDOsUJ5nr/P9IMETtQkMSqGSZs8gKxSg+KPqcnJ//sQTdfJN88v/Jx2KUUCj
	RYmPuMBrgFVNpPw2xSPpk30SEhZcptZ2IsfSFzrPXZUNK7XFzdWvsWi6YOQYr8xfyXESCRiqlJg
	PjbWAP7iv6RlDKfKx9t8jNf2hm07kjvDqBlrwaEsGFQdyKU5xrMiwkQrUGxBLs7YpJTgaXNyf60
	ISITWNLkmr2QvD18=
X-Received: by 2002:a05:6214:3905:b0:91e:7f01:f95a with SMTP id 6a1803df08f44-91f24229457mr72251376d6.46.1794640221033;
        Fri, 13 Nov 2026 23:10:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:20 -0800 (PST)
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
Subject: [PATCH 08/22] mm/memory-tiers: restrict demotion topology to common memory
Date: Sat, 14 Nov 2026 02:09:45 -0500
Message-ID: <20261114070959.3490008-9-gourry@gourry.net>
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

Memory outside N_MEMORY_COMMON is outside the ordinary allocation pool
and cannot be a generic demotion source or destination.

Build demotion paths and the default DRAM performance reference from
N_MEMORY_COMMON rather than every node that has memory, and do not
assign other nodes to a memory tier through the generic hotplug path.

Removing a node's memory already resets its demotion targets, so a node
that unplugs and returns outside N_MEMORY_COMMON keeps none.

All memory nodes currently carry N_MEMORY_COMMON, behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory-tiers.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 7fc56a8c66518..97d5ecefd89f3 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -370,7 +370,8 @@ int next_demotion_node(int node, const nodemask_t *allowed_mask)
 	 * closest demotion target.
 	 */
 	nodes_complement(mask, *allowed_mask);
-	return find_next_best_node_in(node, &mask, &node_states[N_MEMORY]);
+	return find_next_best_node_in(node, &mask,
+				      &node_states[N_MEMORY_COMMON]);
 }
 
 static void disable_all_demotion_targets(void)
@@ -405,7 +406,7 @@ static void dump_demotion_targets(void)
 {
 	int node;
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_state(node, N_MEMORY_COMMON) {
 		struct memory_tier *memtier = __node_get_memory_tier(node);
 		nodemask_t preferred = node_demotion[node].preferred;
 
@@ -441,7 +442,7 @@ static void establish_demotion_targets(void)
 
 	disable_all_demotion_targets();
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_state(node, N_MEMORY_COMMON) {
 		best_distance = -1;
 		nd = &node_demotion[node];
 
@@ -459,7 +460,7 @@ static void establish_demotion_targets(void)
 		 * nodelist to skip list so that we find the best node from the
 		 * memtier nodelist.
 		 */
-		nodes_andnot(tier_nodes, node_states[N_MEMORY], tier_nodes);
+		nodes_andnot(tier_nodes, node_states[N_MEMORY_COMMON], tier_nodes);
 
 		/*
 		 * Find all the nodes in the memory tier node list of same best distance.
@@ -468,7 +469,7 @@ static void establish_demotion_targets(void)
 		 */
 		do {
 			target = find_next_best_node_in(node, &tier_nodes,
-							&node_states[N_MEMORY]);
+							&node_states[N_MEMORY_COMMON]);
 			if (target == NUMA_NO_NODE)
 				break;
 
@@ -507,7 +508,7 @@ static void establish_demotion_targets(void)
 	 * allocation to a set of nodes that is closer the above selected
 	 * preferred node.
 	 */
-	lower_tier = node_states[N_MEMORY];
+	lower_tier = node_states[N_MEMORY_COMMON];
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		/*
 		 * Keep removing current tier from lower_tier nodes,
@@ -554,7 +555,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	if (!node_state(node, N_MEMORY))
+	if (!node_state(node, N_MEMORY_COMMON))
 		return ERR_PTR(-EINVAL);
 
 	mt_calc_adistance(node, &adist);
@@ -706,8 +707,8 @@ static int __init memory_tier_late_init(void)
 	get_online_mems();
 	guard(mutex)(&memory_tier_lock);
 
-	/* Assign each uninitialized N_MEMORY node to a memory tier. */
-	for_each_node_state(nid, N_MEMORY) {
+	/* Assign each uninitialized common memory node to a memory tier. */
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		/*
 		 * Some device drivers may have initialized
 		 * memory tiers, potentially bringing memory nodes
@@ -929,8 +930,8 @@ static int __init memory_tier_init(void)
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
-	/* Record nodes with memory and CPU to set default DRAM performance. */
-	nodes_and(default_dram_nodes, node_states[N_MEMORY],
+	/* Record common-memory nodes with CPUs for default DRAM performance. */
+	nodes_and(default_dram_nodes, node_states[N_MEMORY_COMMON],
 		  node_states[N_CPU]);
 
 	hotplug_node_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
-- 
2.53.1-Meta

