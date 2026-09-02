Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEBC38DC48;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328077; cv=none; b=gTcA3T9vvVeTzpHEiEhppBoPmoGtdaNPEx4S6TDWojXIphxRg9AO1DGDOzFwP+BwJrhRAHsG76ipE3efbqs1B6y1lo8W4Vkg+SiBPmbc6wZFa/juWQX0RYO3ZcaBcg7ucBFDeOqv7pDjzMtO+4Igg2B45MMSYOc1nJDTf/Qsy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328077; c=relaxed/simple;
	bh=pwc6SSo0ilnNo7kmgrv0lqdGhpT5cL23cxEOjLyIPpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw/zYkAn9S/yYXmGOSSllvWoAT5lp06PRGve+nNKHa/KicDtT5IqL7u/1s5MEYX2FkarXDrwG+4Ek5jbuds17G9coUhnhoK7hFB8Ah/xvsitemTD5O6vEFNcTdAFAkmiY/U+GeGl8zTE5x/JnoW3bvN9aXIw2BpQVis6Criyw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5MjcTJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5MjcTJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080841F00A3D;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328075;
	bh=Yu+kT4VU1Q3i6GWtmiuhnaqb1nzKb+1ULapfSNKwafk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5MjcTJwwhXNehqyFOOBR5dL59vQgGiEePFKoIM3UBF501RxMgTX2frXPSBmDnsRt
	 JxaGVX44e6bMgyMMjtZPq1IZGPJoH/rfodeniXcXTM6iKFGCk6+TeT8rcnBt/Mf2Wi
	 2NZxQWYuwGxEmRNHT6sbv+qiRz1zwn5bB0j1obRDCmxwZybwerjxoYJx59uv3JSQ1o
	 DTWv5VKeulzi+NgJH392KdCLINF9B4zNWNXnMiib7YDxZsBkPFjQqLVrHaJgbF7U5I
	 btdZBZAdMDNEi+lfowYsQRsrsERQWG3OtppWdH051vAbEblAHcQ9J5fBt8M6BdpiF4
	 MtvqJActMDYFQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/12] mm/damon/core: remove debug messages
Date: Tue,  1 Sep 2026 22:47:35 -0700
Message-ID: <20260902054747.99370-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few debug messages in DAMON core.  Those have not really
been used in a meaningful way for the last few years, though.  Remove
those.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 846da6df5b552..4d28eb033fc4a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3732,10 +3732,6 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
-		if (scheme->wmarks.activated)
-			pr_debug("deactivate a scheme (%d) for %s wmark\n",
-				 scheme->action,
-				 str_high_low(metric > scheme->wmarks.high));
 		scheme->wmarks.activated = false;
 		return scheme->wmarks.interval;
 	}
@@ -3745,8 +3741,6 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 			!scheme->wmarks.activated)
 		return scheme->wmarks.interval;
 
-	if (!scheme->wmarks.activated)
-		pr_debug("activate a scheme (%d)\n", scheme->action);
 	scheme->wmarks.activated = true;
 	return 0;
 }
@@ -3889,8 +3883,6 @@ static int kdamond_fn(void *data)
 	struct damon_ctx *ctx = data;
 	unsigned long sz_limit = 0;
 
-	pr_debug("kdamond (%d) starts\n", current->pid);
-
 	mutex_lock(&ctx->call_controls_lock);
 	ctx->call_controls_obsolete = false;
 	mutex_unlock(&ctx->call_controls_lock);
@@ -4044,7 +4036,6 @@ static int kdamond_fn(void *data)
 	mutex_unlock(&ctx->walk_control_lock);
 	damos_walk_cancel(ctx);
 
-	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
-- 
2.47.3
