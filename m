Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FED329C48;
	Sat, 16 May 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956646; cv=none; b=gBz7Mswf7irQTD4dLoeWHVKP4rjBMH6DkqeuEwg4+ns4GcJCIrPNnaosAa6nnWNFucdgwCpkXjeefsQIfXR+f2RMuRpBep/5k67fbxN37UIT0AyawHZqXbJEeLG8qIrY4TawoYdMLYXKr0OvWtp4/dbsp08ddm1NIwxu1PCP0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956646; c=relaxed/simple;
	bh=rRV3S8Zs8/YBc8+5AI5kB/a9fxfrWlXoj5Vu2qtKMvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iw6ib/RMhfC7MDnmLUACVtGXvBXgGfl0nvwyolW72mVEbFTeKO/VT7E87AIOET2ctHY4wOlyW7XmCHqs/4XAZgKq8dYENGhFI8eJRrJp0hmpmZd8N7KO64+JaGqtI8uECqWpT5NswXfxcv9s2BW93m4BIwcZknZy7pLk7dpYDHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK+xuiP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK+xuiP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8A6C2BCC7;
	Sat, 16 May 2026 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956646;
	bh=rRV3S8Zs8/YBc8+5AI5kB/a9fxfrWlXoj5Vu2qtKMvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SK+xuiP4C2SaxDcfue3JBq/5hYij+Ee22zfOQ6LlqvqDk9kYdu9pGzHSPQTTBbInH
	 lI8AwtBpUNP8Q0J0pMNJecqfzfme9hlNDukGaab3cU/AbSBtk/PsOJshIpPKMV1ltG
	 s2ZhlE2SkmzDXMuWsK73RblUfd4XVDWJ2KEAfoXutOpRNkNuLXi41DA70efNBhp0BV
	 iJzYi8PjHAh8JJ60zu3DmBB4Is+AkFOaFQ4ml1LfexUKjMQYwM2dqol68KXNHR5Tzd
	 VgYjMPTiiFwo02VZz+uGa9qo51mxjy9tBN5v4HMzinTJGVPZ2AVZr4kLktU/0GuCrF
	 GflR/TeenGipw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Sat, 16 May 2026 11:36:46 -0700
Message-ID: <20260516183712.81393-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an array for the per-region per-probe positive samples count.  For
simple and efficient implementation, add a limit to the number of data
probes and set the array to support only the limited number of counters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  4 ++++
 mm/damon/core.c       | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 32005b8b1f8cd..9e70239e5305f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -16,6 +16,8 @@
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION_SZ	PAGE_SIZE
+/* Maximum number of monitoring probes. */
+#define DAMON_MAX_PROBES	(4)
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
@@ -52,6 +54,7 @@ struct damon_size_range {
  * @nr_accesses:	Access frequency of this region.
  * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
  *			each sampling interval.
+ * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -80,6 +83,7 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned int nr_accesses_bp;
+	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
 	unsigned int age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 15f2795a1156f..e5667660b4cd9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -225,6 +225,7 @@ static void damon_verify_new_region(unsigned long start, unsigned long end)
 struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
+	int i;
 
 	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
@@ -235,6 +236,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.end = end;
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
@@ -2754,12 +2757,17 @@ static void damon_merge_two_regions(struct damon_target *t,
 		struct damon_region *l, struct damon_region *r)
 {
 	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
+	int i;
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
+	/* todo: do this for only installed probes */
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
+				* sz_r) / (sz_l + sz_r);
 	damon_verify_merge_two_regions(l, r);
 	damon_destroy_region(r, t);
 }
@@ -2882,6 +2890,8 @@ static void damon_split_region_at(struct damon_target *t,
 	new->last_nr_accesses = r->last_nr_accesses;
 	new->nr_accesses_bp = r->nr_accesses_bp;
 	new->nr_accesses = r->nr_accesses;
+	/* todo: do this for only installed probes */
+	memcpy(new->probe_hits, r->probe_hits, sizeof(r->probe_hits));
 
 	damon_insert_region(new, r, damon_next_region(r), t);
 }
-- 
2.47.3
