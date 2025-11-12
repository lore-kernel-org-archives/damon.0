Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A1633D6EE;
	Wed, 12 Nov 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962127; cv=none; b=gfeHgTDUbJC3NYree0ZkB13a+2ivTrZIUY7apql60nvR2aAwlcDbbYcbjzeZsFsI1cH2AkToHcw/EtdUfmpKkYc5JCRZYKtLV1NLPx48bOKMsTwjbh13Mwq6mGDLzNfigWMT3Vxoo4k3YkInEgZ5aWizFlWL++CJrg7GGIkDCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962127; c=relaxed/simple;
	bh=NiZ7ea35pME1fM3maEI5aXEnDEDvdt1SSghBc/AiFyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYydFLrRPEI8kxH9/em+b2S9b7o18kH/wRbrmcXsLb41UbTPdLrrjKcGIFr94rZQgC1pK2SUhTwYcSDWHK4WS0D1p7l75tiav5s/o36SFPeaqX5qvUqyAXOp0GHXspUyU3k5MsInLg4IjHD5s2L/NY6HqI6YohtZbNb9OrZczKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R37Sx87/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R37Sx87/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B4EC19423;
	Wed, 12 Nov 2025 15:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962127;
	bh=NiZ7ea35pME1fM3maEI5aXEnDEDvdt1SSghBc/AiFyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R37Sx87/i8ZHQBhoTFE3dFsIlhXKSfafQa9RFcrnozAwKjGlQ6I43Gj+nu9r3YpI1
	 wZJuXfNsCUjC5eZyWKbnO5syAAPhPOKJabI09QgxpnHGorsMMlgnyOKVbdwhnUS63I
	 ONJdbjKKxW3SWgYr6p9SSeI/5zfJWBN355f90Acup8ovlYRmnS3yayYk1LT5pXP8Br
	 Ewgc0WKL3TTUXbHtqcJb+uioWEM+TVWg4aBVN9oCiR4ovVv3IWjz/JkFd/EUnK9hTp
	 P0UCtkGfo2OiALXDr5eMNuDw4caLVt5Mn+NZCCPvg8I5x+7XgkLkOQWt2Q8Nt25VSP
	 mc6lX1AxKFFuw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [PATCH 1/9] mm/damon: rename damos core filter helpers to have word core
Date: Wed, 12 Nov 2025 07:41:04 -0800
Message-ID: <20251112154114.66053-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters handled by the core layer are called core filters, while
those handled by the ops layer are called ops filters.  They share the
same type but are managed in different places since core filters are
evaluated before the ops filters.  They also have different helper
functions that depend on their managed places.

The helper functions for ops filters have '_ops_' keyword on their name,
so it is easy to know they are for ops filters.  Meanwhile, the helper
functions for core filters are not having the 'core' keyword on their
name.  This makes it easy to be mistakenly used for ops filters.
Actually there was such a bug.

To avoid future mistakes from similar confusions, rename DAMOS core
filters helper functions to have a keyword 'core' on their names.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .clang-format         |  4 ++--
 include/linux/damon.h |  4 ++--
 mm/damon/core.c       | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.clang-format b/.clang-format
index f371a13b4d19..748efbe791ad 100644
--- a/.clang-format
+++ b/.clang-format
@@ -140,8 +140,8 @@ ForEachMacros:
   - 'damon_for_each_scheme_safe'
   - 'damon_for_each_target'
   - 'damon_for_each_target_safe'
-  - 'damos_for_each_filter'
-  - 'damos_for_each_filter_safe'
+  - 'damos_for_each_core_filter'
+  - 'damos_for_each_core_filter_safe'
   - 'damos_for_each_ops_filter'
   - 'damos_for_each_ops_filter_safe'
   - 'damos_for_each_quota_goal'
diff --git a/include/linux/damon.h b/include/linux/damon.h
index f3566b978cdf..6e3db165fe60 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -871,10 +871,10 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damos_for_each_quota_goal_safe(goal, next, quota) \
 	list_for_each_entry_safe(goal, next, &(quota)->goals, list)
 
-#define damos_for_each_filter(f, scheme) \
+#define damos_for_each_core_filter(f, scheme) \
 	list_for_each_entry(f, &(scheme)->filters, list)
 
-#define damos_for_each_filter_safe(f, next, scheme) \
+#define damos_for_each_core_filter_safe(f, next, scheme) \
 	list_for_each_entry_safe(f, next, &(scheme)->filters, list)
 
 #define damos_for_each_ops_filter(f, scheme) \
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a14cc73c2cab..d4cb11ced13f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -450,7 +450,7 @@ void damon_destroy_scheme(struct damos *s)
 	damos_for_each_quota_goal_safe(g, g_next, &s->quota)
 		damos_destroy_quota_goal(g);
 
-	damos_for_each_filter_safe(f, next, s)
+	damos_for_each_core_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
 	damos_for_each_ops_filter_safe(f, next, s)
@@ -864,12 +864,12 @@ static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
 	return 0;
 }
 
-static struct damos_filter *damos_nth_filter(int n, struct damos *s)
+static struct damos_filter *damos_nth_core_filter(int n, struct damos *s)
 {
 	struct damos_filter *filter;
 	int i = 0;
 
-	damos_for_each_filter(filter, s) {
+	damos_for_each_core_filter(filter, s) {
 		if (i++ == n)
 			return filter;
 	}
@@ -923,15 +923,15 @@ static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
 	int i = 0, j = 0;
 
-	damos_for_each_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+	damos_for_each_core_filter_safe(dst_filter, next, dst) {
+		src_filter = damos_nth_core_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
 			damos_destroy_filter(dst_filter);
 	}
 
-	damos_for_each_filter_safe(src_filter, next, src) {
+	damos_for_each_core_filter_safe(src_filter, next, src) {
 		if (j++ < i)
 			continue;
 
@@ -1767,7 +1767,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	struct damos_filter *filter;
 
 	s->core_filters_allowed = false;
-	damos_for_each_filter(filter, s) {
+	damos_for_each_core_filter(filter, s) {
 		if (damos_filter_match(ctx, t, r, filter, ctx->min_sz_region)) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
-- 
2.47.3
