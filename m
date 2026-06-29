Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD204218AE;
	Mon, 29 Jun 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744947; cv=none; b=IpdW0qDwgW4ahiLyfHR4G84U+447rG0cbyxjuf+1tjcRBSyeK6fnJJ3Yd1iKSSzRP0V+6XMzwYm9xGPuSk/fxMOv9s9ThBI7SKRO7+PrTQZwXIsKXNgDHi7DnYXoIvB891zh+nn19tGRK5Gca64xmEg+w8UX0NFFWtKrPl8JVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744947; c=relaxed/simple;
	bh=Sfcxn1x6pwwPm7Lpr7PVfZ7Dc2oD5JKUbz3rGJ96MIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFe5qDNkvn6coQn/01bWZ9aZ03Ei7mlF6sIMc32bahm55IkjiyAEq2e8kigjQs7/FHzoFPqUQ9Rzl9XIl09JJqWrvQnhYup4FgoqOlKCcgrgEh7F4LN2SYtLIj1ZYRHxMt7SpO7/0jive3eXTA3Q4MTovSYzFkKIpqfaRD87sBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5qQPFvO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5qQPFvO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F961F00A3E;
	Mon, 29 Jun 2026 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744946;
	bh=YEMOORj6+k+v752vYE0fvW8oE/gyV10AxdEBNRJjrnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5qQPFvOwWuoHblsWDCUSPcMaUkfQr0s673YQXPIpHGuxpWZJzMj2fGfNmEgQUS8T
	 mcPlhF+P8MqFhjMeAxmUor3NAuTDNdUB7Mv6SCedZ8pTsScwx5+7h99ZZlZwUxJ3xm
	 HGd2KiTTD5rdSSHQa/MuyUs8eMd6fDyTHqE7GL5D/K14xl+7SHetvbuYeKh5ZoJ0yS
	 o9q3oluA3W8T/ZCgLcWeUcabzeCPVhl4NAfATyKlam+pwiYG0eX87W3wdxl0ODQ0CR
	 AS3LydIvR9iIMB7pVG1rErUeAFNlsQjYydbXZrELnWnhiRZt2knJOPYkJOtpXpZBhv
	 tyJlYUwHs0b0w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/5] mm/damon/tests/core-kunit: add KUnit test for walk_control_obsolete behavior
Date: Mon, 29 Jun 2026 07:55:36 -0700
Message-ID: <20260629145538.134832-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145538.134832-1-sj@kernel.org>
References: <20260629145538.134832-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

Add a KUnit test to verify that damos_walk() rejects
new requests when walk_control_obsolete is set.

Commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs
kdamond_fn() exit race") introduced walk_control_obsolete
to prevent a race condition where new requests could be
registered during kdamond shutdown and never handled.

This test simulates the shutdown condition by setting
walk_control_obsolete and verifies that damos_walk()
returns -ECANCELED immediately.

This validates the invariant introduced by the fix and
helps prevent regressions.

Link: https://patch.msgid.link/20260612062337.2459-1-saileshnandanavanam@gmail.com
Suggested-by: SJ Park <sj@kernel.org>
Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v3
- v3: https://lore.kernel.org/20260612062337.2459-1-saileshnandanavanam@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.
Changes since v2
- v2: https://lore.kernel.org/20260524100258.36819-1-saileshnandanavanam@gmail.com
- Dropped the userspace selftest approach entirely. SJ tested
  v2 100 times on a kernel with the fix reverted and it always
  passed, confirming the microsecond-wide race window cannot be
  reliably hit from userspace due to syscall overhead.
- Added a KUnit test for damos_walk() + walk_control_obsolete
  instead, as suggested by SJ. This directly sets the
  obsolete flag and verifies damos_walk() returns -ECANCELED
  immediately, without timing dependency.
Changes since v1
- v1: https://lore.kernel.org/20260524091812.35283-1-saileshnandanavanam@gmail.com
- Addressed sashiko bot review comments (execute bit, threading,
  dynamic sysfs path, OSError handling) - superseded by the v3
  approach above.

 mm/damon/tests/core-kunit.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index fcf7c7fadb5fe..c5f5124c3d1f4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1456,6 +1456,33 @@ static void damon_test_is_last_region(struct kunit *test)
 	damon_free_target(t);
 }
 
+/*
+ * Verify that damos_walk() rejects new requests when
+ * walk_control_obsolete is set.
+ *
+ * This tests the invariant introduced by:
+ * commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race")
+ */
+static void damon_test_walk_control_obsolete(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damos_walk_control control = {};
+	int ret;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
+	/* Simulate shutdown phase */
+	ctx->walk_control_obsolete = true;
+
+	ret = damos_walk(ctx, &control);
+
+	KUNIT_EXPECT_EQ(test, ret, -ECANCELED);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1485,6 +1512,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
+	KUNIT_CASE(damon_test_walk_control_obsolete),
 	{},
 };
 
-- 
2.47.3
