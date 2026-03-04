Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F55B22332E;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599288; cv=none; b=iNIn+G0YabNaBHwWUvd0OhTskj899pJFBWyoP/EtPh8s8CWuQ7HjwsWnxaGpdhfBM7makrsZvwc8PcX6DDmPmbv/UWN/DMAgrQTWUsPUnTakjSPDbabozlw8vZbDoC6avMRq614z0Z6BOW5qUv0XgN3RhtVVTWS/Pwohlma3RQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599288; c=relaxed/simple;
	bh=nTnfRhRJMckp340lWLTDQoIkY6mvLW+nk013FmeqEz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPpKpnCo99HUly6i80jZ3ICer6lMqXMSMdZyM/Qq1KMkppxrNd3L1xtVNoGQSLyrtxC1gDixnC2tNIpScOnwFZaFVs1aNy4ZMMxiAGkghhV0Kv3iJD6SpAp/mVvqF3vLuk6n4DHMB4p4FQIU3PgwDBpYBsF/PFtXUHhm07wCk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV931DHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV931DHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089FDC2BC9E;
	Wed,  4 Mar 2026 04:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599288;
	bh=nTnfRhRJMckp340lWLTDQoIkY6mvLW+nk013FmeqEz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EV931DHAiKMtwvkYfYmHhfhN/0FZek1fgBPfYn8g0n4wNHd/3yS5HXIwPl784LK07
	 O8tH1R+5W8pA7orBtjjHjWKFfgNpVXDuNGiJ5Ate34Wtptf7lp6CNA5bVDa4KfBn6n
	 w586nH+D6+FOhoCTRbyGCBZbipUfv9Xeo78JGAOdkpeFBElLqODU8Y7J/sZqpUCPfm
	 Z2rtDXs/Q6ccq8kNK6Aj34+CtClK7qxRkChUpJkPKSs6JVZIhblbPuMaxnzYSH9vQO
	 wWj0ag5TI0aGnwofyTUFgDWsqMZ3X93ADOFI7/4oQd9sU4DQCRbRQiMkEbp4Er22P4
	 dawZMVXPcsENg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/10] mm/damon/core: introduce damos_quota_goal_tuner
Date: Tue,  3 Mar 2026 20:41:10 -0800
Message-ID: <20260304044122.79394-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently DAMOS quota goal feature utilizes a single feedback loop based
algorithm for automatic tuning of the effective quota.  It is useful in
dynamic environments that operate systems with only kernels in the long
term.  But, no one fits all.  It is not very easy to control in
environments having more controlled characteristics and user-space
control towers.  We actually got multiple reports [1,2] of use cases
that the algorithm is not optimal.

Introduce a new field of 'struct damos_quotas', namely 'goal_tuner'.  It
specifies what tuning algorithm the given scheme should use, and allows
DAMON API callers to set it as they want.  Nonetheless, this commit
introduces no new tuning algorithm but only the interface.  This commit
hence makes no behavioral change.  A new algorithm will be added by the
following commit.

[1] https://lore.kernel.org/CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com
[2] https://lore.kernel.org/20260204022537.814-1-yunjeong.mun@sk.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 9 +++++++++
 mm/damon/core.c       | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9a88cf8d152d8..63f1e3fdd3866 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -213,6 +213,14 @@ struct damos_quota_goal {
 	struct list_head list;
 };
 
+/**
+ * enum damos_quota_goal_tuner - Goal-based quota tuning logic.
+ * @DAMOS_QUOTA_GOAL_TUNER_CONSIST:	Aim long term consistent quota.
+ */
+enum damos_quota_goal_tuner {
+	DAMOS_QUOTA_GOAL_TUNER_CONSIST,
+};
+
 /**
  * struct damos_quota - Controls the aggressiveness of the given scheme.
  * @reset_interval:	Charge reset interval in milliseconds.
@@ -260,6 +268,7 @@ struct damos_quota {
 	unsigned long ms;
 	unsigned long sz;
 	struct list_head goals;
+	enum damos_quota_goal_tuner goal_tuner;
 	unsigned long esz;
 
 	unsigned int weight_sz;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e8c44541754f7..c5503fdb10bb7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -432,6 +432,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->quota = *(damos_quota_init(quota));
 	/* quota.goals should be separately set by caller */
 	INIT_LIST_HEAD(&scheme->quota.goals);
+	scheme->quota.goal_tuner = quota->goal_tuner;
 
 	scheme->wmarks = *wmarks;
 	scheme->wmarks.activated = true;
@@ -904,6 +905,7 @@ static int damos_commit_quota(struct damos_quota *dst, struct damos_quota *src)
 	err = damos_commit_quota_goals(dst, src);
 	if (err)
 		return err;
+	dst->goal_tuner = src->goal_tuner;
 	dst->weight_sz = src->weight_sz;
 	dst->weight_nr_accesses = src->weight_nr_accesses;
 	dst->weight_age = src->weight_age;
-- 
2.47.3
