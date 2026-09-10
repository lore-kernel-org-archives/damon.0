Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8B36923F;
	Thu, 10 Sep 2026 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013009; cv=none; b=SdhDCXS+XJBPKUnz7//tKY2BifMdz4kGIjP+C4NMNf4buj2DBJva3YldE0xxtQq9DBxL8IhtFg0yY0286Cd2SwWCRS+py1Z5+Dh0BMj68xBSnev1Xy+1mUtQgc2eylQSPgM9hRyss4/vekXlusqhtWIW5Vh1xfKSedBaAw2OVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013009; c=relaxed/simple;
	bh=XCLNTmWip52cot71D04VbReQLPgXJA7i5vWCjMSpq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgHU4zJD9raObBQmNo/VSSQMNlICRmHdc/VoYlCCd4phk9joRRu5Ub15Shf4xmFT/4MEkJOvr/Yj9tgW+hkP0hqw1OVq7d3fu8DLlpgE3aXvo/bgu2RjADRsEs/DG4EBvnPisMB+0bUoXqUWiDMsWdMex0xXOjpYS728QmT84oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeQNpx3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeQNpx3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37B61F00893;
	Thu, 10 Sep 2026 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013008;
	bh=0OvKCQwVrbdq884qmAo02GJLGvlhIZi43wP/kzZVb6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oeQNpx3v1F0Di5qlSqfbke+lKAvzSgjoKl+XISZq8xqDNY9BSHyQujqVytKdb7y3f
	 yuBjSf4naKO/i5XZ1oF1567g75vpL3sJNWHKWMt1q1ut9bPN9crTgxlsjrAfzP6YrG
	 npb7VB3P7Mam9P+ywOW2TI/3wTDC4ymwPZIi8lsFBQDQPLTSCRzI7hZfwfrPdNMsGq
	 VAabLh5KaIiu+dcNI0OZ1z1bEwHQejCeABCU+HqlUhGa34gJxDqQ+Pw668Oou5TK4x
	 yfbEZyCxEiMofyOKpyNFt0X04YBhXUCUslG5wBX6Z8c9Gzqv/GwG5FFP3v89dMo2PA
	 1AbjE3ZACLOYA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 2/7] mm/damon/core: extend probe_hits_wsum() for moving sum based calculation
Date: Wed,  9 Sep 2026 21:03:13 -0700
Message-ID: <20260910040319.147037-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040319.147037-1-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
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
index 1deda16bb70b5..9fa99f92a2e94 100644
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
