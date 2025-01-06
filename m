Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3341E0E14;
	Mon,  6 Jan 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192056; cv=none; b=ZK8K6PrQW+urd1XrNlFdt/Wbcmn3VWD+kp+Momu10N0bUQlkjWmOI04ORDg6GVTbl2KDZoVRWN5QA1W4br4Hvz8iT2htdnPilzeW+5nFPzQ0ujhM/ayk8n7chMHZtlqHwTh4QWqSq1elWXmruaLXimoML1/NzHCYtZQU31x48gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192056; c=relaxed/simple;
	bh=2LH1SS+mcAmlUxCwzoptXsvLS0Q9wTfZdyaAciByRN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMn+Fn+8BDSl287svNebLT8Ll6pUlx20y21OZE4Kk75seqTSgOYejIi/4BlZN+CUN0Gxq86CNXXNUF6Ty7aEmlrTZV9zYFoP1b9A83xgm5k77wf4sAbZCMmLwI5RlczIZyepOXSK6r1xqVqT91QRmXyRMtTbSNH5GNC0lyWFU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAYIhQk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAYIhQk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CE4C4CED2;
	Mon,  6 Jan 2025 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192055;
	bh=2LH1SS+mcAmlUxCwzoptXsvLS0Q9wTfZdyaAciByRN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAYIhQk+ZNsHH1AnWzsQzrhkNcdktCCWYi8JwOkrZT2ipR6JsnMpZyThIUdGJwJJ2
	 m/6qUBaDjKqS5CPI3GgUipsWQJVyTRunXGG7Fi89wrukN65NVpMsLW31CPl+qnHozZ
	 GkvF8Vx1AJIjOP0tsLZtYWeWpcPtc/BTrTkEyDlCeeR39HCLh8u4jQdIie0GAXynQC
	 yNg8FYT63DxRJa5SY7VV/4CVV/0ELLoPG1zaTNXYuPGa+uaCSSWHAqxbrEIh0+5ZwI
	 c3ZyQq5uE1liDUXvdmCx443KSGnIyAm6JvOsVQNTgsNepYr0TPkMc2rr+0ZSy/bziT
	 Y3gfvMfiLQJ6A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/16] mm/damon/core: implement per-scheme ops-handled filter-passed bytes stat
Date: Mon,  6 Jan 2025 11:33:52 -0800
Message-Id: <20250106193401.109161-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a new per-DAMOS scheme statistic field, namely
sz_ops_filter_passed, using the changed damon_operations->apply_scheme()
interface.  It counts total bytes of memory that given DAMOS action
tried to be applied, and passed the operations layer handled
region-internal filters of the scheme.  DAMON API users can access it
using DAMON-internal safe access features such as damon_call() and/or
damos_walk().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 mm/damon/core.c       | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index da003173210f..2a93dbe06ecc 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -286,6 +286,8 @@ struct damos_watermarks {
  * @sz_tried:	Total size of regions that the scheme is tried to be applied.
  * @nr_applied:	Total number of regions that the scheme is applied.
  * @sz_applied:	Total size of regions that the scheme is applied.
+ * @sz_ops_filter_passed:
+ *		Total bytes that passed ops layer-handled DAMOS filters.
  * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  *
  * "Tried an action to a region" in this context means the DAMOS core logic
@@ -310,6 +312,7 @@ struct damos_stat {
 	unsigned long sz_tried;
 	unsigned long nr_applied;
 	unsigned long sz_applied;
+	unsigned long sz_ops_filter_passed;
 	unsigned long qt_exceeds;
 };
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c6ccb4825c57..c4ce72a86d81 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1362,13 +1362,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
 }
 
 static void damos_update_stat(struct damos *s,
-		unsigned long sz_tried, unsigned long sz_applied)
+		unsigned long sz_tried, unsigned long sz_applied,
+		unsigned long sz_ops_filter_passed)
 {
 	s->stat.nr_tried++;
 	s->stat.sz_tried += sz_tried;
 	if (sz_applied)
 		s->stat.nr_applied++;
 	s->stat.sz_applied += sz_applied;
+	s->stat.sz_ops_filter_passed += sz_ops_filter_passed;
 }
 
 static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
@@ -1586,7 +1588,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		r->age = 0;
 
 update_stat:
-	damos_update_stat(s, sz, sz_applied);
+	damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
 }
 
 static void damon_do_apply_schemes(struct damon_ctx *c,
-- 
2.39.5
