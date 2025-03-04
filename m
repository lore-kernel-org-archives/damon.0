Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED2827C15E;
	Tue,  4 Mar 2025 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123165; cv=none; b=HaqrvYrGLSnkh+VlrFXlVMpwDKtFLotNwurg0W2oFbt3NHcO6kKb/8UxTqz/w1DGWbUqQdu4wrewGAX3eIsROwjOUpMikNrhW4s9puZhANP4K+rlsF0uTPqLxHlnTelCShgME/xIZOLNZ846COkqb/Gg3Kk/sAiA1sMxIYn+qJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123165; c=relaxed/simple;
	bh=JHR8X09g7RbF+z7f4pVptzblJHocAhQ0MhsGQMkHws4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDWPyS3rxVjGAp3PiisXgOzWMjI0pLcFNvjzrqT+Fr3RKRWO1VLDPQXYY3hNZH2mxKz+qrDGoYQ10ZWhG3KLMmNHhavfE6sC85uBonPJCPOqDeADAKQ9yZbXjgOw+V+XSR74pft75ssNpve8ZTd+UKmi/JOvof2LEJfy/D7ck6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrMKwWWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrMKwWWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E89C4CEE5;
	Tue,  4 Mar 2025 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123164;
	bh=JHR8X09g7RbF+z7f4pVptzblJHocAhQ0MhsGQMkHws4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrMKwWWtHJlk8IRwUXYWPpsrLjun2KZA81/oqEUwWUUFCof6U744AYZB9SGWuivag
	 376YD7Tlak5+1Q7fwe46b96rtbc2VvxWQmyoiLR32HL4TFFCDWryQF5AIKv2VuA+pM
	 XKu60rm8ooVyLivi4UUZ4POoBTrrq5GieMUbIYHwPo+Z9r3hdhvw1o6rUNVuvHa09D
	 FLMvuZ/roJSe7NvrO6lz49C0cIjtTIpy7pC21p4gRSnCFVe4/U9aU6Ot+pOLNEehae
	 44lsSYbTonQDfKJu5fj7ytc4/e3H5qhRmK1DxRSLKfBwdVsHRCCQNBJsp85Y/ruJDY
	 HMtdyIgNxgltw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/9] mm/damon/core: set damos_filter default allowance behavior based on installed filters
Date: Tue,  4 Mar 2025 13:19:11 -0800
Message-Id: <20250304211913.53574-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decide whether to allow or reject by default on core and opertions layer
handled filters evaluation stages.  It is decided as the opposite of the
last installed filter's behavior.  If there is no filter at all, allow
by default.  If there is any operations layer handled filters, core
layer's filtering stage sets allowing as the default behavior regardless
of the last filter of core layer-handling ones, since the last filter of
core layer handled filters in the case is not really the last filter of
the entire filtering stage.

Also, make the core layer's DAMOS filters handling stage uses the newly
set behavior field.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3fbc31d17239..194550e033b1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -891,6 +891,32 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	return 0;
 }
 
+/**
+ * damos_filters_default_reject() - decide whether to reject memory that didn't
+ *				    match with any given filter.
+ * @filters:	Given DAMOS filters of a group.
+ */
+static bool damos_filters_default_reject(struct list_head *filters)
+{
+	struct damos_filter *last_filter;
+
+	if (list_empty(filters))
+		return false;
+	last_filter = list_last_entry(filters, struct damos_filter, list);
+	return last_filter->allow;
+}
+
+static void damos_set_filters_default_reject(struct damos *s)
+{
+	if (!list_empty(&s->ops_filters))
+		s->core_filters_default_reject = false;
+	else
+		s->core_filters_default_reject =
+			damos_filters_default_reject(&s->filters);
+	s->ops_filters_default_reject =
+		damos_filters_default_reject(&s->ops_filters);
+}
+
 static int damos_commit_filters(struct damos *dst, struct damos *src)
 {
 	int err;
@@ -898,7 +924,11 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 	err = damos_commit_core_filters(dst, src);
 	if (err)
 		return err;
-	return damos_commit_ops_filters(dst, src);
+	err = damos_commit_ops_filters(dst, src);
+	if (err)
+		return err;
+	damos_set_filters_default_reject(dst);
+	return 0;
 }
 
 static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
@@ -1580,7 +1610,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 			return !filter->allow;
 		}
 	}
-	return false;
+	return s->core_filters_default_reject;
 }
 
 /*
-- 
2.39.5
