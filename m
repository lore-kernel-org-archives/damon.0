Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E1871
	for <damon@lists.linux.dev>; Mon, 13 Jun 2022 19:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E22AC341C4;
	Mon, 13 Jun 2022 19:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655148190;
	bh=n6pIJardcDOsM0Vty4Jd2+LmdyUc2TSqs3BgnjMqBM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZU4tSULFHm6FsvW+iSnmeOF25EuoA37Y1Q7CK6fSJNEpgPnkR2oqvoVXTbM1DXOKk
	 0309qTloTvFcZz49r6f/2AVtvrXlKCH005FkekFR746N66hY3QujklydIZpzauQ8sI
	 /fxtWRoCjt56xVP3Tq1VpSE7IWzJrMgWKvmxsrFplcztBs5DG73e0+qszzEia4COJq
	 mk/79vYNlULn+hT+qgm0Dz+eBjcLp15rzxCsD8XZhMkDWP+5zwPfRKikazB5zqhKqk
	 oQWNCCqpwDJ31kF9vSfBuQeBkzZIQ2WcKvJHUbrWWggRgb9Xyn4RPqsuGnfBoqJNjM
	 QlrpeStxf/IhA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm/damon/paddr: use a separate function for 'DAMOS_PAGEOUT' handling
Date: Mon, 13 Jun 2022 19:22:55 +0000
Message-Id: <20220613192301.8817-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit moves code for 'DAMOS_PAGEOUT' handling of the physical
address space monitoring operations set to a separate function so that
its caller, 'damon_pa_apply_scheme()', can be more easily extended for
additional DAMOS actions later.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b40ff5811bb2..7bcd48066b43 100644
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
2.25.1

