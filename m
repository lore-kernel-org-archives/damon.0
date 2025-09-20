Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E16225F79A
	for <damon@lists.linux.dev>; Sat, 20 Sep 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365583; cv=none; b=m0qE/8koyXqaSPBWOBkZuq3EVNJJnVBrUws3BA5XpmA83K5l5gFoZkDM3aOKrZljNRdThq6ruxLdE9nogvruTfyopS0QIXez/dmlDih7x/PsGCP1sVsdVxZmueu+vPAvygizJOO8aA/yfIfHXqMA2mpuydT++3658E9exT2q0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365583; c=relaxed/simple;
	bh=ILQ7np6iYcbWd/E3L3dxiJJYTSPoJju8STS1ry5D/E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fKfOEwlyXTFNQNQzxmkLF1ZM4U76Mgge2yHQklDEXLGln51K6doUVMjnv/uc9D8NRvFcpH7JlbTg9ZzuEyd7dZ5G/xUq7ghi8teyGfVCyDQIbk0cbUJdTAFnZU/3GBf30MdhcZAC+fGCpZRQwTjgaENzwqiwkVUF6htRZ6riVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfdN4z7x; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfdN4z7x"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-267f0fe72a1so19077785ad.2
        for <damon@lists.linux.dev>; Sat, 20 Sep 2025 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758365580; x=1758970380; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Zw24UHgc0XYVtGuGaF7Ugi4fpJHTM194lXS61zOwf8=;
        b=lfdN4z7xHvEt1Zxyhsubf9KQiRTdDoJG0pUfsKugUiBtY7aA9RF1UcXb9Cv2tg+KAp
         ZJRUA+MVyhtcE2u+a4eFsAhTeKUAC/LnkizjsYvUkbGGBr5Q+EM7toV98RC5P5lyytZA
         wX9wYDobafd7uciot0G6kj2CFkDjewuMNxwqw1UoB+53JeGpZpZe9pKLD5WQDyEVUpko
         SvKfrTF+mb2rsDQsZtHgtPfZMFBsBAQzc9ffY4+9hAw+M13Tpz1/QmN5pwckS4A1RsEU
         c2qYxqMZ/QsP0WRgDfzJsL8PgWjVoGUtudBUgKe4bqon90DSUmX0WYnUw3rgXAJzxCNp
         Vr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758365580; x=1758970380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Zw24UHgc0XYVtGuGaF7Ugi4fpJHTM194lXS61zOwf8=;
        b=hMTnFAeHB6gO/k0kXCQBBv7otOMNDZ2rUF9SNlmW3DP+gg1RRXMXZGgb1rPfKKMQek
         EiQRfucbIFK4HGeXYSVZbVV4R6MZnCUejClPbjn8WALi22U/IKv26F4lDOzAMLyjnN/u
         kull9JMSF062R7Lhj/l0SNTwjmqsNbwFjZ8rWUVivHEPryNxAxTNcU1lhoiye4NTVwrI
         Yp7z2PibY3H8QM1I23ugHWTwIdHFxihX3lSy8yxV4G7A6UKCU2VIVPcIW4wO7KIYyzKT
         yiw07ShU3bbo18UYRSBfr8RSF3m/yAXbi1GU8VkXLU/iz/SjetZRQRyz5i/zxSi/bQ8l
         mFXQ==
X-Gm-Message-State: AOJu0YxAHzrp1ljURfKDJP91aOQqCRfComx+d5YO2p3nhiE1CLyTSPJp
	28DzYnIyIV2/ktixR1p/WX9EBuo6CjqBCFa3QT2+xb1A7YBtI2FyiaM0RUPTYw==
X-Gm-Gg: ASbGncs0RiFm0TM6cVsdQNjAAQ58EilpgFkgQ3ZsUUf6qM0BA8A3M6vzn/hKn/GZStZ
	wvRXo2kzUp/67Y5na/Q2Gs0iVEMy3Ljtbmsz1Unf25WBqffZ1ssYU2jL77CO/IPKD/4euHKYeNh
	8gcaYmvXsGawU+uAA52dFDa3eNESsYsMRP87X0OB6ehbTzif0Axnt7txpH4SIqiNv+0qbeHFQpS
	VTbqY/6AasBdO+mj0WwiZ8jassvrB5pSuW1H7sanpc/7BQufC2C8YDn/izAndHiyffH8xPu/8cS
	R+Jo/d/ubw+jHxAVQMY56nZuesbEia/2gn6/8cllNp1hS1W3G30BzYWa7yxKijs5ehzAT0xAv92
	ftgwx8BtyYmJ4fTvIMSeTtLM/IvjJ7t5yRk7o
X-Google-Smtp-Source: AGHT+IGzwDlfyspE+IMTN3Dm/yPKZj/0hUEwcDlbe6QTyNxjv/QbU9bY/I207Q7ZnZiHLoWOilskzQ==
X-Received: by 2002:a17:902:fc50:b0:269:b6bd:bc0b with SMTP id d9443c01a7336-269ba3cbf96mr67210805ad.10.1758365579861;
        Sat, 20 Sep 2025 03:52:59 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:8249:87c3:45e:6771])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm79851195ad.54.2025.09.20.03.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 03:52:59 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: akinobu.mita@gmail.com
Subject: [PATCH] mm/damon/sysfs: do not ignore callback's return value in damon_sysfs_damon_call()
Date: Sat, 20 Sep 2025 19:52:36 +0900
Message-ID: <20250920105236.29952-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callback return value is ignored in damon_sysfs_damon_call(), which
means that it is not possible to detect invalid user input when writing
commands such as 'commit' to /sys/kernel/mm/damon/admin/kdamonds/<K>/state.
Fix it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index fe4e73d0ebbb..97e16f00f23e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1627,12 +1627,15 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
 		struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_call_control call_control = {};
+	int err;
 
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
 	call_control.fn = fn;
 	call_control.data = kdamond;
-	return damon_call(kdamond->damon_ctx, &call_control);
+	err = damon_call(kdamond->damon_ctx, &call_control);
+
+	return err ? err : call_control.return_code;
 }
 
 struct damon_sysfs_schemes_walk_data {
-- 
2.43.0

