Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26092F6560;
	Sat, 21 Feb 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697032; cv=none; b=uRtbbAtwgtc1cfVCNio7Gy0UgJdLla2wl20rLmbrb7rF/NwCRf7z84IJLxMPckilq68IeaGik5tfp7dFPCZf2fHOpl+wkdvgMKidIBsPGZnY66TAtwE6AWthfjyVDU33B1qm4apF4On6kczz5LTZ+5uKuex7nK4cQ+VXL2MFq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697032; c=relaxed/simple;
	bh=bCw9hVCbQXONIXZgAbBvfEk2u6XzT2XAiGuqMrqAhNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojIHl3aP/GA+wHTx9EvvpWKVpKtpJEab3pq1b5SmsRvqRm/8GKaps9uqn3vk0cWifxHfgyocr2BCJmORKooMC1iABbvMmIFsJP5DHGwGeOXVLZv4zUJMR/rFiz0XHE6rfPMkkO22q4ElAplCudy/3VadZG2ieGcKNkSEpFLp1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ+JXmDf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ+JXmDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F54C2BCB1;
	Sat, 21 Feb 2026 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771697032;
	bh=bCw9hVCbQXONIXZgAbBvfEk2u6XzT2XAiGuqMrqAhNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQ+JXmDf6pJAEXnAMg/rBeh4QMAJ96ToBwrJSC3xu3M04NBGmadJ927JiIw4nGUjO
	 0OH2PQ/k+48lrdmKTXz1acmV6OU8VYOebosJba8HVzXawMOeqPQlkiPUQDTfsffSOG
	 X86AgXLcw2by4bsWmjLG7lUhq1r+hfIUXUmQc4mH9e8i03S0268tw6mcLcoLjn1C8h
	 oaxeiYMeKEiiCULy1/ml8nETzJH9kCpNrIs0xRQcxVHT72V4GQV1cK8RFCykqmlZxS
	 8Qa9pHyYYwB3DOE41AxRiVrtX6nPqEZwrEf40RvAO2ZDg/agHUdUyV4kDEjJSLKzDU
	 mX0aaykirReog==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/3] mm/damon/test/core-kunit: add damon_apply_min_nr_regions() test
Date: Sat, 21 Feb 2026 10:03:40 -0800
Message-ID: <20260221180341.10313-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221180341.10313-1-sj@kernel.org>
References: <20260221180341.10313-1-sj@kernel.org>
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
index 92ea25e2dc9e3..4c19ccac5a2ee 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1241,6 +1241,57 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
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
@@ -1267,6 +1318,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
+	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	{},
 };
 
-- 
2.47.3
