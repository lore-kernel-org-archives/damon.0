Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACA3148D0;
	Tue,  6 Oct 2026 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269544; cv=none; b=WwbucnLIGQQdUS/XdHBih6aRH9LeKF0kEhTAvmap2nOUzpdAoL550t/+Q81UdaN6y1DkNo3SOrpmwRVYpDgPbELYzx8+bO6h3UEu2T4AcLigYRBsgFp81Fej96BuhfwAvFpHXNr4i9P+F4vBidiFnJZE/WOipn0kb+dnEXN4Ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269544; c=relaxed/simple;
	bh=cH2iy17nRBP8fZpCc2DJJThfpmo6fVFYJvV2pXrc0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbvLT4MfK7a+QTuHTgmOIXcoNi2GksFRk6AvN9LT6DfL+SVRPa0RlqFXklfeyC2JF/obvYo0qBHnEf0K7n1u+ORawMnhRQS4XEP52KmRIieI1itYghut2OBKdLR1xu5V2DgSyTm+vv2SWYyglJTmfVarfRc5OCTN+nM8fDhW2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLYKtt2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLYKtt2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7356E1F00898;
	Tue,  6 Oct 2026 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269542;
	bh=oPGhPEdn4k02nRhaGV+54+OxW9Un+YDg3dsLDCMry2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLYKtt2oNmQNaZG3Zsk4SNTtQhqBFDGvvm7AVt8J427Ty4skLLe1nE7LoVfTAbt+F
	 T3ST74NAWPg3JbcNvLOZSOzVUn+YdxInLCPL9CkDpie8PvhCQDoroOhdjZgn2CPVBW
	 ux7IhrdwsQG3Rzr8lgw5IjVfnICQRjPiU46i1a59XEe8jPYAjHTNbPMqQkQoLqDMIt
	 1ewq/VMcGJwym2/pZ1TVpFnozve+g4JYqK1LpIyEm6MK2zAwnRfG4ze+Hot/ls/Vrt
	 hgUzDMU3SdBUv2c04KQeU0eFEcPnthNITOjOcwN/t5rG253JREwkbNQ28t1dsmDx5P
	 QFaLqqMZhMlRw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Mon,  5 Oct 2026 23:52:07 -0700
Message-ID: <20261006065209.41507-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006065209.41507-1-sj@kernel.org>
References: <20261006065209.41507-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
region") fixed a minor bug.

Add a KUnit test case to cover this behavior and prevent regressions in
the future.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v3
- v3: https://lore.kernel.org/20260927175159.60703-1-aethernet65535@gmail.com
- Collect R-b: from SJ.
- Rebase to the latest mm-new.
Changes from v2:
- v2: https://lore.kernel.org/damon/20260925045350.66595-1-aethernet65535@gmail.com
- Change the commit message, mention the fix rather than the original
  bug.
Changes from v1 RESEND:
- v1 RESEND: https://lore.kernel.org/damon/20260919080453.628679-1-aethernet65535@gmail.com
- Drop braces for single line, as suggested [1] in coding-style.
- Set min_region_sz initial value to power-of-2 value, '1'.
Changes from v1:
- v1: https://lore.kernel.org/damon/20260831113735.3349-1-aethernet65535@gmail.com
- Resend since the dependent patch is merged into mm-new, that would
  help us getting AI review help.

 mm/damon/tests/core-kunit.h | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index ef146ca2ae8a..3fbb4e4e36fa 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2439,6 +2439,47 @@ static void damos_test_esz_goal_temporal(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damon_test_last_region_quota_reset(struct kunit *test)
+{
+	struct damos s = {0};
+	struct damon_target *t;
+	struct damon_region *r1, *r2;
+	unsigned long min_region_sz = 1;
+	bool skipped;
+
+	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+
+	r1 = damon_new_region(0, 100);
+	if (!r1) {
+		damon_free_target(t);
+		kunit_skip(test, "region 1 alloc fail");
+	}
+	damon_add_region(r1, t);
+
+	r2 = damon_new_region(100, 200);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "region 2 alloc fail");
+	}
+	damon_add_region(r2, t);
+
+	s.quota.charge_target_from = t;
+	s.quota.charge_addr_from = r1->ar.end;
+
+	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
+
+	/* 'r2' is not processed, it should not skip */
+	KUNIT_EXPECT_EQ(test, skipped, false);
+
+	/* 'r2' is last region, it should reset charge_{target,addr}_from */
+	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
+	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
+
+	damon_free_target(t);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2482,6 +2523,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
 	KUNIT_CASE(damos_test_esz_goal_temporal),
+	KUNIT_CASE(damon_test_last_region_quota_reset),
 	{},
 };
 
-- 
2.47.3
