Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D813AD53F;
	Fri, 18 Sep 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741717; cv=none; b=nmoS/FIh9NNP802jbeiUeIuA4ZvoVPztBXz4BKlaR78XuzPWTYlRDD6+3wI8byT6DkRj1PvMJJAftE18/hGf/cIx5t3bXzm4P6PJqSuFwPDiaK80z0EdNYGNqSxF7SV1Bi2YbQ7YedkkvmH4NTcQEDbwhpPnvEVXpaKodt0vCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741717; c=relaxed/simple;
	bh=8MzCWvlHieDINCqR5+czAozZfPHIuo7j88iy0ae8w9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/WlcJFehPxAgmthZzbin6Lp7n+UYPwZqgpNXzrTee88+wv0Vw6pBDd9fpt02BmBmWmsG13GP/v0CNrwVLXvxcPP6rTYJFsWQLX6OnH5XNQw2FxHwlUQlyQeobWMXs3r+94P1MQcKdAdZ/hypmBpYEXh98XaGYNhLRD2KRDWEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igi3UyRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igi3UyRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7471F00899;
	Fri, 18 Sep 2026 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741716;
	bh=YDElM6FF7RUmZ+/ENlqzK5UOqsMZpif0jqIreTeTKcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Igi3UyRlFW/WKsgtQw8ZOmhcBYN2xquwJjMhs3uktX2GXilu0crpt0zJB0h1av/rW
	 VKrUcQPx02cFjFb9mlC/sueBvyLHxw5zLhnxNgAqbBbWpJkN4lV5h2u2tcQjaq1lUF
	 FoAi3Z5Fit87CP6jpBXJzRetkeO3odXYy37tUDJcgPvEdOCgmV9vREGZHR/7FWhlNd
	 XqQ4/20lvjiigthiqd1LnchkaLmHUX4liD/wv+5Yp6trhWvhqEII/3RiPfTbKIH1yF
	 AKTxjv36CJlPTDCJIPntrS3YHknh9qkGUiLh/oSu2NuqtX+Bl9Gg0e7EpxwZXYDDdG
	 Y886/2P7eWoxw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Fri, 18 Sep 2026 07:28:20 -0700
Message-ID: <20260918142827.85303-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142827.85303-1-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
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
 mm/damon/core.c       | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

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
index 4687b909d42c9..98cf6bab9fc6e 100644
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
@@ -3239,6 +3240,19 @@ static void damos_set_quota_goal_current_value(struct damon_ctx *c,
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
+	if (goal->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		goal->current_value = s->quota.reset_interval * 1000 -
+			goal->current_value;
+	else
+		goal->current_value = 10000 - goal->current_value;
 }
 
 /* Return the highest score since it makes schemes least aggressive */
-- 
2.47.3
