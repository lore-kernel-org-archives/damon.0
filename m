Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BADA1607BC;
	Tue, 18 Jun 2024 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734703; cv=none; b=LQAo+IGOQGDFGLjctmX9K9zCo4BY7J8t3r9ALHWFYTkB2C9+ruYKWaYzHlMM5snU1GMJlCe69GBqbc9W0m3X2+S2L07IwLuOKVHOhSE8YRCWFYlEtq8/voyiYbdmT0sX7lQ+QofKD4+QnZJdqYvEQvwpGXlK5kvJtYRrtDTxPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734703; c=relaxed/simple;
	bh=50hBEP6CpX4UJy/Ydz/ykmHUVQkUp5qb7XdctlMxkUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baPcISIStSMUe6We3WLH8QiipZP/+OgRnt3AG9tfBmp+ERUyYEhiAoIpnmW4uKOuBAgRsYjLLJMt9xRLNx+kPU44qbiyARGxC2jeBbPtg7YxEKkRcM5UnEfzCzJvk/T/Ld75R1E6wUM3qJYs5AwKY4XoPVo3FSvdv0YLj0TuFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv3wHdx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv3wHdx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C6BC3277B;
	Tue, 18 Jun 2024 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734702;
	bh=50hBEP6CpX4UJy/Ydz/ykmHUVQkUp5qb7XdctlMxkUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bv3wHdx62BoXicPFD3PtWCmzu1QMbhv2f1y/yA6WIoKpljpHHt1SpeWSMp51QlqTh
	 YRo9i5ZHlHsb8/rM5jZWPOZOJAdHlCUnI1ovNiJZyXBbcQCjvaa2bb40wetatKs/TA
	 aw0ojXny1SKlwjKjhYhpd+0a5Hy6JFL5XOvQSKDN8mQ8Z5AiScjUsee6GCQXhbbpwD
	 8wT93MtFD7eBrhaeQvmcT7N1wSk+tll4x3u2s2Ku/osq8eZJffSqBJIkRbD9KyVIN2
	 yyYiJz4eJf2pWOUnSxMJ4EN7n2p7g9D2jtcyniabVB9N7eF3++GExlXmeU3iXTtaCZ
	 5BQVwFeCDY2Eg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] mm/damon/reclaim: remove unnecessary code for online tuning
Date: Tue, 18 Jun 2024 11:18:07 -0700
Message-Id: <20240618181809.82078-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM contains code for handling of online DAMON parameters
update edge cases.  It is no more necessary since damon_commit_ctx()
takes care of the cases.  Remove the unnecessary code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index be7f04b00d0c..9e0077a9404e 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -181,23 +181,11 @@ static struct damos *damon_reclaim_new_scheme(void)
 			NUMA_NO_NODE);
 }
 
-static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
-		struct damos_quota *src)
-{
-	dst->total_charged_sz = src->total_charged_sz;
-	dst->total_charged_ns = src->total_charged_ns;
-	dst->charged_sz = src->charged_sz;
-	dst->charged_from = src->charged_from;
-	dst->charge_target_from = src->charge_target_from;
-	dst->charge_addr_from = src->charge_addr_from;
-	dst->esz_bp = src->esz_bp;
-}
-
 static int damon_reclaim_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
 	struct damon_target *param_target;
-	struct damos *scheme, *old_scheme;
+	struct damos *scheme;
 	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
 	int err;
@@ -214,11 +202,6 @@ static int damon_reclaim_apply_parameters(void)
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
 		goto out;
-	if (!list_empty(&ctx->schemes)) {
-		damon_for_each_scheme(old_scheme, ctx)
-			damon_reclaim_copy_quota_status(&scheme->quota,
-					&old_scheme->quota);
-	}
 	damon_set_schemes(ctx, &scheme, 1);
 
 	if (quota_mem_pressure_us) {
-- 
2.39.2

