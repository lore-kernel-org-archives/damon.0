Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313B15E5BC;
	Tue, 18 Jun 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734697; cv=none; b=cnWBeuHxjZmkLOZ1FcNvoaKer5g0loQx5X3U6mqSA9+3LJEEBZnkt+Unwfd6jRHQ4xl6IQdgHN3xwVUBn19DXFb2lc24W71hisv7kFmVVAQDhC1he3NJZYl4i1gSsWSlDvUBhVzYeCFWCzqTNE7GnEF52JGMnm1npU4AoQ1IMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734697; c=relaxed/simple;
	bh=7hRdxjHOSIuwrdZCOKzvtYTSDa0l/gnw+9kuPa/0bZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpKgAAPH73E5CPKCl4qkgBCuSo9rs9FleChmJJcx6xjfeJxlr4hlrHZbgTzRPwIugEy8UdqoDlpvlGtCTiFjM9UDimdeY422mD1WzN2QTV0P4Z6bssVC2Xzkpa9l0bfORYrWDOQNYxMGGzvG0nLMKegZ1Vjmbkf1XRN7QORbg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkohSxYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkohSxYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D542BC4AF48;
	Tue, 18 Jun 2024 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734697;
	bh=7hRdxjHOSIuwrdZCOKzvtYTSDa0l/gnw+9kuPa/0bZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkohSxYoVet+2VnInROCLHYvbmT/IcPl8P0ZgsPJ3X5uqKAAALvILpaMNTgGw2HL+
	 pA+wVpDtiRRJCmbVDvwOy8kIDC3Ybx/M7EllPDu5PiuRpxWxCTL1Q0o//xVXjeXAGc
	 PyxuRULZuqMY6uvSC9/eijvV1adFiBJ7alMLDXzn7OXN4Zl0nxghlYw9X1AKmLb/8K
	 rMXmH7ZDhYb7tpjfcBqUr0HQacYPAy6ttPJ76I2ENZCQwJaXxJVzD1oE9uKvrub2Wt
	 6v82xCBHrO/7cykYCj+gtLR88OKpLBk1gH6iTcPcMlSflBWhDl/2OVHuce76tLx/hu
	 h+yFlMoGobSuQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] mm/damon/core: implement DAMOS quota goals online commit function
Date: Tue, 18 Jun 2024 11:17:58 -0700
Message-Id: <20240618181809.82078-2-sj@kernel.org>
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

Implement functions for supporting online DAMOS quota goals parameters
update.  The function receives two DAMOS quota structs.  One is the
struct that currently being used by a kdamond and therefore to be
updated.  The other one contains the parameters to be applied to the
first one.  The function applies the new parameters to the destination
struct while keeping/updating the internal status.  The function should
be called from parameters-update safe place, like DAMON callbacks.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3d62d98d6359..ce12c9f1b4e4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -742,6 +742,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 			int target_nid);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
+int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src);
 
 struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c0ec5be4f56e..b538a31fbd83 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -666,6 +666,65 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 		damon_add_scheme(ctx, schemes[i]);
 }
 
+static struct damos_quota_goal *damos_nth_quota_goal(
+		int n, struct damos_quota *q)
+{
+	struct damos_quota_goal *goal;
+	int i = 0;
+
+	damos_for_each_quota_goal(goal, q) {
+		if (i++ == n)
+			return goal;
+	}
+	return NULL;
+}
+
+static void damos_commit_quota_goal(
+		struct damos_quota_goal *dst, struct damos_quota_goal *src)
+{
+	dst->metric = src->metric;
+	dst->target_value = src->target_value;
+	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
+		dst->current_value = src->current_value;
+	/* keep last_psi_total as is, since it will be updated in next cycle */
+}
+
+/**
+ * damos_commit_quota_goals() - Commit DAMOS quota goals to another quota.
+ * @dst:	The commit destination DAMOS quota.
+ * @src:	The commit source DAMOS quota.
+ *
+ * Copies user-specified parameters for quota goals from @src to @dst.  Users
+ * should use this function for quota goals-level parameters update of running
+ * DAMON contexts, instead of manual in-place updates.
+ *
+ * This function should be called from parameters-update safe context, like
+ * DAMON callbacks.
+ */
+int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
+{
+	struct damos_quota_goal *dst_goal, *next, *src_goal, *new_goal;
+	int i = 0, j = 0;
+
+	damos_for_each_quota_goal_safe(dst_goal, next, dst) {
+		src_goal = damos_nth_quota_goal(i++, src);
+		if (src_goal)
+			damos_commit_quota_goal(dst_goal, src_goal);
+		else
+			damos_destroy_quota_goal(dst_goal);
+	}
+	damos_for_each_quota_goal_safe(src_goal, next, src) {
+		if (j++ < i)
+			continue;
+		new_goal = damos_new_quota_goal(
+				src_goal->metric, src_goal->target_value);
+		if (!new_goal)
+			return -ENOMEM;
+		damos_add_quota_goal(dst, new_goal);
+	}
+	return 0;
+}
+
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
  */
-- 
2.39.2

