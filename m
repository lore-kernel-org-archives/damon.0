Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AF3E7BA7
	for <damon@lists.linux.dev>; Fri, 26 Jun 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464407; cv=none; b=Et9TMBcsMsFLjJGxIcwqtHXLYNd8XYd7JGUuo8QLr1VvEYJ0AikHgcVxw4vVusH+4+vrHKd474fG0T2Fzyda+dNq6L83z9XkmG8OOayT7I8aUa6wpnUb9mZigl115zkPMfVVFAMh/b6LiEP/mMybhyJwUkkGcDIDRJ0bVmtpgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464407; c=relaxed/simple;
	bh=Ds3LdZWnr3AWaeQztKl7qNplh+TcKtAjHrlOs/N++Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyaWMYpJHe5xQfTRncVuvyNIrkR+4zB1TbD3uuUYLt3FXBHAPqKOnLgCPwm1Rq43O0KmUFVuz9iujAIwyQNtbDjwixZUOBPrz10tUMj0lVU3adBJUCo7kDoBEKm2gmT4tU4IuTb6fy8Pm94amjLZ8GF7R4vPyGn1IHSglJvwBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BZC2sX83; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BZC2sX83"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782464402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiF+ZZp+CVU1sZqeDDRKvFPYiBeZ08llaMDiB0IH+P0=;
	b=BZC2sX83iCPGiP8u4V/j2JFHHAvan3ttXTMNSWEawRTRc+lBxqRdNidDx4QEoApuNeJhAT
	BgdopX6rtN9K9+8I+cLEXF9ye8+IOW3/ZuUeXXpWrpCbv6N7VonvJYEtiyZ43uTJ3qsC3P
	ZqY5ujY+QkxJyy2C1NoBP7ZADQVxNFU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: jiayuan.chen@shopee.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon/tests/core-kunit: test split above max_nr_regions/2
Date: Fri, 26 Jun 2026 16:58:38 +0800
Message-ID: <20260626085851.70754-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260626085851.70754-1-jiayuan.chen@linux.dev>
References: <20260626085851.70754-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 29fbe495e532..6fe7abcd670d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -341,6 +341,69 @@ static void damon_test_split_regions_of(struct kunit *test)
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
@@ -1521,6 +1584,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_merge_two),
 	KUNIT_CASE(damon_test_merge_regions_of),
 	KUNIT_CASE(damon_test_split_regions_of),
+	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
-- 
2.43.0

