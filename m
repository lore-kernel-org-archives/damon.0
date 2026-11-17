Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936146;
	b=nh5mf7YjIQ7ZpRwdmWzGV3se0gtkF4dmbF3aig33Rb1nB2jOgpZSNuRVBcZGucQbTh0V
	 JEWpn9Ri1Hr0CCCqbS0D0QvjVaQEz7pPMva2r/NPbSSc+6Kx1yeM0GB7lyd1E412kGlna
	 yhvi6pL4La73a4cX7+nI0/WJOJPy4AnBJoOa5BiLPMd81wRvmiOHV5ZqtCkyPrXTnhA++
	 7GZNePOG0ps4eUmSwsLw0oeZF+nMwiJW56Olxj2DuIvzogbgRwMI8MIjpXRtuTLYv41VN
	 7wwsJwUMsaa+xS7rzjj2mx2NT2e1i2JfW0/8T+xKFdKxh6s5RUS37gHOwDL2Cv59KYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BuMdsy7WLDJTbG/fzLpGZSQEU36QGPKXqBoedqSItWQ=;
	b=4ta3eLHRWTmzWOva0eGcPz10P49iP1cX3Z7gPaPyMPPpPGniTZmsfpnLPQ/8Qgg1jP90
	 sOIfY9ZSmxs1k+7R6iAgCHlAKGqbbfzP7M+dLWQRhVye+COXP8qHjbJxCWzLBSHKc+3Xm
	 brOuCec7G2BANDn7+nnNcLIRRo/KHcrz70nDazOL6wn2mb3Pj+sstwMQiVmRDl3cOsHAO
	 9lvc/g3BUzBSuQCqu8+FLLvGo4a3+0iwDkMX/FvwkMnnGN21M5/fwujlMboVofPdp8cEz
	 0v/6kJCQFavsAa2vmBP+13wWWmAI+h4VQ1nRAjA72GXrL+yI4oBKBQDX0FTPN0inCow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9r3JigQ;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33F606A33D
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA33F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9r3JigQ
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3822ae3b363so16512eec.3
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 09:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936145; x=1795540945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuMdsy7WLDJTbG/fzLpGZSQEU36QGPKXqBoedqSItWQ=;
        b=a9r3JigQE6wueThFkAxoiuhEqpZScAzinW/y3iLOSYf/HB/9a86enlWDfcETXaY60H
         rb1TpRuZQrL1TnbSI84ntduKfaKWFn/4CDS1g43sVx9p0B7elDsMtJ6vs71gVbvJRACf
         OU75k8uXFqVyecs5b4+J7UeZBPfOn+YMll0XnKBtzPXSyhAYZwtfgCw0B+Bt8lAUWuhz
         QskELBa3Pv1FysfBKeNqyNvklycrP0mrz3VJTkLypVWTf+DLz9azuaJ1v+YOv5hrJspQ
         MEMDIprTyZ+514sTghYPWA2xPaUmraZ1R9VX+R36zCpRyDEEJ70wYM+ZqsjiZ/opoAso
         j2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936145; x=1795540945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuMdsy7WLDJTbG/fzLpGZSQEU36QGPKXqBoedqSItWQ=;
        b=JtMpcatGQc18ncEhlfo+Cd3T22B4tuHpd/3kAI/z6N+8/LT/eBdTkPF4wQPMah+smm
         h9uz3tUAK2WVFH8Kc8Eg7SY34m53TPjDhd9QsVUIXJ4rat2xqPXd9qXisyQGlfEFd1W6
         x5TSBWNwlwVx09Z+DRSMps6LpzSILnjWMp7+/LSkeW/xLKPM7GWytaUOXV8Ozlm2b405
         IrC4BWVymPSeDzRg4HwwByp9J2leQFZFRnK4zqHplJBdbY5ZAcNq5WLfWpCsW9v7m3ih
         fafl3p1NXEPS7xJjyeolkFD+1VfrgAdMn4ogGGaNXNqHzs0cIwQAhJ/jV5nFmhWJ86uP
         7F6w==
X-Gm-Message-State: APuU4Z/AvLsTu6Wh57BZbDjCiq3VqdoyafGduTbG1bn0RmCxBxQkR7ar
	e2obmIpAUpGF4OdRsYk8oAQbOzrXZjsYtJYiwfvT3pj3VlHzg1S4mhNK4VshH2f+
X-Gm-Gg: AZFdTZeHap5m65SlfrNKwZtVWQGVLY2Tz7tn84mepnfs9JvaZ+LXYH5O63K6aFMF9v0
	O4+5s99QMrR/n+vJWOVQNe51Be6KAP78iWvvW6GkjdYPzbHuaNGzGUNe4baTkDV/fi9Dvs5/tsO
	oH0ioOa/F9RjJQx8KxvZBY2Nojr8YoD0rSfMhqlOifqRvCeWyutfTNrvhv6vm4Y6kxptGD5o30P
	qofWZmRY1YXUCp7oHpPKKycHAmeb42VT/qQqSNwebLboKHoxO1wJxQqdTK4caVKl088sQ4OLvjQ
	gPUNUQz8f1iUQVfuPeywhbZzneMaiX1w/UkAeIWNv4iiymRqakWwda4MPHQAOG6iHNSMytBJ9xI
	lKLvG8nP5IlBddT412mxoJAbvVJR/Z5qsOK8DzUAdOfDumxoXRaaxREQHOp5S69GwKSH7jtq0CB
	aghp/DAXkBJ5A9jsPtNxIyF8N7v5WBbx/Yb1iqvE5I6v3fYSUlmisX6Ww6a8QohqoBN1Mkhv6SW
	aVSztzU/fhCkpYKyvfkgUrJyvgMOrPbC+e9OPM2Yp9SHkC8vKF4sfNS5ft3PHESmHAG2/CgAh3u
	chODATQTAMgq2XOEXBFBbxDdYesRArrmTNSGRHM7SShdnCwvdGNnC3Q=
X-Received: by 2002:a05:693c:2113:b0:372:c0ee:875b with SMTP id 5a478bee46e88-3827aed1f65mr225022eec.0.1794936144774;
        Tue, 17 Nov 2026 09:22:24 -0800 (PST)
Received: from localhost.localdomain ([38.254.175.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm45963480eec.9.2026.11.17.09.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:22:24 -0800 (PST)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: [PATCH] mm/damon/tests/core-kunit: add test for damon_call() on obsolete ctx
Date: Tue, 17 Nov 2026 22:52:19 +0530
Message-Id: <20261117172219.26725-1-saileshnandanavanam@gmail.com>
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
waiting forever.  Add a kunit test for that.

Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
---
 mm/damon/tests/core-kunit.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 43e2f950f8ff..13315291f69f 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -2481,6 +2481,24 @@ static void damon_test_last_region_quota_reset(struct kunit *test)
 	damon_free_target(t);
 }
 
+static void damon_test_call_controls_obsolete(struct kunit *test)
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
+	ret = damon_call(ctx, &control);
+
+	KUNIT_EXPECT_EQ(test, ret, -ECANCELED);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -2525,6 +2543,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_rand),
 	KUNIT_CASE(damos_test_esz_goal_temporal),
 	KUNIT_CASE(damon_test_last_region_quota_reset),
+	KUNIT_CASE(damon_test_call_controls_obsolete),
 	{},
 };
 

base-commit: 72e1cd73734bc4d52affbf7896389bf3814bcf9d
-- 
2.34.1

