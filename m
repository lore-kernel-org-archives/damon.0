Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8A2F28EA;
	Fri, 15 May 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805886; cv=none; b=unqQfa897j25swFCDDDE0h01Oi0DHgFPxPfZO4EGm+oTzFr1fgysWZnSmf0cZGCJEhFwypeK1ftfujgtI197XywlBXfLfrpU1YQceYojUE45gm0GEcGDobmTHwzQh3lr2+ZNQWdXqhTw31QvpOOc+z2ackv045r3U5DR5bU9s84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805886; c=relaxed/simple;
	bh=01iJIEtk8jxRwVFE50bS/u85msL+GIHF9+n6SYfgnN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk5lcKXy7uOtXRSD5pQ45OwkZDP2EUO9qkkjiRAqnwW4VGLuJZ/Msnn6MEhRzwa1+ZqU7AOnQYsWPDiLQ2ZlXVBYou2BnNxNYVtphFXsducmBlvT/6rFfoTdxTmZyO922mXzM3471HYTmN084WxA6q5m/LO2WjsclYi/V3z09qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9IAxz97; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9IAxz97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5301BC2BCB3;
	Fri, 15 May 2026 00:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805886;
	bh=01iJIEtk8jxRwVFE50bS/u85msL+GIHF9+n6SYfgnN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9IAxz9732L+u2X9kM2t69E546JI98VBHv0tsyapmY9RJYt/jVZV7oev1lQPmg1Nx
	 XeC23/5wRZ0RuVW0bj6kI73EKTbOMKkT0PQ2OoJzKnQAqrqdoAEW3FKHoDk8Yl660E
	 x4jDmpOurHwpT70ZQug1LjqszY8spxtHjFb6WM8kuSXHUq8xbySEjzy56ajGUKALb0
	 6yy1WX77ObnEJwQ6u+9GNCh9dpva4aMcbME2LVPKfr1+MgnlgSzv2Srm/gAR+vhfjT
	 8YoTBGUyhBHvda2d+dI7OZB+Ix+mfBwjkcLMqMCGOKQ3RPEyyh7+4eNuIwDCMdRo8x
	 Us0S36xE6pTpQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 02/28] mm/damon/core: embed damon_probe objects in damon_ctx
Date: Thu, 14 May 2026 17:44:03 -0700
Message-ID: <20260515004433.128933-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
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
index a8fff5325b010..3ba5a31b51769 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -847,6 +847,7 @@ struct damon_ctx {
 
 /* public: */
 	struct damon_operations ops;
+	struct list_head probes;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
 
@@ -879,6 +880,11 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_probe(p, ctx) \
+	list_for_each_entry(p, &ctx->probes, list)
+
+#define damon_for_each_probe_safe(p, next, ctx) \
+	list_for_each_entry_safe(p, next, &ctx->probes, list)
 
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
@@ -921,6 +927,9 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_probe *damon_new_probe(void);
+void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
+
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff719..0e55fa70fa5b6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -109,6 +109,38 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
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
@@ -601,6 +633,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	INIT_LIST_HEAD(&ctx->probes);
+
 	ctx->addr_unit = 1;
 	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
@@ -621,12 +655,16 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
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
