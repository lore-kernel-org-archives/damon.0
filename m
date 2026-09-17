Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F23BAD88;
	Thu, 17 Sep 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617948; cv=none; b=AtvOamMHQlbuGVkEkVSTY+Anej7n7aByNUZu/N4AD96zslBrO/HjKTS3IL7GhHLBY3AumZv0m2KJwdEhMuiFc+Yro6jkLZRqrERBY62pxMjKfRUMvygNGmgA1kMoNCBZYYQCCFRdex+bT7K2A/CUT1swWnPLYnAEpP5Ko/y8brE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617948; c=relaxed/simple;
	bh=Ddkx7ZTSFvFyvhnKdja06+laaOkv/3+hcb3Kam2zg7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGOgAKwylZNV1EMo9K/Omq5wupvaAMPc4HyCd5amw8GxJZXl6CYa3/bljx2pX+E6N0RTKwl1iWXwHP8yPWCOw1wBUvfx0PG8QW/30+WO3Jjy+Nim9jG6V/jp1dkldQI7rlNkXPgKAmhJneRmLRRfu9IZTURLCmYqRqK6tdAqjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVJlBFLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVJlBFLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204D71F000FF;
	Thu, 17 Sep 2026 04:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617947;
	bh=3HzbqHqjQymjaA7BsBDU1/xd02tq5ixlWdlSiDNtUtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVJlBFLuAAEcE0McA4H2A92moJphJQNyCLtRJOYqmffUyhdzTDtPz7AZYB3R4kvC1
	 VV5/cE5e2xkL+odrzu3tuJrCLgimM6mOCCZ1rqp7plBxPXC1GrN8a/YQEWLjqBwqU/
	 Tn1Sm0drOOrkqUO+dhSvHfnqdPNMMrR0whTPqnkAJzgYa1nEW+GdHt3Gb8cpSqJp9S
	 vOfNdgrXvPy9Rtv1W8hrLqZwmxZHypptUhbe3Mx+6dpSYeNUOg2cxXx+9p8dAxKPPC
	 /dqx9dDWBGV4XC/bvLjTCDGfP/xz2FUkDXx1PWB/Q8UzTGTTL7c4MKnlSwgcQLTnFq
	 t2uWbKUmxBxOA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/10] mm/damon/paddr: remove pa parameter from damon_pa_filter_pass()
Date: Wed, 16 Sep 2026 21:05:32 -0700
Message-ID: <20260917040537.107341-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
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
