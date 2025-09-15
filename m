Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9E22B5AD;
	Mon, 15 Sep 2025 01:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901496; cv=none; b=GX6cpkVIieOQnu8+c+538hwDZrscbY+//8REx8bxH7mvRp5ImmApYfP9zBLK/K9lDvw8Pv962Al6obO6isUd8jKGdi6bbAYCVkPekNSJHNlHmKokHf2et+RC63uBs+202cdQHPJUtkIolVFQoE4Rd9HuzxqI1iLM0frz0T8SRiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901496; c=relaxed/simple;
	bh=nGvVrC45Vt9+6E5tO/9Zsq1bOPvFtQ8UtnVHJOeO4A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7Nk+GHP2VLQ3glFRPwjXd4WsU6UYyR22S5Yviaqs0ahdrnmgiTaZnGflBAI41gG6EsfWyY0cALc4rd33oOWGcMewh8SYRnm03hcDUDIwJfpzHzXl3zH+N4CwXZwgURmggtwEs+ZrLXwCS6fsF7PCX48lAK6mf3HQ0U2r7xVUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ/a/13l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ/a/13l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD88C4CEF0;
	Mon, 15 Sep 2025 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757901495;
	bh=nGvVrC45Vt9+6E5tO/9Zsq1bOPvFtQ8UtnVHJOeO4A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZ/a/13l/K1JrCtefJnoQGLam5FR90aUMxEBXcPo0pELUkzQl4QrS7ftW9oXrJLi8
	 pWAoUwc0TlelI102Agga97Ef8ZDzF7aVSKqyMeeQ5KDOFGcHD9+Y7U7U0dtR/BJdGV
	 crJbVH/nQ6DMcg9zGbuj9W7O0t9Fq2yHw6CWkQ89jdo7rIzA1XjE7eksYZoKEDdSqX
	 WmIX0rW+eVn26eQKBvwXJTbgDvjGGXgmRIrkjf8iBNKvI7cVlBJtlTHhiSeH5Y4cG/
	 Wk0LxcLfvHmZQ3ZRmSAWcnXxWjfu868XaqaR8H4K8JmqVUQBPyPJrsWJkesyatSjw+
	 jxS1ZjVbZ5kaw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] mm/damon/lru_sort: use param_ctx correctly
Date: Sun, 14 Sep 2025 18:58:04 -0700
Message-Id: <20250915015807.101505-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915015807.101505-1-sj@kernel.org>
References: <20250915015807.101505-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_lru_sort_apply_parameters() allocates a new DAMON context, stages
user-specified DAMON parameters on it, and commits to running DAMON
context at once, using damon_commit_ctx().  The code is, however,
directly updating the monitoring attributes of the running context. This
doesn't cause a real user problem but apparently this is an
unintentional mistake that can cause code review confusions and future
real problems.  Fix the wrong use of the parameter context.

Fixes: a30969436428 ("mm/damon/lru_sort: use damon_commit_ctx()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 14d31009c09e..ab6173a646bd 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -219,7 +219,7 @@ static int damon_lru_sort_apply_parameters(void)
 		goto out;
 	}
 
-	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
+	err = damon_set_attrs(param_ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;
 
-- 
2.39.5
