Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C5437852
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907090; cv=none; b=ZT7+LpGzxEb0iYmwU/vkiHz7Lnrut2lvEOoRglhKX8m/SgtTLCIn3M20mqTfP5z+dxzwSb7axf0E30H7YTlXpwzBZxIXI/NVIUKNfOqTNsQh7/uyD/iWP4OPr1iyK+208GJzLsvKKVZX30NeOgEq0L6Y9XqJ2XmfQzxWRWnZPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907090; c=relaxed/simple;
	bh=rmWR38P9oV+3YYhnLaf+Dq+xPZyqqx+mXZBXqMUox8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ4VF91DCstGIF5WY2TJACF1ZH7oHt31cJPMPsY0sNZx7MtSQGkBKwx9Am02jptkFDDlblrhCZHTW7N730bLEoXJwcRhu6ue016L2BW7quYG8OcGql+BFKGblx2YlH4x1Qde8j1lmL4qbkUDyqPSd0WoQVc4WXVTAG/JenQqJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVsvnTtL; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVsvnTtL"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso2337412a91.0
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 05:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907062; x=1790511862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NtyjzrgYhOa3bpnnzl8J/NBn02c098QytsBeznFYa9A=;
        b=oVsvnTtLtCKDLg4HCtVf+J0H7KqqzGjkGjf9uIc1WqBXDo0kfuOzicaeZ0LeQPY4he
         0VKcQrWy6mMDV+RNNdgDB066cSsUBgtsXBSZAWYsNSl0HTHs2+cSH1AXzkRrdF3U0gkd
         igHDv+M7a3RlFIXGTXvvOe2CNO2P+4HCC8XvdkGFmOeHWrcr0qONp4h9M8YcQlk5q7mA
         emqsox1e41yh2moiX+MN9KmhXtuRkyWAR9kJ414PFB85kiITs14v5u8uiglk+sgL7ppS
         MzY1AORoBSD2LFeWyRzoYt2LHvMIZHN0mMv9QshM67zISqOPYPyW8ibGw5fxV/lDGQeN
         YC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907062; x=1790511862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NtyjzrgYhOa3bpnnzl8J/NBn02c098QytsBeznFYa9A=;
        b=Kp+FSb86/3OgBpBuhHaHMBFKIrA9KcujkGKP4FvuNepOOtq8+VxrBp/aXWDaWQ0cRl
         E1E3J4wktRuPdoDcuLbO46ukMfl0VpZGGlUE3TKJeILNpVRg912JfGl9AtxP0g9b5vVd
         9jBZ6XlSmnxPtPh+tuy4FuY06EGMhMTcs97fZ4aFjXoOIKUmQI8N5/L1llycGku7wSMA
         LFodM9uzHWeFN+WAYXDn6/U7yHcTlS9wPncyxa/AQ0lnbxr6qtXN5xImtkHV0YE+CPot
         r6oA+2TMgbCHcP2Uly9Umwi7cIUZTOh9vzIYXOnjV/caKn8UFW9IMJbSOrQsa3q8F+xh
         35oQ==
X-Gm-Message-State: AFuF++l5BaGbVQguci5rquJXlfIu78ST5kvy4qCYVQLveDokx7rlkY8t
	jM7jy5lNwnb13QiGwVAQyUJ2/Pl46hNNakFRdPBwmxjnD77J7aqJ9YQ=
X-Gm-Gg: AYBFou3aPjt4t7bE2GbsGJJPaU37yRHNdQW1jL59/j+LZDJyeiidq+rlWrxTuCY66be
	802iKGS1NLCi6WUPrGcHo3Ns11NCo7VH9jrR/kYtnNPPFvc31JJJ5ObfdxRNdyMazrQHpw4xMmY
	4aiaUiyYFK3d8E1dtzwPMAVYu1H6Otnuu2gQHJPFjn6I17GrIjpUXDfvLKj+qgMZ6G5QEZSjgc3
	Nlrv1EzhyBSkc3psLh7ReVNob1quZqNtMYxM3xmsamE7cwB+pqfsHwhaO3tM0zg3t8DIikY46GL
	hFaLfevDdiaukAo8YfshG50cN5ENwiUSnFbZfO+Jmb/RrdRIChfbOS5WcXsej+/QfTVX1rmez5N
	EZ+U7mzExAvQe7sdDSV7dLxulo5GcMu4hQ1+oLr7hVoe4pw6uxEJgSf++OG/9hEfI1CjvcxYBEi
	S+8iIxIMygBHUXwyJ6sLpoIh10duhe/vw2+Ch85G55yMcWF/HMbVRIy2+Or/UHP7dzLBArrNJYa
	QSBiXADEcAj/xUo72p5DEPJ5O0=
X-Received: by 2002:a17:90b:3a81:b0:39e:6a82:afd9 with SMTP id 98e67ed59e1d1-39e6a82bbe2mr6880094a91.43.1789907062475;
        Sun, 20 Sep 2026 05:24:22 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm8753943a91.11.2026.09.20.05.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:22 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v3 2/2] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sun, 20 Sep 2026 21:24:11 +0900
Message-ID: <20260920122411.610213-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
References: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() encodes the size quota in basis
points, so the conversion is exact only up to ULONG_MAX / 10000.  Pin
the three sizes around that boundary: the largest one that fits, the
first one that does not, and ULONG_MAX.

Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
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

