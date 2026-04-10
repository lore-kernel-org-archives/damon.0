Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD23D0919;
	Fri, 10 Apr 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830845; cv=none; b=I+NjYJL3s2gba5CErt+HlCcYkweN7QlXMwaVlwUv0M1fQqJBNtawxDwsshrxRybCga61gazmjMJegD02AibpHhL6aCwdyM+wZlrpZcl/ZoIpZGC2LMD/ZBK1qw5lzIikrUDFPnKQna3zOzjaW5BxJxYxn3zWA506JOJ34Yd059E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830845; c=relaxed/simple;
	bh=bRUkpmCPpf8L/6LaFfwvBKwm/4LpPOhSu9Y0BbXCNpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG8pQxVuI5QjlNtsyNxivAdyAmncjgKf+VUQ2IAFntzssW91yXQePSoKWjCEy1OnDs3bDQHE0OR+H6aIvCpUnmbiNUysf6tle9NCDHx+Q73Lq5knVzvi6P7MY2Jiod5iKfo/juG9UqsGOXd3BO63zapPzqQTGK0oeNihpG/vMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa7P2pgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa7P2pgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF127C2BC9E;
	Fri, 10 Apr 2026 14:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830845;
	bh=bRUkpmCPpf8L/6LaFfwvBKwm/4LpPOhSu9Y0BbXCNpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sa7P2pgvXdb/wIm55UTCQrMbVgTdHxtDQvPCc3KJj3Kaex7BTU/5OTffm/cf+kKJ3
	 6UUSzoRawh2Sciton9d5REsSD23HKgqL9W5PeTijYYQYT/Gdad4P5sddsA2X2YHgUq
	 7g6ga826N6x3PqZr2hssvcQMol8Gaqw0Zs1Htx5jDUN5tb90j+WowH1weW5ZyXa8h7
	 Kk67PHk9CslS1FL4LgLbILpMGut2jH14n9l5EpKDEwzqxs5otNppknE/vhxq2fcwCD
	 xw20L5IERd7a+O1uN/U8V0aTpIh9cOg8w97pGG+KKB13tVioa3dyBF2ICCEBqKZV/v
	 Ni5VUIrrfPCNA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 02/11] mm/damon/core: merge quota-sliced regions back
Date: Fri, 10 Apr 2026 07:20:23 -0700
Message-ID: <20260410142034.83798-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-1-sj@kernel.org>
References: <20260410142034.83798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_apply_scheme() could split the given region if applying the
scheme's action to the entire region can result in violating the
quota-set upper limit.  Keeping regions that are created by such split
operations is unnecessary overhead.

The overhead would be negligible in the common case because such split
operations could happen only up to the number of installed schemes per
scheme apply interval.  The following commit could make the impact
larger, though.  The following commit will allow the action-failed
region to be charged in a different ratio.  If both the ratio and the
remaining quota is quite small, and the action is nearly always failing,
a high number of split operations could be made.

Remove the unnecessary overhead by merging the sliced regions back, as
soon as the schemes handling for the slices are done, and there is no
reason to keep the sliced regions.

The sliced regions may need to be kept if no scheme action is applied to
the slice due to the quota being fully charged.  That is, the 'age'
field of a region is reset when a DAMOS action is applied to the region.
If no DAMOS action is applied to the sliced region, the region keeps the
age information.  If it is merged into the original region, the age
information is lost.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c7d05d2385fe8..b0f673efc53c8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2159,6 +2159,40 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 	}
 }
 
+static void damos_apply_target(struct damon_ctx *c, struct damon_target *t)
+{
+	struct damon_region *r, *orig_region = NULL;
+	unsigned long orig_end_addr;
+
+	damon_for_each_region(r, t) {
+		/*
+		 * damon_do_apply_schemes() could split the region for the
+		 * quota.  Keeping the new slices is an overhead.  Merge back
+		 * the slices into the original region if there is no reason to
+		 * keep those.
+		 */
+		if (!orig_region || orig_end_addr <= r->ar.start) {
+			orig_region = r;
+			orig_end_addr = r->ar.end;
+		}
+		damon_do_apply_schemes(c, t, r);
+		if (r == orig_region)
+			continue;
+		/*
+		 * If no scheme was applied to the sliced region, the age of
+		 * the slice ain't be reset.  Don't merge that back.
+		 * Otherwise, the monitored information of the region is lost.
+		 */
+		if (r->age) {
+			orig_region = NULL;
+			continue;
+		}
+		orig_region->ar.end = r->ar.end;
+		damon_destroy_region(r, t);
+		r = orig_region;
+	}
+}
+
 /*
  * damon_feed_loop_next_input() - get next input to achieve a target score.
  * @last_input	The last input.
@@ -2528,7 +2562,6 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r;
 	struct damos *s;
 	bool has_schemes_to_apply = false;
 
@@ -2551,9 +2584,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	damon_for_each_target(t, c) {
 		if (c->ops.target_valid && c->ops.target_valid(t) == false)
 			continue;
-
-		damon_for_each_region(r, t)
-			damon_do_apply_schemes(c, t, r);
+		damos_apply_target(c, t);
 	}
 
 	damon_for_each_scheme(s, c) {
-- 
2.47.3
