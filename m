Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219F33DEDD;
	Sat, 16 May 2026 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956645; cv=none; b=aAuqyFdfI3rkfYYs0CRc0P4zKQ4J4jGiYzdx7aVE8hDl4jzaJrgrTLLJYrXOqO3kNnEVslSlD17YYn1edUjgJWWXKWDUMQI8GvogC30Wkm0HS54yNJBAkJ/7zvmeILEPw8Es8CKB3NTAUFw3pBqvnM7gDxU3+Pr4VlS+YVtTqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956645; c=relaxed/simple;
	bh=9qp2MHSM8s3w0sFukfKdtDY+4dXqqo1Od1wtQQBaYpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsfE0ls+WyntEO0cqUyxXhCrECouOvAO3b/FClLOLjEsYu/tAD6g+dLM1DZg5dqGVQkeGXCUEN0uq+cvMbmWm2cmHg33z6BXSEdb33ijsYE5QZtCwF7IBM5lsOiOZM6GmwYJGdYNITLr4JeQiCUR8MkA3jW1NNnUvbcxq2NhpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw6wvPQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw6wvPQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BDBC2BCB8;
	Sat, 16 May 2026 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956645;
	bh=9qp2MHSM8s3w0sFukfKdtDY+4dXqqo1Od1wtQQBaYpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bw6wvPQLdsJaJizOt333zj+YEXZGuQp/R+IN+ZGEEyhPIguIJLOM3+JgFBFxg+ZJd
	 0kURv5jMOCCe0Mx/2aRuuEKYYM/xxQKUqhfhwnuzOFNFUwz4xwggQ9k4IiKKy/2dZ6
	 7rdD3Iet4yMtKXu45uWakL4NFH1V7wueUvx1gQmivjJzEZ+KaMD03FywtERAVTF7E7
	 6r5yfG9OMXVlYx7ovBZwNcfxw2PeAMX3xI0O6Pj+Ee8aNtiRCE+b/BSzx+8dAiPQR9
	 VGqpHtGEZQToRKE7bSDTYpa0VcAvnjNKmwJsVGPswoDuzqX3oEbiMOSYXsZH56EdlR
	 azn6CgVwxd9Eg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 03/28] mm/damon/core: introduce damon_filter
Date: Sat, 16 May 2026 11:36:44 -0700
Message-ID: <20260516183712.81393-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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
index d15f47a321d88..32005b8b1f8cd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -721,12 +721,38 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * enum damon_filter_type - Type of &struct damon_filter
+ *
+ * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
+ */
+enum damon_filter_type {
+	DAMON_FILTER_TYPE_ANON,
+};
+
+/**
+ * struct damon_filter - DAMON region filter for &struct damon_probe.
+ *
+ * @type:	Type of the region.
+ * @matching:	Whether this filter is for the type-matching ones.
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
 
@@ -880,6 +906,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_filter(f, p) \
+	list_for_each_entry(f, &(p)->filters, list)
+
+#define damon_for_each_filter_safe(f, next, p) \
+	list_for_each_entry_safe(f, next, &(p)->filters, list)
+
 #define damon_for_each_probe(p, ctx) \
 	list_for_each_entry(p, &(ctx)->probes, list)
 
@@ -927,6 +959,10 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_filter *damon_new_filter(enum damon_filter_type type,
+		bool matching, bool allow);
+void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0e55fa70fa5b6..44943d654dcce 100644
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
