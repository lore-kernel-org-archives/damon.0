Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94260330328;
	Wed,  8 Jul 2026 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478945; cv=none; b=OM/UnkdwftnHZdTgVheagEVyZiNYHYaA4+4GX/OK6O6R5fFPa0fzodUy/ucfb06MniEjze9PzwHbuMfinLK45yyoFJLOCIoeADc5KGZgeneXOjz8QKnvKjiRRVOPwK3gGrvpzb0nxacS5PFxrGLQDKGcQh1J3Q9Q8WL1puuv8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478945; c=relaxed/simple;
	bh=dYUcQGND6Kru11SQ3BBOstRMi6fKjCKOJHHBn7L9rwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLySCiv1zpd1JzA9ohPqb/KrgPkN+tbpJVa0FBktAxI0BG97qMHorcT+bhipsBENTnjCiSyqri/3hIQjOcJBZf8AcjhcJRIUFfB3kkak+OkfosVrI8BXun2YxMsqpU95tEpSgc0lUP+1xuFyYjKLTz9U/MbA8sNUeWrXzVXhkVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiUnSXjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiUnSXjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543191F00A3A;
	Wed,  8 Jul 2026 02:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478944;
	bh=mTeI5Dbt+ALLrinCjjWwHybLZIRmQonrPoimOF6qJBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PiUnSXjTwIfxjIy86c7MyQH6nD0+t5BAxC9Fhc8TZxDjbICpxFbMgCwigh20FopmT
	 KZqu0LWJvCFRGu/EqfzVUpmvjhUXvZBjLSubgfSlJyzSFRxInFtMLxQjT5DPm/KJeR
	 WUdCzSHiNUCE/j403Erhf/mGYAyZc7X2FABC9ZT6imOnf+nxvgSEWgoDnjaT3Etlsw
	 ALuJlfFTFLadIPlyAcOAdicmcnYsV5fzaGDimBHlA5MAjbq1jgmHqTNkgVRjDu4exi
	 DQQAIo3/405PNBtov5iNZzhbP2oDedYkTOcV3mdDhTUOO85/YPOdg9lydS1eNM0Cf0
	 UljpG86xHr+vg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 2/7] mm/damon/core: s/damon_max_nr_accesses()/damon_nr_samples_per_aggr()/
Date: Tue,  7 Jul 2026 19:48:48 -0700
Message-ID: <20260708024855.116614-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708024855.116614-1-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_max_nr_accesses() actually returns the number of samples DAMON
checks for each region per each aggregation interval.  Rename it to
better describe what it really does and not confusing for more general
uses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ++++++----
 mm/damon/core.c       |  4 ++--
 mm/damon/lru_sort.c   |  2 +-
 mm/damon/ops-common.c |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 19b7e839bde0b..63f596957c1f1 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1056,15 +1056,17 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 	return ctx->ops.id == DAMON_OPS_VADDR || ctx->ops.id == DAMON_OPS_FVADDR;
 }
 
-static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
+/* Returns number of samples per aggregation interval */
+static inline unsigned int damon_nr_samples_per_aggr(
+		const struct damon_attrs *attrs)
 {
 	unsigned long sample_interval;
-	unsigned long max_nr_accesses;
+	unsigned long nr_samples;
 
 	sample_interval = attrs->sample_interval ? : 1;
-	max_nr_accesses = min(attrs->aggr_interval / sample_interval,
+	nr_samples = min(attrs->aggr_interval / sample_interval,
 			(unsigned long)UINT_MAX);
-	return max_nr_accesses ? : 1;
+	return nr_samples ? : 1;
 }
 
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index a15005db82899..177e5abc981ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -880,14 +880,14 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
 static unsigned int damon_accesses_bp_to_nr_accesses(
 		unsigned int accesses_bp, struct damon_attrs *attrs)
 {
-	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
+	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
 /* Convert nr_accesses to access ratio in bp (per 10,000) */
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
-	return mult_frac(nr_accesses, 10000, damon_max_nr_accesses(attrs));
+	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index e8c389ad3226f..7e077084cb03a 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -303,7 +303,7 @@ static int damon_lru_sort_apply_parameters(void)
 		goto out;
 
 	err = -ENOMEM;
-	hot_thres = damon_max_nr_accesses(&attrs) *
+	hot_thres = damon_nr_samples_per_aggr(&attrs) *
 		hot_thres_access_freq / 1000;
 	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
 	if (!hot_scheme)
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 6bdd1cfd3863a..89c694f6e4fa8 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -112,7 +112,7 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	int hotness;
 
 	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
-		damon_max_nr_accesses(&c->attrs);
+		damon_nr_samples_per_aggr(&c->attrs);
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	if (age_in_sec)
-- 
2.47.3
