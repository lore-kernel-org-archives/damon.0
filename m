Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0E160860;
	Tue, 18 Jun 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734703; cv=none; b=TAQk4hdo70GAhmdtL/cXZ+ltpaaq3ddkW5hT0/S3b5rqj02hutQliISn19cxaTGzmZTETCLudLy87PGDOpg/UcnoSvO6a6/DBmWSSlgqrYQg9PfPUL0P536eaSPaqZ6PALipxvPCVCsg0ovRhVQ2HxBCNcgbj9/Qg0IG/mw2y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734703; c=relaxed/simple;
	bh=63ugfgzmyX4NmFqGz3i2C7qMQZ/sIyT4hK0C23YIhHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUK51nNeGOqvAryRR+LDKKCnlJMMkjQPLVgfdMut4u8uiwSMZdqaqwmBeb0AengTILG/kZb2pQOgDQGmDNEzYt3GXrhidC22r5X7DiOxe/C10O/65AQBWiSIXpjUnx4bBIQdigmAh7FCQtAGKLS9XkX3/6vS+QvsMHwK/RoxENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLvial6x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLvial6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D6DC4AF49;
	Tue, 18 Jun 2024 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734702;
	bh=63ugfgzmyX4NmFqGz3i2C7qMQZ/sIyT4hK0C23YIhHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLvial6xmmuQ0yPDZAWQraZaKb6LAp115Mm79wORwQmYVnNAOzFEko+KxgpbPJLkz
	 MRYok8GqL9vvB+Xng+vOPk6x2Ke23b0oGTXyeQGQo8z1inXgPxk4fopGgnRjedXhZy
	 Eqrd1/iiBBe8JnYfDTnDFaiiUHu98i6oWKGJpphMMCb2CQJbEYesD+bDmm5pfzkviY
	 1KZ8YT+nbf6AUahFRFTMWuenMt9RgUl8U+0ZAhSKipyrrpCZoOyO8V25BsNViSxrCe
	 XKrsvzOBk9oEyDrM0MCHujO98I7Z0YxrtalloMZJBeENxgdIECdr4zIzpyBHS4z3gP
	 fY0Sy3b+SnQUQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] mm/damon/reclaim: use damon_commit_ctx()
Date: Tue, 18 Jun 2024 11:18:06 -0700
Message-Id: <20240618181809.82078-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM manually manipulates the DAMON context struct for online
parameters update.  Since the struct contains not only input parameters
but also internal status and operation results, it is not that simple.
Indeed, we found and fixed a few bugs in the code.  Now DAMON core layer
provides a function for the usage, namely damon_commit_ctx().  Replace
the manual manipulation logic with the function.  The core layer
function could have its own bugs, but this change removes a source of
bugs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a05ccb41749b..be7f04b00d0c 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -195,59 +195,64 @@ static void damon_reclaim_copy_quota_status(struct damos_quota *dst,
 
 static int damon_reclaim_apply_parameters(void)
 {
+	struct damon_ctx *param_ctx;
+	struct damon_target *param_target;
 	struct damos *scheme, *old_scheme;
 	struct damos_quota_goal *goal;
 	struct damos_filter *filter;
-	int err = 0;
+	int err;
 
-	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
+	err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
 	if (err)
 		return err;
 
-	/* Will be freed by next 'damon_set_schemes()' below */
+	err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
+	if (err)
+		goto out;
+
+	err = -ENOMEM;
 	scheme = damon_reclaim_new_scheme();
 	if (!scheme)
-		return -ENOMEM;
+		goto out;
 	if (!list_empty(&ctx->schemes)) {
 		damon_for_each_scheme(old_scheme, ctx)
 			damon_reclaim_copy_quota_status(&scheme->quota,
 					&old_scheme->quota);
 	}
+	damon_set_schemes(ctx, &scheme, 1);
 
 	if (quota_mem_pressure_us) {
 		goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
 				quota_mem_pressure_us);
-		if (!goal) {
-			damon_destroy_scheme(scheme);
-			return -ENOMEM;
-		}
+		if (!goal)
+			goto out;
 		damos_add_quota_goal(&scheme->quota, goal);
 	}
 
 	if (quota_autotune_feedback) {
 		goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
-		if (!goal) {
-			damon_destroy_scheme(scheme);
-			return -ENOMEM;
-		}
+		if (!goal)
+			goto out;
 		goal->current_value = quota_autotune_feedback;
 		damos_add_quota_goal(&scheme->quota, goal);
 	}
 
 	if (skip_anon) {
 		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
-		if (!filter) {
-			/* Will be freed by next 'damon_set_schemes()' below */
-			damon_destroy_scheme(scheme);
-			return -ENOMEM;
-		}
+		if (!filter)
+			goto out;
 		damos_add_filter(scheme, filter);
 	}
-	damon_set_schemes(ctx, &scheme, 1);
 
-	return damon_set_region_biggest_system_ram_default(target,
+	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end);
+	if (err)
+		goto out;
+	err = damon_commit_ctx(ctx, param_ctx);
+out:
+	damon_destroy_ctx(param_ctx);
+	return err;
 }
 
 static int damon_reclaim_turn(bool on)
-- 
2.39.2

