Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440003F12E2
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146108; cv=none; b=rILgO3Cv1FPrz4Oa60a67vV0Sb0XvkIpUAwnUXtbEO/s8G7v6ztRHCTXY1I0N5o3lX9fvqAxbBwiEQJY/t1hpMATn+XPfKSFwJ7DbShC915AyOY/l0R6EsBT0Jcti9dQCiKZah2DiPiLetS5JSIW8323HFRp+5ityGRvCNZgkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146108; c=relaxed/simple;
	bh=qDYP3S4OxJ8bbbMu8gz1C4d6dy+Jr7lILaJZY+QNc28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESqeIrQviDU3jFv9yRmQXZLgtvJnFS3DqdC8jOCBF1lY5Om50fs4U1h6bJWI1aVHNyyKmyYqC10tmSP/1gWELyxugNc8avkeJncbSUPkUJRLUqJWLPo1VQ6p+MBVWxGpVE0QoZRucN7xXxE2sMGQJSO+ax404hG3Tyq64rU+IuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pu+k9Hkn; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pu+k9Hkn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785146095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FgYVRL1tlXQScTSC3dysRI0YQkKByHkMOxweBGBsepM=;
	b=Pu+k9HknezyVEwEXvqKoksxaMAHsADHucnYz8DJ26j7yYxOB1esAumkh/Ph9j3igBv82FQ
	OolxG26WW9AzUc2RLVk40iWO1Oh5J2bN+cWwEyWiEMIN+qvt5LrbMa0tbKOJzOZIRW/DhW
	I6ZjLElXBXFDMZXcpKDGm2jqAydhG4Q=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] mm/damon/core: cover discrete System RAM areas with per-range regions
Date: Mon, 27 Jul 2026 17:54:22 +0800
Message-ID: <20260727095429.143527-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jiayuan Chen <jiayuan.chen@shopee.com>

damon_set_region_system_rams_default(), introduced by commit 70d8797c15d6
("mm/damon: introduce damon_set_region_system_rams_default()"), is used by
DAMON_RECLAIM, DAMON_LRU_SORT and DAMON_STAT to set the default monitoring
target address range covering all 'System RAM' when the user does not
specify a range.  It walks the 'System RAM' resources but keeps only the
start of the first resource and the end of the last one, and then sets a
single monitoring region spanning that whole [first_start, last_end] range.

On systems whose RAM is split into discrete areas that are far apart in the
physical address space, that single region also covers the holes between
them.  For example:

  $ sudo cat /proc/iomem | grep RAM
  00001000-0009ffff : System RAM
  00100000-4848c017 : System RAM
  4848c018-48550c57 : System RAM
  48550c58-48551017 : System RAM
  48551018-48615c57 : System RAM
  48615c58-48616017 : System RAM
  48616018-486dac57 : System RAM
  486dac58-4e563017 : System RAM
  4e563018-4e627c57 : System RAM
  4e627c58-4ef39017 : System RAM
  4ef39018-4ef3f057 : System RAM
  4ef3f058-4efe6017 : System RAM
  4efe6018-4efec057 : System RAM
  4efec058-50247fff : System RAM
  50317000-56720fff : System RAM
  56722000-59c19fff : System RAM
  6bbfe000-6bbfefff : System RAM
  6bc00000-777fffff : System RAM
  100000000-1007effffff : System RAM
  67e80000000-77e7fffffff : System RAM

Here the last two areas (about 1TB starting at 4GiB, and about 1.1TB
starting at ~6.5TB) are separated by a ~5.5TB hole, and the single-region
setup makes DAMON treat that entire hole as if it were memory.

This is harmful in a few ways.  The monitoring target regions are limited
by max_nr_regions, so regions that fall into the hole waste that budget and
leave fewer regions for the real RAM, coarsening the adaptive regions and
degrading the monitoring accuracy.  In addition, DAMOS actions on the paddr
operations set walk such a region page by page, so a region that covers the
hole is walked for its entire (empty) span on every application.

Set a separate monitoring region for each discrete System RAM area instead,
coalescing only truly adjacent (no gap in between) resources into one
range, so holes between the areas are excluded.  The reported *start and
*end still carry the overall first-start and last-end, so the user-visible
default range reported via the module parameters is unchanged.

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/damon/core.c | 116 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 34 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 760559d495b3..8dd4a0d22064 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -4394,22 +4394,14 @@ static int kdamond_fn(void *data)
 }
 
 struct damon_system_ram_range_walk_arg {
-	bool walked;
-	struct resource res;
+	unsigned long addr_unit;
+	/* NULL in the counting-only pass */
+	struct damon_addr_range *ranges;
+	unsigned int nr_ranges;
+	unsigned long prev_end;
+	bool has_prev;
 };
 
-static int damon_system_ram_walk_fn(struct resource *res, void *arg)
-{
-	struct damon_system_ram_range_walk_arg *a = arg;
-
-	if (!a->walked) {
-		a->walked = true;
-		a->res.start = res->start;
-	}
-	a->res.end = res->end;
-	return 0;
-}
-
 static unsigned long damon_res_to_core_addr(resource_size_t ra,
 		unsigned long addr_unit)
 {
@@ -4423,23 +4415,66 @@ static unsigned long damon_res_to_core_addr(resource_size_t ra,
 	return ra / addr_unit;
 }
 
-static bool damon_find_system_rams_range(unsigned long *start,
-		unsigned long *end, unsigned long addr_unit)
+static int damon_system_ram_walk_fn(struct resource *res, void *arg)
+{
+	struct damon_system_ram_range_walk_arg *a = arg;
+	unsigned long start = damon_res_to_core_addr(res->start, a->addr_unit);
+	unsigned long end = damon_res_to_core_addr(res->end + 1, a->addr_unit);
+
+	if (end <= start)
+		return 0;
+	/*
+	 * 'System RAM' resources are visited in the ascending address order.
+	 * Coalesce only truly adjacent (no gap in between) resources into one
+	 * range, so that any hole between discrete System RAM areas is kept out
+	 * of the resulting ranges.
+	 */
+	if (a->has_prev && a->prev_end == start) {
+		a->prev_end = end;
+		if (a->ranges)
+			a->ranges[a->nr_ranges - 1].end = end;
+		return 0;
+	}
+	if (a->ranges) {
+		a->ranges[a->nr_ranges].start = start;
+		a->ranges[a->nr_ranges].end = end;
+	}
+	a->nr_ranges++;
+	a->prev_end = end;
+	a->has_prev = true;
+	return 0;
+}
+
+/*
+ * Find all 'System RAM' areas and return them as an array of coalesced
+ * damon_addr_range.  On success, *ranges points to a kvmalloc'ed array that the
+ * caller should kvfree(), and the number of ranges is returned.  Returns 0 if
+ * no System RAM is found, or a negative error code on failure.
+ */
+static int damon_find_system_rams(struct damon_addr_range **ranges_out,
+				  unsigned long addr_unit)
 {
-	struct damon_system_ram_range_walk_arg arg = {};
+	struct damon_system_ram_range_walk_arg arg = { .addr_unit = addr_unit };
+	struct damon_addr_range *ranges;
 
+	/* First pass: count the coalesced ranges. */
 	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
-	if (!arg.walked)
-		return false;
-	*start = damon_res_to_core_addr(arg.res.start, addr_unit);
-	*end = damon_res_to_core_addr(arg.res.end + 1, addr_unit);
-	if (*end <= *start)
-		return false;
-	return true;
+	if (!arg.nr_ranges)
+		return 0;
+	ranges = kvmalloc_objs(*ranges, arg.nr_ranges, GFP_KERNEL);
+	if (!ranges)
+		return -ENOMEM;
+	/* Second pass: fill in the coalesced ranges. */
+	arg.ranges = ranges;
+	arg.nr_ranges = 0;
+	arg.has_prev = false;
+	walk_system_ram_res(0, -1, &arg, damon_system_ram_walk_fn);
+	*ranges_out = ranges;
+	return arg.nr_ranges;
 }
 
 /**
- * damon_set_region_system_rams_default() - Set the region of the given
+ * damon_set_region_system_rams_default() - Set the regions of the given
  * monitoring target as requested, or to cover all 'System RAM' resources.
  * @t:		The monitoring target to set the region.
  * @start:	The pointer to the start address of the region.
@@ -4449,9 +4484,11 @@ static bool damon_find_system_rams_range(unsigned long *start,
  *
  * This function sets the region of @t as requested by @start and @end.  If the
  * values of @start and @end are zero, however, this function finds 'System
- * RAM' resources and sets the region to cover all the resource.  In the latter
- * case, this function saves the start and the end addresseses of the first and
- * the last resources in @start and @end, respectively.
+ * RAM' resources and sets the monitoring target regions to cover them.  Each
+ * discrete System RAM area becomes a separate region, so holes between them
+ * (e.g., on multi-socket or CXL systems) are excluded from the monitoring.  In
+ * the latter case, this function saves the start and the end addresses of the
+ * first and the last resources in @start and @end, respectively.
  *
  * Return: 0 on success, negative error code otherwise.
  */
@@ -4460,14 +4497,25 @@ int damon_set_region_system_rams_default(struct damon_target *t,
 			unsigned long addr_unit, unsigned long min_region_sz)
 {
 	struct damon_addr_range addr_range;
+	struct damon_addr_range *ranges;
+	int nr_ranges, err;
 
-	if (!*start && !*end &&
-		!damon_find_system_rams_range(start, end, addr_unit))
-		return -EINVAL;
+	if (*start || *end) {
+		addr_range.start = *start;
+		addr_range.end = *end;
+		return damon_set_regions(t, &addr_range, 1, min_region_sz);
+	}
 
-	addr_range.start = *start;
-	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, min_region_sz);
+	nr_ranges = damon_find_system_rams(&ranges, addr_unit);
+	if (nr_ranges < 0)
+		return nr_ranges;
+	if (!nr_ranges)
+		return -EINVAL;
+	*start = ranges[0].start;
+	*end = ranges[nr_ranges - 1].end;
+	err = damon_set_regions(t, ranges, nr_ranges, min_region_sz);
+	kvfree(ranges);
+	return err;
 }
 
 /**
-- 
2.43.0

