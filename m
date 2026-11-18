Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794983890;
	b=cB8lrgfpgrE6fLmfYkFekt+65mQ3ARjRwhmEj3Xd3yjTj3Sy1fY0tDlpFuE0Lq4WVeFl
	 0l9SCNNn7FI4i5/D5cG5uG8dWqbbn5zqtNJdNiilERyK5B/XZyYjwR4S9+dO9UinItwSf
	 cT0/tIYD9SonhzuZAvwR3yiPfj3V8TDEr5xWes1ojVEQLssHCShBQa7HLhAWYparJRNqT
	 dzvG76od03BtOlDuHXpHORjFQugA0YoNC6aV6YlK1rjb4lWekss1rj8wWarHCs24wcYtp
	 alMtfwTg38rO+RIy8T2OvOe1qxauEaHnGx+U2srYi7m1I3+2zOzeDoB5gkf2C2hsnZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794983890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=M1+qMsPy6fKyAjck+GZTx88ZCCPsYdHAFPCNWYPe8pw=;
	b=0PIHHLXfRLH0L4DEBMCwPOfKrDipL0Km04yRXsragAtdv7HmWIYSg+EC6MywNcfUoZQT
	 LCGkmbr8XxZhMKm6Fmng1J7y8FIcpeKr6QtLN7r0iE5wG8vJV5s/BVT+fIBAfcdoAzo2s
	 hrTO1CNnhtbllpcs1p6atPIZirpXHRrla3ZhqDgC5VHaLOu9hSRImGjzRaw0WT2lz0dle
	 841IPyD7EQwDoz4SXTfNgA7QQJ33Zj2oCD62TcPZRCun0Lt/lQTfv7GsOUWjxcEXnMnmI
	 orkOR1LczgJQSWw1zXCE+T/KSzn10b3G0vhiPgnstw5u1WUj98c4dNlzCaSe0HOSTxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q08jPk32;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B1606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 06:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B40B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q08jPk32
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36e90071735so129017eec.0
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 22:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794983889; x=1795588689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1+qMsPy6fKyAjck+GZTx88ZCCPsYdHAFPCNWYPe8pw=;
        b=q08jPk32xsWgfrZ1s8hl0d9RheYDV91dPBxigwfekN0grKjzoTp3taB7B4g9ppepbu
         FiSq+AHvE4OgCoWQIKn/oxXl5eVyX27GG73jqx+M70WDmNk3vpiAXfM4piHcRq9ilarS
         rSOfci7F/k53gGMWtH6E2Sk8V3jZV8HKFUcgQbMllXggS1L4nDXsnhSpFs2VXA2oAZly
         /HXYhV4aweLdeoJd8mjkUXpDoVHPQUD6TIjfXiuBOdQY1jR37bptOkFTX7aRLriLoqg5
         hWFbg4jW8mkR5DcKvowpoLjk9v1pRpKAGGT3gj1mYMmS0R3QWCrKMqO0ORpKlYvVQJw8
         LnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794983889; x=1795588689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1+qMsPy6fKyAjck+GZTx88ZCCPsYdHAFPCNWYPe8pw=;
        b=yc4eLnxOTakz6MrzmzEksPY3wFl4ED97tYfbtbhXejifbuYWcNyudWK+BqjMk36sFL
         y0b3zXNVptZ3EBXD6bxC3I3v/6/mwC2Uyb51edXXR67hxmLsrhfndFDng4gNNoXQ+Z1F
         b17HAiQ1FGRWxMpMRAksIS0Mm2jVggUJdE3dW4VgW1hWhBHFrbJ42AGXR9YDPk0iVYnr
         WDorshwsV10Kn6K8L4UXAUV1pW6kqlmlIHqPJK/l7DGfzeietFbsn5kpy6qzVFfIF0aJ
         xJkzD5MlcOqW6dMxYKV1497ibBVy5p3XWYglM1JO3bKncbSA0+eYlBMdtCIXykPlH1I3
         1eYQ==
X-Gm-Message-State: APuU4Z+pdurOx38r7EA8MTz2Y3gcd3UhCZJOa6JV6j4YT7IWttDQgK2y
	xwzY22YEtDcku4k5VXutPg9uhNPzcWVNtOt7WHDnFeuCaMsT2nvxcoi9
X-Gm-Gg: AZFdTZdP4eNf3JA7aZStUYgkFzEObm9jYyAKyaDY1AQoJQA36+ji/wl81qYXMbHTvH8
	+cLl9DX/ztSe5DQAk6y5HxxfTyxd+/tNNP0PqXpIDvOc3yWGgNQ4OtprAVnliFPL0HXVp3YePqt
	85VnlnFxU4+VTYIWHcCbvQPtDLW/vluuKaellXk1Jw4O5KxNtHM0WMXyC0F/khqfMvu4phCY7l6
	1+8piW44UQmZDR6Z7yb6hmkvKN3Etb8Cg6aRSwPLRkGl6lu36PMZHwX2tDAKCNQhVKB3CbPbAS5
	ZDmFcd7HFubWyfrDcFSqNNabqlVbeNcbf1yFZawZPJ5auODqzIvpgpQhcltk2uvJ9DP14J4mMd/
	aIm3dcK7htNAwz7oAuVMxP5Bgqr5ymxi0tXvCcJGFz780pVuRfPRpbIVlaUuY5CScBVQsrLt4xi
	SW/GZxJvtS9nF0ZyBt0iB6lByvwjdjnODAwRZSYn5Xv25syG8NPPR4lPdw07WLhUu0XvIv2bb0Q
	HTi2cDyfsTPoTSp3lvECnFTdgHQVACzjWYKDwIRAak4HJMKH0YfiNTeT4mrOGiCiR2OoFP3D/z0
	jvYQAlEP+W0EvqDaOpPA+7pvlRaX0co8eSdxropqoKWvPgoavLzpQLNjHnmt+k1vaWHjiZyjFQ=
	=
X-Received: by 2002:a05:7301:52c8:b0:381:dc3c:4c19 with SMTP id 5a478bee46e88-3827aed7177mr2606013eec.0.1794983888747;
        Tue, 17 Nov 2026 22:38:08 -0800 (PST)
Received: from localhost.localdomain ([27.59.52.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a63059e3sm6423069eec.5.2026.11.17.22.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:38:08 -0800 (PST)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: [PATCH v2] mm/damon/tests/core-kunit: add test for damon_call()
Date: Wed, 18 Nov 2026 12:07:55 +0530
Message-Id: <20261118063755.37749-1-saileshnandanavanam@gmail.com>
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

A newly allocated damon_ctx has call_controls_obsolete set, meaning no
kdamond is available to handle call requests.  damon_call() should
return -ECANCELED in that case instead of queueing the request and
waiting forever.  When call_controls_obsolete is unset and
damon_call_control->repeat is set, damon_call() should return 0
without waiting for kdamond.  Add a kunit test for the two cases.

Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
---
Changes from v1
(https://lore.kernel.org/20261117172219.26725-1-saileshnandanavanam@gmail.com,
 https://lore.kernel.org/20261117174834.29182-1-saileshnandanavanam@gmail.com)
- Merge the two tests into damon_test_call().
- Drop the list_empty()/call_controls.next expectations.
- Drop list_del() on the stack-allocated control.
- Post as a single patch.

 mm/damon/tests/core-kunit.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 43e2f950f8ff..228cb044d1dd 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2481,6 +2481,27 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	damon_free_target(t);
 }
 
+static void damon_test_call(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	struct damon_call_control control = {};
+	int ret;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
+	ret = damon_call(ctx, &control);
+	KUNIT_EXPECT_EQ(test, ret, -ECANCELED);
+
+	ctx->call_controls_obsolete = false;
+	control.repeat = true;
+	ret = damon_call(ctx, &control);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2525,6 +2546,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_rand),
 	KUNIT_CASE(damos_test_esz_goal_temporal),
 	KUNIT_CASE(damon_test_last_region_quota_reset),
+	KUNIT_CASE(damon_test_call),
 	{},
 };
 

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.34.1

