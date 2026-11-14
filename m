Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640211;
	b=X59gMebJ1aDY/8r+RnzZOvRDo5X9OW+OIALJMYikecHeIQpjHMCJnQC/n199c7miMSZ6
	 E3nZldq4R8nlYM8ClWBIsH76THaIdEDXUiMqc7q4DqPThQiSo1vF1MIV8pp+Ve7ZSgNeh
	 j+CQHBjxg4ujlmORbqpwKp5ZcBZConZ7VjwCKy40DxM85swXrHlj9TwXdnHSAxELCQXSV
	 MnKTwVJvJ8mfAC3jkyX3lCRXroXggjEd9VYD4iAkZxh7ju8VgEqyIp+YBJmQebdhKnVyd
	 bToOeD/EY8mkMzGu2GM4A4GDopbxthZIBMvIIaUzypTOIA2uiMIjTEZTKVP3oAupRbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
	b=R6UV9z2ZRhENjxgd0mSDhDkVwN2Uw46vAi+3FVCOHMK03/RoUijzYYwbzwVzAs7QdfEJ
	 xvJUAtklGq7y+iiWw/99Poz4MyoS/it/xQoErmEqn2k4KUI9zVY5Bs8BtyaIlM2tfKHyf
	 7YCOdr8RJ7b8/NccE5RsJi8P6mJqZXMYOd37KEvtFn/PibRjTsNOKE3n9F6/yZXcJBt+X
	 r1spccMbtU504Ztsw971SmdQiBcZgA7O4McDukElt2qANQPt8iQIKj3QJuqRHbgPwBmP0
	 E/fhI4CzEq4Sc0jpNYqbM6HBcH/LDScxrjbWuHRDzCxxcb7Cd1yUnyjmMslcnn1A8HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PqLAFOiR;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A729606A8A6
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A729606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PqLAFOiR
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ecbdf5343so39947186d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640209; x=1795245009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
        b=PqLAFOiRQud2tLhS/ABxUgVACPUZ3I9FOI5TkatrC0H2G/XdlD1+cZydgq5Rllvt7a
         MoGW1hDQYg+OHm6q1R8ECLRKIqKNOOM5OnX+5Hay7RU33T8E2SiZ+RSY3gSKCWiWmUfn
         uex/0PD5WnXzkYemmiajHbeb9C1+UScGLzBJQC5/9woCQZUcpFAc50FKjKtXPFXZ/VXn
         qZjVXfPQu3pDTxSkoKUdrHb6cC+BgRetHYi3SkpyLFXryiHJRQ5wDAl5CnrmLcLRK2up
         pRc2bg8pEEa0+7FnuwJDL2sQ3xwBvnBHuMr+LHqX26isokjs+9e8zv11prSUixRbKuiF
         yk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640209; x=1795245009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ra1qoxU4QdTYWMO3cOdicsi3ZqR2JP+4Yyk7L1wLDNk=;
        b=RJIpPHy04r26S272NcGkOav50wAV4p+ZcQHmzVblMO6Z0A9jcdBmgfW3p7TqKfhWBU
         +hQauvwc2JJf08TnX1rJ5rGlkXkPHqFgeBm1blBonc4DA8o8xJqIVXL2jpSfpY3c3pRu
         raEpF7z+EoV947TNU8u5V+j9gNnEuuPH5bPco4e42q1KxJKj190+zqFtS2iKTZWr3Wec
         BlT4+k4yvTJ4Tg7IU1qToaNqoXjd4G71QzMsYYgX1UUSvXDrfUnaZGX2/xvqJEoGJSdB
         UcDC+Ln+fAB3KqjHc1LhqhMGGXQSmLxa/wK8PlMDemt3AV05vFDmMSzAsZp4EEjU35Cc
         xO9Q==
X-Forwarded-Encrypted: i=1; AL+hErHDaROMuRYVabxm+f0FINoxVSS55KJPKwKBVHEi4NqYui4DlATFpSkEOllGqchhJn+eqxScpQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9veON0Hix0D2kopWUTALKt8UkBuJnq6jjw1ijxMICgligzBr+P
	h8NG+6Qfz/vbHYWfY6OJUKI0a4ZkNVvoJXBmYsU3ohhyyKAtgvUttU+77ZOZcrj3ZJs=
X-Gm-Gg: AYBFou19+YTLoU/1O+S1LJgpcL1o9GxZEtyFdo6/htqYJ6rflBhn2Zs5cxxefM8zs9X
	Uh5iu5mB5xfs7ot7HxwYNX7MlfVgOrOmh+s1x5+Qekk0ms8hhKH7/bSzG9VZj/eZfO0a5wamgUQ
	t7lguNF038KjWHFlLZHQDBg5v/De91H3fsFKJdH4+nnsXt2tZ/0Q1pVAS5PMQRAVQdO74lJmjyB
	70BEM8+YODDiVN8HFHdVkLBfLxLeIj2D5z65vk+474BfjISJhJ3ep5VVX4vHFTPLEC69tbbXkfp
	7nRmlB/J5BNKoL/kfDlSUrc+gp12oW+v36xPn58knQozJF9DiiLkVi7ZbyS63m2a4tR23IO/YG0
	Zg3yY/fOxdzDaPjBicPp+nCp7seQBnaQbWu5RVGfHEu3d+Pcf3GiN5gSdMAMPNXyNNytgbo08tT
	EeK+qPizsQkgSqf2wD9B8fSs1OddmhF1a81xO74pY/eTqUJMdGeYCHermAP8GDIACdQD6eH8Uwx
	h1qGnm2jxN2wMTNOdv95vwsDEqf2hxQBuP8lyqBPg30pE5QSGQbael0yVuFfKFrRmkpPnUtucqC
	W/Hvs7Mbsm1pAVYXC79rwNDZKByAs1eDIP9JZ8KiXc4hQWZW7Mv8Mtp66qiRBkaRAtRoUzAzAa2
	Zhs5fd91dkcCb7aDZ91SGBYi++9VhzHamcQNv
X-Received: by 2002:a05:6214:18f1:b0:91f:1a70:4b0c with SMTP id 6a1803df08f44-91f1a70a6famr79219716d6.4.1794640209017;
        Fri, 13 Nov 2026 23:10:09 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:08 -0800 (PST)
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
Subject: [PATCH 02/22] mm: publish and clear node memory states via helpers
Date: Sat, 14 Nov 2026 02:09:39 -0500
Message-ID: <20261114070959.3490008-3-gourry@gourry.net>
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

N_MEMORY, N_NORMAL_MEMORY and N_HIGH_MEMORY are set separately in
free_area_init(), check_for_memory() and online_pages(), and cleared
in offline_pages().

Centralize those updates in node_set/clear_memory_state().

Behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/internal.h       |  3 +++
 mm/memory_hotplug.c | 11 ++++-------
 mm/mm_init.c        | 14 ++++++--------
 mm/page_alloc.c     | 15 +++++++++++++++
 4 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cd3675c044e0a..608a83c34c224 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -62,6 +62,9 @@ void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 
+void node_set_memory_state(int nid, bool high, bool normal);
+void node_clear_memory_state(int nid);
+
 /* mm/vmscan.c */
 unsigned long zone_reclaimable_pages(struct zone *zone);
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f04a248d8adaf..490f400498f14 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1184,14 +1184,11 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	online_pages_range(pfn, nr_pages);
 	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
-	if (node_arg.nid >= 0)
-		node_set_state(nid, N_MEMORY);
 	/*
-	 * Check whether we are adding normal memory to the node for the first
-	 * time.
+	 * Publish this node's memory states, including any newly-normal zone.
+	 * Hotplug never adds highmem.
 	 */
-	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
-		node_set_state(nid, N_NORMAL_MEMORY);
+	node_set_memory_state(nid, false, zone_idx(zone) <= ZONE_NORMAL);
 
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
@@ -2146,7 +2143,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	 * list. Otherwise this node would still appear in the fallback lists.
 	 */
 	if (node_arg.nid >= 0)
-		node_clear_state(node, N_MEMORY);
+		node_clear_memory_state(node);
 	if (!populated_zone(zone)) {
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index a9d848c92678b..b4c4dba93652d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1763,21 +1763,21 @@ static void __init free_area_init_node(int nid)
 	lru_gen_init_pgdat(pgdat);
 }
 
-/* Any regular or high memory on that node? */
+/* Publish the memory states of a node that has present pages. */
 static void __init check_for_memory(pg_data_t *pgdat)
 {
 	enum zone_type zone_type;
+	bool high = false, normal = false;
 
 	for (zone_type = 0; zone_type <= ZONE_MOVABLE - 1; zone_type++) {
 		struct zone *zone = &pgdat->node_zones[zone_type];
 		if (populated_zone(zone)) {
-			if (IS_ENABLED(CONFIG_HIGHMEM))
-				node_set_state(pgdat->node_id, N_HIGH_MEMORY);
-			if (zone_type <= ZONE_NORMAL)
-				node_set_state(pgdat->node_id, N_NORMAL_MEMORY);
+			high = IS_ENABLED(CONFIG_HIGHMEM);
+			normal = zone_type <= ZONE_NORMAL;
 			break;
 		}
 	}
+	node_set_memory_state(pgdat->node_id, high, normal);
 }
 
 #if MAX_NUMNODES > 1
@@ -1924,10 +1924,8 @@ static void __init free_area_init(void)
 		 *memory-less node. The pgdat will get fully initialized by
 		 *hotadd_init_pgdat() when memory is hotplugged into this node.
 		 */
-		if (pgdat->node_present_pages) {
-			node_set_state(nid, N_MEMORY);
+		if (pgdat->node_present_pages)
 			check_for_memory(pgdat);
-		}
 	}
 
 	calc_nr_kernel_pages();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8532af052d74b..834d199ff8429 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -208,6 +208,21 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
+void __meminit node_set_memory_state(int nid, bool high, bool normal)
+{
+	node_set_state(nid, N_MEMORY);
+	if (high)
+		node_set_state(nid, N_HIGH_MEMORY);
+	if (normal)
+		node_set_state(nid, N_NORMAL_MEMORY);
+}
+
+void __meminit node_clear_memory_state(int nid)
+{
+	node_clear_state(nid, N_NORMAL_MEMORY);
+	node_clear_state(nid, N_MEMORY);
+}
+
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
-- 
2.53.1-Meta

