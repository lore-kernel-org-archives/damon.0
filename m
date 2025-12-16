Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E534253F;
	Tue, 16 Dec 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872104; cv=none; b=LNWozP1PpNeqa5Og5tBSrQezr7GMoHa2PD98cFPkONhO16WuvREUmVtlYpgi/BPZF/Ji8u4G23dKEaJ9s0scM/RPWS5kplLfaT8qNO8lSVT0s9x00mc18BIUVy35XJLKc5LXDrr1z4IDtkfpMbqQgIQlyuGl/j+ERNumazjs5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872104; c=relaxed/simple;
	bh=FHEw5hu5B8m0TfMg+08OEnZOsjSGxKvHndmP4M5Ow1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSIUKIU0NJ6bdc+DQfeSASRfjF7rezd/Tqk45T27Cv8vhoVnv2uxVvQIvwbMW77hv5Rzu3uKo7B69yDQkD7TljHtWVTjTPh5NtdqwmciBoJyDQiKbAEg0W9n2KThS8nDMqWNER6I/5feHfQQ+0LO6g1k5C4x+3xb6HIiCOPFz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6bSg4ZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6bSg4ZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2FEC19423;
	Tue, 16 Dec 2025 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872104;
	bh=FHEw5hu5B8m0TfMg+08OEnZOsjSGxKvHndmP4M5Ow1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6bSg4ZKdyQZYD8/5fdt9puKkD7nDp9CqTQM85B6Cujj2f6wuAeQamtzQ0fxuB/bK
	 Pfw5mwujN9mnggDHLTLFtyvAvCA/0bmDVgxVZYbo0V0pi2Sk8GoWmi2vPbELWzd1AZ
	 5jDqYGrCnLUKkWQ7YOlMr0CYDc1VGF1It8jJfs7EHbB4by/f222ZygFB8B+6GGfOTL
	 aFFROa5vc+sNKhHBMPZSy+l/A54w1hy8n4PeKvpa0FojLKtagGqY3ttBZrZaH85kAc
	 8SK4mEZnybP+eqNo3652hdmUnzSXo/lv2t80y37HIt4ZOcecE1AHaaWG8YhYUf8MMX
	 DNkmOeY7nMdLg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/12] mm/damon/core: introduce nr_snapshots damos stat
Date: Tue, 16 Dec 2025 00:01:14 -0800
Message-ID: <20251216080128.42991-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON generates monitoring results snapshots for every sampling
interval.  DAMOS applies given schemes on the regions of the snapshots,
for every apply interval of the scheme.

DAMOS stat informs a given scheme has tried to how many memory entities
and applied, in the region and byte level.  In some use cases including
user-space oriented tuning and investigations, it is useful to know that
in the DAMON-snapshot level.  Introduce a new stat, namely nr_snapshots
for DAMON core API callers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  3 +++
 mm/damon/core.c       | 13 ++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200..1d8a1515e75a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -330,6 +330,8 @@ struct damos_watermarks {
  * @sz_ops_filter_passed:
  *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
+ * @nr_snapshots:
+ *		Total number of DAMON snapshots that the scheme has tried.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
  * determined the region as eligible to apply the action.  The access pattern
@@ -355,6 +357,7 @@ struct damos_stat {
 	unsigned long sz_applied;
 	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
+	unsigned long nr_snapshots;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53fb988b6a0d..6f3328b29a65 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -157,6 +157,12 @@ void damon_destroy_region(struct damon_region *r, struct damon_target *t)
 	damon_free_region(r);
 }
 
+static bool damon_is_last_region(struct damon_region *r,
+		struct damon_target *t)
+{
+	return list_is_last(&t->regions_list, &r->list);
+}
+
 /*
  * Check whether a region is intersecting an address range
  *
@@ -1949,10 +1955,11 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
 			continue;
 
-		if (!damos_valid_target(c, t, r, s))
-			continue;
+		if (damos_valid_target(c, t, r, s))
+			damos_apply_scheme(c, t, r, s);
 
-		damos_apply_scheme(c, t, r, s);
+		if (damon_is_last_region(r, t))
+			s->stat.nr_snapshots++;
 	}
 }
 
-- 
2.47.3
