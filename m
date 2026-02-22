Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6002233704
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750176; cv=none; b=GfVk+guUhd13vMD4+2fU4HSf4218s/zpCfoakuG6Sxz3scwDCyaAL/NJiNmxV09MO1u6L6o7IN3/hiZkG2f6Yj9VYrxMBhPTll6nQD9HZZSOsKegqw3qc0iq5ZFStIS45A7gHXQdR3k6+kXsPzcqt0c8zqhKxkOB3ZjiGRY9gIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750176; c=relaxed/simple;
	bh=Aefhw780FZYcBuGz8WT4CBUZ6IdM/Ont/+9yMbNMRvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvenivHZL/Uu2A9TgzTaNN+QYs1zUfR5XWOQNYmnjKBFTEMXCxGT7Yg+7Q75zs0pqwS8WmLnnsZ3OBE1jiu4v4j2mieEBBFoPkbQGJxJpQa941kEDS5Wke/5PxQyMsmedhjeYGUjrSg/hiR0Rl0Jylk4MjDGWMc0BNEsJAFJ5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cYUCCCuq; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cYUCCCuq"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50336cffef9so25076751cf.0
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750174; x=1772354974; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV1BMLJRDB150NHPYMpWTJDZSx7tUpTBtDPGS7yRISs=;
        b=cYUCCCuqF5KqM6hb4Dhd794tvzePqrLXJen3zVvRfppsBIXzc8D/YTcX8MOixmzIRd
         vMi9gs2YYlUTiEgtpjs3RWO+Ujr+1TeWFBHW5Nw5spCsSMQNq8h/dpvYKhzlw/qmaSFw
         fUkpG49idaW5cPwD8CAQFTA4jywXqc4pTeOvv3WMpO2twNURQhNMLnA1tRHeuGtQiaEU
         fwfTSUIlKi9uElEmOQE/k5L/3NaePvMn+AQE0z/gMT6TJ8BS49+TF1FjSXrR07NYLFwa
         0BcEKu84MUuZJWawx7CMqUo69megI8OO9m7fc4QU25WERiDdIRQtPlkMDODJui2ZzOfx
         FFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750174; x=1772354974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CV1BMLJRDB150NHPYMpWTJDZSx7tUpTBtDPGS7yRISs=;
        b=PiWI5ChZFCmSLMjsxwCv+GKmIgj2io+wL+wSSroivnHpC6A2nQFfC5o9IKF/u3tkww
         xa6jx37WpvmWr2iu/WgD7a0mwAzqntzgZxlh20lpm3zy6BGZuHh3pU/pOuN0DLqJTnwq
         i8hSbUp+6ZUeW4IaZU4GGkqMOb6FezrTM4XmbDR3XVTV1v2CywJ65Di2hdkTaTl0Fe0o
         M6VGfmEltlrXfVxboFQrNWVPzij9nl2+ddPyQi8i4sWvJt32qRSj9jEPMWR5xl7f2cqK
         6F8Fewa9jGKIUDvhnlvgXklVWPQAQAWZ3gFUAhztjIKdxfU7tlyRMpcTzxq3/MvpBPKq
         bkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWV6KRQ+tGeiZxdA756Jv0RwIgdViLqxOQ59YBil+4AMwNpIcPioaAWwqqeDiJUtW9yq9eew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtd0tDrXqeCugLHliHcmQGtEiEZQf3YrB92exlWqN6JwC60kVo
	cZDZmUlxKqO3BeSr6Tig/ticQuyYPS/Fb2iTPgeW414kXaKd2bJ/14FvU7IH8Vo1m30=
X-Gm-Gg: AZuq6aJfJIdJOJy6NvYcQ+7rqYJrGKvWu/NJdyOKc6Ovb52neeGWDFplwu2UgJYWXiF
	EpIJzE/FE3li3GSjgqReiLhdEcr4eDISY0Zrr8Q22watALb6zkNPaa4lp6918F0xodyLr9q/TAP
	2pOKL0wtYsuSJxi5uzoamTwtxj4nTXLOOHvZKX+eg/UQs8XbdWQzLrTcC1vSBegBjiAf++CTVE0
	1E0vzw9nBTIujEw/OpZ3AIpv7PjtmmCjin2y1Frxe4nqInN5EQ3cXPZRrjZRqaZvhPuiIR3ryrM
	0kyrWX0lsOIfUfToOpXdR1Zqy9eEs0HPC2aeArH6YBH79ZG8PtzcF87QAEgRb/jA0uFLWqHeCKZ
	CjmJ4Jt/4zmHRODkrbECdABovevihlkbplxoDBVr+fmn84/CBL0IWvGJKXrLNrdAa2F15shsc08
	CXCIBgEQyn/v+cf6lyG4cbTpl1mcfrqbGD4FoWvJ2q/uKPdN4xHHmjNPTcwfr8iNY0GuqrEkaGO
	ZXreYyE0fJPkrw=
X-Received: by 2002:a05:622a:1903:b0:4ff:c884:31ad with SMTP id d75a77b69052e-5070bcb47ebmr73646721cf.53.1771750173883;
        Sun, 22 Feb 2026 00:49:33 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:33 -0800 (PST)
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
Subject: [RFC PATCH v4 10/27] mm/swap: add free_folio callback for folio release cleanup
Date: Sun, 22 Feb 2026 03:48:25 -0500
Message-ID: <20260222084842.1824063-11-gourry@gourry.net>
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

When a folio's refcount drops to zero, the service may need to perform
cleanup before the page returns to the buddy allocator (e.g. zeroing
pages to scrub stale compressed data / release compression ratio).

Add folio_managed_on_free() to wrap both zone_device and private node
semantics for this operation since they are the same.

One difference between zone_device and private node folios:
  - private nodes may choose to either take a reference and return true
    ("handled"), or return false to return it back to the buddy.

  - zone_device returns the page to the buddy (always returns true)

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h |  6 ++++++
 mm/internal.h                | 30 ++++++++++++++++++++++++++++++
 mm/swap.c                    | 21 ++++++++++-----------
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 7687a4cf990c..09ea7c4cb13c 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -39,10 +39,16 @@ struct vm_fault;
  *   callback to prevent node_private from being freed.
  *   These callbacks MUST NOT sleep.
  *
+ * @free_folio: Called when a folio refcount drops to 0
+ *   [folio-referenced callback]
+ *   Returns: true if handled (skip return to buddy)
+ *            false if no op (return to buddy)
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
 struct node_private_ops {
+	bool (*free_folio)(struct folio *folio);
 	unsigned long flags;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index 97023748e6a9..658da41cdb8e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1412,6 +1412,36 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 void free_zone_device_folio(struct folio *folio);
 int migrate_device_coherent_folio(struct folio *folio);
 
+/**
+ * folio_managed_on_free - Notify managed-memory service that folio
+ *                         refcount reached zero.
+ * @folio: the folio being freed
+ *
+ * Returns true if the folio is fully handled (zone_device -- caller
+ * must return immediately).  Returns false if the callback ran but
+ * the folio should continue through the normal free path
+ * (private_node -- pages go back to buddy).
+ *
+ * Returns false for normal folios (no-op).
+ */
+static inline bool folio_managed_on_free(struct folio *folio)
+{
+	if (folio_is_zone_device(folio)) {
+		free_zone_device_folio(folio);
+		return true;
+	}
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->free_folio) {
+			if (ops->free_folio(folio))
+				return true;
+		}
+	}
+	return false;
+}
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long vm_flags, unsigned long start,
diff --git a/mm/swap.c b/mm/swap.c
index 2260dcd2775e..dca306e1ae6d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -37,6 +37,7 @@
 #include <linux/page_idle.h>
 #include <linux/local_lock.h>
 #include <linux/buffer_head.h>
+#include <linux/node_private.h>
 
 #include "internal.h"
 
@@ -96,10 +97,9 @@ static void page_cache_release(struct folio *folio)
 
 void __folio_put(struct folio *folio)
 {
-	if (unlikely(folio_is_zone_device(folio))) {
-		free_zone_device_folio(folio);
-		return;
-	}
+	if (unlikely(folio_is_private_managed(folio)))
+		if (folio_managed_on_free(folio))
+			return;
 
 	if (folio_test_hugetlb(folio)) {
 		free_huge_folio(folio);
@@ -961,19 +961,18 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		if (is_huge_zero_folio(folio))
 			continue;
 
-		if (folio_is_zone_device(folio)) {
+		if (!folio_ref_sub_and_test(folio, nr_refs))
+			continue;
+
+		if (unlikely(folio_is_private_managed(folio))) {
 			if (lruvec) {
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (folio_ref_sub_and_test(folio, nr_refs))
-				free_zone_device_folio(folio);
-			continue;
+			if (folio_managed_on_free(folio))
+				continue;
 		}
 
-		if (!folio_ref_sub_and_test(folio, nr_refs))
-			continue;
-
 		/* hugetlb has its own memcg */
 		if (folio_test_hugetlb(folio)) {
 			if (lruvec) {
-- 
2.53.0

