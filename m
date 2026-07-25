Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A26371CE4;
	Sat, 25 Jul 2026 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013358; cv=none; b=qx1eBaHmCtF4lIYL4NTKNU4E0IyEHVmVkP1AH/g4l1RGsmFACcZFAcqRLUVbUr98E0ehR3ohqwHZFORn2zHXpVnWu9zZVfBXlK+LBHyjhC14nW8AREJ+aTCSFFlnVcxzNbcz8HyyYC/q4OhGCvC1EWlKk1HD/l1rC/MUN2QuF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013358; c=relaxed/simple;
	bh=LqkH270yj6cEGx5W27ucoHgM47ijlvoVXs2hvZhey3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/rYomcVQmw0OSpxU144Um+oPFVKFao+35d6kDi44Qkf2wCFFya1oc+P1j6sAj77aPv0F+QD+uhUTQRlGGmMYagjKDydyoFRMU1+WK4VVKYCm+bEdZ6kIBvJmeIbeOBg9KTBWd/lW7qKtQIgYtpi4r8Z13Rma8S8hM9UAea6lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX0TEy62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX0TEy62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6B71F00A3A;
	Sat, 25 Jul 2026 21:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013357;
	bh=QnE06deXrI0slNd+Eqrp5ImjS8Zb6D21mxT9DSUmfyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BX0TEy62bI8Edi8K4sbFTmSYcLY18hx8RnHnVahzCCxwwMPbM7C6STlFtYLSPN7sn
	 f5iLeDeuoMDgvh5auBFcwwPUWxzNjRc83GkBfK3aYRw+5QALIbjnSFQrOTNrX0NkFZ
	 GhV1OakXo8K2mKr+ruXqnOCygwaS5ypnFuxvxVsrO0n7q0sXjaCXpwrpQYw88EEvo5
	 d3OzCYQ+fVYvNKa4pbaCrXabsmD3bgNSoF2vV9k9aQ+Q32K4J2eme2pyTiS3XYWis9
	 j3A7F9cNRqaQb8slaEubtp8tSF0582ZHO57j7rfe9P92cImmEXRRRpQuTPlAjwbC+J
	 TN9bnhvdk6lLQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/17] mm/damon/core: introduce damon_operations->prep_probes()
Date: Sat, 25 Jul 2026 14:02:11 -0700
Message-ID: <20260725210225.129944-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
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
index c74dee56efee8..11d16b7104a7e 100644
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
+		bool has_prep = damon_has_prep(ctx);
 		unsigned int max_merge_score = 0, max_wsum;
 		bool get_max_wsum;
 
@@ -3876,6 +3889,8 @@ static int kdamond_fn(void *data)
 
 		if (!access_check_disabled && ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
+		if (ctx->ops.prep_probes)
+			ctx->ops.prep_probes(ctx, has_prep);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
@@ -3890,7 +3905,8 @@ static int kdamond_fn(void *data)
 			else
 				get_max_wsum = false;
 			max_wsum = ctx->ops.apply_probes(ctx,
-					access_check_disabled, get_max_wsum);
+					access_check_disabled && !has_prep,
+					get_max_wsum);
 			if (get_max_wsum)
 				max_merge_score = max_wsum;
 		}
-- 
2.47.3
