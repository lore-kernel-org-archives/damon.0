Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF24322B88;
	Sat, 21 Feb 2026 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771702597; cv=none; b=QMe2BR1BUJjN9HEHv0RKEAwEwlGyY1SXITCogvq+OmEfR8KaI/1jokk6g7PVq1QmyQ9yEA64UW4F59EEiaJE3g7mSbvv103YESR2lcW/B+BEg/b16fB9s/jnnyDghOlJc6hteB1ZXyM0sA5/wuu02IcaB108zJSfes8aGKVkfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771702597; c=relaxed/simple;
	bh=h+yGkK1mUlydQHBhuSmFBiMNXZJ33nd1yZsz+jGXjHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfIHSsiCcK4o39qbikB1p83LcC6/Cgywj+ungocx/KidaCn2rphDXZYUMXdxERnKES0v/hnN8vJ/QHqMDHrcM99xnUmL3fRRzgB7Yf0KgsQJWE6ojo9MD9Aa5CuJVxR+WtbE1SWA4G6dkRBJKSJXMZAFZk0habeEhdvUGXWFjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYxEcmN7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYxEcmN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F74C19422;
	Sat, 21 Feb 2026 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771702597;
	bh=h+yGkK1mUlydQHBhuSmFBiMNXZJ33nd1yZsz+jGXjHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jYxEcmN7X9Ujj0uCpoyQ+P9KlPERhlBrT8vThzywUA+fvZazJSadEOpAf+Mx1YQqk
	 tLTyJvlbFeH6MMW3i6Y+hS2b7mR4ctodUZgKEz+VrHJREQbtwwfFoQ5lemocCmkabK
	 i/B7G38wQxpfe0fN/bBpxj8azjo6TSTWMlJ8LeOr6Y16LeyDpsNIrMRhKy1lawea+m
	 CbuLuK8r2KU1aKXx0uXERmHwbP1vyiDSe9UytRMgVTvumT8y6kr0gQJhzEx6tt9VAX
	 ELTT48NWJSiY2BqbxQQiNb/xXmfAIwiqn2GXS2fIUYxOAI9miNARy/yu3Owi8LHxOw
	 7doRlHA82ZnMg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/10] mm/damon/core: add damon_reset_aggregated() debug_sanity check
Date: Sat, 21 Feb 2026 11:36:25 -0800
Message-ID: <20260221193629.19332-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221193629.19332-1-sj@kernel.org>
References: <20260221193629.19332-1-sj@kernel.org>
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
 mm/damon/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 16f7994903d6d..4efe732e76c69 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1681,6 +1681,28 @@ static void damon_warn_fix_nr_accesses_corruption(struct damon_region *r)
 	r->nr_accesses_bp = r->nr_accesses * 10000;
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_reset_aggregated(struct damon_region *r,
+		struct damon_ctx *c)
+{
+	if (r->nr_accesses_bp == r->last_nr_accesses * 10000)
+		return;
+	pr_err("reset time invalid region found!\n");
+	pr_err("nr_accesses_bp %u last_nr_acceses %u\n",
+			r->nr_accesses_bp, r->last_nr_accesses);
+	pr_err("passed_sis %lu next_aggregation_sis %lu\n",
+			c->passed_sample_intervals,
+			c->next_aggregation_sis);
+	WARN_ONCE();
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
@@ -1697,6 +1719,7 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
 	}
-- 
2.47.3
