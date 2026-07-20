Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDE49551D
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576141; cv=none; b=JoHsIP0gA+d8XeW/IRDV6ibDOBNcG7c2a5hAo/XMk688WO4/XHKZbV3rTbePJpx+qWrZdsYMrKTY6QHbtrle+8S6IT4m5n9O+qFlzax879P1STfNBGY6EMwDJb26k0r1+RKThhqD4Q7wJhdIB2RzwjDVo4kFJ2jL1HTUAOCeZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576141; c=relaxed/simple;
	bh=BtKBWdkjS9o77enkZUBMvcNJnN5s5RzN+oUPM2oERqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toPQvSX2S0A0vjhkR95pCpF+faveKITWneLHaBCqqlDfGN6ry9XH82NFNuTz0X/Wo1/6LmHHCubWkXyQifmHEgrOZGCf1J7AeOzCHzWW5KRC7B75YJl1TzT/JDaRuSMJJ03/Pj0qsS8ICC/3PJbZ3vcLcbTG+0zuIe02uiwPknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=e7VyspRj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="e7VyspRj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e50a650a0so622255385a.1
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576136; x=1785180936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Td0ObD4Hgwpwfgrx3CumklQ3nHYCwgNqQNeFJP8dHtU=;
        b=e7VyspRjSvD7XdvtbRbsWcH/slN+4YStmzn4Vq0jIPKGYa+U+x/QY6+4MtXSKGwkIA
         IDtydH/hIBH6iJVAR9ZjncKm3wi7EIESOrVoiRTM3SEEYDyChYRGm60F116A+aoihiXP
         81KfS3Zd0oxp86VjyN7LbgzYr8HEXX1TaoqcTCyLqE1kVwS2f/3jHg6cE8aBslqxEWSe
         LzfORcnIet8m7ekpG6F8PbW6E/NB5hu2xoXXwqpu3m0+V5875E450+MIIBuCIjLDx5St
         Zz44t132w6ED/hJTZUNnzVE7JciFkcLGGPfvfTONI6xV5ya3AN0PgyPZJqpYMwc22PGI
         QT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576136; x=1785180936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Td0ObD4Hgwpwfgrx3CumklQ3nHYCwgNqQNeFJP8dHtU=;
        b=VV9cLb/BJywJvNP7NH6OR8JzLE6LKpCkMeMdRJ/7YFSTgBtVsAyScelfaKTwUymNs2
         HlByIy3vWvJ3qLJww1CY9g4BCWcrXTKgmxtU845Hkhs5w39Ve0XooPcWhNwdIclDaoCz
         qnC/yVqR2yD2nmpBu5DCuNwL0AH1Bi0bV6CXDEoaOgWEA0JbbR6fPLDw0IQGH6U6c2mE
         TL6G/GyiukPdUfnJkrDv8Jn1EitZNOMiYTn0vDkM8avwGQBtnyyfqOAZdh9EQ44LTQnr
         O54tkYi6MZJZeOcFJyEHyE8k7K3nAaQtO9rWk69OBN/1IfGqeQ3CQ5tluHZGuRuH6/9t
         Eqyw==
X-Forwarded-Encrypted: i=1; AHgh+RrWbU9/NsF46/gi6nPCBOA9dgKj/3MYGFepMH2AnGEgHyWtO1df8EvHa72/4tbryjEJpLXC3g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxag5L3jvn7kRQDkOD3Uh2XA74JvnQkS7eGa/d3HeV+OJUkmTcx
	pBg8bwuvmQFSu/lkoG+ERMIxPwfMX1RvfmmHOB6u4V2w2K9BalPIsEQCplx9J4bYM5U=
X-Gm-Gg: AfdE7cntb5gdH91QvZ/3fwlOKYf+99ZN7RJ3sKC7QMllsvxVM397EQvkepS8cXFlTZr
	d8AVzSa29DHSQ+j8JyX7x3phj3eqy5Ule7ICSkxofyQSgBmwqj5V+yMw0uSZiTjgU5GDDteZ5aB
	HkoB6oq26ZC0gAbxtVV5hLYK9TAStL6rhw9q+kBj2rONWH74qvujV/uoqukhHTyefWUKKSRa2Ph
	JZm7EJUHTm2rtkxn/8ihF+WwV15NbN3cxOOBo4pgvSN/sNZbAkLMmhKX1khrYwSiH5mt6qecD3i
	1Ap5soRhdDeaUH4nD6zc8UXsds2crk6ntmx35fc2uMFhsa2PHlqpHcKd7+cIcFEustTbVQ+HGDj
	9dulYt/J6fC+BbPB9WvnV1XSgjQT2/Wky/4EaMsOYOTxrUviO4HFO62dWYetkRQ8qHMMQakEhXe
	HTGi1EpdwfGaK05R0zg4552YuSTxftNwujr4BtJJaOmUiKLl/qR9QYgoh5gg9gyXpPMfXkH/vsL
	Q==
X-Received: by 2002:a05:620a:890c:b0:92e:c117:5ed6 with SMTP id af79cd13be357-930b4350ebdmr1533259585a.86.1784576135604;
        Mon, 20 Jul 2026 12:35:35 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:35 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 22/36] mm/mempolicy: add MPOL_F_PRIVATE and zonelist selection
Date: Mon, 20 Jul 2026 15:34:16 -0400
Message-ID: <20260720193431.3841992-23-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MPOL_F_PRIVATE, the internal flag noting that a policy contains
a nodemask with a private node, and making private node memory
reachable via standard mempolicies.

Plumb zonelist selection into the mpol allocator interfaces via the
allocator's alloc_flags, using the alloc_flags-carrying page_alloc
interfaces.

mpol_alloc_flags() maps MPOL_F_PRIVATE to the alloc_flags an
allocation uses:
    ALLOC_DEFAULT            -  normal allocation
    ALLOC_ZONELIST_PRIVATE   -  private node allocation

With this, a VMA with (mpol->flags & MPOL_F_PRIVATE) can successfully
services faults like any other mbind() from the private node:

   buf = mmap(..., MAP_ANON);
   mbind(buf, ..., {private_node});
   buf[0] = 0xdeadbeef;  // Page faulted from private node memory

Like any other bind, the nodemask relaxes if it is unsatisfiable.

For example: apply_policy_zone() allows an unmovable allocation
targeting the VMA to fallback to a viable node instead of failing.

cpuset rebinding does not affect private nodes - the nodes in the
original mask are preserved, and we enforce two remap rules:

  1) never allow N_MEMORY nodes to remap to N_MEMORY_PRIVATE
  2) never remap N_MEMORY_PRIVATE nodes at all (they stay in place)

In the case of an empty nodemask as a result of rebind, revert to
cpuset - which never includes N_MEMORY_PRIVATE and always guarantees
at least one N_MEMORY node.

As of this patch, nothing can actually sets MPOL_F_PRIVATE, so this
is a no-op that simply adds the plumbing throughout mempolicy.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 79 +++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 7f6fc9599693b..87af18c84b947 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -67,6 +67,7 @@ enum mempolicy_mode {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_PRIVATE	(1 << 5) /* nodemask contains private nodes */
 
 /*
  * Enabling zone reclaim means the page allocator will attempt to fulfill
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2b76c57a460c9..90110e9761122 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -432,6 +432,10 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 	else
 		pol->w.cpuset_mems_allowed = cpuset_current_mems_allowed;
 
+	/* If any private nodes left in the nodemask - add the private flag */
+	if (nodes_intersects(nsc->mask2, node_states[N_MEMORY_PRIVATE]))
+		pol->flags |= MPOL_F_PRIVATE;
+
 	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
 }
@@ -505,22 +509,33 @@ static void mpol_rebind_default(struct mempolicy *pol, const nodemask_t *nodes)
 
 static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 {
-	nodemask_t tmp;
+	nodemask_t tmp, priv;
+
+	/* preserve online private nodes to re-add later */
+	nodes_and(priv, pol->nodes, node_states[N_MEMORY_PRIVATE]);
 
 	if (pol->flags & MPOL_F_STATIC_NODES)
 		nodes_and(tmp, pol->w.user_nodemask, *nodes);
-	else if (pol->flags & MPOL_F_RELATIVE_NODES)
-		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
-	else {
+	else if (pol->flags & MPOL_F_RELATIVE_NODES) {
+		/* fold only the public part: a private node must not take a slot */
+		nodes_and(tmp, pol->w.user_nodemask, node_states[N_MEMORY]);
+		mpol_relative_nodemask(&tmp, &tmp, nodes);
+	} else {
 		nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
 								*nodes);
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 
-	if (nodes_empty(tmp))
+	/* private nodes are identity-mapped during remap, drop them here */
+	nodes_and(tmp, tmp, node_states[N_MEMORY]);
+	if (nodes_empty(tmp) && nodes_empty(priv))
 		tmp = *nodes;
 
-	pol->nodes = tmp;
+	/* If any online private nodes remain, add them back */
+	nodes_or(pol->nodes, tmp, priv);
+	/* If no online private nodes remain, strip the private flag */
+	if (nodes_empty(priv))
+		pol->flags &= ~MPOL_F_PRIVATE;
 }
 
 static void mpol_rebind_preferred(struct mempolicy *pol,
@@ -2411,7 +2426,8 @@ bool mempolicy_in_oom_domain(struct task_struct *tsk,
 }
 
 static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
-						int nid, nodemask_t *nodemask)
+						int nid, nodemask_t *nodemask,
+						unsigned int aflags)
 {
 	struct page *page;
 	gfp_t preferred_gfp;
@@ -2425,14 +2441,21 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	preferred_gfp = gfp | __GFP_NOWARN;
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 	page = __alloc_frozen_pages_noprof(preferred_gfp, order, nid, nodemask,
-					   ALLOC_DEFAULT);
+					     aflags);
 	if (!page)
 		page = __alloc_frozen_pages_noprof(gfp, order, nid, NULL,
-						   ALLOC_DEFAULT);
+						     aflags);
 
 	return page;
 }
 
+/* A private policy allocates from the private zonelist. */
+static inline unsigned int mpol_alloc_flags(struct mempolicy *pol)
+{
+	return (pol->flags & MPOL_F_PRIVATE) ? ALLOC_ZONELIST_PRIVATE :
+					       ALLOC_DEFAULT;
+}
+
 /**
  * alloc_pages_mpol - Allocate pages according to NUMA mempolicy.
  * @gfp: GFP flags.
@@ -2448,11 +2471,13 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 {
 	nodemask_t *nodemask;
 	struct page *page;
+	unsigned int aflags = mpol_alloc_flags(pol);
 
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
 	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		return alloc_pages_preferred_many(gfp, order, nid, nodemask,
+						  aflags);
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2476,7 +2501,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 			 */
 			page = __alloc_frozen_pages_noprof(
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
-				nid, NULL, ALLOC_DEFAULT);
+				nid, NULL, aflags);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
 				return page;
 			/*
@@ -2488,7 +2513,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		}
 	}
 
-	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, ALLOC_DEFAULT);
+	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask, aflags);
 
 	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
 		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
@@ -2597,6 +2622,7 @@ static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
+	unsigned int aflags = mpol_alloc_flags(pol);
 	int nodes;
 	unsigned long nr_pages_per_node;
 	int delta;
@@ -2610,14 +2636,14 @@ static unsigned long alloc_pages_bulk_interleave(gfp_t gfp,
 
 	for (i = 0; i < nodes; i++) {
 		if (delta) {
-			nr_allocated = alloc_pages_bulk_noprof(gfp,
-					interleave_nodes(pol), NULL,
+			nr_allocated = __alloc_pages_bulk_noprof(gfp,
+					aflags, interleave_nodes(pol), NULL,
 					nr_pages_per_node + 1,
 					page_array);
 			delta--;
 		} else {
-			nr_allocated = alloc_pages_bulk_noprof(gfp,
-					interleave_nodes(pol), NULL,
+			nr_allocated = __alloc_pages_bulk_noprof(gfp,
+					aflags, interleave_nodes(pol), NULL,
 					nr_pages_per_node, page_array);
 		}
 
@@ -2632,6 +2658,7 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
+	unsigned int aflags = mpol_alloc_flags(pol);
 	struct weighted_interleave_state *state;
 	struct task_struct *me = current;
 	unsigned int cpuset_mems_cookie;
@@ -2667,8 +2694,8 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 	weight = me->il_weight;
 	if (weight && node_isset(node, nodes)) {
 		node_pages = min(rem_pages, weight);
-		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
-						  page_array);
+		nr_allocated = __alloc_pages_bulk_noprof(gfp, aflags, node,
+						  NULL, node_pages, page_array);
 		page_array += nr_allocated;
 		total_allocated += nr_allocated;
 		/* if that's all the pages, no need to interleave */
@@ -2732,8 +2759,8 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
 		/* node_pages can be 0 if an allocation fails and rounds == 0 */
 		if (!node_pages)
 			break;
-		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
-						  page_array);
+		nr_allocated = __alloc_pages_bulk_noprof(gfp, aflags, node,
+						  NULL, node_pages, page_array);
 		page_array += nr_allocated;
 		total_allocated += nr_allocated;
 		if (total_allocated == nr_pages)
@@ -2750,17 +2777,19 @@ static unsigned long alloc_pages_bulk_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
 {
+	unsigned int aflags = mpol_alloc_flags(pol);
 	gfp_t preferred_gfp;
 	unsigned long nr_allocated = 0;
 
 	preferred_gfp = gfp | __GFP_NOWARN;
 	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
 
-	nr_allocated  = alloc_pages_bulk_noprof(preferred_gfp, nid, &pol->nodes,
-					   nr_pages, page_array);
+	nr_allocated  = __alloc_pages_bulk_noprof(preferred_gfp, aflags,
+					   nid, &pol->nodes, nr_pages, page_array);
 
 	if (nr_allocated < nr_pages)
-		nr_allocated += alloc_pages_bulk_noprof(gfp, numa_node_id(), NULL,
+		nr_allocated += __alloc_pages_bulk_noprof(gfp, aflags,
+				numa_node_id(), NULL,
 				nr_pages - nr_allocated,
 				page_array + nr_allocated);
 	return nr_allocated;
@@ -2796,8 +2825,8 @@ unsigned long alloc_pages_bulk_mempolicy_noprof(gfp_t gfp,
 
 	nid = numa_node_id();
 	nodemask = policy_nodemask(gfp, pol, NO_INTERLEAVE_INDEX, &nid);
-	return alloc_pages_bulk_noprof(gfp, nid, nodemask,
-				       nr_pages, page_array);
+	return __alloc_pages_bulk_noprof(gfp, mpol_alloc_flags(pol), nid,
+						nodemask, nr_pages, page_array);
 }
 
 int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
-- 
2.53.0-Meta

