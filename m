Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDF380FF9;
	Fri, 19 Jun 2026 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897682; cv=none; b=EPBlSObvSM7RgKyaVjFXHv81SItg8nJzWbgED9eVvrFnW6AUaeBRmsfnPBYqA5SXAY92fUNMFQjVuZNxghxal2WfOSR9cdOhS6wS/L/mu6BghKGSXaHMJYtbWPNPkjvLNIcUR3U6rhFqo/tpdTg6SXX1s4VRwF4Z3gTeEmndg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897682; c=relaxed/simple;
	bh=YhLvOOkfxeXbbGISinqWYnzgTB2q/xZN8wRMCkKTbGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFaS9Ck3FnGLSmTF69wXd12qkYwxk3oM8Gr/ETRiCRIuyMNfZ08o4Jo2oXzFEVt4+0r9jdAgubloMnD+wZHdwfpFSMFd21veWwk3bWCxB9K2YyQgxWJAj3x2au2+MqYG1dDI1dsbFOlRGhvRrwFGWLb9OBvBzCYObS9VNm5LUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKY+azgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKY+azgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759F41F00A3F;
	Fri, 19 Jun 2026 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897677;
	bh=zrHWh3GiVfO/8U75+2UxprSqwOj2/SBF1FltGYOX4u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKY+azgH7CU74H5abuvE3sjjSthi2JPWe+ndYBhg2Q5Jw/8lzP/m7FtBppiEznQpY
	 i0qF19kA5G/LtgAO5iHYwMt4h7Tw+JoF3kNRkM1FCu7c3CWJqvTMRDBQ9HQrTK8OSp
	 H/7kzNURe51Mc95fmqz9024fz5E/79rGtrJPjPorEydMti8KnVDK0HF9+NoWFiAZ85
	 K3y7zXN53/6eltCI7SczLQ+mJxMpBHv2NwYXkhcVPJypbU62qNv4EupU7yBB6VWmv8
	 slBt+Nw3P2PdXeIU6yR53NcpSbzK8/TaGWkEUbeqVHJ5nw57VptPAgQ6oGdZ4liSh/
	 qvLGtYcn+1sUw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/13] mm/damon/core: remove damon_verify_reset_aggregated()
Date: Fri, 19 Jun 2026 12:33:52 -0700
Message-ID: <20260619193415.73833-8-sj@kernel.org>
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

nr_accesse_bp is no longer being used in real use cases.  Remove its
validation function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 12d09d2f7ea1e..9b8423056d879 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1992,23 +1992,6 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control)
 	return 0;
 }
 
-#ifdef CONFIG_DAMON_DEBUG_SANITY
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-	WARN_ONCE(r->nr_accesses_bp != r->last_nr_accesses * 10000,
-			"nr_accesses_bp %u last_nr_accesses %u sis %lu %lu\n",
-			r->nr_accesses_bp, r->last_nr_accesses,
-			c->passed_sample_intervals, c->next_aggregation_sis);
-}
-#else
-static void damon_verify_reset_aggregated(struct damon_region *r,
-		struct damon_ctx *c)
-{
-}
-#endif
-
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -2037,7 +2020,6 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			r->nr_accesses = 0;
 			for (i = 0; i < DAMON_MAX_PROBES; i++)
 				r->probe_hits[i] = 0;
-			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
