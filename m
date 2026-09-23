Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E92E7391
	for <damon@lists.linux.dev>; Wed, 23 Sep 2026 00:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790123173; cv=none; b=ICQzFH0R+k7VT0x1cTFq4I1PV7Eds6cfX9LK3w0TsrH11xknJHW/V8ClTNN8CzdYmHoiqSJKMt+pyKEqds5sbHRJSrw1WU5iv7byHHhHFsy3zSKl3LmTgpbVi1RO+zMA/qPkSBKnQVXGaAYhwVbJ582D24Jn2QC+tIPwWgIlHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790123173; c=relaxed/simple;
	bh=KblCp5Jc0jNWn7Y/dXJ1lznx/zRC/if0zz0c3bQPz54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjFcHQF4YeAAjUH35UObLfn/4FJJImB/DeuQfjnvBsUmq6gBtWMG8X3bN/H95pDYfzZ4Atf7pGh6t+vKZz6TlGIBf2LJU0fozT5mIwKXN6qrVEJsBhAUdTHSWqYBK1nzJO4heVUb9YVw/879yMTP65N7srRkkgAMLxE9rT3f3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvkFqEXV; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvkFqEXV"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d91c22d27dso1480825ad.1
        for <damon@lists.linux.dev>; Tue, 22 Sep 2026 17:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790123171; x=1790727971; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=073LFNHYNcDRZAaaJHUMAvNgAbfdcL8a4X1+nmCa0A8=;
        b=cvkFqEXVDo58ZXLvS55XLPj37ELkK5r9yF0+ED+S/DcL3dFtbpo9NZrtBcZFbve2oB
         pxSIkTh0vXJXZMK/YL+NcNNc3p+Lr8Avx4OyLTFvN58Jlodb4w4hyYLyvNITzZpBvZr5
         wxMvQKt0YkZIDH1XKaZXDtf+4t85jZ9fWLzAwzbO2QsOZzAGHwTPYaVWhJUB8/VhphuJ
         V1TvrFD65c5C9qAqDZjm3T/45y4s8C8u8Rmm/Aog6CFbfwqRNwucQ0Yl2y0sc9pOlBnC
         iKTo0K2KJwl7Wz+3mXP/e8cq3slPTSz1MgTS8oY/H5CwYDHwxrR+us2QfdOD/tYSLRpQ
         5kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790123171; x=1790727971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=073LFNHYNcDRZAaaJHUMAvNgAbfdcL8a4X1+nmCa0A8=;
        b=fiSqX9FP97rq8IIF/FrPpOb5GFgw93zoL6i2ubCuua5sS/ejh0EAz0K6BRLZLQ9CnR
         zNU8ZetFFPTtrNSDI3FfLBHV8a3twc6A6gWPtWiD85XlTM51lt27wkzn7cKo5N5tCbNw
         P2UymFjfUyp3pXDHpzrNdmKp1PtFGaNCAWjyxPF0049oyheP2PzrR3paTEehJ16JbFUN
         QgzN6KdRYef5eukeTdSXkhcWCDS3GR7DD+Ndd+NxpZTgvtR+kwq2PfQslzxkvgGj5U8d
         5B51Rg3xS3zeIMJwhgbDrVkCYg3o3kAAEaSNfIjvrgM+LZk1dbZnBPcZjR3ujDIuT9pX
         WQsA==
X-Gm-Message-State: AFuF++k70iUxGqnErv1ErkehA1eiB3TjGYEcGnQantUM7d2r28kPQgvp
	BlKSh+68P7G4l1Zb6rBGUsMfped6EOb4wyKtJPJ+T18fQVLHw6jVPk4=
X-Gm-Gg: AYBFou18FuPKWgXZYK4ajn4U36e7gJ9SqlIT/VSkGU1F9mMMT6kno4czpDlZRUgNMso
	Ud02gmzLmgVmkAvdqsCH3j3zbkIaYWfgR93+fJ1JTnB718exaNc73QcEwwymokTvSaG171LNaJS
	2y270qmMjuRTfv898CGDk8Dfsr29frzNFoOvVgjGHASuPKI4Qb0v25T0s3Qg+VIA+o63s8bA39T
	BF/vbi7FGuBr20bXjw2uAFf1wecLyRyxJ1xbfBNJQxjvafv+0VcDzLW9ozicTnyEblZiWBi5YEx
	SzMoOpqQMmrvzbF+NdWjcgudNI5AwlGKVfWEjUV1uK8kzLVMkBfqRXl5fayfHfdwI9dBUDqmvpm
	M7WFjhHB/N7Wrzov/rELab4u2BaWXJUVudrsgSi9g2SLEozuY/x5+D7lV009xo4y5Hy0Acb9Wys
	kPqqMOreKWeRyKcluqdgmdmIuOpr8brsXUlgTgwn5d3nM/n/1zwbwss00oNWDpVDWGwz2tP9lBb
	DMJ98eedUyPdJco4QPLAZNtbIr63OKwCt+MEkM=
X-Received: by 2002:a17:902:f683:b0:2df:3872:f266 with SMTP id d9443c01a7336-2df69d0c450mr8862005ad.8.1790123171214;
        Tue, 22 Sep 2026 17:26:11 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5a7b76sm2176595ad.20.2026.09.22.17.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:26:10 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v4 2/2] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Wed, 23 Sep 2026 09:25:59 +0900
Message-ID: <20260923002600.1825448-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
References: <20260923002600.1825448-1-donggeunyoo.kernel@gmail.com>
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
index df84d9cc7d204..bb20c6d01b692 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2242,6 +2242,53 @@ static void damon_test_rand(struct kunit *test)
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
@@ -2281,6 +2328,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damos_test_esz_goal_temporal),
 	{},
 };
 
-- 
2.53.0

