Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBC3B14C8
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531517; cv=none; b=dWxcPJ2dXpNBjA3BZes1PT8B5y+ORrujddB8ymQJ15DGDP9gm/YzSpeZ3Ma9DCLG/MbRfJgLNzA+JNpXZ+6urlRU1Wyx2VwgUQrTuG5EEWP0ieOKs3k8hxpx2WNQepEsw5sqYLoZBEjPxnW36t3h/JIN4gCNmVX4maQDwYO03oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531517; c=relaxed/simple;
	bh=Cf8NIJkWVY8TWvFnYDbn8a8mY24SXis/B6SkCoozzm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ouf0USQA8OFixdWOSlkHNn7rJZWQb4aTd2uiG0bZd+n9AL6k8nSBXCK2gKnwk0t9ziWgsZmgFXR68/LCPFNXhHtfIiHOddrKlZdCp5MNXdbfxzorajBqJytL/krb9+hyEoU5VbgcGFooV1OjKOlxk3kkDY4wlFaM+VY3sQ/rbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he7a2yRW; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he7a2yRW"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78d59bb02so712267a12.1
        for <damon@lists.linux.dev>; Sun, 27 Sep 2026 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531515; x=1791136315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwmzHbcrjIY/XcCe6sCdMKV/UzCFAPbJtQGnBjUsEZY=;
        b=he7a2yRWIM1ykLx2nq/Twbp4JuE2KvMM5NJhilq1K5Tr/MFmCPtTzPRSOdmEFG2zwd
         Mg3kQZehgnbyGRA8U2HaZmv/RpPk/6dkzuySiexubC0ZrNc6qrEMe5EEZmgloJGE5bGO
         2ycxMVvs+w6OVwYV0hqSkbCJfCZIrXl73EYd+4SFR11IPZyPjmYTk6Wu8r0+8cp6D/4s
         Z6l7bS8kwmiqIwKGlnuxMK+H/8AYS26Kp7kfCTRbBwmqKMfokwknt64g4D+FPiQJ8Ezt
         HVq/xTrh+BLsqg607v9mzW41XtdH0tnB//eZZXMt0Aj4Fqidm8NaaD+BzFAmTo4NOjTh
         pU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531515; x=1791136315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kwmzHbcrjIY/XcCe6sCdMKV/UzCFAPbJtQGnBjUsEZY=;
        b=g96svSu3PTBfdhoxaQ57Rv7x+gl7bs+YeedClpNXxmHWqvxAbaOIiHkKYCNpmIgO5l
         47WOXReYinJz09nTaD0vHJVRfRMjuSzQWOFJ63SPYjDGOrBenu4Ecvaxi4ezwyi/fSbV
         KWrb9MDuET7v3/+aznGQO7H6UouDEi7u10v4d45mhINSFpyVuc76aADHIsy5oEuYcaGd
         CpUmjBcGoSNTAUq04ZH5PudAUcC7ZJdn98Vy61vViI/EmM8SNBgUmu4vizTdTfZA5uiT
         Xpz0riyYRcuSMq5hMpx2NI5cqwXr/IO2wK0rbo7TF5gdUUsH4ZzKTlfDqRsCbHFloH19
         0Dfw==
X-Forwarded-Encrypted: i=1; AKwUvByblF2VQzEfVts1z6DEZJe+/GIzZpD1xYFAKu0gk/gmx3X1p8Jvj1aSH5hoVuk/0Op3Z8W7kw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ9s0hhbpNWK+PtQJ/fz5SB9XWpykEat9e//PMke+4wOUpTjyLz
	j3LGhljWykxq8fot9A30kV0p73qrOoyLfBoqmsEx8fgnLORujk4Uh1kU
X-Gm-Gg: AYBFou3Kmfr+okv8H/fEaNSzMY3K3/q9lzsalNJYPYkH+K9p70ZEXkXl18ZAv97jXnQ
	gdu5AHsjMeCapqq28nwmg28hR4xZRjfubsabu2FKb9ai8KkKr9SqgQGODsi7EkcvQh409iGHe1a
	r404ez1j721lBiBrr30VA7rpjiH3fpM0e1uFppf3ak1uUau8dMy/ojwfMbbZgzdpv37ydikOhkp
	AViQV9KryHJ1lCg6F1UgbRaL2nL77p4k8vKV5RHQdHagg2qxLsfPuoAlLUD6Bbt0Rl7wDFVD8um
	OR9O9XndoYGDuzoZG5xAyPf+EWD9TkwmJDwWevhW9afygDh0s4HLk+rFQ2mS00I6RxnBfpeYrp3
	u0HW/+vYU0yCMLInw8mzHG76s3z7AZokhoB1ODug9AtiZ6LTqao2MSQ336p51RiktlOFJlZrV5m
	3WsqVQaQm1M93Bx4YfU0wwnlto7NzmpFObes9He2m4zWWBaiifYgty46qE41DZk4BUnFbUn6Sup
	bMCutYjNuI=
X-Received: by 2002:a17:90b:440c:b0:3a0:c8e6:ab30 with SMTP id 98e67ed59e1d1-3a0c8e6b9b6mr5659510a91.59.1790531515391;
        Sun, 27 Sep 2026 10:51:55 -0700 (PDT)
Received: from celestia ([2402:1980:867:387a:70b:38f1:a1dd:9303])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9355e54sm15597784a91.5.2026.09.27.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:51:54 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Mon, 28 Sep 2026 01:51:43 +0800
Message-ID: <20260927175159.60703-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
region") fixed a minor bug.

Add a KUnit test case to cover this behavior and prevent regressions in
the future.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v2:
- v2: https://lore.kernel.org/damon/20260925045350.66595-1-aethernet65535@gmail.com
- Change the commit message, mention the fix rather than the original
  bug.

Changes from v1 RESEND:
- v1 RESEND: https://lore.kernel.org/damon/20260919080453.628679-1-aethernet65535@gmail.com
- Drop braces for single line, as suggested [1] in coding-style.
- Set min_region_sz initial value to power-of-2 value, '1'.
- [1] https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

Changes from v1:
- v1: https://lore.kernel.org/damon/20260831113735.3349-1-aethernet65535@gmail.com
- Resend since the dependent patch is merged into mm-new, that would
  help us getting AI review help.

---
 mm/damon/tests/core-kunit.h | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2..f4237436e1b4 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1632,6 +1632,47 @@ static void damon_test_rand(struct kunit *test)
 	}
 }
 
+static void damon_test_last_region_quota_reset(struct kunit *test)
+{
+	struct damos s = {0};
+	struct damon_target *t;
+	struct damon_region *r1, *r2;
+	unsigned long min_region_sz = 1;
+	bool skipped;
+
+	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+
+	r1 = damon_new_region(0, 100);
+	if (!r1) {
+		damon_free_target(t);
+		kunit_skip(test, "region 1 alloc fail");
+	}
+	damon_add_region(r1, t);
+
+	r2 = damon_new_region(100, 200);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "region 2 alloc fail");
+	}
+	damon_add_region(r2, t);
+
+	s.quota.charge_target_from = t;
+	s.quota.charge_addr_from = r1->ar.end;
+
+	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
+
+	/* 'r2' is not processed, it should not skip */
+	KUNIT_EXPECT_EQ(test, skipped, false);
+
+	/* 'r2' is last region, it should reset charge_{target,addr}_from */
+	KUNIT_EXPECT_PTR_EQ(test, s.quota.charge_target_from, NULL);
+	KUNIT_EXPECT_EQ(test, s.quota.charge_addr_from, 0);
+
+	damon_free_target(t);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1664,6 +1705,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_is_last_region),
 	KUNIT_CASE(damon_test_walk_control_obsolete),
 	KUNIT_CASE(damon_test_rand),
+	KUNIT_CASE(damon_test_last_region_quota_reset),
 	{},
 };
 
-- 
2.55.0

