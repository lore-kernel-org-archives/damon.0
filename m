Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD93E5A27;
	Sun, 27 Sep 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510747; cv=none; b=XqUA1zIYOKpuUM0X0p8WqgEHiL6METo4pCzQsuSS80Ccz9K4zQYAjOhwWLgSPWZcTNx+mgDkDjiPnbuPIHbHBpI8Pif9811NiaQoV92lfsEj/2Xi70xO1XvV9E+Cjbrmy/GSCOBBJ5j7w2YBIhtqDlSMJChNta/zmiVLo4I/6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510747; c=relaxed/simple;
	bh=py31rbRQv0qdjyhhHYCh1lqd2fVrT7lGuKiB2ony4tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiICQ9pCM5TOhDso0iyJfGvsltYws7pfDZNFFma8rXX6OOR8rrJxSg+OjFk2QHuaPzjfA6l2xNuXmDhjrLyX0wDi/hLjHlL3Jw6KqoXQNn2M8Doq+vuGxY8EkWt4wouXdpZPrwSX7WPKoZ0dBjME7FIITxbCErefIkinlMzU02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRNjgOxQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRNjgOxQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EEA1F00893;
	Sun, 27 Sep 2026 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790510746;
	bh=nCUk6L1aWaPzrTTzvJ81KlDjiL0II5tx/S//2fpxpwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRNjgOxQDn+75I2Dx/utQk867cR4sElrSKVNMiaXhXFdaWAaOp/FF07qOkMaD+XZ5
	 tzZMdD9bQdFYEmlzZH6Ehz0SWHjKX56+/sKssQ+Bkru9BMY6k7Vq7OxdbcusmGp5nM
	 mx9KbeTW1JMLavmpD7C5/RcQ+SixC/LKVzfdwPVZde+XAwkDurisbaLI9BfGO/FQGE
	 oVQ4cE8r7/KDT6JPjb1043UKZCNPUsDBSPSIxt3Dgiok8ezaWyWFs9hwlOkSt6Nio6
	 c6QCyVI7XQW1/VITVaMDrq5OEE3OmCo//9y9Vm7emXsZxa7Zk5FCYP+q8JSlDpZoOG
	 nB4cWwF++W57w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 1/7] mm/damon/core: introduce damos_quota_goal->complement
Date: Sun, 27 Sep 2026 05:05:25 -0700
Message-ID: <20260927120533.50484-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927120533.50484-1-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
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
index 844b175120f0..78b227875287 100644
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
index 733025b36745..270ce9c85a2c 100644
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
