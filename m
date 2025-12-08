Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46531D366;
	Mon,  8 Dec 2025 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175414; cv=none; b=Hck9KG0fDUA0+BO38Tlg05NAFU5CLV6bANM60pesNJgFifhB0DFDXyDrNMv0FVom0bXsWi9I8SwC/zbEcpI2QZDeywCE543/6dTJeF7w6MNu94W8E0ISivC3JZhOsYrbzLhFSu5GB7l/blV7OIHI9btH3bJjEZMJC4RCCIKmIpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175414; c=relaxed/simple;
	bh=YPnSi5M7u97aTRieMiHi7Bu1nhCZ+HHUKBFpBBpeqKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7wwYgUPmPPBpRnL/kENzjyBvqLM/fCL44eCfgNuSYrPI9Z4kUioGEA8L9EF6ciFjgHQt5o03zxZPGKtv+F42SPPGfNOwDZRLccq0aMLip0WgZiVOwx+yDslzk1ebKJKftViUK7j0G1sL3Dem0VGKAc02f7xyA/quSLQboEGQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwtpk9Vd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwtpk9Vd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2673C113D0;
	Mon,  8 Dec 2025 06:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175413;
	bh=YPnSi5M7u97aTRieMiHi7Bu1nhCZ+HHUKBFpBBpeqKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwtpk9Vd4vrAjXdu+Ctd4td0gpjFcxyLgrazZzrenIIZvhJn+IUMrfbqM012cAkPK
	 4VyOKWJtp1gDHMdQ+i+MyhhJ9tz0oclTNl3ruANfwuKzTKbjbMp2uGqePbWHoHvztQ
	 9ghRHb7AHRZZAzH7iYKqlNrPAZuYtfgfBcdH2H3O6fZDYHfpA3bAQeGokqZ2OQ1dCs
	 t9bkI/OOqV/F5+nKVCawY9qS0EMKXsyDlervg5viMH36AAOUy0zD54FEcU6VMZwRo4
	 Mv6ak+y8CjbpLzR5hpINFvZFct2LEgTwreIMdv27mspWLjTQY1JJM9FHFUlEmrMoGK
	 TJgbSfE0dwdPw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 16/37] mm/damon/core: implement damon_sample_filter manipulations
Date: Sun,  7 Dec 2025 22:29:20 -0800
Message-ID: <20251208062943.68824-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic manipulation helper functions for damon_sample_filter data
structure.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 15 +++++++++++++++
 mm/damon/core.c       | 45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 78be584ce5dd..aff34dce7c7c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -947,6 +947,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 #define damon_for_each_target_safe(t, next, ctx)	\
 	list_for_each_entry_safe(t, next, &(ctx)->adaptive_targets, list)
 
+#define damon_for_each_sample_filter(f, control) \
+	list_for_each_entry(f, &(control)->sample_filters, list)
+
+#define damon_for_each_sample_filter_safe(f, next, control) \
+	list_for_each_entry_safe(f, next, &(control)->sample_filters, list)
+
 #define damon_for_each_scheme(s, ctx) \
 	list_for_each_entry(s, &(ctx)->schemes, list)
 
@@ -1022,6 +1028,15 @@ void damon_free_target(struct damon_target *t);
 void damon_destroy_target(struct damon_target *t, struct damon_ctx *ctx);
 unsigned int damon_nr_regions(struct damon_target *t);
 
+struct damon_sample_filter *damon_new_sample_filter(
+		enum damon_sample_filter_type filter_type, bool matching,
+		bool allow);
+void damon_add_sample_filter(struct damon_sample_control *ctrl,
+		struct damon_sample_filter *filter);
+void damon_free_sample_filter(struct damon_sample_filter *filter);
+void damon_destroy_sample_filter(struct damon_sample_filter *filter,
+		struct damon_sample_control *ctrl);
+
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index d2f842d8afd2..4b98473eef84 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -533,6 +533,46 @@ unsigned int damon_nr_regions(struct damon_target *t)
 	return t->nr_regions;
 }
 
+struct damon_sample_filter *damon_new_sample_filter(
+		enum damon_sample_filter_type filter_type, bool matching,
+		bool allow)
+{
+	struct damon_sample_filter *filter;
+
+	filter = kmalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return NULL;
+	filter->type = filter_type;
+	filter->matching = matching;
+	filter->allow = allow;
+	INIT_LIST_HEAD(&filter->list);
+	return filter;
+}
+
+void damon_add_sample_filter(struct damon_sample_control *ctrl,
+		struct damon_sample_filter *filter)
+{
+	list_add_tail(&filter->list, &ctrl->sample_filters);
+}
+
+static void damon_del_sample_filter(struct damon_sample_filter *f,
+		struct damon_sample_control *ctrl)
+{
+	list_del(&f->list);
+}
+
+void damon_free_sample_filter(struct damon_sample_filter *f)
+{
+	kfree(f);
+}
+
+void damon_destroy_sample_filter(struct damon_sample_filter *f,
+		struct damon_sample_control *ctrl)
+{
+	damon_del_sample_filter(f, ctrl);
+	damon_free_sample_filter(f);
+}
+
 struct damon_ctx *damon_new_ctx(void)
 {
 	struct damon_ctx *ctx;
@@ -561,6 +601,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->sample_control.primitives_enabled.page_table = true;
+	INIT_LIST_HEAD(&ctx->sample_control.sample_filters);
 
 	ctx->addr_unit = 1;
 	ctx->min_sz_region = DAMON_MIN_REGION;
@@ -582,12 +623,16 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 void damon_destroy_ctx(struct damon_ctx *ctx)
 {
 	struct damos *s, *next_s;
+	struct damon_sample_filter *f, *next_f;
 
 	damon_destroy_targets(ctx);
 
 	damon_for_each_scheme_safe(s, next_s, ctx)
 		damon_destroy_scheme(s);
 
+	damon_for_each_sample_filter_safe(f, next_f, &ctx->sample_control)
+		damon_destroy_sample_filter(f, &ctx->sample_control);
+
 	kfree(ctx);
 }
 
-- 
2.47.3
