Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51C82F8EA6;
	Thu, 25 Jun 2026 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364094; cv=none; b=SOy8IDRBCiv/qy9yaXcyjXCr8aD7wr5OVUSnjXw6jutpMQxXJeVzz1CE+5PtulbvQ+tJfOawE8VwOw5TMEDIQc2XYisDVdY5bcgJZL1Zxi1mNAckx4atirSmDmW/ivzDMFp5Dura+VOjS+f4ehbwtXQYbUb5L0KLlwCq3wK/6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364094; c=relaxed/simple;
	bh=anVu4aGE0ztLPrsxchKRN6Kggp9WONRXep9H7QzzwPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCIDkU0MHQoCKv3lM80ulE26kOo+gMN11y81T6eR22uVctZmoKK1VXsng9I/zgFR9cVycY/yORioEuFCFe5CPIvY7cahoXQXWj7Q+q3qQn+pM5Li7pxFONsyN+3pEDExzYUamre+kWH5NkL4c/MlgueM1anNHLQJSxHXI25gx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG3xyDlc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG3xyDlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F371F000E9;
	Thu, 25 Jun 2026 05:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364093;
	bh=fNLgK6VekKiqsNObBDFES+rnS20A7718psQePgY2aCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eG3xyDlcLCX5iTF+RmzsKyzT/t18Va9zOOOyuC04ZIolNSfwAFLNCPMYHpHc11ktM
	 +CBBox/OdM5o1FQd7n/gCbUuxZ0Mu3xLpWzBS1csm/tNOhRCjxifUU3ApwZPorEsRE
	 wGhF5Z4IFnZ0oia+V250IH0B0FIYEKl/uZrrA5Pm3wTittwig+tbzTmmpVojuvd+tE
	 9D4fnpFTAstiD8B6ZdLnr5DjxdBlZv5vfKsAFws04ZnWHfsgSVqfIF4+pvhyFeHyzl
	 ekSLntcYb35BqUIsO1uod9NcqqFMb6HGEp3jpWWZURJb8YoJv+jNHFchtVNeMWK0sZ
	 Q9liXI9Jdz06g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Wed, 24 Jun 2026 22:07:46 -0700
Message-ID: <20260625050756.91115-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9012c4e647df ("mm/damon: replace damon_rand() with a per-ctx
lockless PRNG") optimized DAMON for better performance.  Add a kunit
test for ensuring the pseudo randomness quality.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 1cfb8c176b873..756f3b9e2ed3b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1460,6 +1460,26 @@ static void damon_test_is_last_region(struct kunit *test)
 	damon_free_target(t);
 }
 
+static void damon_test_rand(struct kunit *test)
+{
+	struct damon_ctx ctx;
+	int counts[10] = {};
+	int i;
+
+	prandom_seed_state(&ctx.rnd_state, get_random_u64());
+	for (i = 0; i < 10000; i++) {
+		unsigned long rnd = damon_rand(&ctx, 0, 10);
+
+		KUNIT_EXPECT_GE(test, rnd, 0);
+		KUNIT_EXPECT_LE(test, rnd, 9);
+		counts[rnd]++;
+	}
+	for (i = 0; i < 10; i++) {
+		KUNIT_EXPECT_GE(test, counts[i], 900);
+		KUNIT_EXPECT_LE(test, counts[i], 1100);
+	}
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1489,6 +1509,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
+	KUNIT_CASE(damon_test_rand),
 	{},
 };
 
-- 
2.47.3
