Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBA3D093B;
	Fri, 10 Apr 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830845; cv=none; b=fnU+OGBylIiG1a1KyizxyO3Sv6zBTHygdvpObEwdgRzTPlp4FonrKmOGzGSIo9iDz0IoC/LoaBcKIfWTqjMjX1bFF4dWgAl08YgtjWyVcsE8OLd7AsfbnHNimEWBNNGlmjOfg5gu2a3ZulfMlS1Cy9EnWpgCd7oY+V7CtuXh95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830845; c=relaxed/simple;
	bh=UXAPF6g5HmLPcR+NX9wWokbltFyqLM2XHmtP9qYo8uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dE7BFFFwS9QmoPfjcLYNxxkcm6b50Sp1bnBz0srjD9a1CZVeCGSP+ipLW8XvKKMSC17TXTw7o0KLFHw9pIatZIELH+wN+XP5yqcKJhJT6AT/OdwYjEmCnDAdP3AmCSKbEKG0e/MYBzV5MlcEv27Qxz8deAfe0SfLsDGhg/4LnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT/qKC1E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT/qKC1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4841EC19421;
	Fri, 10 Apr 2026 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830845;
	bh=UXAPF6g5HmLPcR+NX9wWokbltFyqLM2XHmtP9qYo8uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KT/qKC1EdgmNF/OypCa4cBbTyHfxYQKJqufzo2eY9EkfjLj/N9/9UlQrya7Y3Kfjs
	 v1xyTg9phwjD5maLmTnvBDx/w0Z1c+p6xx9LIZdZvUXG7vQT8x/2xUsPdWN5TDAP9u
	 cEHD+meJTxI1VTRC1H1uj9xKorZ/lZg4RyWWwwK6wvQPEDQs2uDLtMU1i7UWCsqtv1
	 HM0tc1idJo1ovlBgDDUAFGEcFdpedpUY6D5SHRmk83DK70Y8pvsURDaVPFf1nh1ZkK
	 MhfysZJ3UqL857JlOLwz9sIydBhNaWPARYYUtKdtUG00iBTPYVzgvrX+IVTq4LJxSy
	 7nSuz0wmY0fkw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 03/11] mm/damon/core: introduce failed region quota charge ratio
Date: Fri, 10 Apr 2026 07:20:24 -0700
Message-ID: <20260410142034.83798-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-1-sj@kernel.org>
References: <20260410142034.83798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS quota is charged to all DAMOS action application attempted memory,
regardless of how much of the memory the action was successful and
failed.  This makes understanding quota behavior without DAMOS stat but
only with end level metrics (e.g., increased amount of free memory for
DAMOS_PAGEOUT action) difficult.  Also, charging action-failed memory
same as action-successful memory is somewhat unfair, as successful
action application will induce more overhead in most cases.

Introduce DAMON core API for setting the charge ratio for such
action-failed memory.  It allows API callers to specify the ratio in a
flexible way, by setting the numerator and the denominator.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  9 +++++++++
 mm/damon/core.c       | 21 ++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d3054af1d964f..5fb1dc585658b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -235,6 +235,8 @@ enum damos_quota_goal_tuner {
  * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @goal_tuner:		Goal-based @esz tuning algorithm to use.
  * @esz:		Effective size quota in bytes.
+ * @fail_charge_num:	Failed regions charge rate numerator.
+ * @fail_charge_denom:	Failed regions charge rate denominator.
  *
  * @weight_sz:		Weight of the region's size for prioritization.
  * @weight_nr_accesses:	Weight of the region's nr_accesses for prioritization.
@@ -264,6 +266,10 @@ enum damos_quota_goal_tuner {
  *
  * The resulting effective size quota in bytes is set to @esz.
  *
+ * For DAMOS action applying failed amount of regions, charging those same to
+ * those that the action has successfully applied may be unfair.  For the
+ * reason, 'the size * @fail_charge_num / @fail_charge_denom' is charged.
+ *
  * For selecting regions within the quota, DAMON prioritizes current scheme's
  * target memory regions using the &struct damon_operations->get_scheme_score.
  * You could customize the prioritization logic by setting &weight_sz,
@@ -278,6 +284,9 @@ struct damos_quota {
 	enum damos_quota_goal_tuner goal_tuner;
 	unsigned long esz;
 
+	unsigned int fail_charge_num;
+	unsigned int fail_charge_denom;
+
 	unsigned int weight_sz;
 	unsigned int weight_nr_accesses;
 	unsigned int weight_age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b0f673efc53c8..f93f107bfb9ec 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -918,6 +918,8 @@ static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
 	if (err)
 		return err;
 	dst->goal_tuner = src->goal_tuner;
+	dst->fail_charge_num = src->fail_charge_num;
+	dst->fail_charge_denom = src->fail_charge_denom;
 	dst->weight_sz = src->weight_sz;
 	dst->weight_nr_accesses = src->weight_nr_accesses;
 	dst->weight_age = src->weight_age;
@@ -2042,6 +2044,23 @@ static void damos_walk_cancel(struct damon_ctx *ctx)
 	mutex_unlock(&ctx->walk_control_lock);
 }
 
+static void damos_charge_quota(struct damos_quota *quota,
+		unsigned long sz_region, unsigned long sz_applied)
+{
+	/*
+	 * sz_applied could be bigger than sz_region, depending on ops
+	 * implementation of the action, e.g., damos_pa_pageout().  Charge only
+	 * the region size in the case.
+	 */
+	if (!quota->fail_charge_denom || sz_applied > sz_region)
+		quota->charged_sz += sz_region;
+	else
+		quota->charged_sz += sz_applied + mult_frac(
+				(sz_region - sz_applied),
+				quota->fail_charge_num,
+				quota->fail_charge_denom);
+}
+
 static bool damos_quota_is_full(struct damos_quota *quota,
 		unsigned long min_region_sz)
 {
@@ -2112,7 +2131,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-		quota->charged_sz += sz;
+		damos_charge_quota(quota, sz, sz_applied);
 		if (damos_quota_is_full(quota, c->min_region_sz)) {
 			quota->charge_target_from = t;
 			quota->charge_addr_from = r->ar.end + 1;
-- 
2.47.3
