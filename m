Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE437EFE2;
	Sat, 12 Sep 2026 19:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240698; cv=none; b=P2ueiGyo4DyUyG88pRx3Mk03BH1mGu98FPN7LQar3lf8ztYIr7LKrHjfNfgGxx672G/3yYS8Vfz2UZmBWfWUdXlCNbj1eUzaW28+zrUTAtPwcBtaqDV06o2x5v2NDnjcvie2EuF+h+2XS9ZO+ihUsQjVlyByTJ8TrQb0LJklsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240698; c=relaxed/simple;
	bh=6h3GJnIwfR+wAmW138+iTOVPy0JzFMMNyZ+vHGhSeTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDEEAwV9Yznds8Ear3U5PXS2drDfNg8dc3JwggTgeaDzpUzrsPwhz4KVThrLoVKvgYkfrhm9SE90X1Ccn0OdfT3p3J/pVnaBgpvSUwB8km5S44voLiQ2YI7T/Pg5PiRjq6qYbld5QJu2ROoJCMPIDiyWhRNieDqh0oQ8BrO5mWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSDnYgil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSDnYgil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A3F1F0089B;
	Sat, 12 Sep 2026 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240696;
	bh=I5maU5zzmZHDxR2AzfaTKL3DQf78nhgNoQRlzVqJW+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YSDnYgil9MBGd5k4BYAZLCJOj9+ScoGA7iOy1ENZ2EvV1HQxJKVh3ZYcGuLQw+gPX
	 17X6y/h6zrIyGk6scu9KMcNCvh3IzV7xnRnNvFiX5r33B9qn72XXz5YKQX5Du0Thc3
	 RnbzbpyZZIjP0KnqDnZT6RtICn3w8COslSAngr0T6nX4bI6og3IhXk7Sb8WHc8IcRk
	 SF2qVg2ZW3bXaGs9eVBP8ooUisap4kWv+5Ixwo67THw1A/wjhkui2sdfgtKF2kYO1u
	 YZXtA8J+nzq0KsDcZulZsowyGvU9ZItY/la65zwfxvjtf/5XfPGziZVQzlChH2nZT5
	 FD42pwaD2QfFg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/8] mm/damon/core: disallow max < min damos filter range arguments commit
Date: Sat, 12 Sep 2026 12:18:02 -0700
Message-ID: <20260912191807.138502-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912191807.138502-1-sj@kernel.org>
References: <20260912191807.138502-1-sj@kernel.org>
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
index 3ad1fb2f21f3f..3dec1a8f7ed3a 100644
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
