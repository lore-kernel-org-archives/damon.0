Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E3F284B37;
	Fri, 26 Jun 2026 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433025; cv=none; b=iLfsmg7aiRIoMXtiQIHx37CDJSdCMXwiKdJisZYmi95jM3uom6rn3jSvb5njXq9+MC2vRuCwcqa3O6VGgnzvT6KLuI1kHK/6j5YrhpGTmjYW6uRkYcWbmdmgjChlI+JPWPWe3XPOlt6kjrXqlS7l7KVPBGumqEJ3e+5jBBxCeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433025; c=relaxed/simple;
	bh=9AhhRDZ1bU+GUz5WFkYsc+ZGyO0zp6Dw3Zqto2My7Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOmoKDq2HJRSnCJA+eqRBOuJi6XykRj6Ws+1b+Ratf0OnH+M8Is6yPljSgO5XghRmjx5i1vAicBCQ+96+vbuZYU7KybaXQaJEv9UfyssNrhAaBPC+G323lDrW7B0FIb5vfeLeYhmMoPUqMrzi6F9gTp8+TKH3wzPoIn5YCMichI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJrhdGvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJrhdGvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C41F00A3D;
	Fri, 26 Jun 2026 00:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782433023;
	bh=2dKSzklg/iygza9/Q9kj3LGtbFghgmmhxZCw/eIqgzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJrhdGvj3mMyAr45edesRy1s4UQtEBtCTDY+FxTtS3/BZvgzvKbVfPO5j7rbT2ttW
	 6RBc88u+FgIP9uty5oDQoJC1WMR4oyCLPqhS08snJ6mLTyVg67Bep2DImBhgT+7NXa
	 Gaz0ER4ZTKIEfDsMa4ZgF+1+pbV57yMYo8ow8/bu0EsCHPUepKy37hwW+50u00Z6TX
	 k3KsVyVtO1yVrZgh+91FXpEFG1uVYN5lVRgP4tz37xE3inWOeaKL27mERGckxogk9d
	 xzG7e3wR3SErovAc2l/MKG0PXiyfUTPXTX3LEFV2PSJeTWO5/Gza9dl6YpQ2yjOZZV
	 QG8npMF+HiDRg==
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
Subject: [RFC PATCH v1.3 03/11] mm/damon/tests/core-kunit: test damon_rand()
Date: Thu, 25 Jun 2026 17:16:34 -0700
Message-ID: <20260626001644.85825-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626001644.85825-1-sj@kernel.org>
References: <20260626001644.85825-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 1cfb8c176b873..282670b0fa908 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1460,6 +1460,20 @@ static void damon_test_is_last_region(struct kunit *test)
 	damon_free_target(t);
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
@@ -1489,6 +1503,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
+	KUNIT_CASE(damon_test_rand),
 	{},
 };
 
-- 
2.47.3
