Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC203E3160;
	Thu, 13 Aug 2026 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599883; cv=none; b=nvaqFCj8LgWKh34Kj9rDTvLdJzsGYL6Rn5ntc8XZkV4u4YS8Us8v/90qfSy2ehKPieBJwymibCrYJurqIuFvdCf0xue3Ve4fapFqiIV5mWmigV6v+ZL6TFHvot5BIHZnGK+/VoZ7O9XasJ4k8VZleqOoF4UWx4N9fDX6/Ac3k+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599883; c=relaxed/simple;
	bh=akhgfTDbw6hVvE+84o0NhYRf+lwaiCMkUipusX6VUfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGH1aML100f7NiB7/4C+W4o/xFpRW8wao2x4UFzQ2Q7jGaBFRv9MzWtRx4BWyh2dz56kFZ5gPhHQ2lha8ceWfBCBWfUFYIxFmgtH76CwqB7qKy5YjggywqB10Lus2Na8mkxVQVoggeYpxKjgvQUwAO9Usr+IzguUqmlOnuAR0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvZ4nl92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvZ4nl92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C141F00A3A;
	Thu, 13 Aug 2026 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599882;
	bh=fXLkVAHbgjaWy56zhYvF1vnHi1V0hiXRFOM3tY/zcKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvZ4nl92JoDuDADgB+BpCGre4XpGPaT+GvKTadtgGwJmhVp055oVE4Q6/YPCaeON1
	 EcNwwIKapv2jGvsBMANiDwhPdbUznOMpJhbrbEcJQUKoSSIbm8ZAlljPm9u4/miSD3
	 J3BGXWa5sz9cIYQCmRfF9wwQcZ64GANcp70Yz92DRahvDwaH+SswDKfHBX2JhyiPDc
	 x60IDkf7P2XQS04sG0HD09gFIVkZFxteITGAlVkQUOmNMOYgQujVlENXlF8XLXdV6f
	 u+aP7olg/Vv+o1DTWruYlk7q7V96NWvk1UZfp/GwUCOJbg7cSfzjAbuNVwvfPj4wSN
	 03yY6NmvtWysQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/3] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Wed, 12 Aug 2026 22:44:28 -0700
Message-ID: <20260813054432.101197-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813054432.101197-1-sj@kernel.org>
References: <20260813054432.101197-1-sj@kernel.org>
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
index 5a92e4fac6d92..183d505c08e4e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1193,15 +1193,18 @@ static void damos_commit_quota_goal_union(
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
 	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
+	return 0;
 }
 
 /**
@@ -1219,14 +1222,17 @@ static void damos_commit_quota_goal(
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
@@ -1235,7 +1241,11 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
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
