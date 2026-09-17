Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E205908DA;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654943; cv=none; b=on1QQA4TUBghZNn9QNLPGAcJlZrwaROQRlTN9ueZ8sIassSVb/CMcLwa/YTm1Y+yO4pkG7E1hmFz+sUDTBkk5eX//aNsLrYngSM/kIC/ccgRG58e31UeYmx2BaA2if42mNer1EtiE6k1sOxH6027MhYuelntPxZbVXBqvp6zoPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654943; c=relaxed/simple;
	bh=Ddkx7ZTSFvFyvhnKdja06+laaOkv/3+hcb3Kam2zg7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3jlF5wOWKlSUPsPpfy23jGGXBF+j+LFuqs5wCsx2bSTbtzy4DXYn+rMklxFaDoO4edytlaXso/f6gUWvGngFWLzO6HxhEIEOlp/6vtc3gzYL4xOr+47dz5zolPhfAzsQ7cDD8p8Zp0NNvCjEX9vRyANlsWVJlq/rhEujQIY3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltc9y5z/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltc9y5z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F81B1F0089D;
	Thu, 17 Sep 2026 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654940;
	bh=3HzbqHqjQymjaA7BsBDU1/xd02tq5ixlWdlSiDNtUtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltc9y5z/3ONggzQaz+gWDW8wvl9S5sQIQvHt4ii/ZG7pw4aYnhxQILLkHd0qMSIPd
	 QX5qZgfzGBZaPQWgqq1C3J71poLBiq5KvE4fNgneVsV9IfpdC7UqsBAvNIA68dw0Ft
	 zJOA2aa+AhZ+DLS10cWjzjM5cjN4gX1qZyKBvx7vhDXEu5Elbiv17UQwJsLvSx7lip
	 jWU/j0V+ccDF+Rt9HBkImVWV2l8JOND8kN/T3MDg0aVLDX5BgTyH0KUIrMnHhGmLXj
	 E9j+OlVfh6B9EKu6HW3ByybAECIXzsJLj/BmzBp4D4YFpkmq1xZEXhWJyV3YBxTI3z
	 S6LrUkRHOD9Hw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/paddr: remove pa parameter from damon_pa_filter_pass()
Date: Thu, 17 Sep 2026 07:22:04 -0700
Message-ID: <20260917142210.90829-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_pa_filter_pass() receives the 'pa' parameter, but doesn't use it.
Remove the parameter from the function signature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5abfabaa339e0..2cfdc356b4157 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -163,8 +163,7 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 	return matched == filter->matching;
 }
 
-static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
-		struct damon_probe *p)
+static bool damon_pa_filter_pass(struct folio *folio, struct damon_probe *p)
 {
 	struct damon_filter *f;
 	bool pass = true;
@@ -200,7 +199,7 @@ static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
 			damon_for_each_probe(p, ctx) {
-				if (damon_pa_filter_pass(pa, folio, p))
+				if (damon_pa_filter_pass(folio, p))
 					r->probe_hits[i]++;
 				i++;
 			}
-- 
2.47.3
