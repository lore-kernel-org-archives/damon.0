Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2C2F1FEF;
	Sun, 26 Apr 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236755; cv=none; b=A6aVQjisyWD2zjI4jMzJDxf113BUtO8LEoBJEAsIU0QGu+xgF3hgroa0jFkPujm3RDXzYhkd6i5NB0mv1Q6lExSLRUZ4HyvoOGEpKWGCQzF30L5j/oZxpk2QtPqaXXDfAOiDkK9Ce1BGyFe0XVHFiwMTy2OgqpkUgsAivsuBe5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236755; c=relaxed/simple;
	bh=ssUx+oZtCnXAftQFdGVKJ2duGR6qwdo9mJW3FrliT4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQg4EPqvHRIqowiw7ezmxko90JjJjWAhKm0bRq99j+mEEda5Mdwj2K02f+3vRzm1XbgqbSqqNmlCgx3X2j9I2OOMmyQicRegAmmGXaobwYs+SueMiYLTL3NVVwfrSudEZP+EeHlH4AYrzNoOdh83zlqGW0LWu7FxwUJvTjHgYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4ybWyt1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4ybWyt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9E8C2BCB4;
	Sun, 26 Apr 2026 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236755;
	bh=ssUx+oZtCnXAftQFdGVKJ2duGR6qwdo9mJW3FrliT4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4ybWyt1ndP5z/2On8DxGztXhJNX5X+YtMrrJCoV2D4wzTwKcgbCmbHnDx6tHubF6
	 uviyhSgXNMgpPEcU37xIktpHGf3dwx2oR/QyVDZ2MAH1K183q5RLhDKRFyP/b2NAgF
	 7enksJBYZa6xHYFvU1AI3nUJ+bQ0nqqKqFT6DpRScAoqdBtzMWySbxWJ4txqFwLTdO
	 3GT0ZWG7VTao4tyPEnIvMHng5vPlAFYZYY3wKI34tYfiK7ZEZeO1575hK5DpGTcMpx
	 MmYSC+iwrmE2RFYcB+IZl66VFLU6CfxJz/7EIvE+4NdaPM1HXfg5KlSpzCju8REm1V
	 J3s3GgfW0fPAA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/19] mm/damon/core: introduce damon_filter
Date: Sun, 26 Apr 2026 13:52:04 -0700
Message-ID: <20260426205222.93895-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-1-sj@kernel.org>
References: <20260426205222.93895-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a data structure for constructing damon_probe's attributes check,
namely damon_filter.  It is very similar to damos_filter but works only
for monitoring purposes.  Also embed that into damon_probe, implement
essential handling of the link, with fundamental helpers.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 65d7ee0a70ac0..3290792eab547 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -732,12 +732,38 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * enum damon_filter_type - Type of &struct damon_filter
+ *
+ * @DAMON_TEST_TYPE_ANON:	Anonymous pages.
+ */
+enum damon_filter_type {
+	DAMON_TEST_TYPE_ANON,
+};
+
+/**
+ * struct damon_filter - DAMON region filter for &struct damon_probe.
+ *
+ * @type:	Type of the region.
+ * @matcing:	Whether this filter is for the type-matching ones.
+ * @allow:	Whether the @type-@matching ones should pass this filter.
+ * @list:	Siblings list.
+ */
+struct damon_filter {
+	enum damon_filter_type type;
+	bool matching;
+	bool allow;
+	struct list_head list;
+};
+
 /**
  * struct damon_probe - Data region attribute probe.
  *
+ * @filters:	Filters for assessing if a given region is for this probe.
  * @list:	Siblings list.
  */
 struct damon_probe {
+	struct list_head filters;
 	struct list_head list;
 };
 
@@ -893,6 +919,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_filter(f, p) \
+	list_for_each_entry(f, &p->filters, list)
+
+#define damon_for_each_filter_safe(f, next, p) \
+	list_for_each_entry_safe(f, next, &p->filters, list)
+
 #define damon_for_each_probe(p, ctx) \
 	list_for_each_entry(p, &ctx->probes, list)
 
@@ -940,6 +972,10 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_filter *damon_new_filter(enum damon_filter_type type,
+		bool matching, bool allow);
+void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 861ab977d1edf..170abba8fdf2a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -109,6 +109,31 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	return err;
 }
 
+struct damon_filter *damon_new_filter(enum damon_filter_type type,
+		bool matching, bool allow)
+{
+	struct damon_filter *filter;
+
+	filter = kmalloc_obj(*filter);
+	if (!filter)
+		return NULL;
+	filter->type = type;
+	filter->matching = matching;
+	filter->allow = allow;
+	INIT_LIST_HEAD(&filter->list);
+	return filter;
+}
+
+void damon_add_filter(struct damon_probe *p, struct damon_filter *f)
+{
+	list_add_tail(&f->list, &p->filters);
+}
+
+static void damon_free_filter(struct damon_filter *f)
+{
+	kfree(f);
+}
+
 struct damon_probe *damon_new_probe(void)
 {
 	struct damon_probe *p;
@@ -116,6 +141,7 @@ struct damon_probe *damon_new_probe(void)
 	p = kmalloc_obj(*p);
 	if (!p)
 		return NULL;
+	INIT_LIST_HEAD(&p->filters);
 	INIT_LIST_HEAD(&p->list);
 	return p;
 }
@@ -132,6 +158,10 @@ static void damon_del_probe(struct damon_probe *p)
 
 static void damon_free_probe(struct damon_probe *p)
 {
+	struct damon_filter *f, *next;
+
+	damon_for_each_filter_safe(f, next, p)
+		damon_free_filter(f);
 	kfree(p);
 }
 
-- 
2.47.3
