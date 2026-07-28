Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6AF3B3895;
	Tue, 28 Jul 2026 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216500; cv=none; b=YIMKGpt1hfmajJdo2hgfEz3ZjGs0Cjz1GlMpl27RZ5iMA0v8nFUF1zP/j0Eu/M2nTCQNkkj5IKkWwpWMnfSV5wqgjALUguURmuuNRnSA/i186LC4egN0k4Zw4INkmtzrrZtuFGmVunaPouRBdj/nZ13JwRhp+4zHswCBOUISwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216500; c=relaxed/simple;
	bh=Ph4tfwVfbDdj+VSVpAPJTNe1BWDH3/wXUYB+lenMBpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiY52UUzGtKqwald2npZFjysyutHREvIDtL39H2hhBxY18D63LqlbCevMT6f20OphPDbhxLgzIgYNgb/hIT5il00wO08JzZLb9ASKAQrqiakG9ht3HUh7NJw+lydsuQg5xKVg1m+7khahG+Ad3mw2UrSOhKQPMOaAe7KwK+3ROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2dGFUnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2dGFUnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72131F00ACA;
	Tue, 28 Jul 2026 05:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216498;
	bh=69vkU0D1ZC9y76VW8fWIr/5QR0D00VAs0a00zXjnW44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V2dGFUnX32iH54X59LjRu3KD43H08ytdjfiq+W5IUFp+yIkbUrYs1F2dfRnIE8BRQ
	 Iu52W7c30k2K/2h5/Xh4ad7jBJutRyAtzYrrZr8zlSzC95R6NQ9o/FOs4mp56nnIw5
	 B7oYHEj2YhBHmZoJcN0Q88Dzzu0+CpeKBSI8z9J3UqJQ/6JQ2jkKens0bs+0JktGRl
	 7clUKJP6ZebDV3pHXLd9+V9AP2sHhWkuSS/ELDpki0GFjQyQWfp4n36Z7vWW/OAlwo
	 utdNUJ+RcKkr40FZ/BjP+1R6sseXmqBZbKhEzOyCJRhWE4RdngTUCA2nzBCVJynYA7
	 8/QKsaoI7XWQQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/10] mm/damon/tests/core-kunit: test overlapping ranges for set_regions()
Date: Mon, 27 Jul 2026 22:28:05 -0700
Message-ID: <20260728052811.192712-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728052811.192712-1-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 954157679ec3 ("mm/damon/core: disallow overlapping input ranges
for damon_set_regions()") disallowed passing overlapping input ranges to
damon_set_regions().  Add a kunit test case for the overlapping input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ac15393a7935b..3041b8288ec26 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -606,6 +606,17 @@ static void damon_test_set_regions(struct kunit *test)
 			{.start = 42, .end = 21},
 			}, 1, 1,
 			(struct damon_addr_range[]){}, 0, -EINVAL);
+	/*
+	 * Regions resulting in same region after alingment should return
+	 * -EINVAL.
+	 */
+	damon_test_set_regions_for(test,
+			(struct damon_addr_range[]){}, 0,
+			(struct damon_addr_range[]){
+			{.start = 10, .end = 20},
+			{.start = 20, .end = 30},
+			}, 2, 4096,
+			(struct damon_addr_range[]){}, 0, -EINVAL);
 }
 
 static void damon_test_update_monitoring_result(struct kunit *test)
-- 
2.47.3
