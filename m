Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167AA3A9018
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 07:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789802020; cv=none; b=iC6jCbn1bo+bBSzaD3Z+28xKhN9xkzLX6xDpcEqF5Pxwesoj0iU/uhZfxz63ZsAQRsX001jQeQvjGxQGbZF5AFMwcXH4nhVsSU9cSkCfYJ6hVcHFLFqKbP66jpfj6c/dK7cvc6bshJ7ZRVZdYS9j9knTbEWgI2NDHKHoUOPEZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789802020; c=relaxed/simple;
	bh=fYrmY7I61SG7Oq9N8JqryYeMpZkLC3QMjwmM8r1nkNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7URkWxKRiQrhOuvSD0nxJnbSSFBk3fXvA0ftiraM3/ls3qiMt5mLB0OTm58zP5wDy2zGL9ZHwR9rryEhHQd+nONldNb5+JGcDyfHbglbLJm81Jz1Kw7por4VNn+V1PAeHhq3TVg2MQ+bZacXV0cJCpEPzyGP4R7W5hoPhV9ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft8qI8e/; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft8qI8e/"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-398cb5615deso1671514a91.3
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789802017; x=1790406817; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlJRvd2rG1Bz2EK/T/fTdnK/hmBMI225GJHFCiKFLUk=;
        b=ft8qI8e/JWmDcLFpnaXm2yQ8U9lLM2Ri2vh6RkoQHubKydnOK/OhXlkq/V9vvv3DNw
         7fnilcejFHq/FxYp3k5hXoQ4dqFR+g5PgBTLV3I8Y4abpSJQQoeVRtIgl0s5ck7LynlH
         uJisGH3sILuplUsks6UkDeIui0fnDAOiFbLu7aKB/9PgWESP6C1MHCBXkalruN1971aO
         m/32r8qSQNMMlk/48clLqhGhadYcbsIHpSN9MHMcudz25FKRwcKZTB+RThQfgGSnrH9y
         t8xdpGOPEH9FNEcEnmLhgeFvD3nfNh3PHMW4rATQ3eiY0aqYr9s/SiaLyz2bVS/mRHUT
         M8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789802017; x=1790406817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OlJRvd2rG1Bz2EK/T/fTdnK/hmBMI225GJHFCiKFLUk=;
        b=deKAKExNJY8s5Gz8Era1ehE8IOd6uISOQ3Z9WggGb3ljntD+ME+n/fZwnysjqUkuSd
         tpEpZD73BwE+JQNokYS/hp+caqo3ilYWpBEaMiQ7rc6XrZM2w7Q0ZwmbTbdPeu8XCZe3
         8IayRCUf5OWYO4QQTsCivl1BcZFTEemcwai5NBBtzVs8Hgpm2s9dJJpYZrVSSGYVgUFi
         8tdsl4LHX7f0CxB0WVTUzBtLxz+1q31TXGcU/3bn1KZ2ow7J6CtL6MWQy2792CcQuSAt
         I/qGeHYQq6v249tEL5aNqNwaQRECgRnO8jGOksC0EmWuZ47qugF5JaziKSDw8QtIF+r7
         bCkQ==
X-Gm-Message-State: AFuF++l/ugxcB/FMmUD3xjhQiSo5FjVYXxJfl+NkfL15TWKk/eqhchD9
	xjJO1qimGe5xfMf9Xx2WcpQr1XKlHNG6Q5h64ApLENXvtyQ4e+DvDDw=
X-Gm-Gg: AYBFou3xp0OqxrvZWq4wBuDFIPrxUYND5lmors1TY1j9xwEKpO6W8OEsQN0UKrhP1LC
	mp8iurt9xhSM0t4gVzbPOIJp2kaplU3ffeUF7XR3beZWx/NnArzQ2arV0Yvheys6ZY3UE5HrM57
	FnR7vmYtATzJak0jCLq+g9fvovwgoyuwTXzYUNiCZN7SZT3SP07hu40gzlRXPfpDRafd3dgR0as
	L6V3caPOwV7P7rNK6r4/ulKvAJLf6SytDaO8yHShmkKi+m1zysK+MWReHmXcUPGy8UeBk5JBWE0
	QqBX6Z1EwpxpXZs25CkkPzb2l5RFUvDSqUJ9p7pIWT2lc5oIdU9bQ6vqKgKLaTGxk55WcEP4NJR
	qkUaxpkMeyyT+yycZdmYzLQG0NoMNYc/2vL7i4aNohWUj8ZGMtjEd6d0PevsIfXT6oSK/d34+JH
	KFVHkqOzQ3y+dSZcuu5DP2pbDEFkRqpeT6ZLwC6i7Vc5ZEv5WD2WPZI4ynqdIQNKCjKSgi/rS4G
	UMtwLh/wHjWAHxIZoIQBYMhb+c=
X-Received: by 2002:a17:90a:e7cd:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-39e549bd704mr9273357a91.0.1789802016898;
        Sat, 19 Sep 2026 00:13:36 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:45e5:9e39:6356:6164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02738654csm1050170a91.3.2026.09.19.00.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 00:13:36 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v1 2/2] mm/damon/tests/core-kunit: test the temporal tuner's size quota conversion
Date: Sat, 19 Sep 2026 16:13:24 +0900
Message-ID: <20260919071324.1583280-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
References: <20260919071324.1583280-1-donggeunyoo.kernel@gmail.com>
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
 mm/damon/tests/core-kunit.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5ff0436c5844..4460dce0352c 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1929,6 +1929,40 @@ static void damon_test_rand(struct kunit *test)
 	}
 }
 
+static void damos_test_esz_goal_temporal(struct kunit *test)
+{
+	unsigned long max_sz = ULONG_MAX / 10000;
+	struct damos_quota_goal goal = {
+		.metric = DAMOS_QUOTA_USER_INPUT,
+		.target_value = 10000,
+		.current_value = 0,
+	};
+	struct damon_ctx *ctx;
+	struct damos s;
+
+	ctx = damon_new_ctx();
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	memset(&s, 0, sizeof(s));
+	INIT_LIST_HEAD(&s.quota.goals);
+	list_add(&goal.list, &s.quota.goals);
+	s.quota.goal_tuner = DAMOS_QUOTA_GOAL_TUNER_TEMPORAL;
+
+	s.quota.sz = max_sz;
+	damos_set_effective_quota(ctx, &s);
+	KUNIT_EXPECT_EQ(test, s.quota.esz, max_sz);
+
+	s.quota.sz = max_sz + 1;
+	damos_set_effective_quota(ctx, &s);
+	KUNIT_EXPECT_EQ(test, s.quota.esz, max_sz);
+
+	s.quota.sz = ULONG_MAX;
+	damos_set_effective_quota(ctx, &s);
+	KUNIT_EXPECT_EQ(test, s.quota.esz, max_sz);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1965,6 +1999,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damos_test_esz_goal_temporal),
 	{},
 };
 
-- 
2.53.0

