Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726766E9
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8063C4314B;
	Tue, 13 Sep 2022 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091105;
	bh=qZmiFc1Nc82ylFf2RlnRQAmg5LcM9WJjL5ftMxpc9Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BB374hfZv4lK06Nj4HgDd75pbYfHPfeFxPQ3Xjt/cz2hsv/aWWPi+WTgisy1XCo1g
	 pjg2H6jqjFT4AOYIOmVse24brY8ClPTPcIQwlN8UwP+19TilWDubDQSho9kqu4E8Pu
	 GMvpdtW9cKXgQqp2mcz7axPBiGT/Rk365rLZhsCkfQuVLu/+BlcKFMGe5MZtIRF4NW
	 OxwoHMlnk9xXSAhE/vStWlWrwr4HOqsl8MUTZ+vX375YF7UtWc6v00HgsPB+mnumGH
	 ViI3StyG6zLvY9d3ivDvJfY04ME++3mtJXZIIu2j9RR5H3Ptivgx8IqdWU9Do9Bjv3
	 NCY1EzCxzmVag==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/22] mm/damon/reclaim: use stat parameters generator
Date: Tue, 13 Sep 2022 17:44:43 +0000
Message-Id: <20220913174449.50645-17-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit makes DAMON_RECLAIM to generate the module parameters for
DAMOS statistics using the generator macro to simplify the code and
reduce duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 7f845f617dc5..1ef8353ac15a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -136,35 +136,9 @@ module_param(monitor_region_end, ulong, 0600);
 static int kdamond_pid __read_mostly = -1;
 module_param(kdamond_pid, int, 0400);
 
-/*
- * Number of memory regions that tried to be reclaimed.
- */
-static unsigned long nr_reclaim_tried_regions __read_mostly;
-module_param(nr_reclaim_tried_regions, ulong, 0400);
-
-/*
- * Total bytes of memory regions that tried to be reclaimed.
- */
-static unsigned long bytes_reclaim_tried_regions __read_mostly;
-module_param(bytes_reclaim_tried_regions, ulong, 0400);
-
-/*
- * Number of memory regions that successfully be reclaimed.
- */
-static unsigned long nr_reclaimed_regions __read_mostly;
-module_param(nr_reclaimed_regions, ulong, 0400);
-
-/*
- * Total bytes of memory regions that successfully be reclaimed.
- */
-static unsigned long bytes_reclaimed_regions __read_mostly;
-module_param(bytes_reclaimed_regions, ulong, 0400);
-
-/*
- * Number of times that the time/space quota limits have exceeded
- */
-static unsigned long nr_quota_exceeds __read_mostly;
-module_param(nr_quota_exceeds, ulong, 0400);
+static struct damos_stat damon_reclaim_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
+		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
 
 static struct damon_ctx *ctx;
 static struct damon_target *target;
@@ -318,13 +292,8 @@ static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 	struct damos *s;
 
 	/* update the stats parameter */
-	damon_for_each_scheme(s, c) {
-		nr_reclaim_tried_regions = s->stat.nr_tried;
-		bytes_reclaim_tried_regions = s->stat.sz_tried;
-		nr_reclaimed_regions = s->stat.nr_applied;
-		bytes_reclaimed_regions = s->stat.sz_applied;
-		nr_quota_exceeds = s->stat.qt_exceeds;
-	}
+	damon_for_each_scheme(s, c)
+		damon_reclaim_stat = s->stat;
 
 	return damon_reclaim_handle_commit_inputs();
 }
-- 
2.25.1

