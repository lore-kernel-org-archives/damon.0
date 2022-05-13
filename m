Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4494C64
	for <damon@lists.linux.dev>; Fri, 13 May 2022 15:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB7FC34100;
	Fri, 13 May 2022 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652454033;
	bh=11GGetY1wDUykE5Nyy58CKhxn3If/B0NbPr4dqjZJhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVD2EDqRC51IxA65gs5McXHnMkTqUbN+hLAkSkMsvfpKfy0uENX8P6re5sXBCv5Vn
	 oFpMKegP2kxpOaZ5b++DfDafD2GzJhb0OA0WK/T5gno8MBmL0FUtleA9BeuRWornnB
	 P7yHSCGIkFU7Nzxbu4i62IKOymu7BaVxzOi+y6WXDToTPtLqtiBLWBQsA09K+LAXzK
	 sfFXKRNfF0MUyjurphbZZ5UfQjInipxl2BKx9BSf2KS6HmRE6bXzrwMUZbgF3fC4cQ
	 KODfYyVmTFB1O9V3T0oVTjzkZwvSY6HmR69GzF3ffAbeL3tA3l+8+6hXf644IStnHY
	 fsw74HIIbXkjg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: linux-damon@amazon.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 1/3] mm/damon/paddr: move DAMOS_PAGEOUT handling to a separate function
Date: Fri, 13 May 2022 16:59:58 +0200
Message-Id: <20220513150000.25797-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513150000.25797-1-sj@kernel.org>
References: <20220513150000.25797-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

This commit moves code for DAMOS_PAGEOUT handling to a separate function
other than damon_pa_apply_scheme() to make damon_pa_apply_scheme()
prepared for later additional DAMOS actions support.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 21474ae63bc7..08deee12ebfd 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -204,16 +204,11 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
-		struct damon_target *t, struct damon_region *r,
-		struct damos *scheme)
+static unsigned long damon_pa_pageout(struct damon_region *r)
 {
 	unsigned long addr, applied;
 	LIST_HEAD(page_list);
 
-	if (scheme->action != DAMOS_PAGEOUT)
-		return 0;
-
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct page *page = damon_get_page(PHYS_PFN(addr));
 
@@ -238,6 +233,19 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	return applied * PAGE_SIZE;
 }
 
+static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *r,
+		struct damos *scheme)
+{
+	switch (scheme->action) {
+	case DAMOS_PAGEOUT:
+		return damon_pa_pageout(r);
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int damon_pa_scheme_score(struct damon_ctx *context,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
-- 
2.17.1

