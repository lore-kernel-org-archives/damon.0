Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E414F9EB;
	Thu, 27 Feb 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621484; cv=none; b=Ubv+SqkzJspYDFRKgCs+fEdHW6gFKBZNqzlxQnrdm/YqC3JKK+xjUyujUfg17Eg7bggypr46+KGzYZED+BcX44amReQ6UdtEFjnMQO3YrbMH7mqFXsgRQoMA6IdyveYuydSGX8LViAm43zhAiSoiSQ0NxXYQMkJ2BGvhB6DWyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621484; c=relaxed/simple;
	bh=QU2B5OyjwKcbSYOittkRG8TZWYJnF6pYkD/57XDdhdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYXv5dIv22EshQfeHESddEctnUQoUY5NGcP2Jg+ZM3Q07AtFzThNOtFFnbUxmVR1VXC3hiVASG+jT9EjqTWWmfbYS8pYiSV/fHhvB5P7nPEZ5L/85pv7qEPNWV/Q3m8M+0QDf0CsWqc/95EhsCbpP/3N1/+m+5yRgG4WYaRShpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwgPPSnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwgPPSnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29670C4CEE9;
	Thu, 27 Feb 2025 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621484;
	bh=QU2B5OyjwKcbSYOittkRG8TZWYJnF6pYkD/57XDdhdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VwgPPSnPJQDwc1rIVc7Xx2E+0web9XOgqArVd0SNog172cRGHzVZOVlDqmVdLin2W
	 LLsafYJZIObPHyBR6FtPy4GXobvAx8bDPgoGmKOGbheMalJLOqEE918Ys1Im19RAJr
	 JevxJ/CifsvJqnzMdjGmHnLGcLPhbCTTf16UlCnfOYY0W38Xd/1/LRfTVgvb5ayGz2
	 56Jeu70HfrlQE6odKGESqBShUS90gYBpYtNoZ2RggUBGgjr6YixIBqOrs3/vDKLQqh
	 I/aIY0swcGT3PSWadD7IY26Rdf/eM8lGHeiaw/YXahxPhvcfCf8KJZkNC3VlkHdkhg
	 XQJUfC8DLYF5Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/9] mm/damon/core: support committing ops_filters
Date: Wed, 26 Feb 2025 17:57:48 -0800
Message-Id: <20250227015754.38789-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
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
handling damos->ops_filters.  Hence, no DAMON kernel API caller can use
damos->ops_filters.  Do the committing of the ops_filters to make it
usable.

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
