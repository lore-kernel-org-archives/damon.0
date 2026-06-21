Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5432C2D2382;
	Sun, 21 Jun 2026 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057460; cv=none; b=bLefLtSjNn+Bpu2AbdOICdRZ9w8gT5Pi7jW1D+QNoIy/ghkmiXiEPKqoE72ZrvZXIBlaKVZWGNt4LRx6J+6O14YIpx5iIapV9iHgma83D2h4EJ7Q9pIKKjh46HM/jGAq4bRnJkijtODw3OAX/Q5mor55D8JSDwRug8xo4uIr+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057460; c=relaxed/simple;
	bh=etkah1d9ED8v0h45ogs0I/182hJHhzhkse6ZP4WUvoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuKTmAZy95YwWPPTiTe33GWaBiLy79j/Yh73K9rHEtKrF3hlY6tCd5WvyIkqUBnsuQh8m3H42bWmCbWUftKbFH5TYQ9lMvk5WkFd4B2iggvYtHjvXfzrbOnV1ciidVrABP82IFhOGMUkrPNId525Wy0jpMa0pdRRnEQth2/oMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofNK3KGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofNK3KGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4861F00A3D;
	Sun, 21 Jun 2026 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057455;
	bh=AJ3stxT6aRCI9DnbTthOdJWIipgq9UMulRZrQF4jmXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofNK3KGpvnR/g/IGjlCw/xf1+fltfCmEYDyg1gR9MO0Q8uerA9pMgo+mZrF8h42fG
	 m0J3amdg5+uZ2hyW+W/SfhIdybyD/KdEq9n0KiToa6ywbJ+xTdk2ele5DdXeAn2+lR
	 6qRwjgV27ktCi4c07vu1mA97duK+Sbwyl4qILClctUqPzcq8RM2WRM51LBuj675IWP
	 9DXpyqsqWVM8mpqiEsH6eWLTD12ogpalhTT6QV/fXVI62mQtgHCbxzSGhL9OJHLPZo
	 54wKwEQ4e0ICU2lRBdB4SM+OYMhahRw6UaI8eCYX/4W32waXClBZOG/OZuUfCr4Tmm
	 tSEJ3nxb3npCg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 09/17] mm/damon/core: remove damon_verify_merge_regions_of()
Date: Sun, 21 Jun 2026 08:57:05 -0700
Message-ID: <20260621155715.87932-10-sj@kernel.org>
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

damon_verify_merge_regions_of() is only for nr_accesses_bp validation.
But nr_accesses_bp is no more being used for a real purpose.  Remove the
validation.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7bb9b3c32d6fc..76ac58bf3dff9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3114,20 +3114,6 @@ static void damon_merge_two_regions(struct damon_target *t,
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
@@ -3141,7 +3127,6 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		damon_verify_merge_regions_of(r);
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-- 
2.47.3
