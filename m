Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3433985A;
	Mon, 18 May 2026 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147686; cv=none; b=Un7c3lzFFaeO/6P9xJ5OCNR1lQ2f+SwDMr69AJghj6/1xbRnTSYdHnr10k0177DgoF3Dylaa0N4AXo+H+bWAKI6j/BnZMK96d06WyivCDIwQSALVO59LRMdqfKfVwtS9HyjDvnzL/6R3G2P5V8rcZ5XIjRQ2ZcORsVQqPbjBrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147686; c=relaxed/simple;
	bh=EOdiDLw/Fh1yhoztKW51lYed+pEAR0BsIW9TAh1kfRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIIghuatINVcXedfBI51c0bN14FrI+yQlPETlUA5jpEN4Q+53o8Oz3azbqVRwZRFplLjN5NokCW+Sb5rCu+2SPr6+A34ZjD+SfT6aCQncr+Qn7a0Qq0VUT5j3NnZabEZ3snsFvRvqX2QS6LXc5C6SYb8nLBoPnS27CC3DgomrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNtF7sqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNtF7sqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22534C4AF0B;
	Mon, 18 May 2026 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147686;
	bh=EOdiDLw/Fh1yhoztKW51lYed+pEAR0BsIW9TAh1kfRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNtF7sqbaWtRINKs/9wm8INSXN1Jw85y9a3gFeOXhJASFk2FC7+1/9zS4gFnJMnep
	 Ijk9mRO0bujO7/WL+8XgRvnYe51tmd1qXYPDbsLqDaPCNJmPYmDtal4i1eOJUMYsmx
	 hwktFvtinqKzdvsIAEojku/MdJhEKyOW5KLISSL8atvr35FyfBV4sp2F9QN0jxX4Th
	 +VdbY8tsBKNCztZQnlFyDHma2nh9BVFShz29Ie48U83xGR3Sb78vRx7aGUG6Fbq5aN
	 Y6KY5Dz1eVXmcfPPNxLikOmw56a3F5ZPVNHXI2JPS5co1BH/qO/Oro2J5K5nyVnJSx
	 eF9sOSCkwLkPQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/28] mm/damon/core: do data attributes monitoring
Date: Mon, 18 May 2026 16:40:55 -0700
Message-ID: <20260518234119.97569-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518234119.97569-1-sj@kernel.org>
References: <20260518234119.97569-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the data attributes monitoring execution.  Update kdamond to
invoke the probes application callback, and reset the aggregated number
of per-region per-probe positive samples for every aggregation interval.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6dd1bce81ec2a..433da8781e255 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1913,10 +1913,14 @@ static void kdamond_reset_aggregated(struct damon_ctx *c)
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
+			int i;
+
 			trace_damon_aggregated(ti, r, damon_nr_regions(t));
 			damon_warn_fix_nr_accesses_corruption(r);
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
+			for (i = 0; i < DAMON_MAX_PROBES; i++)
+				r->probe_hits[i] = 0;
 			damon_verify_reset_aggregated(r, c);
 		}
 		ti++;
@@ -3410,6 +3414,8 @@ static int kdamond_fn(void *data)
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
+		if (ctx->ops.apply_probes)
+			ctx->ops.apply_probes(ctx);
 
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
-- 
2.47.3
