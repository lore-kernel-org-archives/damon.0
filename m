Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47C501F53;
	Mon,  7 Sep 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801147; cv=none; b=gYo7LHVyNjkMCZGViVLq2PNR8hRb/5u3db6fzkfshegEBBpU26IKBq9hVR8ZogaHS2F6bVYYZGCatn/nw9bGlOoRyIoRbLL57vrv7uQX0Zyo5TVwYZzASulx4+KFEru4rH6MjeHMaQSF4i/hu/b2ctSu6lDnHbrp7r8vtjNnVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801147; c=relaxed/simple;
	bh=Y1BNgJTPI/nQKjFvvasfGPi5MdMWj2Yvyi9brUFOviM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVbGR0b6mcSlOsF/tGQTaJNvhNdKgQ2nXLFCHJg6BsXC5ze5IX+AFZutDx/Ynr3Oo3zCsa8ad0WF/N21HdjLoo2h/AxEhjEGWaODeBi0E/+WPEIHqGvIm50RePMi41JKPawBs1qE6xWRj5o7h5NwisT+f1xlN+ruR8zjtYeRJaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHBRoN/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHBRoN/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B364C1F00A3E;
	Mon,  7 Sep 2026 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801145;
	bh=Dxxa5wP8u6+NzrCeSUKIx091CaUINS3Abxx04SVxcHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHBRoN/JWf+JSmblQjMDXNP3atlUTDvNsd4f4vJv+3KdhlTwqVCDKx4TLP5HdJMh7
	 SZCE1v99rIiKmttJvXs0hQmgyeiICbIfE25qXhypdvBuI7kqoG+Vc/mjPjDy/954BN
	 pqDCLAOXybS3PKOZT9s9efM7vhJ8xnm+RKldCioPS8IRAeBZ8GKqdyLevetfjmlNSV
	 F9f9eDyaUSNODVeD2BZn0Fym77oZj/rSloYHl3AF31Goqky1lq1JkiYdLzS2yewKmV
	 GY2qrMU5jJDYPXyEFILOEaFPcyB8ClW0xf1i6cvH6A8NLIQuMMS/JURU8T1c9zJL4R
	 E/ovuggBfCETw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Mon,  7 Sep 2026 10:12:10 -0700
Message-ID: <20260907171218.101430-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171218.101430-1-sj@kernel.org>
References: <20260907171218.101430-1-sj@kernel.org>
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
