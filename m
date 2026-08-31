Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C951A72F;
	Mon, 31 Aug 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188820; cv=none; b=tVJxAqwS148v0ZDtB2gq4JT599bB4IhM83QTtE+CYbOgDXJUHGnVuQ8VIEHaeO09Sm+naaV3P5ElVoS/Q8TU2l8/dMqvUo70XfWomv5giow2cjt6Q5tdzMkRYw1hYZQODYHS67FwtJ13LbOWLRzLwENxPHkj0YRZqWJsQidJtqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188820; c=relaxed/simple;
	bh=/m2MgfqcWMXWTS3rOf2JdJxa1KYmjpJgfVfa99jugPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnclsjet43V1Ju/og6U0XiC4guqlwvnVnzofpF7pCsjG/1vLvIp58McyIufRfWkGWdRr2GFnlLEod6XwXHotkMch5pzSHrL3RuHZ2RFNWZfL+z2WKV7zQu4nQ37UPGwHdmJQsRoXZsxONepZSf33B4beTZUKZCN6KSgdKiLvRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5wScyc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5wScyc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F51F00A3F;
	Mon, 31 Aug 2026 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188819;
	bh=o7lIq+lsQYzbYzf+cqUQ249deMwzfBwDjcIr5FOU1kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5wScyc6VUkcQzeNeObcmSoumA5UwCUlKoqWQIJjXLhYY/NhNn0CVz16iLB6Wof5X
	 OVbAR8k2fpqNpOlw8oKOWNbtpgLrFd76oQ4H0cv34bKVOU8Twv0chFMJsgWvfk/PLP
	 +Y8dF45RzxRUn3tlrqfTrFCLv9XnBsnjWxG6nf4WcmqBLEJtMgQS+5pE53CGvhVPSf
	 fsnGoVnyVVwT/n1NZD9f6PU+O4e0k5p+6U16ExhiX+lWBunFoXtCTCV+/cBa4spfb+
	 s8TVCYgOvdvblvVqxU62Sin/thY7oQUGByap+TxLzaHqDjUEYwf5HkFZz+zFqqIWDz
	 0OFFIq2lQutSw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Angelov <jasonangelov@ucla.edu>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/damon/core-kunit: test damon_valid_probe_params()
Date: Mon, 31 Aug 2026 08:06:49 -0700
Message-ID: <20260831150650.84829-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831150650.84829-1-sj@kernel.org>
References: <20260831150650.84829-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Angelov <jasonangelov@ucla.edu>

damon_valid_probe_params() makes damon_commit_ctx() reject probe
configurations that could overflow a probe_hits counter, a single
(weight * probe_hits) product, or the sum of those products.

Add a kunit test covering each rejection at its boundary:

- samples per aggregation interval: U8_MAX is allowed, one more could
  overflow a probe_hits counter
- single weight: the largest whose product fits in unsigned int is
  allowed, one larger is rejected
- multiple probes: each product fits, but their sum overflows
- no weight set: the validation is skipped

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 68591ca99a4f7..af26b3d60957b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1341,6 +1341,62 @@ static void damon_test_commit_ctx(struct kunit *test)
 	damon_destroy_ctx(dst);
 }
 
+static void damon_test_valid_probe_params(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_probe *probe, *probe2;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+	probe = damon_new_probe();
+	if (!probe) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "probe alloc fail");
+	}
+	damon_add_probe(ctx, probe);
+
+	/* Parameters are validated only if any probe weight is set. */
+	ctx->attrs.sample_interval = 1;
+	ctx->attrs.aggr_interval = 1000000;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* Up to U8_MAX samples per aggregation interval are allowed. */
+	probe->weight = 100;
+	ctx->attrs.aggr_interval = 255;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* More samples could overflow the probe_hits counters. */
+	ctx->attrs.aggr_interval = 256;
+	KUNIT_EXPECT_FALSE(test, damon_valid_probe_params(ctx));
+
+	/* The largest weight whose weighted hit count fits in unsigned int. */
+	ctx->attrs.aggr_interval = 255;
+	probe->weight = UINT_MAX / 255;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* Any larger weight could overflow its weighted hit count. */
+	probe->weight = UINT_MAX / 255 + 1;
+	KUNIT_EXPECT_FALSE(test, damon_valid_probe_params(ctx));
+
+	/* With one sample per aggregation, even the largest weight fits. */
+	ctx->attrs.aggr_interval = 1;
+	probe->weight = UINT_MAX;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* The sum of all probes' weighted hit counts could also overflow. */
+	probe2 = damon_new_probe();
+	if (!probe2) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "probe2 alloc fail");
+	}
+	probe2->weight = 1;
+	damon_add_probe(ctx, probe2);
+	KUNIT_EXPECT_FALSE(test, damon_valid_probe_params(ctx));
+
+	damon_destroy_ctx(ctx);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -1667,6 +1723,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damon_test_commit_ctx),
+	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
-- 
2.47.3
