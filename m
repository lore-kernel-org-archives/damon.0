Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424D26A1B6;
	Wed, 26 Feb 2025 06:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551818; cv=none; b=Z9KBaZgNot2VgN0keT2tGWs2dJcBDsbVumpBKDRTiBbOu5SXBYEgTeBg1UUUpHZlgsOqsl/gidm5ELbkguLSz+18thnP/oPNMbm/PPAN3iGUmw9vZvSgcf0o7gHTJK3GKt6aXlvPIyI1ydbvvki2yfcJkrYDqNjACe9ZoYdvzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551818; c=relaxed/simple;
	bh=43qAgqvlrGuT5QCdJ6rPL+omeoO3HK7C7mVfbHXX3rQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AAaFXp8Pyt2s5J8eIZ/ML8GnrzV1IdtxE8b8yNwpXiWlTpy1NyAJAMgd33rzo9+iHCA0q71IcoGcwbNgOFu32bhZsyNTmkXa6bp4KYX83Z+eK6HZovd8d4AtvWu9NqEYrL1lEyNGLk3tdV1g07aEB9Krg/9c+3PQW7GyWGyOt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4OrK71w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4OrK71w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23684C4CEEA;
	Wed, 26 Feb 2025 06:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551818;
	bh=43qAgqvlrGuT5QCdJ6rPL+omeoO3HK7C7mVfbHXX3rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4OrK71wA49aXqNHD0dgxHKUbfmC0RMtGyCLCaB6W3Eyv4rKbWxPGCoR1QCw0SNg9
	 hjHvjPnTQAqPS3kKuYHaXiKVTPYlH1ij1VFFgXXiSPsfrzOJ2suCfPduH0d6nzK20g
	 hBBC+6wchQZVwWHdiszEe/DQwIcEXs/YKGslXcd0k2jL3BXRBtBC8LPDS778Vr6lvY
	 kazGYDDVN7rsJKJ6BEtfvgINPlqmFKOoMkaq3G+lbsyOlwAlRx1jE4kS66PMnFypWU
	 Xm9TfZgjYCUQ4B+nYySeAzTOQb3myWea8idoUNYg+f77E66mcHOWHMf7O+H2UXCwO+
	 EVNsmFbEdpE4A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 03/13] mm/damon/core: make damon_set_attrs() be safe to be called from damon_call()
Date: Tue, 25 Feb 2025 22:36:41 -0800
Message-Id: <20250226063651.513178-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently all DAMON kernel API callers do online DAMON parameters commit
from damon_callback->after_aggregation because only those are safe place
to call the DAMON monitoring attributes update function, namely
damon_set_attrs().

Because damon_callback hooks provides no synchronization, the callers
works in asynchronous ways or implement their own inefficient and
complicated synchronization mechanisms.  It also means online DAMON
parameters commit can take up to one aggregation interval.  On large
systems having long aggregation intervals, that can be too slow.  The
synchronization can be done in more efficient and simple way while
removing the latency constraint if it can be done using damon_call().

The fact that damon_call() can be executed in the middle of the
aggregation makes damon_set_attrs() unsafe to be called from it, though.
Two real problems can occur in the case.  First, converting the not yet
completely aggregated nr_accesses for new user-set intervals can
arguably degrade the accuracy or at least make the logic complicated.
Second, kdamond_reset_aggregated() will not be called after the
monitoring results update, so next aggregation starts from unclean
state.  This can result in inconsistent and unexpected nr_accesses.

Make it safe as follows.  Catch the middle-of-the-aggregation case from
damon_set_attrs() and pass the information to nr_accesses conversion
logic.  The logic works as before if this is not the case (called after
the current aggregation is completed).  If not, it drops the nr_accesses
information that so far aggregated, and make the status same to the
beginning of this aggregation, but as if the last aggregation was ran
with the updated sampling/aggregation intervals.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             | 38 ++++++++++++++++++++++++++-----------
 mm/damon/tests/core-kunit.h |  6 +++---
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0578e89dff13..5b807caaec95 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -602,11 +602,25 @@ static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 }
 
 static void damon_update_monitoring_result(struct damon_region *r,
-		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
+		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs,
+		bool aggregating)
 {
-	r->nr_accesses = damon_nr_accesses_for_new_attrs(r->nr_accesses,
-			old_attrs, new_attrs);
-	r->nr_accesses_bp = r->nr_accesses * 10000;
+	if (!aggregating) {
+		r->nr_accesses = damon_nr_accesses_for_new_attrs(
+				r->nr_accesses, old_attrs, new_attrs);
+		r->nr_accesses_bp = r->nr_accesses * 10000;
+	} else {
+		/*
+		 * if this is called in the middle of the aggregation, reset
+		 * the aggregations we made so far for this aggregation
+		 * interval.  In other words, make the status like
+		 * kdamond_reset_aggregated() is called.
+		 */
+		r->last_nr_accesses = damon_nr_accesses_for_new_attrs(
+				r->last_nr_accesses, old_attrs, new_attrs);
+		r->nr_accesses_bp = r->last_nr_accesses * 10000;
+		r->nr_accesses = 0;
+	}
 	r->age = damon_age_for_new_attrs(r->age, old_attrs, new_attrs);
 }
 
@@ -619,7 +633,7 @@ static void damon_update_monitoring_result(struct damon_region *r,
  * ->nr_accesses and ->age of given damon_ctx's regions for new damon_attrs.
  */
 static void damon_update_monitoring_results(struct damon_ctx *ctx,
-		struct damon_attrs *new_attrs)
+		struct damon_attrs *new_attrs, bool aggregating)
 {
 	struct damon_attrs *old_attrs = &ctx->attrs;
 	struct damon_target *t;
@@ -634,7 +648,7 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
 	damon_for_each_target(t, ctx)
 		damon_for_each_region(r, t)
 			damon_update_monitoring_result(
-					r, old_attrs, new_attrs);
+					r, old_attrs, new_attrs, aggregating);
 }
 
 /*
@@ -661,10 +675,10 @@ static bool damon_valid_intervals_goal(struct damon_attrs *attrs)
  * @ctx:		monitoring context
  * @attrs:		monitoring attributes
  *
- * This function should be called while the kdamond is not running, or an
- * access check results aggregation is not ongoing (e.g., from
- * &struct damon_callback->after_aggregation or
- * &struct damon_callback->after_wmarks_check callbacks).
+ * This function should be called while the kdamond is not running, an access
+ * check results aggregation is not ongoing (e.g., from &struct
+ * damon_callback->after_aggregation or &struct
+ * damon_callback->after_wmarks_check callbacks), or from damon_call().
  *
  * Every time interval is in micro-seconds.
  *
@@ -675,6 +689,8 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	unsigned long sample_interval = attrs->sample_interval ?
 		attrs->sample_interval : 1;
 	struct damos *s;
+	bool aggregating = ctx->passed_sample_intervals <
+		ctx->next_aggregation_sis;
 
 	if (!damon_valid_intervals_goal(attrs))
 		return -EINVAL;
@@ -695,7 +711,7 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
 		attrs->ops_update_interval / sample_interval;
 
-	damon_update_monitoring_results(ctx, attrs);
+	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
 
 	damon_for_each_scheme(s, ctx)
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 532c6a6f21f9..be0fea9ee5fc 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -348,19 +348,19 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 100, .aggr_interval = 10000,};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 15);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 1, .aggr_interval = 1000};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 2);
 
 	new_attrs = (struct damon_attrs){
 		.sample_interval = 1, .aggr_interval = 100};
-	damon_update_monitoring_result(r, &old_attrs, &new_attrs);
+	damon_update_monitoring_result(r, &old_attrs, &new_attrs, false);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 150);
 	KUNIT_EXPECT_EQ(test, r->age, 20);
 
-- 
2.39.5
