Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1380259CBD
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750213; cv=none; b=mexH28ChnXzdt5vokZZ18IJ1OMwP0g6SMWZGwEalG9TNEOT35DMh8ypJ6kFI735XAql8Yvvn4gUAQ0rU/DsS13cEmjAO/gcVnjYSN9knEulaGW/xA05edtnwIyPCS1AMbVpjlP4yZCIbwT6QkOCcQ6PphFR16QAecbW8i5clwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750213; c=relaxed/simple;
	bh=FN4ZcFBXmxL8uNXxIrtPiA8q89iYFsEg9AGsn3itCkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pu3aljgtXPdoPRgCiJVneDf4quFBBmP84JQw9j0lnfDqj5QQfF8B/X/m3Cel2l2FNB98Ydsm7WFPuUL5XOCoBTK732TWm9avtp4Gqno4uINBrLHjK1LatjEgWvUCCRI0L7DWjOa0GjKqy3ElLGp2GBpaZ62H4viIuGP3laSl8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gfSp/kjm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gfSp/kjm"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50698970941so37365781cf.0
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750211; x=1772355011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy4WnBkIkvEh/axNS8gHjhsiSAf6nP1SGd3uu4mb5rI=;
        b=gfSp/kjmcVK4l5sRnUaTs+72mWS/eKgSCaiuK5MNtNOz1u7W/ypOjJ3cjT19tbwn43
         8EtL6aIVCFrzvkT/t5egy31U/BhzOgOlVZWOpKkQ9/Q8ih0Ji1ryCJRN0Gd21uVUkY3K
         jg6az+HJwmBbFL+Z0h2V6IwfLntGsETzPEKFCiRzazKTqLh7H4ZuniK2xVcb60HVBtuP
         uzA+5GPoyABrviyAtS+nitGFRDSlEYOcZKCQ9W9xNJ354qXGg/TV4qm0ZnZLsaHwdnx5
         Nb2HUPrts9e8VtxBbDd13jYdm1bqd24fV388VWkqCe8hwvp3RcHDsIhfUDdn9M7fRNXk
         SrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750211; x=1772355011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qy4WnBkIkvEh/axNS8gHjhsiSAf6nP1SGd3uu4mb5rI=;
        b=p59RbLkBaSV1gX3bNEF5qrlvBj7q2Nnu0I7eKbTrH0ZowcZO0J56627eU7h19DDWkx
         GMAMpJE8i8HxiLUUUk0HYNp5ThU0m5ZWwUPv9/nPvPXWuDzI9PY3LRtOrrMBp1EfxKnb
         eJOASmP+B0O30ZMQvz63zp3KXIUI1UzjaRTJl8qV+e/FlUaGkdtxmjMYQHHg96UKDPoI
         Zu3luTRaI94MOW3JRkhrOKwK5HRbi+wjjBXOHXROkfBjfVGBOWrrSChqBm18gblD1RTr
         TqVWeFf/GQDVuoNu1/5bHeZ58ckOoT2MbZtI191vgdLWGm5CeaQLYJ2tfYAQftOszlji
         oVjw==
X-Forwarded-Encrypted: i=1; AJvYcCXtDcyFt+fSmCm1S4hQPckV+f7C8IxJV/CkV/M6OQwVeGIdi8z2byHWDFlJM9/mMkNzZY6b/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUqOKDdF2iLDiBVy2CLJ33t2YJCzilbTYyal+9G/CPSndczYck
	3iVihA6V76nCd2B23CudA95iHoAEy+yzAhB7vFQuztReQx7IhnyEP7M/nQe0ldjaPDk=
X-Gm-Gg: AZuq6aL1iKPh7z7muATRInPcbXyyxnZ7NF/3qsp9owgOzsQb62hjG/6MYQsdOCWXRDq
	Av8qpfkYA3yjApwONxL3NN8kkI35FDIugCe+9WHgLKDQ9A6LNmjKySErJ+g0bD4oA5UpLquOxYM
	7UvZHkdRm7xiBS/UT5xVEj8uLZqOAHSsS9UJjfA6zAHhdxpDLpTOn2qXLXJgXU+7Rcr10uJst8O
	yjtriSFYLyL/E+qO8OX3fpLmzQJmlCmsL8pmDJfVRz/AThgJ9LjiIw+JGpyyd/nmypAx6OqMeFj
	zIp+ndI3k9iW/FH6qJmra6zcpSQoArfiALqgW/Oq1Gb9RVyP1IVZPhK88oYvU+9JSxtloDL2DnL
	oQpiuMLlaM7fyYIXmxoP5YoyDZxCsEU17mXXDfMDXQZ69EARSMZJOMOKpVGiWr5ZUHJ78Qh7iu5
	g/20SkWPJYIvy7aJvUkVGKN7jWkulZOLYyQ+LN0KHlDQ+hDxfajYvY3HT/K22HlXLbJhuOBP1zZ
	xIerNyRYRyxTc3Je9Aer3lgBw==
X-Received: by 2002:a05:622a:1789:b0:4ed:ddd9:1402 with SMTP id d75a77b69052e-5070bbddc75mr66100291cf.24.1771750210655;
        Sun, 22 Feb 2026 00:50:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:10 -0800 (PST)
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
Subject: [RFC PATCH v4 20/27] mm/gup: NP_OPS_LONGTERM_PIN - private node longterm pin support
Date: Sun, 22 Feb 2026 03:48:35 -0500
Message-ID: <20260222084842.1824063-21-gourry@gourry.net>
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

Private node folios should not be longterm-pinnable by default.
A pinned folio is frozen in place, no migration, compaction, or
reclaim, so the service loses control for the duration of the pin.

Some services may depend on hot-unplugability and must disallow
longterm pinning.  Others (accelerators with shared CPU-device state)
need pinning to work.

Add NP_OPS_LONGTERM_PIN flag for services to opt in with. Hook into
folio_is_longterm_pinnable() in mm.h, which all GUP callers
out-of-line helper, node_private_allows_longterm_pin(),  called
only for N_MEMORY_PRIVATE nodes.

Without the flag: folio_is_longterm_pinnable() returns false, migration
fails (no __GFP_PRIVATE in GFP mask) and pin_user_pages(FOLL_LONGTERM)
returns -ENOMEM.

With the flag: pin succeeds and the folio stays on the private node.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          | 15 +++++++++++++++
 include/linux/mm.h           | 22 ++++++++++++++++++++++
 include/linux/node_private.h |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index da523aca18fa..5d2487fd54f4 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -866,6 +866,21 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 static DEFINE_MUTEX(node_private_lock);
 static bool node_private_initialized;
 
+/**
+ * node_private_allows_longterm_pin - Check if a private node allows longterm pinning
+ * @nid: Node identifier
+ *
+ * Out-of-line helper for folio_is_longterm_pinnable() since mm.h cannot
+ * include node_private.h (circular dependency).
+ *
+ * Returns true if the node has NP_OPS_LONGTERM_PIN set.
+ */
+bool node_private_allows_longterm_pin(int nid)
+{
+	return node_private_has_flag(nid, NP_OPS_LONGTERM_PIN);
+}
+EXPORT_SYMBOL_GPL(node_private_allows_longterm_pin);
+
 /**
  * node_private_register - Register a private node
  * @nid: Node identifier
diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb1819ad42c3..9088fd08aeb9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2192,6 +2192,13 @@ static inline bool is_zero_folio(const struct folio *folio)
 
 /* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
 #ifdef CONFIG_MIGRATION
+
+#ifdef CONFIG_NUMA
+bool node_private_allows_longterm_pin(int nid);
+#else
+static inline bool node_private_allows_longterm_pin(int nid) { return false; }
+#endif
+
 static inline bool folio_is_longterm_pinnable(struct folio *folio)
 {
 #ifdef CONFIG_CMA
@@ -2215,6 +2222,21 @@ static inline bool folio_is_longterm_pinnable(struct folio *folio)
 	if (folio_is_fsdax(folio))
 		return false;
 
+	/*
+	 * Private node folios are not longterm pinnable by default.
+	 * Services that support pinning opt in via NP_OPS_LONGTERM_PIN.
+	 * node_private_allows_longterm_pin() is out-of-line because
+	 * node_private.h includes mm.h (circular dependency).
+	 *
+	 * Guarded by CONFIG_NUMA because on !CONFIG_NUMA the single-node
+	 * node_state() stub returns true for node 0, which would make
+	 * all folios non-pinnable via the false-returning stub.
+	 */
+#ifdef CONFIG_NUMA
+	if (node_state(folio_nid(folio), N_MEMORY_PRIVATE))
+		return node_private_allows_longterm_pin(folio_nid(folio));
+#endif
+
 	/* Otherwise, non-movable zone folios can be pinned. */
 	return !folio_is_zone_movable(folio);
 
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index fe0336773ddb..7a7438fb9eda 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -144,6 +144,8 @@ struct node_private_ops {
 #define NP_OPS_NUMA_BALANCING		BIT(5)
 /* Allow compaction to run on the node.  Service must start kcompactd. */
 #define NP_OPS_COMPACTION		BIT(6)
+/* Allow longterm DMA pinning (RDMA, VFIO, etc.) of folios on this node */
+#define NP_OPS_LONGTERM_PIN		BIT(7)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
-- 
2.53.0

