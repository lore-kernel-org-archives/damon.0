Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B329E10B;
	Sun, 21 Jun 2026 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057462; cv=none; b=DGFba6y2eT/VRzICIprB9oXVByVvs46aAzWOAFE9SiV2KqWeEJxKu65vwgb8dtdoiFj5yQFSvmn7MKf+lX0606BQ460RRnHVIap8QbB4zppXC5GY42HyCwONtxqepDM5PXuWI2CYY0Lhfvdr8SKO9wZb/iU1eAPfaMaQqKDRNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057462; c=relaxed/simple;
	bh=Pk5H2uYYg3tOViNz0tUw0i/U7sKkSTy+a5qUSd1tBfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEgs9q7jBSquNCDrsHZ6yiiZLdn5qwRoIlnFGjtl8iEgUyYdRtDsAZetugu9Y3qyyz51wZxNBhg4oi8vhuB4XXYJjbKuENPef5uF6jdT9rImVUh5EKMqZkkY3s6miDAGYgL+fqLKtuiWgBbXHkZeGwApqNWGR/iUaRQNJhPsmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iniIxnCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iniIxnCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72A81F00A3D;
	Sun, 21 Jun 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057461;
	bh=uvLgUJHE1vEAag5JmbsfYlxb2tTaH8mInR0sbbJDVgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iniIxnCW7I2cg/mgubwoOLxmr7ujOTiYB0L00EXm00LtS/jdGIwYf2fjMPi+yEQwO
	 15kmNcYavkDLntpqyI8wOH+VdEcMMf0zSzFfe+g89Rn2XlYz8U5viJzAxuMrzPTEV9
	 g9uZh1ZjPeZcxiXm8X3lQplJvxn45Pd3HY/aqqZRewId5/bYx0obLt+SEV3u5M8czn
	 cFbfg7bnxvCrNDnyBNgNc6VejnLTQAKTZcXaEusvq/rSEYL1CeqdiEEt3Q8tHndQKJ
	 Q8gZ8Wl+3ww99i95tOc6/NhvQ7cKjXQ6zJHIvFpzVew4uVb1djZZpXgZ5JtasioM5L
	 eAFNj6wXGNd6w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 13/17] mm/damon/core: remove attrs param from damon_update_region_access_rate()
Date: Sun, 21 Jun 2026 08:57:09 -0700
Message-ID: <20260621155715.87932-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
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
index c3c8e83234011..6b36e17660c05 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3768,15 +3768,13 @@ static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int nomvsum,
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
