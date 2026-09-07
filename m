Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C12384CD6;
	Mon,  7 Sep 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801148; cv=none; b=H/efMwTiPS+Ja+3wp+SGjgG/R6Dnd0aRCnV9z+Cs3N5XDu0biYXta4ZO0YEMHcNKUfVudHMK9xRWP/5aJbahz1fWTYKqZyBeLWqCexxWgGEWCg/NV/GKYdBisAhTgTTKJxeHIx+UlP8hlJWqiG4Y7mLnbb8sh8MwR3EjhXK/s3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801148; c=relaxed/simple;
	bh=Vrm/rC8iyoCJls6/si6QOKjWbYp5ai4d/l+ukMOE65A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsluWbKu2Zi1ojIVEXRLIF+xrhXEORx3RYHNBszvGdO/6+D85I7GbCkP3enJ0seMo/8YWobsgZylaW2mAnOvLgp++zWo4NfmpN4LVaYkL9y+UphlUVVhFhWDgH6EeQNAOEF38AXw84/mOcILjd6OcXZt8V1+oTngkG8z5GKggNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC4AxmPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC4AxmPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552B81F00A3F;
	Mon,  7 Sep 2026 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801146;
	bh=lU6Anck8dGcwHo6Zz1AH/wx0RCbpjIZ1+t8NQz+I98U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kC4AxmPQiOZ3aJ+kyB9vrnbNxo6iJlrY/iUYv1AXldMH4C/fJN36qQrI2ES9RCnXE
	 SQFcvPOjzZlAdzrkPSsR0vsHmP13qCTg/bm8g4IbjuJ6optJOOgxqEIVbFjwScHaJ0
	 GmxsBnmUi8ewFCxfkyiuQ7/2FGOYMF+zaduMew5hsmbZGgP/kuK6oWjbzkHGl19yxU
	 uJu9HlasDNMRUoxYy3G1mU6wL/ttmYQyoIxLNjyW4OswjL2/lZDFxNaTN4Gr2npOBk
	 c6BFdAAbvggDGBZ7v/TOEMJ1ovF+cnMCo1UODwHrVWVH0ZlV5a7c0mUgB5/QxiiIkg
	 34yqqnFgQwzvQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Mon,  7 Sep 2026 10:12:12 -0700
Message-ID: <20260907171218.101430-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171218.101430-1-sj@kernel.org>
References: <20260907171218.101430-1-sj@kernel.org>
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
index 30af5bbcc90e7..98efc6e2876f4 100644
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
