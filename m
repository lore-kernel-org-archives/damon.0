Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659863;
	b=jd+6eVh8/IV/607Nh4lLDrB8eGR6uZxNhl77TDWF3IzEl/NcuhPFiQjimDda0Cw8uglI
	 UeS87zyODSx15YZzRVq3OJYXhD4iJ1b0pK1SakndiEMA5maE4n87WVAdhLGsIZ9XC0n/P
	 Ng/Nl7Odg4c8zI6RubAf76UWRP5c35gBRuIZFgJe2d7sj0CwMvidB/0WJr4DR5qJBXW+W
	 a/3+qBxlwwUrARXq0u0BxUmw7RXTdrsLtNz+h4mVAw+9nKqCeqk/CNE7aJ3v2PrVFsauP
	 AIOhvrQNZMNs2yCCpBpkw+DmOIkXo24cVqFrxqWUJaXkmfe9ma3lGD5+yleHNVoENeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8k0YpciZy/RNGLWCkWb5Euha9kzjWaqxc+X4RS4poFk=;
	b=XT/cZdzT7Dr5MyYjFzQ5CTTIJHmtdaT6Y84rPUzCTiG7A87J0Q33bwoHegCeve6XRD/n
	 neBBLkLLA5PDX14U9J5Sf2DmnhKxQ0qj6S/H5RjJP8Ykor7MZKW+1bg0NARtyNZErSJ6D
	 44ZllLH8IbOmzjIM3VB5dhL6wNU0DtStDfoimexpPd3rFmaoZAy3jz8s2f2oU4pbRq8vB
	 QvFyU6FXQhN5sv5GvkwgzYcgFPgbrLXyvXSSOdnY4/lOhO/NOz8N3x2HiAGpkRFwm6WKX
	 KuZfd11UQ50FT99OTgaaRFQfW/Tn8LdXzBVUl0XahhP6ZyKYqU0YKtVAsIt6jOtUpKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JzPxDoh2;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E4606A327
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 22:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E71E4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JzPxDoh2
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b0f59a5fdeso29340467b3.1
        for <damon@lists.linux.dev>; Mon, 02 Nov 2026 14:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659862; x=1794264662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8k0YpciZy/RNGLWCkWb5Euha9kzjWaqxc+X4RS4poFk=;
        b=JzPxDoh2L/8FdwUpHzcNWYKLVAHuwI1POTAcKfJSEo1IwU9HjVfMMKbwbJ+DSsxPt1
         slmXdLI+3Ch2Rs3Czpl7LN0pRpmqOI4sSvT/dhJrOXHoEGS+4PjZAK2vE4ac8I/RYORq
         QcOJCZVy4sMA1FMv1tk4fiqXGPynGDHPK/XI1PBwKNH3z9n+oP6NKreFQ9GIG26e2HhF
         IhbsbCDMf5cyc69UcLG5UZGGsumJVF881vDfGIHIUXa4ZOzJN1wVaXWAvEpAxq78ooSZ
         aW9xijTb3ItC1r5R8wIMnXVR53PJE5xStoBOoqYKlG/GFyjhXJdKUx84gKlIwPwsvjaD
         iMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659862; x=1794264662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8k0YpciZy/RNGLWCkWb5Euha9kzjWaqxc+X4RS4poFk=;
        b=VHxAhMgMwIK3tKjokd8sDL4kv/AMsR/sGMLKF7hzXxZY8pP9Q2k2zOHZjdcikJtHfz
         Iennyf0X3bb+5dE/tysSgZ8n3J1+3uh2Ldc75NkTHMJgAQ3GuHSxQugmYdk1ryV3LzJy
         g1U6YgkMXHy2tbUAxHLgYmND9f8eryQjeRmW3PF+OoDjd0gDAe4fYLL7L6MqOw0kmiZG
         k0Y6LrgJJsm0tQzv/bQULefIpmKLnelUiSLe5zF5qEpWd0tPbjJ+cjiyuOBFoymGs0YY
         L6/1rjDBXUL5uSJIS4iZf4ODgG+gSWroHyOzauLI+T/WikRP5Tx6Yb1GbzhHc79AJQZK
         Qz2A==
X-Forwarded-Encrypted: i=1; AKwUvBzb6HokJqVF0FJ7E0ds76RByPUMm3PXdAz07na4MXCNOJq1lamCOP+2ouQfonRloEXdQda/gA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/3nfdjN3yQo38h1cbSE86MEGfqCmd+AurRJaCVS08PY2ifhOfZ
	dp+Zn7lK9OY00azPb4VKKS+KWXlxw7YMd3Mcm7jATSrgsJh22NNG9isP
X-Gm-Gg: AYBFou0kyDKTYgWNqBMgCy2ngwkkrsc84NYI/lCnEdk6girOjMfs9loftQpSyfUgSjd
	0zw2afPut8fP645LmHNDBf+C0Rc6rkKEGOLdjX5oEHIvZthCKU8/fPTx+D2HDT2PdmmzkPnBwzT
	mmmIAVRsIa8uVAgx6+p0JB9dbeB8TW1CioW3NtDY3Je/vxiI6cBzjRSfI1qxhtouCIrZ5Xg1Ac3
	zIqA556lUIP+NDsQXLnlwkYg1t/DgVToSrgzDtGUwCLTux+RA/BQ7TaBf2GBoPQYmQpzumQ7V7E
	eVAzrGBOiglzj6ujJUrs+BFIL9sus4m7S5QX4v5lanpPz1WZJBt0sRx/jjAXjD3EgwSdmn7x9f2
	5eMaqqEga/ZWlJ2Ih/Pmo2nRjIPCAMIkusvyTmfRGETikYcxClWkSOLKCCLm1hNhb7FfYwsDb1w
	MPODuIOccL0CjpLjLKRmIFoI1BKjt0rBvOHjP04Q7ucjcrpbAKqK2mq08EcH9LVUfV+E0Bxb5zC
	+ASN0H6p4Akzg6cGICK+t5l/+FmS5+kKGT1pR7eKLgpP2YX9DBHgk+9Pic3kVnxpF7UjCe9/nwp
	mrzwaK85lFzxMrHMtxuELK3MoBkPnhS6pvw5GDJ/KFi4pnhusXU21d+cPit6CbtLVsb6J2nvFar
	vUcAc
X-Received: by 2002:a05:690c:6d81:b0:8b0:8b34:edc2 with SMTP id 00721157ae682-8b2b66c629bmr83714117b3.19.1793659861879;
        Mon, 02 Nov 2026 14:51:01 -0800 (PST)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b71bce56sm60299087b3.44.2026.11.02.14.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:51:01 -0800 (PST)
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
Subject: [PATCH v1 2/3] mm: memcg: read root lruvec LRU stats from the node counters
Date: Mon,  2 Nov 2026 14:50:29 -0800
Message-ID: <20261102225030.2743129-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261102225030.2743129-1-joannelkoong@gmail.com>
References: <20261102225030.2743129-1-joannelkoong@gmail.com>
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

Reclaim and refault detection read LRU sizes and workingset counters
from the target lruvec after a ratelimited rstat flush. For global
reclaim and the root memcg, that flush covers every cgroup in the
system, and the ratelimiting can leave the stats stale for seconds.

For stats that only track memory charged to a memcg (LRU sizes,
workingset, rotation and reclaim writeback counts), the root memcg's
hierarchical value equals the node counter, which is always up to date.
Add lruvec_lru_page_state() and a monotonic variant that read the node
counters for the root memcg, and use them in reclaim and
workingset_test_recent(). Root reclaim and refault detection then see
current values instead of stats that can lag by seconds.

workingset_test_recent() only reads the eviction memcg's own lruvec, so
skip its rstat flush when that is the root memcg. For reclaim however,
we still need to keep the flush (for now) since global and root reclaim
also read the rstat stats of the child memcgs they scan, which the flush
is needed for in order to keep up to date.

On an 80-CPU machine, a root flush took 69us on average with little
cgroup activity and ~0.9ms with 128 memcgs actively allocating (wall
time, including waiting for the rstat lock). Reading a node counter
doesn't add any cost. It took the same amount of time as reading the
rstat counter (~150ns, which includes bpftrace probe overhead).

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/memcontrol.h | 16 ++++++++++++++
 mm/memcontrol.c            | 44 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                | 36 +++++++++++++++----------------
 mm/workingset.c            | 19 +++++++++-------
 4 files changed, 89 insertions(+), 26 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 980358bc6f49..656bd677dd3c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -968,6 +968,10 @@ unsigned long lruvec_page_state_monotonic(const struct lruvec *lruvec,
 					  enum node_stat_item idx);
 unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
 				      enum node_stat_item idx);
+unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
+				    enum node_stat_item idx);
+unsigned long lruvec_lru_page_state_monotonic(const struct lruvec *lruvec,
+					      enum node_stat_item idx);
 
 void mod_memcg_lruvec_state(struct lruvec *lruvec,
 			    enum node_stat_item idx, int val);
@@ -1430,6 +1434,18 @@ static inline unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
+						  enum node_stat_item idx)
+{
+	return node_page_state(lruvec_pgdat(lruvec), idx);
+}
+
+static inline unsigned long lruvec_lru_page_state_monotonic(const struct lruvec *lruvec,
+							    enum node_stat_item idx)
+{
+	return node_page_state_monotonic(lruvec_pgdat(lruvec), idx);
+}
+
 static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
 					  enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ac6c43ea8c5a..938843346571 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -587,6 +587,50 @@ unsigned long lruvec_page_state_local(const struct lruvec *lruvec,
 	return x;
 }
 
+static bool lruvec_is_root(const struct lruvec *lruvec)
+{
+	return !mem_cgroup_disabled() && mem_cgroup_is_root(lruvec_memcg(lruvec));
+}
+
+/**
+ * lruvec_lru_page_state - read an LRU stat of an lruvec
+ * @lruvec: the LRU vector to read from
+ * @idx: the node_stat_item to read
+ *
+ * Like lruvec_page_state(), but for the root memcg the node counter is read
+ * instead. For stats that only track memory charged to a memcg (LRU sizes,
+ * workingset, rotation and reclaim writeback counts), the root memcg's
+ * hierarchical value equals the node counter. The root memcg can just read the
+ * node counter directly instead of going through rstat, which requires
+ * flushing. Flushing the root memcg flushes every cgroup in the system.
+ *
+ * Use lruvec_page_state() for other stats (eg slab).
+ */
+unsigned long lruvec_lru_page_state(const struct lruvec *lruvec,
+				    enum node_stat_item idx)
+{
+	if (lruvec_is_root(lruvec))
+		return node_page_state(lruvec_pgdat(lruvec), idx);
+
+	return lruvec_page_state(lruvec, idx);
+}
+
+/**
+ * lruvec_lru_page_state_monotonic - lruvec_lru_page_state() for delta sampling
+ * @lruvec: the LRU vector to read from
+ * @idx: the node_stat_item to read
+ *
+ * See lruvec_page_state_monotonic() and lruvec_lru_page_state().
+ */
+unsigned long lruvec_lru_page_state_monotonic(const struct lruvec *lruvec,
+					      enum node_stat_item idx)
+{
+	if (lruvec_is_root(lruvec))
+		return node_page_state_monotonic(lruvec_pgdat(lruvec), idx);
+
+	return lruvec_page_state_monotonic(lruvec, idx);
+}
+
 static void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, int nid,
 				     enum node_stat_item idx, long val);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7ddef3b488b3..fc93a1d8afe0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2379,8 +2379,8 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
 	unsigned long inactive_ratio;
 	unsigned long gb;
 
-	inactive = lruvec_page_state(lruvec, NR_LRU_BASE + inactive_lru);
-	active = lruvec_page_state(lruvec, NR_LRU_BASE + active_lru);
+	inactive = lruvec_lru_page_state(lruvec, NR_LRU_BASE + inactive_lru);
+	active = lruvec_lru_page_state(lruvec, NR_LRU_BASE + active_lru);
 
 	gb = (inactive + active) >> (30 - PAGE_SHIFT);
 	if (gb)
@@ -2428,7 +2428,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * into a decaying average. This ensures currency, as workloads
 	 * change over time, and avoids overflow in the calculations.
 	 *
-	 * Use lruvec_page_state_monotonic() so unsigned subtraction
+	 * Use lruvec_lru_page_state_monotonic() so unsigned subtraction
 	 * yields the correct delta across a signed-long wraparound of
 	 * the underlying counter (a real hazard on 32-bit that the
 	 * clamp in lruvec_page_state() would otherwise turn into a huge
@@ -2440,13 +2440,13 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 		struct lru_cost *cost = &target_lruvec->cost[f];
 		unsigned long rotated, io, nr_rotated, nr_io;
 
-		rotated = lruvec_page_state_monotonic(target_lruvec,
-						      PGROTATE_ANON + f);
-		io = lruvec_page_state_monotonic(target_lruvec,
-						 WORKINGSET_RESTORE_BASE + f);
+		rotated = lruvec_lru_page_state_monotonic(target_lruvec,
+							  PGROTATE_ANON + f);
+		io = lruvec_lru_page_state_monotonic(target_lruvec,
+						     WORKINGSET_RESTORE_BASE + f);
 		if (f == WORKINGSET_ANON)
-			io += lruvec_page_state_monotonic(target_lruvec,
-							  NR_VMSCAN_WRITE);
+			io += lruvec_lru_page_state_monotonic(target_lruvec,
+							      NR_VMSCAN_WRITE);
 
 		nr_rotated = rotated - cost->last_rotated;
 		nr_io = io - cost->last_io;
@@ -2468,10 +2468,10 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	anon_cost = &target_lruvec->cost[WORKINGSET_ANON];
 	file_cost = &target_lruvec->cost[WORKINGSET_FILE];
 
-	lrusize = lruvec_page_state(target_lruvec, NR_INACTIVE_ANON) +
-		  lruvec_page_state(target_lruvec, NR_ACTIVE_ANON) +
-		  lruvec_page_state(target_lruvec, NR_INACTIVE_FILE) +
-		  lruvec_page_state(target_lruvec, NR_ACTIVE_FILE);
+	lrusize = lruvec_lru_page_state(target_lruvec, NR_INACTIVE_ANON) +
+		  lruvec_lru_page_state(target_lruvec, NR_ACTIVE_ANON) +
+		  lruvec_lru_page_state(target_lruvec, NR_INACTIVE_FILE) +
+		  lruvec_lru_page_state(target_lruvec, NR_ACTIVE_FILE);
 
 	while (anon_cost->count + file_cost->count > lrusize / 4) {
 		anon_cost->count /= 2;
@@ -2495,7 +2495,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 		 * workingset is being established. Deactivate to get
 		 * rid of any stale active pages quickly.
 		 */
-		refaults = lruvec_page_state(target_lruvec,
+		refaults = lruvec_lru_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_ANON);
 		if (refaults != target_lruvec->refaults[WORKINGSET_ANON] ||
 			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
@@ -2503,7 +2503,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 		else
 			sc->may_deactivate &= ~DEACTIVATE_ANON;
 
-		refaults = lruvec_page_state(target_lruvec,
+		refaults = lruvec_lru_page_state(target_lruvec,
 				WORKINGSET_ACTIVATE_FILE);
 		if (refaults != target_lruvec->refaults[WORKINGSET_FILE] ||
 		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
@@ -2518,7 +2518,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * thrashing, try to reclaim those first before touching
 	 * anonymous pages.
 	 */
-	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
+	file = lruvec_lru_page_state(target_lruvec, NR_INACTIVE_FILE);
 	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
 	    !sc->no_cache_trim_mode)
 		sc->cache_trim_mode = 1;
@@ -6701,9 +6701,9 @@ static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 		return;
 
 	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
-	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
+	refaults = lruvec_lru_page_state(target_lruvec, WORKINGSET_ACTIVATE_ANON);
 	target_lruvec->refaults[WORKINGSET_ANON] = refaults;
-	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
+	refaults = lruvec_lru_page_state(target_lruvec, WORKINGSET_ACTIVATE_FILE);
 	target_lruvec->refaults[WORKINGSET_FILE] = refaults;
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 1504f91cdca5..e8620ae1c516 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -483,10 +483,13 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	 * section (for e.g, in cachestat) - these callers need to skip flushing
 	 * stats (via the flush argument).
 	 *
+	 * For the root memcg, the LRU sizes are read directly from the node
+	 * counters (see lruvec_lru_page_state()).
+	 *
 	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
 	 * still needed here?
 	 */
-	if (flush)
+	if (flush && !mem_cgroup_is_root(eviction_memcg))
 		mem_cgroup_flush_stats_ratelimited(eviction_memcg);
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
@@ -518,17 +521,17 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset,
 	 * workingset competition needs to consider anon or not depends
 	 * on having free swap space.
 	 */
-	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	workingset_size = lruvec_lru_page_state(eviction_lruvec, NR_ACTIVE_FILE);
 	if (!file) {
-		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_FILE);
+		workingset_size += lruvec_lru_page_state(eviction_lruvec,
+							 NR_INACTIVE_FILE);
 	}
 	if (mem_cgroup_get_nr_swap_pages(eviction_memcg) > 0) {
-		workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_ACTIVE_ANON);
+		workingset_size += lruvec_lru_page_state(eviction_lruvec,
+							 NR_ACTIVE_ANON);
 		if (file) {
-			workingset_size += lruvec_page_state(eviction_lruvec,
-						     NR_INACTIVE_ANON);
+			workingset_size += lruvec_lru_page_state(eviction_lruvec,
+								 NR_INACTIVE_ANON);
 		}
 	}
 
-- 
2.52.0

