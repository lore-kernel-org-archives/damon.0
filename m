Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F436E46C;
	Thu, 10 Sep 2026 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013009; cv=none; b=u+Qow+vqI8NpDVjDmtBB1HARKduiWEy7NWu+d3Bw9/DitgRbuEcod5j0GLsBXr/Ia4rsNqqnl/FMRUCG5LzpjpfEjNi3/JlBR2zQVUkSlUL6dKeGd2ppALPpFF4jQq9vnQwbGLaCPkWSe9pwhhis+D52k43p0/S59H61wDEudxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013009; c=relaxed/simple;
	bh=/s5M0my2VRrF4bdGS8mHHWAW5UTy+skM6R6wa2GBleg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGwpFir9g11jhFdfd2JRjs8+vt24uE49m9iamgE0t2brF80zQCscuYOa5mtyn1a86qQxTEGyAc1NHAtTfywqhZMN/D6mUpTWrbKyrkGNu0zUthmfxIqcFgL/9PTFjB1RE/phF7ShiDJahmH5tTpmdSrHZiFq/JkaUEVPUeiNBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuAe1Q0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuAe1Q0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1A51F0089A;
	Thu, 10 Sep 2026 04:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013008;
	bh=b57SpIkbZ6AMBsE6RM4G3dlGWMR1DXMsNf+oP0yvVfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iuAe1Q0YUHJimYcpz18LK6OjYduQt4A9/RkIC4nCX5SUrQ/xXI1A5ah8/fTFhs2nv
	 qSCIGjcGC/gtG7gBvdVZO6/Z2I3ZnvCz5FINszIOgN/QC3r7x4goXa5Gfz7yAZoB3s
	 dFsPQ3qFss+48nKU1mbn5RBBe8m+0KcYTVNV2myFIxKzLNpi2uY55MX887aWyAn0ef
	 loW/QBfP4RckCvfZsyhnIi6F40Pl1X8aCAVAtraGZsizCn0ZPMO65FDaEQ6KJOdD7Q
	 OktxLiAbHM5nL95lPb8v+6/BKUx/WqeuZX1qar8Z2xhwe0RaOHXO4yuGf3Zo8jtH6d
	 2IM4hAdMjfveA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Wed,  9 Sep 2026 21:03:14 -0700
Message-ID: <20260910040319.147037-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040319.147037-1-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
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
index 50e0f9407db2b..0c98f7e267d07 100644
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
