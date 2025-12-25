Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE942222A0
	for <damon@lists.linux.dev>; Thu, 25 Dec 2025 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766704898; cv=none; b=KVGTg+H26omxTe9VZnxpyGeLu+GNqa8TW+fcV//RMwns759FopUiv485oYl3sKF9DTHCd9Y3U6uBO9ULMvOMpWGP4IrQzTrPnOrTfR1z5nQE8svV04gfnZbahCwiRY6t1OFHWxxtrRSE8rXOal0K/iIRhIHlwLyZfMwZ9iZWv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766704898; c=relaxed/simple;
	bh=6sGApEq2wAUJdIA4naJGX1M4w9kayzWqSsFuKwnnP5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwBvcA3YmiJt/AxQrVpqkpczGrJMSFTvZGpBnyio/7TY4dt3GkEMm8Dlr2YxyPRBgn06vVV5ifD4vnEL1ilZyD2ylKfuVzOXSD8AgTHHvGMjCpJipvdvF647O+Jp0ykdumN8qFDuIF9g+LFg5SgUN2oQXRU883eUy7zwugBOLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V1Ud422M; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V1Ud422M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766704895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0ch+6yI2tUKJ64buXx3qfBV9aEKwt068abp9sUTgOs=;
	b=V1Ud422Myo3TSvF6ot7WDW/igs4tzP3Spgllu6/P7t+yRgxB7sI+zS3mDjX1I21L2u889u
	tqjQR3Orgezg0Y9YJj/O86Yg0JdwIfK39WId2zS0EWkLKrgb9HIm3GEFOB+HcLG+3E5+Sb
	Gr+pB7+MPupund5xTwfR5NYHdHmprNI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] memcg: expose mem_cgroup_ino() and mem_cgroup_get_from_ino() unconditionally
Date: Thu, 25 Dec 2025 15:21:10 -0800
Message-ID: <20251225232116.294540-3-shakeel.butt@linux.dev>
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>
References: <20251225232116.294540-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the CONFIG_SHRINKER_DEBUG guards around mem_cgroup_ino() and
mem_cgroup_get_from_ino(). These APIs provide a way to get a memcg's
cgroup inode number and to look up a memcg from an inode number
respectively.

Making these functions unconditionally available allows other in-kernel
users to leverage them without requiring CONFIG_SHRINKER_DEBUG to be
enabled.

No functional change for existing users.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 4 ----
 mm/memcontrol.c            | 2 --
 2 files changed, 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1c4224bcfb23..77f32be26ea8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -836,14 +836,12 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
 
-#ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
 	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
 }
 
 struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
-#endif
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
@@ -1308,7 +1306,6 @@ static inline struct mem_cgroup *mem_cgroup_from_private_id(unsigned short id)
 	return NULL;
 }
 
-#ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
 	return 0;
@@ -1318,7 +1315,6 @@ static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 {
 	return NULL;
 }
-#endif
 
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 25ad8433df2e..e85816960e38 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3620,7 +3620,6 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return mem_cgroup_from_private_id(id);
 }
 
-#ifdef CONFIG_SHRINKER_DEBUG
 struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 {
 	struct cgroup *cgrp;
@@ -3641,7 +3640,6 @@ struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
 
 	return memcg;
 }
-#endif
 
 static void free_mem_cgroup_per_node_info(struct mem_cgroup_per_node *pn)
 {
-- 
2.47.3

