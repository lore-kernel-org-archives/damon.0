Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDADA383334
	for <damon@lists.linux.dev>; Thu, 21 May 2026 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779339191; cv=none; b=Mf4sKJeh/nEoTwA9NaCmjZa8OS+HYho5ZIqPWbMGtNMSaqnbfoZYuhe5/RbCJ2lY9UxAxiuBrkeKWizwAclptFdEhAfoWmVJXzvlJRwDqY9mWYX2m1cOfmwqogKHTplkedyisJJ2nqMi8xuG/KJGokapZMqETd9alvWfBjudefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779339191; c=relaxed/simple;
	bh=w+qUK/n2Ff+mKSdAKzNJS9/pHdTTj2lLuwe8izNLXCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdYUKx2gbJZJD/jp5RtpmR0IYa4jlmS/gWzMXMGwlo6tg1on1O+miGXxKxK3T9Jy3AxGJZO74sCd79P2NOXJcY4cGHeNfq2IlSs3GGa6am+fWVKs3XBjs0E6EFXCs0UpqM3zUDMdmVyICO0O+n2ZPe7HtVSPycXLNv9LTTQDUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JdSL8oC2; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdSL8oC2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779339185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TMZKInof45y0i4jsA/uEMDRZe595ToXMa24DqFXerQ=;
	b=JdSL8oC26JhfCkCCLDzXIJ2jl/dNNqteRDB5gXeL3AWCvNAMIEyK/G1dyix+KjY0Lg1CkF
	ki0FsJpjVjXfF4ojbNeIALSxNdTytyEasbe+8MA7g0EQi/1cOh8UnhYqFvs/UM0qlMOIRE
	EmxDuyGyWPLTGvcj30/Y9Wk6pOiUgOo=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: damon@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shu Anzai <shu17az@gmail.com>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/tests/core-kunit: test split above max_nr_regions/2
Date: Thu, 21 May 2026 12:52:24 +0800
Message-ID: <20260521045236.115749-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260521045236.115749-1-jiayuan.chen@linux.dev>
References: <20260521045236.115749-1-jiayuan.chen@linux.dev>
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
function can still produce new regions and does not overshoot the
limit.

All tests pass:
  damon: pass:29 fail:0 skip:0 total:29
  Totals: pass:29 fail:0 skip:0 total:29

Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 mm/damon/tests/core-kunit.h | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 1cfb8c176b87..6b2439670049 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -339,6 +339,75 @@ static void damon_test_split_regions_of(struct kunit *test)
 	damon_destroy_ctx(c);
 }
 
+/*
+ * kdamond_split_regions() must still be able to make progress when the
+ * total region count is above max_nr_regions / 2, as long as there is
+ * unused budget and at least one region whose access pattern has just
+ * changed.
+ */
+static void damon_test_split_above_half_progresses(struct kunit *test)
+{
+	struct damon_ctx *c;
+	struct damon_target *t;
+	struct damon_region *r, *big;
+	unsigned long start;
+	unsigned int nr_before, nr_after, i;
+	const unsigned int nr_small = 799;
+	const unsigned long small_sz = 10;
+	const unsigned long big_sz = 1000000;
+
+	c = damon_new_ctx();
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
+	c->attrs.min_nr_regions = 10;
+	c->attrs.max_nr_regions = 1500;
+
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
+
+	for (i = 0; i < nr_small; i++) {
+		start = i * small_sz;
+		r = damon_new_region(start, start + small_sz);
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
+	start = nr_small * small_sz;
+	big = damon_new_region(start, start + big_sz);
+	if (!big) {
+		damon_free_target(t);
+		damon_destroy_ctx(c);
+		kunit_skip(test, "big region alloc fail");
+	}
+	big->nr_accesses = 50;
+	damon_add_region(big, t);
+
+	damon_add_target(c, t);
+
+	nr_before = damon_nr_regions(t);
+	KUNIT_EXPECT_GT(test, (unsigned long)nr_before,
+			c->attrs.max_nr_regions / 2);
+
+	kdamond_split_regions(c);
+
+	nr_after = damon_nr_regions(t);
+	KUNIT_EXPECT_GT(test, nr_after, nr_before);
+	KUNIT_EXPECT_LE(test, (unsigned long)nr_after,
+			c->attrs.max_nr_regions);
+
+	damon_destroy_ctx(c);
+}
+
 static void damon_test_ops_registration(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
@@ -1468,6 +1537,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_merge_two),
 	KUNIT_CASE(damon_test_merge_regions_of),
 	KUNIT_CASE(damon_test_split_regions_of),
+	KUNIT_CASE(damon_test_split_above_half_progresses),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
 	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
-- 
2.43.0

