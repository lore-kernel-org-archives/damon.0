Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFE3C1085;
	Wed, 24 Jun 2026 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310828; cv=none; b=bCDK6PcDMJ/xTqaAFJdQI2Ip0R+zYuQWj5bwmY6LXGBfMKWD4RVob77NT3UlRBLE2vnDDr4b3KKYJAciXpqkUUCk9E/6XcnI7DzdpOYEVicnJDiTKpDpa/m9L6zq0rcY4xlf8A06Z04SIip1bAIBpQYLCnKXCPjStcflAmRvkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310828; c=relaxed/simple;
	bh=nubvS2VDtVju1y6WYgkOejoitMWvC9O6QM8HO1reoRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RliDLRbVJzMg30eHsHTTKlLJ5F6I/JgyW1ItD1rihDD2vF07+KXji3iwIah+niODGXvAhgQfc2lX/AL4sSSg1vhnfxAdmJeQ6hnuEPDolxIck/8JCUUeLwymYeadKMvbg55b0o5WDl+nJNMcYiQh11Yi8qpaPp3iK2yQopHtqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnR1B/g5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnR1B/g5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980811F000E9;
	Wed, 24 Jun 2026 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310827;
	bh=r93tCIhwYTvoKawcFrjLmwPxR1Kntzh6Ey6FCsL943Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnR1B/g5Cfc26bM4njpw6UNzV5hrILh0j3rSX4S5TxEZXDgF9eDpYuYgp0xhpP+ML
	 BccNFa88UwLxfcwR+7nmpH/M9ps0xVmIdaHpmA669+MgSKd+T7045ZgZkcCph/0i5f
	 cDtkicGsbJvpSaoXJgGuI2Pami+EwLYDCJ0ZvSsFii8yuLjGImZSfyw97helfbsPap
	 URtFInac9pI6r8rh74DyKoaycBDEWrYN4ipzRFOv3KfN+PWZz84WYfMczIMQ62d23L
	 3BNtjFGjAVrLrE5akn3X9RWD8pDfMWstXva23vOCfbPS2d0QeCbAXZrdveib6Q86V8
	 iuJOmEjAzQ6TQ==
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
Subject: [RFC PATCH 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Wed, 24 Jun 2026 07:19:59 -0700
Message-ID: <20260624142008.87180-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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
index df16cc070eeb0..a1ba807d59a13 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1488,6 +1488,26 @@ static void damon_test_walk_control_obsolete(struct kunit *test)
 	damon_destroy_ctx(ctx);
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
@@ -1518,6 +1538,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
+	KUNIT_CASE(damon_test_rand),
 	{},
 };
 
-- 
2.47.3
