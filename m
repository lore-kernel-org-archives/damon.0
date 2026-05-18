Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD5E33A9F3;
	Mon, 18 May 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147685; cv=none; b=huczkCrlMTqgVxc/zabq9BdM5neU1L1RYIyiDluXQG5ZzqQy4cJaeb6k7Lc1dX3/eEhKYybI52hZO+QgRqbmUJ7mXpMDRlENkcgTDNLuAAld00i7XT5fqwz6LXvX6EHMdVuI6vRD9WT+T7Ug/F9R5IXKO56uU/fKEwRT+bzMJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147685; c=relaxed/simple;
	bh=bf/w6G1Oz26zbX7WatE2cZ1YXPddmn7MtSESl1T9sTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rx2hHtUWr3Rr/qFKtZlwzmwLIQ9O7hwlnr6OSgXhUjVAs3JOATi51biuUFmGYSYqxN9Q/ZBL9R2wTuOW/6ZZkNd26d5aGRFKpRl77ZB9R+WMp5lC7SCD40KjCH8PSrhRkrWTOw3uwoXMhH/gbHtrnOaEjsTgca0o3Wuq5URw1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxLCnyTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxLCnyTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC1AC2BCF5;
	Mon, 18 May 2026 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147685;
	bh=bf/w6G1Oz26zbX7WatE2cZ1YXPddmn7MtSESl1T9sTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxLCnyTT5UlEzwdnpnmd2/EeZJAcwhJjx/sgWGqm9JU+OvQA5SU8JTYEZBWjnQUy+
	 POQ7oGyTNhcIZZP3nKet9oC/IRADspR6c6pNoFC5/rkHQHMnjowDIELTYUMyhXO5IF
	 MoeaIDKEVLkgOiPJHxuNgq8/wAEK+9XK54G8LmsCdqt5tfuVYIV27eykNBfiOl42nb
	 0a9lvnbRJMwOfqRvuyoejjOz+WpgUW6bHIadbYEMG98iQMBXwWK7aIufyXXJhMQTLT
	 gmcK+Dab82FVsyC5Xx7tm8Q1uQApDxqqCfGEh6vXcjAVsGQS49c82xZ/Dxj9hVQEnc
	 RqOTn1LGiyb0A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/28] mm/damon/core: introduce damon_filter
Date: Mon, 18 May 2026 16:40:51 -0700
Message-ID: <20260518234119.97569-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
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
index 43d71eb24ccb6..f8b679dd944d9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -730,12 +730,38 @@ struct damon_intervals_goal {
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
 
@@ -910,6 +936,12 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
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
 
@@ -957,6 +989,10 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_filter *damon_new_filter(enum damon_filter_type type,
+		bool matching, bool allow);
+void damon_add_filter(struct damon_probe *probe, struct damon_filter *f);
+
 struct damon_probe *damon_new_probe(void);
 void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6ce1b949efaa7..516368fbf1de3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -113,6 +113,31 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
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
@@ -120,6 +145,7 @@ struct damon_probe *damon_new_probe(void)
 	p = kmalloc_obj(*p);
 	if (!p)
 		return NULL;
+	INIT_LIST_HEAD(&p->filters);
 	INIT_LIST_HEAD(&p->list);
 	return p;
 }
@@ -136,6 +162,10 @@ static void damon_del_probe(struct damon_probe *p)
 
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
