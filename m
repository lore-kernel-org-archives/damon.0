Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B14192EC;
	Tue, 30 Jun 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829061; cv=none; b=SdB3C/7BsyvqGWfnUnFc/2N4V9OZLrRkNLVcHHuW+Cn7NqH3A1/gLrd8M6beE86rNWMV/K9cuqWCcY5mx6xvZ5at2Hd2mwH2lPbCs0ns76pw4YxdH6sR7JNIVmeEcAwyj53/hu+rCDzNdj8Vl9zC38AQ8pka/DoxGpFHYAPVsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829061; c=relaxed/simple;
	bh=oNcYmQpMlLqn/8NYE11BqPV6jYmgrD3VqsyPJhcMnwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9H/nobllDtgx4rvNK9/3Mqu6gYPIaYHdfeAS4hVMLClTmzYAIc9GDGAhth1emEDKU63L4ptrd4fcEGyx2BcjCOVbtFCm/GDdgOTLIio/iqGetBSNLN+GqHjTW9Zk0JqO8wC4bovKU5NStqFo+fV93lJYQ+tcyeVTQN9YH+EqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6y75598; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6y75598"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3371F00A3A;
	Tue, 30 Jun 2026 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829060;
	bh=2uS6dozko2yZPUVNoFA79ufpLiFmvL+C2qUOX4NrXFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6y75598emWFv7MuquKR3xnTvI5bWm5OwWmd1cKX6WS/8PTsllnL5LZuUhTEMgKal
	 O0yGoQwcKRjp8V1+meDk3bf4ht4oiCY1RJ0guY4NEMcS3jef1Fp+OVmEkPK9Xnx4UP
	 uGIKOrc8oPLh5dSgKHdo50VgaNwRymnp28/Ai9Pilo/xnj/e4bwyekzTUNr/eNqpUz
	 V/cN044WEmjwN+9s6lAGYBlTOj8iMSStzNTUp10tqWvYyJ+GsSKs5LNg/F+0gdsdlA
	 2J6deVAtXsXkmpanniBCqVvNr00O6TAoqVvTfZQGCm/w/wWNwUA3mjFxNVbNvLLRc9
	 PBrUw8XoMYqLQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Tue, 30 Jun 2026 07:17:17 -0700
Message-ID: <20260630141726.92246-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index aef7e0553cba4..0124f83b39b83 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1547,6 +1547,20 @@ static void damon_test_walk_control_obsolete(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damon_test_rand(struct kunit *test)
+{
+	struct damon_ctx ctx;
+	int i;
+
+	prandom_seed_state(&ctx.rnd_state, get_random_u64());
+	for (i = 0; i < 10000; i++) {
+		unsigned long rnd = damon_rand(&ctx, 0, 10);
+
+		KUNIT_EXPECT_GE(test, rnd, 0);
+		KUNIT_EXPECT_LE(test, rnd, 9);
+	}
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1578,6 +1592,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
+	KUNIT_CASE(damon_test_rand),
 	{},
 };
 
-- 
2.47.3
