Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF7137750;
	Thu, 27 Feb 2025 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621482; cv=none; b=GN6k9zT99EwBe1Ke6SFK5dI2KnIgEprKW1pqruZzNRVv1ZkcSJmWkSld4tty0OMpiiQUnZCYmHL1Kg5wtEwT4rdqqEYDkfCzxAzv+OJ7TouX8ebQlNkSQtq+cqSEqFNiTSfRgXiR4VX+hbuOF8EJyw5Djklxv89p/62a/cda8+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621482; c=relaxed/simple;
	bh=rhFsNhRUaSQHgawNxfN1Ke4vP/OFw5KgXJOej1ppOTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fx2WY0qQ5EY8GNgr5qcjM2nRz2hQk7Auh+E9TpBYA01mHH7cF7Azk5lt7OUiVvaH8ENBclm0jNnitisGyUxG4HE2dNyB6lp1I/35QhHTQIVCg6KGD0sEcS4pczknTpmgB1SZEop4Q7ka6JYf7eMgRBxZbzShqkEWV/93jt2Q3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js2t26O2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js2t26O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F20C4CED6;
	Thu, 27 Feb 2025 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621482;
	bh=rhFsNhRUaSQHgawNxfN1Ke4vP/OFw5KgXJOej1ppOTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=js2t26O2XKtZGE3Dz4T21JiIIrbyHgstsd9l+raa3zsams1DBAgkQLkYwPi0NyhRI
	 q4ldhoGPKcn51cyoqXBfa241uVi4FuI0GkLDtQTqv6fOeOKZ9we1erdUXNZQDoJTgS
	 dxsQ8tRhCKepDOSGM+pbDpHllMX4mXc4BllITmwitSgviys/u6csxyHxEdALwpIpZR
	 i4X82CfixbZv4fpJALo0oUbF0LwikzrkVKhQIwo2KodrClxrSO/lyZ8IbGDHnBmFGk
	 GjrHenlFCJrjUDy9GHEPykIBZ/GF/NuiVphMdYE1Eth3aYmkkPr/6LzCVfYcjfpOFo
	 AJ+zQgiMnBp9g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/9] mm/damon/core: introduce damos->ops_filters
Date: Wed, 26 Feb 2025 17:57:46 -0800
Message-Id: <20250227015754.38789-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters can be categorized into two groups depending on which
layer they are handled, namely core layer and ops layer.  The groups are
important because the evaluation sequence of filters decides the overall
behavior, and core layer-handled filters are evaluated before operations
layer-handled ones.

Currently, all filters are maintained in a single list (damos->filters)
in mix.  Filters evaluation logics in core layer and operations layer
iterates all the filters on the list, while skipping filters that should
be not handled by the layer of the logic.  It is inefficient.  Making
future extensions having differentiations for filters of different
handling layers will also be complicated.  Add a new list that will be
used for having all operations layer-handled DAMOS filters to DAMOS
scheme data structure, with support of its initialization and basic
traversals.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 8 ++++++++
 mm/damon/core.c       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 795ca09b1107..add82fdc1117 100644
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
@@ -503,6 +504,7 @@ struct damos {
 		int target_nid;
 	};
 	struct list_head filters;
+	struct list_head ops_filters;
 	void *last_applied;
 	struct damos_stat stat;
 	struct list_head list;
@@ -810,6 +812,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
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
index 38f545fea585..bcb7e42098dc 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -374,6 +374,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	 */
 	scheme->next_apply_sis = 0;
 	INIT_LIST_HEAD(&scheme->filters);
+	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
 
-- 
2.39.5
