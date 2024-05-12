Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5655C3B;
	Sun, 12 May 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715542625; cv=none; b=lZwQR0ac52SE3gthey4TiGhamaca7xH5Sq/9YHfXl5LQ/vekrKkt9ALbchdpwvOfPkXZMQl3Sebe2kD+fxHyGxgHVUizNdcPQStZALoZtjIcpFln0fB2kuwLnpRrrhfUK3mM08kMn6ikKSYp9nzu9VseZBrj+iboHvy6SyL4GKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715542625; c=relaxed/simple;
	bh=t7+2aKGmVybNoTsNs3UjmFvYLVfl4dPfhLTblMrn/KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJRWURsi/Jm+bi8+8mMo6kRrp1IDGuMKHyC4mjHonK5kBPoVS6w8VTOhjyalx0qQqhbgks/dGMCHABV8GzIixeL5oG6f87PV+8tkS0rlUvRxiFMGQJSqyB9WR6xwk+JrQ5eyJg3UDTQehgrdcGClMU++RXjAUrq21ZYlbjPpzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgPPQHOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgPPQHOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D63C32781;
	Sun, 12 May 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715542624;
	bh=t7+2aKGmVybNoTsNs3UjmFvYLVfl4dPfhLTblMrn/KY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HgPPQHOuTXT6FE4SuvaFzlVnrDo3qPzoUsiD7CoL2rElMRvR+osrfWPN6jSENu3/N
	 S/FQHQk2Rr+NjPrG3a6KPW/EOJJlpItNzFgLnfdOyt8YPV8zlLA7YEME7w8J29SvOd
	 xtAl3JLWQp9TD3ZmaoFxgS30+sh780Kf4SBcjCCsmEyI03JuMEjE2ScLQ6q4X0Kn/D
	 ned+SNZshIE9bsE+wZ7PY3mJz/1uEfojxUiHQj1hKwNpmei3xixA7O3lrv7E0mmM3H
	 4fLoi2EPD8RswWtisl8TDrhMmAcLhdKPIKZdr/0z/0Mk22fJ03z8TLbbB4TfGMa/pM
	 jxFu0+NhhMvkQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC IDEA v2 5/6] mm/damon/acma: implement scale up feature
Date: Sun, 12 May 2024 12:36:56 -0700
Message-Id: <20240512193657.79298-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240512193657.79298-1-sj@kernel.org>
References: <20240512193657.79298-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the memory scale up feature of Access/Contiguity-aware Memory
Auto-scaling module.  It runs DAMOS_FREE action scheme with
user-acceptable level of memory pressure stall as its target, in 512
contig pages base granularity.  For minimizing DAMON-internal
DAMOS_ALLOC-ed region management overhead, the scheme is applied to only
128 MiB not-completely-allocated contiguous memory region of lowest
address.

Note that it does nothing with free_callback() since the host will
notify in-guest use of the page via page fault and return it on demand.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/acma.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 4 deletions(-)

diff --git a/mm/damon/acma.c b/mm/damon/acma.c
index b093b90471dd..32827cbf2fa7 100644
--- a/mm/damon/acma.c
+++ b/mm/damon/acma.c
@@ -54,6 +54,13 @@ module_param(commit_inputs, bool, 0600);
 static unsigned long min_mem_kb __read_mostly;
 module_param(min_mem, ulong, 0600);
 
+/*
+ * Maximum amount of memory to be guaranteed to the system.  In other words,
+ * the upper limit of the scaling.
+ */
+static unsigned long max_mem_kb __read_mostly;
+module_param(max_mem, ulong, 0600);
+
 /*
  * Desired level of memory pressure-stall time in microseconds.
  *
@@ -144,6 +151,11 @@ DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_acma_scale_down_stat,
 		acma_scale_down_tried_regions, acma_scale_down_succ_regions,
 		acma_scale_down_quota_exceeds);
 
+static struct damos_stat damon_acma_scale_up_stat;
+DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_acma_scale_up_stat,
+		acma_scale_up_tried_regions, acma_scale_up_succ_regions,
+		acma_scale_up_quota_exceeds);
+
 static struct damos_access_pattern damon_acma_stub_pattern = {
 	/* Find regions having PAGE_SIZE or larger size */
 	.min_sz_region = PAGE_SIZE,
@@ -164,8 +176,8 @@ static struct damos *damon_acma_new_scheme(
 {
 	struct damos_quota quota = damon_acma_quota;
 
-	/* Use 1/2 of total quota for hot/cold pages sorting */
-	quota.ms = quota.ms / 2;
+	/* Use 1/3 of total quota for hot/cold pages sorting */
+	quota.ms = quota.ms / 3;
 
 	return damon_new_scheme(
 			pattern,
@@ -246,6 +258,36 @@ static int damon_acma_set_scale_down_region_filter(struct damos *scheme)
 	return 0;
 }
 
+/*
+ * Similar to damon_acma_set_scale_down_region_filter() but for scaling up.
+ */
+static int damon_acma_set_scale_up_region_filter(struct damos *scheme)
+{
+	struct damos_filter *filter = damos_new_filter(
+			DAMOS_FILTER_TYPE_ADDR, false);
+	unsigned long start;
+	unsigned long start_limit, end_limit;
+
+	if (!filter)
+		return -ENOMEM;
+
+	/* scale up no above max_mem_kb */
+	start_limit = monitor_region_start;
+	end_limit = start_limit + max_mem_kb * KB;
+
+	/* not-completely-free-ed SCALE_WINDOW region of lowest address */
+	for (start = start_limit; start <= end_limit - SCALE_WINDOW;
+			start += SCALE_WINDOW) {
+		if (damon_alloced_bytes(end - SCALE_WINDOW))
+			break;
+	}
+	filter->addr_range.start = start;
+	filter->addr_range.end = min(end_limit, start + SCALE_WINDOW);
+
+	damos_add_filter(scheme, filter);
+	return 0;
+}
+
 /*
  * Called back from DAMOS for every damos->alloc_order contig pages that
  * just successfully DAMOS_ALLOC-ed.
@@ -307,11 +349,40 @@ static struct damos *damon_acma_new_scale_down_scheme(struct damos *old)
 	return scheme;
 }
 
+/*
+ * Scale up scheme
+ */
+static struct damos *damon_acma_new_scale_up_scheme(void)
+{
+	struct damos_access_pattern pattern = damon_acma_stub_pattern;
+	struct damos *scheme;
+	int err;
+
+	scheme = damon_acma_new_scheme(&pattern, DAMOS_FREE);
+	if (!scheme)
+		return NULL;
+	err = damon_acma_set_scheme_quota(scheme, old,
+			DAMOS_QUOTA_SOME_MEM_PUSI_US);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	scheme->alloc_order = scale_pg_order;
+	scheme->alloc_callback = NULL;
+	err = damon_acma_set_scale_up_region_filter(scale_up_scheme);
+	if (err) {
+		damon_destroy_scheme(scale_down_scheme);
+		return NULL;
+	}
+	return scheme;
+}
+
 static int damon_acma_apply_parameters(void)
 {
 	struct damos *scheme, *reclaim_scheme;
-	struct damos *scale_down_scheme;
+	struct damos *scale_down_scheme, *scale_up_scheme;
 	struct damos *old_reclaim_scheme = NULL, *old_scale_down_scheme = NULL;
+	struct damos *old_scale_up_scheme = NULL;
 	struct damos_quota_goal *goal;
 	int err = 0;
 
@@ -324,7 +395,11 @@ static int damon_acma_apply_parameters(void)
 			old_reclaim_scheme = scheme;
 			continue;
 		}
-		old_scale_down_scheme = scheme;
+		if (!old_scale_down_scheme) {
+			old_scale_down_scheme = scheme;
+			continue;
+		}
+		old_scale_up_scheme = scheme;
 	}
 
 	reclaim_scheme = damon_acma_new_reclaim_scheme(old_reclaim_scheme);
@@ -340,6 +415,14 @@ static int damon_acma_apply_parameters(void)
 	}
 	damon_add_scheme(ctx, scale_down_scheme);
 
+	scale_up_scheme = damon_acma_new_scale_up_scheme(old_scale_up_scheme);
+	if (!scale_up_scheme) {
+		damon_destroy_scheme(scale_down_scheme);
+		damon_destroy_scheme(reclaim_scheme);
+		return -ENOMEM;
+	}
+	damon_add_scheme(ctx, scale_up_scheme);
+
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,
 					&monitor_region_end);
@@ -428,6 +511,9 @@ static int damon_acma_after_aggregation(struct damon_ctx *c)
 		case DAMOS_ALLOC:
 			damon_acma_scale_down_stat = s->stat;
 			break;
+		case DAMOS_FREE:
+			damon_acma_scale_up_stat = s->stat;
+			break;
 		default:
 			break;
 	}
-- 
2.39.2

