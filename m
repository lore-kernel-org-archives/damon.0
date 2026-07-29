Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAD2E7369;
	Wed, 29 Jul 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296281; cv=none; b=tlziII4uoRAQ16ANWj+PK5gox1OwYbbwUX9jue4sBaox6LEjukGUTMbpPTKrJiMNeb3aDIJb+oNI7dFJzsYQGXO5qIVPj/PhRIdJ7S5k1DSPUW1QfZi3XEq7dK3J630fBfZDhVIff8omaRvz7wx/R6ODZsaBKzRby50ME6Ryozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296281; c=relaxed/simple;
	bh=ALqtcJr6Cxz4pXUoeb9ElWqQ0e7dp3Dj7LcL7FNfIg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz8XwDMDO7BjqjlBjpKbCWiqdosvttsE3fxfRw2D9RLCpo3wEw9to2WuEt/ov2IgucV9Pa77VCN1mEof7LSKoSF0XEF3vP/zeKMoLSu4H4bc0Dgxl+sMrrBSHY+DAEr348N63jK7Ct4XlquTaijtUQoMgJ2+mnw+1nU6hhl2h7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAZzZK77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAZzZK77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BA51F00A3A;
	Wed, 29 Jul 2026 03:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296280;
	bh=rsKOoYzf/dRz4aZ57YQorCEYYMXi515YQmVG5cvaY7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAZzZK77x+nswa64wnXDcpK+n2mCKX1j8XHH9KUc90NQAIuMpbCdKLNaxyPg5rIBF
	 P+uWdSbPwIzkChgEuNESgryIpJwv23n7Vd2nscDtfgSiW5etj3MKKIXkZOhPZmGK13
	 cXzAqIJ7tT/8VdS2s7OGxrPQrmto9J+ke5eTMocRl0THfcqiopaZoNOV51vCF3YOKQ
	 DFzZ//axiUpwqDTQPHMe1Yt6VI9WTp7rlq+Omfrw9FT7LaUZN0RjOFvT8uYnGqIPTk
	 Afen4/9GEtDivIEs8xfzzmJaFvovph+XhwF91qUfODKskHJOEAIbS+pSy+zLu9buLe
	 DqF7jn08Zkrrw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 02/10] mm/damon/core: remove debug messages
Date: Tue, 28 Jul 2026 20:37:42 -0700
Message-ID: <20260729033751.131213-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
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
