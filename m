Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4C29898F;
	Thu,  3 Sep 2026 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397424; cv=none; b=ekSbxE/zziJSWz80YSCwLM3u3W7mLNHpxbkMty5TxYl4/g6aR0agYg1WsCUrjGtcUb4jcnbPwMnz3gXRDWQ+zheAf/WjyyZWClmA958HrIJs0bbA5S3uhPLScjTLyP4ylO+fKCTH9R8PnCH/8jHrntf4o8tA/n3i+m45/zOddmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397424; c=relaxed/simple;
	bh=wAZLCviLOkwAGlvhZFB48gga6WtfFacHiZ14c/z8NiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWGy/YEtI58cOkBlG4Mekgimwx5/XsVx0WSskBr2pHnOMXoif/MFYc2Y1fAUqaJ8fEQNNLgi7Lk6fTyZEy/ElCa5kU0K9ji1pgUU42B6JK1H0Bg67e8ZBO7rxGD1It/eTrn1GwYmA1Sq+bm2Jaw/XVe3h5NdPkvSP4biRp5soAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W21hnb7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W21hnb7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CB21F00A3F;
	Thu,  3 Sep 2026 01:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397423;
	bh=bFqUVYf2n04Uixau/NkzvcP/6puf0JnXDQxViDXP7BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W21hnb7eXdHFi5C1WDTJxhG7jrXJ3GRTxTkW9kXHLAflDXVKTfvdNeQzKfzYZJDIM
	 OkyuKIY20zYacrL6Y26G9sSwNzVPZ4nvRHrnky32h5IIPr/oVwCa2C/PZzglsSq35q
	 i2VcWvgmSs40pPuPwUtSTJMM1UPrOr00aRXUPck0Uz10xwYvokDhPHA22vBhQuwKYl
	 Seudwxv3FLimUuSQindVD9+RBkBQpqcL2X/K11Y8AgJo9aX4/KSeFiVA/HMxNUFXnE
	 2dXpn67RadvEj2yUpBivnV2xL+IaInOeiH0beKyN1yX8XsbBl8W2eOWka1L608IIm/
	 64zleUSZnJ+6g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/4] mm/damon/reclaim: remove unnecessary damon_call() param validation
Date: Wed,  2 Sep 2026 18:03:32 -0700
Message-ID: <20260903010334.93622-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010334.93622-1-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
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
