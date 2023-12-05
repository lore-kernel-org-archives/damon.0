Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823004689
	for <damon@lists.linux.dev>; Tue,  5 Dec 2023 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6aY+O82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4127C433C9;
	Tue,  5 Dec 2023 02:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701743345;
	bh=hl6U6OugfgCPU2deKjlNge8ZmSL6lB/DjRx+v2yMHcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6aY+O82JRLvi9ZiWWCgNK9dzhk/rfbzFntuVc90rQCW/Qz98hD+qf1B+yrS8lvYu
	 XUIDJKNblYxLPqmArrgtOb4NxmUhlPnUNpFSomqcHGzLHD5JVDiUduOhmugOvLbPuG
	 WXOEHM3IGOGqXhKGrZP+kJjf38+ykbHuleoo3E2+2yRd/8nRjGgl0uDINgj1OVDnk7
	 fTsDY58oxNXjT2WKpZZNi8iSjrAKre/9np2NhgNBqh9iA11U2kLCJMxhTbSk7qKbNk
	 EjaY/ejgRFM9qz4Bh/64/9Hk5OeEN3dcCKJ8PT/UHgvKQ6lFDxvOOsNwUmnw+bC2jq
	 FLJrF+YB+LCKw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/damon/core: export symbols for supporting loadable modules
Date: Tue,  5 Dec 2023 02:28:56 +0000
Message-Id: <20231205022858.1540-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205022858.1540-1-sj@kernel.org>
References: <20231205022858.1540-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose minimum DAMON core symbols for supporting use of basic
functionality from loadable modules.  Followup commits will add sample
loadable modules that use the exported symbols.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f91715a58dc7..8a5c3e905738 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -111,6 +111,7 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
+EXPORT_SYMBOL(damon_select_ops);
 
 /*
  * Construct a damon_region struct
@@ -343,6 +344,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 
 	return scheme;
 }
+EXPORT_SYMBOL(damon_new_scheme);
 
 static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
 {
@@ -380,6 +382,7 @@ void damon_destroy_scheme(struct damos *s)
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
+EXPORT_SYMBOL(damon_destroy_scheme);
 
 /*
  * Construct a damon_target struct
@@ -401,11 +404,13 @@ struct damon_target *damon_new_target(void)
 
 	return t;
 }
+EXPORT_SYMBOL(damon_new_target);
 
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t)
 {
 	list_add_tail(&t->list, &ctx->adaptive_targets);
 }
+EXPORT_SYMBOL(damon_add_target);
 
 bool damon_targets_empty(struct damon_ctx *ctx)
 {
@@ -464,6 +469,7 @@ struct damon_ctx *damon_new_ctx(void)
 
 	return ctx;
 }
+EXPORT_SYMBOL(damon_new_ctx);
 
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
@@ -489,6 +495,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 
 	kfree(ctx);
 }
+EXPORT_SYMBOL(damon_destroy_ctx);
 
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
@@ -616,6 +623,7 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
 }
+EXPORT_SYMBOL(damon_set_schemes);
 
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
@@ -719,6 +727,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 
 	return err;
 }
+EXPORT_SYMBOL(damon_start);
 
 /*
  * __damon_stop() - Stops monitoring of a given context.
@@ -762,6 +771,7 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	}
 	return err;
 }
+EXPORT_SYMBOL(damon_stop);
 
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
-- 
2.34.1

