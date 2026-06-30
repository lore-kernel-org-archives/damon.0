Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5BA3DE455;
	Tue, 30 Jun 2026 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792509; cv=none; b=FOBoFm1qWKEQbIaJtDIALmvWRKyEHG9g1awncwMJ1oi8K0HBhalwJAL0G1iZH58DJqkruufwzgne40CH4A6CdDQIttlriZ17zL5oKOSFtwv3oQmp4OidoWQY1IrEnReshg/A1DmTXs0jZaVEPlS35R0JhH2Up2TRmxiHDz1Mz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792509; c=relaxed/simple;
	bh=bMQFYC9Y0j4SMVXAHuWHysS+h0U3ibYqWc7I/xeb+U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPkUYW+VQVLmRkuHIoU++awnyf+CD7TqviHOXtr+1QsZxfFlWyYynXIkmW0UKjreqjsMO7KW5VI9odqwlgF0bEeWpqFWuRV/m2rjEU6jore0lSLpv0AoHjmDUI76e63QoGSoURmVIxgcJS+3TFcytT0OGYPK9QzvRf+Y96Ly/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY/EbHjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY/EbHjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB5C1F00ACA;
	Tue, 30 Jun 2026 04:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792508;
	bh=AeaX6kvkHlHkpOf8DnvsGxy9uMSNxNlGVRxbrbpMKQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DY/EbHjPDTE17mIGg1SKxqLW7Sf+TwrTRwaQEHJdTfQ7Gh7cB5+hRBdoFBOpFgtOm
	 TNSE2lbhG5PCMyG7azKi7I2ANSfqVHqMMaz4YifHCCQbrJ2kKDArnRk96CsTLTo4To
	 3pjKH0+V8BQko6xXXGGeun3dTMdByJrIdTSc9YrFM/NwFTtl8yjNK5h81iANSokbUX
	 IdO4AGTJK5WFiolJutdOLGN3/HH0TsIGt2w8Iyy1KOgHbqXJcMpmrWoCXlU51Um2Dm
	 Kl1H3C0XSz3GLc5rVaQWqHK0Nj3hya7mK9C1bX9oRl8jUrfEWkOc+qHzyDIsjRV3p8
	 kVABhTWAHMj2g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/18] mm/damon/core: remove damon_verify_merge_regions_of()
Date: Mon, 29 Jun 2026 21:08:03 -0700
Message-ID: <20260630040812.149729-11-sj@kernel.org>
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

damon_verify_merge_regions_of() is only for nr_accesses_bp validation.
But nr_accesses_bp is no more being used for a real purpose.  Remove the
validation.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bfef6a8556c8d..78c32ee45d28b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3121,20 +3121,6 @@ static void damon_merge_two_regions(struct damon_target *t,
 	damon_destroy_region(r, t);
 }
 
-#ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_merge_regions_of(struct damon_region *r)
-{
-	WARN_ONCE(r->nr_accesses != r->nr_accesses_bp / 10000,
-			"nr_accesses (%u) != nr_accesses_bp (%u)\n",
-			r->nr_accesses, r->nr_accesses_bp);
-}
-#else
-static void damon_verify_merge_regions_of(struct damon_region *r)
-{
-}
-#endif
-
-
 /*
  * Merge adjacent regions having similar access frequencies
  *
@@ -3148,7 +3134,6 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		damon_verify_merge_regions_of(r);
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-- 
2.47.3
