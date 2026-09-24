Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BE48095A
	for <damon@lists.linux.dev>; Thu, 24 Sep 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281001; cv=none; b=a47Xups5R6gJDEUnx5nhXeNrijy2LpC777gUpGmYqeXiB6WjrCecYidh9ItudPg3YYHZSmral96f/ipGgoBA8FOTosnYkM6Px5DDldKrq1HCj/Fn6D1K7rMIzSPGoZfQ+R38jWe7QaOvrWWmTMk703H9E9w5O4Fjsb8qkdD64r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281001; c=relaxed/simple;
	bh=+wpqn3MkNoPlg8bjD8tEsQDaKj+7SwlEj98iIZevWVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBtWzyJqay10v1xIjBHIK/hvvCighGYeJIqnOrjwigDUxETuWPvYDK9GGnhSP46pMqeUCsX7dDjpSJ1qHnuUzSvBg55rIukdfGM3oWpjCZCEtWEYSWeLw/bvDSjsbdjc/jWr0fLg2JU3Y4KumA99iTh44i5R1FanjhRcNQVPzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjW4D8tq; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjW4D8tq"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so2324365e9.1
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280996; x=1790885796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lNjYmC2mw6Yjd8M3Db3AkasSR6Gybp0ryKVRb8ZCRNE=;
        b=PjW4D8tqs+1y1ILLOnLz4VnsvoTWGzNWFDjB2XgqgpBaio+Vy2QWwOCAmqHfn7Ys55
         bGwblghVVrP5ZJEV/UdRD9dtES6cSYA8ZrieWYOE+BstTI3N/sB/tEarp7h/rQemN0Lk
         C54aK05is6M8fDWuy8WPYGdse7dAyappbyqmk/VPWlQlBHjQv960q+vVoJCL6P1GHtaz
         1pfqxHTUdvCgAoRMbE6CnMcmaslKNIEmsW+4reaDAWBlFmJNiv1Ptb86Nf6tKieKpBsv
         fjAbyZT1DJP+xDJv9jWkXI4v48wh8ZBKhA5WauzVGW/hLW0g2w3C/WBJaEhtIZjgSg1X
         07Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280996; x=1790885796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNjYmC2mw6Yjd8M3Db3AkasSR6Gybp0ryKVRb8ZCRNE=;
        b=1kLQq0QC/TV53OnN+Aep50NM/clFbm8+z60rSGw2KLofBNYSmhyRNs6GxpiU+EUoHb
         I7JFU8NUJl2OTcgcNvAP3RZRVx0smZNROqyTAYGL5zSMprZmnnP18vH0xZIFhKa3pCVF
         ZMZtMCjVZgKNPz8S0yuB812SdVe6c8fzRglD3L15n1GLP9LjLNVGmUkCrnFsz6ATWW+1
         2Dlks6XkfQtlNloRDscuHaSf2jbFBK1aD/EmhhBC3w5e5hksM7HxECZ74NTe8JV3oZB8
         Cn4C9oQ7193pW5mAxYEOFebBl/hkmiRyb6JOTSBxsvm2iq1pbajP1miQV+U3LjUarDVi
         lm8Q==
X-Forwarded-Encrypted: i=1; AKwUvBybRLL3h6ISBl/uZC1scHxd7S0bHA9TXNCqtcG+MGFpqeawrTTpGBwuxzD84wJ9zBTGmxXaLQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lTUX/EUaOeK/N7HKp98LSZ9KZe4u6q2zuG654Rv0uoULwoZ9xV
	WhrPMoMtvxkVxPBtHR1B3CEuIy62X1GUuLSs07qGe9bRQPmA2pnDdzI4
X-Gm-Gg: AYBFou3Nzk7a0qT52MZl7RbQyVYekXyruLtXx+PYb+19C9CyGkaQCwkChx+J4FS3PAL
	BpSBXmkfydV/3jZWjICXP2khHcITNcTTDP5ly+IDLEkERBpufPJk0Oep0zoaiHu102Bu0A6c32k
	qf21RpSB56vOcSRb50+Ov8eJpn7gLzD10+u5k77Q1reHA9TFRc+mlXyU61FGk8KYu1c+wCNnxAi
	/4ZT/AvEn1npHLnmM8o/inb5kTXYYkQL/DF5DL32UefgG92GSRtxvabvijLJHYu3tnrsTWRHEeM
	Cf9VktYi/XiaBdCsu47ErfH8mXUaQGTSbYShDsyHmed7iQ/ClnVyCWITDgDR/I0fFjrp9CbaqGD
	PJUm+1q4VK7qbLI/5YAmK0FkfeZt9pTIenefSj7GQAzFj329HLNfNplUil3hmHVqyp9hPY9qmdm
	Uj7jiuJSPS8N/fypQB9LigZpiOPcib+NjVEPree8r1k7jkLxkQVLk+ee8zFvUXwYUE2SUlFL1ix
	4LPNqOTEfe0BPHtTnet9cdtq6eJFS6XMiik4sibY96JukZYEXhF2ahltCgzOMFsrecEMpMhrisv
	jQ6GjODOnEzHg8Zf4DEkYWMTz7AIZyYacja2dweNKjvA3NcET8ypik3nxYYm+tb6Uz8gm38JIeD
	ClDBZKkikGDM=
X-Received: by 2002:a05:600c:4e86:b0:49e:6ac4:b76e with SMTP id 5b1f17b1804b1-49fe66f720bmr62480535e9.30.1790280996266;
        Thu, 24 Sep 2026 13:16:36 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-adbf-6901-3138-76b5-e9f7-b9cf.310.pool.telefonica.de. [2a02:3100:adbf:6901:3138:76b5:e9f7:b9cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfa6a7sm144818795e9.12.2026.09.24.13.16.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 13:16:35 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm/damon/tests/core-kunit: test preservation of quota state
Date: Thu, 24 Sep 2026 22:16:14 +0200
Message-Id: <20260924201615.4478-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260924201615.4478-1-kmehltretter@gmail.com>
References: <20260924201615.4478-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that damon_new_scheme() initializes the new scheme's quota without
changing the quota passed as a parameter. Cover all eight fields
initialized by damos_quota_init().

Also check that damon_commit_ctx() preserves those fields in the
destination scheme for both accepted and rejected parameter updates.
Use an invalid min_region_sz for the rejected update and confirm that
returning -EINVAL leaves the running quota state unchanged.

Without the preceding fix, all eight fields are cleared in the
constructor test and in both context update cases.

Reviewed-by: SJ Park <sj@kernel.org>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Changes in v2:
 - Collect SJ's Reviewed-by.
 - Refresh context after rebasing onto mm-new. No changes to test logic.

 mm/damon/tests/core-kunit.h | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index df84d9cc7d204..ce17f44583087 100644
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
@@ -2259,6 +2364,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_mvsum),
 	KUNIT_CASE(damon_test_nr_accesses_mvsum),
 	KUNIT_CASE(damos_test_new_filter),
+	KUNIT_CASE(damos_test_new_scheme_keeps_src_quota),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
 	KUNIT_CASE(damos_test_commit_quota),
@@ -2270,6 +2376,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_filter),
 	KUNIT_CASE(damon_test_commit_probes),
 	KUNIT_CASE(damon_test_commit_ctx),
+	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
-- 
2.53.0

