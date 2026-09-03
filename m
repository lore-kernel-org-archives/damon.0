Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4538282F03;
	Thu,  3 Sep 2026 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397650; cv=none; b=tGIAYe2Ty6T9GBGD5/48FqCcQFT0Vyr9rnPs8FhSdm1gGNC66tEUtHaDwukYY4vON8l/6SHw2XIJYiwBJeWlEMshtJIT4Gpd0j17viQbQDf7pYUn1RU6ZbQwPL6nsJG73wJPEpZViELII2Ln5sZhWEpBpfdiMgOssfu0GZ+jC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397650; c=relaxed/simple;
	bh=p2zMxKh68xFaCW7ziOQznGepGBTgaox7iBIqZjpl2U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X71W8sS3/jMcyOUyHFCCtc2YXH0WAygek8bC3MPOSjHiz32j7DZZqi46uEeMK0EViQjpe7enEBe8NzMspWTug7aJQKNKvz9qhfh7QuAfobqUtTju8dU1S+CHvsocapIKY9WC9pW2GW6/yIc8F+6WauONyxq1IpgjzpfCGZdt8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huWcm2b3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huWcm2b3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AEF1F00A3A;
	Thu,  3 Sep 2026 01:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397649;
	bh=a9IM/Ej4irsu0tekSCIZa7xad+wT2QHGn683VTr7Q88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huWcm2b3wYceGKjjjwjPQBzLv+hRL5m1+3L96P+Dy7mb8+EOVh0ZG7ka055pt4CQ4
	 O/yPRyz4jI002lrsN1mNDvJJirJXLV8WEwBh08RFyqVJsYYnyvJw5v1HEt/FDS1fIz
	 wjex7RFagx+jP6A4+tQrp2zPlXnczIk2g3zd7bLlgSGjBqYt28/7NCEIJiyRn9zuUZ
	 tPQxJvCPWAP8d2ZQld1rkG6FABZbFKrUp908uIUDKnioz7ozLp91G5QAwX1V3K3b76
	 kSWO/++MpfPUfEtHnDPJC1zA7KY/v7TqP3LOnZNX6FbcROeznspzN4wOoIGpnVsl/K
	 HpKzS1nupRz2w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Wed,  2 Sep 2026 18:07:19 -0700
Message-ID: <20260903010722.94244-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010722.94244-1-sj@kernel.org>
References: <20260903010722.94244-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a DAMOS scheme has a damos_quota_goal of zero target_value,
damos_quota_goal() could trigger division-by-zero error.  Hence each
DAMON API callers should do the zero target_value validation.  It is
easy to make mistakes.  Actually such bugs in DAMON_LRU_SORT and
DAMON_SAMPLE_MTIER were found and fixed [1].

It is better to handle the corner case only once in the core layer,
instead of multiple places in all DAMON API callers.  One
straightforward option is using an alternative denominator for the
corner case in the damos_quota_goal().  However, the zero target_value
is meaningless.  In this case, the quota goal is always evaluated as
achieved or over-achieved.  The quota will only keep being reduced.

Simply avoid using zero target_value by adding a check in the core layer
DAMOS quota goal parameters validation/commit path,
damos_commit_quota_goal().  Update it to return an error in the case.
Also update its caller to propagate the error.

[1] https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 56ec6f616fa9a..89d1c77417450 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1212,14 +1212,17 @@ static void damos_commit_quota_goal_union(
 	}
 }
 
-static void damos_commit_quota_goal(
+static int damos_commit_quota_goal(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
+	if (!src->target_value)
+		return  -EINVAL;
 	dst->metric = src->metric;
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
 	damos_commit_quota_goal_union(dst, src);
+	return 0;
 }
 
 /**
@@ -1237,14 +1240,17 @@ static void damos_commit_quota_goal(
 int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 {
 	struct damos_quota_goal *dst_goal, *next, *src_goal, *new_goal;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damos_for_each_quota_goal_safe(dst_goal, next, dst) {
 		src_goal = damos_nth_quota_goal(i++, src);
-		if (src_goal)
-			damos_commit_quota_goal(dst_goal, src_goal);
-		else
+		if (src_goal) {
+			err = damos_commit_quota_goal(dst_goal, src_goal);
+			if (err)
+				return err;
+		} else {
 			damos_destroy_quota_goal(dst_goal);
+		}
 	}
 	damos_for_each_quota_goal_safe(src_goal, next, src) {
 		if (j++ < i)
@@ -1253,7 +1259,11 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 				src_goal->metric, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
-		damos_commit_quota_goal(new_goal, src_goal);
+		err = damos_commit_quota_goal(new_goal, src_goal);
+		if (err) {
+			damos_free_quota_goal(new_goal);
+			return err;
+		}
 		damos_add_quota_goal(dst, new_goal);
 	}
 	return 0;
-- 
2.47.3
