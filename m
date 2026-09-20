Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CB3B0587
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871495; cv=none; b=cvHWpHrkQ/QJiYOudGB2QUi8efGaP3jUcppvRmYkpLEQQQQW5oAaIrdPDyVUNn5e4wk0k5VLAoi8YpEOMrlWZ6IFe+j8g13gjLehxuuJorkrjtPu/zrRmrIB3SgXIzXwku1inS27PtVAg3963Af/zykaptPawqQabxb1gOkmXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871495; c=relaxed/simple;
	bh=gCSp4fLALR9AlO+8Sxd7XKtxyIR4PXe+RtMvtM/vFr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnEfMmNRwnLPIV9lRD86DtYZu10L3VKOtZpPdizv34cwEFbcGDQJscWeLRao+UyOWcz+M/vGQDyE5EVuvGhayqLdvTskA8MsiXXqeWJ2zmHBNKVzsUeTLQIqeJfxI/ZmcO0wdBmtiL1TRcEAn3ViuKBoccw1Chp7kzAccivCrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y94TMEN1; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y94TMEN1"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85a4329731cso1494536b3a.3
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789871482; x=1790476282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCQCwXtMyVG3gFC0VFWbPq0+zT3uX69pml+4GH4Kjjo=;
        b=Y94TMEN1itpEnXpSux5oLB9ZthlJyzuRm5y/jxyBLoB9p4Mcyuyv5CdZWlIXbdis9O
         EIvTEZVo3a48+6ynCzuzGWnGgXYixklmd+Xwjh26n6srZciBPb0R1UHshOpDol4Jhtrp
         V3vJRYH9fwODMNUXOYUqEJm39Bs7IB73nYFA99+rxILAN+N0r4JOyPSu0z6auEVD1SPv
         jYDHjD9u5kzuEv2yCzgVuuR8nrPk08675HjZB9z432HxzUkK0AP7kM/m/EsTS5lt3lHN
         uKvtv6w47GWmQzuT8TpDKK6NVLwmLKzRh08BFuHHDBrkyhbSZ4RZHlFr/NM0PhFcrYqk
         1WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789871482; x=1790476282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MCQCwXtMyVG3gFC0VFWbPq0+zT3uX69pml+4GH4Kjjo=;
        b=HMG8EUDo6yEqgM1VbZFokt0WzIe5GiXLILtkMbPNlmIQL1ElWwhltGui32VtNFoSOm
         ga8p5rxS+JzPRPIujc+dkOGfeRvVERT+oQQ5Z4NsL1znrTYy6ylP6boQxTXbslr698YZ
         uzO4LaXUmEPQfPSG/KPAI48Uou9Ruo5CZ12FBvfkX6ciBJ9glL2locP4mKE/YDEMCBEf
         WvSAnvLk1KjNov7BOvxRnP/SVZjWvnK9cZqEq4MAyZ0HMg/NZcCYdau03a90y86mjh3A
         VbLhPcqrDogiJEs6WbiaTfZnaZF1oqL+EPX3YmIJrdklo3+2SD887BipV+Fgiz0ySCLB
         dBLg==
X-Gm-Message-State: AFuF++mGOI3M2tajAZbLnfLZYDahCqxBUCGnY6yZtxJSJVr0rn9fwXIT
	dcUVuou3rO/wb3jWCsXI27Sv/xLAwx2ye352Yjl1UdQSinyKmpVsHJa2MzfJCE3JSA==
X-Gm-Gg: AYBFou0q62y9VkMgOFPPhmYedejqjRu6MinEfy6t0VisjeHjJG5ewsyISpbwQJpJ/dH
	dfxRqJ0FPd4J5ex4gsxY55hC47qlChkM3Og3y+2Ha6sW7cEQ1D5TdygO6tUUGemscRxOus0G5Ev
	kXuXJqRkdsremstTR/2WmZ9+HF8BoKAwjouVZbmjUimReXDbHPu1Xry5I3AFeYBxek06zafvygc
	rxF/ghb291OqpvHDf/LMpFUfBl1AVlZcB+DvLLSFvEVW+YF750Qi9ygN37/YvKyacuTbJxg3l/g
	54ekUGcSEpUDwPc1hHSS2l/Is+B6SvurJZ6hEg0SMxfK3sojEQuwl/EIRJMx64ffG/7W9GxeFy4
	LBwcKSt0c8fq1aJZ7yT7vdRWuCpXUzfCRPBY5mBZDBn/XHS+eM3Gh+gek63NLoNGISqNlg9guZY
	jfXtMzIYm6Be3zGxs1W8iCU2x+Jw16He2oby4UD7OxFoSEileor9R8aMllqk45YxooDa37+ttyo
	XvSbGELHSMKprw46l2Q3Q/1mw==
X-Received: by 2002:a05:6a21:3510:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3dd8c3fbf58mr12345243637.2.1789871482415;
        Sat, 19 Sep 2026 19:31:22 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:36d8:54a:e0bc:3e5e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aee03efsm1481341a12.24.2026.09.19.19.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:31:21 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v2 2/3] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sun, 20 Sep 2026 11:31:10 +0900
Message-ID: <20260920023111.2466265-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
References: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() encodes the size quota in basis points,
so the conversion is exact only up to ULONG_MAX / 10000.  Pin the three
sizes around that boundary: the largest one that fits, the first one that
does not, and ULONG_MAX.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 mm/damon/tests/core-kunit.h | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5ff0436c58441..a0604788bc638 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1929,6 +1929,53 @@ static void damon_test_rand(struct kunit *test)
 	}
 }
 
+static void damos_test_esz_goal_temporal(struct kunit *test)
+{
+	struct damos_access_pattern pattern = {};
+	struct damos_watermarks wmarks = {};
+	struct damos_quota quota = {
+		.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL,
+	};
+	struct damos_quota_goal *goal;
+	struct damon_ctx *ctx;
+	struct damos *s;
+
+	ctx = damon_new_ctx();
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	s = damon_new_scheme(&pattern, DAMOS_STAT, 0, &quota, &wmarks,
+			NUMA_NO_NODE);
+	if (!s) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "scheme alloc fail");
+	}
+	damon_add_scheme(ctx, s);
+
+	goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
+	if (!goal) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "quota goal alloc fail");
+	}
+	goal->current_value = 0;
+	damos_add_quota_goal(&s->quota, goal);
+
+	/* The largest size quota the basis-point conversion can hold. */
+	s->quota.sz = ULONG_MAX / 10000;
+	damos_set_effective_quota(ctx, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, ULONG_MAX / 10000);
+
+	/* Any larger one saturates instead of wrapping. */
+	s->quota.sz = ULONG_MAX / 10000 + 1;
+	damos_set_effective_quota(ctx, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, ULONG_MAX / 10000);
+
+	s->quota.sz = ULONG_MAX;
+	damos_set_effective_quota(ctx, s);
+	KUNIT_EXPECT_EQ(test, s->quota.esz, ULONG_MAX / 10000);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1965,6 +2012,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damos_test_esz_goal_temporal),
 	{},
 };
 
-- 
2.53.0

