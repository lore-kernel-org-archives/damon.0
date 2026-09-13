Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C33353A85;
	Sun, 13 Sep 2026 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319837; cv=none; b=Ar4fKFWCrd0OnkgyUjJ5uAHIMhMfvcSBU4G+kcyXMyTHf5I7gOV/Lln7k2j2cFpjzQk/vPvPi4vNELmN+5F/5OYqK5zOxDtETVTuLIH2AzM1cp8DiVLVaf5DnKDcAlFjHIfSfppuXt+anBqp95tVfK1rs8+ffHmFHaOlc7AF2mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319837; c=relaxed/simple;
	bh=1TQB/zd3/cakG4J9zdL3sTQwr6f7ClpMOfdh91yRlBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx6FH+b6v29TqBKOqufBBNRWlUfRQi2GzbKe15qivetBKTBuLGXzXfQ/zXnt1GFIL25sxHTxu9kipWl/GBqPTYLR/sBOpNslN+sNEGYHlZoWn4jrZrCE8ADifJCSAiVJRsvJOOWjWQDi76fakjAhfsOq0cXmoUT9ZZWFiLT/bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQjBiGLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQjBiGLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFFB1F0089B;
	Sun, 13 Sep 2026 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319836;
	bh=Af0P/XKXdgAAzkHEeahdC79McKW/w8Lwx3TN8N0HP1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQjBiGLPWEvT7nWrogYH8mpKAIP66m2WtYqxhrebNUTe7XEeut+RvP0LoZp5EFyZ+
	 ZZhH+ilUbK3eVLqxzuUX6tidBcAbd/GhIY+1dUGldEVL3suAkq/yQg7EMJRHvye7y+
	 3wy68lbNFrITT5HzMPwjJeuSd0TCy5Xs8ob/LQ91PeSSM+y4kb0O6NP8yN1KycTAnk
	 nN2lKSF6pyntZEHu/OhG/vKSILHt42lCxIdQxryBStGzWE8+na+afloRquZIUi7pRt
	 fQlvkS0nia4PflJPcUfOag6Qs7PfDoWPZOt776ioSL2vbO/9XAwn+lRDOnwVa2Lddq
	 NrdcaFohSG4DQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 4/8] mm/damon/core: disallow max < min damos filter range arguments commit
Date: Sun, 13 Sep 2026 10:17:01 -0700
Message-ID: <20260913171706.103052-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171706.103052-1-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_filter_arg() receives range arguments for a few types of
DAMOS filters.  It allows any range including max < min range.  It is
fine for the logic, but makes no sense to support it.  Actually DAMON
sysfs interface is doing the validation on its own.  To avoid duplicated
validations in multiple DAMON API callers, it would be better to do the
validation in the core layer.  Add a validation of the given range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ea7d8d5a4abf6..5212bfb8f85f2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1325,15 +1325,21 @@ static int damos_commit_filter_arg(
 		dst->memcg_id = src->memcg_id;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
+		if (src->addr_range.end < src->addr_range.start)
+			return -EINVAL;
 		dst->addr_range = src->addr_range;
 		break;
 	case DAMOS_FILTER_TYPE_TARGET:
 		dst->target_idx = src->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (src->sz_range.max < src->sz_range.min)
+			return -EINVAL;
 		dst->sz_range = src->sz_range;
 		break;
 	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
+		if (src->range_max < src->range_min)
+			return -EINVAL;
 		dst->range_min = src->range_min;
 		dst->range_max = src->range_max;
 		break;
-- 
2.47.3
