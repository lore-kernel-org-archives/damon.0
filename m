Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797392641F4;
	Tue,  4 Mar 2025 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123158; cv=none; b=ZhTpiwKC6GLRQ+YiX2t+FfFU43+aogEQJEfhxKnrjiWPAVE2vDonX4Ltgq4wcXZL3mjsAGXXutw2hMVJsJeUZl8+j7zldDNu0ViElczpffAfxcs37iSmwvZlZhfJOXEp4Av9I3d0QoOmY6hlUiohxGPlohWPSZsNFT6IfgOcKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123158; c=relaxed/simple;
	bh=1+GLBKsLzSxJFQ7DWFpnQ3RNIvFxJfA/ezMRoeI16Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltx/6VWDHBygDlXMAqteUYuCW7o9V0FUJBKeBSJCNRWhYXjgLKx3dURtMMK/FNDpeGcMc/pgEyzOR45L1r8wYZsZKVdtgAWkTTHe4NtXp23JHArczcZsPo86w9R+4SqCZi2JRddC0K+zy8NFbNMIGgKV5WZCIuWRjB9C8F8LIuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPOgLZev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPOgLZev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C948EC4CEE5;
	Tue,  4 Mar 2025 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123158;
	bh=1+GLBKsLzSxJFQ7DWFpnQ3RNIvFxJfA/ezMRoeI16Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPOgLZevkRvv7BLRFMCqBUuVRZGPlsN3CRS72TzgxGKYe0HfDe6lxR8n2UmyNc768
	 JGMTJ5QSmwvaJDLrkIK1Wo8y0357xd7Y+GaxxDa6dcrtti3tJcE3bO98fw57l4VpQU
	 eMzvTQMcgCr3stTR9Lj3KufTiP3onmpvw4Ra9zpe7FsKOisvmvwVcoW/b3Z8KNXG3s
	 Pu1yLZj6amxGpf/SryrRWQlM31f6MPN60U9DC+zNLLBhj0i4iCSEfHzJDuts7HqMDp
	 X+/+NUomBDp5hzyCriU0l0T7KjDX6siT8E2FF2n3KIWwK0Ru5GI8OZrGn6sOsdV8Qf
	 PkVpilH0sKigQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/9] mm/damon/core: introduce damos->ops_filters
Date: Tue,  4 Mar 2025 13:19:05 -0800
Message-Id: <20250304211913.53574-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters can be categorized into two groups depending on which
layer they are handled, namely core layer and ops layer.  The groups are
important because the filtering behavior depends on evaluation sequence
of filters, and core layer-handled filters are evaluated before
operations layer-handled ones.

The behavior is clearly documented, but the implementation is bit
inefficient and complicated.  All filters are maintained in a single
list (damos->filters) in mix.  Filters evaluation logics in core layer
and operations layer iterates all the filters on the list, while
skipping filters that should be not handled by the layer of the logic.
It is inefficient.  Making future extensions having differentiations for
filters of different handling layers will also be complicated.

Add a new list that will be used for having all operations layer-handled
DAMOS filters to DAMOS scheme data structure.  Also add the support of
its initialization and basic traversal functions.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 8 ++++++++
 mm/damon/core.c       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index b3e2c793c1f4..7f76e2e99f37 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -448,6 +448,7 @@ struct damos_access_pattern {
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
+ * @ops_filters:	ops layer handling &struct damos_filter objects list.
  * @last_applied:	Last @action applied ops-managing entity.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
@@ -508,6 +509,7 @@ struct damos {
 		int target_nid;
 	};
 	struct list_head filters;
+	struct list_head ops_filters;
 	void *last_applied;
 	struct damos_stat stat;
 	struct list_head list;
@@ -858,6 +860,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damos_for_each_filter_safe(f, next, scheme) \
 	list_for_each_entry_safe(f, next, &(scheme)->filters, list)
 
+#define damos_for_each_ops_filter(f, scheme) \
+	list_for_each_entry(f, &(scheme)->ops_filters, list)
+
+#define damos_for_each_ops_filter_safe(f, next, scheme) \
+	list_for_each_entry_safe(f, next, &(scheme)->ops_filters, list)
+
 #ifdef CONFIG_DAMON
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9d37d3664030..5415b7603d01 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -375,6 +375,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->next_apply_sis = 0;
 	scheme->walk_completed = false;
 	INIT_LIST_HEAD(&scheme->filters);
+	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
-- 
2.39.5
