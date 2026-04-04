Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620138F65B;
	Sat,  4 Apr 2026 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320794; cv=none; b=mfpE3VXn74ieWxG5MQYqBcBg5Ivo/mCj1A843M6pB57IvhLhVNIt2DGXbf7ew0DXiwYxDCMlCgHzHrLWtNPkd9NiSQb4eEQKwGsxaaWh/qqkAfdhCINnE0hjx/TmzhMmWOPR2uxCMwTXvymmX1svAqIyt+w5TU4tqELjvf53LpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320794; c=relaxed/simple;
	bh=LD+Gu8qGFIg85Mqkymtw5F6uEv4cPpFyAPwSqtGapaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAqdcAjYj7QXya3cRHO6bptmCSQl7J2057tvRrZgqxdI5MPqv48xj6KlOU9kVeWutyCfBLSL4Ees1w7z8VXcM007MjOejMQlRNqX1Ms1uoLuPrNzO3mDTlHtCnfAiRpnpTU3dGerzGuTlTAncFM1rD/5N3o4YouhtIut+6k/fB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta9PmKot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta9PmKot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA03C2BCB3;
	Sat,  4 Apr 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320794;
	bh=LD+Gu8qGFIg85Mqkymtw5F6uEv4cPpFyAPwSqtGapaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ta9PmKotJNVWvjCGct+sfbcIjOx9c/DZpn+LjzzrMYZaGdz5XVIPkIZmTyq7obbCX
	 ZUIAbN8NT94KDVyx7L0wvPm68Fzy5A/2Dm+Yk0KjMDbgAFNhCy9+resE90P8pjQA1X
	 Fgo7u6QS5IkKegPxt/QiCCpkPAxdV/dhnaCnAXjfZBoAMbQ102S46BPxY8GFZjs6HM
	 aWFoTm+2/pYU4Gvivpa0uBgG7qGAIOjGvvH3ikaRmlmPmFZYH/jYp3Ovc+KxmXHdeG
	 PgaSkWihrHLrDGPuIfCMq8ZqfOtXidzTNzUw57RWtMT9c8ste/RW0DMWEy2A07RrwU
	 mmsJzL/Wm8Vgw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/9] mm/damon/core: introduce failed region quota charge ratio
Date: Sat,  4 Apr 2026 09:39:31 -0700
Message-ID: <20260404163943.89278-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
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
 include/linux/damon.h | 9 +++++++++
 mm/damon/core.c       | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4b69f4553267d..9ab7331775b9e 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -233,6 +233,8 @@ enum damos_quota_goal_tuner {
  * @goals:		Head of quota tuning goals (&damos_quota_goal) list.
  * @goal_tuner:		Goal-based @esz tuning algorithm to use.
  * @esz:		Effective size quota in bytes.
+ * @fail_charge_num:	Failed regions charge rate numerator.
+ * @fail_charge_denom:	Failed regions charge rate denominator.
  *
  * @weight_sz:		Weight of the region's size for prioritization.
  * @weight_nr_accesses:	Weight of the region's nr_accesses for prioritization.
@@ -262,6 +264,10 @@ enum damos_quota_goal_tuner {
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
@@ -276,6 +282,9 @@ struct damos_quota {
 	enum damos_quota_goal_tuner goal_tuner;
 	unsigned long esz;
 
+	unsigned int fail_charge_num;
+	unsigned int fail_charge_denom;
+
 	unsigned int weight_sz;
 	unsigned int weight_nr_accesses;
 	unsigned int weight_age;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fe5a4a8d5b294..4cbf664c52021 100644
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
@@ -2098,7 +2100,12 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-		quota->charged_sz += sz;
+		if (quota->fail_charge_denom)
+			quota->charged_sz += sz_applied +
+				(sz - sz_applied) * quota->fail_charge_num /
+				quota->fail_charge_denom;
+		else
+			quota->charged_sz += sz;
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
-- 
2.47.3
