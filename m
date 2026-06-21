Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1412D3A75;
	Sun, 21 Jun 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057465; cv=none; b=EvRCOz19KtXBvrGNPyEXNzr1MUVq48FWFz69PFrQYKyFuU8lJHYRBHJiBavUpSmPaDznGpPzgZj0BuwpVT6DFuaXmU2g2CCIVTz3NQ1V2jRg5NIfrbm0EK3fxHasPv33icaGnWZepvgujTnPuRuwoezC6heQoPkENpJulzyUMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057465; c=relaxed/simple;
	bh=lyEyFwuk2du7esQJgsMsYO+Itcd9tto7cP1YGOqaBDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGrrqGvOBu1jH8Q3CrnZAIoT0Qhf+/5cNBgl+CrJS9z3aftnLWOXwnGzMh4Z+3FUr44Vv/BQNhzX7sJwfzUGKNsRXNj/1qvb/EASKkQv5u3gA9wWetYaKgxRaZzzz80YvqdWflDiAM2175AOHIc9n3p7fCFE2wxQiUW39/zmZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqNv7/Du; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqNv7/Du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E833B1F00A3E;
	Sun, 21 Jun 2026 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057462;
	bh=4SCo6lzfTq2NnUpvCBQ4Z8jQXScoLCzX5q9Y3rAVGW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lqNv7/Du8+OBKTSKBj6MYibfAgRaqYsLp2aNRZOlHdnSQQoofM9LS7XWeKKGazW71
	 bICjE0aaZEavlvoBmRcW1ey3b6zwYgfJIhKsXoOmhPczFv1Aby5cBXZkrXoNemBc/B
	 SMhaWr1TVLHQXW9FT+4iw3jFpu8gfLbA31kDeZDqVu5miYyALaqjLhnxJR2HfBQm6z
	 k931Hm3fKMGRXXyDrXVg0tVglaHRgAMzcMOZNrZKFm4DNfc+Hie0k9wuTpCoonB6t9
	 gWP6XVG2xJNKp4XHclXT0eN7hqZ/6PdKigzWiGWqRN1feCtbhcAJjDMa0xUiUSGxxX
	 WU9ow8qXt3Kmw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 14/17] mm/damonn/paddr: remove attrs param from __damon_pa_check_access()
Date: Sun, 21 Jun 2026 08:57:10 -0700
Message-ID: <20260621155715.87932-15-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is not using the parameter.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index db48ad274b078..a301e831a3945 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -82,7 +82,7 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 }
 
 static void __damon_pa_check_access(struct damon_region *r,
-		struct damon_attrs *attrs, unsigned long addr_unit)
+		unsigned long addr_unit)
 {
 	static phys_addr_t last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
@@ -111,8 +111,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(
-					r, &ctx->attrs, ctx->addr_unit);
+			__damon_pa_check_access(r, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
-- 
2.47.3
