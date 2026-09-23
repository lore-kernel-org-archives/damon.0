Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026648122F;
	Wed, 23 Sep 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158513; cv=none; b=eKwlFaou5tTzFjozrUMPZOKKLE18f7AEM9QYtOQmWEObb8zDcVfCPMTLv2KLxetfUXlKhCpiwpfc5hI/lA0APshzpq69ALS8xloksZPJRRlvp01tru3sHjM+qfFwy0VNczsQcRckNl7bP5daiGqa7iiYKgVj8toRzhE7MKYoP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158513; c=relaxed/simple;
	bh=qYzWp6VHP/HR+yWUpjZx2lyqgT5Lv+oRVspqenmMkOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRrRneGfK5uJgbTxpNwGR3b8RXnl5F+UIDorkkIdT+bfv5ohEbJEAyNV6S+teCX6uFfcziQVyyWfSyK89nmvz48Pm2qw3a2CnvHeXxMU9WHnadNr32gUQs9vZwlXG2OqOaxEM4v9EReZum4+wOA60iI37Wi0ZVToLbw1OIVQ69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLsYsRuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLsYsRuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5D71F00893;
	Wed, 23 Sep 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158504;
	bh=Le0M5MU2vZNaokYjxTmQGl7234V19KAd0AEz359SlAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLsYsRuH3maXMLxmsRhxQSiF9J5/Gx19cMgqQyWx4F82RCnG5QdLrzPQBS77+m3fQ
	 WHlqZ8KDbcYIkq8UZFDvvbUaNQcbXrmFRnu5VqdlAMFF61GFwQXbE4EgrtmDBW63qa
	 7a6mKZ9LYajFcXr21026JxtlCkXI88nsCIO9T1nGQBvgOkBe0TRxZvN86gqR9Eoyd0
	 lnoO3vwu1j6IwIaqxPCQJB0u2tE60W9gdghX2t3A0OAhmST8VqDpoi0vaMKBVFX5uT
	 +xcRAPPiIQiWpeECHM0S+IGUFbwqWFb2X+kvas0Z0vajqSnYTh7vBEYHgMUzlnvZfu
	 2Z1P487s0yx4A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Wed, 23 Sep 2026 03:14:46 -0700
Message-ID: <20260923101454.5748-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923101454.5748-1-sj@kernel.org>
References: <20260923101454.5748-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce damos_quota_goal->complement for specifying whether to use a
complemented value of the given goal target metric.  Add the field to
the data structure and implement essential core support.  Handle the
flag in the quota goal commit and current quota goal metric value
retrieval.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h |  2 ++
 mm/damon/core.c       | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6a29dc2ac8db..42234839ce29 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -169,6 +169,7 @@ enum damos_quota_goal_metric {
 /**
  * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
  * @metric:		Metric to be used for representing the goal.
+ * @complement:		Use the complement of the metric.
  * @target_value:	Target value of @metric to achieve with the tuning.
  * @current_value:	Current value of @metric.
  * @nid:		Node id.
@@ -191,6 +192,7 @@ enum damos_quota_goal_metric {
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
+	bool complement;
 	unsigned long target_value;
 	unsigned long current_value;
 	/* metric-dependent fields */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 566960659e4a..836cf0d0de6f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1224,6 +1224,7 @@ static int damos_commit_quota_goal(
 	if (!src->target_value)
 		return  -EINVAL;
 	dst->metric = src->metric;
+	dst->complement = src->complement;
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
@@ -2960,10 +2961,18 @@ static void damos_set_psi_current_val(u64 now_psi_total,
 		struct damos_quota_goal *goal, struct damos *s)
 {
 	u64 last_psi_total = goal->last_psi_total;
+	unsigned long val;
 
 	goal->last_psi_total = now_psi_total;
 	if (last_psi_total != U64_MAX) {
-		goal->current_value = now_psi_total - last_psi_total;
+		val = now_psi_total - last_psi_total;
+		if (goal->complement) {
+			if (val < s->quota.reset_interval * 1000)
+				val = s->quota.reset_interval * 1000 - val;
+			else
+				val = 0;
+		}
+		goal->current_value = val;
 		return;
 	}
 	/* uninitialized last_psi_total; make no effect this round */
@@ -3255,6 +3264,21 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
 	default:
 		break;
 	}
+	if (!goal->complement)
+		return;
+
+	/* updte current_value to complemented value */
+
+	/* for user_input, users set complemented value on their own */
+	if (goal->metric == DAMOS_QUOTA_USER_INPUT)
+		return;
+	/* damos_set_psi_current_val() handles complement flag itself */
+	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		return;
+	if (goal->current_value < 10000)
+		goal->current_value = 10000 - goal->current_value;
+	else
+		goal->current_value = 0;
 }
 
 /* Return the highest score since it makes schemes least aggressive */
-- 
2.47.3
