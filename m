Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033515FA77;
	Tue, 18 Jun 2024 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734701; cv=none; b=QO+BkDTxocWzFTC3TLJuxjJS4d7Mkr2jaAjaAszAs0F8jCqB4b8SacIqExFvX6zjsxwBj0UO1V5s4MP7o/rPB09/lx52mqjk+n3vgKnNlMZby0Jz6eNzFt9mrFFKR/CwHRHoz0xik+r++5t1LxZzlHAkH4+9Ne91iEV7Ah7M680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734701; c=relaxed/simple;
	bh=FhX0FlOnMgUOXgLd59wQh9U7osp32SgwH12eXj0ho8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAEaDzKI4TxgdTSNK32GcCAC3d0Jc/FH4XQoR1/ivsJkZ3KNTdCvEpQsVXol8IvsISnTVtE7v8ZLWKlvhRBNLfU4tfcx4JiAc82DdlZ6mlpwxxTmQW/R33eSdnUpDc54kOmJfe4GaUe0aNdxvvxDybsIqfcadkBhAVjckiQnI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu9AAeUW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu9AAeUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5D2C4AF49;
	Tue, 18 Jun 2024 18:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718734701;
	bh=FhX0FlOnMgUOXgLd59wQh9U7osp32SgwH12eXj0ho8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fu9AAeUWwTeRvtt2JM6jMIciTRKYP/+kxem/o9sGjge4tI6cDVL9JuDRmdkXWUjvO
	 FE0m4jQ759sVN2rvKx3+TwR/0pBlT1i0cBvmuOsDRkaBljXk5rK6aORrGPyH/jRBwu
	 w+tD6OmLtv0CxJZcBJEI8q23Hh0DzzfsAWJbYxHNGvdGD4cR/8fqCgVi18TGcmO7lM
	 p7Cj3vOwXsVrCzzwVZ3ClXe840/Iw6Od1CEYAvLM3iO4n4hfaLUu2saw/99s43fa6K
	 bQYGpdBDRJgSRCZZ4eW3VO1v6IlDmMlVhhUQwpkyuD1WEhld44789a3JPdjxezvpjL
	 tiLJAL/I+k2wQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] mm/damon/sysfs-schemes: remove unnecessary online tuning handling code
Date: Tue, 18 Jun 2024 11:18:04 -0700
Message-Id: <20240618181809.82078-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618181809.82078-1-sj@kernel.org>
References: <20240618181809.82078-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon/sysfs-schemes.c contains code for handling of online DAMON
parameters update edge cases.  The logics are no more necessary since
damon_commit_ctx() and damon_commit_quota_goals() takes care of the
cases.  Remove the unnecessary code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 68 ++--------------------------------------
 1 file changed, 3 insertions(+), 65 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 1bccf2619e11..77c0265dff5c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1912,10 +1912,6 @@ static int damon_sysfs_set_scheme_filters(struct damos *scheme,
 		struct damon_sysfs_scheme_filters *sysfs_filters)
 {
 	int i;
-	struct damos_filter *filter, *next;
-
-	damos_for_each_filter_safe(filter, next, scheme)
-		damos_destroy_filter(filter);
 
 	for (i = 0; i < sysfs_filters->nr; i++) {
 		struct damon_sysfs_scheme_filter *sysfs_filter =
@@ -1955,12 +1951,9 @@ static int damos_sysfs_set_quota_score(
 		struct damos_sysfs_quota_goals *sysfs_goals,
 		struct damos_quota *quota)
 {
-	struct damos_quota_goal *goal, *next;
+	struct damos_quota_goal *goal;
 	int i;
 
-	damos_for_each_quota_goal_safe(goal, next, quota)
-		damos_destroy_quota_goal(goal);
-
 	for (i = 0; i < sysfs_goals->nr; i++) {
 		struct damos_sysfs_quota_goal *sysfs_goal =
 			sysfs_goals->goals_arr[i];
@@ -2091,67 +2084,12 @@ static struct damos *damon_sysfs_mk_scheme(
 	return scheme;
 }
 
-static void damon_sysfs_update_scheme(struct damos *scheme,
-		struct damon_sysfs_scheme *sysfs_scheme)
-{
-	struct damon_sysfs_access_pattern *access_pattern =
-		sysfs_scheme->access_pattern;
-	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
-	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
-	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
-	int err;
-
-	scheme->pattern.min_sz_region = access_pattern->sz->min;
-	scheme->pattern.max_sz_region = access_pattern->sz->max;
-	scheme->pattern.min_nr_accesses = access_pattern->nr_accesses->min;
-	scheme->pattern.max_nr_accesses = access_pattern->nr_accesses->max;
-	scheme->pattern.min_age_region = access_pattern->age->min;
-	scheme->pattern.max_age_region = access_pattern->age->max;
-
-	scheme->action = sysfs_scheme->action;
-	scheme->apply_interval_us = sysfs_scheme->apply_interval_us;
-	scheme->target_nid = sysfs_scheme->target_nid;
-
-	scheme->quota.ms = sysfs_quotas->ms;
-	scheme->quota.sz = sysfs_quotas->sz;
-	scheme->quota.reset_interval = sysfs_quotas->reset_interval_ms;
-	scheme->quota.weight_sz = sysfs_weights->sz;
-	scheme->quota.weight_nr_accesses = sysfs_weights->nr_accesses;
-	scheme->quota.weight_age = sysfs_weights->age;
-
-	err = damos_sysfs_set_quota_score(sysfs_quotas->goals, &scheme->quota);
-	if (err) {
-		damon_destroy_scheme(scheme);
-		return;
-	}
-
-	scheme->wmarks.metric = sysfs_wmarks->metric;
-	scheme->wmarks.interval = sysfs_wmarks->interval_us;
-	scheme->wmarks.high = sysfs_wmarks->high;
-	scheme->wmarks.mid = sysfs_wmarks->mid;
-	scheme->wmarks.low = sysfs_wmarks->low;
-
-	err = damon_sysfs_set_scheme_filters(scheme, sysfs_scheme->filters);
-	if (err)
-		damon_destroy_scheme(scheme);
-}
-
 int damon_sysfs_set_schemes(struct damon_ctx *ctx,
 		struct damon_sysfs_schemes *sysfs_schemes)
 {
-	struct damos *scheme, *next;
-	int i = 0;
-
-	damon_for_each_scheme_safe(scheme, next, ctx) {
-		if (i < sysfs_schemes->nr)
-			damon_sysfs_update_scheme(scheme,
-					sysfs_schemes->schemes_arr[i]);
-		else
-			damon_destroy_scheme(scheme);
-		i++;
-	}
+	int i;
 
-	for (; i < sysfs_schemes->nr; i++) {
+	for (i = 0; i < sysfs_schemes->nr; i++) {
 		struct damos *scheme, *next;
 
 		scheme = damon_sysfs_mk_scheme(sysfs_schemes->schemes_arr[i]);
-- 
2.39.2

