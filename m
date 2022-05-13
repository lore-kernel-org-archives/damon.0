Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6614C64
	for <damon@lists.linux.dev>; Fri, 13 May 2022 15:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85191C34100;
	Fri, 13 May 2022 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1652454038;
	bh=dvkE+Xle/CL236kYATrTSaFb/CzjqEqgY0TtOELuS3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8xkcMwft8MJgi5PphUHDXBPYWeRuVAR9cEtuPyM3CN3b3Stzq8L9ooP1Xmc8xPc6
	 5PPqqjAnCV1UyX2GcnApgnhwTq94CHyWAsTfFHUSlxGkzjNq8SIehWGhdObmVyCSJI
	 dg6QFE3X8lSkpdgqFCieCzbpPGH2nJrpP7BhimaJKGUoigLKieCQkTGNCK9L0IuftZ
	 0jyXQ3FsdasiWkPdTUqNpq4juzPBY7aWZ5jS70hVOn+avgDIPnQcFFedlc6nNpy9DB
	 EwVsolHZXS/3tLcnqYnIkyh4xwa6N1BtPOLsU1FUi0Y5CCQXGb86NqZ0pNdy4lawcB
	 Rj5bHogHTx8aQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: linux-damon@amazon.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 3/3] mm/damon/paddr: Support DAMOS_COLD
Date: Fri, 13 May 2022 17:00:00 +0200
Message-Id: <20220513150000.25797-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513150000.25797-1-sj@kernel.org>
References: <20220513150000.25797-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

DAMOS_COLD is currently supported by the virtual address spaces
monitoring operations set (vaddr).  This commit adds support of the
action to the physical address space monitoring operations set (paddr).
Using this together with hot DAMOS action, users can proactively sort
LRU lists so that performance degradation under memory pressure can be
reduced.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 69980b922bf4..761b1580271c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,6 +249,22 @@ static unsigned long damon_pa_mark_accessed(struct damon_region *r)
 	return applied * PAGE_SIZE;
 }
 
+static unsigned long damon_pa_cold(struct damon_region *r)
+{
+	unsigned long addr, applied = 0;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+		deactivate_page(page);
+		put_page(page);
+		applied++;
+	}
+	return applied * PAGE_SIZE;
+}
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -258,6 +274,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_pageout(r);
 	case DAMOS_HOT:
 		return damon_pa_mark_accessed(r);
+	case DAMOS_COLD:
+		return damon_pa_cold(r);
 	default:
 		break;
 	}
@@ -273,6 +291,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_pageout_score(context, r, scheme);
 	case DAMOS_HOT:
 		return damon_hot_score(context, r, scheme);
+	case DAMOS_COLD:
+		return damon_pageout_score(context, r, scheme);
 	default:
 		break;
 	}
-- 
2.17.1

