Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251FA25783A
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750210; cv=none; b=PPXN5KIanwzV9cPMeGsn3cttyzxRgGBhHpNvak2EB0agZfN48lWP12A9AjDcevT+xpJfjlrYX10MyCcTqov2PnMY9anc96wWETDXcmvHym/9Xd9R8O2yC50K+FOEjT3gDrPrdQ+2cnAeSpHgwUV2MI4nvJRoNUDdtZ6bqCxK/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750210; c=relaxed/simple;
	bh=ugHHZgdJqiJXcDB88oSYbue+JadFi16VcX0GKhbfi44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWkdYxJY4FTI0acVYOU9o9PH6XkUB2BZiHE8A6wvzygabRGQJNx26AmGJSW73J0Cowa3hm4cT8/tl+7EwvOCJvDOFw15MdwYkkOyzGe33a+9Vo7kl/9RB88brjvSCxb55+/ywZGSzkiNNMq4ZtgQoEWXLGozNOL2zxZedABNKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Gz2mqyTi; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Gz2mqyTi"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50334dd44d2so41386611cf.1
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750207; x=1772355007; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FZckDxptwGx8klYMDL0XD8dz9+dfEviXYn1CKFqg9s=;
        b=Gz2mqyTiL8PbFgmNeWZd77sM34JL8NHh3cD926LFBJwSWktc9iiiow9bUYbR/wVx/n
         cW7GQ8n08G+K5Al84gUg9usWEtdoC6Z2mL4Fgz5K/MkH+F3ku7OFJDpViRdcefCTtEVa
         V1i6X2FsN7F8sz63aAq9WZLxkRH2D7hiN6K8lQfYQqlDu0jRnbzRsGz87AXT/aShqyZW
         5H045yaBDJkJgM1z4j88iAWrFfc4mrTUrHzQyAXrCzB+VYOd+1Ydf8iDH5IeC5dXCOCE
         hkDF+Gcs3WusswmMgJQPVofSZm2Ebpssqsa4RwTgRW7Ka54iFx3Df0MO4JE1fZP8y/cw
         1/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750207; x=1772355007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FZckDxptwGx8klYMDL0XD8dz9+dfEviXYn1CKFqg9s=;
        b=hOXfWC/Q4E2EsT4s+z2FiAbtxEL2/GNq32isTecYuCrXZnlmZFzvH8Wp0Eb/GBFT8D
         RxUdHdLvFiYreK11eMRKENj14cAJCdMIhO4NxQQszBmhpGQ4F7040ZZmotRtUWASbFY4
         Kj1jEniNLx+M20rfc1KGNt+tUrrwATeojy7OPE9SeJZLco3DTl97NubdamAzYHpafOtD
         +EXWkvjZlJgduNtYSVS63zvcIuWSKpNgtB/nQNnGSFTskvCdZTHKi8i3yjoqBmDYmlzp
         8NqtnbNKIu++9RNBOT5pmwrWz+WRiYtJk2UUUlyxKxPhhTu8E5l1AbXnNKNt8rcj/ah0
         PB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOU+k4xQP58VpOTmfHW4bi4ZhmuJuGrw099aFwwXhIs6onF2oozw54C5M5ELkOByNEcPfS9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE8bI+Scvc35E8Jxv/gi2Uqr/SfP5+kjMbrOhaMFkXmy+1dVp2
	32ph/Z+QFp/lbVWaK47eQI+DxheqRUg3m27bNo+GVmKEgbBskmukeDH+Hkupv3T1yRE=
X-Gm-Gg: AZuq6aIDpSmxja6pPtDLGcI7YzEyYbLRiGdDBp/sWbKdaxwHSd9pfiSOmaRSQYk8vKJ
	itxzLXI+tL4tyHGOoJzk8lQIrVfGo/b+veZuclSYawHCIcdu733n9GcJysQBzzArVYDxflnWKJx
	1DA+tDfnqx8gWDD63EJEOttRgeODR9S+Q6wyG7/eJMS9GnVeP25JjstnJx1NEUHwOWjXxR3DBjM
	HiRNpnIuNgzqr5DVZqMr7nA+3A6qJtDgPo14sI4aI5ZsS8dywPEIQnSlVrB0ttkcsq6mxs0fNGN
	0Zt5rrAcA6fWN1Y1RFGw8oPIqmvGOkDR+kPubRrJZld4rXIUPJU4IJEvJLkKJYYZcQ+KmoGBVd8
	bEvj982O0h5rxpb2u6FlYGWeYmVtKEGj8LgFB7M51jv2pbPGGjGgcJY3QGEeA08HlH1R4O8kyF5
	6Uc6+iEbqDmUczC2cwnKH26fsuVakcoCERaLmbURLR42Lt9O10JHVqJOrzrAGmW4HRzpNhHkdJT
	FMWGDW+eywMuos=
X-Received: by 2002:a05:622a:209:b0:4ff:4a7c:da11 with SMTP id d75a77b69052e-5070bba08b0mr86322821cf.11.1771750207039;
        Sun, 22 Feb 2026 00:50:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:06 -0800 (PST)
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
Subject: [RFC PATCH v4 19/27] mm/compaction: NP_OPS_COMPACTION - private node compaction support
Date: Sun, 22 Feb 2026 03:48:34 -0500
Message-ID: <20260222084842.1824063-20-gourry@gourry.net>
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

Private node zones should not be compacted unless the service explicitly
opts in - as compaction requires migration and services may have
PFN-based metadata that needs updating.

Add a folio_migrate callback which fires from migrate_folio_move() for
each relocated folio before faults are unblocked.

Add zone_supports_compaction() which returns true for normal zones and
checks NP_OPS_COMPACTION for N_MEMORY_PRIVATE zones.

Filter three direct compaction zone loops:
  - compaction_zonelist_suitable() (reclaimer eligibility)
  - try_to_compact_pages()         (direct compaction)
  - compact_node()                 (proactive/manual compaction)

kcompactd paths are intentionally unfiltered -- the service is
responsible for starting kcompactd on its node.

NP_OPS_COMPACTION requires NP_OPS_MIGRATION.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  4 ++++
 include/linux/node_private.h |  2 ++
 mm/compaction.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 88aaac45e814..da523aca18fa 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -965,6 +965,10 @@ int node_private_set_ops(int nid, const struct node_private_ops *ops)
 	    !(ops->flags & NP_OPS_MIGRATION))
 		return -EINVAL;
 
+	if ((ops->flags & NP_OPS_COMPACTION) &&
+	    !(ops->flags & NP_OPS_MIGRATION))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	np = rcu_dereference_protected(NODE_DATA(nid)->node_private,
 				       lockdep_is_held(&node_private_lock));
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 5ac60db1f044..fe0336773ddb 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -142,6 +142,8 @@ struct node_private_ops {
 #define NP_OPS_RECLAIM			BIT(4)
 /* Allow NUMA balancing to scan and migrate folios on this node */
 #define NP_OPS_NUMA_BALANCING		BIT(5)
+/* Allow compaction to run on the node.  Service must start kcompactd. */
+#define NP_OPS_COMPACTION		BIT(6)
 
 /* Private node is OOM-eligible: reclaim can run and pages can be demoted here */
 #define NP_OPS_OOM_ELIGIBLE		(NP_OPS_RECLAIM | NP_OPS_DEMOTION)
diff --git a/mm/compaction.c b/mm/compaction.c
index 6a65145b03d8..d8532b957ec6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,9 +24,26 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/node_private.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
+
+/*
+ * Private node zones require NP_OPS_COMPACTION to opt in.  Normal zones
+ * always support compaction.
+ */
+static inline bool zone_supports_compaction(struct zone *zone)
+{
+#ifdef CONFIG_NUMA
+	if (!node_state(zone_to_nid(zone), N_MEMORY_PRIVATE))
+		return true;
+	return zone_private_flags(zone, NP_OPS_COMPACTION);
+#else
+	return true;
+#endif
+}
+
 /*
  * Fragmentation score check interval for proactive compaction purposes.
  */
@@ -2443,6 +2460,9 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
@@ -2832,6 +2852,9 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 		if (!numa_zone_alloc_allowed(alloc_flags, zone, gfp_mask))
 			continue;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
@@ -2906,6 +2929,9 @@ static int compact_node(pg_data_t *pgdat, bool proactive)
 		if (!populated_zone(zone))
 			continue;
 
+		if (!zone_supports_compaction(zone))
+			continue;
+
 		if (fatal_signal_pending(current))
 			return -EINTR;
 
-- 
2.53.0

