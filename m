Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B3F385D6B;
	Thu, 21 May 2026 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335643; cv=none; b=hZiT7CNgQw76A4WVx5xdj0vMtDeQSTRU5oPLd57fk7aRIK7n7wwBbYTTVRae6K7+RYq6ElmnQxRp9v3gLMZlPtc7MPYhWmLjgGagyYwc7JU6V2W5mLWjgB4sJs6/V+YOCVTysuGLgzFi4xE5Chmxjin1LWxXCaf9wI6uAm9oGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335643; c=relaxed/simple;
	bh=Io1W+l0y38wprpiIkcNjCK1tfQcAY0yDIRtRdd0LSw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybz1vM3BUGZsQd20Zq8UMg/QTNO7/HqHJKKM+1u/jZ31dNmNLh6UifoqkXMPjHCBf4IVBXEhbmk8x40Jh228vAqnuo/760nMIJLxCZj+hcO3oZO1Kq/ibr3wfU4r3kePIaXKhhE5dYWqVdlg/P1dNAFi/pvR9B+BidMCh5pcwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnJrB7cT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnJrB7cT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407141F00A3C;
	Thu, 21 May 2026 03:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335642;
	bh=ITBL4yRv8OcoOU4P8OrL5kgNMtEVib2v8kU4r8mcDLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnJrB7cT4v3dYGSTNMSiwj11LmzPl3hj4+zec1b/QKOlZmz6Jbv18DBi2cq4Z8vIu
	 QSSFsb3zfslf6R2teLc+/GMdrw7Ehs1pXQDfeMo9sm7mi31Eex0LsHseyjm0UuIkUZ
	 /eCjIagNJjvgnHVGkQGZ7+XAYlIcDgLQ9ARyoxBvhEYBKbYv3Nq3UFIOp7pYrMDNaz
	 BG7V4mztpawULh0xTOyvpyPv+VXNoEEeTAdQ4ufCSL9/zvxGNyGJy9u3PJzzpaXnYP
	 vVh1CJeEHjNiPvikfAABfjIMvl5xQ89kJG258ePEvNra2GGFkYVhqaSQcLovHhOe0e
	 aESjE1abkRpmw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 07/14] mm/damon/core: hide damon_destroy_region()
Date: Wed, 20 May 2026 20:53:41 -0700
Message-ID: <20260521035349.87565-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_destroy_region() is being used by only DAMON core, but exposed to
DAMON API callers.  Exposing something that is not really being used by
others will only increase the maintenance cost.  Hide it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 1 -
 mm/damon/core.c       | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3acca7deb1693..638ee65f88dcb 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1013,7 +1013,6 @@ void damon_add_probe(struct damon_ctx *ctx, struct damon_probe *probe);
 
 struct damon_region *damon_new_region(unsigned long start, unsigned long end);
 
-void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 53b4bdd27b39d..8a9202937781c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -291,7 +291,8 @@ static void damon_free_region(struct damon_region *r)
 	kmem_cache_free(damon_region_cache, r);
 }
 
-void damon_destroy_region(struct damon_region *r, struct damon_target *t)
+static void damon_destroy_region(struct damon_region *r,
+		struct damon_target *t)
 {
 	damon_del_region(r, t);
 	damon_free_region(r);
-- 
2.47.3
