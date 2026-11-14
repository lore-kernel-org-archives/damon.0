Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640208;
	b=atSLn+GsOXUvheQj7M7GBX1GzTZgj8gy5JhXcfE5sKQMHlvMY/OwBOS1hm0Py5me3z5Q
	 5ykLL5+jcxss4WBA4xf+51/tRAXDpnzJmGDondFeP/4e0ux95w/MahPo3WdDaTeWyU5JH
	 U9uE8fZGqWum3ETaEtAgH74FWXfD1qx/Pvwvmr5QKWnXq0jHtvnqpcKRMx05LT3dhZYnH
	 LjbT277EFaHk39qJNPMF1Q2rs5KOZkGQYT9BVDakRp1H8dFSd6qVdp+0wgiaJU0q8Rppe
	 OOr4Pw/rOkRdrhLYlI91HDS3x2n6NCwsB6k8LvQ81/Uc/8XyMBlvwuHHRvehld9ftwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8m1rh8YCtMa/eK/x1h9nBhdh93CAkPykNk2YYLlQM4w=;
	b=1/ZENsYr32WsO4rsAA0tjYuTAKwvX9z47zlyoIWgb7yIVKcRMbvlSZVWnh6eco0KX1qu
	 m8vI+bhFwLZe2V4k4LITn7okKbqQIV2JGILV7lfkeqEn/U0NbaIUbK1Gybs8tL6rkTKV9
	 WIUH0RfVXdDtsVwIkDBtBcQqYtFdiHSXfBz7g6oQWh85puoG1non54Hw9NhcVyLngpujM
	 hcyZ9kr8cseTfegfab3RP2eCkJ/YSo7GinqNALMQyZPKIX6Vu2l2nbSYFHGdyqvqCrOKr
	 Q/iGtoH7z6v2MuiAKUzsEya+M8LRggMTw4NMOk72gB0S5FMtLPvYchLKjoh73VFmf9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=P1KGu7Wu;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B34606A883
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2B34606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=P1KGu7Wu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f2b8cf037so243025885a.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640207; x=1795245007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8m1rh8YCtMa/eK/x1h9nBhdh93CAkPykNk2YYLlQM4w=;
        b=P1KGu7Wuvr6v2oBfj4o311JBLaA6bJBWLTGeoD7tgptsObosBN/jdmP7P5w40mI2qf
         X1/N1YXnNnLErR31QfZtLDozOklLkSrmkA4PogYf/wckxtlyG/C5FL5bhODovIoK2QoY
         dbp+vVRA2F7X3pqKNac2YPoDH41bpCPmj9bu3que3A0N89DSBDbK3lQbEdE24IT5iVyI
         ACnCKepbmr0bid2xKcwJkaDF14LnhFemu5COpgzjRyFmrLiC2IdRJFggWbBU0CCyN+CM
         Jba2t0FfHrjeWGKOwi2+qHZddBFiyvxDYdueeobPtFOrwXDo+6j+lU9gPPUwhdqshLiE
         Ojtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640207; x=1795245007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8m1rh8YCtMa/eK/x1h9nBhdh93CAkPykNk2YYLlQM4w=;
        b=dKPqrv5ZQHIpvmKLelC5K/lqa+L7XO8NQrGEa1wZZFbhmH8hYGQ40HBK3fGeOIUhZ/
         5GdoNHK8qwk7O5vElYVaT1zZ6Tk4lGiumma7SNSFKE7KQPJAHYOOqkkGP4MakjMum4oe
         Xa5WDmxLdgr59RQQ8r3c23I4/+Rn7twmCogUO/AEnXY7ymJIJ3DKU69V/hpFcSB0INYK
         CeRajp8hxD9GxI5S64MVLMj7ryHYl5z/WlEod8P3K75R2BFAAkt0Rtbc5B/lB9LqJGMA
         +//UhLs7jMEAEBUbeJaYr/fKW0ibVgY3nBXdLU0vbEmCuKDmP5u5cdCuYa6rVaoShiFo
         ZFRQ==
X-Forwarded-Encrypted: i=1; AL+hErFEyi42Gc3BNC0+hcYfL9JnHg3OSKl4TyAoPkbwlE7ohB2LAozEbUzfjMYRhwRZPgWYHv+A6Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Rj5NmFc5ybEeDuHg9+cBdTC0CLr6TxOQk4zSK4EJaApEbvqkx
	OmQ2UgyP6+tiwec/wDnnxsgKj3A4y0rrdGTrNGSj5KPXHrb0uckBcoswSa6XMxroN7I=
X-Gm-Gg: AYBFou1coPVeg4PBvPx9XUPJJMJnZSBLhwA8vH7LlpR3Q2E2SlKsrfGPU9A+eyCXaRA
	Rj564BeU0owRi5XuB7L7+zrPl0cZ9QvkhHAbt79p5fpr9r0MML5YW7BZvrzT7zxI1Vt7jHaxu7w
	0mrrnF9GadL58ReKnwHJusgI5Y9aFMMxuagqkdfN9fLRSDMMGpA3r2yuhz3cHzRxL3J/vFPRkv3
	Qou1BIrbWZj9Kcs1gFAB1f6QEVw6Ec8wsFscPyb1T76afqV/Gz+gKCNElt9PWgHwCwtcBZunH4Q
	8vgufaugKUMIcP9AGSVsNL08i6ukcic59y9mnSTNN41yGY2m8kBXxLbnHJjZxuEO4EJjmMR2q2D
	hKqyAfOXspTHceGlwq8QOEPEesCiktbrW5eTeMFEX8CTfcHLGy5uzR24e2sJK+wp5SInqsBM+w8
	bI77xa3J7wqc9WUbZFSjI+MtLu5RUebzb8sn69cKIApeul/RK/wOZJDNejhZB6EUItxDBpPc7Wy
	zYSWNOK/UzSc8TSfriKJfksTVMfogpQa/H5slS9uo3hldUSvlAWIAOM8dUvrQoIwR5xVIOUcmrW
	4Bzggj1Hzpna3ROXvbF6DlnyOyMIf2K3O1+mQx4lvkkvgVRQYEHouA4ukdRHD8NoCkkMa72El1b
	Iw6+qxfxWLocYdqQ=
X-Received: by 2002:a05:620a:6606:b0:93a:2d07:142f with SMTP id af79cd13be357-9494b9aec7amr802433485a.7.1794640206954;
        Fri, 13 Nov 2026 23:10:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:06 -0800 (PST)
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
Subject: [PATCH 01/22] mm: add node-state-filtered zone and node iterators
Date: Sat, 14 Nov 2026 02:09:38 -0500
Message-ID: <20261114070959.3490008-2-gourry@gourry.net>
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

Add node-state-filter helper functions/macros so MM walkers can select
their node eligibility explicitly.

Add nodemask intersection and nodemask/state iterators using the bitmap
intersection helpers, without allocating a temporary nodemask.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/linux/mmzone.h   | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nodemask.h | 28 ++++++++++++++++++++----
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c161d563ce8fd..5ff190d870830 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1845,6 +1845,13 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+/* Populated zones on nodes in @state. */
+#define for_each_populated_zone_state(zone, state)	\
+	for_each_populated_zone(zone)			\
+		if (!node_state(zone_to_nid(zone), state))	\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
@@ -1937,6 +1944,45 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 			zone = zonelist_zone(z))
 
 
+static inline struct zoneref *
+next_zones_zonelist_state(struct zoneref *z, enum zone_type highest_zoneidx,
+			  const nodemask_t *nodes, enum node_states state)
+{
+	z = next_zones_zonelist(z, highest_zoneidx, nodes);
+	while (zonelist_zone(z) && !node_state(zonelist_node_idx(z), state))
+		z = next_zones_zonelist(++z, highest_zoneidx, nodes);
+	return z;
+}
+
+static inline struct zoneref *
+first_zones_zonelist_state(struct zonelist *zonelist,
+			   enum zone_type highest_zoneidx,
+			   const nodemask_t *nodes, enum node_states state)
+{
+	return next_zones_zonelist_state(zonelist->_zonerefs, highest_zoneidx,
+					 nodes, state);
+}
+
+/**
+ * for_each_zone_node_state - iterate zones in intersect(nodemask, node_state(state))
+ * @zone: The current zone in the iterator
+ * @z: The current pointer within zonelist->_zonerefs being iterated
+ * @zlist: The zonelist being iterated
+ * @highidx: The zone index of the highest zone to return
+ * @nodemask: Nodemask allowed by the allocator
+ * @state: The node state the zone's node must be in
+ *
+ * The state filter is part of the iteration rather than a trailing if, so that
+ * this expands to a single for statement: a macro ending in an unbraced if
+ * silently steals a following else from the caller.
+ */
+#define for_each_zone_node_state(zone, z, zlist, highidx, nodemask, state)	\
+	for (z = first_zones_zonelist_state(zlist, highidx, nodemask, state),	\
+		zone = zonelist_zone(z);					\
+		zone;								\
+		z = next_zones_zonelist_state(++z, highidx, nodemask, state),	\
+		zone = zonelist_zone(z))
+
 /**
  * for_each_zone_zonelist - helper macro to iterate over valid zones in a zonelist at or below a given zone index
  * @zone: The current zone in the iterator
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 607373bd83ee6..28a456c3f5964 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -386,6 +386,10 @@ static __always_inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *ori
 	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
+/* Iterate the nodes present in both masks without a temporary nodemask. */
+#define for_each_node_mask_and(node, mask1, mask2) \
+	for_each_and_bit(node, nodes_addr(mask1), nodes_addr(mask2), MAX_NUMNODES)
+
 /*
  * Bitmasks that are kept for all the nodes.
  */
@@ -411,6 +415,10 @@ enum node_states {
 
 extern nodemask_t node_states[NR_NODE_STATES];
 
+/* Iterate the nodes in a mask that also belong to the specified state. */
+#define for_each_node_mask_state(node, mask, state) \
+	for_each_node_mask_and(node, mask, node_states[state])
+
 #if MAX_NUMNODES > 1
 static __always_inline int node_state(int node, enum node_states state)
 {
@@ -435,15 +443,21 @@ static __always_inline int num_node_state(enum node_states state)
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
-#define first_online_node	first_node(node_states[N_ONLINE])
-#define first_memory_node	first_node(node_states[N_MEMORY])
+#define first_node_state(state)	first_node(node_states[state])
+static __always_inline unsigned int next_node_state(int nid, enum node_states state)
+{
+	return next_node(nid, node_states[state]);
+}
+
+#define first_online_node	first_node_state(N_ONLINE)
+#define first_memory_node	first_node_state(N_MEMORY)
 static __always_inline unsigned int next_online_node(int nid)
 {
-	return next_node(nid, node_states[N_ONLINE]);
+	return next_node_state(nid, N_ONLINE);
 }
 static __always_inline unsigned int next_memory_node(int nid)
 {
-	return next_node(nid, node_states[N_MEMORY]);
+	return next_node_state(nid, N_MEMORY);
 }
 
 static __always_inline void node_set_online(int nid)
@@ -481,6 +495,12 @@ static __always_inline int num_node_state(enum node_states state)
 #define for_each_node_state(node, __state) \
 	for ( (node) = 0; (node) == 0; (node) = 1)
 
+#define first_node_state(state)	0
+static __always_inline unsigned int next_node_state(int nid, enum node_states state)
+{
+	return MAX_NUMNODES;
+}
+
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-- 
2.53.1-Meta

