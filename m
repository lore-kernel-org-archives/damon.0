Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585561;
	b=B+1Rkdbpm8AZTcdQn7m4WHwo7JE+EtEexnqm46u5DLahbWGFEOqmyYsITin1oLZB2DXw
	 SAuJliWyPmDDZWcQ8xEhYBTsOtRh5Et59K6NwiiIWtD+hpTxA/+jQVAfxLSOf/yQeCPi+
	 XFqCeEm+lUykDLI2wT2EaZCjSmvilN15qenyE/FLYyFA2RkiDhHsZYarJjKeFDqoK68OS
	 7dc607sbBP5xrEWBIiSeUbRrQqXv12b1pp9jnBn7rB8mvX8GvDQZT5fCMzW573izwmiLW
	 stvfE5HivnT6C2Bsr5nKFV/cpgS5gKXGmU2vZSoCzOi8uHLluSpIar06jh7c3P2SgfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=BUQE0kUGDk8M7CIw9MtJvjFLkWAN6uJ898YNqYUmUwc=;
	b=SXummT0qiPOkKmGuyCXTYnqbZhtw1vdk1H9AXQlbnZ+RIrTduCbK8DQPD7Q9gcmr5heK
	 pM6Nc1cjqoaKKqg2A0s8CCcFt1PtZsttcj9ezxkXmZNzuBdI0IPKDVElIUB7f0TfdvgoH
	 nLm/dzuMpC0gyjyFoCipk3/UsLkhWuqKvcczcgevM6z/TuAe0VH5JKXelILNJ1337DcPP
	 BeNu2dIupzeqtVx9DS+6iqeBqk1bKhQlcGEueqmNdJGfgBaCyIRDDCzSHl+O5AeI/tnUy
	 J5rA4SgYcxjPclnV9/7tCOcvsLdMfmTU2MiaAueHYse2GzrXiCysu5IplNxy2JRlf1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HeLBjTvQ;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE08B606BAA8
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 15:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE08B606BAA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HeLBjTvQ
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so978655c88.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794585560; x=1795190360; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUQE0kUGDk8M7CIw9MtJvjFLkWAN6uJ898YNqYUmUwc=;
        b=HeLBjTvQd7OsiT3k/LBq+GieNkxxvwd17eLG4XbpHuBRb7udnx3nTs3UGPnFgobIxj
         unMk/BbdY1G09TlXEPGxHoWjc5L8BY4aoW6rWzvbG02hum+la+uWnL5Y/Jo5TakNbXH7
         rDyVhS8VpAY9YNvjJPAT2q3m2ZNgGNh4xW66/DxREYWoh/AzfvTeVzvVVpqZXeLdAYkp
         bAWybTjHt383zWVRIMdd6DjwYGdBsG8NN8ShgfPJGWLaH3KS+YY0xV2G7MYwJIQI/9mC
         VMf0tLk9QiT/zFyUlXIpdcASZtXxdhiZ3NFbW64v/DogMUuw4hAXUy/j6CEJ5ZLpGwqh
         /cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585560; x=1795190360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BUQE0kUGDk8M7CIw9MtJvjFLkWAN6uJ898YNqYUmUwc=;
        b=2VQuDnY+s74MyfgaIaE0svM9cuNClY2IItMq5WPbVCvpgYuzmYxSVQp+qnTdOFbqnt
         LCBJK7w0tn2z5+mVtKmRCQAAtvI4LWK2wIxicyX1M0ik1gWHImBqtn07pzxJ/xvckfAL
         SreARMVk7wR5FFjNnhTGxa2KHDILzeJ3Qty1pHnzUThylptZdqh4/kBeWr0OSdl2B+/9
         TbkCMzEb7925K1Ge/Y5xX8V7Sf2ZKDSH+IIqzZrCGt/KjioyA89KRefIcnzAAOSFNTFW
         otZzGVbj+3jULnbPFRr9dxXuQV48gf7LzAadiKXk0pxR/OHQxbt8H27kCgv5k1qu+nQZ
         xt2A==
X-Gm-Message-State: APuU4Z9BB1vA8/v4rffKsYRikfCJCh3b/X4/8EP6IIPRpVePS+urwbgO
	GDrYL7EEwIJ+eisAjX9KbfyR60eJOaE7YHHKBIIPI9JZQ0vaMWZkSpi6IhLZxGXx7z8=
X-Gm-Gg: AYBFou3V6/6F6btMpwJnD4xTBbMRTxw8nljZjW9o0xzT9qLnc7ps05dNJspHInUgzil
	y64VfnmDsZ3YFeqFDH+yHhvpl14PRRFb2jDry2/ZniUm2hZMj4xI/uNwLyz/LsQzTfm8RH7TwuJ
	3T0ocat3q49d27igl1y1iIbA2ZE9KdrtSxo1YS0TFK/pAF0c0ET/rhp1GoqAccO/jpwORIxlWAq
	lwD3fXNrTpsLl1xSsNdP+OmKqYpg9/95NL4LNNvok5pKgsU1WmGJuDpRZdG/0xgaPObocTGFk90
	7baqMDuaNgsPqrEVqNZiQ3y+06K1s+LJekeM0tgl8X5+WIar++wszZApXwECc6/AQwW2kLBdAFk
	07xPS5dzLRrfsaWBMDrqtx/DBJctXTiU8AT+VRG41TWmnI+uLtgWEj4AZXQ96WBEnLB3M1YyOLo
	MKrq70NJ0yF61BUiATj409m/TpLyveauGlntlBCbXCXQQmEOHsPAktJCPPTnjq/eKK/GHEgIzOB
	XtKETqUhAqzEHX32kSSR6y/EgVRfRanyOYEgq5mlMLuBOcloo5BAVB7nFD92CWRYieC7CTe/Y26
	14IM5RRC/x5aSGFmNF+Z+v3EwGptKA==
X-Received: by 2002:a05:701b:4590:20b0:1b3:b53e:b4c5 with SMTP id a92af1059eb24-1b503137aafmr2631085c88.38.1794585559658;
        Fri, 13 Nov 2026 07:59:19 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm7868383c88.15.2026.11.13.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:59:18 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Date: Fri, 13 Nov 2026 07:58:57 -0800
Subject: [PATCH 3/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS interval changes
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-test-age-ms-filter-v1-3-b99eab2f71bb@ucla.edu>
References: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
In-Reply-To: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
milliseconds to filter for target regions.
Aggregation interval can be changed by users or intervals
auto-tuning features.

Add a kunit test for each:

- convert region age to milliseconds, correct behavior at boundaries
for defined filter range
- DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
aggregation interval changes

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 81 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index fb84d30a712d..6de7c2531702 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1837,6 +1837,86 @@ static void damos_test_age_ms_filter_is_core(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
 }
 
+static void damos_test_age_ms_filter_interval_changes(struct kunit *test)
+{
+	/* Filter window: 200-400 ms.  Start: 100 ms interval, age 0. */
+	struct damos_filter filter = {
+		.type = DAMOS_FILTER_TYPE_AGE_MS,
+		.matching = true,
+		.range_min = 200,
+		.range_max = 400,
+	};
+	struct damon_attrs attrs = {
+		.sample_interval = 5000,
+		.aggr_interval = 100000,
+		.min_nr_regions = 3,
+		.max_nr_regions = 3,
+	};
+	struct damon_ctx *ctx;
+	struct damon_target *t;
+	struct damon_region *r;
+	int err;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc fail");
+	}
+	damon_add_target(ctx, t);
+	r = damon_new_region(0, DAMON_MIN_REGION_SZ);
+	if (!r) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "region alloc fail");
+	}
+	damon_add_region(r, t);
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(ctx, &attrs), 0);
+
+	/* below window: age 1 = 100 ms */
+	r->age = 1;
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* inside window: age 2 = 200 ms */
+	r->age = 2;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/*
+	 * change aggregation interval 100 -> 200 ms:
+	 * inside window: age rescaled 2 -> 1, still 200 ms
+	 */
+	attrs.aggr_interval = 200000;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(ctx, &attrs), 0);
+	KUNIT_EXPECT_EQ(test, r->age, 1u);
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* inside window: age 2 = 400 ms. */
+	r->age = 2;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/*
+	 * change aggregation interval 200 -> 50 ms:
+	 * inside window: age rescaled 2 -> 8, still 400 ms.
+	 */
+	attrs.aggr_interval = 50000;
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(ctx, &attrs), 0);
+	KUNIT_EXPECT_EQ(test, r->age, 8u);
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* above window: age 9 = 450 ms. */
+	r->age = 9;
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	damon_destroy_ctx(ctx);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -2599,6 +2679,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_age_ms_filter_is_core),
+	KUNIT_CASE(damos_test_age_ms_filter_interval_changes),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
 	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),

-- 
2.53.0

