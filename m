Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3E18651
	for <damon@lists.linux.dev>; Tue, 21 Nov 2023 05:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuE6wR8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6E5C433CA;
	Tue, 21 Nov 2023 05:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700544976;
	bh=NQFkESlGtOo/Z9kTwMOTiB8dRtXYj2d4RmPD6fS+g6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RuE6wR8s0cxItHT3S4v7846HvTe8lzcB2GDG2usS3By8VthmMpudVeqd8U8fNOrH6
	 om/JguB2ZLBLI0bLl3U0NAX7CceryPzzMnPfR9xGRaLfqRcFNiwfDwT6pIaxcK9SV2
	 /gtAtDGnJLSTZWk4xkjlCYg3LX7ai4cL0RyKBkq+yp0G0UxgmQX4v/PETr61S7jvDV
	 4nMxnm3stGHrnb5XnaXTX5vUlk6CkAFUrSa3qGPDhGNIbTnPrtfGYVcfJaIZJWZOYF
	 cME8q3NrmRl3KKcqTti1PJTJ0zNtx7K3SPeH9JonPLtlYq4UYPPx/AVKO6uoc1hiFc
	 X13VXI4G9j19Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] mm/damon/core: export symbols for supporting loadable modules
Date: Tue, 21 Nov 2023 05:36:02 +0000
Message-Id: <20231121053604.60798-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121053604.60798-1-sj@kernel.org>
References: <20231121053604.60798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose DAMON core symbols for supporting minimum functionality from
loadable modules.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c080a16f6bdd..8ab8c902b9e2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -111,6 +111,7 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 	mutex_unlock(&damon_ops_lock);
 	return err;
 }
+EXPORT_SYMBOL(damon_select_ops);
 
 /*
  * Construct a damon_region struct
@@ -353,6 +354,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 
 	return scheme;
 }
+EXPORT_SYMBOL(damon_new_scheme);
 
 static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
 {
@@ -390,6 +392,7 @@ void damon_destroy_scheme(struct damos *s)
 	damon_del_scheme(s);
 	damon_free_scheme(s);
 }
+EXPORT_SYMBOL(damon_destroy_scheme);
 
 /*
  * Construct a damon_target struct
@@ -411,11 +414,13 @@ struct damon_target *damon_new_target(void)
 
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
@@ -493,6 +498,7 @@ struct damon_ctx *damon_new_ctx(void)
 
 	return ctx;
 }
+EXPORT_SYMBOL(damon_new_ctx);
 
 static void damon_destroy_targets(struct damon_ctx *ctx)
 {
@@ -518,6 +524,7 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 
 	kfree(ctx);
 }
+EXPORT_SYMBOL(damon_destroy_ctx);
 
 static unsigned int damon_age_for_new_attrs(unsigned int age,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
@@ -645,6 +652,7 @@ void damon_set_schemes(struct damon_ctx *ctx, struct damos **schemes,
 	for (i = 0; i < nr_schemes; i++)
 		damon_add_scheme(ctx, schemes[i]);
 }
+EXPORT_SYMBOL(damon_set_schemes);
 
 /**
  * damon_nr_running_ctxs() - Return number of currently running contexts.
@@ -748,6 +756,7 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 
 	return err;
 }
+EXPORT_SYMBOL(damon_start);
 
 /*
  * __damon_stop() - Stops monitoring of a given context.
@@ -791,6 +800,7 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	}
 	return err;
 }
+EXPORT_SYMBOL(damon_stop);
 
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
-- 
2.34.1

