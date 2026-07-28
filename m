Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC033B38A2;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216497; cv=none; b=WJNbRbvmZIznUybfm+NRrFlfF9qo38+FD9GND6LWxqIE7hxmlLS3d0SYoPP9vprCqOLDAWGkd53BVH1AX3akJRHrzYbFtFAxaU927UPvg9HlsuaLAkyjRlvj9T+tOlTMCVLhXL1j9uqwH/PHMT6Qb12ps1ppS9YF7MfQMDmrS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216497; c=relaxed/simple;
	bh=ALqtcJr6Cxz4pXUoeb9ElWqQ0e7dp3Dj7LcL7FNfIg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNmOhmSOa5030gLmSE3DZUoFEERkgUqYV9ldmsOlbAongLf5Fis3O9Gv2VhkspHrZMFwtQyktvPbxAzdIgHcArSY4lEZ2Nj/tT1cWFDYezUZG+h18Se7zN/qYMCfo+lKmXx0l1UF9v2ECo+vZ5cpUOkmFovpyvvNMuYTiLvite4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drfJ2nh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drfJ2nh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6F1F00A3F;
	Tue, 28 Jul 2026 05:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216496;
	bh=rsKOoYzf/dRz4aZ57YQorCEYYMXi515YQmVG5cvaY7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drfJ2nh6PTAFZ7CdJ/do6A7rzEFEqyv4+aSYwk29P7sOohY0EPTokRJE9PJDWyDcU
	 sUcLYIXcfPvc2rq8BIHlg47myx4J+Bsll/NFBMvhKRmdp18Dd+P73pkIi2DIKJfSbd
	 g5sSfJ1rkyHFW+AJEnDgUaT348onUpaDl5eknL50ZJS/gslBjt78RlKufUIqY8Imcd
	 V28czKZGCG7780LCT8B9GQK1qJcROVX9SKfRzBOMfL5lrx1onkiNYq4lrcI+FZfFD9
	 c+ygtxJqvQXU3L+N85zbqjrYS9g61J+XawaM+Owf+muCGVlUjGscq8WubEJyyBfH8c
	 c407avxFTWyMw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/10] mm/damon/core: remove debug messages
Date: Mon, 27 Jul 2026 22:28:01 -0700
Message-ID: <20260728052811.192712-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
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
