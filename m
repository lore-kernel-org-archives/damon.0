Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2019D880;
	Thu,  9 Jan 2025 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445100; cv=none; b=buLOnrCYYyntYQtAKFvovSmtztDDBYjqK2clZRHTQ5wPGOVv2yWAbQV1715VwtNTzJo8NhVp/IP6LmcYEAc8vWo2bfG3LkolYvLwWvATyQ5j96/RiNUnxk18ztCMDAHzS9E7BlgHZse8jY6ldBKp1cJeHFRrTwDz/ZD1jg271o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445100; c=relaxed/simple;
	bh=/TwzvHzsYhMLVRMAly61w18SuFtGS0e8DIve8swoAg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/S7m2Hd22b+ansYdLLPQNWZbP+m4PnEWVOCkKN/kjFbeaRCVO6ej4e7t+xlwwD17QUn4iECCFo7hUKD7yAAWdf6+EZ3VQSPZezgKUOE9uBBDSFDHny8mTIE2rde1XXyjyPf9ddnnk1QRLqehBTFbtKEM9/7AZUi/Uv6CctZBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOiV8xN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOiV8xN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EFEC4CEE1;
	Thu,  9 Jan 2025 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736445100;
	bh=/TwzvHzsYhMLVRMAly61w18SuFtGS0e8DIve8swoAg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOiV8xN+tOzd6OhWGwRDcbApXOwx2OoSQwcl1ajO5uMihuqIeFetDPj9kO1jvRZI3
	 DCaVH7i0rTdMfXF9gctFxlGeo8ihHqNWZs0nADBR6YSrMd36r0n6p36YB1MuIFuRj1
	 /BMQS++22T1gOsjeEneFIB8/06l2tUcaCx5/BajT7ICW4t09cZsy+uQeu0Qyvjz7dx
	 f8LNV/bZ+JLSt8fXU5hvrmJCT+A44RSIA0A4g8SuUGaxAAUCZaDwk07W+nPkt1v+gB
	 qK+y9hp3bWU2vsD48OucJ/zTxW2Lmn30O1QwshQ0saR9Kd3SnNh47BIjxCa+9Mev5e
	 F095E2SrYdR5A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 03/10] mm/damon/core: support damos_filter->allow
Date: Thu,  9 Jan 2025 09:51:19 -0800
Message-Id: <20250109175126.57878-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109175126.57878-1-sj@kernel.org>
References: <20250109175126.57878-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters supports allowing behavior, but the core layer's DAMOS
filters handling logic still assumes only rejecting (filtering-out)
behavior.  Update the logic to aware of and respect the behavioral
decision by reading damos_filter->allow when making the decision to
exclude a region or not.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             |  6 +++---
 mm/damon/tests/core-kunit.h | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bdde532ebbc8..76707b0635d6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1374,7 +1374,7 @@ static void damos_update_stat(struct damos *s,
 	s->stat.sz_ops_filter_passed += sz_ops_filter_passed;
 }
 
-static bool __damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
+static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter)
 {
 	bool matched = false;
@@ -1428,8 +1428,8 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, s) {
-		if (__damos_filter_out(ctx, t, r, filter))
-			return true;
+		if (damos_filter_match(ctx, t, r, filter))
+			return !filter->allow;
 	}
 	return false;
 }
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index cf22e09a3507..8f58d3424c21 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -434,25 +434,25 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 2;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = DAMON_MIN_REGION * 6;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 4;
-	KUNIT_EXPECT_FALSE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
@@ -465,7 +465,7 @@ static void damos_test_filter_out(struct kunit *test)
 	/* region started in the range */
 	r->ar.start = DAMON_MIN_REGION * 2;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_TRUE(test, __damos_filter_out(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
-- 
2.39.5
