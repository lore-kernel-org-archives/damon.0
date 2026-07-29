Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E0304BB3;
	Wed, 29 Jul 2026 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296282; cv=none; b=dK/yxBwPRD51h4ZHy8VX/fzvJA+7/rvD8SNpwdL3XgGQSvu0tvxCkpWdUu1/JhCHzG6kThLu0JXWfLk7f29p+8UibrVmd5Ol+7GAWuRUTXAnZ3vDp+oAsLebEGuRzkyqxekwsBbOjHAcFxdy042pwFO9KoRclwdo0AXYYHmgUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296282; c=relaxed/simple;
	bh=hBXKcXG4b0K0CuDzEh4AFJo8ClqwVQvOP73HkbC3Jc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh64xGhKVqTiHOw0G316YWm6WHYs5Y195v9BiLeSR96QnnHrhxCTcF9cTY7pC8DIgby5omA7c49uFROh3/YLTS8Y/f5rdQx7kYfPwW9p3RSENd8KoPlkK3TrePjJc7reMs2fE+uozI3UeG32hPrrziFxPZmEYHKMH67FdZ5IAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD5nRq9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD5nRq9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C21F00A3F;
	Wed, 29 Jul 2026 03:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296281;
	bh=OrmqzezRZHpLkQbXvsx8kdT8w9xKKaZj6lZcjNbOnP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TD5nRq9BrIBNUNfBlS7ERMfjkrbTQsnW9PQaVv/TJJGgmWTHMk+Ch28JKpN6hT5vf
	 lpEcSwBdhMu+fJqh+EyKbyfJg+LZFJZhS+JeB5dD7md/+dK9Hpkmt14xWAHaVcfR2b
	 iGWQBKy+hDf86toKlZEWflOolW16RmoFxw9ra3sDmGFnQ5aPEvhDhdLGqHydQ+MHyd
	 V9aqPBmpxh0b09lBd/f5JmvVoSTAZv1lz7ZvDwmWXlu3bhtY0Navh0Soq9Ug+LVPFH
	 SApGHpoPVyPMoa6dmXIvbKV4StR1xv67nIVoRa7pZxz6AWswA6PLH3GSuJ2cIL4BEW
	 rIBYYzIEwtitg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/10] mm/damon/vaddr: remove a debug message
Date: Tue, 28 Jul 2026 20:37:43 -0700
Message-ID: <20260729033751.131213-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a debug message in the DAMON virtual address space operation
set.  It has not really been used in a meaningful way for the last few
years, though.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 0648400b2d65b..1b220f6f2632b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -189,22 +189,12 @@ static int damon_va_three_regions(struct damon_target *t,
  *   <BIG UNMAPPED REGION 2>
  *   <stack>
  */
-static void __damon_va_init_regions(struct damon_ctx *ctx,
-				     struct damon_target *t)
+static void __damon_va_init_regions(struct damon_target *t)
 {
-	struct damon_target *ti;
 	struct damon_addr_range regions[3];
-	int tidx = 0;
 
-	if (damon_va_three_regions(t, regions)) {
-		damon_for_each_target(ti, ctx) {
-			if (ti == t)
-				break;
-			tidx++;
-		}
-		pr_debug("Failed to get three regions of %dth target\n", tidx);
+	if (damon_va_three_regions(t, regions))
 		return;
-	}
 
 	damon_set_regions(t, regions, 3, DAMON_MIN_REGION_SZ);
 }
@@ -217,7 +207,7 @@ static void damon_va_init(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		/* the user may set the target regions as they want */
 		if (!damon_nr_regions(t))
-			__damon_va_init_regions(ctx, t);
+			__damon_va_init_regions(t);
 	}
 }
 
-- 
2.47.3
