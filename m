Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A127380A
	for <damon@lists.linux.dev>; Fri, 12 Jun 2026 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245454; cv=none; b=sdBm28FXbecOZLRpLX2TGOJsaJ55zEvtkxtnCTORggBUasWUpKssObxLFfBAxEtnT45idKiI0QdXZXXrIGjy8ntvhWVi0wvFLyiq+5riEURF5AqgyhWMywCT+KeenQyd0/bnMmXWMO77FvsaYq7Xp6yoBwzZKxf/17SjU4YiTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245454; c=relaxed/simple;
	bh=V4degicP98YaeLR08jiuNOlhbT3ArmkZyO1D0XGygGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAAqUcDZM6DdiShGIeY6S3JiuoBS6P4P/kuptMYbuMEXxASEbkSGn1qbcjjzo1rl4Pr9NXfiRqtCrbpY/zmzurnsj+N5GASJso7dGH9d2HyTGP6VYwgwY0Wi6Ral4CZkkFrEbrRtNXQZSbcDH8b6KipV9SOC6fHHConIGzcgsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqAQTuEI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqAQTuEI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2e8d381so1388775ad.1
        for <damon@lists.linux.dev>; Thu, 11 Jun 2026 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781245452; x=1781850252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45sVfS/nx2nzBsCxkzCB9QiCoVHDr0etpbiBAxE4XQM=;
        b=NqAQTuEI79priB9vWDwiDvRufNDymj1o0rcmsNgn7j2bo6EjDkmy2NoMCKbfofFCp2
         vS6wT5sSAu+K7+lWJgcYl/UlOZ6qjG5r7JkpRD97uuMzZlYS1iisjDh3KL3somPgZ1Ob
         Zr5HXi0HPO4W9/jcjw88m0JRhnrzfQcmzZBhE07jI4pWMzuee9BrtwTKtbD0/cum8ScY
         HRvjlwJLsdh+0B4zSHesNz9ypuw+/kvNbuPjREArhmA1Z01mQ0FwYWbFbSbheb/HlIO/
         bIRQNMPo9p9dpFR6oKTyWBkJg3Y/DBwuoAFfOetoA+QQ8U3SW60PsR2JVSvK/Er84gxI
         7Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245452; x=1781850252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=45sVfS/nx2nzBsCxkzCB9QiCoVHDr0etpbiBAxE4XQM=;
        b=JLhuBkFkfsxjVMh0cMlkNjMNmQlBqon1kb6tw+PETequ4qWaWXRykmDtkIMZzCO/6t
         CTwl8ZvIWvHEFYzVvFficCUX6LdI/6fJY6P9fPfUdTpw2edhvBm+KOa6NgllGUr6lBnv
         CcYQeoxc49EhJA1G+bo9qv7YgIqKxqozAvk0zgsYuMAWmCi8YrkbKIvjXaqz8WQfIfwO
         c4iK/2J+JRxnWLlCQcUl8COUTkCv+npOBynqxRrh3rSReFnYIlWnR0g7yD7DsLTpDLV2
         JaO095eM5CEdGmR8WHevArIIWiIpPrFdVgmDa986TNb/Oq+wKj7HI6ePwLM55NsyT8Ww
         bXsg==
X-Forwarded-Encrypted: i=1; AFNElJ/i/OycOFbKP4Iti61s9Rr3k1rGfWmNhN8CbwC9zES49v5xYPUAB6FQM6GmVR4ucVcmdks7eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMUiY+6I79pCO7Doe4Deh3FImR2OMi7BkPFRzniX6pOmPx/2qS
	VBAsGX+HGBqanz+FUaqra0f/IsPQbTG5CEiAhbaxN6kCXf0YBRAHzuMj
X-Gm-Gg: Acq92OFFKYF4XU4ii9xySCwOi6+776/gxUrlMLCawT6km6pFH7qAjCspZavr7wPKcRC
	dQcTNQIQIcdiMYtnio1245BCft5hlktmDxj/BK2PlNSFUvgTLWWFa2eCqCqHgkfbuB6qyr2+uno
	tSWmCz99fQF1hav6D3EJfzpkOAIuFHtvkSZEY8KolzYVqc5hSCXTFS+pXtcO3qKXrtlUtEQWlvr
	AdiOAT6hKtXSlsexq5cVseeeAZZvVJnrKdewqOBpEIz39cHbdCjPk3xg35TPEoXHG3FGZ1K4BC8
	HMNHu89rPVjj9LP++qUP+o3BHyMJVIf6C7rKjWK+vUfKItR4OoVaOLq5/jIzaY6g7LgUE/WwGL1
	66ozzQOqhIJAP+ByVLo30WsbcIvkegdDSwoj6AHp92voWeY3J2GWJPb0EomqpqaZBHS0RR1vKOU
	pfNGOPolNapvKU2Ra2en3w/S9HOtWxjAWmySJpvtxAdgl7AXM=
X-Received: by 2002:a17:90b:2c84:b0:36b:9798:4f6c with SMTP id 98e67ed59e1d1-37a0468a571mr789060a91.7.1781245451640;
        Thu, 11 Jun 2026 23:24:11 -0700 (PDT)
Received: from localhost.localdomain ([106.195.67.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9cd8dsm1064680b3a.1.2026.06.11.23.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 23:24:11 -0700 (PDT)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: [PATCH v3] mm/damon: add KUnit test for walk_control_obsolete behavior
Date: Fri, 12 Jun 2026 11:53:37 +0530
Message-Id: <20260612062337.2459-1-saileshnandanavanam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524100258.36819-1-saileshnandanavanam@gmail.com>
References: <20260524100258.36819-1-saileshnandanavanam@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a KUnit test to verify that damos_walk() rejects
new requests when walk_control_obsolete is set.

Commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs
kdamond_fn() exit race") introduced walk_control_obsolete
to prevent a race condition where new requests could be
registered during kdamond shutdown and never handled.

This test simulates the shutdown condition by setting
walk_control_obsolete and verifies that damos_walk()
returns -ECANCELED immediately.

This validates the invariant introduced by the fix and
helps prevent regressions.

Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
---

Changes since v2 (https://lore.kernel.org/20260524100258.36819-1-saileshnandanavanam@gmail.com):
- Dropped the userspace selftest approach entirely. SeongJae tested
  v2 100 times on a kernel with the fix reverted and it always
  passed, confirming the microsecond-wide race window cannot be
  reliably hit from userspace due to syscall overhead.
- Added a KUnit test for damos_walk() + walk_control_obsolete
  instead, as suggested by SeongJae. This directly sets the
  obsolete flag and verifies damos_walk() returns -ECANCELED
  immediately, without timing dependency.

Changes since v1 (https://lore.kernel.org/20260524091812.35283-1-saileshnandanavanam@gmail.com):
- Addressed sashiko bot review comments (execute bit, threading,
  dynamic sysfs path, OSError handling) - superseded by the v3
  approach above.

 mm/damon/tests/core-kunit.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 9e5904c2beeb..599aac056b73 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1336,6 +1336,33 @@ static void damon_test_is_last_region(struct kunit *test)
 	damon_free_target(t);
 }
 
+/*
+ * Verify that damos_walk() rejects new requests when
+ * walk_control_obsolete is set.
+ *
+ * This tests the invariant introduced by:
+ * commit 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race")
+ */
+static void damon_test_walk_control_obsolete(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damos_walk_control control = {};
+	int ret;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
+	/* Simulate shutdown phase */
+	ctx->walk_control_obsolete = true;
+
+	ret = damos_walk(ctx, &control);
+
+	KUNIT_EXPECT_EQ(test, ret, -ECANCELED);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -1365,6 +1392,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_filters_default_reject),
 	KUNIT_CASE(damon_test_apply_min_nr_regions),
 	KUNIT_CASE(damon_test_is_last_region),
+	KUNIT_CASE(damon_test_walk_control_obsolete),
 	{},
 };
 
-- 
2.34.1

