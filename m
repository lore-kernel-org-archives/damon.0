Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682F3DE433;
	Tue, 30 Jun 2026 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792509; cv=none; b=ZBkD95fkZStpK/ble/6uoCzy/l7om4lAKoBa/GDUBLyvZu+9WzGlomhKiNiZJ+YMuG8SEtEHjZIto8JTSTnj/drNoWIetknVBWp2edbJHFI32419eYZPDY/CuUoZrYdl3Bz8sHfqx2sSzRHldXFQJOsWjSaOzG2R+qzNZcapf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792509; c=relaxed/simple;
	bh=aDNY4y74UyHwAPDAndWTkjjijX0ZymJFngF28Ebc+t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHbPb3phZEv5AmA7CxNfuTqPWXAIjs/Ukb+gJMxKeqML4jusXNEXUTzt4iaFG64SHpHvwRN7d99F3YQ+4iXbDZuUIijI9X+mHteTon3vg73f9/CS18EKFB0UPzbkC+vV9NSLDJXRV3xrD+IApRIjiWpizh/BOnqFCpXxs8WDcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVIJXHC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVIJXHC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC3C1F00A3F;
	Tue, 30 Jun 2026 04:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792507;
	bh=yfQjprzOnvA7X4Lkapy5NoOzGVbkDSS1TbGnomzln1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVIJXHC6Vw8ORLDT4fJrVGyc2qkVlERLV2YH2Kgk/RQlxH+MtrdW87rGGwXS6u3oP
	 3QIJiiP2d0KalJALBdTKmZp1w7KHmGiN9LSwS7cjmv5ju+JDtIc7yzcGc7bnh1D9D2
	 X0fwfz3h5eEJXPayNGdIdTBhyLi4OXWutBz8wWpjeuuozWskWK7Jbyzq58QaV/k7HJ
	 URUvNiF0/Tx/+n2N0tZukiKLp9LMBQhtI4/s+bRxZD7MTeIoeMCvFd52AgomfV3Wbw
	 VpOxaP8/rZ2Xa2hm8VxujKCKYCoiinduFE91DZd9vtomwdzlt039/yEXr8SXsPVu53
	 Ptt4PDGgZ5j8A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/18] mm/damon/core: remove damon_verify_reset_aggregated()
Date: Mon, 29 Jun 2026 21:08:02 -0700
Message-ID: <20260630040812.149729-10-sj@kernel.org>
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

nr_accesses_bp is no longer being used in real use cases.  Remove its
validation function.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 634708475c01b..bfef6a8556c8d 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2006,23 +2006,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
-#ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-	WARN_ONCE(r->nr_accesses_bp != r->last_nr_accesses * 10000,
-			"nr_accesses_bp %u last_nr_accesses %u sis %lu %lu\n",
-			r->nr_accesses_bp, r->last_nr_accesses,
-			c->passed_sample_intervals, c->next_aggregation_sis);
-}
-#else
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-}
-#endif
-
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -2051,7 +2034,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
 				r->probe_hits[i] = 0;
-			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
