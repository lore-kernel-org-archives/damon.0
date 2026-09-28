Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078C48FF6E;
	Mon, 28 Sep 2026 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588034; cv=none; b=FWyFhACeQ+nVmOI4zSP4paeG/rTtdxSoOBDUlzWdPfTjiup5wJQqhlD1BdceT/GLHKYwXN1lHr6va68A/2GLv/Ya2icOLvJzprDI4JO/CSl2HDnaCiZ6fUWCYPqn++/Cu2mtMKiE/+YOATvWgX4szkdeYHxWZTdEC7yjqH0bfkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588034; c=relaxed/simple;
	bh=py31rbRQv0qdjyhhHYCh1lqd2fVrT7lGuKiB2ony4tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgqI89ribhVyEXPIPZir+AtaKwnbL+Fe1gO8ZS/DPBmBRvjMb928roGU2Dc/ma/G0+zanemRhIsZ63+iycDIcIsydeKEAOwap9YCWw4HhzcybQ43IQ64TLBBg3MBmcHV2dWdk/o0u3E48L0UNb2tqmhpo/mIDcSfazBKNbJc2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW004KwN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW004KwN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF9C1F00893;
	Mon, 28 Sep 2026 09:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588032;
	bh=nCUk6L1aWaPzrTTzvJ81KlDjiL0II5tx/S//2fpxpwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WW004KwNVIYEXrtmQWam0faQScc8OeqZS7bPF9E74Zy09MhziQYJ4gsX1jnNF6y2s
	 w9YqHiKaVWMJdHqULM8+anbdnlj2cpSaUBwZNlBl3dZuIPs27e4q1V0hwqGrTC/95K
	 bisOlITQDUpuHABxhq1qfK+A/X+Srpmcj5OrgfyB6sO5dXykjqWFi3p3fTS0O7TWZa
	 JPx9sRR0oQPXScUWMz0xk3aPxgzBnQHawHJXNZ8HmWST0CBcWZOcwQtElllwYeasTw
	 twssCp4r4IsR9NlNU5tma9iR8CLez0iywCIxU+uJYRVC7Pxx5hxxdhg9uTuPQ75jN0
	 zjfJS1LdXQPJA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 1/8] mm/damon/core: introduce damos_quota_goal->complement
Date: Mon, 28 Sep 2026 02:33:33 -0700
Message-ID: <20260928093342.16584-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
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
