Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016B2E8B67;
	Fri, 11 Sep 2026 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089225; cv=none; b=LG9gZPOhIVAjCY1RK2e9UximSHzCa+UD4YPkbC1RBjSsohHkKsDO6Gghzafa7EztO/8O9+2PdbyBwy2EeL8jojzGz2r3k4WVuqSi7ygUcIjVixGWooXIqeqsGGmWvHV4GjgYnEZqxnqmqlbMS8tbcJnTWSYkaYn0sjQQQ8IxAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089225; c=relaxed/simple;
	bh=ruEQIQfN7/9KLmSy9ZqhbJfPjDew7W2dWmDZIYZGTBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtAWFJnBdxF3DrsPZmHmKqE9OJ36MAPzRW5uhrQ9k4jhAYzE9f9vnwMOSUN4oi6iNDu30XtItyCzaIxRozL7WQWhFI76/t9tqMZ4eTxAzDsQsGEltKHteJa3eE6efmuCILamBBsAf1WK38qBY44awvnl7THqv1b3GDIJI6r8ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA8n1J11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA8n1J11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A6D1F00893;
	Fri, 11 Sep 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089218;
	bh=j8SWQuWvWu2mDr3ZPa1cO5y8fbw9Oppo9ANwQ11kECE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MA8n1J11Q+N453pKNit7qsK5N8m3xsD/WiHIm1bYiUNfAtBL9TJl+eMtw24ru5EL1
	 cakIWDwPlXCptF4UsAX7P5KTwmIqBh8OFy8A+bZZqFTdCvXZWWe70HoAOQ5Iv0EvZy
	 jlMOBWy17LWZDIYp93GDUXP1Y4oRawKlOVvORwqK+JzNm+JA2VpM53CLmpsUTpKY2h
	 y6GND+wLVryqKyy2rzfGkY2Mx9s6y/n3mJny+1vKjLQTFVZfl+//WovOqdLPeKnD0z
	 6iNCX/b2scJnYCJTW/DDxobJBZ/Qx5/4Dvs6eMLiPC9xtzxyt1TexVX+zKMGC5tJ5k
	 GT8FS3GM9Huiw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Thu, 10 Sep 2026 18:13:22 -0700
Message-ID: <20260911011330.93678-2-sj@kernel.org>
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
