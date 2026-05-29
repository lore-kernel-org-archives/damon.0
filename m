Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BD2BE65F;
	Fri, 29 May 2026 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012877; cv=none; b=MHPd/DFKfgqRhHLm2ohRXSzRgE1lnAWoZflJuD9JxnEuhyKQngCSTQk9sGv+iKdfhLQlFwzQJGO2H/ROdyWjrLFBfuh5PIujVfVFx5AUklZTyK1mZ7EEDGf7Z2npxTS6K6TYDKt2CqjYXnqODVKwjm1ysIwCjYtrnlT3MgtpP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012877; c=relaxed/simple;
	bh=syR8gk/1Kn3wTXFIT82Sc+Spvg8Sajy64FM66/WxSLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/9HqN0X5jadBShJcjUxFwaXCYgQQ/O8wqvWvwlW7g4D5l/oqGGMualsifP/s3FPegpJJBnOW69BQXEgQUM5k6iwvJIo53a8eNupMjNX+EZYhnWSbO3kMwlqCLFUUT1Nhge1t30v7wnNBK3HSL077HLlbbFtoLCrz4khTS/7PzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPGfiAZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPGfiAZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77811F00A3F;
	Fri, 29 May 2026 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012875;
	bh=8uMRK9tYWaXpNpaEqAhpqFf64f/zJybxf3IUBnmYDVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPGfiAZeei+OnhXocD2OZunx4l+5LCfQHMl2Tu4l2ZueUilbE5jDRJwTepAYmTsgu
	 jqYfD44g0BH6qEPxlFmG37EQFxHWXhaA3X259qp0w7JODM99jw2LnBUgqtZs/elB3J
	 5/tkTkw/AJya4VBGQokkaJHizTsHCVqqgCCNimAn4DHNaj4b5tJfcCFDZJrPVjR3NL
	 fJaH4U7XULYv6xx0DvdG1stdgHdGaOUlDwTOUfbNJSji28RCO9dF+/KGaEXJcp1kBk
	 iUULj+RP99O/oAJqSQFrp2D2IRJlcDy24UYU6ndbWY1faNymfzGvCDDpN/3DTr9J/K
	 0hWQEDMzgd2fQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] mm/damonn/lru_sort: handle ctx allocation failure
Date: Thu, 28 May 2026 17:01:03 -0700
Message-ID: <20260529000104.7006-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529000104.7006-1-sj@kernel.org>
References: <20260529000104.7006-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT allocates the damon_ctx object for its kdamond in its
init function.  damon_lru_sort_enabled_store() wrongly assumes the
allocation will always succeed once tried.  If the damon_ctx allocation
was failed, therefore, code execution reaches to damon_commit_ctx()
while 'ctx' is NULL.  As a result, it dereferences the NULL 'ctx'
pointer.  Avoid the NULL dereference  by returning -ENOMEM if 'ctx' is
NULL.

Fixes: c4a8e662c839 ("mm/damon/lru_sort: use damon_initialized()")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index eca88ed941b32..8298c6001fd09 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -476,6 +476,10 @@ static int damon_lru_sort_enabled_store(const char *val,
 	if (!damon_initialized())
 		return 0;
 
+	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
+	if (!ctx)
+		return -ENOMEM;
+
 	return damon_lru_sort_turn(enabled);
 }
 
-- 
2.47.3
