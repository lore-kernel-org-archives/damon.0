Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616199;
	b=a3bc2wweuwEyg5Vwzb5/aKhvz0C0pnrno5/GSOaoReUNU1F6LYEKr0mF4gZWEWvo0iy4
	 5+4daHZqQTKJlsfbNGJ1KQTj9sIBfU6x5bppie+KSwiM5AiY5s0EOamCd+cdk8QRcyJs9
	 2DRixcRufcNiNKafBqhhaZItZcyTUxAzoZEZGkWx2ldrFpsGPuBHuMbqwIgPAN8GFAi/i
	 hX9u4p1QrboB2YCER1efrZ4V+hnMiApBDJx/eTWuMUOxAuBtAa8DprXlIttBY987KBwW2
	 ndjycR4GAIGnCMY/jwf09ZNDhsIbTDPbFDsj6etw+vLUB+cDYP4+mAYnnpWxrW6SWEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nJgQdHN5NLYxxbOCpexwWsSr9IBzYZ+JufSPNjQMV9s=;
	b=ldPKsr2kN2p2gV6HBwtwiSLQNalpyadtazJv+LKcY1V3S8ZsE0KLsU9cSAPYVfAdHg+t
	 zGOMBrddeQ3Q/ZXJaR19oNbswLwAxPP05UNXJvprsj92vsXNMbQ4M+gFtlXG/rNlxpU05
	 MO19C9D0ghko0cFqJkWRCXGZwD8yesYm1cCluOUYrXjr81n0McsOS6kAheQlvGufyyIBF
	 Y5720Ic/F9D77AVu0p9xTBhvRgLnTrXHjwRdSSIIf1yS1X4N4fwCXIvscTwww+O+17657
	 KpykpvPgb3Ogn/NOYsvr1Bua63KFlR4zFYivpwjxNYh+zfMt5dWJSsKxsYq9JqNRJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfL6l9Lf;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46F606A331
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E46F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfL6l9Lf
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6798eb0d190so1264561d50.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616198; x=1795220998; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJgQdHN5NLYxxbOCpexwWsSr9IBzYZ+JufSPNjQMV9s=;
        b=GfL6l9Lf3Wrqde3kS70A2z/9zyLwzI7tu1AZNhlDTOv1eczBMxAt7zr2CMBEwRIcBF
         DKmmXtoce0S36jhHd78cIPEaOT3LD6gEQvUTxGx/3eJ+6ccz8tqPq3kIRkJtySyqP57Q
         ju57F+a2eavt0+dT5qff7GHnCXvFp6myAn1TGqG98jeZT3XEpIQP0zAf/8t/+pkSOMzB
         i/zxlIq+C8wRUK/WLjB2YJzoE9Js/p2An4UjJORUpn7t6NC6K2x16S3a0J4d+KciQc/h
         Ac/eppIzh6gIS2jHd+OVYEDGH0GMfrJ88MOcEY4RYabZtHhN2FYgFnu3F70RfiU5d1z8
         pypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616198; x=1795220998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nJgQdHN5NLYxxbOCpexwWsSr9IBzYZ+JufSPNjQMV9s=;
        b=zsEIJFRtt9Amdn8FOrw/XCS/Y44dSpmap8rCPn18Pny4fydxxH1pmScbnv0wqbf5zB
         V6fn/mwAsc3nRvudYTkp1kEASw3iLw/VGDEoJqWLENk1dfZaTsMefdEbmgz9MXtV14Nl
         S3C9X2B+1rIIR+gYZeDYX/RLtq8PltLNpWeiF5Md1Ewcrt5RhFJ4ye3/BAOPWvYO9ttn
         /b3Wlu83VTE8+5P7R3NNovXlVXMKz0hBVC3wZMUkIQxGxvZQ0zcp32/6TPccaWPHyqG6
         K5YTessrr8CZlUUJumhB/xs8me73pIjAw5JAWfluu+oSSAFN/kw6GGXYHVt9lPzFuKlz
         +yQg==
X-Forwarded-Encrypted: i=1; AL+hErH5wAmTXPNpPTV8W8MPbZU9HzSJS2S6B1i1BZmxvp5+OnZyTIIGqhTtVq01+FBsxbk/Nzr8nw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/iJ3xdUMJng5pRXrkoMtsIlgCDPYJ6hifvT4+XkSF+mUcub8BX
	CezubyQZg/0dSQ0VAMI9YNFBJdozpdGSZ0xA3CAc5GHO897QNqRctEzy
X-Gm-Gg: AYBFou3nlhi5usO1OTwcZWUuk9U/lMtSYOVifboswGf0ir7VFW0lDSo6rQU3Iy+vNF9
	Lx9umtj8OaW9oxbGK3rHw9LRU5FD3F6qImHYHNN7h2tWfVUElsfzgWaMBg+evRf1ZRAUTTiDFuQ
	JQERubVo9wjcsNOYyh9x8Adj1TlCHMUOB3FGedD+dnPRk9hk9FsQ1ZySi8xtNPQ0/lWODlfz8rt
	0aI2GtqMayFqA5WgQHCwTTApydaaN9vUofDG5xuXnmVTghMv1z3qUwSMKFTNsECQ7PpHa7wWYBq
	Dz0Vq1tSU6k04nJm7PsqMcOATQz1wSpTUYEOhB2GoL6Dz+a0EfVu0TM9hOGt2+U0j9vaMrCByOc
	6aYxZDjZIBLKU0JG+aN5xYskzEvIdAg7fonpBV24Pt+kmbUCYbSD4tskDQrMybJbsARsyU4uiqp
	rCHVxQhLIiFMGQTwe52z0B/zcC2Xmk0SnNKJf6JFVA5ZweAtePW4+MKWmv2nsvoJWLY0TrG8LSj
	aCBmx3hgMTkLi9Av67DJcggZirHgMyMIUWR5cca4bemwzC+qnjMjSxR7XGIcrqLDC2X8jssArT3
	6KpuDmF2jlMxZEHpuQywjO//VIPDfzYGtVEQbp18iPmIWAz4x9tapFvw7ZT/46MX82m1oRJjDaG
	+1dGWXQ==
X-Received: by 2002:a05:690e:144d:b0:67c:1fba:b42c with SMTP id 956f58d0204a3-67d896508efmr2961856d50.45.1794616197983;
        Fri, 13 Nov 2026 16:29:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a555cf0sm3448893d50.5.2026.11.13.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:29:57 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: yosry@kernel.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH v3 2/4] mm: memcg: read root lruvec stats from the node counters
Date: Fri, 13 Nov 2026 16:28:20 -0800
Message-ID: <20261114002822.1043378-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <20261114002822.1043378-1-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
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
 mm/memcontrol.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 091401cecf39..196c0382181b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -504,13 +504,67 @@ struct lruvec_stats {
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
 };
 
+/*
+ * Whether to read the node counter for @idx instead of @lruvec's rstat value.
+ * This is only done for the root memcg for stats where every update also
+ * updates a memcg's stats, so the root memcg's hierarchical value equals the
+ * node counter. The node counter is preferred since it is always up to date,
+ * and avoids an rstat flush which for the root memcg flushes every cgroup in
+ * the system.
+ */
+static bool lruvec_use_node_stat(const struct lruvec *lruvec,
+				 enum node_stat_item idx)
+{
+	if (!mem_cgroup_is_root(lruvec_memcg(lruvec)))
+		return false;
+
+	switch (idx) {
+	case NR_INACTIVE_ANON:
+	case NR_ACTIVE_ANON:
+	case NR_INACTIVE_FILE:
+	case NR_ACTIVE_FILE:
+	case NR_UNEVICTABLE:
+	case WORKINGSET_REFAULT_ANON:
+	case WORKINGSET_REFAULT_FILE:
+	case WORKINGSET_ACTIVATE_ANON:
+	case WORKINGSET_ACTIVATE_FILE:
+	case WORKINGSET_RESTORE_ANON:
+	case WORKINGSET_RESTORE_FILE:
+#ifdef CONFIG_NUMA_BALANCING
+	case PGPROMOTE_SUCCESS:
+#endif
+	case PGDEMOTE_KSWAPD:
+	case PGDEMOTE_DIRECT:
+	case PGDEMOTE_KHUGEPAGED:
+	case PGDEMOTE_PROACTIVE:
+	case PGSTEAL_KSWAPD:
+	case PGSTEAL_DIRECT:
+	case PGSTEAL_KHUGEPAGED:
+	case PGSTEAL_PROACTIVE:
+	case PGSTEAL_ANON:
+	case PGSTEAL_FILE:
+	case PGSCAN_KSWAPD:
+	case PGSCAN_DIRECT:
+	case PGSCAN_KHUGEPAGED:
+	case PGSCAN_PROACTIVE:
+	case PGSCAN_ANON:
+	case PGSCAN_FILE:
+	case PGROTATE_ANON:
+	case PGROTATE_FILE:
+	case PGREFILL:
+		return true;
+	default:
+		return false;
+	}
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
@@ -551,7 +605,7 @@ unsigned long lruvec_page_state_monotonic(const struct lruvec *lruvec,
 	const struct mem_cgroup_per_node *pn;
 	int i;
 
-	if (mem_cgroup_disabled())
+	if (mem_cgroup_disabled() || lruvec_use_node_stat(lruvec, idx))
 		return node_page_state_monotonic(lruvec_pgdat(lruvec), idx);
 
 	i = memcg_stats_index(idx);
-- 
2.52.1

