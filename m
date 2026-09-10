Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AC3659F9;
	Thu, 10 Sep 2026 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013009; cv=none; b=MnN3MJXFfgi/pRKWwMipxqz1zhz3dVlIM/8kyyCowY+MVeBke2HqP/85XKOYiHsPg4ahwPQRfn1jpQb5FYMNUG9aS5jO2gs9Q0ecRYCczLoK954x4YWScIu1ubMRAsQeoYI1evds4mdmA4G5o06unb1YLuvkp2zzvDEjzD3Fqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013009; c=relaxed/simple;
	bh=Y1BNgJTPI/nQKjFvvasfGPi5MdMWj2Yvyi9brUFOviM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtFm4KgD9vThDtbylAilELPJKC3hNczKZEbCvcWTxElmaZPw3CtW6iWU7uPMXG1rkyAkh5K4FQecIA8iIvSnAmXuPfWUtMTHe3Juwyl3UIyas2okg62N8FdCbTFZXZWV4srdqC5+QddSzz2DnqsEzy0rkdu7/m0M4GrXZuK2CFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bED307cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bED307cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEB61F00898;
	Thu, 10 Sep 2026 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013007;
	bh=Dxxa5wP8u6+NzrCeSUKIx091CaUINS3Abxx04SVxcHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bED307cl2sGFNZVAYrK7mZrmuxaml4iPTXDqeapjKFViFL6kmH3sQRTJl48Z2odWI
	 1oagjsJAHT9Y6CP7yw3k4mXNKxeSXFoBneEroJgN1yvmRAdDFEvNrLOCCXgQPS7Cck
	 M62s6v0bEiSxmCqFp4uXuaBlIaB1SqJkBtGBfZ748kk9eRqeOi0Pmmvv0E54rs0880
	 jBDhMU2UBBsFojRmjOECPuo3BOM9gnvpHUMBgKumhvcblwRI3XBzC7P6Az67p9262S
	 JTef2bK8K4zy5vQz27rxJm6svm1tlMW3+noOsjhIl2x1S0niNHa9ePrVGItZReqzO4
	 M5bZd8U18EsIQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Wed,  9 Sep 2026 21:03:12 -0700
Message-ID: <20260910040319.147037-2-sj@kernel.org>
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

Update DAMON kernel API to introduce new DAMOS core filter type,
PROBE_HITS_WSUM.  It will allow API callers to describe the DAMOS action
target regions based on their probe_hits weighted sum.  For describing
the filtering target weighted sum range, add two type-dependent union
fields to damos_filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 871d26adf6ae5..1deda16bb70b5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -399,6 +399,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
+ * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
  * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
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
