Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FA526460D;
	Thu, 20 Feb 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080118; cv=none; b=GBCEgzslb9tJYp75mf/PhhdK8iCepWVjPxAQlFaVHrlnklHajlgSyNcwigsvVtcHRUlW3yRSCD4hdg0QuKKaCw4bVELXjU0BBpvEOE6GzCC5XC081qSBhV+EhlegHw9cjS1EUjeDe1pdGlhs7QEFLfUvVrkE4K6Fm/qLIefFXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080118; c=relaxed/simple;
	bh=vASrAL/pnHBXCkrPC/c/PavcC1+wtiSIVa/v3Hmh35w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sKOiFRn6Plz3W8E+j9bBk6VJil3LtkkwwApxEWpJzddqMKIML3TbIkW3TF5VM1PFE3pIHmgkB03GIRyR622ecyBdxMI+RBAM7dKqRXU+WoMNo5wYVHu9N3DGHmzm+4Gzvg1rIAddJLH5XKi5OJeXT8gYGnbNVIMEhPu26QcXqjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8MMfv/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8MMfv/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4DCC4CED1;
	Thu, 20 Feb 2025 19:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080115;
	bh=vASrAL/pnHBXCkrPC/c/PavcC1+wtiSIVa/v3Hmh35w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8MMfv/tOGNBm1TAxJCJDAx4QYLjeYuaj6aAYaqtgN0vsN33ugXGEIHaijFDoIquG
	 hLi2NLkdNHlU/CFkARa3eUpElnZLE1UdG9kRTP7K0eHH9qBlhme2MEp0+wAEfP7+I0
	 t9G5Uy34RRTBzJSCbKuKIKfwqtoVj/Us5EY+LGCbn7qT2JbrkRV3Is/No+Iwq1lJVk
	 ln3aK/2A4z2vLOp8Tik53VVrLURf9TjF9L3U1buOI51CMrFaRNs1w+9A+Xo2UCY5fh
	 +ZTGB87uLddNh2LGGQCm133hhclagskCW+4JjKQ5t5U+lK4ajkxzxNNF8ibAfb1JWr
	 u2qF/Qu63N8NA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/9] mm/damon/core: introduce damos->ops_filters
Date: Thu, 20 Feb 2025 11:35:01 -0800
Message-Id: <20250220193509.36379-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters can be categorized into two groups depending on which
layer they are handled, namely core layer and ops layer.  Also their
evaluation sequence is decided by the categorization.  Currently, all
filters are maintained in single list in mix.  It makes the filters
evaluation loop inefficient since it should do the categorization in the
loop for every iteration.  Introduce another list that will be used for
having all operations layer-handled DAMOS filters.

Note that this change simply adds the list and does not change any DAMON
code to use it in real.  It will be done by following changes.

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
