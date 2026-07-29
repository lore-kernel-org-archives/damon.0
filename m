Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11496495525;
	Wed, 29 Jul 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333785; cv=none; b=PbstAMjScwJDfbtNfQMPMp0c44KO4tFDny11PqS5usLUmMQKYyYmcMapSWUDvtBWCeYwNIgpROfVsrFPZgb2/6Auf+zZsquRfR/CiV1+UkLV477IzsQKJhqd7PQHlVFOsxiAwAQzyAEhV9Ma9ahpWkDpagTm6KCvcaUiM0qkqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333785; c=relaxed/simple;
	bh=ALqtcJr6Cxz4pXUoeb9ElWqQ0e7dp3Dj7LcL7FNfIg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdJQMfYR1diCxy86Bo91acD7NgEB3rHo8KdvgCQAY9JF1rH0cDArCAmLzmC18ixQKfKtwCqx2rjKZbfm0HCjzhGObL8HPUW9ZiNiuDjI4C/+Vmju/bDdaLg1iMFmc5WnxbYjE+IbkhTnJl/1UxChHE6nyACWHGt5x55GvIQLhYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqCPUgWZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqCPUgWZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63DB1F00A3D;
	Wed, 29 Jul 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333783;
	bh=rsKOoYzf/dRz4aZ57YQorCEYYMXi515YQmVG5cvaY7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YqCPUgWZocGbcqlu//Eplon8O/n2ikX4zR58EXJgrot0DTLzs7hq7kWXfM/bvYSJm
	 SmAK2MPrgAP3HiIKlhCjIubS668OmphMod+BvoQl514xZ9Xpr117ULzJz6DxU/9EB9
	 lp5YwoN0zjW+UzxSPeb8ht2GJN3iucQoi5InyzrHyJF9aKPeLDf+64vRDR2yKMk/Jz
	 z8g4mH1Sx9XiBoeIIzHh/YoIqcV29f/2dYU/ijcXxLwu77MnTr6l6DHFJktSezoaWF
	 BPN1LtrZR9PGjbhAAA1q9G8GVqRbEibCutBp+/GNpiEyofcKyRp0bwwm9JQ95CJXRP
	 t5Y3hg2XMhiag==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 02/12] mm/damon/core: remove debug messages
Date: Wed, 29 Jul 2026 07:02:42 -0700
Message-ID: <20260729140253.87753-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729140253.87753-1-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
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
index 4169268d94416..1b0f12d17de3a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3693,10 +3693,6 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 
 	/* higher than high watermark or lower than low watermark */
 	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
-		if (scheme->wmarks.activated)
-			pr_debug("deactivate a scheme (%d) for %s wmark\n",
-				 scheme->action,
-				 str_high_low(metric > scheme->wmarks.high));
 		scheme->wmarks.activated = false;
 		return scheme->wmarks.interval;
 	}
@@ -3706,8 +3702,6 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
 			!scheme->wmarks.activated)
 		return scheme->wmarks.interval;
 
-	if (!scheme->wmarks.activated)
-		pr_debug("activate a scheme (%d)\n", scheme->action);
 	scheme->wmarks.activated = true;
 	return 0;
 }
@@ -3850,8 +3844,6 @@ static int kdamond_fn(void *data)
 	struct damon_ctx *ctx = data;
 	unsigned long sz_limit = 0;
 
-	pr_debug("kdamond (%d) starts\n", current->pid);
-
 	mutex_lock(&ctx->call_controls_lock);
 	ctx->call_controls_obsolete = false;
 	mutex_unlock(&ctx->call_controls_lock);
@@ -4005,7 +3997,6 @@ static int kdamond_fn(void *data)
 	mutex_unlock(&ctx->walk_control_lock);
 	damos_walk_cancel(ctx);
 
-	pr_debug("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
-- 
2.47.3
