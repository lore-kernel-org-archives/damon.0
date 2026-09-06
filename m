Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB083C8705;
	Sun,  6 Sep 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728723; cv=none; b=c37zQRV+ZhzcCO2ZPY+jSNDdoHqP+mOISstBF/pEuVQVTD4xyN0gCr2C93LMXpm3DnnBOfbmhnAbQW54ETmV7uH3TldTLlBi/5k6nqTaH5qncHEY3i1paCkUP2uV/aaXEdN0K7MtxXdB1jBPuihQI7yLWNznw6faTqHt5EjdGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728723; c=relaxed/simple;
	bh=64A8eSI2cMClOGz3kyZmsTmWzNg+K9bSbEyPFRmR49E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMBfshzTUWVW+GeBZsKglGvMcBuMc98x0vcfUqkUKeLIJ9zES8m4ay1ycpxhTNiHTFgKN3bcwM3DIArFADuHTyUHkuiV/XIBECEp+daptL8f/bth3Y+qc4CTwkAdpw5jOMiLwWTlOykyfM8B7yDTeo2pMvq7bFQQaKanJazLZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hev5VWS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hev5VWS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0091E1F00A3E;
	Sun,  6 Sep 2026 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728722;
	bh=enJ6Ikb+xyWqp47h1SJ/IEbgrZU8ueGVdQgMTNLWdsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hev5VWS0XGTr1CiIZQoRlNatCSnZKU1ZWGfV/gemtU6nYfmgwkNgdevPYhOdvcIft
	 H7WX182R8g6uqDQqJ2JNNIIDkqUmr5H8zR5GXjpbQfbeubTqJgfgo075kzWjAk5m54
	 jwwTumD/XDhtMuG4+OZpfRdWycm/Klu5RgNX1TNe0PAuibTmtbM1ahTEgPkseH+2Nt
	 psK496Zlj8G8fu4R54TzMKogl2xswfhdYZX9ejbf+KOnkXKDoG1lo76zoG+Qs+eN8K
	 tPLTvXxJB8TBgdfuzBAX6dyppUx0YiORIyz31qzZaZgKIjx7rzzMNvxqq6ao8nf07s
	 aO6mZyYOVDKpA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/6] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Sun,  6 Sep 2026 14:05:07 -0700
Message-ID: <20260906210513.106895-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906210513.106895-1-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
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
index 871d26adf6ae5..59d57131d8327 100644
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
+ * @range_mx:	Maximum value of range arguments.
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
