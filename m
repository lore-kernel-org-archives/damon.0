Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63E485CCB;
	Fri, 11 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134920; cv=none; b=Xo36/3Qysr/ftXiouxl5st2lBw+f5JL8xnZKUu69X7jRRyZZ88sS4t6WO7HKzDA/FDGhNFlE+Zdhnds5aWJTEDOFl86TvRe7i9o167f0FmHLoPREr0/S6WkkVtIohrW0SP/ACJ9XpHDE0NS4u57KcUnq/e1plLQSdzCTU+YHsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134920; c=relaxed/simple;
	bh=7AxxHTrkdV7mwTgoe3iAAfcfGgU5tzyVxHlUmy8up78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgo0bBPEZ36nCeBFamIfOk2p7YFw58/k8BajWA4yNj4e3FawDwxU7mc8SNylBoOP5o36ysPADhY5k/Fdouzysb6SXEmExh+x2sT3d0KMDAhXXLQkZ0CcijOcfDwKDfcJyET/27UshcnezrrrN9RBe5ERuhxNQ6m0TVsdvW4/W/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV03SwfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV03SwfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0411F00893;
	Fri, 11 Sep 2026 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134919;
	bh=c05rFO8XMq4oV/KPD78qqBcGhHhl2uV7qApXR0TPJMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KV03SwfYdnpbLX6lb4huunwxAG8GE1PiiEan5RCu1BqFex6/EsnT4uXH3BjNkj/rH
	 jnsjyc6W+hfCi68uYZkyyIe6lp/YQw3EFKdSkIZSRhGwqp2YeuPSe5mm+MN/v8o6bE
	 nGxw7It30650Xk8BB36trzRGaSrGv1M2ZHSPsRTUnfVNFeFm4kOo+yRmhy0N5QqxqF
	 oYJ2i5QIz8rxNNsecf+7lwcdzfc/I9Bm+ggGwrBOFY06KcDbvkv++nMCs2XQe/guXm
	 nRjmy7iZ6sViLCJrgj4iG1tEkB+6ligNxmlU+vUM64afXsw48a65ces2eN01jkOyy8
	 Q4iwmpFgzj45Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/7] mm/damon/core: extend probe_hits_wsum() for moving sum based calculation
Date: Fri, 11 Sep 2026 06:55:04 -0700
Message-ID: <20260911135510.96914-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
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
index 9e84bdeb5616d..abb529771091c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1075,7 +1075,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
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
index 79195026b903a..5abfabaa339e0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -208,7 +208,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 				folio_put(folio);
 			if (return_max_wsum)
 				max_wsum = max(damon_probe_hits_wsum(r, false,
-							ctx), max_wsum);
+							false, ctx), max_wsum);
 		}
 	}
 	return max_wsum;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 7063356370c34..d5dde97b3cd0d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -711,7 +711,7 @@ static unsigned int damon_va_apply_probes(struct damon_ctx *ctx,
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
