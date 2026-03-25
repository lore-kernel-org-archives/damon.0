Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC5371878
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424292; cv=pass; b=f7g/6fZXS0UgxdJ4KvgC5nIHQ/ekQcNmLajEUuKOG/Q1J51kY1fwOKc7qItWae0puH9ydZjC9I2RrFg0N98t+mbqYjv5wbYjaXWqjz5SG1pZ+hmyFl42LFLohKtenWPp9YUkEc3UoQ8JhoFsFxVJoxEGGDZg+t1eRbfD8kpM0Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424292; c=relaxed/simple;
	bh=NCpDFdVe9iHnwJZlnOzuHDWnpqfCBtDcOeacFMCNRYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIrLcoz9mFJPVWBS4nF9advmihkVLc2Za4UgAOMfRZyyI/aPG5WCp68xWbRatuOMefbUVut0zQgGiL9VpkOnrWIPtC8NJZJ0Bux0hZBIINNetyim20X0VJyjEcDCaesFk1G+hnqr9UyORRVlgxth7QRfWuGDGKARalNOF1MdCl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fvjLZYLl; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fvjLZYLl"
ARC-Seal: i=1; a=rsa-sha256; t=1774424285; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YUzINS5O5bYJ12stM1hz4afv2mWnJwNouWzE9tsnTZwfsF/eo4twLFV1MLog0ODzKPR+tkmtHU8Eqdhjv9NLRcSkQL22vn66WmaAZsyVvHGANpVynkp+a9M6LyONtyW4WtKdjF7II08qVdSkqU7RBsSxVyZRl/nZG9oO4JPy6qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774424285; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UiDWbq+Vesxlf62C23Hm8indkustIaG2EimGmGm7dUo=; 
	b=NUMZ631GPwwuMUAfMzWO4/FTB8pp6rxMkVrU/dwxVIs6/RB9ipKwBYIa7GX9DREJbgtvN/2YL9P3GJ3Shgwd8ffiswCDVwJSCWmMTtni3WCgMpL/XkCQQ+grEB398DHEGvVfw+V+RVhDuvHGeAAC+WryF5wsMsqckVsowZSHmqw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774424285;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=UiDWbq+Vesxlf62C23Hm8indkustIaG2EimGmGm7dUo=;
	b=fvjLZYLlsfhzXVv87/zGnHVe1ANmLrP76ixhW6UGJ7FKpYKZyqll5IHXQKv8WypX
	U7liFT/wyr8BdcF0vqJU3AjvthuXoTCW0v0JhJ3cuR1T7i7C8VJiJb0RMmTCBQTAlsi
	ppRTPmPX6USpkm4QEjn3aAYUbGZLrM8N/UxTcA8A=
Received: by mx.zoho.eu with SMTPS id 1774424282494241.87438479042987;
	Wed, 25 Mar 2026 08:38:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 1/3] mm/damon/core: deduplicate scheme index lookup into helper
Date: Wed, 25 Mar 2026 07:37:58 +0000
Message-Id: <20260325073800.141756-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325073800.141756-1-objecting@objecting.org>
References: <20260325073800.141756-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Three functions (damos_apply_scheme, damos_trace_esz, damos_trace_stat)
contain identical loops walking the schemes list to find a scheme's
index for tracing.  Extract the common pattern into damon_scheme_idx().

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/core.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6ee421141996..56372e577931 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2045,6 +2045,19 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->walk_control_lock);
 }
 
+static unsigned int damon_scheme_idx(struct damon_ctx *c, struct damos *s)
+{
+	unsigned int idx = 0;
+	struct damos *siter;
+
+	damon_for_each_scheme(siter, c) {
+		if (siter == s)
+			break;
+		idx++;
+	}
+	return idx;
+}
+
 static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		struct damon_region *r, struct damos *s)
 {
@@ -2060,7 +2073,6 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	 * index here.
 	 */
 	unsigned int cidx = 0;
-	struct damos *siter;		/* schemes iterator */
 	unsigned int sidx = 0;
 	struct damon_target *titer;	/* targets iterator */
 	unsigned int tidx = 0;
@@ -2068,11 +2080,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 
 	/* get indices for trace_damos_before_apply() */
 	if (trace_damos_before_apply_enabled()) {
-		damon_for_each_scheme(siter, c) {
-			if (siter == s)
-				break;
-			sidx++;
-		}
+		sidx = damon_scheme_idx(c, s);
 		damon_for_each_target(titer, c) {
 			if (titer == t)
 				break;
@@ -2394,15 +2402,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 static void damos_trace_esz(struct damon_ctx *c, struct damos *s,
 		struct damos_quota *quota)
 {
-	unsigned int cidx = 0, sidx = 0;
-	struct damos *siter;
-
-	damon_for_each_scheme(siter, c) {
-		if (siter == s)
-			break;
-		sidx++;
-	}
-	trace_damos_esz(cidx, sidx, quota->esz);
+	trace_damos_esz(0, damon_scheme_idx(c, s), quota->esz);
 }
 
 static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
@@ -2469,18 +2469,11 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 
 static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 {
-	unsigned int cidx = 0, sidx = 0;
-	struct damos *siter;
-
 	if (!trace_damos_stat_after_apply_interval_enabled())
 		return;
 
-	damon_for_each_scheme(siter, c) {
-		if (siter == s)
-			break;
-		sidx++;
-	}
-	trace_damos_stat_after_apply_interval(cidx, sidx, &s->stat);
+	trace_damos_stat_after_apply_interval(0, damon_scheme_idx(c, s),
+					      &s->stat);
 }
 
 static void kdamond_apply_schemes(struct damon_ctx *c)
-- 
2.34.1

