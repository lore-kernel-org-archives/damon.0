Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8E3BE642;
	Mon, 22 Jun 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138126; cv=none; b=DYUOntq+vZN5p50i0DD98Ojua6iRMjeEVyWIZI4V3keSgzc4/4XeXUURDpNFBhRSPJJ3WsIMByN3Af2hFBATsxKLXz+SBKwYzAFADXNP1oxd18a4a4Lq/t11eR9yfEUSNlFR2wrC6YNpO4nMIhsOsdIlwhqRwBV+9QbnKeYDrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138126; c=relaxed/simple;
	bh=sJXs6JTOmmTaimisUfsOE/MKddIu6qwkbRkDatUfnhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXBQpbg6tI7sHFAuH952ypoDzMBUWjKRKUQWxIQDQZ4McpQbjjHemi+IKGdvGVdhAIK9W/mSDGVlO4AzMODia0UzK5rLlMAG844pfWIT3s7IV3a0LZWZyNky9nJbcwo5EJ6B8EsOaIDXks+7UAVf4931Ykd68rl1dCmBpDA9j0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVGWVwdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVGWVwdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828461F00A3F;
	Mon, 22 Jun 2026 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138125;
	bh=jQDP+fLezsfpK2Udw4OPbczVKLHgO20AD8woKXU9dAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVGWVwdofdbv9/P5rtpzV11I0NbBetnrmSb4rdvw1zVHFFo1SZhMbG8jkARFtcknW
	 Dej/pc88igKEkbyYJ40P1pUKFF6MUx4zGq0RS7mzEKHh06tKjI46t0+SKBfqOFxunF
	 I6f6mw7R/I9tjKJk7ulcpaIZANpz8552HPFlSe+j1HL+ygFRpMukoBvHSh3xtk2S8Y
	 MrXVW7HHLPwndEyi8qxvUy/tat0Ua4nCEZcujSPt1rOgJrIRAAw9VysdCPFyyfnWMz
	 WpzpF3MTYc2DPMxLG30bckQ37rjb4cC9ZSKWQq5Rr7jeOFHifGvr5+ctBaoZ3YiX7O
	 kU8iPdHYQTjEA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 14/18] mm/damon/core: remove attrs param from damon_update_region_access_rate()
Date: Mon, 22 Jun 2026 07:21:34 -0700
Message-ID: <20260622142139.30269-15-sj@kernel.org>
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

damon_region_access_rate() is not using attrs parameter.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +--
 mm/damon/core.c       | 4 +---
 mm/damon/paddr.c      | 4 ++--
 mm/damon/vaddr.c      | 6 +++---
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 55a743d99b567..a09ee8a09b5af 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1018,8 +1018,7 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
-void damon_update_region_access_rate(struct damon_region *r, bool accessed,
-		struct damon_attrs *attrs);
+void damon_update_region_access_rate(struct damon_region *r, bool accessed);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		bool matching, bool allow);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b095f053c6fa6..560e1aca5ee22 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3771,15 +3771,13 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
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
index d0598f5f26882..db48ad274b078 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -93,12 +93,12 @@ static void __damon_pa_check_access(struct damon_region *r,
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
index d271476035641..2e12cc628fea0 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -503,19 +503,19 @@ static void __damon_va_check_access(struct mm_struct *mm,
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
