Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18933A701;
	Sun,  1 Mar 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387013; cv=none; b=sadSp2X0yjF72NJZEkUUJH9niiBuBCgYsLjP0ycvBSVFA+seuvPck1E5umslmkBLdPGl62ir8zHZGqPiWW3wMyKhiESYv2agTXhsg6D2X0O3Yv4Vnd/SLEqfKYolmCkfaZ3qoaXNtGsv3dXhX245FbLhtRAEOvXV34wlT4un3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387013; c=relaxed/simple;
	bh=7QL/RYpMYPTB1eC/p0ZRS1BwtD3YKWYXznWIGxGADnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOWOdtZQT4JwuwnPwSCnIIdQNGcuQ42Ij4UXVYzuaemLIw8oYUvLe8rwane/c3i9ugGr56zTc19Xs8les7CCORGCPnyCxcO9byC6P9xFwii4D5Y85aWmDok+2xO24IuX5rOnuQHKEBJSsv1mbfOXNIsdR/mBLZg73w8/oLq3x94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7kM60CE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7kM60CE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0281DC2BC86;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387013;
	bh=7QL/RYpMYPTB1eC/p0ZRS1BwtD3YKWYXznWIGxGADnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7kM60CEmDaEzNJTLTipUMV58oimjOz6LLzz56XC7mxaW9NAFTZrX1ECyv31z3LXx
	 47QuYTMJoYczO1ndrolzeKIUlFl5c7SpKgDLHOpUdGVDfNudPok6f6Pll/t/j5V5Vl
	 Vhj50I5tC1d4Ph1ByHi5QzSbBI4I67LFXQ5/yTCee35voA5bJIynLeJ091CjVU8DZ4
	 +pQEWpJ4115VEYgzKJiSf9O1oFwdMSyIXtoPLpYWIiYawScj8l0SOJaZbvVmxJWQKL
	 4rMRRDxAzOtSWOmJDHNvSdLVkMtMRRdPoQhh/PMuJzNED+Q9286s2vTCNVnWvOAfrO
	 NGGRBLLU8Ju/w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 08/10] mm/damon/core: add damon_reset_aggregated() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:23 -0800
Message-ID: <20260301174327.76849-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At time of damon_reset_aggregated(), aggregation of the interval should
be completed, and hence nr_accesses and nr_accesses_bp should match.  I
found a few bugs caused it to be broken in the past, from online
parameters update and complicated nr_accesses handling changes.  Add a
sanity check for that under CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index be2300cf3aeae..e8c44541754f7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1666,6 +1666,23 @@ static void damon_warn_fix_nr_accesses_corruption(struct damon_region *r)
 	r->nr_accesses_bp = r->nr_accesses * 10000;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_reset_aggregated(struct damon_region *r,
+		struct damon_ctx *c)
+{
+	WARN_ONCE(r->nr_accesses_bp != r->last_nr_accesses * 10000,
+			"nr_accesses_bp %u last_nr_accesses %u sis %lu %lu\n",
+			r->nr_accesses_bp, r->last_nr_accesses,
+			c->passed_sample_intervals, c->next_aggregation_sis);
+}
+#else
+static void damon_verify_reset_aggregated(struct damon_region *r,
+		struct damon_ctx *c)
+{
+}
+#endif
+
+
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1682,6 +1699,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
