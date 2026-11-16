Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827212;
	b=q1Rsmt8evI0vja68UVvcJ3NrQQAPXpIB7uLuD4vcck8rIKNTflPjNKmhZd3YomAiZ6Gz
	 UfDLMKsh+ITkHqCw7KM1qHBfuuY+3Y0pjuz7utAbm/O2PNiH5b98HPuP02jOVVjHhZhn8
	 z5PAq1AgGxMh9NuOhmnfeOOF3T5gVXmFCJXTz82FqZAzFDlj0heL18KqmAtbDpnD/cSjT
	 gbVD2sdUSF06vtQX0nCk/eie3pnu6srWtumtUVMCJRR2vG2kz9n5nLcfTunIlKqg5CDDH
	 ZYnjoojLpbAIXmF3OwBoMxe2OkH+H0y6HqGmXWJnfUtIkfb9FN/83UEY4+K13s6vh2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=G6Er2nPrtscnG/s8rWHw2Y9sWYYlyx2QveGZLr9tu7k=;
	b=sq+Hy9uDDAHjVKUFmkkHOjVW5zxe5oz/TNmV3Ss56zel2o9PoCrkFvUlVS37EQ/GqCv5
	 fwAwF1BnqSEY0O6zkFU5l4H8vOlrVqL/7DxV5KhOc57gzqnnoH1RFP0NKwCVUzUxlcOuC
	 umwhAvCc2SCV/vG8YtGG0R9i+UCTN2uGiZudJm/hFzbg/XKcgCa0vBhKCQ0jzqeDhE6RN
	 sZ3cGVupGOGdyoqXA67bbkcPJkwQzrFw6VgEhLz+3F693t7lo6q0IHj0P91tf+lQZMzrS
	 BfMwCElu46vyq99FO+0tzI0N5SUWIGBx/EaYXH2UNssvog5lODLq25SofBx8IajVEXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pCVHVq1m;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35282606E4B0
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35282606E4B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pCVHVq1m
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so3662408c88.1
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794827211; x=1795432011; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G6Er2nPrtscnG/s8rWHw2Y9sWYYlyx2QveGZLr9tu7k=;
        b=pCVHVq1mBp1zgovEwEFA03DhMMeKM38pZbTwc+6gV4nh4LzbrjWjct3FdLyX3mDgyz
         yLwFCfcKCe3jgXlldWKqmK15wUlCMiUVDAMq/oTm5t0AZUzY0pw0AqzkBcoNuB2m8DHe
         LLeKtZBFQW50eOgfKEYITEm5ygValjLy6wzUcsk5P+tMDuhL0M42AjUrlsZDETs8xf6J
         ItUGLwaO3VpIfelogF2xYduwGM9d6y0T9Xwo/OYZd15uYNmA26T6OM7jUlmn/Gp0atWV
         qBKWhTNlAVr8f6/9RkW0HEyGvGYWr0Q1VC40IIL6aCOOKZNFNDCTPh9pWm1B0khXnztB
         fB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827211; x=1795432011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6Er2nPrtscnG/s8rWHw2Y9sWYYlyx2QveGZLr9tu7k=;
        b=GMU9/4sApu6Ev2zaCLPJVlj6u1Vtap2p/Gd3Jl2dVDek++HjR5aGr4c4JgYdn8+6BD
         27ReDncSB9L07xxPl3zmCiochniJIG+BQ1twkuUHd4/8p8wA4dFwgP4k8Wc+9k+VOiSD
         4kBsu9oV0g6QkRd0z4VWg7KvQ9HT6yGC4Lz+B2O94G0+q8MI2BDz0MWq4nlgJEvvD0Rk
         KFXMQBfcljCN7D1eJb4v+NgzADSsLvESjHCHJDgbgFAEwkwKxpdoVAyIs+V7nRCkLuIe
         wSUal6U7X8n62DnSrz/OsyGzyc7BhrfHzlWQEFy3sG2NYT+eiU0ukm+UMC44eCzvkFT3
         65xw==
X-Gm-Message-State: APuU4Z/c0oqv3Qy+sK4/RnE/X4J/J6hEy1e8jk38aqL2Gq17aiC7uiQz
	4npQ42DPCk2Ro3ePgGHaeq7SClQVGltPg1QvB4t5w0+e+YU153aRf3cFkijEyoXyK3o=
X-Gm-Gg: AYBFou3+KMxP3bkWpEEaVbR0yEgVUh3t44H3+Ri04qftfp8WkQqCOD0ck2hERVOY3gj
	lgmZ8kQyiJ2BXBy/otAYLPOY/7p4iq+ooRicG7to0uY+NyMPvHQC8w4GdwZVyh29keUSPkrYxeQ
	JDr0qc7VwPBKZ7QVtPcKLF6TiqUfYNgUu/iZxNSZOziSVKelKQJXAUlwD9SNWXPU2/GwZ4Bx7gb
	Y5h48unqbQXQiabEWwcUgUpcE3uO6QcLqUpbKZzMefrMfiA/769rcYobxS6j9IArwBiy1SD2nN9
	UsF3YPSsgK1y2KfaiOkyeJU11Y28BNmgWy1KnoJw7E1u3iCiQluBhUCj2gzJKm98ZgscXLB2YKu
	X4u5AO9WxihPS/9Hgedd7Lm6a0wvM7HHQf2eKXuvP25cd4G28xc8guGasDQJXLcs6Hvfoco8M3l
	PKUhMrkHvSQGIzv6t8cLAPhf2sYz10KfZCLI+DSMOXunkkHQyNUSf7ydNKGs7XYO3zUT/NSvqM4
	UxHcFsJT6YvWWWMTkp4DSz7+nlxM/W8/M09LMmPR9DRlCI8fYW2zfoIzig9q2eHXWqqYTtKMOQI
	35w85++RmqrNpmrvBhSxLeJTNME6Xw==
X-Received: by 2002:a05:7022:38b:b0:1ac:9da7:e881 with SMTP id a92af1059eb24-1b503175cf7mr11947613c88.36.1794827211184;
        Mon, 16 Nov 2026 03:06:51 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm12522103c88.4.2026.11.16.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:06:48 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Date: Mon, 16 Nov 2026 03:06:22 -0800
Subject: [PATCH v2 2/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
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
Message-Id: <20261116-test-age-ms-filter-v2-2-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
In-Reply-To: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

DAMOS_FILTER_TYPE_AGE_MS is core filter, not ops filter.
Add kunit test covering this rejection.

Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0eb5dcdba0ae..156f74832c40 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1832,6 +1832,12 @@ static void damon_test_valid_probe_params(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damos_test_age_ms_filter_is_core(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test,
+			damos_filter_for_ops(DAMOS_FILTER_TYPE_AGE_MS));
+}
+
 static void damos_test_filter_out(struct kunit *test)
 {
 	struct damon_target *t;
@@ -2593,6 +2599,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_commit_ctx),
 	KUNIT_CASE(damon_test_commit_ctx_keeps_quota),
 	KUNIT_CASE(damon_test_valid_probe_params),
+	KUNIT_CASE(damos_test_age_ms_filter_is_core),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damos_test_apply_scheme_filtered_sz),
 	KUNIT_CASE(damos_test_apply_scheme_filter_sz_unchanged),

-- 
2.53.0

