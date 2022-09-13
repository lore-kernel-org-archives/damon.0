Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91B3C39
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CE3C433C1;
	Tue, 13 Sep 2022 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091096;
	bh=K7noZZXWc7OYsglqBcB0HhttVkm6j87iOZkQHk+Jwew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gjqjlZf4JKxlU1qngINKNjIQRI28bhKmxR92VUaRZcndWGVsHxTgjpcRt1D0Zuwi/
	 ePWweOxeH7mPuBSxxkL4zVMcsH4BEUV1NwoCQfXffHgIhxad80QCQ2qV008KHhn1Vv
	 hoROFzflbLsBCI3TbtUudMRip+AD3zcKQc/WxZWvjH+kvUUrRZf1kgRbUHtIKUbl93
	 uDwfi6aqAsyDMGoFYTAiRhyXbFN6YYa4qhwczpJtNWzGb73RaAA7rnjEVaNxUf1bNf
	 DphOwtdl5EriObrDYPtNfFlpiKLOUudJbjBdUgRbArSbBe91yejtE9j/5NCe9eevAu
	 ls+6bACVYRRGw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/22] mm/damon/paddr: deduplicate damon_pa_{mark_accessed,deactivate_pages}()
Date: Tue, 13 Sep 2022 17:44:29 +0000
Message-Id: <20220913174449.50645-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bodies of damon_pa_{mark_accessed,deactivate_pages}() contains
duplicates.  This commit factors out the common part to a separate
function and removes the duplicates.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5eba09d50855..dfeebffe82f4 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -231,7 +231,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 	return applied * PAGE_SIZE;
 }
 
-static unsigned long damon_pa_mark_accessed(struct damon_region *r)
+static inline unsigned long damon_pa_mark_accessed_or_deactivate(
+		struct damon_region *r, bool mark_accessed)
 {
 	unsigned long addr, applied = 0;
 
@@ -240,27 +241,24 @@ static unsigned long damon_pa_mark_accessed(struct damon_region *r)
 
 		if (!page)
 			continue;
-		mark_page_accessed(page);
+		if (mark_accessed)
+			mark_page_accessed(page);
+		else
+			deactivate_page(page);
 		put_page(page);
 		applied++;
 	}
 	return applied * PAGE_SIZE;
 }
 
-static unsigned long damon_pa_deactivate_pages(struct damon_region *r)
+static unsigned long damon_pa_mark_accessed(struct damon_region *r)
 {
-	unsigned long addr, applied = 0;
-
-	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
-		struct page *page = damon_get_page(PHYS_PFN(addr));
+	return damon_pa_mark_accessed_or_deactivate(r, true);
+}
 
-		if (!page)
-			continue;
-		deactivate_page(page);
-		put_page(page);
-		applied++;
-	}
-	return applied * PAGE_SIZE;
+static unsigned long damon_pa_deactivate_pages(struct damon_region *r)
+{
+	return damon_pa_mark_accessed_or_deactivate(r, false);
 }
 
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
-- 
2.25.1

