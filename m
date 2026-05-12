Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BC13B992C;
	Tue, 12 May 2026 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596619; cv=none; b=OA+epjyfhvHnAKrEEaZk9eLLWHnpkKAsiJH/p4QYMbxyJip3DLokb3SysXmAjItgD1zjg5jWFGWcgAtvJ9m8gBJXB344zhhmjWNPu0kYdf8/IfG/7bfmN712hrUCz4Y/wGwD3OsAofTX0B8+hYvMnPIXv2i3oAHB7DAmKsjecMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596619; c=relaxed/simple;
	bh=sqTfJo5eyZfIgPieldGgPDsesotOxkPfGODr6Semhvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBHno5655nv+5/4t/3BEdw3dRfHvy+SRqdFjUXcU0Mw9LPD0mTOnoKexaCkTYgKeltN5NK3kSwC58rccx/I03x0At5bfxCM+LDyn5edDNTtkYlwWYROtlklfPtlJjfryKJc4YwqjrnRSiY1LhCI44BVAbd6UloGL345OglHAFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvCucv5B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvCucv5B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0DBC2BCB0;
	Tue, 12 May 2026 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778596619;
	bh=sqTfJo5eyZfIgPieldGgPDsesotOxkPfGODr6Semhvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvCucv5BnfwStN8bnkbrx8qW6MAFLmXHFk8Lz4P3dUPAmmvG6cRLR9twBgi22e7yy
	 blKIN3ZS2qREWyurMfrguoqHa1cu14dobPyOvvrJO4EWFBX1pkKDtxlH7ikwZ9IKD8
	 ahd6Us4+KjL3By0ez9gIEQjIosh/TKnxb1uR8Gm6NZ7MTxTvxpdzjMa3nCBabFfTsT
	 ivmC5sIKc1VmdxpRIvNwzVZiwGKYmrWc5pAyEzCbSH8nN0dxzKrtmi5IB6l+a6wizo
	 skSwbszm/+iJqfOxusaJvqvtKi/1MrO+XRrR+2qICEeBML55B+zvmZsElPRmhhaoBK
	 TRAwQ6xiJwUTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/28] mm/damon/core: introduce damon_region->probe_hits
Date: Tue, 12 May 2026 07:36:20 -0700
Message-ID: <20260512143645.113201-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512143645.113201-1-sj@kernel.org>
References: <20260512143645.113201-1-sj@kernel.org>
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
index 95b2c508a63ea..19b780bfab051 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -17,6 +17,8 @@
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION_SZ	PAGE_SIZE
+/* Maximum number of monitoring probes. */
+#define DAMON_MAX_PROBES	(4)
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
@@ -47,6 +49,7 @@ struct damon_size_range {
  * @nr_accesses:	Access frequency of this region.
  * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
  *			each sampling interval.
+ * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
@@ -75,6 +78,7 @@ struct damon_region {
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
 	unsigned int nr_accesses_bp;
+	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
 	unsigned int age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 240cae1420c12..72acdeb8c478e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -229,6 +229,7 @@ static void damon_verify_new_region(unsigned long start, unsigned long end)
 struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 {
 	struct damon_region *region;
+	int i;
 
 	damon_verify_new_region(start, end);
 	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
@@ -239,6 +240,8 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
 	region->ar.end = end;
 	region->nr_accesses = 0;
 	region->nr_accesses_bp = 0;
+	for (i = 0; i < DAMON_MAX_PROBES; i++)
+		region->probe_hits[i] = 0;
 	INIT_LIST_HEAD(&region->list);
 
 	region->age = 0;
-- 
2.47.3
