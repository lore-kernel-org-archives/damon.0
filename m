Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616237D12F;
	Sat, 19 Sep 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780454; cv=none; b=hb8uIz72+4iDytjq3LA9JTCP5Yv7E8dlYO7OWYmmKKZrzwKGE2yYro+jDrKqoGMWqp/jh/dpF8iOKSs4B9HaDW3nAf5BDmcpHKtXeQIIZgQBhzNQwS4lebewUr7y2HsnqFZHSmbp0cHNusRxhFmBnvvkDgH3KHwv/P35UqXuy3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780454; c=relaxed/simple;
	bh=3ZxVr4r2yvbUvKXK4+V4XR9/fVECWUlccUz9xb7cG2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0uem4+a4bsGFsh1NZFTkFoKJaJmn15M0+aOag0fW7h0Uosba6mplj0Oy37msBpM7bYBH/QUeugZWx+kMrqao7/yl0L3Zi6lAc7iL7HPR5MIS2jr7WjlebSi4pMH9MMZ62Kprdybkozjfwk2rrQHQia7oejq2kkP0jdzgqFTDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLiqC8bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLiqC8bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237081F0089D;
	Sat, 19 Sep 2026 01:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780448;
	bh=r4oxXYRuQjWd+sGDrw6IwSBotjvM7beQln0V1eFRUVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLiqC8btuCHiDoIaDtMK3nKE6F8yr4kzmUZVcBu16PG+/5FQiVNJbfveuJTwnZus4
	 LpqIA/K6vd7gtuCJ9uEp4Kmi6a40P4fvVJX3IOjF9eZrUJisET45Ps2Fs5wIY4aFIq
	 Sl0abzUnuR6ctFMct+7B/XjNSI64r8ZzHf4BqpZ61u3bwCfigyZqH4MmUpwhFZm2yt
	 Sy8Xr90yFlsZ5s/+Wcb1NrvtZo8leVc/BirD4h2fWbGyaILlFo0nmA6Cv1uz2IH1Qe
	 g9p288J2eNqBXLWsVeYHWr7lla9DhN8nsG4OxMmlKWaDIF9xzOhCZJjHNbCAiCc8aK
	 74/fjYzQGt13A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Fri, 18 Sep 2026 18:13:50 -0700
Message-ID: <20260919011359.88921-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919011359.88921-1-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
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
 mm/damon/core.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 844b175120f09..78b227875287d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -175,6 +175,7 @@ enum damos_quota_goal_metric {
 /**
  * struct damos_quota_goal - DAMOS scheme quota auto-tuning goal.
  * @metric:		Metric to be used for representing the goal.
+ * @complement:		Use the complement of the metric.
  * @target_value:	Target value of @metric to achieve with the tuning.
  * @current_value:	Current value of @metric.
  * @nid:		Node id.
@@ -197,6 +198,7 @@ enum damos_quota_goal_metric {
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
+	bool complement;
 	unsigned long target_value;
 	unsigned long current_value;
 	/* metric-dependent fields */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4687b909d42c9..05d1df3746e83 100644
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
@@ -3239,6 +3240,23 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
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
+	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US) {
+		goal->current_value = s->quota.reset_interval * 1000 -
+			goal->current_value;
+		return;
+	}
+	if (goal->current_value < 10000)
+		goal->current_value = 10000 - goal->current_value;
+	else
+		goal->current_value = 0;
 }
 
 /* Return the highest score since it makes schemes least aggressive */
-- 
2.47.3
