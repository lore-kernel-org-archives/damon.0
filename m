Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863B48593F;
	Thu, 10 Sep 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049942; cv=none; b=A5RBQlJIFKoK+IaHY268CuDyy38OPeJOFHZEx1lO1C49KhXmYIljcj1hHIK8BPag+EdUDClros00H/ml6QjaBAvkEQKrUWua+5T8jMpvk6H1Eoo/lr49SEVX3kZYgr2+fqtxvnshhTAKo57P54uqnwIFk7SF8r8nBbRB0Viyo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049942; c=relaxed/simple;
	bh=ruEQIQfN7/9KLmSy9ZqhbJfPjDew7W2dWmDZIYZGTBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwIsB41rWdtLICuq+S0jo4HRx/2Nd+EeqWeQUKy/wMdzjDB3qfs0VOy+TTm4/hOj7Nfi/JWf3WDQj97CFQyrgQwHEOR25uRx13vVJh+vW0IE53bQNgd+VXpNRWGsdZrX7Yl94+U7vARyhthFxUMZf9gw+DTNX0+z7PgttwCvp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcrDdV2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcrDdV2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CB1F000FF;
	Thu, 10 Sep 2026 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049940;
	bh=j8SWQuWvWu2mDr3ZPa1cO5y8fbw9Oppo9ANwQ11kECE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DcrDdV2OuRczE/ZW01khn6Ch9zyR3ESaeUpagDfMSI2MQIro4saeKfS41yfx4KyGB
	 iTHZvtRAZNMsDC3NgX6oljEhhaMzFTZvrXKXx2aF/NDTOr9mP+pkyRwd0UZuTxQDCT
	 jiiIcFVXeV5lbVVI0HXhz6XLI7YuxqoqeGH42A7mPEOdCwe4ZTD2r6C3rkBGw2Rmix
	 Iin+VoK8BZsup+gJ7Ztbvox5N4vfCEZXh4WfvCGsT4Og2ha48qhvoKgEnVFaC5oH8Q
	 7UYIDJzbV39+W/nE2v1zSPRA1OiEy4+rRSOZ06UXDdGhKNT9aSu5k1J8V76uT/xyxc
	 nx6g4XHB7NoNw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Thu, 10 Sep 2026 07:18:41 -0700
Message-ID: <20260910141849.170896-2-sj@kernel.org>
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

Update DAMON kernel API to introduce new DAMOS core filter type,
PROBE_HITS_WSUM.  It will allow API callers to describe the DAMOS action
target regions based on their probe_hits weighted sum.  For describing
the filtering target weighted sum range, add two type-dependent union
fields to damos_filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 871d26adf6ae5..ef99ff778ae10 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -399,14 +399,15 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
+ * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
- * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
- * are handled by the underlying &struct damon_operations as a part of scheme
- * action trying, and therefore accounted as 'tried'.  In contrast,
- * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
- * by the core layer before trying of the action, and therefore not accounted
- * as 'tried'.
+ * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
+ * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
+ * damon_operations as a part of scheme action trying, and therefore accounted
+ * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
+ * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
+ * trying of the action, and therefore not accounted as 'tried'.
  *
  * Support for the operations-handled filters depends on the running
  * &struct damon_operations.
@@ -420,6 +421,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_UNMAPPED,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
+	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
 	NR_DAMOS_FILTER_TYPES,
 };
 
@@ -434,6 +436,8 @@ enum damos_filter_type {
  *		&damon_ctx->adaptive_targets if @type is
  *		DAMOS_FILTER_TYPE_TARGET.
  * @sz_range:	Size range if @type is DAMOS_FILTER_TYPE_HUGEPAGE_SIZE.
+ * @range_min:	Minimum value of range arguments.
+ * @range_max:	Maximum value of range arguments.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
  * byte of the region matches to this given condition and avoid applying the
@@ -450,6 +454,10 @@ struct damos_filter {
 		struct damon_addr_range addr_range;
 		int target_idx;
 		struct damon_size_range sz_range;
+		struct {
+			unsigned long range_min;
+			unsigned long range_max;
+		};
 	};
 /* private: */
 	/* List head for siblings. */
-- 
2.47.3
