Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802C264614;
	Thu, 20 Feb 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080118; cv=none; b=WZ06MDzNfNprQOOaarF/4PLPpUJDwcrTJ3WJNwXLdiuPTpnw5yqS7HAFkxkM2S790tNiPlhbUcnn+q29bI+qi93bXVin8ZXkDmnpdpGgLPyS0SZVh4nNOJUqyrZ3Akzh8AnV6y1HE+6VyjS51DRseNfsvnM4e40e0p//iJ7D04w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080118; c=relaxed/simple;
	bh=2GbFALk/c9BNCc25jRYoGVkk+3jSEEjMYTr49dqSrPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdjqDwJgTP9Kri93nqDLSRXvsIVRS28RwJ7ptRltTp6L/Eij3Q7SS3c3pYD2soa60e6CyVRFvHgwH4gzv50SjUqEvQxqG2NNwLrhOIl2n0FOy5NmrYGmHU0jgVrS6UG26AWqvrhjgChQ/5bclUV1Mf7qntWXur8xxRkK62lj1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9946da1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9946da1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1BEC4CEE4;
	Thu, 20 Feb 2025 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080117;
	bh=2GbFALk/c9BNCc25jRYoGVkk+3jSEEjMYTr49dqSrPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9946da1cnNgfEsUSUknhKQ7sBC0WcrZgLi2EGaWpPPeZQl7zaAsOY7m9rrzO9r3R
	 2rL/pyrK9jJc/Vrw8TBPEBETY5IPECmuJ6TIZ3KyyAp1qMx7Z4IBoMR2tXmv6hhsOV
	 2UEsVohJNOsUYe03IrDOBI7o0Y0qGAyewwoZCNlru/RobSC8bDnJTcZNZWSiEoeUUQ
	 hkmGRAfGNh/Mjkh2g1+GGRPJn7cN7vZ8m7uRXvL+BjX1p1abgtAnknhAyY37zHJuvv
	 REImn0dECTmcI7Y7TIoUQaV67vTnq8ZO6VSQKpVb7Di5mdZuVjx7zjuWgAF50PdHqm
	 m+BMGnnF7R6BQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/9] mm/damon/core: support committing ops_filters
Date: Thu, 20 Feb 2025 11:35:03 -0800
Message-Id: <20250220193509.36379-4-sj@kernel.org>
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

DAMON kernel API callers should use damon_commit_ctx() to install DAMON
parameters including DAMOS filters.  But damos_commit_ops_filters(),
which is called by damon_commit_ctx() for filters installing, is not
supporting committing damos->ops_filters.  Do the parameters committing
so that DAMON kernel API callers can use damos->ops_filters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcb7e42098dc..ffdd84ff6fa5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -793,7 +793,7 @@ static void damos_commit_filter(
 	damos_commit_filter_arg(dst, src);
 }
 
-static int damos_commit_filters(struct damos *dst, struct damos *src)
+static int damos_commit_core_filters(struct damos *dst, struct damos *src)
 {
 	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
 	int i = 0, j = 0;
@@ -821,6 +821,44 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 	return 0;
 }
 
+static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
+{
+	struct damos_filter *dst_filter, *next, *src_filter, *new_filter;
+	int i = 0, j = 0;
+
+	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
+		src_filter = damos_nth_filter(i++, src);
+		if (src_filter)
+			damos_commit_filter(dst_filter, src_filter);
+		else
+			damos_destroy_filter(dst_filter);
+	}
+
+	damos_for_each_ops_filter_safe(src_filter, next, src) {
+		if (j++ < i)
+			continue;
+
+		new_filter = damos_new_filter(
+				src_filter->type, src_filter->matching,
+				src_filter->allow);
+		if (!new_filter)
+			return -ENOMEM;
+		damos_commit_filter_arg(new_filter, src_filter);
+		damos_add_filter(dst, new_filter);
+	}
+	return 0;
+}
+
+static int damos_commit_filters(struct damos *dst, struct damos *src)
+{
+	int err;
+
+	err = damos_commit_core_filters(dst, src);
+	if (err)
+		return err;
+	return damos_commit_ops_filters(dst, src);
+}
+
 static struct damos *damon_nth_scheme(int n, struct damon_ctx *ctx)
 {
 	struct damos *s;
-- 
2.39.5
