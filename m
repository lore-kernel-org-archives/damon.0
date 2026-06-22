Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CAD3BF679;
	Mon, 22 Jun 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138127; cv=none; b=uhxmJgEAZ1u/AH0E+BjIDLIzBhSGrYvtaznEXRDTFa55quZQ2PCHovBHnOgTrcLmNBna2kOMosx2UblWFskuSAa6NOYLAPZE0sShnl8AwakLtnCv4mmlcFjvhyYQ1KRZTZKAhTWXf6f0OeLieH3I0bWwDPZIstcZ+tb9z62yIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138127; c=relaxed/simple;
	bh=lyEyFwuk2du7esQJgsMsYO+Itcd9tto7cP1YGOqaBDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnoPwz0czPa46Cmz93vcASrbG3YhRR1O0U1zlxArIaMpHAbTzH01hmtG+bl2VIc8K/+gMUk/RY7YiBYqCgsRLd52fTLi7G/NdjhXaD1bgTJFPN5175UqUJFqC6yhfhLngMzi0qoMvb3R5HQ16SO1HBO6Jy/c7wAhGN2FAfug7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQk78hTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQk78hTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2971F00A3E;
	Mon, 22 Jun 2026 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138126;
	bh=4SCo6lzfTq2NnUpvCBQ4Z8jQXScoLCzX5q9Y3rAVGW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQk78hTnJ8eNlf1ewgMytoD3vl5FB50qv1ZN1hvnJoB7BPPBS6sG0RXknLtEEYTfp
	 5k5gHrTrnGZu+vIgJ4U4TW6UX8m9/bjSPKW67R2hseYeEO0N2d3tZ1CE0dM/evRsSZ
	 Wrxx9bcY97kzpjUO+DoQI4Q9a169qG22CQMGJlY3jC0DyLm+/cOrk0RS2ZlpDjH+fh
	 Y1qy9KKHth5FiqNHhkomyE8qiPZlltujKfU4oA19/AXsmyCGT6iPDSNkzJeUy8qda+
	 1Or/EDQcxnGgBiMiF9ouh5aNquaGcJUOzGQfhvFuHpQ7RY2pwdMwrZLxG/MfcXR2jc
	 IAjlparSKqkwg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 15/18] mm/damonn/paddr: remove attrs param from __damon_pa_check_access()
Date: Mon, 22 Jun 2026 07:21:35 -0700
Message-ID: <20260622142139.30269-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
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
