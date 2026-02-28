Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E063D6CCF;
	Sat, 28 Feb 2026 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772317720; cv=none; b=CgdsGE6whSWgzWL0zi01WeTSzAsdJtXJRSRlu5TtcRgevR1I43anwNNidxL/S7VFW0nBY5PkFouXtBXogGfoJ0138WPIThIxbq9EoZkhaqBo4gkxEUb0MSxepKh6sK2qwTb7qMa427h6dWAANWKYcihXj5DXyZ/noMe00owfazI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772317720; c=relaxed/simple;
	bh=4L+Cdqj56W1rAMk9bb2m53VgY9gTD5qLF9/nWjkq5hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euvS/CqeBV4uca2WhWaPT4ACingyzIu95+vxU1n40+5UvmBWborxbmjbCstFivSLgHlMQO69IcubrZC+5rogBMjtt0HOAoi/O9ozglPJhuMIxJYJOeGkLjv59g0n+GMGDqPxUSlZU40bp8Gyw8vUh39Fr8XegnL1XbxCMx2spew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnkMZ/I+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnkMZ/I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EBBC2BCB0;
	Sat, 28 Feb 2026 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772317720;
	bh=4L+Cdqj56W1rAMk9bb2m53VgY9gTD5qLF9/nWjkq5hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnkMZ/I+DQzkpIvEWkyYi/X/+ixNqN/8hcPutPaMfkOy/PTp3SFn1EJ8rt7upP49F
	 b2I4p2KHDDt6wsn3r8sPiM1jDVNBF9vB5p6Kfrr3I7vA6K8QooTKrD78B37nv4B39t
	 IIUHc9uFEj9b29HpnLwMVi7oKz/1y8DjIwKMnUhLm4pD+z/si9b79a3+Gm/qFZ7tnW
	 Hk+fOGnlVZ//Aq16rv+zRc9WJ5PWd1IF8063K5ToM+FquEeeHVoWUX7bIIoM4oBIdO
	 DPtSY1xYhnxekFy+G6OcQJmi3rGLxrfZeYJsUd7fkHgaVDiWiLfy7cTvNZPZjF0Dfy
	 nPwC6/fjhv2Ww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/test/core-kunit: add damon_apply_min_nr_regions() test
Date: Sat, 28 Feb 2026 14:28:27 -0800
Message-ID: <20260228222831.7232-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228222831.7232-1-sj@kernel.org>
References: <20260228222831.7232-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kunit test for the functionality of damon_apply_min_nr_regions().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 52 +++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 596f33ec2d810..fcc1336b234c0 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1239,6 +1239,57 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
 	damos_free_filter(target_filter);
 }
 
+static void damon_test_apply_min_nr_regions_for(struct kunit *test,
+		unsigned long sz_regions, unsigned long min_region_sz,
+		unsigned long min_nr_regions,
+		unsigned long max_region_sz_expect,
+		unsigned long nr_regions_expect)
+{
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned long max_region_size;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail\n");
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc fail\n");
+	}
+	damon_add_target(ctx, t);
+	r = damon_new_region(0, sz_regions);
+	if (!r) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc fail\n");
+	}
+	damon_add_region(r, t);
+
+	ctx->min_region_sz = min_region_sz;
+	ctx->attrs.min_nr_regions = min_nr_regions;
+	max_region_size = damon_apply_min_nr_regions(ctx);
+
+	KUNIT_EXPECT_EQ(test, max_region_size, max_region_sz_expect);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_regions_expect);
+
+	damon_destroy_ctx(ctx);
+}
+
+static void damon_test_apply_min_nr_regions(struct kunit *test)
+{
+	/* common, expected setup */
+	damon_test_apply_min_nr_regions_for(test, 10, 1, 10, 1, 10);
+	/* no zero size limit */
+	damon_test_apply_min_nr_regions_for(test, 10, 1, 15, 1, 10);
+	/* max size should be aligned by min_region_sz */
+	damon_test_apply_min_nr_regions_for(test, 10, 2, 2, 6, 2);
+	/*
+	 * when min_nr_regions and min_region_sz conflicts, min_region_sz wins.
+	 */
+	damon_test_apply_min_nr_regions_for(test, 10, 2, 10, 2, 5);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1265,6 +1316,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
+	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	{},
 };
 
-- 
2.47.3
