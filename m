Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A303644A2;
	Thu, 25 Jun 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397483; cv=none; b=KqgAm/uRYu6ySJexOHzAeIEG0dtdpL4CTLCTLvPHTkB+JKvjeupCjRfPq7ETMWrueTp2Yz0o2z2wOJHmJm7728xXIyJMqyqxQYuFNsDX5dx82Biut/uoDRexdGTEpejO4CdpvGMnAKo5LIsVlil9zIDmAIJulWgBzI+5DPKy1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397483; c=relaxed/simple;
	bh=23dDG2LxMLdWthQFd/idibL4PqE/amPFLAPjiZeibZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhw8RIjkobjO9C2SjatMutepjK3Av0Xkq0ZHEIhD6P5u8HoOlevcAtP3Ic+Jud9F+L35BQlEl5WmqVxxamxML8u0fO9V9+MEVWhHYv6oCS8P8jRBNn+6TBlTusv6tiy3PO3EcC+d8SO+bSloo9fDfdmR0LNAnjlHmbu7F4Gm/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmhtcTjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmhtcTjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE61F00A3F;
	Thu, 25 Jun 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397482;
	bh=Tg2jmDMliQWq/p4UiCF6FYRtQk7AyMDI0guNB97ZZdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nmhtcTjntOUk+GVd/GfKi40OpFXwJThGcv2dCmao/FoMUpdHYTbjgQuae+KDJgvsA
	 77ud0y9bYni6U61DzFx18SC7GA8e/ky8Oh5UxIKc3BxAIkCmrJNm7dlubHHrhngVih
	 s9IlZ3GcPv765b5zQTMU9rWRamkTWFsc5/RE+EmiVfRhJoT44W+10eqhIPw8z4AQLa
	 GKyHDB8CgjWrlLnto5JKzpONAw/WOI+v2SZ7oCa2pXEIVjStFMS644HFtrQzUVCtZk
	 DVMRxlQ9DRh79hiqK4sA4/R9D/dMBiBjgNJhiY556tKOw8JZYjIKyTQDmtc82fCdKd
	 luiK0uUG7Rgyw==
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
Subject: [RFC PATCH v1.2 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Thu, 25 Jun 2026 07:23:48 -0700
Message-ID: <20260625142357.103500-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9012c4e647df ("mm/damon: replace damon_rand() with a per-ctx
lockless PRNG") optimized DAMON for better performance.  Add a kunit
test for ensuring the bounds of the output.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 1cfb8c176b873..eec7cb325a431 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1460,6 +1460,22 @@ static void damon_test_is_last_region(struct kunit *test)
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
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1489,6 +1505,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
+	KUNIT_CASE(damon_test_rand),
 	{},
 };
 
-- 
2.47.3
