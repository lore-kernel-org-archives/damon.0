Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585556;
	b=JDY85dfF1U+AXjxOBsWetAmIGXGlaK+D/lv7ABhJ1Ok0618sX9Pdy8CMdOCHBWl3Abr0
	 IXkxAZa83JaQP9/n+5Bfwf4kfuRHBmd6dPpeLLPWFW2IobOjv6yzqQFWD/VuDSUKpVITf
	 RGupfzn6hhrFSBiyLsYkEzXfMUZQPwf1944kZkHCfsSMfGi9M7gvCY2ehju25xTy3fxc7
	 27AJb9YGnWGcohRkKD9JBQ6yjJAGG2nKc0ZESuUX5pD5TPYAIO8bMP1TKqEPyzjxFIDp+
	 bxhafCCkeSl5iJrk/MjjkrGowuNYfeQcB+o0HV5Ms1WpcY3xKrERSgjowwYAPeS1oZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=/inMl5ihTFO44VU9pWq4Bx3NmmHKW+CV93YX/kcCu/0=;
	b=5bzxGkDP8q1Q351tnyRN2pn7dVPD1AZG22d0XhyWv0cLTnD1yuPJr2QsTFbxpVVpL7ow
	 A0ZTi2SUJS+xS7uaQ9JTAn1zs3ffRtqVcMT9p+qOglcFeDSMDW9Tcf6JpCBDayJ6px/VM
	 j44BnM2JQWDhACr4DpAu6+t6o59urOa+jgmrFirJfhYGVAmhqGxl5W7W4o0QJPVafzk7D
	 ZeYC4/fajJxOADl1zdphGwREYHMYCVH7rjfGOb40lsLmSFwQSPwuRIagfGqcmGISUSC6E
	 OdHc313cGTHD786I52dvqbvyZcf9Fs8GEopAAu/XRcFGURPw+IAfKHjbm519JjCenaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ucla.edu;
	spf=pass smtp.mailfrom=g.ucla.edu;
	dkim=pass header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K5ChEdc2;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AC606C54A
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 15:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 957AC606C54A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20260707.gappssmtp.com header.i=@g-ucla-edu.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K5ChEdc2
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso610795a12.2
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20260707.gappssmtp.com; s=20260707; t=1794585556; x=1795190356; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/inMl5ihTFO44VU9pWq4Bx3NmmHKW+CV93YX/kcCu/0=;
        b=K5ChEdc2suDTOjl69dU2vkUsA+vKcQsEhYYhK6Lc1qRBp7bD7G5qGNuFEoC2PNBJmj
         QeLTjq09beoYilDfOjX7qX265I5/4j4nncB0Ur8pGlPaJZr5BbLhCXVlslfKryEi0Uph
         Jm1mNulJ8KrloDjoCCRDaqn2rhZlrUPzxoRFcMo4PDm5Vq9z0qCAJEU1qhDiRmW3jsn0
         wiIJ/Q3llAwQTXLYCkzVvdSAeIl2231frwcnyQyxw51eik/EH2QodGQ6iruaZxJOAhNN
         Cw5w5qKe1C5I25jO1vuyp4DytsYLfOqWiy83Jn3Sq8kgl/HZTY75YAjyBmzCzwd1aN6o
         oWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585556; x=1795190356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/inMl5ihTFO44VU9pWq4Bx3NmmHKW+CV93YX/kcCu/0=;
        b=AYvSZFeAjHMLeCjoKVxmHdebkWSiVjFq/fsOhn5DPZaslCAroQACV2Lg0U22om59fC
         4CEKMkCL+w2a2JNZyVgmkF96NG1j6afTnAXzE1EFcMQoNCJuDnNFZMgPl9aBPM5b43bu
         O1j380mserCU1QwNvLemVcHad0RnYdGLiMbOOS1SkspMDaZJc2LBkJoO0Ng7n55ZDMzj
         o+DGPOvgcembgUNXXRUACXkyO0fK9OsOU6xqfGrd5s8w8Q2LdbcYSA2zS7Ti4Iv+fNEt
         Jo/LAzXxpZyx6tKzCd5skOnRgkykYFi7gI0YjguM8BIZJJVu6Q+LZrAW/CERk/+568hj
         rMSw==
X-Gm-Message-State: APuU4Z9AUUjF8ubjie19FsUPBtPYTN0brVsE+kdiRHmMU2mQNpuJSk/y
	6qc3HrhceMR3FKNGWLlk/OqY9gOCOgC2TQMEiRyaj9qC2tu41r3Jqqz6vvUIcBSuM8M=
X-Gm-Gg: AYBFou3sF7CGA2LBS9HYmWwmFsxjWfA7fyjJM/bXjLEM02QUh6JAeVowwDU4wjpNZkq
	eET7CHj7oLqtK1PlUl+t17npDf5pkHPwza2SJjYwtWo364GCZAopE69m8EUfB8jAvWVN4PEh3Sm
	YvkpX0dME0RnMzaweLj6k6PKdIBWKk+Cji6tASixlatjyTGLDKWuZFH9uCkc/sDI24Y+vhnk7It
	MPYqkBdgU8wG4vf3CpVAfa+aEhawBwKXUGafS6jMnYa708aQgqCYRHCS46pF5tX17iBSwsqJSD8
	jyI4pzGrxt2t1aFA8FoGat1NwdtO6uWAU/5262PiNKJF62V/KLBtcvsmc6dCtMXEmnxId6vV4wJ
	mR22bQNZCgUkNtZP6VdDqnLqH9ZnSMrPMD+MUPKkmhtBeUP0dY+AgCil0BVnPG6W39ATteCkLDz
	DhoZEOOu2VXZ7iessIxh9HtcrUJTOyyyMBgQG24wuHuLnuTszj5zjzqtO0yhjidnEGNGHhpQPlo
	uA5R0GxxJjK/HUFke6/jtZ6Pv4ZflXLjKJeevkmuQyBRJ4CHNzD8TixwQanY4sRL5dFCq1bx36d
	vyhQ69inROeGfKicnPee27VHVa6RroE2XKFa0BvKr976mDmsB5E=
X-Received: by 2002:a05:7022:7e8e:b0:165:aced:1fde with SMTP id a92af1059eb24-1b502fe08c6mr3364841c88.0.1794585555597;
        Fri, 13 Nov 2026 07:59:15 -0800 (PST)
Received: from [127.0.1.1] ([131.179.95.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031bc518sm7868383c88.15.2026.11.13.07.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:59:15 -0800 (PST)
From: Jason Angelov <jasonangelov@ucla.edu>
Date: Fri, 13 Nov 2026 07:58:55 -0800
Subject: [PATCH 1/3] mm/damon/tests/core-kunit: test
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
Message-Id: <20261113-test-age-ms-filter-v1-1-b99eab2f71bb@ucla.edu>
References: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
In-Reply-To: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jason Angelov <jasonangelov@ucla.edu>
X-Mailer: b4 0.14.3

add kunit tests that commit DAMOS core filter type
DAMOS_FILTER_TYPE_AGE_MS.

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

