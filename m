Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275635;
	b=LBwPAiANIXGLdnOyq/DvRo0avm+HuGDHdkuYHGbxfvG6s6ShKRRui8DlXMxqJ8kf4IeY
	 LPmCM0w6r5cGNqNv85CRug0YDdrK2T/OdhkSX7pDn42X2FYkVj4GjPxCRhkFUujlwH2Zr
	 f5HCDFZpU8WUaseB+t6osDMq61PVuYg9AyFK30/CARHMUP80Qp6jIaXcRgMn/i77mBjpN
	 6HvAT8XC9L1si6VcsOBw6XbN4Is6qczVnVbbeA/IIdGQXrkkq78tbON8dH/hMQAeS0i0N
	 A972qCtEL3VADWIAKyZwJkTfmgDbgPeDTUwflUu2n6NTSkY6aKG8sBJXga0AOJWyB6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fUH2iaJE8DQ9XreGrrxcpLj5+gSWzYR66IHD/grDUA0=;
	b=qyJlRwncnnK/KRHMbfI2NluziAYrmwa1LD8NsARb2HHvVy8fgYZPI6yiV+snzJAAWFwI
	 dhSuFzirFxn9XyQ+PH/0jMDfS2LRdsBm5MARAAcw2JJfsJWmxRSsF6zOpADXocS2jElWk
	 LI/rU2wT/Z2QuR/25OWvKYQgHfeoKyUUS0A4M2ZD8NgpOoygIQseh1D0zZnfvVnyUi0zX
	 V11VUegYZeThU0cagzsnR8BGb2JDJz/QqHfyvIY7oxlNmN+8/geqcbxLBRW6nHKIMYQbB
	 Eq4pFFV3Tfvj4IOFjO4YAyB1dPQ7drHA3T6qJFukQwmERiTtfzqfsqzqBKQ7eMkMMoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vw0joxk0;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2A606A321
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76C2A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vw0joxk0
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so993399a91.0
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 17:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275635; x=1794880435; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUH2iaJE8DQ9XreGrrxcpLj5+gSWzYR66IHD/grDUA0=;
        b=vw0joxk0M6fukafYvOZ6/fKoNpRyL9+GFlPDOEHBVecrCCFb4CcdvuNHj6VaVNUJL2
         PdZLKOa5vQ6OamQpCW67ouCqmH38CZQZgKmVB3/v9zqfBhJuhPNiwZ3AsC47iZG40FJR
         buA5F1QjFI56ghQ+U9OqJ24uFAg88lHG/7MDtFY2b1XKdJR51qB/b7cctLkXetnjw7E/
         rRP8VUW/yLjYbi/Esszt+6+NLMm+Olj73H1LpTId6CMU+DO2Vnj4sSaFCka43TpaoFyu
         dPrApGE0OWX3kwA8kdeJ4kB2iYZ7IUjugCzrTvHjGfOVrBnQikukll/zpy1JbUJWx5Ui
         2KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275635; x=1794880435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUH2iaJE8DQ9XreGrrxcpLj5+gSWzYR66IHD/grDUA0=;
        b=mjNVq/e9TVsUgvvANh2ETb/mZq2Vf59nvJ/BtqtgaIpA1mXI7ARJqTii8dhPRJh9Xy
         kEX3zTe2mkKgaoXxAM5hcJToujdt4SucCTUANZgGYdlY+vRaW322fSoJuN5Koe6t8ibO
         ZUOSMTw5AYiEOZTFUjxeXcm/Mbqurh+q5FMN4Sq1RsqsiqeJvZzTpuM+nXxmHR3FSZef
         JgEURwhB5+bjOPOXpL+FpIx17KRVlaWwA5vRN4tjet4TNlW5bol2KpU1mTzGvRQ0aUDS
         ZB0qFY8QIOTotO7yOjlK33IFYMkyTpXf73Zt1m3IZjAQcmx5YvDLgKMV69zJQtjADLfs
         0DLA==
X-Forwarded-Encrypted: i=1; AL+hErErp9lkmWH6WAquXXQQ6qOswxRRvn3ukyoSN7oNiz+7foH7BkJ4zZ56DZOJoLqhVvQQPFlpUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Z2iyTQmwaPjTQlIwhPuH7EtfdEnmP+drOOXTSWr44/xKw5+Fj
	xZzb6K22oxGH9IA1jx7wclFQaJuKs0PhUXJmlgVIMSJ8eC66bzdLmw1d
X-Gm-Gg: AYBFou1BpLOmEGTJzMdECN3XomCs24UZf4+LABRI+HbbEt9Vjjhl7qm0etAGyjyRFm0
	7z1li6jOzxhyAY1JYzVZNwiILwII6G2dGHBjqZIBtOB5JQYmyITAd0oq+zoMVwbe8z0jPEJaFg4
	lHgGOvtdYa4Llm9YIYsiQ/SeL3tPR38AkTf2jtRsYccN9HALLpOOKPrirut7sI5B6UdxMrpvvsY
	h8yx2UZv+23ywy7KvHkDrqrlDWJcT6N9uP14M3cKEN3hFf3Gdj71pVhsjn7wYDUDoFXO4iZ4+so
	WtsX++BULN3qPqvDsBygpb8ocIzi3Jck7MkakvwT1DvAM2y/FY8RiO1HXyVG+VykjyfmfIbCW4K
	heXF8sgxmvWmB2qA/Sx8sVmLlgd8SlMQKSyvtb+CvpoqI7/JnKARB+vS4mPKC07Yghh6Az0SuIb
	0qzmoaOlTmQu/uMqY2CKzYgQR4If8LFPUZFBLTlHy2qf1jyzmz+2xGH4fO4HBtbTOuHDgaJlYcf
	7AN6qqx7d8Z/CGlFdI/PKihexVTxB8YuRzWkqL73WoEljq25ibqFVGAHgV585Hb7PzYWvLxJgIg
	jLO7d2+gK5TjFBTcNgLMSyJC0HI2gURTGU2XGgv7dxeO1Y3sS2UY42POd3lpO8sy/DPv+5NReTy
	RJWHiHQ==
X-Received: by 2002:a17:90b:1c09:b0:3b0:9a2e:b491 with SMTP id 98e67ed59e1d1-3b166d31311mr1425834a91.66.1794275634865;
        Mon, 09 Nov 2026 17:53:54 -0800 (PST)
Received: from localhost ([2a03:2880:ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1678d1c0csm1631708a91.6.2026.11.09.17.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:53:53 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: yosry@kernel.org,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH v2 2/4] mm: memcg: read root lruvec stats from the node counters
Date: Mon,  9 Nov 2026 17:53:19 -0800
Message-ID: <20261110015321.611093-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261110015321.611093-1-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
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

For the root memcg, lruvec_page_state() returns the rstat value, which
needs a flush to be up to date. Flushing the root memcg is expensive, as
it flushes every memcg in the system.

Most memcg node stats only track memory charged to a memcg, so the root
memcg's hierarchical value equals the node counter, which is always up
to date and doesn't need a flush. For those stats, have
lruvec_page_state() and lruvec_page_state_monotonic() read the node
counter for the root memcg, as they already do when memcg is disabled.
Callers that only read the root memcg's own lruvec then no longer need
to flush it, which the following patches take advantage of. It also
makes the root memcg's stats more accurate, as callers that ratelimit
the flush can otherwise read values that are seconds old.

The exceptions are the kernel memory stats (slab, kernel stack, page
tables, secondary page tables and vmalloc), hugetlb, and
WORKINGSET_NODERECLAIM, which counts reclaimed xarray nodes (slab
objects). Their node counters also count memory that isn't charged to a
memcg, which falls into two categories:

a) the allocation isn't accounted to any memcg (eg kernel page tables,
   or hugetlb when hugetlb accounting is off)
b) the allocation is accounted, but it comes from a task running in the
   root cgroup, and the root memcg isn't charged for it

As such, these stats still need to read the rstat value, since the node
counter value can be higher than the rstat value.

One user-visible change is that the root memcg's memory.numa_stat (and
the hierarchical_* entries of the cgroup v1 memory.numa_stat) now
reports the node counters for the non-excluded stats, as it reads
lruvec_page_state(). This is more accurate, but as a result, it may not
exactly match the root memcg's memory.stat, which still reads the rstat
values.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ebc9330aeae..2575bf2ba0ea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -389,7 +389,14 @@ ino_t page_cgroup_ino(const struct page *page)
 }
 EXPORT_SYMBOL_GPL(page_cgroup_ino);
 
-/* Subset of node_stat_item for memcg stats */
+/*
+ * Subset of node_stat_item for memcg stats.
+ *
+ * Stats whose node counters can also count memory that isn't charged to a memcg
+ * must be listed in node_stat_includes_unaccounted(). Otherwise,
+ * lruvec_page_state() returns the node counter for them for the root memcg,
+ * which can be larger than the root memcg's actual value.
+ */
 static const unsigned int memcg_node_stat_items[] = {
 	NR_INACTIVE_ANON,
 	NR_ACTIVE_ANON,
@@ -504,13 +511,52 @@ struct lruvec_stats {
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
 };
 
+/*
+ * Whether the node counter for @idx can also count memory that isn't charged
+ * to a memcg (eg kernel memory that isn't accounted). For these stats, the
+ * node counter can be larger than the root memcg's value, so the root memcg
+ * has to read its rstat value instead.
+ */
+static bool node_stat_includes_unaccounted(enum node_stat_item idx)
+{
+	switch (idx) {
+	case NR_SLAB_RECLAIMABLE_B:
+	case NR_SLAB_UNRECLAIMABLE_B:
+	case WORKINGSET_NODERECLAIM:
+	case NR_VMALLOC:
+	case NR_KERNEL_STACK_KB:
+	case NR_PAGETABLE:
+	case NR_SECONDARY_PAGETABLE:
+#ifdef CONFIG_HUGETLB_PAGE
+	case NR_HUGETLB:
+#endif
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Whether @lruvec should read the node counter for @idx instead of its rstat
+ * value. For the root memcg, stats that only count memory charged to a memcg
+ * have the same hierarchical value as the node counter. The node counter is
+ * preferred since it is always up to date, whereas the rstat value needs a
+ * flush, which for the root memcg flushes every cgroup in the system.
+ */
+static bool lruvec_use_node_stat(const struct lruvec *lruvec,
+				 enum node_stat_item idx)
+{
+	return mem_cgroup_is_root(lruvec_memcg(lruvec)) &&
+	       !node_stat_includes_unaccounted(idx);
+}
+
 unsigned long lruvec_page_state(const struct lruvec *lruvec, enum node_stat_item idx)
 {
 	const struct mem_cgroup_per_node *pn;
 	long x;
 	int i;
 
-	if (mem_cgroup_disabled())
+	if (mem_cgroup_disabled() || lruvec_use_node_stat(lruvec, idx))
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
@@ -551,7 +597,7 @@ unsigned long lruvec_page_state_monotonic(const struct lruvec *lruvec,
 	const struct mem_cgroup_per_node *pn;
 	int i;
 
-	if (mem_cgroup_disabled())
+	if (mem_cgroup_disabled() || lruvec_use_node_stat(lruvec, idx))
 		return node_page_state_monotonic(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-- 
2.52.0

