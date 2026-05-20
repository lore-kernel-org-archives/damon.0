Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B3375AD0;
	Wed, 20 May 2026 06:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258551; cv=none; b=brXBRxAdFUhrcmA3n5vhRoekqO/yhCRbvdbuNq11J4wB8BrrpwuzTwBoBw5/LbKfvS12PqJBKNvD679rSRuKjqB2SkeGurKVyNZ3H51aR53VSiFqDQJroQptWWZ+zY6aGAJBMm07wgY0kZftTOEQIQi1PWZ4XGhGxjv3shHUOR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258551; c=relaxed/simple;
	bh=/YKZkQU2w0xT9X6y4g6IAtKtOkJAVQT/NTHny/zpY+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKLCYC4GHW5OBliT/1v5nx1v7eHBb0BKzDIfnwBfhKV/xt86zVxz3mxLZMXbYe92dP1/TbB3CaWFntdxRWLidVJhlUwQ+5pfHUzc7rQCtYryo9dLe9/quFSEbMy/9PN8Ft0U1IK0deMbne64FhWcBNv894G2RM9ci+TvfH3F0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKNodR2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKNodR2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6F11F00898;
	Wed, 20 May 2026 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258549;
	bh=NwOzNgtGbmRdNv9xvtTz1sguHFhxD3l9rWcheeXYL1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKNodR2mXQacDR6VwfgdI84XtuHCPEtfsbxXjj+VOEIJZHsmXqa9fgdgzD9zs3KwY
	 oVQvotEN3KJh1Z7OtyropMGw052yEne4+wEvRukSS//nfcwVwRwg3PDBf6BxyikS3j
	 2o9r0acV01uzHH18rJOQkyKnAJ9n6OjE+n7afqX0ZMA26XyiP/lbQoq8ncOCB+/uYo
	 x/S9mTXuwI2nJFowrXRJOvfijga5GSlsvzJmnZClUWdccPHM42CH/2Ph1DuJX1HID6
	 vOKEd71Awc0pVcel40aRflw20k0rzRNlT7FCPNLYfwp9EfcuYwXMsJolI1/kPG/1eR
	 adROpNMleuf5g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/14] mm/damon/core: hide damon_insert_region()
Date: Tue, 19 May 2026 23:28:38 -0700
Message-ID: <20260520062858.167011-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_insert_region() is being used by only DAMON core, but exposed to
DAMON API callers.  Exposing something that is not really being used by
others will only increase the maintenance cost.  Hide it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 -----------
 mm/damon/core.c       | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b9370c1779cba..3acca7deb1693 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1013,17 +1013,6 @@ void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 
-/*
- * Add a region between two other regions
- */
-static inline void damon_insert_region(struct damon_region *r,
-		struct damon_region *prev, struct damon_region *next,
-		struct damon_target *t)
-{
-	__list_add(&r->list, &prev->list, &next->list);
-	t->nr_regions++;
-}
-
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d1de6ff54eba..53b4bdd27b39d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -256,6 +256,17 @@ static void damon_add_region(struct damon_region *r, struct damon_target *t)
 	t->nr_regions++;
 }
 
+/*
+ * Add a region between two other regions
+ */
+static inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next,
+		struct damon_target *t)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+	t->nr_regions++;
+}
+
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_del_region(struct damon_target *t)
 {
-- 
2.47.3
