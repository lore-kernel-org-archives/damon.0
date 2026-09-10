Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F82449BD98;
	Thu, 10 Sep 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049942; cv=none; b=hj/npz6o5dtB2VnxxrZmAOt1IUJrs0rY+zvD8uRojws2rJqHXduF9AiMun8w64UAE9uK1yPZ/FbuS42MDL5DjF617RLcXqWA4W2C+41ibwOWN2b2GcvIZV3dFwJLFOj0dcN63p0iCZSCnRjROACuvWxc6tCztfJzKF3Pv59Qi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049942; c=relaxed/simple;
	bh=mX4Rm5gtqdT+P17ZxUZ/MvnsjwSmQIw1kotJP1i7qeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhtIgX4y6MeHN9hMhRaoBh0vxwWAOZykX+uCfw5auZxhPaR7iuACIazHkFqg6VQ+9e9K2lHA3zhAxTyxFr1NZUyMfcnVnm5Fn/TnYyYPa4VDWRNuk2RdbqKiYo8XPh8Yegwt/GJxJvvWzvZ1fullLN/rKS+GwyDSdMw76yBnVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyak9dtw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyak9dtw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34221F00898;
	Thu, 10 Sep 2026 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049941;
	bh=//P9EELBAWJiTTEfH8OFzItA8Z77D6zhflq7gYb2N2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nyak9dtwBifrw34nlqILyA/okiRc91+DBtJ39xCKbVV14Yiq1/h0WzuiJ/iF9rc7Z
	 mBV9wMUXZtC2N5cwd7avFdF9dFnaF9fSWuT6gGDGu1dTNP063p/i59JMEcJpQ++sKZ
	 ML4tOd79iQ8xe2jM1UWbXBHNQohMBsCjS3bBKOXj7WGmNDFfvyRbKQWTJIWADOWOfW
	 /zdXWQiZ6xhXwJznqX0nrp/pTs+x76fKp0vkfsu5lKyhcYYgvm0ocS5OSRey6yUb2H
	 OdBeoSeqQoYEQSRGIxV0NHDIOOhSx/BPN+SXwo2FfbYghBZp3MbH3RZQVup37QmB3L
	 sGgYqXx+6MRJw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/7] mm/damon/core: extend probe_hits_wsum() for moving sum based calculation
Date: Thu, 10 Sep 2026 07:18:42 -0700
Message-ID: <20260910141849.170896-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
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
index 645cb367019ae..e9630f41e51fe 100644
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
@@ -3449,7 +3453,7 @@ static unsigned int damon_merge_score(struct damon_region *r, bool last,
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
