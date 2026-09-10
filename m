Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F448CD54;
	Thu, 10 Sep 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049942; cv=none; b=RErVGnjxY7S7JgmwOEcHfEuwxXajj/SnEunZYWeK37caBDugRSePakwmJHVX3zYInCjAt3J2N4I0y5cuvNCbnSAqDb44ZXOTt+lGKObOrzFXxDhBG8FRUtnoRTWh1vOBjjCSp9+3WA43jJt1fAQygGyaiegDVvQSf2bcgdxjpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049942; c=relaxed/simple;
	bh=9viLNo/cpATQLCGYnUYgc0TT7fNMscirpui8mxLcXDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omlGGDmn7MXWTnR12bMdBXuPJJO8whLmX9uhe+UTIcFQgsaMZv70pbSnC3EAp9Y+MiKzCY8PZ2whAxMmv8MqKEcMdhQoT588rbpfigv9xB5jYW3zEptXbEg1GxyOWKeXHHXQ497YReOAUhDn3u95Z6CZos6jNjytz3jAl93eqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeRVgxyi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeRVgxyi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E98C1F00893;
	Thu, 10 Sep 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049941;
	bh=PWrMrM3f3WHWIPiBc1do7PEyYjGSCGGW8JjOmMYVBv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeRVgxyixHufqqb7P/t2eodGXN/9vTEqu3GKl7K33f+WK9+KgwQtezZTip4wimx5G
	 vyHHRWf1ooGXazAwjYavRcGa/pNX5WqXp5fGtv7sWtDdIYfjwHoG/v5Tw2qFyRH3CT
	 W5khMH+4iC3x3MBnlEyQw8de3MnV8tzfx6vR21OzNegXqn9tZP6wAsY6KBfEX8qSCq
	 nR0fbUoSv7b5+zXRE03mKl/o5OQcim9w3ldTkJ096g6YR4jd3uNZGGwd8s4hDgZbOZ
	 uNNoO3Od/UHfUGbHVhylzoZBDUprdXzpizGc1dx6MH0Uj7cbReCYnOiPsF4m4GB+jh
	 Rb1PgVve+WMQA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Thu, 10 Sep 2026 07:18:43 -0700
Message-ID: <20260910141849.170896-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement probe_hits_wsum DAMOS core filter support in the core layer.
Make three small changes for the support.  First, update
damos_filter_for_ops() to treat probe_hits_wsum filter as core filter.
Second, Update destination damos_filter->range_{min,max} for
probe_hits_wsum type damos filter commits.  Third, extend
damos_filter_match() to handle probe_hits_wsum type filter. Calculate
the weighted sum of the given region and compare it with the given
filter's target weighted sum range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e9630f41e51fe..d9d56f4be1a97 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -658,6 +658,7 @@ bool damos_filter_for_ops(enum damos_filter_type type)
 	switch (type) {
 	case DAMOS_FILTER_TYPE_ADDR:
 	case DAMOS_FILTER_TYPE_TARGET:
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
 		return false;
 	default:
 		break;
@@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
 		dst->sz_range = src->sz_range;
 		break;
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		dst->range_min = src->range_min;
+		dst->range_max = src->range_max;
+		break;
 	default:
 		break;
 	}
@@ -2510,7 +2515,7 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 	bool matched = false;
 	struct damon_target *ti;
 	int target_idx = 0;
-	unsigned long start, end;
+	unsigned long start, end, wsum;
 
 	switch (filter->type) {
 	case DAMOS_FILTER_TYPE_TARGET:
@@ -2545,6 +2550,11 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		damon_split_region_at(t, r, end - r->ar.start);
 		matched = true;
 		break;
+	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		wsum = damon_probe_hits_wsum(r, false, true, ctx);
+		matched = filter->range_min <= wsum &&
+			wsum <= filter->range_max;
+		break;
 	default:
 		return false;
 	}
-- 
2.47.3
