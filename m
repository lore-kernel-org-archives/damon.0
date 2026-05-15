Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933134404A;
	Fri, 15 May 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805888; cv=none; b=Io897fqpvLPUw3Ea0ISwz5CS1nTyoivZhQwZtXzPLFzK0p9FKhI77MLoxzsKSCqryk7p83xbQbLI//UE//6yunEjYEKjc9El1q/fN1sllz+ScsfldFqn15sbvjEDww2ll+ReJqcXOzYuxJfv+I6xtycnxs7xjmZIpf9UfkdPsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805888; c=relaxed/simple;
	bh=nUMg5BO3GWRW+rFzmCKpLHBjk9zjtVe3/poBms+RH3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+seXWv/GvqYMU/JnJ3eeGBB2KOHgXik1L4gmK0+0P3Hl4ovHHX7lrwA3G+W8Eflt9jLh8dUf4vfON8r0wYuQ4rFZ8363LO1tVbsPtHXownTLr2v1kWzkcWnMWuY9EVWlsqNPck7dmPuxRcsjH+YBRbEDe3IPmx8v8Zy0EtzG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJy8/cVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJy8/cVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F6FC2BCC9;
	Fri, 15 May 2026 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805887;
	bh=nUMg5BO3GWRW+rFzmCKpLHBjk9zjtVe3/poBms+RH3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJy8/cVJ81Ae+2eCoSi4N8ohqYC0QqIvbbjba8mrFJOd/qQkvPhB4yjhvbIwjqbhw
	 UCheQXHCUszPehMT6MEus2ROhKegttMtt/GHOEqMmRsEVVepNcVOelR8fRxJlo8alI
	 zLi+heVms3v8nv0gnstcOKjaIDDEHeYkUeEfcvjpdh0QviJxJmy3anIhXhDULEN7en
	 W6/vEXumqA1yiJyAH9k0Cr5KmM+h73tGLjLQtG5W7KKrj8Ra11FWfQJA9e5IZWKacs
	 oB/rSPWu97y/lKHb+dJJqFovmqzkP5fkYSXxESmlGXjx+W2KmSEFSskTYrndslnW6n
	 sMbIwpOvcWszg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Thu, 14 May 2026 17:44:06 -0700
Message-ID: <20260515004433.128933-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
 include/linux/damon.h | 4 ++++
 mm/damon/core.c       | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9c2576f103767..bf78ad849a9be 100644
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
index 15f2795a1156f..f6b4beb4b8ecd 100644
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
-- 
2.47.3
