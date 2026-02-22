Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73226261586
	for <damon@lists.linux.dev>; Sun, 22 Feb 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750216; cv=none; b=aVtx+JC8I973m1saFhOXa7k4bYGX6pZCxVxoJFq1OJ3SM+EWu+LvOfUHCVRh8ubmv+90Evzo+Y5nn8HrKDUuVTyPALg2w7w7YETJOOaK5vwF2x6L1avoe1ojrecH+LCvFMs6EYXHF5ygbYzwChkV7cZXgXFs+HnoIeLF8QrKgyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750216; c=relaxed/simple;
	bh=244yDtSyFVbK83TYYa36HIEQwZx1d31NEEAoZWs7XP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnLFMlOMv5GUnbR+BOPkOGVp4AudyRTkl20x77TopUcKlRMhIMfvHn2LAs4NhDL0O+ZguwWTRtk3mP4Q8bRiWsrlMJaUB7HizUcD1uZuD2at7Mb+WFQ6ZyAaFaUL7O6dAVvr0vDCPapo6wFLtUtJNqNz0BGmZzMRxS+OVQTCyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZJ7Vet/F; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZJ7Vet/F"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-894674a4c4aso55252886d6.3
        for <damon@lists.linux.dev>; Sun, 22 Feb 2026 00:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750214; x=1772355014; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqXt+gXrz4jwbWr1GpuXze54uGQtZjiwIpwqUhqliWw=;
        b=ZJ7Vet/Fv4CLNWsAOr6+J+Lhh4vQZCo7T8KeK7GJTsYiXxDk9qkEa8szpio4dXnIuA
         xJIFB4KlnzuIScsh2InwvfOwRC4jIcs6NcxjfJ0F0eZoYeRUhHJzzbRLKV38O8uXuq9r
         fKuw/Bsgi/ChhWDjqu8mgr75PQZAL+KPMxgQNcBH+1kUAzuVYZZZZQwBRjVtrD8Wc8bk
         xOkgniRkpvKNHpAiyjcNdk34ExXuZfGsR/QP4rPzao/LbYvbagB40d1pzdyYfdgBmIfF
         fUGtMiKLXD3KuNYStzU1xpAnlJynvy+xXjI+g4P1UIgHeCC0cWYunmD5FgsVhjevFjEL
         VsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750214; x=1772355014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqXt+gXrz4jwbWr1GpuXze54uGQtZjiwIpwqUhqliWw=;
        b=kPRptbNyGnKiNPSP8IxFcMQry1ihLqPAVJ14Hpol/WTgZh4FclxIgVfuYW51kuSSAi
         EoZCcF+BYEj7y5gRRvQ69ZyfZYAhSOOMG6Gi7R20VzmrS/JkL+HIw+BZTkNklCyCtSlh
         GekSauTMitCZaCEm34K0CvbiERaFARyIm1jweBh669mYCQsPbUQihyfP7U4XL9dQvBlT
         Vap0H0zKqWVeZCcesCw0GFOKijqd1cxD/5A+9Xx3Jdw/w0hqZKrv/5Ubb/5/HoCo0GHT
         R6acF8HDRm6AHfmcT3WoBtMCfzzKWnJH3PysIt3rsrdEdFaFiXQe4RsuCGXMAUmGOLA+
         487Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcpbXvWXdWzuR7NxNRkwFrNU6xxPbChyPrXokGFTE1VRkvXfOtt9jwqSumL4o8zw2Hv0G23Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4tVQMhOG+Pl0iFjXuI2PgNhbukFAOxl/weNpJi/r3UEJF5bPa
	CaDbjGcc5hMI/PfvGsmhvavPXdIZIV8xBaTlfFxIupHaEf03Fu7dfVd0ZNFvmK/fZcfCJStAmRt
	VX/7G
X-Gm-Gg: AZuq6aIidzfCkDgcHc+Yt3m7qTDv4BFFS+W8KTPjCMO9nYw80bD5dtfHFcfwWOjHp9J
	aBePKkqHKfD2fYyi6QPEXi9q0zSEsw088KquvbivUvsLRVtR3NqPlv9ygDTo7lsv9HJJhq4A8bu
	sX4Og4sJwc71eETOW+jK6Ov6ON42AhIZO1OC6wWkznqF+owSb6l1i6Tqln+4K0EYL7yxd9/i6FG
	BxmvqaeAtqQ9yutv8J/2MDiKMBdqxeYwycfrkadrbD66dj0jEy9FY5gUjwqI9rTxSXXnkefNJUo
	rHsm6dT8tluT75MZmHRg6FFYDGwKshbHz/d2W5u17PulM8j4hUjaji2yA5DTtuTDR3tIC9zKNxL
	i/6jp5G0FcdT1KiYt8wwYU543Q6LfHETiu2+yYMhlnoLtc8f2waZMSpu+gGpTMFXnvFGy+jAUMA
	OVDtSPTLvHF2bzh1y2dsND1OAmYinQVbdxaGQTOTUmqrzmU+/wkFZqD6O44bFvnhG50Z8CUQBXu
	1NL/dJP21j4fGk=
X-Received: by 2002:ac8:58c3:0:b0:501:4b96:466d with SMTP id d75a77b69052e-5070bc97e29mr62373271cf.50.1771750214354;
        Sun, 22 Feb 2026 00:50:14 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:50:14 -0800 (PST)
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
Subject: [RFC PATCH v4 21/27] mm/memory-failure: add memory_failure callback to node_private_ops
Date: Sun, 22 Feb 2026 03:48:36 -0500
Message-ID: <20260222084842.1824063-22-gourry@gourry.net>
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

Add a void memory_failure notification callback to struct
node_private_ops so services managing N_MEMORY_PRIVATE nodes notified
when a page on their node experiences a hardware error.

The callback is notification only -- the kernel always proceeds with
standard hwpoison handling for online pages.

The notification hook fires after TestSetPageHWPoison succeeds and
before get_hwpoison_page giving the service a chance to clean up.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/node_private.h |  6 ++++++
 mm/internal.h                | 16 ++++++++++++++++
 mm/memory-failure.c          | 15 +++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 7a7438fb9eda..d2669f68ac20 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -113,6 +113,10 @@ struct node_reclaim_policy {
  *   watermark_boost lifecycle (kswapd will not clear it).
  *   If NULL, normal boost policy applies.
  *
+ * @memory_failure: Notification of hardware error on a page on this node.
+ *   [folio-referenced callback]
+ *   Notification only, kernel always handles the failure.
+ *
  * @flags: Operation exclusion flags (NP_OPS_* constants).
  *
  */
@@ -127,6 +131,8 @@ struct node_private_ops {
 	vm_fault_t (*handle_fault)(struct folio *folio, struct vm_fault *vmf,
 				   enum pgtable_level level);
 	void (*reclaim_policy)(int nid, struct node_reclaim_policy *policy);
+	void (*memory_failure)(struct folio *folio, unsigned long pfn,
+			       int mf_flags);
 	unsigned long flags;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index db32cb2d7a29..64467ca774f1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1608,6 +1608,22 @@ static inline void node_private_reclaim_policy(int nid,
 }
 #endif
 
+static inline void folio_managed_memory_failure(struct folio *folio,
+						unsigned long pfn,
+						int mf_flags)
+{
+	/* Zone device pages handle memory failure via dev_pagemap_ops */
+	if (folio_is_zone_device(folio))
+		return;
+	if (folio_is_private_node(folio)) {
+		const struct node_private_ops *ops =
+			folio_node_private_ops(folio);
+
+		if (ops && ops->memory_failure)
+			ops->memory_failure(folio, pfn, mf_flags);
+	}
+}
+
 struct vm_struct *__get_vm_area_node(unsigned long size,
 				     unsigned long align, unsigned long shift,
 				     unsigned long vm_flags, unsigned long start,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c80c2907da33..79c91d44ec1e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2379,6 +2379,15 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
+	/*
+	 * Notify private-node services about the hardware error so they
+	 * can update internal tracking (e.g., CXL poison lists, stop
+	 * demoting to failing DIMMs).  This is notification only -- the
+	 * kernel proceeds with standard hwpoison handling regardless.
+	 */
+	if (unlikely(page_is_private_managed(p)))
+		folio_managed_memory_failure(page_folio(p), pfn, flags);
+
 	/*
 	 * We need/can do nothing about count=0 pages.
 	 * 1) it's a free page, and therefore in safe hand:
@@ -2825,6 +2834,12 @@ static int soft_offline_in_use_page(struct page *page)
 		return 0;
 	}
 
+	if (!folio_managed_allows_migrate(folio)) {
+		pr_info("%#lx: cannot migrate private node folio\n", pfn);
+		folio_put(folio);
+		return -EBUSY;
+	}
+
 	isolated = isolate_folio_to_list(folio, &pagelist);
 
 	/*
-- 
2.53.0

