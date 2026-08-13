Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301B03612E8;
	Thu, 13 Aug 2026 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593013; cv=none; b=Xc3Rx71QsGKgptOpz3koyqo63wrfEy9/Q/tkP0Ll+7KFlw99nPFOtrualPYE2Ppec3IkquBLC+AnWrJ3045mrDOFpHMViwtoeLoi+w7vXg6ULHpzbJ1jfmNzfb7No5rEybgJe+RFYloAvjAclF1uhmeBBc63U0rFOelKTakzfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593013; c=relaxed/simple;
	bh=wAZLCviLOkwAGlvhZFB48gga6WtfFacHiZ14c/z8NiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ds8cokYh9NZBFzRJvTMxuwD7VtzMhv4qJIC2aaoOjhr2ZkDjvpc/nrpLCRjcLYISiLhIVfGaTwX6AzNOTm0I9KW5uZK+JFaykuS6uk//TQG4ePFi+AZStvh5fV3OgyHGURqUiSf7RIwOHW4ipTWCgqCV2nLOhR0OZ56mXJTsWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOj3dCJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOj3dCJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9CF1F00A3E;
	Thu, 13 Aug 2026 03:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593009;
	bh=bFqUVYf2n04Uixau/NkzvcP/6puf0JnXDQxViDXP7BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZOj3dCJ/1d3ON081pPcVJreuyCmWBp+g9lWZeT672RpxyAgNE0u/xEa0VbttpZVSB
	 RXQi/h/A/XyUh6lqJXEMCowjcMLF9EvJsIFKiUx0o+LFheHNXSrZ4Jr5aTOUdnmEOw
	 0966Xms2D6m+ziu5O+Z75zFAdTnDlx0BybIKL6n0gJWTFRVK94enFhCM+1o1HJyHGO
	 Weo4J041qAte4Gawte5oeZ2B298hmFP0Dg9/IB8mowtQHU+w+550V3OWS3vBqp4Zo8
	 282vrVqncGxGDbyZtUGyenSjZQwvewRbSRsW+qT3+0MgNgerYhRkYk0RfspjGKVS+X
	 jtrvCMexIeW3g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] mm/damon/reclaim: remove unnecessary damon_call() param validation
Date: Wed, 12 Aug 2026 20:49:58 -0700
Message-ID: <20260813035001.97364-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813035001.97364-1-sj@kernel.org>
References: <20260813035001.97364-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM avoids passing NULL or unstarted damon_ctx to damon_call()
with its own validation.  The validation is no longer needed, because
the DAMON core layer now handles the corner cases itself.  Remove the
unnecessary check.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 45d5557cc575a..42a2c9cb13431 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -271,8 +271,6 @@ static int damon_reclaim_commit_inputs_fn(void *arg)
 	return damon_reclaim_apply_parameters();
 }
 
-static bool damon_reclaim_damon_has_started;
-
 static int damon_reclaim_commit_inputs_store(const char *val,
 					     const struct kernel_param *kp)
 {
@@ -293,10 +291,6 @@ static int damon_reclaim_commit_inputs_store(const char *val,
 	if (!commit_inputs_request)
 		return 0;
 
-	/* Skip damon_call() if ctx has not successfully started. */
-	if (!damon_reclaim_damon_has_started)
-		return -EINVAL;
-
 	err = damon_call(ctx, &control);
 
 	return err ? err : control.return_code;
@@ -343,8 +337,6 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	if (!damon_reclaim_damon_has_started)
-		damon_reclaim_damon_has_started = true;
 	return damon_call(ctx, &call_control);
 }
 
-- 
2.47.3
