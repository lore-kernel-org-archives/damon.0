Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A1426D18;
	Thu,  9 Jul 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605970; cv=none; b=j3JxH7Da73wx/rDX2OQ1ZuD7stY2T2Ffi1GONzSop7njmRB0VZDOC4bDEEBrZQ3Uu5/mZqlDVaoTEA68F7ASHtJy6TFz/QDVXWvWh2ZYynLvmkth5U6NrTSCd/L9OBhbLFV4PhbIKEWu0//xjkHlYkd8Q7mgGFST0J4nPgl0jP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605970; c=relaxed/simple;
	bh=vUr+kQ6tcR68TsGCp6jwWO3LIKRQlssvqoPgwYI7YEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMyrbS/2VLlgX3aXoIdF/Us/T1CFJz696yAjXnXEdv/1qBzyP6fAyOctmknWRkcP9gNj/yXlCIjUmO7FVK9UtVo4eU7dmk/vtpGJowIQI2d+MQBgfnr36rSCWREPRItjw82RHJH74dfFyWfXnkLfqScX+kWYH2OztNEuyAT30oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmWqvOkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmWqvOkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31811F00A3A;
	Thu,  9 Jul 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783605968;
	bh=B8V92yvjw2SyU/dNzdlsr6pPt37KiwtlzMcTn7UeWbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kmWqvOkQqQNagbDCpLqVlB9rcK8Itp2cQY4lZmBJI3jF7JRicCqH22EVRhFW+OrnP
	 d1dVgQpmI7ar1jaxmU8ra4j3tDTVp+OjKIN6h4Wpw0/N5pFeifZbJEZdAwy9l15eEY
	 9ZE4ji1qrqCgQ1KYechJtCLBcSV4S492xjTQOIfJByZambMXlmtf57nFY5GUpf/WUy
	 IrS3xjWcjCe9pLCsVVpE5BuxCl4pWTtPKRkLR7+3Geq47dq1vZwyOqKuba4g5KFMyB
	 ZaI4vfXO9tmbJHQ3cNn8KYZUzf+TMg7U0TqXvzU0JBPhREdcS8XZ7WZA9vhTj/O2dw
	 9axFUaP96GLQA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 13/19] mm/damon/core: s/max_nr_accesses/max_merge_score/ in kdamond_fn()
Date: Thu,  9 Jul 2026 07:05:51 -0700
Message-ID: <20260709140600.90950-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709140600.90950-1-sj@kernel.org>
References: <20260709140600.90950-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probe weights are set, DAMON merge logic works with the probe hits
weighted sum.  The core logic is setting the merge threshold based on
the access frequency, though.  Before using probe hits based threshold,
rename the variables to look more general.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f1be748e9a674..8837b2129baa6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3730,7 +3730,6 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 static int kdamond_fn(void *data)
 {
 	struct damon_ctx *ctx = data;
-	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
@@ -3764,6 +3763,7 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
+		unsigned int max_merge_score = 0;
 
 		if (kdamond_wait_activation(ctx))
 			break;
@@ -3775,7 +3775,7 @@ static int kdamond_fn(void *data)
 		ctx->passed_sample_intervals++;
 
 		if (!access_check_disabled && ctx->ops.check_accesses)
-			max_nr_accesses = ctx->ops.check_accesses(ctx);
+			max_merge_score = ctx->ops.check_accesses(ctx);
 		if (ctx->ops.apply_probes)
 			ctx->ops.apply_probes(ctx, access_check_disabled,
 					false);
@@ -3783,7 +3783,7 @@ static int kdamond_fn(void *data)
 		if (time_after_eq(ctx->passed_sample_intervals,
 					next_aggregation_sis)) {
 			kdamond_merge_regions(ctx,
-					max_nr_accesses / 10,
+					max_merge_score / 10,
 					sz_limit);
 			/* online updates might be made */
 			sz_limit = damon_apply_min_nr_regions(ctx);
-- 
2.47.3
