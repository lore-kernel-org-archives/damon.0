Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7B3822AA;
	Fri, 19 Jun 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897682; cv=none; b=S7rDIVn2h79Rx0gZff8cUYBTCTIYgvmKHxT389oCB/TYxDaiuFIMeF0z04Xf4M0w6in5CrA6kWoLSXAwxVNIAKoXNJmDUF7+zri1KVtO5Cf6pxBBuApoO4PJeuwpijcXk7PoVEPoHlkwCTDRGS9DEUPrMKjFSSLFbtv1v2jrhis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897682; c=relaxed/simple;
	bh=B/56pUaar7MlCn4AjLaim6IUwqNS4vH8Ek8BdRTaadk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIAbR+7SJcxA6VCf9V9f0MGJGPHkpCeqB0Gs3rgsgV3kR8W9OyBwl1B1IX3274Pf+eukFsU6SJ1uzP8oJk2g/p+fPvA25PVLx1AhPtduvP9uEFBVBB1WHK/mvjbcBefpPzBW8i9DnyzkiJwwd7pu82oDLEuLvXxdNwHK3B1ihWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNt+PiuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNt+PiuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BE31F00AC4;
	Fri, 19 Jun 2026 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897678;
	bh=tOLvV8tB06/pvCLjG2dl48pE3b9/q317si70zxHfWTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bNt+PiuRHcp1/q9m4TXokEOUpQ8IdcXtMFnOt3EY8sxikaiKbXsQPHt7/RQl8F/od
	 bMI5JZrxr+T4lBr+kN7BfSwsZfh36msxkMA8nbpEnINZmodviU3FAMEioM8QlbgU11
	 ykKCJEy+VanGB3woPJA+/tmWIibQmDnRYaW+jRT/F8/t+Ue+WYk5sk7e63JTsX0oz3
	 +YIC0aFUhT3mJ7cPqefLGXNO5W9UQMj1JLxbg3CkH7VOVH71GQ43+Krb4c4vq0/SaN
	 Y92sYr7lqBsjuRtXiwkDQtrWs0l58+qZjsLRxP+/s7PRdx9vi3msEoSfBQ9zt4H9Fz
	 wesUyjV8XjX1g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/13] mm/damon/core: remove damon_verify_merge_regions_of()
Date: Fri, 19 Jun 2026 12:33:53 -0700
Message-ID: <20260619193415.73833-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
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
index 9b8423056d879..f2db39aa34f4c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3107,20 +3107,6 @@ static void damon_merge_two_regions(struct damon_target *t,
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
@@ -3134,7 +3120,6 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	struct damon_region *r, *prev = NULL, *next;
 
 	damon_for_each_region_safe(r, next, t) {
-		damon_verify_merge_regions_of(r);
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
 		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
-- 
2.47.3
