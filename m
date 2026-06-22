Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9543B14D0;
	Mon, 22 Jun 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138133; cv=none; b=XnNY5GVq+yjetLRuiEH1ITKcXlYRv6CFEffzHaafAPdMVlzZR6U/UXDNoZNLMVZ7WxrSUgP7clRk3KY5fS9cPXDaZQtesNjoBteUrkTS0GSNzSkEmoArHeRXqvLa9zI3E4qofa0NX4o+m6p9xpd05OjvfUkuFDxB2+QVvx+86Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138133; c=relaxed/simple;
	bh=IuyX0Vj8VrqZZEKVWTsXa6DquK4YXIC7ivYb/y6S/rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/KLGEASy7PKuu4yXRxEgMzs/rU63lC3LUt0bvGdIiYK6G+CmwRJO85x4sF/MEBvICAqaTCqev2axb4dbccFopWFuGCLIBNqbUtZ8HVlLJ7Du3AP385+u+2JiiG6m4babKK+4Dg08QbGlrvoJXYgObVv9P208+CPQcv3lVYMbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfU+OCmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfU+OCmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54891F00A3D;
	Mon, 22 Jun 2026 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138132;
	bh=xNrJYEZHyN6uUA2mSDTyP7l+hkeko4b5LYoh0CGNL34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfU+OCmDaxVZKRtX1orFdupKSlZbgcq8Pf0HOmShMK7Cj8CfbCuEtFJeEoH4xMIzU
	 ZTNzFI29KG3g/eBR3Kd/V484JrRBuhgFbx+h9aLfMFO2zq7pn7kSPpekmdSBEPbc1G
	 NGF9IxvyQxefnjL2sdPvbOKQUAxYTyIbNFRX21Mz9ewTMUMH2K1lRHrvbJtv4VHIsf
	 4Rmx8lO/W/x39DokyfrkyhWdvYPVHklVbiVlqa+jWqDbH7RxnQ1AkkrN80imlAieNZ
	 1a5GH3IQ96fnXJeGdHXFHm375pX0P13QLguYntWcc4vOiyNHjGUr0k6U/Yk5meGjft
	 tJA81EBxt+VIw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 18/18] mm/damon: remove damon_region->nr_accesses_bp
Date: Mon, 22 Jun 2026 07:21:38 -0700
Message-ID: <20260622142139.30269-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code touches damon_region->nr_accesses_bp field.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ----------
 mm/damon/core.c       |  3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a09ee8a09b5af..fc3d467dc2e34 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -47,8 +47,6 @@ struct damon_size_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
- * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
- *			each sampling interval.
  * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
@@ -61,13 +59,6 @@ struct damon_size_range {
  * not be done with direct access but with the helper function,
  * damon_update_region_access_rate().
  *
- * @nr_accesses_bp is another representation of @nr_accesses in basis point
- * (1 in 10,000) that updated for every &damon_attrs->sample_interval in a
- * manner similar to moving sum.  By the algorithm, this value becomes
- * @nr_accesses * 10000 for every &struct damon_attrs->aggr_interval.  This can
- * be used when the aggregation interval is too huge and therefore cannot wait
- * for it before getting the access monitoring results.
- *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -77,7 +68,6 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
-	unsigned int nr_accesses_bp;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5b5375b035149..4f7954b383d18 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3587,8 +3587,7 @@ static int kdamond_fn(void *data)
 				 * aggregation, and make aggregation
 				 * information reset for all regions.  Then,
 				 * following kdamond_reset_aggregated() call
-				 * will make the region information invalid,
-				 * particularly for ->nr_accesses_bp.
+				 * will make the region information invalid.
 				 *
 				 * Reset ->next_aggregation_sis to avoid that.
 				 * It will anyway correctly updated after this
-- 
2.47.3
