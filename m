Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D66286D5E
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950657; cv=none; b=jCcSKY7khU3GWojMPgOvdX4d6oiIWbLJXSLqgffXxzoAJt0DKX4a92ESc7axomcWI+RMO8Up3zWSK5ogrHB+93nrYlGHPBoM52CSNx8EuSaFx/S9nAdUEboi7aM/8r7A5SExHTjOwDrDoRwbAOGIx//XvVhx3I1Kv9DRRS52XWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950657; c=relaxed/simple;
	bh=m3sULRI5UFp0Vrtz1PVlSriadvaJcu4eq0E21z1jQLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jH11VY93iDVfq7cdXBpsPQoRgZgOzusPftk8LwSF4BGRtfKqb7b57DGz37on8BpVjI5T4r4Q35+/8hHX/vD1kZB/O8IIkDmR321vvWN5wqvv3/UD47bnTQgK6vBmImhpnXbCC0EEIGSyLS6XDJV/GFMHCL6pggAI6QMQCujPqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3WH6iTx; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3WH6iTx"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633cd80so1060585f8f.2
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789950654; x=1790555454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dpGtqMcJeHhOEzV/bkAAFY9Zr0/SXcgfjA47TvgATw=;
        b=O3WH6iTxVrSVQg9eeoCGhS925E/1fg/2YdfIPLHqPVjHlbYDHI6kOcI+WDer0hdWSs
         Z7t7JYcgGUQev47sH/UjUbRdL23YGcplgRZmhce3E7E16NHJivqzBnHKcBsrWqtjeLwL
         5NqW9CPtfXFi79Qv7M/OJDebYLUvgiuIWcRIxyoT+SCv5liegdm41+CpQZGJ+xGjbtfB
         FLy5xobGureMzHrEv0jEQQ0whqHkW5n/yiEriz07BAxQyyOvqYOiqeZbtIemi/ig6Rwz
         1NG3vuH+1/s4jwiI/G7Lj1nE619QuKy2DF4WMzZaaUYG3J3U43RnKyke5YKUiCafo2xc
         XMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950654; x=1790555454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6dpGtqMcJeHhOEzV/bkAAFY9Zr0/SXcgfjA47TvgATw=;
        b=2doPQrxg0ItlPqYoPcHQm65T7YtF/tbRAlokwoBpee8OWiF/PgNMDThNYBR+mqlerf
         TpaZS2nKRZ8fxNRzthjHlfcpxHgAguSdX5Oj9AeefuQ+k/3lNbVeAHu8bdhInos4dPyR
         9yZgg84Dlu2K53bTcW3D21Ttkog6XSRi7WVHSA5a0P0jYFwyt0R0EWQmTuuRRBmxG+bn
         jBBjdcQlYpEBFrEs7iedj1rib/HAdNHHsQCYl39AVamE/LorB5tDYr85/E/x3jbV9pKb
         1g0dsfKxRH8nAN243dYCqY+R+w9KgyOgDL6Sy3oddY0sbSTqgUWeVZ2pPR/XliIwuIpT
         rV0w==
X-Forwarded-Encrypted: i=1; AKwUvBzQkWMnuv9QmIfvIwZzj/uqN5D+YIAqhbhZeyKgS9MVGmY58eV7TT7T2dsW5ZABPW7JaPCIcA==@lists.linux.dev
X-Gm-Message-State: AFuF++mma13LB5gI019Br6SQwXHBqaqm96vZrsBZdDR0yYXst5Cucbq2
	U9XxVKWCdA9bijxz0zOubbC9diHp0Lq8Hi2qZNJuXcJorN6ybJNRDrGy
X-Gm-Gg: AYBFou2XSmDkYkhzNDlRD+FyBC76rvZSaG4fsr1PTuLxt6FwE7lKQGKyS8KThFaVP9O
	GpA7ilM8tM83xAw++K6nGChVBSY6sdPT/Ydrv/TCAXeLTVJq1gg54nZadezrVfjfLz2/hTSckRK
	KBOycM+AWNnxH71QmRUJ86yQgIzAx157Ed00OpU32zvd6h2Kmb3h8O9xaT56V9mM1P0fL//HkB3
	Xc5Z9b5dgtqr7Se4CJsWo5+w+fyrLmABZdLa1av0m7y+GCoaSKMRQPoWq6m1fvairRGKozeEN3f
	WvLCY70Ki/acIIdoLdFCbmM9cAcnpyUwuDoZzJ01wXGFxBiROqcY4nmyxnaqKAeQ9ciWG3fO2Tt
	8zMrnW5eL+ffzDneiCvRB8RMtEW6n/h+dU2JWB1pxL0L1mVDKrg7dLZ/1CnndJa5PlShG1tb75z
	WhIvY49AXWOl3CVb8nOiN3uDUTNQFaDZi8om3ksfJ3q85Z/a//HA6TO0VTf6WXXfHclYANhrAQt
	nrGi/DCrVhQsHF8S9yfcjt1MuEoPrH2Nub9dcyGn5+z0qC1el4do36xEFkqvFUxx5wyYmJcadkV
	HvlXM/Meg3bC9l/Qg4hOQgMR3/UAE5p7Uz669pMg3KCVxTLYxINXtB1x8Xmo7GxV8CrZj5/Qn7T
	iGQ==
X-Received: by 2002:a05:6000:610:b0:487:afe:c154 with SMTP id ffacd0b85a97d-4871e36bf11mr15086090f8f.40.1789950653979;
        Sun, 20 Sep 2026 17:30:53 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a012-6c01-e0c2-ccc1-7acc-3570.310.pool.telefonica.de. [2a02:3100:a012:6c01:e0c2:ccc1:7acc:3570])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm17515695f8f.23.2026.09.20.17.30.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 17:30:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/tests/core-kunit: test preservation of caller quota state
Date: Mon, 21 Sep 2026 02:30:47 +0200
Message-Id: <20260921003047.12041-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260921003047.12041-1-kmehltretter@gmail.com>
References: <20260921003047.12041-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that damon_new_scheme() initializes the new scheme's quota without
changing the caller's quota. Cover all eight fields initialized by
damos_quota_init().

Also check that damon_commit_ctx() preserves those fields in the
destination scheme for both accepted and rejected parameter updates.
Use an invalid min_region_sz for the rejected update and confirm that
returning -EINVAL leaves the running quota state unchanged.

Without the preceding fix, all eight fields are cleared in the
constructor test and in both context update cases.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Please feel free to take the fix on its own. I can also fold the
context-update checks into damon_test_commit_ctx() if that would fit
better.

 mm/damon/tests/core-kunit.h | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5ff0436c58441..811fd668e2482 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -812,6 +812,48 @@ static void damos_test_new_filter(struct kunit *test)
 	damos_destroy_filter(filter);
 }
 
+static void damos_test_new_scheme_keeps_src_quota(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {};
+	struct damon_target target = {};
+	struct damos_quota quota = {
+		.sz = SZ_64K,
+		.esz = 123,
+		.esz_bp = 456,
+		.total_charged_sz = 789,
+		.total_charged_ns = 1011,
+		.charged_sz = 12,
+		.charged_from = 13,
+		.charge_target_from = &target,
+		.charge_addr_from = 14,
+	};
+	struct damos_watermarks wmarks = {};
+	struct damos *s;
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s)
+		kunit_skip(test, "scheme alloc fail");
+	KUNIT_EXPECT_EQ(test, s->quota.sz, (unsigned long)SZ_64K);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, 0ul);
+	KUNIT_EXPECT_EQ(test, s->quota.esz_bp, 0ul);
+	KUNIT_EXPECT_EQ(test, s->quota.total_charged_sz, 0ul);
+	KUNIT_EXPECT_EQ(test, s->quota.total_charged_ns, 0ul);
+	KUNIT_EXPECT_EQ(test, s->quota.charged_sz, 0ul);
+	KUNIT_EXPECT_EQ(test, s->quota.charged_from, 0ul);
+	KUNIT_EXPECT_PTR_EQ(test, s->quota.charge_target_from, NULL);
+	KUNIT_EXPECT_EQ(test, s->quota.charge_addr_from, 0ul);
+	KUNIT_EXPECT_EQ(test, quota.esz, 123ul);
+	KUNIT_EXPECT_EQ(test, quota.esz_bp, 456ul);
+	KUNIT_EXPECT_EQ(test, quota.total_charged_sz, 789ul);
+	KUNIT_EXPECT_EQ(test, quota.total_charged_ns, 1011ul);
+	KUNIT_EXPECT_EQ(test, quota.charged_sz, 12ul);
+	KUNIT_EXPECT_EQ(test, quota.charged_from, 13ul);
+	KUNIT_EXPECT_PTR_EQ(test, quota.charge_target_from, &target);
+	KUNIT_EXPECT_EQ(test, quota.charge_addr_from, 14ul);
+	damon_destroy_scheme(s);
+}
+
 static void damos_test_commit_quota_goal_for(struct kunit *test,
 		struct damos_quota_goal *dst,
 		struct damos_quota_goal *src)
@@ -1572,6 +1614,69 @@ static void damon_test_commit_ctx(struct kunit *test)
 	damon_destroy_ctx(dst);
 }
 
+static void damon_test_commit_ctx_keeps_quota_for(struct kunit *test,
+		unsigned long min_region_sz, int expected_err)
+{
+	struct damos_access_pattern pattern = {};
+	struct damos_quota quota = {.sz = SZ_64K};
+	struct damos_watermarks wmarks = {};
+	struct damon_ctx *src, *dst;
+	struct damon_target *target;
+	struct damos *s;
+
+	dst = damon_new_ctx();
+	if (!dst)
+		kunit_skip(test, "dst alloc fail");
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(dst);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(dst, target);
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(dst);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(dst, s);
+
+	/* Copy the parameters before populating dst's runtime quota state. */
+	src = damon_new_test_ctx(dst);
+	if (!src) {
+		damon_destroy_ctx(dst);
+		kunit_skip(test, "src alloc fail");
+	}
+	src->min_region_sz = min_region_sz;
+	s->quota.esz = 123;
+	s->quota.esz_bp = 456;
+	s->quota.total_charged_sz = 789;
+	s->quota.total_charged_ns = 1011;
+	s->quota.charged_sz = 12;
+	s->quota.charged_from = 13;
+	s->quota.charge_target_from = target;
+	s->quota.charge_addr_from = 14;
+
+	KUNIT_EXPECT_EQ(test, damon_commit_ctx(dst, src), expected_err);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, 123ul);
+	KUNIT_EXPECT_EQ(test, s->quota.esz_bp, 456ul);
+	KUNIT_EXPECT_EQ(test, s->quota.total_charged_sz, 789ul);
+	KUNIT_EXPECT_EQ(test, s->quota.total_charged_ns, 1011ul);
+	KUNIT_EXPECT_EQ(test, s->quota.charged_sz, 12ul);
+	KUNIT_EXPECT_EQ(test, s->quota.charged_from, 13ul);
+	KUNIT_EXPECT_PTR_EQ(test, s->quota.charge_target_from, target);
+	KUNIT_EXPECT_EQ(test, s->quota.charge_addr_from, 14ul);
+	damon_destroy_ctx(src);
+	damon_destroy_ctx(dst);
+}
+
+static void damon_test_commit_ctx_keeps_quota(struct kunit *test)
+{
+	/* Only power of two min_region_sz is allowed. */
+	damon_test_commit_ctx_keeps_quota_for(test, 4096, 0);
+	damon_test_commit_ctx_keeps_quota_for(test, 4095, -EINVAL);
+}
+
 static void damon_test_valid_probe_params(struct kunit *test)
 {
 	struct damon_ctx *ctx;
@@ -1946,6 +2051,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damon_test_nr_accesses_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
+	KUNIT_CASE(damos_test_new_scheme_keeps_src_quota),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
 	KUNIT_CASE(damos_test_commit_quota),
@@ -1957,6 +2063,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_filter),
 	KUNIT_CASE(damon_test_commit_probes),
 	KUNIT_CASE(damon_test_commit_ctx),
+	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.53.0

