Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60924291C;
	Mon, 26 May 2025 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748293785; cv=none; b=naf5hWIQLEll8ogeVhaDkw2uuoqrxKMDwkj+VgDo6hVAGbIeO72VAGXAYtoh1667wE08Yc9GNvpyHgRd+CTk/Ka3Zx/dWhkks1frLrdOaijLugz+SFUiZ1Z1yJRaRO/50x7+UWYtR4smDMVptP6KpftvD/4zoJjGSwJRHsicoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748293785; c=relaxed/simple;
	bh=99xhNIYjrRRHYJ4jwFEOfM7WQzxpqK4uF5YCwTKBiUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjkpRC+sov/lnHT8yMcQDiGMss2Oiyv5dSqksqwqCGZfh+0E1c7aX24W+O6ZTvq8lZW/hLAPCLMQcdu1J31vT+pCejEcede27eVojK6RChBepgswgeTH3gTBi7BbNLtu04Ky1lfREkVaYmXoIt38kJ4oQ7WyQcAyqSnnDSwof/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elTcgBEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elTcgBEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4699CC4CEE7;
	Mon, 26 May 2025 21:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748293784;
	bh=99xhNIYjrRRHYJ4jwFEOfM7WQzxpqK4uF5YCwTKBiUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elTcgBEM0yQs3NazQgBkA22UjHhWMla8mf0W/YUXruLw5IfIMCPMBEkfcC4pbGNUu
	 8x6uZkzZsCFu20h1k21YhN9GDrbWSGWvVj9TJFpjWBeevTMJfRuh4WQJ5Iu3Grc+ao
	 jwi/8tV2Q28N28vuxhlQCGG6gagRE1PHgflmb6+lncdSRn4ZUU5JDQXQ23fwiWySbq
	 oU86JkB1np33KdTdKRM9IvF12RrV3I9TohfeQqgBSpXbh5ovbRKSGf3hYElcQovMYY
	 LTMnIr1gXBhnp3tWWOXCBM2OcqaorTy4rlX1WOVeL42d2uNrHrnDYHUlGWk34qGO9A
	 mOtEZp7F/BjaA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] mm/damon/stat: calculate and expose idle time percentiles
Date: Mon, 26 May 2025 14:09:35 -0700
Message-Id: <20250526210936.2744-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526210936.2744-1-sj@kernel.org>
References: <20250526210936.2744-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing how much memory is how cold can be useful for understanding
coldness and utilization efficiency of memory.  The raw form of DAMON's
monitoring results has the information.  Convert the raw results into
the per-byte idle time distributions and expose it as percentiles metric
to users, as a read-only DAMON_STAT parameter.

In detail, the metrics are calculated as follows.  First, DAMON's
per-region access frequency and age information is converted into
per-byte idle time.  If access frequency of a region is higher than
zero, every byte of the region has zero idle time.  If the access
frequency of a region is zero, every byte of the region has idle time as
the age of the region.  Then the logic sorts the per-byte idle times and
provides the value at 0/100, 1/100, ..., 99/100 and 100/100 location of
the sorted array.

The metric can be easily aggregated and compared on large scale
production systems.  For example, if an average of 75-th percentile idle
time  of machines that collected on similar time is two minutes, it
means the system's 25 percent memory is not accessed at all for two
minutes or more on average.  If a workload considers two minutes as unit
work time, we can conclude its working set size is only 75 percent of
the memory.  If the system utilizes proactive reclamation and it
supports coldness-based thresholds like DAMON_RECLAIM, the idle time
percentiles can be used to find a more safe or aggressive coldness
threshold for aimed memory saving.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index f9ae44db265b..7ef13ea22221 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -33,6 +33,11 @@ module_param(estimated_memory_bandwidth, ulong, 0400);
 MODULE_PARM_DESC(estimated_memory_bandwidth,
 		"Estimated memory bandwidth usage in bytes per second");
 
+static unsigned long memory_idle_ms_percentiles[101] __read_mostly = {0,};
+module_param_array(memory_idle_ms_percentiles, ulong, NULL, 0400);
+MODULE_PARM_DESC(memory_idle_ms_percentiles,
+		"Memory idle time percentiles in milliseconds");
+
 static struct damon_ctx *damon_stat_context;
 
 static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
@@ -50,6 +55,72 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 		MSEC_PER_SEC / c->attrs.aggr_interval;
 }
 
+static unsigned int damon_stat_idletime(const struct damon_region *r)
+{
+	if (r->nr_accesses)
+		return 0;
+	return r->age + 1;
+}
+
+static int damon_stat_cmp_regions(const void *a, const void *b)
+{
+	const struct damon_region *ra = *(const struct damon_region **)a;
+	const struct damon_region *rb = *(const struct damon_region **)b;
+
+	return damon_stat_idletime(ra) - damon_stat_idletime(rb);
+}
+
+static int damon_stat_sort_regions(struct damon_ctx *c,
+		struct damon_region ***sorted_ptr, int *nr_regions_ptr,
+		unsigned long *total_sz_ptr)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_region **region_pointers;
+	unsigned int nr_regions = 0;
+	unsigned long total_sz = 0;
+
+	damon_for_each_target(t, c) {
+		/* there is only one target */
+		region_pointers = kmalloc_array(damon_nr_regions(t),
+				sizeof(*region_pointers), GFP_KERNEL);
+		if (!region_pointers)
+			return -ENOMEM;
+		damon_for_each_region(r, t) {
+			region_pointers[nr_regions++] = r;
+			total_sz += r->ar.end - r->ar.start;
+		}
+	}
+	sort(region_pointers, nr_regions, sizeof(*region_pointers),
+			damon_stat_cmp_regions, NULL);
+	*sorted_ptr = region_pointers;
+	*nr_regions_ptr = nr_regions;
+	*total_sz_ptr = total_sz;
+	return 0;
+}
+
+static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
+{
+	struct damon_region **sorted_regions, *region;
+	int nr_regions;
+	unsigned long total_sz, accounted_bytes = 0;
+	int err, i, next_percentile = 0;
+
+	err = damon_stat_sort_regions(c, &sorted_regions, &nr_regions,
+			&total_sz);
+	if (err)
+		return;
+	for (i = 0; i < nr_regions; i++) {
+		region = sorted_regions[i];
+		accounted_bytes += region->ar.end - region->ar.start;
+		while (next_percentile <= accounted_bytes * 100 / total_sz)
+			memory_idle_ms_percentiles[next_percentile++] =
+				damon_stat_idletime(region) *
+				c->attrs.aggr_interval / USEC_PER_MSEC;
+	}
+	kfree(sorted_regions);
+}
+
 static int damon_stat_after_aggregation(struct damon_ctx *c)
 {
 	static unsigned long last_refresh_jiffies;
@@ -61,6 +132,7 @@ static int damon_stat_after_aggregation(struct damon_ctx *c)
 	last_refresh_jiffies = jiffies;
 
 	damon_stat_set_estimated_memory_bandwidth(c);
+	damon_stat_set_idletime_percentiles(c);
 	return 0;
 }
 
-- 
2.39.5
