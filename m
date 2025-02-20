Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CDE26656B;
	Thu, 20 Feb 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080122; cv=none; b=srTIHKClgbFLwp7J5w+uHTCOuza90vMKHIYtNmpUUuKfKxyi+BAGWJ21AQaY6FtH+7Q0dDocaGEJ86utr2/usR/Fg5IaYAixX0iZWLDqYWYQc5fyNGmtptYdz1XmkIu4vZhk9ZbVzArfmLIwjrxMCHHarIazlj6o3h9zNp2ahuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080122; c=relaxed/simple;
	bh=wusvJRacW6vYvCH54BiAWS1KizhtAHCC8gqFD4D8VEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+SqB5UsESZY3TwbJOeAI8DhiVJNVi6FSaWrgSDuW/vcdrAMXkYFQFtErLfEwNLrfy/BSPOtUvsLOvhgUWW/4BBNqfa75IO+/wbhmMcOsfFrnAVmbogrs70I92slcX0YppYr1f7hCW2DYNI5UJ+czDsTdibNyHUrjQtvQ8IKtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLqc64Rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLqc64Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255E0C4AF0E;
	Thu, 20 Feb 2025 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080122;
	bh=wusvJRacW6vYvCH54BiAWS1KizhtAHCC8gqFD4D8VEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLqc64RqWA6JWSUep9kax22dPADZ3GBhFdf/qoAj3myZcuLBsfW4mfY7gO1QPp6Oc
	 3qDscqg7nD32T35IwbnHtCa0MyzpA3Dz/+QGhRAn57IgMPOq5+KsRCS1FMkW+xlNuW
	 JeeOVnLCn05CG7ow/7cyK2yfifr1Vte4kwI6v7TqhXJxdZEq+ZthJxs8QyRAYTFfwP
	 cVMnFmdokR+t1DIDUHk0NdlrFuv6iWSHMqagG/GecEcW9zSkwYexx3UwAgDq1G/zGY
	 2qjBr8uzR8QPAAy7UnQEGJmBOYdFsuovqesfw6CKC+FZujBTEbyT6Ebcv9D6zCKHjw
	 Xlf0vDZdnP9Tw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/9] mm/damon/core: set damos_filter default allowance behavior based on installed filters
Date: Thu, 20 Feb 2025 11:35:07 -0800
Message-Id: <20250220193509.36379-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Decide whether to allow or reject by default on core and opertions layer
handled filters evaluation stages, based on the last-installed filter's
behavior.  It is the opposite of the last installed filter's behavior.
If there is any operations layer handled filters, core layer handled
filters stage keeps allowing as the default behavior, since the last
filter of core layer handled filters in the case is not really the last
filter of the entire filtering stage.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 78126a5145fd..9744ab9ca5c5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -864,6 +864,29 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
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
+	s->core_filters_default_reject =
+		damos_filters_default_reject(&s->filters);
+	s->ops_filters_default_reject =
+		damos_filters_default_reject(&s->ops_filters);
+}
+
 static int damos_commit_filters(struct damos *dst, struct damos *src)
 {
 	int err;
@@ -871,7 +894,11 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
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
@@ -1490,7 +1517,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 		if (damos_filter_match(ctx, t, r, filter))
 			return !filter->allow;
 	}
-	return false;
+	return s->core_filters_default_reject;
 }
 
 /*
-- 
2.39.5
