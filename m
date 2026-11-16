Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827209;
	b=lkQpYYXO7W+xteagG13puWRTJNoRKmT44WX2IwR16/DmBTuu+eRTqdm2fPYCVQrSG+h9
	 Iqi5oD6WK2Cv6EqDR5zX36jUueaVTwE+fwVP9ppR4WppUILyQXaDSADvzjzX0TR4E+qt/
	 r0ACcj1SmYz7gBljscv5fn5iEcX2xzqrQ9pK9OgwXqKJOfz1oxh/CdyZOpIsn/gLMYDdI
	 7KtCn/z7uH7AqsKp0UarA6aesL7gl8t7chq2LxUBRPFNioHGxj0PFpTVJkvnnxDKdbjcS
	 KR6310KrU9Y3WalGuh0dQ7wioavOWEmcOBf3NPa93F/MZrkRHgd7HpUTkZvYJrSHf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=n1STAPeBDhVJdiPrWnEBENabND8c5F/YLGiEN4UGv2I=;
	b=TIZ70yxa92ILu1gjFUJJvBZpBYc4PmFvCKyh2bjeei3wkn1JFT/9RUl29CNBIHLoVrfO
	 IDsmsSLbpyz+KMllCkeJhdsyMQZlsXwOhS8quHx9ZnTsoNAxB9c3IBIyv+wqyhJRDzXf2
	 AI/vTRQ7bbVcFdE2YNwmcidoDHluO5+sy0SP/7Sr6Y3BmvckhV7JO8pN19P66dO71wMbP
	 /H0JyLY1NSv9YS7mvNUoufrX0WohVO6nHGEePv+WRLshsUbm7TT3R/r2PLtQYzi2jvjhu
	 wcAcCXF3ml1Cjdlvk0Q3Nk31SRF4aS/ici7T7jlHhy8xC6QzY/X42t0UMbHwAbWkVhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fLXUBBtA;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AE60A2620
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C3AE60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fLXUBBtA
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3ada81853so2888829c88.0
        for <damon@lists.linux.dev>; Mon, 16 Nov 2026 03:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794827208; x=1795432008; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1STAPeBDhVJdiPrWnEBENabND8c5F/YLGiEN4UGv2I=;
        b=fLXUBBtAMQnSmzXdVrqfCE4jGj36OQGo2qC5kGfLdNJ5haLPqqt81Ecb6bsQZkix95
         0WC6+tyyJh/EUJj2BVmymwdxd0qVSNF+Tf/HggizG8Gk702OWU/XtWNequlMMEF6jkbB
         UFmfBaj2YemY7REva0Tqv8nD7boErwSMJUu3x+cXzot7H+GoAQrKn3S9DE8SzgPG+8oG
         gm3ItP9+M1K6UXj7SHaUG9vUqzxsCNwr+yRBTvaKMAZ00T/3WW3HJIbSAuDLbEjaJzXd
         7pTB6ms1Ixc2i6b4rHoApFSB94zJDvL9wJ4jyN0ZuQ/etR3OlrlEIBTn+xMDJx36tuZr
         EPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827208; x=1795432008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n1STAPeBDhVJdiPrWnEBENabND8c5F/YLGiEN4UGv2I=;
        b=Ld7e87K3xtrN38PZZMfoyDrvHnx25AEXruNxAGutftGVKMNdi9jvXh173tHhAk1RPR
         wTaHSDtwRHanXz7bmutf1sP6m3g0nMJTkizyqtiWcetz3GoKyD125/vWio9q74eNHdLi
         YwuVG4XP6/4hw9L11gDvT9QxwMwe7+pKc5Vp7uwxXDFsif3g5Gqb4U/lQXb1U37XgjGW
         crNDBuOLZDyxhl5knUoENfjgDt0U1ksMkLJ6w4gOoCqL5U/1aJiwmhlQPwB+73SEMici
         j3UeEuPZY11U7n0t1JQscTll6bFexK8QWBe7ifYglsyaoKDankpgibO0a5J44bCfuAEn
         L+PA==
X-Gm-Message-State: APuU4Z8EKZzJelzL+QiLCVcVk2ky71MsShNrU3IxgLlQ1Sn1RLVxok75
	ILDdIkhlNXGbWw73Qvi9UJ+zp4s57g58rrp+p8vtFv/Wilt12LnTtvTq/2Jaz/NQOr8=
X-Gm-Gg: AYBFou1QxTKDIKkn8EosH4yESL9ozwPa2kvizwoqR6EEf2dZBl7AmcAJ/iJ06MuIzHy
	oMe/By4P4yHf/w+aeNH3OIwmgvHQDIUF7YwMYYmw741y2zu6f3tnH9H3vzzW1FCzPZXToLAqt8u
	NXBTQSdQn5FMq+4jOV2GOwk6E2N8A9T8GO5Mt/wPyhLj8jmWyVaYMH8ht9CSlhr1km6m+JIXcF1
	8MVLTuBPPQ9VffEUH14IPKoV48E4Eiqg+J3e9cVbWVh2f2mwjXLhoSJ5h1rrNlmigyBAiotNPYI
	XfoiQV6eVqXX21hJyUsBWx5GMWOn89AVoRIdR8aTcuMgB+7Zu4CZ/EYbwau7gQ1CKyi7Cq3xHXp
	kt0DEG2325YhRN9Ukx5RjkB8hkl8aZ5wVf5EwcU7uDAp6wTs353Uavy72R/aqAN5gM6fnyzxOp2
	PRwGefP+VIadCyjBAnePeCZI9tRlzbiucmaUQqjOx4FFUABJ3b76/rxKq6sHv7t1l9TDsgTfWNE
	R0WngeO5ZSS8GqOlQFvvO8+Qd2d9+ZapzJk8D+PEpzAf+LXidQMLTBmhfAcmgkpR1sWNYA7ACaZ
	rN74Ok4fEdmRmrX9cDeR52+AySCBIg==
X-Received: by 2002:a05:701b:42c9:10b0:1b2:6eef:3f32 with SMTP id a92af1059eb24-1b503137c87mr10395040c88.37.1794827208245;
        Mon, 16 Nov 2026 03:06:48 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm12522103c88.4.2026.11.16.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:06:47 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Date: Mon, 16 Nov 2026 03:06:21 -0800
Subject: [PATCH v2 1/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_test_commit_filter()
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
Message-Id: <20261116-test-age-ms-filter-v2-1-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
In-Reply-To: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

Add kunit tests that commit DAMOS core filter type
DAMOS_FILTER_TYPE_AGE_MS.

Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a5ca4bfe2f0d..0eb5dcdba0ae 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1271,6 +1271,10 @@ static void damos_test_commit_filter_for(struct kunit *test,
 	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
 	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
 	switch (src->type) {
+	case DAMOS_FILTER_TYPE_AGE_MS:
+		KUNIT_EXPECT_EQ(test, dst->range_min, src->range_min);
+		KUNIT_EXPECT_EQ(test, dst->range_max, src->range_max);
+		break;
 	case DAMOS_FILTER_TYPE_MEMCG:
 		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
 		break;
@@ -1304,6 +1308,22 @@ static void damos_test_commit_filter(struct kunit *test)
 		.allow = false,
 	};
 
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_AGE_MS,
+			.matching = true,
+			.allow = true,
+			.range_min = 36,
+			.range_max = 14
+			}, true);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_AGE_MS,
+			.matching = true,
+			.allow = true,
+			.range_min = 14,
+			.range_max = 36
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_ANON,

-- 
2.53.0

