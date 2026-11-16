Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827215;
	b=MG4sul3zZWLeG8iUGaPmanpuEh2Cf7GX7AtHOMxoIHNCl0ei205hIT8k2nl1KtqLXUyz
	 HesI27wNWZLC91/Hg1WWU9ci2oLZc0teNCjvwD/2NGi1yTBZBjUrpUDLOHrAL1hbXJVil
	 SuqTe2EjHVa1/1MuORyKui5CZsqLImg4EVgA/SIRHJKt8EJtWUfjwILKwHKdmObzwwn0a
	 x7RtBZgNqPsWCL3kCNy/xI1AhO9iOhmUCgIML1Yj3yRYy2naEYn2AvY5291SMUc2uKi8E
	 L471abzKphiACORGnbWUYfq88pTlLr0y3WiUb0ArWOPKUxiovcSGNEWsvTzrfRYh4Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=++HRlb3lmLPEyFHs8o+X0oq76Kzwdkq3LTMbh5HSJ6Y=;
	b=ZTMaLfkSxiHrgSwI3Sm51QDnj5PLBY86GGUZUO2cWMTepASgrMCIXXy+aHbqa/VRhxSx
	 TSalBJb+LeJkjDUmOfW2dG8uGW3P5CPqrNNBWbwLD8GHqxcf8zuPR52ONgW6RY8kZqAag
	 ONK+NmgoNaj3Gg+tcp8Kfqlo/xIiQNN+BgpAMLmmsxKhDoKVRtUmEPMqTHgBC+69j/bf0
	 ycRARSo0tOXdaukZJobeNNCaFM2AWMib/DE189kpgfwKbsUILsJREHnZz3YR3N6rBFHsL
	 8FYd71hzvNVAcz+6lG9x51e1sstD5RrucO2d0C5WKCAH2wGrBI8XroLCFKd0/+v6fjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qHkLvMvu;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199CB606FE96
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 199CB606FE96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qHkLvMvu
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so4432658c88.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 03:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794827214; x=1795432014; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++HRlb3lmLPEyFHs8o+X0oq76Kzwdkq3LTMbh5HSJ6Y=;
        b=qHkLvMvuEEpTJA5Xvgnkrous2bCHXwRyaHFb+rgZDQQzkOaQUU4G0hVUz5jlbeUZlp
         +ADrJypQKq7QfqwXhPo4U90NvVPSOF1VFizoJJmb4LnjahMb+jrOsHipKRIVSVzfCI+s
         VZvpp7MBbe80/ctCSQO6OTOajBejmnhmE/IaBEOHYDy3nRpaoiDL3gOhKbHsDaB2iqA+
         HUAYiVmh6wuB3sGSt79HX70w0g5bRQNn/Afg0EYR+4tW/YLOfCmkKyzgPGnKNymYTJac
         uwzzIaTv5CLeY47Oio+q0INAXV31KPNzL2Z16w9Iucj3QviSlxp0uqYSBM//IcsKfZxB
         rK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827214; x=1795432014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++HRlb3lmLPEyFHs8o+X0oq76Kzwdkq3LTMbh5HSJ6Y=;
        b=n9+CttXw9eIvwDA0Iv3BLoPVd2fowsYcATk0hxBOnWV+AOAuZGL0dmjYfpV1oXs2EJ
         slvDWErfYM0W1DuyRww6GOsBr5/zp5+rUBKpyhF52OUkqO5GDueWSYn/0Vg0UAoHWuwQ
         73csrsPtfc3AIpyERM6iNZTLbIXniCKXuBUSiUzVZrhDyJTf0V4/tE4havocm5pI83nG
         DKOhA2D2dNHE3YTNNbr+WmaLBGZSPxbcbM+kgwfxOgYTK2BgpnYxBsJ11fb3Tp+gvpE2
         6/MMXbgwxxbE1/eFUasVrUc12jjluIMJzp2BCJQenMQH1agNckuLUYyRVIn/22Lv+Gc2
         UUVQ==
X-Gm-Message-State: APuU4Z9fqoLTVKXwGEO55am1dEhSJ1WBnki4mUJ/1FwoPsmaZMxrG7fe
	6+UB+TyMl4ahkCe9WMmz0Slyz0OudrVGtkttdQRhscgbG3k+7pudPxafvnVh/54s4YY=
X-Gm-Gg: AYBFou3w4mzSEzoVaivrFZhOmYlU8BUT/Y9h/MgnPNIGYIFJzhip7V1vTbNKBIbK5Yt
	eL8Dau2cQkv4ravAL+wH1rylchef5B68prbNAtJ0WGZaR9gsHi5zsq5fzGP7Re/ydOetufed5k7
	HD8dYtEjAdluurQIVGOPrFAy4RFb39SGlgM9qJdfNz2p3hxPkqCCHESjDA+PwteLjaJDV68YpfY
	Kfg257+APpvl0QAvZwq2h/+L93oLsYpwQoSXOvzHoxXY5/cERdzSkPmN3fUu32sfpGnW14u7lAt
	GevT+Gd7Ccd62Z0bzLtcjwd/9BqDbw4ZTNlT24y95q3k9JXOxWIoC8gqlsbsgZs5XmjmlrZDBsp
	tUk0kkPnQlPa5V9D4bwwY8UA36q3x9+rr9a/fHeWik5ji6fvkiHseDknNZQVScRFWqM7ulfzmvw
	vSg4SBr/iwQXL8CpH1XYiI9iZZHnTFzxemWK2j0WLUDudlTvwD/yLGpFejy5EZeQPyxPkjy6UuN
	JompnJIx7joPXVoL4RIwDSv7BxiiCahg1r/97QKQGvf86DzNNQZ+i261tyX3nqiTocOzwwndeS7
	n2KUeDygXNy9PJErbem2QUrVfQU5vTGgOlKh5DCB0CCPxRHePUw=
X-Received: by 2002:a05:7022:ea8b:b0:15e:9126:c60f with SMTP id a92af1059eb24-1b5030e2ef6mr9036471c88.29.1794827214001;
        Mon, 16 Nov 2026 03:06:54 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm12522103c88.4.2026.11.16.03.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:06:52 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Date: Mon, 16 Nov 2026 03:06:23 -0800
Subject: [PATCH v2 3/3] mm/damon/tests/core-kunit: test
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
Message-Id: <20261116-test-age-ms-filter-v2-3-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
In-Reply-To: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

DAMOS_FILTER_TYPE_AGE_MS defines an inclusive range for age in
milliseconds to filter for target regions. Aggregation interval can be
changed by users or intervals auto-tuning features.

Add a kunit test for each:

- convert region age to milliseconds, correct behavior at boundaries
  for defined filter range
- DAMOS_FILTER_TYPE_AGE_MS filter keeps correct behavior even when
  aggregation interval changes

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 66 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 156f74832c40..3b2b745b8546 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1838,6 +1838,71 @@ static void damos_test_age_ms_filter_is_core(struct kunit *test)
 			damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
 }
 
+static void damos_test_age_ms_filter_interval_changes(struct kunit *test)
+{
+	struct damos_filter filter = {
+		.type = DAMOS_FILTER_TYPE_AGE_MS,
+		.matching = true,
+		.range_min = 200,
+		.range_max = 400,
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
+	ctx->attrs.aggr_interval = 100000;
+
+	/* An age of 100 ms is below the 200 ms lower bound. */
+	r->age = 1;
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* An age of 200 ms matches the inclusive lower bound. */
+	r->age = 2;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* At a 200 ms interval, age 1 matches the lower bound. */
+	ctx->attrs.aggr_interval = 200000;
+	r->age = 1;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* An age of 400 ms matches the inclusive upper bound. */
+	r->age = 2;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* At a 50 ms interval, age 8 matches the upper bound. */
+	ctx->attrs.aggr_interval = 50000;
+	r->age = 8;
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(ctx, t, r, &filter,
+			ctx->min_region_sz, &err));
+
+	/* An age of 450 ms exceeds the 400 ms upper bound. */
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
@@ -2600,6 +2665,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_age_ms_filter_is_core),
+	KUNIT_CASE(damos_test_age_ms_filter_interval_changes),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
 	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),

-- 
2.53.0

