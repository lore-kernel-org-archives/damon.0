Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932C260565;
	Tue, 16 Sep 2025 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993722; cv=none; b=goWYHFCyVmogFHcKcWcGtJMwZ+v40TO4xbpcixiytVXzqTr+Gj1o242v2tTIttK5isea7DTsD2V3q2cduxcA/3CMpJQT3k0BaYvVqlYIl+ivP7nLAnR4akJQBZK2e7PhIlvuRHMXVN/MhtBKOt9/SEANc2y2IrW4ELPgWxRYpsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993722; c=relaxed/simple;
	bh=AfFc3OpSjbhPeNbz+Yb9iOakhYwHCt/NFSR70/mcjZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RgxWpPgRA3A2oAMNeDU4yYpE0hkbv1A1TeyPdUMjVFhP4443AuPi0j3ONrSVPq1/42pCbBtj3kTsGNOoQ8SH7SO4RV7wzDPec22FE/OMLnJLBo99dwDC57peDEsdqz1mISEuiT1xIPGc4Ys7sYkS1ReAK/dPA00o9ug2U0tjniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCaLOGwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCaLOGwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE366C4CEEB;
	Tue, 16 Sep 2025 03:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993720;
	bh=AfFc3OpSjbhPeNbz+Yb9iOakhYwHCt/NFSR70/mcjZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCaLOGwZMAAJUlm+iZk8xywaYfHX/rCIdKmJ0AenkSvV/KiDRTAceiXlRsY9M6iVV
	 T8LNEoolqh6ge7VDc6/k7bzJi3vckF6xt/TBebnEU5PvB2Oty5fJzrOVZju5FXG2Km
	 BVVtijmUVBPg8wgA1z3ID0USW3grfC7+XHZXTjAuB7xMGKRG2E5BjK9PF78HnlIuKF
	 6pRTFaxvX10IxERc8GeQi30SaP5AvT7BH0twMDd9Dg3fxuT0SlLv+htgCIuBJn+Ewb
	 fcbVv1jlhhS+GqB7Po4dt8YdoOHZ/nk1euOotZUHBPBCJAC9lCsJepc+s4YRrzeNow
	 GR/ShJkmHhW9A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/reclaim: use damon_initialized()
Date: Mon, 15 Sep 2025 20:35:07 -0700
Message-Id: <20250916033511.116366-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916033511.116366-1-sj@kernel.org>
References: <20250916033511.116366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM is assuming DAMON is ready to use in module_init time, and
uses its own hack to see if it is the time.  Use damon_initialized(),
which is a way for seeing if DAMON is ready to be used that is more
reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 590f9d6c55ef..7ba3d0f9a19a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -349,7 +349,7 @@ static int damon_reclaim_enabled_store(const char *val,
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
-	if (!ctx)
+	if (!damon_initialized())
 		goto set_param_out;
 
 	err = damon_reclaim_turn(enable);
@@ -372,8 +372,13 @@ MODULE_PARM_DESC(enabled,
 
 static int __init damon_reclaim_init(void)
 {
-	int err = damon_modules_new_paddr_ctx_target(&ctx, &target);
+	int err;
 
+	if (!damon_initialized()) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = damon_modules_new_paddr_ctx_target(&ctx, &target);
 	if (err)
 		goto out;
 
-- 
2.39.5
