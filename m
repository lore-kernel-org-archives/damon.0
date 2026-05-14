Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC753DD85B;
	Thu, 14 May 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767759; cv=none; b=p6qg/ayNKO2bsWy9ma6zck5ZIzkOVNXodyoHdlqEqvC7eODdNAM7SgduU/hduXqRRNxzVhRPpyr1BY2rtljX/ltP+jtZ+uG+ZdwgbaU8/bXodg4rlAOVgpa70rrcJaBDjsM1D1dqFA3PteCRwQSlSy0IgUpeXpKAU/lZS8BSKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767759; c=relaxed/simple;
	bh=zvNnkp+6yNBQFjvFCmCTyrnoUvo/qS1CeDP5FbHiLzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bY5kOon8ntMiz82E05JSklhsLc2iD1Oh58hFSJ3h/V/VPxdRk6Z7ufzunLRSReDLoLJ/Ra0WNsXq+2oPwPl4NoWoxnYZ4q9MDBnk1jAYRHS4WxGfama4/2G6NlBZ45rhdzfS3yIYQEoQe9Z9uOfS3EK/eUSdymowsGl5UrWCrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVdqfGs1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVdqfGs1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C420AC2BCC7;
	Thu, 14 May 2026 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767759;
	bh=zvNnkp+6yNBQFjvFCmCTyrnoUvo/qS1CeDP5FbHiLzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VVdqfGs1wxQksNwRWcqJuVW5ydFkI7vXR6XZMrvGdSChHcdzrXyrjNAYWHwyVJnGD
	 4SCeJ0lugvVStzzuZprTF7zEOD2SNRQja8f6kMLTNYgu93vKvc6W+j2wjawHfuF+B5
	 uWFFY9YTlmeGhCHDleDe3ihGqcdlt99CyLtWOOyrTzz/mH6W9s5pS8z83pnRVAXU7a
	 k+EMPOs019JXcJUYsYgAhP3+EWKPmkM6OpI9fh/+wbJq3mkPXpQ9Hh4DQU4+sSf2O7
	 UP1V1IJqsxbBcQS5KLzSgSvTCB9SNyNLza+YtHRYQgqNg1cz7aarKqyqT+tLBT7t8X
	 s/B1VeUFpScgA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 02/28] mm/damon/core: embed damon_probe objects in damon_ctx
Date: Thu, 14 May 2026 07:08:35 -0700
Message-ID: <20260514140904.119781-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let damon_probe objects be able to be installed on a given damon_ctx, by
adding a linked list header for storing the objects.  Add initialization
and cleanup of the new field with helper functions, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  9 +++++++++
 mm/damon/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4794931fa2ea3..dc53bc3da74b3 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -857,6 +857,7 @@ struct damon_ctx {
 
 /* public: */
 	struct damon_operations ops;
+	struct list_head probes;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
 	bool pause;
@@ -909,6 +910,11 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_probe(p, ctx) \
+	list_for_each_entry(p, &ctx->probes, list)
+
+#define damon_for_each_probe_safe(p, next, ctx) \
+	list_for_each_entry_safe(p, next, &ctx->probes, list)
 
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
@@ -951,6 +957,9 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_probe *damon_new_probe(void);
+void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
+
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3a8725e400c6b..8a55cc61d2972 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -113,6 +113,38 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	return err;
 }
 
+struct damon_probe *damon_new_probe(void)
+{
+	struct damon_probe *p;
+
+	p = kmalloc_obj(*p);
+	if (!p)
+		return NULL;
+	INIT_LIST_HEAD(&p->list);
+	return p;
+}
+
+void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe)
+{
+	list_add_tail(&probe->list, &ctx->probes);
+}
+
+static void damon_del_probe(struct damon_probe *p)
+{
+	list_del(&p->list);
+}
+
+static void damon_free_probe(struct damon_probe *p)
+{
+	kfree(p);
+}
+
+static void damon_destroy_probe(struct damon_probe *p)
+{
+	damon_del_probe(p);
+	damon_free_probe(p);
+}
+
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_new_region(unsigned long start, unsigned long end)
 {
@@ -605,6 +637,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	INIT_LIST_HEAD(&ctx->probes);
+
 	ctx->addr_unit = 1;
 	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
@@ -627,12 +661,16 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
 void damon_destroy_ctx(struct damon_ctx *ctx)
 {
 	struct damos *s, *next_s;
+	struct damon_probe *p, *next_p;
 
 	damon_destroy_targets(ctx);
 
 	damon_for_each_scheme_safe(s, next_s, ctx)
 		damon_destroy_scheme(s);
 
+	damon_for_each_probe_safe(p, next_p, ctx)
+		damon_destroy_probe(p);
+
 	kfree(ctx);
 }
 
-- 
2.47.3
