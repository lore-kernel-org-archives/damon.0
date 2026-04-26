Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630D2EF652;
	Sun, 26 Apr 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236755; cv=none; b=UQqnk8TBN5Tu6FSH8MyFtTOp/ocf/HDmHrZY2eTsrLG6bwlLchvE39jI5JJKB9/GVex8OsSs6w8qzLON0WEUhMPBcDX0X/8mqoJyNrM+BLrCGcce9kbIP3p2pDxoH8kx7D/ms4YxbgsRIxIbFsUX0I2JrzunJ9ISSBmtz/4Uftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236755; c=relaxed/simple;
	bh=MBnxsMb7aVVsu9fBOqUd4whtHJLGz98akhVkcLMVfko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hj+4TCgqvRmOF5f0dZ4pVbZBV1T6zTZJ7gemfgb/hlj9NIgqQtE1ffP/0dA05iq9QqNWC9oi6psVZAJa1wkFE6R9Tv0mgEnF3eXCUoZF5fwjxKzT5qQ8cRE9KStc//hFmjShsd1q8sNAig7oaqo8FRWCNv4MeJSWYwwOwrfiyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFUVNBJY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFUVNBJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E900C2BCC7;
	Sun, 26 Apr 2026 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777236755;
	bh=MBnxsMb7aVVsu9fBOqUd4whtHJLGz98akhVkcLMVfko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFUVNBJYGo8GJ+nlSDyoHTMLKuEEuU98keMZ2AGVXQTenj6xfcYgVLnHrj2M481eC
	 dPaja58+UYFgsTShSVrUwMLM85x/A5KpstSajf5D9sSJIBmTDUVM6xJsibDDpLeyIP
	 igJwLFtVvvtx+eKwIAe8prraRVNAyGKxhq6xrluZFcfSONUjB7+De3oe2UuGq7OO9A
	 lMusAHSUv6VV+wrhE+MpGDvcMsWdwbb27qQHF5fUJP2hHa6x1MQEzjM2mtmULWI/Jb
	 jXgTWkuI3WTDBVtDQzqGYQVukL+m8LoTQhIFpXYhRHWkh2INbD4gRRTAc3rmkM60oK
	 p5ZeWbwpnPgFA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/19] mm/damon/core: embed damon_probe objects in damon_ctx
Date: Sun, 26 Apr 2026 13:52:03 -0700
Message-ID: <20260426205222.93895-3-sj@kernel.org>
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

Let damon_probe objects be able to be installed on a given damon_ctx, by
adding a linked list header for storing the objects.  Add initialization
and cleanup of the new field with helper functions, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  9 +++++++++
 mm/damon/core.c       | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index da2f026eac725..65d7ee0a70ac0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -859,6 +859,7 @@ struct damon_ctx {
 
 /* public: */
 	struct damon_operations ops;
+	struct list_head probes;
 	unsigned long addr_unit;
 	unsigned long min_region_sz;
 	bool pause;
@@ -892,6 +893,11 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 	return r->ar.end - r->ar.start;
 }
 
+#define damon_for_each_probe(p, ctx) \
+	list_for_each_entry(p, &ctx->probes, list)
+
+#define damon_for_each_probe_safe(p, next, ctx) \
+	list_for_each_entry_safe(p, next, &ctx->probes, list)
 
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
@@ -934,6 +940,9 @@ static inline unsigned long damon_sz_region(struct damon_region *r)
 
 #ifdef CONFIG_DAMON
 
+struct damon_probe *damon_new_probe(void);
+void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
+
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f556786597c83..861ab977d1edf 100644
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
@@ -633,6 +665,8 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.min_nr_regions = 10;
 	ctx->attrs.max_nr_regions = 1000;
 
+	INIT_LIST_HEAD(&ctx->probes);
+
 	ctx->addr_unit = 1;
 	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
@@ -653,12 +687,16 @@ static void damon_destroy_targets(struct damon_ctx *ctx)
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
