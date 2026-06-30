Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9E3E0C73;
	Tue, 30 Jun 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792512; cv=none; b=J2v+s0O9Ik7lb5AznnMwD11WDvP2CfPKcykyPPearPQE1cMB8RhzLUteXvliyQ4GlOShpmxqf1p+0gygcIsyTkw7yhU7C5LZpDo6dV9E7aXgYAmnGoKv/j3nuOQXSD0tz9dbXzWhIGcm5WLUSrjjz5kUgBUxzuPAYL2v5wHZvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792512; c=relaxed/simple;
	bh=gdyT/kdiaV0axHnzl5rf+Y5BSrfMRqFFs1aKu740zLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErLeRb8+JhO8HUC5Xr/ekd7s9OhKu5XTTah4Mckx3J8uoSYzNDdfke7XwBYXb1zAYmHKWVnEldbOS9aVf5lE1e9BhU+T7IyQuBEK9auis4rfUVrZApbzteZuXON6Z/C/Vg3GxKpgNYeRihGX1mGPqb/1UgU01WLJDLHxk8kLf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjQF8ufS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjQF8ufS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F6B1F00A3F;
	Tue, 30 Jun 2026 04:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792510;
	bh=dCxqSNOS7n5QD0XpLwrveJ2jBbzhv9XH4+TY6qd4Yow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjQF8ufSGzW7qQlvHhiNC5FEcXN9VWApYrmYeEtq78sza2tW/bDo577WS/tZkzHc+
	 OagxGU6rObBbB0AlOjvKdAQXjv7dKUHS3uv+xXTWFY/QJSfN68v05VtuI3wSLQmD6/
	 AN1QYpWIsDOvVY2IQD6sJeoi3FhBzDhmzdf877VLMFUWWoacu1NuMfnq/11o54DD6a
	 4N9KYeEuDyjDVvMMK8tn0VQs8cpCSg68yqcxnTSoFMqdvevlAA6C8p/DBjYT0OL2b9
	 BuABzjkyxu/42uUi8il6TezFzEcDdPl8JQM4Ot86N8KTEwhRjJWsds+3Ad2T8ZT4q4
	 1pdauFcttXG7w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/18] mm/damon/core: remove attrs param from damon_update_region_access_rate()
Date: Mon, 29 Jun 2026 21:08:07 -0700
Message-ID: <20260630040812.149729-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_region_access_rate() is not using attrs parameter.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +--
 mm/damon/core.c       | 4 +---
 mm/damon/paddr.c      | 4 ++--
 mm/damon/vaddr.c      | 6 +++---
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 87c1ff479da82..02ed47c558cc2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1016,8 +1016,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
-void damon_update_region_access_rate(struct damon_region *r, bool accessed,
-		struct damon_attrs *attrs);
+void damon_update_region_access_rate(struct damon_region *r, bool accessed);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		bool matching, bool allow);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index dcd5e484fa442..33c6fade59d37 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3814,15 +3814,13 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
  * damon_update_region_access_rate() - Update the access rate of a region.
  * @r:		The DAMON region to update for its access check result.
  * @accessed:	Whether the region has accessed during last sampling interval.
- * @attrs:	The damon_attrs of the DAMON context.
  *
  * Update the access rate of a region with the region's last sampling interval
  * access check result.
  *
  * Usually this will be called by &damon_operations->check_accesses callback.
  */
-void damon_update_region_access_rate(struct damon_region *r, bool accessed,
-		struct damon_attrs *attrs)
+void damon_update_region_access_rate(struct damon_region *r, bool accessed)
 {
 	if (accessed)
 		r->nr_accesses++;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5c2da45f988cf..8530213086691 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -91,12 +91,12 @@ static void __damon_pa_check_access(struct damon_region *r,
 	/* If the region is in the last checked page, reuse the result */
 	if (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(sampling_addr, last_folio_sz)) {
-		damon_update_region_access_rate(r, last_accessed, attrs);
+		damon_update_region_access_rate(r, last_accessed);
 		return;
 	}
 
 	last_accessed = damon_pa_young(sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed, attrs);
+	damon_update_region_access_rate(r, last_accessed);
 
 	last_addr = sampling_addr;
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index e73ec1ce016e5..2eaced0765e26 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -501,19 +501,19 @@ static void __damon_va_check_access(struct mm_struct *mm,
 	static bool last_accessed;
 
 	if (!mm) {
-		damon_update_region_access_rate(r, false, attrs);
+		damon_update_region_access_rate(r, false);
 		return;
 	}
 
 	/* If the region is in the last checked page, reuse the result */
 	if (same_target && (ALIGN_DOWN(last_addr, last_folio_sz) ==
 				ALIGN_DOWN(r->sampling_addr, last_folio_sz))) {
-		damon_update_region_access_rate(r, last_accessed, attrs);
+		damon_update_region_access_rate(r, last_accessed);
 		return;
 	}
 
 	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
-	damon_update_region_access_rate(r, last_accessed, attrs);
+	damon_update_region_access_rate(r, last_accessed);
 
 	last_addr = r->sampling_addr;
 }
-- 
2.47.3
