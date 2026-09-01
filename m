Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBC480972;
	Tue,  1 Sep 2026 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269119; cv=none; b=RN/b4yQoTR9dXU3HTlALclL6BcyFIl1s+aRzZ2Kr3d6p6DIu959JLk69uFtbF2y4z1S/XUkZhh3+Jw7hfM0PLvdKTEsUB7Zobhk+woNUXgCt341Fu0bNpF6zjqxtuQU6YP2zdXpAt+vwBrH7T6ZpRW9vBHuXU2RXmSFB9aCnndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269119; c=relaxed/simple;
	bh=SZeQ5JCi8iR4wDXzcllj59HrIjfGWjZKEdSDpPM3xSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMjXvWt1atGFsUzdjbepq6ZmepzmwynElo+hX18nvZ/zVJn+TqA5tqqyEEKycP5wsfXqTxuWb/g6xyqdEfykIZF2K2flWc1UO+NEiR9AlgnvsQHokcWgWzsS+H+SPAgkbIK+b3S7twNQiHN/ehiJ+k6HGDoRNGAOlM01xFItK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPmxm92b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPmxm92b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0D41F000E9;
	Tue,  1 Sep 2026 13:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269117;
	bh=SiFpyzeeZ8dXbIxeNUm9NHfmBqlBoJ0Y+FG8UIsF09c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPmxm92bXxmEWPYKR2yygRYwRMYLP1oZneWz4EyJVxtKpYyuvsNwMtL9Ak37oquKl
	 tL9PkkCNZKBIIdVpm5OoRP2/4igWlZDouWx5PchABxKMETnJN7+eLEJ+GozAIh4sL6
	 wvInedonXzZoMEG0A7arJfiL1+wRPPHJqaaEuZkvF8f495aVULlzWxh/Tm6yPjjJYh
	 HN1LREfZumaHW/Z/vp3oYpHo9WYeuCO3J6tO/F3kreODG3gljIteMATs5p9lvCJocq
	 Ofww8eLJWsMorZbpzu3s0PfwpIQpuuAFkxAmXnZiEHky6GqkH5Yil20ybR4uQ/gbxO
	 Rk9u/oPzhiR+Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 07/17] mm/damon/core: introduce damon_operations->prep_probes()
Date: Tue,  1 Sep 2026 06:24:54 -0700
Message-ID: <20260901132506.99243-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
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
 include/linux/damon.h |  5 +++++
 mm/damon/core.c       | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1780c14942e63..871d26adf6ae5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -630,6 +630,7 @@ enum damon_ops_id {
  * @update:			Update operations-related data structures.
  * @prepare_access_checks:	Prepare next access check of target regions.
  * @check_accesses:		Check the accesses to target regions.
+ * @prep_probes:		Prepare applying probes for each region.
  * @apply_probes:		Apply probes for each region.
  * @get_scheme_score:		Get the score of a region for a scheme.
  * @apply_scheme:		Apply a DAMON-based operation scheme.
@@ -657,6 +658,9 @@ enum damon_ops_id {
  * last preparation and update the number of observed accesses of each region.
  * It should also return max number of observed accesses that made as a result
  * of its update.  The value will be used for regions adjustment threshold.
+ * @prep_probes should execute required &struct damon_prep for next &struct
+ * damon_probe applications to each region.  It should also set
+ * &damon_region->sampling_addr of each region if ``set_samples`` is true.
  * @apply_probes should apply the data attribute probes to each region and
  * accordingly update the probe hits counter of the region.  It should also
  * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
@@ -679,6 +683,7 @@ struct damon_operations {
 	void (*update)(struct damon_ctx *context);
 	void (*prepare_access_checks)(struct damon_ctx *context);
 	unsigned int (*check_accesses)(struct damon_ctx *context);
+	void (*prep_probes)(struct damon_ctx *context, bool set_samples);
 	unsigned int (*apply_probes)(struct damon_ctx *context,
 			bool set_samples, bool return_max_wsum);
 	int (*get_scheme_score)(struct damon_ctx *context,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 87ac428358ec0..df22621765911 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -157,6 +157,18 @@ static struct damon_prep *damon_nth_prep(int n, struct damon_probe *p)
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
@@ -3906,14 +3918,19 @@ static int kdamond_fn(void *data)
 		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
 		unsigned long sample_interval = ctx->attrs.sample_interval;
 		bool access_check_disabled = damon_has_probe_weights(ctx);
+		bool do_prep;
 		unsigned int max_merge_score = 0, max_wsum;
 		bool get_max_wsum;
 
 		if (kdamond_wait_activation(ctx))
 			break;
 
+		do_prep = ctx->ops.prep_probes && damon_has_prep(ctx);
+
 		if (!access_check_disabled && ctx->ops.prepare_access_checks)
 			ctx->ops.prepare_access_checks(ctx);
+		if (do_prep)
+			ctx->ops.prep_probes(ctx, access_check_disabled);
 
 		kdamond_usleep(sample_interval);
 		ctx->passed_sample_intervals++;
@@ -3928,7 +3945,8 @@ static int kdamond_fn(void *data)
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
