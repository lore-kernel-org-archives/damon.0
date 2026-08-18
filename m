Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B0F3B0580
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024778; cv=none; b=C51yosf2aUoFwKGFWh9d/NAH/8sDasLHCIdDxrOXJjfUPxYDQErV2Ks1bpzN28bccNWhNE9XxHbOXEOqtnk/Cp7KvBfFema3BNJz/McaFI3+7vHgPRVF0CuTIAFQM0n9eJHYOEfMCP4jFkFPsqxaQ9UyzvrYFRR9bPHrSAmVGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024778; c=relaxed/simple;
	bh=BmcomMSONTWOIWRXzO+a38W4DDfeltbqysAe/UNmlZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxY+r9xyTfbNXcLyAA0G73vyw6esXMrPbKbG0DFXCgAWcNctgqGIee7ZVN6jfwR7S2Jzuuucu7VIAhDnPuWhsMhPC6IeYTL/GnETZBBe0EbzRV7OyYTU6YlDqbht3M/XwJsTe1j9bV4KjT+O4VjdtZKG/RtspASoIUose45CpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=g.ucla.edu; dkim=pass (2048-bit key) header.d=g-ucla-edu.20251104.gappssmtp.com header.i=@g-ucla-edu.20251104.gappssmtp.com header.b=WmHm3dTb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20251104.gappssmtp.com header.i=@g-ucla-edu.20251104.gappssmtp.com header.b="WmHm3dTb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso44228835ad.2
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 20:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20251104.gappssmtp.com; s=20251104; t=1787024777; x=1787629577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDkagHVNS2LJhNT8XESQiKeoHr8QVrsAQC8Ivqfl/sw=;
        b=WmHm3dTbH5JxTXjZRf8ooPhTOY2qfCRVO+qWtBqW9JYFy7z23XIZdiGM13SlZ7AYsw
         EzQS7lnTr6yjmJyvnUSGK6uEmw43Qjca9ZUCmitTVjG9jtIMXwm3TvMU9g1ZfXGEU3Qe
         xbt3KzxjoVF7BSxGhX0m9tYKH867YqJun5cH/+8jeMxQI05a4a8DVYn46AFIh6MDI2pd
         URgrppy58HROp9Qo8Qig7Sy9qbG2T2ArnYnXA92/CUqN1n8QOdfuoGBoGcUeunWFdf++
         iCEwtq/1TKv901IILpfyWpINiVVDrjyrXox4a04wdARRdXHQgoY4VXSJhrCdVLbK0Rdo
         6gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024777; x=1787629577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fDkagHVNS2LJhNT8XESQiKeoHr8QVrsAQC8Ivqfl/sw=;
        b=mHOZUwuIZtnXO2rzWaO//t81UBQeDYbpq4KBjboxxEpqLoPzEHKgcUsQT4Ap8dkhFO
         uTlTz4FsMkOU7ivkUFKGxMTu0vWVMD9/0ZRG8DJmfLAWfT4hjRysBs/qi08LusvCFg4d
         dkMnrSWqaPMUXDwl3j+JMzuwdX9kff0uNFTppc8R94nGd1yHaJn0gdTtYQblqIp917YK
         ZzqKfGPtkJrh4DX+2ffWfTro4eYxXHVzj1y929sPCk4H23VPunmb5J6Fsv6fRP+bUfls
         EGcTqdGFSue4n8Ug6FCWedWx5pryeu6rICwURGfsW4Q1R4b6jlmTBJ9SmVmlILVZruDX
         +CmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoPCOIL/F4KSoxAWNdzcE+hTqlOroLxo9ul3dr7qPNYoCEi6UfbARwc1Jf/1IWGmOw0i1LpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtz6A9BL9qEEIhwl4PneutOnK5L2GZjkUM6qZnQt+Zgmjv5rv3
	xp/F/wFJruIa/ZQ12E0gmFP41t4Iwg0do7xyCrsOttHH1ZPp0w0+f4mXTeaFbYwHFpE=
X-Gm-Gg: AR+sD10IqhTX5nRT7BXDGgsMIHBKblr+mbsLUlneKI4UF9Snwjvkfco7nt830CSjuWF
	NMBBg4AqxfcSJ+kKRyuE/Js4qhG/fzQ7U0/rXf/vcTxHbzkO7E9meNN19kwBnl3sh0pkuHVGhvr
	bdtK6rJmmwWdU9ZO7gOhD9x19kXhGUUyyuJ634FZWNMjoZRPtj/3Id1uA2o2PNrAW5iAXHuGG1l
	iMZqh/IFYSaKt6imsMbNNVY5OI0dJn3I92mUGRvryuzY3ebcAo3TjRiXCzUQX2uQ80E4x4xQeXK
	TbxGQQWY9KIGKtyC5eNhOJknlQsWFdwkR5c+lnrcszvUIlWWimDOYlNBR3x3Dn1jpLw7Y/Jbbv2
	91b0CfxobMJN97xwRwliuJpmNq0oI6Hfsyf4F6HdHVrBMpzs9XaN+S8DjjQAVvk/zYkLu5qPIJE
	I73jVqGFCRwxdq9vOyW7s9cdG0h7L4dIEGGdKxlrOR9jmhePRGIFVcjhR6dAfxFR0I9mvFMPbnS
	WrrnRloLLTwvhZj
X-Received: by 2002:a17:903:37c4:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d3b0c5437dmr334519695ad.8.1787024776791;
        Mon, 17 Aug 2026 20:46:16 -0700 (PDT)
Received: from damon-kunit-dev.tailb106f5.ts.net ([73.93.135.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267be8e35bsm11453293eec.14.2026.08.17.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:46:16 -0700 (PDT)
From: Jason Angelov <jasonangelov@ucla.edu>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jason Angelov <jasonangelov@ucla.edu>
Subject: [PATCH 2/2] mm/damon/core-kunit: test damon_valid_probe_params()
Date: Tue, 18 Aug 2026 03:45:52 +0000
Message-ID: <20260818034552.11975-3-jasonangelov@ucla.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818034552.11975-1-jasonangelov@ucla.edu>
References: <20260818034552.11975-1-jasonangelov@ucla.edu>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_valid_probe_params() makes damon_commit_ctx() reject probe
configurations that could overflow a probe_hits counter, a single
(weight * probe_hits) product, or the sum of those products.

Add a kunit test covering each rejection at its boundary:

- samples per aggregation interval: U8_MAX is allowed, one more could
  overflow a probe_hits counter
- single weight: the largest whose product fits in unsigned int is
  allowed, one larger is rejected
- multiple probes: each product fits, but their sum overflows
- no weight set: the validation is skipped

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2db94d49c9ba..b1ca4c8e03f0 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1338,6 +1338,62 @@ static void damon_test_commit_ctx(struct kunit *test)
 	damon_destroy_ctx(dst);
 }
 
+static void damon_test_valid_probe_params(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_probe *probe, *probe2;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+	probe = damon_new_probe();
+	if (!probe) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "probe alloc fail");
+	}
+	damon_add_probe(ctx, probe);
+
+	/* Parameters are validated only if any probe weight is set. */
+	ctx->attrs.sample_interval = 1;
+	ctx->attrs.aggr_interval = 1000000;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* Up to U8_MAX samples per aggregation interval are allowed. */
+	probe->weight = 100;
+	ctx->attrs.aggr_interval = 255;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* More samples could overflow the probe_hits counters. */
+	ctx->attrs.aggr_interval = 256;
+	KUNIT_EXPECT_FALSE(test, damon_valid_probe_params(ctx));
+
+	/* The largest weight whose weighted hit count fits in unsigned int. */
+	ctx->attrs.aggr_interval = 255;
+	probe->weight = UINT_MAX / 255;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* Any larger weight could overflow its weighted hit count. */
+	probe->weight = UINT_MAX / 255 + 1;
+	KUNIT_EXPECT_FALSE(test, damon_valid_probe_params(ctx));
+
+	/* With one sample per aggregation, even the largest weight fits. */
+	ctx->attrs.aggr_interval = 1;
+	probe->weight = UINT_MAX;
+	KUNIT_EXPECT_TRUE(test, damon_valid_probe_params(ctx));
+
+	/* The sum of all probes' weighted hit counts could also overflow. */
+	probe2 = damon_new_probe();
+	if (!probe2) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "probe2 alloc fail");
+	}
+	probe2->weight = 1;
+	damon_add_probe(ctx, probe2);
+	KUNIT_EXPECT_FALSE(test, damon_valid_probe_params(ctx));
+
+	damon_destroy_ctx(ctx);
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -1664,6 +1720,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_commit_migrate_hot),
 	KUNIT_CASE(damon_test_commit_target_regions),
 	KUNIT_CASE(damon_test_commit_ctx),
+	KUNIT_CASE(damon_test_valid_probe_params),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
 	KUNIT_CASE(damon_test_set_filters_default_reject),
-- 
2.43.0

