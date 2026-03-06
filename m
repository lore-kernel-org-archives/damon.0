Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712B3CF69E;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810963; cv=none; b=leKjP6SllYLXznEOrpl7V7b37aRyRRM4PS7eFALq8RAMt9TN9l6NL7JeDyvHuFrGXrm1ivc3Ap8PtVaH5MZ1QZ+Ztt3PFHD3wghIGdJe50K0aqT729Eww2VfYh77xuWAK1j39zC3RBe3x7nu8ZsUL6LjVz4VwvsuRTKvdeNuWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810963; c=relaxed/simple;
	bh=lNQhvpFnr2Kehya342ovbJrx9ImZU409SPVoAQ9GUWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRzokatqreTtRNgU/DG8+VN+szDgWg7KprgIZhzWqBMF/Xu4UrjSc1gY/RdWavk+5OvBD6GUjHWrp4HHxE5ERGqDJcKKpP82TD7IksxL2GD1+HmmzOJmlDJgkcdSDoESjq+1UQZIX2yjbQF9hDEUJvt2fF1jaUlvX18fFUnsDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV8uMcTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV8uMcTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42347C2BD00;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810963;
	bh=lNQhvpFnr2Kehya342ovbJrx9ImZU409SPVoAQ9GUWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jV8uMcTNRpQluGW6AZdtbiWhDl0ty9J1UACsJDbieFyAB/TuOa6BFeYza062Ckht/
	 yAX0Fff3ExGhQdexGdIhS8o3KmHnhudqZraQ2bgFlfj8ChnNp9T6lHRIowTahiHCtF
	 wdtW5Y0zzcW5s7U1+saWdzNe6rOmmKRWDW1VaYXadzF6GpT43ZfmSr6KAqocnpsqmx
	 gjwG1yDnm2Q68hk6i2aGz6Lt+xz5FM8U7+zhsm85mFmInuaACW5ljvr1HxdxzzWMZo
	 sj+QnyOWBRTsvnPFNUk4w6CQKfl++7+5jyJFq7RR4QtJpimQxfRJYel6B852BuiXu0
	 vTX06q27i7eNQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/core: add damon_merge_regions_of() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:09 -0800
Message-ID: <20260306152914.86303-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_merge_regions_of() should be called only after aggregation is
finished and therefore each region's nr_accesses and nr_accesses_bp
match.  There were bugs that broke the assumption, during development of
online DAMON parameter updates and monitoring results handling changes.
Add a sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8a3738a17cdd9..93d1577b1ae07 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2505,6 +2505,20 @@ static void damon_merge_two_regions(struct damon_target *t,
 	damon_destroy_region(r, t);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_merge_regions_of(struct damon_region *r)
+{
+	WARN_ONCE(r->nr_accesses != r->nr_accesses_bp / 10000,
+			"nr_accesses (%u) != nr_accesses_bp (%u)\n",
+			r->nr_accesses, r->nr_accesses_bp);
+}
+#else
+static void damon_verify_merge_regions_of(struct damon_region *r)
+{
+}
+#endif
+
+
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -2518,6 +2532,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
+		damon_verify_merge_regions_of(r);
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-- 
2.47.3
