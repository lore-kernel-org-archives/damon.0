Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D33D3CF8;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810963; cv=none; b=m5BOHlD8PtoG4t8J9SgapuJDZvdFkCgnqVLf9CiKoUrGqJyNm4dYzWHdAdZ+r5arJk+7fhW4o6tao5+e5B7qbmJQof/wTqGuOR+Fp59U42u2ajrKVzBf4I+qgLxLi/Ao5teUEFgnsgKnHKxpsjxLkk0fpv8AYJP2bSVbuxgP8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810963; c=relaxed/simple;
	bh=7QL/RYpMYPTB1eC/p0ZRS1BwtD3YKWYXznWIGxGADnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkpxuPY1bsELlID3snZykyMenIEhcPsDLeyxsAiCDi1x0Xqnf+eUGCKlz9tZVIKWjx5Dj4aaY+nCVl7AQNm2Oeb5aXqO6Cysz9JO1zBKv5xzW3NKBjnN8gv4gyeuoC9pueltu2yC3uaArWtirXgcoLJjVTn6LlBZT+3FxMW6UMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1fm2DUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1fm2DUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5E2C2BC86;
	Fri,  6 Mar 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772810963;
	bh=7QL/RYpMYPTB1eC/p0ZRS1BwtD3YKWYXznWIGxGADnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1fm2DUImHlRnIE6oAsvDturwnznPySYDUcJwjnRiMZUOBbLVdOKtU0o9SxybtH3N
	 kZvG5pVzm2eyVDZbvN9VlGRBCeh2sqgNZmagwb4439kVElZSxXquDR6a3bhNdo0zJm
	 jCJsENfOOO98J9RHHxi9sy005TXMAtrYcS0ZsjRKAcvcBNWS63zpxEGU6otnmqPVLK
	 9Qg49J5iBrziw1YPJGTR1YyxFckMgFkEEZzY3ygQlWk2JaCUVpTJt/8DxJrG91jkbw
	 /ob8qXkoKrmLTnEuhpigEung45LpNG6GhWhxu4TvBoRrcTQBUIaaFNHrNiwewgfTOg
	 hrHbX2AQctG7A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] mm/damon/core: add damon_reset_aggregated() debug_sanity check
Date: Fri,  6 Mar 2026 07:29:11 -0800
Message-ID: <20260306152914.86303-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306152914.86303-1-sj@kernel.org>
References: <20260306152914.86303-1-sj@kernel.org>
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
