Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD623414411;
	Fri, 11 Sep 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134920; cv=none; b=ojycao06ZgvXdsopDI4+/pKqQIiEzVNVu/Z22C9jpEwhigTlvwtiwee+Pqh6+z23hdEsH4bLFcXDbAIQ1ihU9o2peZSwQZQNW2bmFhSk7laz3vFGmNEVEoZpHe1mVV4e8l3BGsW6T8c8IT5/nzn/uS0HYcCRkjbd+D/S7wAIyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134920; c=relaxed/simple;
	bh=/s5M0my2VRrF4bdGS8mHHWAW5UTy+skM6R6wa2GBleg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrWq0M9GtdNSordKbYaPKsjfDluRebDQsLuHRdcEAakxk1rvpo3qzPnM2uAlOFIZK99w/kq0QXVYg8WonzfseNiyQQ08YqkNLY8/HaH4Kg4jd4F6zD8Gv0T+kexV4Q1+cp8j9OkiGtC+uMWUz+M5TYLjTCQAK78UY+ur96BxiTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnxXKJyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnxXKJyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBF91F00899;
	Fri, 11 Sep 2026 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134919;
	bh=b57SpIkbZ6AMBsE6RM4G3dlGWMR1DXMsNf+oP0yvVfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VnxXKJyl5okYWsrJhnqQEEBR9G8H3GRrfqpJUyQQgtxJDYX9QWY5qajMHsnjOFdXz
	 4nwiKhr96HV4iMtCX9a7Z7NukPanS6dkcRWjrOla2EPvF3JuspFqZ0Uv8rL5TyzsrX
	 3+SK7mBxkmNxqsCrUCYYO9jX0FqPOYBEQh9RpTHjLDfjUqkoK+tgOfLXSi5I1tPfvR
	 fkhmoEMXqOtO93NEp37Nk2EfNuZom0GvVyWrW2HlSPan77enuGebbBxV8HLZiLHNDy
	 4r9nhSHYiPZfdqFPX40447510SWhWgILFZcCEgWCaITW9UdR67uPv3PJmVGulvbiU1
	 /lBYDRCJosivA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Fri, 11 Sep 2026 06:55:05 -0700
Message-ID: <20260911135510.96914-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
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
