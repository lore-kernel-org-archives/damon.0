Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640233;
	b=yaRQDeBih9/fyVLj7Qqbh9LEbwYzfWWSjhKSpTJEW3W9WsSFwx0/eeHf2rSLLITFnq62
	 7Yv+Zg03ftXM7yeng3ytRO//hd491wmRlaqny9kv0WdUHgVXVra85Db7xvaf+rNyZE7fQ
	 f4NgvZeAA1x6oAUXmf+IZgbs98/xrq/RzD2qj3Kg5XHo++v3ebtPjeIzXhssOvf05OnRJ
	 UKggNtbZtsPvhr8aBn59GH0kHhWVZ2Ltz8KcjzXozyBRG7eob5FA6ojLGgmUyBy9lLc4f
	 7MDd7TpoiXXWqYpA5O6TrUHuFLyY+26rXlPdz5oUwvMplEG1lcMVaxUJS8ZbJZcRaSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5RFbW7qtEXFgFx3OLZ5ldAh4JcKSI5CeWW5dNwakgac=;
	b=cwqCL64iU1qNf0hY1uXCvtIQMYdyb+TpYtdrV/GhlCm/k5NcBpoHrmMDZP+uhsK4hc5V
	 oylaMoGzBhZZRJ9KaITLdX1Jyad3aXjh8G3/0wZJk80BqThQNsReuTbv6RWBmyAKcY9Mx
	 wOMIC8tB+YEjChj2Axo2b9H1BH8envd9n8pXn52dBoXE2eKNwxZ6ED9muS+2eXhYNYMkn
	 AVWA5I1GWTF0IRU/jN17WOV5vCYv+hcyPvlRBl2cOiTRlHswdUcRpR79TywiyUXetpNYI
	 c6G/e87vmpwBYzJQSiHduoDa6LA0XcZIJANcG1nOlVSfn2ioCtwZOpmNUUAm3jT2/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CPE9fRt3;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF11B60A6F7A
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF11B60A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=CPE9fRt3
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5363316fa0cso29203301cf.3
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 23:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794640232; x=1795245032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5RFbW7qtEXFgFx3OLZ5ldAh4JcKSI5CeWW5dNwakgac=;
        b=CPE9fRt3Th/9h41MELRzPqGEgQT14KdsGngeNCixNSbZPIcskYdcxUwVUUDHZ52ymd
         vDcKBU92mTjSiVxO+R+8N88LjJHJ6ljD+xNspdFkHxqLYhN/FxqEyxc24GlhhGVUipKy
         RYk3o14lSBPX2tskXZSc6RwDNdecQRVfIWj20aujTAP2Utda3h1/1Ou/UXgAUEgi02Gf
         Jb83h1F6acTQgC203iVs9vLlUTOMIkYEK7CU7e7IPpKOlZBHeIeWjcZ3GziD5BsrZGAU
         8tc1NabYWCEEQ3D+QR0h+/UmkDZINyh0FIJmz2ISjEUr/2ysE+hhFpVTd5WR3L7tIZ5X
         WPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640232; x=1795245032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5RFbW7qtEXFgFx3OLZ5ldAh4JcKSI5CeWW5dNwakgac=;
        b=yDXeIx0IgxjXKFSGwFJN1sZ+mr2D4GRdlkzvthodnbgHouvpHD/fnoo9JJpAYaRRai
         FgGUP6kj4Xl1L8eEwsoHozMm5o2rC8xeZ1kv7P2GbfVHZq5jXifQQACWC3eFSbxL7Mug
         uXNk6amIREFrFY9RTrbSyROwc0ylvwX57UiVeCn7XEtP2nBOIGfCoQE/jEbxIcaIy3oO
         CJ0eMYTvc+bBZwXw/PSXMYu4TvrEHObcp89kYhu+qXDVCZ+WRO3opdz458Ocy+T3PSJU
         92uM1OWJqmE2fkPUs8Ql5fU52JIK3XgtCFzde3Rgd+qHrHUJofcBECcdJSktFW0WicCk
         TlbA==
X-Forwarded-Encrypted: i=1; AL+hErHqGO0R/quVxZ84eejF7WBVLs907QSM/y7KmgkoxUlmCV8tKhAS8Ry8AU6apiFwnQKVRH0qLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pBSG+RXlHxRCKiuJoeW2NgAeDuOB/VqdgpZyOIbyL/j9+kdsi
	5Maa7s0OTB0O3jlxLjgzdSLg85TQx5yQwh2Cooj3W3iG5ZEx8YkqvfC8dJK+WxvbWTo=
X-Gm-Gg: AYBFou23fB8FLWEwhfkwJl7D9z0jYDOMr+djhU50YeyB7Bal2lUC5lbNJ83Th+u9w98
	Mx0qWQ516PKdoahiEslLE6L+5zEg1Pi2FBukeMCZ/fuH0t6mQpJI6fpvNaKcdbPRixLinfwHvZ5
	IA4Tyqkt6xnO7oqFrCIPl42Q1I7qDlsI5h96crro7z8i39raBhiAEDWHPFmByvGzgM3FZkjYD4a
	fPUAUYaFsKDw98WWoi1Yz40izqqGuPWBO186qN4ViXhnSn/MgHkhAqaXWYXkjjDAa7azqMDVmeC
	P01j+txFHxslwrZ3vUwmzuDut2FykucQ3v6ZSgVmYBAFjAViVyGVS5oX12oUkredPgkEvyBsQq5
	JRk04bhOnx2EGSMNChpeZZhFZnQg57vsORbfEsp+rZn719UGED1tcgRmV1cquzJK7Gfa5ND7/5o
	RiDCqEBrolScV8nvQZUHiCG6SiKSwRK9t0+O2pjlfce6noUDkkVUmsT0bYYSbl10TfLj4cMz5DF
	Aa+MSvZSfW0+sh0qPej1sOmD2lNOC1TcFVfgjsc0m6xNaMmVTPI5RFm8yrYpROfu9bD5r3h/kOq
	kEGNobzaa0jNOMQKSwS7vx/imZEtWrpPY5n6MNR+3jof712LovZ9ntDOwc5LRECoUjP1KUKNGAs
	QkLQi2onJSWeV8EXeMIJG2XBSJE7DXfPqpPNC
X-Received: by 2002:a05:622a:58c:b0:535:a5fb:6459 with SMTP id d75a77b69052e-55ac8e98474mr80004781cf.68.1794640231712;
        Fri, 13 Nov 2026 23:10:31 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23db3a99sm37730986d6.40.2026.11.13.23.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:10:31 -0800 (PST)
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
Subject: [PATCH 13/22] mm/hugetlb: restrict pool growth to common memory
Date: Sat, 14 Nov 2026 02:09:50 -0500
Message-ID: <20261114070959.3490008-14-gourry@gourry.net>
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

Fresh HugeTLB pool folios come from ordinary allocations, which only
N_MEMORY_COMMON nodes serve.

Restrict HugeTLB allocations and pool-growth to N_MEMORY_COMMON nodes.

Keep the original allowed mask for pool shrinking and demotion so
existing pool folios can still be found on any online-memory node.

The result of this change is that hugepage allocations will fail on
nodes without N_MEMORY_COMMON.  This restriction can be loosened later
when/if it grows a user.

All memory is common at this point, so behavior is unchanged.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hugetlb.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cb2de24affdc4..cc1468f68901b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3452,13 +3452,13 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 			gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
 
 			folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-					&node_states[N_MEMORY], NULL);
+					&node_states[N_MEMORY_COMMON], NULL);
 			if (!folio && !list_empty(&folio_list) &&
 			    hugetlb_vmemmap_optimizable(h)) {
 				prep_and_add_allocated_folios(h, &folio_list);
 				INIT_LIST_HEAD(&folio_list);
 				folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, nid,
-						&node_states[N_MEMORY], NULL);
+						&node_states[N_MEMORY_COMMON], NULL);
 			}
 			if (!folio)
 				break;
@@ -3528,7 +3528,7 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 			prep_and_add_allocated_folios(h, &folio_list);
 			INIT_LIST_HEAD(&folio_list);
 		}
-		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY_COMMON],
 						&node_alloc_noretry, &next_node);
 		if (!folio)
 			break;
@@ -3672,13 +3672,12 @@ static void __init hugetlb_init_hstates(void)
 
 	for_each_hstate(h) {
 		/*
-		 * Always reset to first_memory_node here, even if
-		 * next_nid_to_alloc was set before - we can't
-		 * reference hugetlb_bootmem_nodes after init, and
-		 * first_memory_node is right for all further allocations.
+		 * Always reset the allocation cursor here, even if it was set
+		 * before: hugetlb_bootmem_nodes cannot be referenced after init,
+		 * and further pool allocations use common memory.
 		 */
-		h->next_nid_to_alloc = first_memory_node;
-		h->next_nid_to_free = first_memory_node;
+		h->next_nid_to_alloc = first_node_state(N_MEMORY_COMMON);
+		h->next_nid_to_free = first_node_state(N_MEMORY_COMMON);
 
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
@@ -3802,23 +3801,21 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	unsigned long allocated;
 	struct folio *folio;
 	LIST_HEAD(page_list);
-	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
+	NODEMASK_ALLOC(struct nodemask_scratch, scratch, GFP_KERNEL);
 
-	/*
-	 * Bit mask controlling how hard we retry per-node allocations.
-	 * If we can not allocate the bit mask, do not attempt to allocate
-	 * the requested huge pages.
-	 */
-	if (node_alloc_noretry)
-		nodes_clear(*node_alloc_noretry);
-	else
+	/* Scratch masks for allocation eligibility and per-node retries. */
+	if (!scratch)
 		return -ENOMEM;
+	nodes_clear(scratch->mask2);
 
 	/*
 	 * resize_lock mutex prevents concurrent adjustments to number of
 	 * pages in hstate via the proc/sysfs interfaces.
 	 */
 	mutex_lock(&h->resize_lock);
+
+	/* Fresh pool pages come from the ordinary allocation domain. */
+	nodes_and(scratch->mask1, *nodes_allowed, node_states[N_MEMORY_COMMON]);
 	flush_free_hpage_work(h);
 	spin_lock_irq(&hugetlb_lock);
 
@@ -3855,7 +3852,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		if (count > persistent_huge_pages(h)) {
 			spin_unlock_irq(&hugetlb_lock);
 			mutex_unlock(&h->resize_lock);
-			NODEMASK_FREE(node_alloc_noretry);
+			NODEMASK_FREE(scratch);
 			return -EINVAL;
 		}
 		/* Fall through to decrease pool */
@@ -3873,7 +3870,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * within all the constraints specified by the sysctls.
 	 */
 	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
-		if (!adjust_pool_surplus(h, nodes_allowed, -1))
+		if (!adjust_pool_surplus(h, &scratch->mask1, -1))
 			break;
 	}
 
@@ -3889,9 +3886,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		folio = alloc_pool_huge_folio(h, nodes_allowed,
-						node_alloc_noretry,
-						&h->next_nid_to_alloc);
+		folio = alloc_pool_huge_folio(h, &scratch->mask1, &scratch->mask2,
+					      &h->next_nid_to_alloc);
 		if (!folio) {
 			prep_and_add_allocated_folios(h, &page_list);
 			spin_lock_irq(&hugetlb_lock);
@@ -3978,7 +3974,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	spin_unlock_irq(&hugetlb_lock);
 	mutex_unlock(&h->resize_lock);
 
-	NODEMASK_FREE(node_alloc_noretry);
+	NODEMASK_FREE(scratch);
 
 	return 0;
 }
-- 
2.53.1-Meta

