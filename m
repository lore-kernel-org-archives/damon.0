Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFD43DDDAE;
	Tue, 30 Jun 2026 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792508; cv=none; b=bh1m1zoZzQ27VMqepHzd5kbdjgrN/dC1JlYriTmIl/Ox5ZRmPWtSAd3Mp+uvcDT36zJamiiSiKe46KECHezYvlw3IylVwBhUrheQCaKlKmIOQyzaWk67hvFS3J26QOgN69clJtHZi23PUVYIbLV0uGMCz9cZrh7uiFOD4eaDBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792508; c=relaxed/simple;
	bh=+eoncOAM6CpgXuZB011DDEkCvAXL6oOo+xYwoZWKmHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbsftzA5TBucdfVfzLqfn6uCLX1idarhWoN7ItLXqfjQJTQHmOSriMuEOTL5QhZi2nt7qj4o77V9iNeG59D87cGG6El15jTwF7WzXhxP4etRuFQ8XZI7m4O8RzrFKUgORmAF9n7yllhsenw9WMDqKsMZzTLL9HoJQMjXCnjhbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm2y7Hwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm2y7Hwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F31F000E9;
	Tue, 30 Jun 2026 04:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792507;
	bh=JRvSVKzpIplr+7ltnBKnWzHgirAUrH+Vc8lkxFHCvIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fm2y7HwtO18BzMHkwfFDKSVlC5dpZMxOKTEHA5I1985RY6Oy9+pP9nqvNL8/MG64x
	 gUaoKYRzK3VuzgDWBahW8d7zFVMzT2LTc6gp8zY++mVQbja1eYqot10pMKJXo8R1rX
	 rpZ8X+ocAMS3ran0C0XciYPRDWn+Xyi+8CpiJSIGAO5mJstx322viR0EV3cJYl8+a/
	 fd9K46d0DYq5A71rPJVrbuxXKj71IRutKJiXTbvV9quWUWRsorUKgXm6HEFQ5eYOhw
	 OdHHo2pMQl3dMY1tcb3xa7CJOQBSv7eJ5Z3w2KUzHvvb9FpAiuWFiqN6pPKmz36FhY
	 cm+3pGIlnbmsw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/18] mm/damon/core: remove damon_warn_fix_nr_accesses_corruption()
Date: Mon, 29 Jun 2026 21:08:01 -0700
Message-ID: <20260630040812.149729-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_accesses_bp is delicate.  Once it is corrupted, the consequence is
the bad madness of DAMON monitoring results.  From developments of
features of size, we historically found nr_accesses_bp can be corrupted
by complicated bugs that are not easy to debug.  Hence we added a
function for finding the corruption and fixing it right away.

There are no more uses of nr_accesses_bp.  Hence the function for
corruption detection and fix is no more needed.  Rip it out.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6423e7417c24b..634708475c01b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2006,19 +2006,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
-/*
- * Warn and fix corrupted ->nr_accesses[_bp] for investigations and preventing
- * the problem being propagated.
- */
-static void damon_warn_fix_nr_accesses_corruption(struct damon_region *r)
-{
-	if (r->nr_accesses_bp == r->nr_accesses * 10000)
-		return;
-	WARN_ONCE(true, "invalid nr_accesses_bp at reset: %u %u\n",
-			r->nr_accesses_bp, r->nr_accesses);
-	r->nr_accesses_bp = r->nr_accesses * 10000;
-}
-
 #ifdef CONFIG_DAMON_DEBUG_SANITY
 static void damon_verify_reset_aggregated(struct damon_region *r,
 		struct damon_ctx *c)
@@ -2060,7 +2047,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			trace_damon_region_aggregated(ti, r,
 					damon_nr_regions(t), nr_probes);
-			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
-- 
2.47.3
