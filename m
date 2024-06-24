Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0019EEDA;
	Mon, 24 Jun 2024 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251897; cv=none; b=RS1qLa+jg5IXLGTXIEoLH0lw1XXjdppqeaJ5C9VZEiKzZB6iZwA5G/4r/PU79oN07TwGlJFx72JSkd8RVGFL0Lyl7tyGS+FUQq2h/XU1AjDZdNJFqfg5sryF42zr+9ZyvcaRUNWgre/MrVyxoKS5AhumGgCkYJYZgLeqRkQSwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251897; c=relaxed/simple;
	bh=YTBdXq2TGG2GhM+XlgLTSVVwIadpxauvL8szohE7zO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJzLZyzE3RJBtCbsRyFuexlwTis5y2rndCvyaRSRKoPuI2dPG4BmLyET9Ov9Jkce1pMAmdFSdAOuDTHUPJeNYX7sN+xc2fQabXPOSSoc7Sqf5z4SPr5zbjtGlF0GOvJcCTkZUnlucA5F+BbXRTOTqJ8ILtVmXbFWFnPNNUccYZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENjwz9wd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENjwz9wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADCEC2BBFC;
	Mon, 24 Jun 2024 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251897;
	bh=YTBdXq2TGG2GhM+XlgLTSVVwIadpxauvL8szohE7zO0=;
	h=From:To:Cc:Subject:Date:From;
	b=ENjwz9wdsaeRlckaB8ZWYIdy5ErpdGluAMVz1vjPPy1hd7Uvf31aeWSt87r96sab/
	 RQl+VYURfa2tZJShM21Bdsrvw8sTmFl8XY5sezW25kc0WhW1Gi0mZmAFan6yDB/NC7
	 erwKzeamoUHkFvVBysnGh2R2j5PPndzfdt51UjaKC/A4R88J/hdN0rlolmDJY10Wsu
	 /9XDUMWTOQkZkrm2+LQcNVKxmJaz0kYUl9/MFAvfrO1ktlPgNPiDTs4zIF+ChgSBW7
	 DZ+oszY0aqJWKacBJLwCa89ogO2KfnlbEXq9Xz+GDZ+TBG/73xptVAAjzSCuAvpIIC
	 QXTLDTXtwYIbQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: merge regions aggressively when max_nr_regions is unmet
Date: Mon, 24 Jun 2024 10:58:14 -0700
Message-Id: <20240624175814.89611-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON keeps the number of regions under max_nr_regions by skipping
regions split operations when doing so can make the number higher than
the limit.  It works well for preventing violation of the limit.  But,
if somehow the violation happens, it cannot recovery well depending on
the situation.  In detail, if the real number of regions having
different access pattern is higher than the limit, the mechanism cannot
reduce the number below the limit.  In such a case, the system could
suffer from high monitoring overhead of DAMON.

The violation can actually happen.  For an example, the user could
reduce max_nr_regions while DAMON is running, to be lower than the
current number of regions.  Fix the problem by repeating the merge
operations with increasing aggressiveness in kdamond_merge_regions() for
the case, until the limit is met.

Fixes: b9a6ac4e4ede ("mm/damon: adaptively adjust regions")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f69250b68bcc..e6598c44b53c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1694,14 +1694,30 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
  * access frequencies are similar.  This is for minimizing the monitoring
  * overhead under the dynamically changeable access pattern.  If a merge was
  * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ *
+ * The total number of regions could be temporarily higher than the
+ * user-defined limit, max_nr_regions for some cases.  For an example, the user
+ * updates max_nr_regions to a number that lower than the current number of
+ * regions while DAMON is running.  Depending on the access pattern, it could
+ * take indefinitve time to reduce the number below the limit.  For such a
+ * case, repeat merging until the limit is met while increasing @threshold and
+ * @sz_limit.
  */
 static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 				  unsigned long sz_limit)
 {
 	struct damon_target *t;
+	unsigned int nr_regions;
 
-	damon_for_each_target(t, c)
-		damon_merge_regions_of(t, threshold, sz_limit);
+	do {
+		nr_regions = 0;
+		damon_for_each_target(t, c) {
+			damon_merge_regions_of(t, threshold, sz_limit);
+			nr_regions += damon_nr_regions(t);
+		}
+		threshold = max(1, threshold * 2);
+		sz_limit = max(1, sz_limit * 2);
+	} while (nr_regions > c->attrs.max_nr_regions);
 }
 
 /*
-- 
2.39.2

