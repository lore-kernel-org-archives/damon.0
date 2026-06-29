Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E694192F5;
	Mon, 29 Jun 2026 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745003; cv=none; b=HRfJBXY4kfe+/IiFKEpzxw9LGLItgOG51AYwSYL+2ZIWgXpncqUbb7Kb1Z/cVz15Tfx8ZhMejiRHrqvowG0HI/V+geLsv9kJ1IpRFSl6R3+K/Av0BUq0NGl+FzMxo089l5QJ3SnpgKhGAT9F95QpqkwMNdO5ZWyZTSDymFP8MBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745003; c=relaxed/simple;
	bh=MF9sJqQkrDY36+sMJw85xShdLBoaWGmIAvipUHSw+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK38Yj7n/+8SaeyEZepXWzE3UPcpgTBfLr/IWcddVG5C2wmQe+6NXR6HtNNru+7XFD6AVsuRqX2PDFl/ovA1+//r3hdv3F8aX4RMzPFrISUnjanTk1twJajQ8+4wzcz4qsXvuKuli5DmvfVQkcV57qn4Y0PM3fYMgtC5BQe+nmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0p6niVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0p6niVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7609C1F000E9;
	Mon, 29 Jun 2026 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745000;
	bh=bnTE7JQYb8oLGzV0AMcpP4t+f6X2wdwYV6UVz9FcFq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E0p6niVzr944xjRtcTil+YADxceiaUiz4FBwNlSoB7Ex0G3NTNBcEjrYvdTGRt4Ls
	 uWkiw1JTnBONqF5l7A/3dvoj4mkhSu84SD34HsO7sEH7ZeSOdzIe7/lgx1L5PGUiEF
	 9Pa9wBg9EcNqEVmm8RaCGn4DkMiCT1j04GP/CLyhf6Y/tBSrMZWnBZ4jqpbFu/OZoC
	 CRGvy6gXw57/KZQmeL5WxsHUTm6JBNpEuiiT7vOodDNOaXJ39bswS4/wVT0hjG181w
	 QLpKD+1whJuDdf+ppU05DKe09W7HF1OsEzPmbtTXcDGDjlyfDhRr6LlxieSx03431u
	 99aCdy/+V42WA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SJ Park <sj@kernel.org>,
	Shu Anzai <shu17az@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 2/2] mm/damon/tests/core-kunit: test split above max_nr_regions/2
Date: Mon, 29 Jun 2026 07:56:29 -0700
Message-ID: <20260629145630.134891-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145630.134891-1-sj@kernel.org>
References: <20260629145630.134891-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a test that exercises kdamond_split_regions() when the total
region count is already above max_nr_regions / 2, asserting that the
function still splits a fraction of the regions (makes progress) and
does not overshoot max_nr_regions.

The region size and min_region_sz are picked so the split arithmetic
does not depend on the page size.

All tests pass:
  damon: pass:31 fail:0 skip:0 total:31
  Totals: pass:31 fail:0 skip:0 total:31

Link: https://lore.kernel.org/20260626085851.70754-3-jiayuan.chen@linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shu Anzai <shu17az@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c5f5124c3d1f4..a00168730445d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -335,6 +335,69 @@ static void damon_test_split_regions_of(struct kunit *test)
 	damon_destroy_ctx(c);
 }
 
+/*
+ * When the total region count is already above max_nr_regions / 2,
+ * kdamond_split_regions() must keep refining the resolution by splitting a
+ * fraction of the regions (making progress), without exceeding
+ * max_nr_regions.
+ */
+static void damon_test_split_above_half_progresses(struct kunit *test)
+{
+	struct damon_ctx *c;
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long start;
+	unsigned int nr_before, nr_after, i;
+	const unsigned int nr_init = 760;
+	const unsigned long region_sz = 100;
+
+	c = damon_new_ctx();
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
+	/* Keep the split arithmetic independent of the page size */
+	c->min_region_sz = 1;
+	c->attrs.min_nr_regions = 10;
+	c->attrs.max_nr_regions = 1500;
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
+
+	for (i = 0; i < nr_init; i++) {
+		start = i * region_sz;
+		r = damon_new_region(start, start + region_sz);
+		if (!r) {
+			damon_free_target(t);
+			damon_destroy_ctx(c);
+			kunit_skip(test, "region alloc fail");
+		}
+		r->nr_accesses = (i & 1) ? 0 : 100;
+		r->age = 5;
+		damon_add_region(r, t);
+	}
+
+	damon_add_target(c, t);
+
+	nr_before = damon_nr_regions(t);
+	/* Above max_nr_regions / 2, so the blanket-split path is skipped */
+	KUNIT_EXPECT_GT(test, (unsigned long)nr_before,
+			c->attrs.max_nr_regions / 2);
+
+	kdamond_split_regions(c);
+
+	nr_after = damon_nr_regions(t);
+	/* Still made progress ... */
+	KUNIT_EXPECT_GT(test, nr_after, nr_before);
+	/* ... but did not overshoot the configured maximum */
+	KUNIT_EXPECT_LE(test, (unsigned long)nr_after,
+			c->attrs.max_nr_regions);
+
+	damon_destroy_ctx(c);
+}
+
 static void damon_test_ops_registration(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
@@ -1491,6 +1554,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_merge_two),
 	KUNIT_CASE(damon_test_merge_regions_of),
 	KUNIT_CASE(damon_test_split_regions_of),
+	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
-- 
2.47.3
