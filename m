Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E83933E8;
	Tue, 13 Jan 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318052; cv=none; b=M9UDKSYLUnj8+bHNd1ktXXmhKqiEvYox0SohSMtR+z8QfukzmGb2+EH5KOhKiM/PLbQKepEmKHhSRc0I0B7ETnn6wbi8dHK0Lo0UCVd8wg6PhM0djuZO2dsHfCEC1nNrZ2/KOVUESEPoQvp0OTvCsfHYqqRZ30wv4FPFQQoQgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318052; c=relaxed/simple;
	bh=Ps1Llk1zn7k8iBguPu+c50Hh6cMt1or4lC99Uh+5urc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsfkawldBJHWcBfMKqhDWFuA7R8qKse7VxjE/3xIFjh7ax46/LN4OXUndJ+PJ0Y3bKdVA/huHsxDmqpFwhAUopdmEvMf2I61s99J6d47NfQFfHsAx1X4B0d1A4If+wASFI90rPk9M2tLwboEm3curVNhRiiIbnKoyOWk5/3wNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk2ebu7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk2ebu7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01167C19422;
	Tue, 13 Jan 2026 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318052;
	bh=Ps1Llk1zn7k8iBguPu+c50Hh6cMt1or4lC99Uh+5urc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zk2ebu7+GAxnV8yJ3e1uSgG0okFBS2+bpqblZ/XsSuXKo3ZOACswlTS/P2AgCE88i
	 Tf8A1g6E1f6j0068Nqhxmr/AJhZSGngoDXYG5DI4eO92dx/edIzFSnx1UzF2uE9HCb
	 oEyIqtftImRHgSNsTgu8n8aOFkNCiBz4oKrSDTROyi05aPZJanwziQTd/8JkjyVdTf
	 45gWlqMgZCyL3BCLM0Z1VIqHHh+UFyhONN+y5f5hQK/iGQAk+ImdvyL7ab0QcCAHUo
	 WkRbzVUVrQYxD5Eea8XTJA0Ax+faZMBn5uVkBI1uUiLHCbAy2JfGE3axG5voYRLye9
	 YxnOY/FivKOHQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/11] mm/damon/lru_sort: support young page filters
Date: Tue, 13 Jan 2026 07:27:11 -0800
Message-ID: <20260113152717.70459-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitors access patterns at the region level, and hence there
could be some page level mismatches.  A few hot pages could be located
in cold regions, and vice versa.  Young page filters can be useful for
doing additional page level access checks before applying some DAMOS
action.

DAMON_LRU_SORT is not using young page filters, though.  Add a parameter
for using it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index a74c4ec170a9..f1fdb37b9b47 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -41,6 +41,21 @@ static bool enabled __read_mostly;
 static bool commit_inputs __read_mostly;
 module_param(commit_inputs, bool, 0600);
 
+/*
+ * Filter [non-]young pages accordingly for LRU [de]prioritizations.
+ *
+ * If this is set, check page level access (youngness) once again before each
+ * LRU [de]prioritization operation.  LRU prioritization operation is skipped
+ * if the page has not accessed since the last check (not young).  LRU
+ * deprioritization operation is skipped if the page has accessed since the
+ * last check (young).  The feature is enabled or disabled if this parameter is
+ * set as ``Y`` or ``N``, respectively.
+ *
+ * Disabled by default.
+ */
+static bool filter_young_pages __read_mostly;
+module_param(filter_young_pages, bool, 0600);
+
 /*
  * Access frequency threshold for hot memory regions identification in permil.
  *
@@ -193,6 +208,28 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
+static int damon_lru_sort_add_filters(struct damos *hot_scheme,
+		struct damos *cold_scheme)
+{
+	struct damos_filter *filter;
+
+	if (!filter_young_pages)
+		return 0;
+
+	/* disallow prioritizing not-young pages */
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, false, false);
+	if (!filter)
+		return -ENOMEM;
+	damos_add_filter(hot_scheme, filter);
+
+	/* disabllow de-prioritizing young pages */
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true, false);
+	if (!filter)
+		return -ENOMEM;
+	damos_add_filter(cold_scheme, filter);
+	return 0;
+}
+
 static int damon_lru_sort_apply_parameters(void)
 {
 	struct damon_ctx *param_ctx;
@@ -240,6 +277,10 @@ static int damon_lru_sort_apply_parameters(void)
 	damon_set_schemes(param_ctx, &hot_scheme, 1);
 	damon_add_scheme(param_ctx, cold_scheme);
 
+	err = damon_lru_sort_add_filters(hot_scheme, cold_scheme);
+	if (err)
+		goto out;
+
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
-- 
2.47.3
