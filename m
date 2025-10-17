Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78519332EA1;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736435; cv=none; b=rNiQ5hKIY2lyL10AWUC6uZHcCKT6WCoDQLCIAEEddWmzciLk5coC2UGN2V7dImgd03ZpC58cowzJqGqPYtqrIebWaCpL5jtWAWaMy8C+Mcp952yaZDseKTlG2Lo9638DXjDue4IOunHXo6dYKdRA0qmmdnv8eyLB5MwBomJu4/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736435; c=relaxed/simple;
	bh=n763b0RvpTofaCr5BebrQgTgr0bAylRbyPom2ZqFCig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2wpIKLwg4VnyKDx9o8/drLHT3nZLYjaDrJVM103GQhSJYBk2in0S5/m0EtOj5svrUacW8L/iYY/BihCZvj6bsQpvRWFaTsHmzCBkZYHCrYhMkNeo3BqH6vE7Ht28IoOyZOk2ZCWhMc82gnq+KYL37r+wmfRKDhD2kO4T330lUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXPurDvo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXPurDvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FB7C4CEF9;
	Fri, 17 Oct 2025 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736435;
	bh=n763b0RvpTofaCr5BebrQgTgr0bAylRbyPom2ZqFCig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bXPurDvoVIqh6Gs78MmE9b9zfXanaNR/Zyl3bbgzgt2brOSRKT5h5EmzoXmXS8708
	 pgULRBZdxO/78W0f6MUUiCDe3zOlAx3VQ1EpInR+bm0eJ28d5Nf2uCz6OqYJ+nKGw3
	 tLnhskbnFaoR5JtWXw5TruFQP4oQbs4hdCdyKJy19gW3hD11mAlLGUVvssb/LpKbs3
	 GJrw5FOsg9E6sB1QHWcfbOdyNYYIxhv1Q3lnzpF7pebwDT6AfWx53aKCHrqaMGruma
	 aeCC4uYHQGGtJ0HKvXt+pkcFZN0bbegKwbenrkG3oUfIE/PWbb6h06Dtgxv6llZFyZ
	 ot/eb8MQm9AqQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] mm/damon/sysfs-schemes: support DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Fri, 17 Oct 2025 14:26:57 -0700
Message-ID: <20251017212706.183502-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of DAMOS_QUOTA_NODE_MEMCG_USED_BP.  For this, extend quota
goal metric inputs for the new metric, and update DAMOS core layer
request construction logic to set the target cgroup, which is specified
by the user, via the 'path' file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2c440a2b80e6..c679e62fd4b9 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1030,6 +1030,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
 		.metric = DAMOS_QUOTA_NODE_MEM_FREE_BP,
 		.name = "node_mem_free_bp",
 	},
+	{
+		.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
+		.name = "node_memcg_used_bp",
+	},
 };
 
 static ssize_t target_metric_show(struct kobject *kobj,
@@ -2526,7 +2530,7 @@ static int damos_sysfs_add_quota_score(
 		struct damos_quota *quota)
 {
 	struct damos_quota_goal *goal;
-	int i;
+	int i, err;
 
 	for (i = 0; i < sysfs_goals->nr; i++) {
 		struct damos_sysfs_quota_goal *sysfs_goal =
@@ -2547,6 +2551,15 @@ static int damos_sysfs_add_quota_score(
 		case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 			goal->nid = sysfs_goal->nid;
 			break;
+		case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+			err = damon_sysfs_memcg_path_to_id(
+					sysfs_goal->path, &goal->memcg_id);
+			if (err) {
+				damos_destroy_quota_goal(goal);
+				return err;
+			}
+			goal->nid = sysfs_goal->nid;
+			break;
 		default:
 			break;
 		}
-- 
2.47.3
