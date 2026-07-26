Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49B3D6CD8;
	Sun, 26 Jul 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087588; cv=none; b=W8Y0XavCQuCEdTTi7D9c23GByDXFWKYy+JAWRwT/vRkC1/uDeo3TEmyvVQdp9GrBLlSiCQqSzk0LWS/wWWH/VyX8P+RB1X4o3gJBYNSi4X3Mk9VBOz1DEnHEvt312XDF7wm6yTjPihdL4p2OXTp+BjSGywuHl4tZpu/1lyigQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087588; c=relaxed/simple;
	bh=dnQrMCeGscnx8qS0aoL3UJNj+b5DIOgUbyGs9Zfdhu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF6nz3NQMYhjw3F/TjWdoZJmD6PhTUFRQnclT2kbU3eRkxO0qevUK4DBfo3nOMHmhTzQBQ7xTS1wWRbZTr214L5U08sWA91rAI5roj2dlCmIhs1fhfsoDUc84Y7N5vxQOtYoGPyNh00ibU+xrNm3caMv3++8/XAWGFacM0OcbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwueIUNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwueIUNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B4E1F00AC4;
	Sun, 26 Jul 2026 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087586;
	bh=orUmWJfivc5NuWXSfNpxR3gihoLgZa1C4mXxNXYJ/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UwueIUNxxuaobnaz9kqKPah/yMCNFJ2l08rRXpIDqPgTNeGZLwz3PRMFOrgKKh+ex
	 2Htz3KHUAvO5pbRdXM7Zcu93N3DInSFctBumVnS3bHXBVZ6hfYT2ijRFP4ym7+gb4S
	 iLyWuRExpRUEgafPxpSuGS7y1jV4eospBiai4Y56XVBVKArcnZkqRZd1E1/kyfu3LF
	 uFIywRRlV1+7Xfd6BGBpf6BAs426KB0WQa0vqqyyYd6fZMWX0SZnlISfg3zAnFDIiP
	 lFWCmDr3SUNaUDFNA2vf4m14yEaDseilHneVwPs9q7D2/MOwvkSi8uZF+bNQnF52Pe
	 V+iJU/l7Ssqow==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 07/17] mm/damon/core: introduce damon_operations->prep_probes()
Date: Sun, 26 Jul 2026 10:39:23 -0700
Message-ID: <20260726173935.94046-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_prep needs to be executed by the underlying DAMON operation set.
Extend the operation set callback list for the execution of damon_prep
actions.  If the underlying operation set implements the callback, DAMON
core executes it in the monitoring preparation time.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  4 ++++
 mm/damon/core.c       | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 255b20e44287f..f5b0f16305b30 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -629,6 +629,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @prep_probes:		Prepare applying probes for each region.
  * @apply_probes:		Apply probes for each region.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
@@ -656,6 +657,8 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
+ * @prep_probes should execute required &struct damon_prep for next &struct
+ * damon_probe applications to each region.
  * @apply_probes should apply the data attribute probes to each region and
  * accordingly update the probe hits counter of the region.  It should also
  * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
@@ -678,6 +681,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*prep_probes)(struct damon_ctx *context, bool set_samples);
 	unsigned int (*apply_probes)(struct damon_ctx *context,
 			bool set_samples, bool return_max_wsum);
 	int (*get_scheme_score)(struct damon_ctx *context,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c74dee56efee8..bd2dc702a9811 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -156,6 +156,18 @@ static struct damon_prep *damon_nth_prep(int n, struct damon_probe *p)
 	return NULL;
 }
 
+static bool damon_has_prep(struct damon_ctx *c)
+{
+	struct damon_prep *prep;
+	struct damon_probe *probe;
+
+	damon_for_each_probe(probe, c) {
+		damon_for_each_prep(prep, probe)
+			return true;
+	}
+	return false;
+}
+
 struct damon_filter *damon_new_filter(enum damon_filter_type type,
 		bool matching, bool allow)
 {
@@ -3868,6 +3880,7 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
+		bool do_prep = damon_has_prep(ctx) && ctx->ops.prep_probes;
 		unsigned int max_merge_score = 0, max_wsum;
 		bool get_max_wsum;
 
@@ -3876,6 +3889,8 @@ static int kdamond_fn(void *data)
 
 		if (!access_check_disabled && ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
+		if (do_prep)
+			ctx->ops.prep_probes(ctx, access_check_disabled);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
@@ -3890,7 +3905,8 @@ static int kdamond_fn(void *data)
 			else
 				get_max_wsum = false;
 			max_wsum = ctx->ops.apply_probes(ctx,
-					access_check_disabled, get_max_wsum);
+					access_check_disabled && !do_prep,
+					get_max_wsum);
 			if (get_max_wsum)
 				max_merge_score = max_wsum;
 		}
-- 
2.47.3
