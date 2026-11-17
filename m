Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937723;
	b=PFntF6qNk8oLHz2qrnrATPF2C379k6ioppH8+JdzNpwbggOE43pawYItXz/oe4uuVNfG
	 pRcr0irTyLzz4poQGgjFW+JCiMX/5oJJj/9VBtj4s90H0uWwJv19ibJloMmaB2QEJW1oh
	 W8T3UwIfzEWwgcYWYSFkK5yQd+Z1fFdL277HfPGi5MhiOAd+RZaXwP6uxciG59p8cqGcl
	 wG4RGyuNy3dLeIpIVAaY6bHKW520Npx3jhAwVMZmYHbGnztAeOl86f45C5riUdMjctMBN
	 kUpoga1/VRVkGZ9SJfjxNzq3+nsy/6M0Yo2BnfVHguFcDXgD6lclsO5F1zUzGvVox1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rA3XzT8tXt6/+XP+fsrdKUtHJCQ7Tr9McEClsG+Hib4=;
	b=svzNUq4ygs+UGZukIYWh+FdhV5RWD6+quEF0rj6VajCnjSf8V8bgKxZTAQwQiFCjIMA7
	 k2ftvpflyy/+YTuU0BipYmTCDDwDo8xoin3ClKqL+j2/cgz3z9jyu/AVVi9WAciaxw1os
	 6SV6KVO/FwhCk9aqxx2hd8yXDhWbjiMt9t8B+biLpi2DcJPh7OLZ62Epdyps6EfDj3jo4
	 S3cxWZwiyMrfnWZpXp7fFCX/6mwLRasCkc9+GUCzP2wHByBbD8s4583Nf2S5ZfA9JS4zt
	 7KNelt2ePcK4GKZfJK+7OfK6fe14h9MhZZRtKJ7mztlzH4WScV8wDxorukegRE2FCBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KsLVpxvF;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B3606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 17:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1B3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KsLVpxvF
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33c10faf6easo26946eec.0
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794937722; x=1795542522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rA3XzT8tXt6/+XP+fsrdKUtHJCQ7Tr9McEClsG+Hib4=;
        b=KsLVpxvFOGmUAkFbVnb4wxeSe5TqSjPeFQxDIhYdEek6Bxm9Mx3eKMsprQzaTCMyO9
         kZgIyjLG1IuC25MA+cjF77VYFF0Zns4bXbwVB5RWDJQLgH+0Go5VM0ol5h6slX1j00iN
         m62XgHyf/AVABre08rb/Qdk2b15R8uhwzlktWOOi0ctNXZTXYd+HTxorGt4LgKFMXRR9
         TzQ8qHd6OGW7gKf6AC/xrsvDtfZtwe8QDr7w5GS1B0dO8fuiiY9TNcPQTKuNHvN24xIM
         FnvjDfDeVJAUH2mywv90fbT1jkQaxg7AHW/Z6Cb1oaaA1wZX0jZD43CKyyEmNCU+8Qli
         0GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937722; x=1795542522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rA3XzT8tXt6/+XP+fsrdKUtHJCQ7Tr9McEClsG+Hib4=;
        b=jjfqVuzu7/s03ynb7vkQxQl93TOyqYaJpM0GdZW8MlMQ3tOLbrSqvrHjtrhnXEk/9U
         C/L2cjX8D9ks+YWLZvzJk3vnb6QUwvYr+6CVjUGow88PveQeNaUCiIdDT3Qv8+fjJxgv
         VTpKQ5LDmxTNK8QpCZJ17+gKJncLXOXkcwmw9Q/vQbLJ0AXlnM8N73iww4NQXqMOl1hn
         vqrcpziIhI41VH79KkYRxINe+FppIed75AvLs9NIDq5zdtHr04o7wbCT5Lp6h5vq4iBp
         IM5VE5Xi3ovFL8ZBHf8T8D3IdxmtLaApRMAGhid7p7vTzfKKI+zLKbAzJ7pMWTNWFgNE
         qZ8Q==
X-Gm-Message-State: APuU4Z96woQTXCsl1jS+XHpHpJQXoIoIUIYx+Cxj0R8MVmgmHm3YY4pw
	4p/B33nDOpbXLC2HQtE3yaWvqsDISKj8HjGvoDbRn5pMWDpMJqArigQA
X-Gm-Gg: AZFdTZcgqR6Pc1rLty7m6nxjqH/w1U2mbKwsqTzIoyqlMlsip44TV0oDecC1/+r5XwR
	XcSbqk8mZJZmNvfEeqThv3dPsTvVJasTH7XMP1qT827j3ytea3yZ0CQXC8i/fC2hk4JlfYLHI/J
	lJf24a78onzshrGkjrRJ+taJ/bsxchNEaj62m5wbcQ13WBW+cl+T7X5QgADAPL0/jmnkfIW/z0+
	t+FLvNJyZYqsFv/6Q4QO4RCYpg5fIETBGoLUN+llBcFoMcnkjQJAM6hMvFWfOggWofWcKkcIt2z
	qg1u3HSdDa5H9IExar3nMdv6+W6mxVt6kEJAoUoi9WK66v+YMtil8oG0KRt+zNEeTobTQrR69Vp
	1nebkHm9XldowD5f4Lx8kqjkolIv65pfUF6We3AdqgQMX9ZsYmBMcXrHZJOuZC8LR/mVDeVJFvF
	3Kkam/zqI0QhcbpYEcrE4dW9MOWtDDe3e2y6rpgXsX19AsVH4d50wmyKxXUlNjxTHeWlL0wa/sT
	5wIjyhWKRI0mK3egD8mqmtMII2AQKD/PlGIxB0hSIVj5MH86JtNbcDrH5uoGPkbkFIh1HOaHWjZ
	DV2cBhpDb+BfnnfFq0vAPp9tLy1r1OfZ3Emo67iKVnfcV+bZYiRmKg==
X-Received: by 2002:a05:693c:894a:b0:36d:5fbc:8c8d with SMTP id 5a478bee46e88-3828036c8e0mr197352eec.2.1794937721763;
        Tue, 17 Nov 2026 09:48:41 -0800 (PST)
Received: from localhost.localdomain ([38.254.175.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3815045b90esm7025750eec.13.2026.11.17.09.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:48:41 -0800 (PST)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: [PATCH 2/2] mm/damon/tests/core-kunit: add test for damon_call() with repeat control
Date: Tue, 17 Nov 2026 23:18:34 +0530
Message-Id: <20261117174834.29182-1-saileshnandanavanam@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When call_controls_obsolete is unset and damon_call_control->repeat is
set, damon_call() should queue the request and return 0 immediately
without waiting for kdamond to handle it.  Add a kunit test for that.

Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
---
 mm/damon/tests/core-kunit.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 13315291f69f..bc93677487b5 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2499,6 +2499,30 @@ static void damon_test_call_controls_obsolete(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+static void damon_test_call_repeat(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_call_control control = {};
+	int ret;
+
+	ctx = damon_new_ctx();
+
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
+	ctx->call_controls_obsolete = false;
+	control.repeat = true;
+
+	ret = damon_call(ctx, &control);
+
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, list_empty(&ctx->call_controls));
+	KUNIT_EXPECT_PTR_EQ(test, ctx->call_controls.next, &control.list);
+
+	list_del(&control.list);
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2544,6 +2568,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_esz_goal_temporal),
 	KUNIT_CASE(damon_test_last_region_quota_reset),
 	KUNIT_CASE(damon_test_call_controls_obsolete),
+	KUNIT_CASE(damon_test_call_repeat),
 	{},
 };
 
-- 
2.34.1

