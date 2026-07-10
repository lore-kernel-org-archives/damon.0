Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAD253B58;
	Fri, 10 Jul 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691224; cv=none; b=LvdYuu1oPbUzscUlnFIwaeJx/H/2pC2uekNk0yNwWwVkP6/B8ZO2L09wWSk7X47OklqjF4JAbQZshbT4FqERpXenHJM6P5OaGBQSXQjorg2Qqyq71qSPXYhVfIkP5atRAq5kgur0ahf4vzfdABu+1bD/lM9BE2uUe4sC6nVeYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691224; c=relaxed/simple;
	bh=nEsmjY06Hyev02Kgci90eG1ifza3IYtKh9jBRs/isCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEz+QaUw27QnfDUJl0hBXG8WBdHC0EYtNKjTJCVVbzlVgiwksONEgg57UkgzZnk9miq9AEHTwRVx1UFQ41r+X6hGcYuEdwluCMA/Rx17G5kGaekWfd4hYs8ZXPX4WaHWNQxqsXR1j+0xxpcsFQujJk70qwfvFy82VysMLOcm9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yr8PFReo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yr8PFReo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC11F00A3A;
	Fri, 10 Jul 2026 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691222;
	bh=Afvkxg7JDGHDzuDLSPibRSpczK7Yb0J9zCK+iiS9Hlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yr8PFReoBPl3zYLmz2T93VhX5MJC7W+HZSn7HB/qd5lNm5UaPeDz+/2+DycWuKFBv
	 uFXxG/L2UvfnwJV04i7R8fZ6n/ydO7HuK5eGKNUNKDxSZBbkq/ac5Vk3XOmeDheP76
	 +hG9OHWUT5Y/L5kU2OdkqiZKDjVTMloOe6osgqdDRg3KRG7Bu0xEXDsgy3h5YrOzv7
	 q90P/u4K6MsKdYFxdwRf8NAihKC4osM4k9m4uqvW2ozZ23rmR1gpQR/KwFGsanRRNn
	 rbl046o7zGWhST9gGFlyFTXzBxY14fmDKrxLE7/blWzc4MlknZOVQ9ExhtBAn4unu/
	 4d+LZNz4r1YDA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/19] mm/damon/core: use abs_diff() instead of abs()
Date: Fri, 10 Jul 2026 06:46:36 -0700
Message-ID: <20260710134651.18084-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of abs() in damon_merge_regions_of() could cause a silent integer
overflow since the macro casts unsigned int to signed int.  It is
unlikely to have such a large value for nr_accesses.  Even though it
happens, the user impact is just degraded monitoring results.  Users
showing bad monitoring results for weird setup is quite trivial.  But
the code is obviously wrong.  Use abs_diff() instead.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260705213817.100841-1-sj@kernel.org/

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index fea97399b5754..4c7e8a12a9b67 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3261,7 +3261,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
+		if (abs_diff(r->nr_accesses, r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
 			r->age = 0;
@@ -3269,7 +3269,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			r->age++;
 
 		if (prev && prev->ar.end == r->ar.start &&
-		    abs(prev->nr_accesses - r->nr_accesses) <= thres &&
+		    abs_diff(prev->nr_accesses, r->nr_accesses) <= thres &&
 		    damon_sz_region(prev) + damon_sz_region(r) <= sz_limit)
 			damon_merge_two_regions(t, prev, r);
 		else
-- 
2.47.3
