Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640242;
	b=WbTqmWXS8MPej+cIGY1U5xoNR9DD85NRE4HgMXXZbJ5/fcK9YOzOwVBU3bZTxbGutoqm
	 F8DeSbFrH+nEspoPVZNJajU8XdHUV2jN6oh49S/QYMhb9qslp7RJr5F2o0MKCKaO1RTkE
	 FUOMlSyr6JF81uXUDxkMiKlo9JZh8me7YIfe+e/n78KpAqu2Vk0Fq/Xdi/j2tkDwiboSm
	 7OBnBSSNXooI6ck8ALl/shhFE6xtK5WglnYTWRbpWksQWwM9Dfq406Df2LiK4OGpVh6GE
	 44CSwKMfUP78OGr0TkiNDxrxf/rrQUa0pR6XqnZmRwduRJM5KuCUcg8oK44AdQMJnrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
	b=E8mz7vlhtn1ZKPirSiA0xOYnWM+jL2WTZqtvLje7TxLMU+xiRiV01r7teOSVZI2cxABm
	 ijMzO2UdZeZJqHdgBll5DxGZH8RPrr4aSLRda7boRvmAl5GG0bCcqz79eaEBlSSBiQ0WZ
	 cHmJfVYGmAoQkDX1tZPkn0x+D5oABleQ8lazYoMffvRW8jemingMgMdMjU30CgUZ+hTD/
	 tbruKptcKOrTth+eekeOmQ9FvVI1J/QN71uD6AEzjIkOaM+eR+E6FtqiW1TBYqtYqeHk+
	 LC2s8KYmvLsDpH+4YmkDSfdrr0Ei+mB8MLgUGgC88TNmyxkjTmK1zbIN5/jQGCn5IAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=U9RDYU3x;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089B60A5BE3
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F089B60A5BE3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=U9RDYU3x
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ea0c05c92so32027476d6.0
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640241; x=1795245041; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=U9RDYU3xcVUWOssMt974oUfW9TgUuKGjVVOgWd4RHxCPQU81oo32gYF/K/o2t1ZUM/
         Huko/T6TilHIzLmpk6tyUMsyG+7fgcyImxMmL21MYPGCVDfdx/+QdvtcqfxXNU6Ol1un
         9A3RjWAtS2bR04FH1/JskV1IN4j57e8CcT4BS22nmg8Y0GK+d/EPI/QZjKVKVTGYWFRt
         BxgjilfB8Sq/OXWpSrFHCrd8Rx9lyQU7idZnnv3A4o9WMXGfycPEu7tHAvDGNwo9OgD+
         k0mgXY2WR6cogDdwCxpN5zLmY+QdhsYxyq1VFVzdm3EOwzOT0BB37FLDOYNEf7tpAfAs
         j0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640241; x=1795245041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fkzw1dSkiJcsilY2Mokhk9gjBcrzBYNOsKL3JfHFbP4=;
        b=MNSqfosBdKHvW08qCZGULdIgavjM015XU51jshfvZNIiegupfMrFCsu3ql0S/d7oEe
         cY4/d7Y3WdDTKAFEoZ57+USMP0cq1mOW2Fpijzu5XSBu8ddvJHwikLcID5rQN5UzipFw
         c5KdnhKaOM5tl5giu/4u866eXLXIbfqaFTlflsVlQ7GWe4TA63SoaWygZJPzaiMpzl5V
         lB9Cm2BTqCbK3Fgu7fc2j6yjYVryWU/3AxtnaT8UJMXqUfmBtBJPQqtLQDMbVtanH22f
         /wwCAHaxyo/b6GCnjBbfNtmuC/MU5xfJ1IIRJEedz/j/ymhhR+beo7JKD5A7dyeG66mG
         zr2w==
X-Forwarded-Encrypted: i=1; AL+hErFC+kB/S2PYlwGudKDi+2sInhCInmBxMI09qK4Q0lqngLzBAHTCwUDtw8C5Wo3QViAdIwsHUQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/yiu2pIWeibw/KR5qCzaKg1qvVNfkIvSL+zAkh6cGn0ywzGbhh
	4xyfifptj1VB3ePUtqZVN2fs9gUFnVn5D9B6CpRHIw3RZ76lnQygu6oKDFW6rIt6ukM=
X-Gm-Gg: AYBFou37tlfTzUWx5a4bgSoXq3MsdySYgqVJOcd6Hq37b5b/1sO5QCvjPfHJiI82M9+
	Mndy1gNWq2ML61rFnLGz28auNWvX+xLJH95zB2D/R6iuDF9Zdsya9tC3oSOI4RJR0as+rnS0u/m
	55bYCtXi5bkf7o5VyDLTGMmUgpuEHQG+4WyIqbh4Q2ZJO5swPxCwL4W4IkHTN2TmgPf5efUBDZm
	fzotFhxkv1hsrLVFP1UDxg5h8uJ/VucjCXwc207KLEg/QFDzrvm9LM2/l3UZFrUBGL+I9wZq1Xr
	wdhz15ITq/cW+laywjdLqWRj2dylmmXqdCLdieAxtBF3e5PezvVyjBidZd/rRXkuwKq0T4wFuK6
	Q+33DxnRr10rGSdTHglORQPbRlbwJiHNMnVlqIxixpNdxqrxJnkWegpVB5jY7+cFretsRXjhVb9
	XpblRvzf2BweLXFlDZUdXZtA6imwxK4IpKn1psj8mYCeSeEQbKrzr755t2KQ2wcNxOCuzIqctQO
	EaT/H1ueq12fpZritdfvrANZon4yaOP9rpQ9+uirfd/SbcRF0lo391u9B4s2usZE7aHBtTFXUsw
	Z/XWACCQ8DErTsb/E/LFKccgMRubrgHmtyXZlZr0K8+CCPzTdgIm7YysFkUJqt125OLRY4A8BSF
	EjLxv0hwHPd1E8jI=
X-Received: by 2002:a05:6214:c2b:b0:91c:9086:ee07 with SMTP id 6a1803df08f44-91f2420df31mr81654406d6.38.1794640240818;
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:40 -0800 (PST)
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
Subject: [PATCH 17/22] mm/vmscan: restrict reclaim to common memory
Date: Sat, 14 Nov 2026 02:09:54 -0500
Message-ID: <20261114070959.3490008-18-gourry@gourry.net>
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

Reclaim serves the ordinary allocation domain.

Restrict it to N_MEMORY_COMMON:
  - start kswapd only on common nodes, at boot or hotplug.
  - walk only common zones in direct reclaim and when throttling it,
    so no reclaimer waits on a node that has no kswapd.
  - walk common nodes when MGLRU registers an mm and when its debugfs
    interface iterates or validates nodes, using first_node_state()
    and next_node_state() in place of first_memory_node and
    next_memory_node.

The fallback zonelists hold only common memory, and all memory is common
at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/memory_hotplug.c |  3 ++-
 mm/vmscan.c         | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 29ff2c46499b3..410a29732bae7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1207,7 +1207,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
 
-	kswapd_run(nid);
+	if (node_state(nid, N_MEMORY_COMMON))
+		kswapd_run(nid);
 	kcompactd_run(nid);
 
 	if (node_arg.nid >= 0)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 061fbd168d982..bb7b1c50bfb78 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2932,7 +2932,7 @@ void lru_gen_add_mm(struct mm_struct *mm)
 #endif
 	spin_lock(&mm_list->lock);
 
-	for_each_node_state(nid, N_MEMORY) {
+	for_each_node_state(nid, N_MEMORY_COMMON) {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
@@ -5562,7 +5562,7 @@ static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
 	do {
 		int nid;
 
-		for_each_node_state(nid, N_MEMORY) {
+		for_each_node_state(nid, N_MEMORY_COMMON) {
 			if (!nr_to_skip--)
 				return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		}
@@ -5587,13 +5587,13 @@ static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
 
 	++*pos;
 
-	nid = next_memory_node(nid);
+	nid = next_node_state(nid, N_MEMORY_COMMON);
 	if (nid == MAX_NUMNODES) {
 		memcg = mem_cgroup_iter(NULL, memcg, NULL);
 		if (!memcg)
 			return NULL;
 
-		nid = first_memory_node;
+		nid = first_node_state(N_MEMORY_COMMON);
 	}
 
 	return mem_cgroup_lruvec(memcg, NODE_DATA(nid));
@@ -5665,7 +5665,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	if (nid == first_memory_node) {
+	if (nid == first_node_state(N_MEMORY_COMMON)) {
 		const char *path = memcg ? m->private : "";
 
 #ifdef CONFIG_MEMCG
@@ -5765,7 +5765,7 @@ static int run_cmd(char cmd, u64 memcg_id, int nid, unsigned long seq,
 	int err = -EINVAL;
 	struct mem_cgroup *memcg = NULL;
 
-	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY_COMMON))
 		return -EINVAL;
 
 	if (!mem_cgroup_disabled()) {
@@ -6492,8 +6492,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		sc->reclaim_idx = gfp_zone(sc->gfp_mask);
 	}
 
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					sc->reclaim_idx, sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		/*
 		 * Take care memory controller reclaiming has small influence
 		 * to global LRU.
@@ -6604,8 +6604,8 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 	} while (--sc->priority >= 0);
 
 	last_pgdat = NULL;
-	for_each_zone_zonelist_nodemask(zone, z, zonelist, sc->reclaim_idx,
-					sc->nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, sc->reclaim_idx,
+				 sc->nodemask, N_MEMORY_COMMON) {
 		if (zone->zone_pgdat == last_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
@@ -6756,8 +6756,8 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 	 * for remote pfmemalloc reserves and processes on different nodes
 	 * should make reasonable progress.
 	 */
-	for_each_zone_zonelist_nodemask(zone, z, zonelist,
-					gfp_zone(gfp_mask), nodemask) {
+	for_each_zone_node_state(zone, z, zonelist, gfp_zone(gfp_mask),
+				 nodemask, N_MEMORY_COMMON) {
 		if (zone_idx(zone) > ZONE_NORMAL)
 			continue;
 
@@ -7736,7 +7736,7 @@ static int __init kswapd_init(void)
 {
 	int nid;
 
-	for_each_node_state(nid, N_MEMORY)
+	for_each_node_state(nid, N_MEMORY_COMMON)
  		kswapd_run(nid);
 	register_sysctl_init("vm", vmscan_sysctl_table);
 	return 0;
-- 
2.53.1-Meta

