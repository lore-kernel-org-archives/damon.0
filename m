Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B3309EE2;
	Fri, 11 Sep 2026 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089226; cv=none; b=cMfWSQojxwOUdpG2Tw9fF2KGuP0ruhIsBmifLJtgWqi++QVfikf0Pj5kRZlEtsHIw2udo47yh7vIJQf1+mGcUT60JEblrrEgHtmuqLMjtr6W5jNF76BrSVyhu7VvVJqEGCA2DZzEba22UIUKNsIuAg472jSCSV8YgRcnTzM3KyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089226; c=relaxed/simple;
	bh=VIRwDW5Bnn+f4LK9ge2ikIi3U3R23ZRwTfUSF9xM5Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu2xmfYGAWSazS+2phoEeRAMyX9ES47DIqlQtRooOZZMRz+ITtf+dSRZOoBye/Z7rg63f2DfzSzGC36bwDa9nIYfs7d6+AXz3x3KLkua261Gcoyh/j1FVcPd2HarqvtprYPaKrhxfBJi1hq5xW9Difve1cEPNTA06BsqtXeDABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtjLo2Yv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtjLo2Yv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B861F00898;
	Fri, 11 Sep 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089218;
	bh=4hmPSIzi4KB41ZqDb3eohWI9E1LBjoQeneU0W0fngWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtjLo2Yv5sV7wQGr9awNaKU+AZoPjMwjjHYtqeQhNhzXwrN0xIkYIGD3jtcjgCwAC
	 0opaAlx60OVRwcV9H48GXgSH/GpKI91OWngLNM8U6dsldwpsCLuZzK6oyfv907zeHj
	 OzRhLdyQ6c6wGVqDTUuHIx2ZAcMOqmYugqQIFjhZfYine0lh9oF3EIlyAKi3oLev8L
	 MDgQkpzc8raayd2SSvq50BiOf0YE3gLoWJVds5QAegHQaixvmrEYwIzyIfBwxbo9aw
	 VF/ijcKzptmlMU2eZIWy6aGygEDKrEkQ8GpGBeD60O23S3CazribL+N8lifcdrLahK
	 erKMkCLIzuVJw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 2/7] mm/damon/core: extend probe_hits_wsum() for moving sum based calculation
Date: Thu, 10 Sep 2026 18:13:23 -0700
Message-ID: <20260911011330.93678-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911011330.93678-1-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_probe_hits_wsum() is being called only in aggregation time.  In
future, it could also be used by DAMOS.  In this case, since DAMOS uses
its own apply_interval, it could be called in sampling time.  Then using
the not yet fully aggregated probe_hits could result in suboptimum
outcomes.  Extend damon_probe_hits_wsum() to get the weighted sum based
on moving sum to prepare the DAMOS usage.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 8 ++++++--
 mm/damon/paddr.c      | 2 +-
 mm/damon/vaddr.c      | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ef99ff778ae10..4a36f344bbc7c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1073,7 +1073,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 		struct damon_ctx *ctx);
 unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 		struct damon_ctx *ctx);
-unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
+unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last, bool mv,
 		struct damon_ctx *ctx);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 06cf2ab7e97d7..50e0f9407db2b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -469,11 +469,12 @@ static bool damon_is_last_region(struct damon_region *r,
  * damon_probe_hits_wsum() - Returns probe hits weighted sum of a region.
  * @r:		region to get the weighted sum of.
  * @last:	if the request is for last-window aggregated probe hits.
+ * @mv:		use moving sum.
  * @ctx:	context of &r.
  *
  * Return: the weighted sum of probe hits of the region.
  */
-unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
+unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last, bool mv,
 		struct damon_ctx *ctx)
 {
 	struct damon_probe *probe;
@@ -483,6 +484,9 @@ unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last,
 	damon_for_each_probe(probe, ctx) {
 		if (last)
 			sum += r->last_probe_hits[i++] * probe->weight;
+		else if (mv)
+			sum += damon_probe_hits_mvsum(i++, r, ctx) *
+				probe->weight;
 		else
 			sum += r->probe_hits[i++] * probe->weight;
 	}
@@ -3456,7 +3460,7 @@ static unsigned int damon_merge_score(struct damon_region *r, bool last,
 		struct damon_ctx *ctx, bool use_probe_hits)
 {
 	if (use_probe_hits)
-		return damon_probe_hits_wsum(r, last, ctx);
+		return damon_probe_hits_wsum(r, last, false, ctx);
 	if (last)
 		return r->last_nr_accesses;
 	return r->nr_accesses;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d7c81829445ba..b8f4d28165dd7 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -202,7 +202,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 				folio_put(folio);
 			if (return_max_wsum)
 				max_wsum = max(damon_probe_hits_wsum(r, false,
-							ctx), max_wsum);
+							false, ctx), max_wsum);
 		}
 	}
 	return max_wsum;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 9a38dc89a156e..4aecf34e39be2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -704,7 +704,7 @@ static unsigned int damon_va_apply_probes(struct damon_ctx *ctx,
 			__damon_va_apply_probes(ctx, mm, r);
 			if (return_max_wsum)
 				max_wsum = max(damon_probe_hits_wsum(r, false,
-							ctx), max_wsum);
+							false, ctx), max_wsum);
 		}
 		if (mm)
 			mmput(mm);
-- 
2.47.3
