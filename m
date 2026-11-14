Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640244;
	b=Nksdg/g75lLFsm8h54TM+VmPg/vs2txcDgSXvC/t5OGaYBVzZQmJcrSQHLNP0z+nVZmD
	 hOnDa+rlo6IfFGEUIpQlVlz4Ou3sygplvYPXfVjW96EcWU3EhYSobP+E1LPpDubE/21G0
	 15ZrQRc2q3uFs7SVpBhTUTCpgNGASp7wxq0lxLGKMRAOlFv+cAPY0neXfS9tpl+2jg79M
	 XH0hkMou4y7UiQcWzglsLuVzpdIwiRIThcmOZQfgnb29Ga5V9vRiZe9MvL8qvLWXOQFic
	 eNQBcjNxUtecRkUzZxSy7zl1EiVAAxNKJRocl2eA8b0Fvice6+j+TRB/lto8riXf6Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QgwyyRUkaLESkoMsTNOOlPxwzMonfztNgfKNstfbYo8=;
	b=xYtiEZo9K5C7N7g18DV8TTEOmX6Mj7VXTWNvTpDEXa6ffUROdpUwqiqK4aVlAQbyr9qc
	 agsMwMSpA059cg1q4oN63M/LqtPk4yg6XwvBf+nvYa/bBsKPjoGqdzBTNNRNbNCnqj8oI
	 sDDDzuNthdXtoTLpzkwXkntCcgwFlc1JAAkzr7v6XwJbRD8Tna4n8C+MHR4ozbUQtIQir
	 mFQkdr9L+lZeltwZzSo4s5nn4y9fo3OB9pCG8ci6AnWBVf6h/nkANf6c4Zai/asfxP89p
	 hPkVhxpxMuwO99Mk2CfKLWhKvWssDOfdYivIGhgsPr+dBpREBfISJ+bCtKtdFz1WIpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gSe0itWm;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4F606C0E3
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F4F606C0E3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=gSe0itWm
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ef011e338so29794056d6.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640243; x=1795245043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgwyyRUkaLESkoMsTNOOlPxwzMonfztNgfKNstfbYo8=;
        b=gSe0itWmu/LljWYBbYMFUr6nR9G5DmXBDrZKM0A/QdzraFhebTIqSCkrz9fFkG1xDS
         K+5ykrf+FrXjVgkLC3INgxKr1HJioBJB/DCqQnWEq6xaWjB7sWToQogksoblgF23sm6N
         WzxeVAh3y5rMJehgUUh6FIXQju27nxPrCez7MUngWCEnr/DdJ52sL8KLYHokHIAz16IO
         TAYI6pGM9SpPfU/hBReGrVV1gOP2VKiSpo1/5BYD4zp/enArS1I2m7rHAdtMD8WU82wy
         QtlBg7OXNv23B/r4KmYAdzaZ2+rWyG5gSGSn+bScQUiZ9rzcS6883+K3/cyDzTEXtoCW
         XH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640243; x=1795245043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QgwyyRUkaLESkoMsTNOOlPxwzMonfztNgfKNstfbYo8=;
        b=P+gHOccat+M7r5OhVb1eekT2gf4UD0HUgA7cO66O9kcba3Ict9fSM1MxGjuC0neeCn
         YqOs10PLiazIrPsK85wEa5X3TV5a7ISqAn3uj8p3d1s0htxX3ROU1e0lz+sslsiAPyuN
         GNc6/itSO7KrVHnktiqXHVSUiU5KABGaTAaMJh1kAingdytvNppf3qG9+GaeAiFJMQ+5
         WFiW13bKHlK8R/tVm8pxP5kQ6jRPP4gyEqmPiHsIQqR1VJVgCYsCWfCvjnJEfcyBV6Ur
         6+saqRFdmXZLy7s6Fu2D2hyPaqbJlDVcT1wa8Wqltequ3ouGjpPYk7SDuONHWFym5zgk
         VYFQ==
X-Forwarded-Encrypted: i=1; AL+hErFEhHLoONJgx9W96/GIRtyKIjmqci7PagbKTW3jU15hU3OOk8uKeWhN86wdJWTFrn769bV8yQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9wZwzmbfM19h4XrjG9JLZN5iU8FBZlTa4J+LSjajhLOU388zly
	wUGA/s2ctYj3QBhbcI8ozL0kTeLs1jDhFkyrNNAKZKKhDVafZf3Yd8ZHB0Jt6kvP/DA=
X-Gm-Gg: AYBFou00SSzuFGp6z1unLTNQQKOiNhQZvuhaWhUVX2zCCdLfYQjXpU7fs2AP3cTKQeo
	eLu0u4litZ9qeJBQooWilVOk6N05+H7rA/gdhfhcH+X/W2sNlrL4efmSedg5xtwPRyXuf5e8Jct
	ZmztXb0fCHlvk/ge1LkXzF/LV4+0wrx8JPYUD5SVJI1z00jYfDGDWpE6d8Hts8Ignjlye3ol9zV
	D75USUQMugFQl4YG13YDJR+dRXhqwS1vL93JSXI4vVMKbYvtkVRiFx9dB5levr0HILWMM9ZRWWR
	hjquSqmTJulXojTifSRDzzwoLFUaVv7zU2Q+bKqpsWYBaV+TrM6yHcbiSEcWJ4e2gDmDInKpPhV
	Cr7eHeVQ4z3Tr45wrNWNscvVHhc+dQ+h9e3510d9k5CVCDludTM4wC3DPc+/50lB+YJwwsh5W8m
	XkIS/FRE4/a93tVf8k5Vl8BFEeMUFwMHxW+zCewzklriSC1cAjDsQeA4AU6F2GVCgIFmUFqwwvZ
	VKmGIANzK3uzkaCKkie4LaKQQxlx+u9FWcRRaDkPiXoPKyYDJNJ/LaCY08b7kjf9af+PjxEffk2
	/8VhKh/PRY5G41oXIypA5jdN2EEj7fqWNLt/fMZKA9lXZvdzI923dsxGWaxuee6njnG0NZhxzdV
	gDzRIVUEWAQO3PX4=
X-Received: by 2002:a05:6214:8503:20b0:91f:1498:4e2b with SMTP id 6a1803df08f44-91f24194a18mr55953066d6.9.1794640242842;
        Fri, 13 Nov 2026 23:10:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:42 -0800 (PST)
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
Subject: [PATCH 18/22] mm/compaction: restrict compaction to common memory
Date: Sat, 14 Nov 2026 02:09:55 -0500
Message-ID: <20261114070959.3490008-19-gourry@gourry.net>
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

Compaction serves the ordinary allocation domain.

Restrict it to N_MEMORY_COMMON:
  - start kcompactd only on common nodes, at boot and hotplug.
  - walk only common zones in direct compaction and when deciding
    whether more reclaim could let compaction succeed.
  - compact only common nodes for /proc/sys/vm/compact_memory,
    and trigger proactive compaction only on common nodes.

The fallback zonelists hold only common memory, and all memory is common
at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/compaction.c     | 14 +++++++-------
 mm/memory_hotplug.c |  3 ++-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 426563acf7acf..6a40e1a9ba78c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2496,8 +2496,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	 * Make sure at least one zone would pass __compaction_suitable if we continue
 	 * retrying the reclaim.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-				ac->highest_zoneidx, ac->nodemask) {
+	for_each_zone_node_state(zone, z, ac->zonelist, ac->highest_zoneidx,
+				 ac->nodemask, N_MEMORY_COMMON) {
 		unsigned long available;
 
 		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
@@ -2855,8 +2855,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 	trace_mm_compaction_try_to_compact_pages(order, gfp_mask, prio);
 
 	/* Compact each zone in the list */
-	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
-					ac->highest_zoneidx, ac->nodemask) {
+	for_each_zone_node_state(zone, z, ac->zonelist, ac->highest_zoneidx,
+				 ac->nodemask, N_MEMORY_COMMON) {
 		enum compact_result status;
 
 		if (cpusets_enabled() &&
@@ -2973,7 +2973,7 @@ static int compact_nodes(void)
 	/* Flush pending updates to the LRU lists */
 	lru_add_drain_all();
 
-	for_each_online_node(nid) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		ret = compact_node(NODE_DATA(nid), false);
 		if (ret)
 			return ret;
@@ -2992,7 +2992,7 @@ static int compaction_proactiveness_sysctl_handler(const struct ctl_table *table
 		return rc;
 
 	if (write && sysctl_compaction_proactiveness) {
-		for_each_online_node(nid) {
+		for_each_node_state(nid, N_MEMORY_COMMON) {
 			pg_data_t *pgdat = NODE_DATA(nid);
 
 			if (pgdat->proactive_compact_trigger)
@@ -3366,7 +3366,7 @@ static int __init kcompactd_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY_COMMON)
 		kcompactd_run(nid);
 	register_sysctl_init("vm", vm_compaction);
 	return 0;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 410a29732bae7..c8ff60e6417ba 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1209,7 +1209,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 
 	if (node_state(nid, N_MEMORY_COMMON))
 		kswapd_run(nid);
-	kcompactd_run(nid);
+	if (node_state(nid, N_MEMORY_COMMON))
+		kcompactd_run(nid);
 
 	if (node_arg.nid >= 0)
 		/* First memory added successfully. Notify consumers. */
-- 
2.53.1-Meta

