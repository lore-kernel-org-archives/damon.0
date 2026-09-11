Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693CA48595B;
	Fri, 11 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134920; cv=none; b=cn2p24v3e8ZfxhvVEshf7npcCUM6v+Lc4ZXH7cEpM0PEjuQ1lDc45ZJSdCymUkBX9KZpOAtdkhyRPT70TIC3U+maSD2W8IMVU2ZwzfWFshltHcxTFsAysAp0iAAfGnV/Lc95fboJ6/EEQWE0JtA6iblJdu1xX9HW5DwT0gHQq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134920; c=relaxed/simple;
	bh=xmndBrhMhbpyzJe/GZ7fJhit8cA77QIBUB9hkxLgGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0E6WXsJylu2JmAr8IP7XyQvulRrTDtqEp/oed5Ly0On1iMECC/vRZgpNr89S2bnEA52Kzur5EvfYzBvFhsoKLUXdu+Xb1WC3Olv9hsx8MrmtsC2wv8sftQTcbc+9Oh+zp3Pf4701cIeU2c7YNey3BeAer4PESTGpSbLNFXhUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMUgkNxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMUgkNxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16CE1F00898;
	Fri, 11 Sep 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134919;
	bh=kMIWiALSFrn/d/Ne4UrnEpuxkZ1ESBf36wruD1e+2pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMUgkNxfjifF94LFMFYVhaCi84XVweVc7zQ66jg6AZ6H0gDuYkPI8eP3fRGR5miwf
	 SuRj/CA1VhZFx+2Yp+MOd6bTF0fyg2ByVLOpaQzKPNTCGYqc98A9ZEaCG3KqJx4YRB
	 sdaXP47joRJ7ie786UeULCNAzz2mZ/R4GcogsGoe9kPHnh9HCnrYxZL+Roa0o4EngB
	 ceMNfCE0kRSMiPxjEkqqlL2v3hjNvusV1vqtqpIzkHhcMXt+JEDHR+/g/I9Kp3Rqma
	 pjb28j7PD4HPuyEVdJ+YufORVOhPtW3Vx5AL8023OM1GOtyD0cMzg7BiBAAU0DlIfl
	 98PtWpmtM8Y+w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Fri, 11 Sep 2026 06:55:03 -0700
Message-ID: <20260911135510.96914-2-sj@kernel.org>
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
index 16800b3dc379b..9e84bdeb5616d 100644
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
