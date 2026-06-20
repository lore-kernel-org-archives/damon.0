Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B7330315;
	Sat, 20 Jun 2026 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976189; cv=none; b=LhPf4SsBIJ1wFbpNNkWtDkuGneWRbsK5urrc49m8LpKR9yYvKMsUZWYEzLy7VmWti5wXw9siuOJxquVr9Mk6JyFr3rA1zjOmx0tObe0kv/sFjo6eSlRZan+Wg21FgVkn1XojAiG5mSJAPOXdHGVRPuibVvAgHrMg9OyZfSPWPwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976189; c=relaxed/simple;
	bh=iRVqIdXQ6Xb8mPVE3kyAPizBU3MwK0e2TtIbCVQ9Fus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXqTb5KnVFZmQB5WlQ/kX4KmN53DHoTL6VkeMmsM0Ad7+Y1kWyT6KaPq8OE/XMWLZkp1YZadF8TrKwv5YIJJY8LJLP6qC6VTumPzARFZCeNM7krPeuXTTWuWNej16A9amIXDKBSGMVYRZaloTL8uZbrw7XBbTDvFDAQRbTEt0mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJmCwMaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJmCwMaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869A41F00A3F;
	Sat, 20 Jun 2026 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976184;
	bh=SYAGsaO01kiQmgR5RMp78XMLHevy+rCRbusd/Bmkavc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dJmCwMaYu4CRKg7QWxPIpjdBYvx4AU6uOKZoiMzlEyROhtUlBopFwgPzr3c02XVcT
	 eVoZixq74e1u4fR+Q3Hz6qz0cCkMRuCVaDqEHRuK5gW0XNtpyPv+FOOqJ0uQdITW13
	 JsTYolmli/dYQ+rO/3jw5M8P2cx1fuep0FvKKMIIX/CCIuWuOVik6nfV5nmQep4jxx
	 Gc3Bm9owJcUc71xB9v0WQEp8/960veQX93mEYxKL/vqeGoWGLgwYyAa9EZtwbjMSxM
	 CMZgdnD5cxtULPztdmjhonngthhxDwgrcxQ/V+hcWiBDmmGgBoHf5kaOwUz03bVn0P
	 7CdE7Hgd49Qwg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 08/13] mm/damon/core: remove damon_verify_merge_regions_of()
Date: Sat, 20 Jun 2026 10:22:38 -0700
Message-ID: <20260620172244.90953-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
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
index 84d21d21ed6c9..6db157ee25129 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3109,20 +3109,6 @@ static void damon_merge_two_regions(struct damon_target *t,
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
@@ -3136,7 +3122,6 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		damon_verify_merge_regions_of(r);
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-- 
2.47.3
