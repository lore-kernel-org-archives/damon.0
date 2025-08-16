Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07D15687D
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309174; cv=none; b=p4Jdn5lxmrVBysCs93xyQm8DDU7eO4Ka/iiAPfIuh/smO/83qmFrrwKMbOv4/J3BqYULUMMjIdLXuxDh48oCBmgJC6hood6GGOTQ/phNd/YPSjYLFQR4/bnSNlaoPRb3Rti6KSbcpu3qSBIaXPnmb0Ph4o0ydh1CdxKqk/bTAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309174; c=relaxed/simple;
	bh=IZG/KJfVeBj/miM0tdGc0qY88Z24bIrYIekeNXgCW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNKbJUbrFw/BzSGPViDGn6ovV9IABzkTD0jVkuSO0ZXeEaRNSa9k84knFISV2JV8poPdZKXIZcLznc7p7rjJ/6ls4ZGXoiTTyFT5PsNUp9wiIA3VWLcvL5UFmF8RB2ApSvAj9n2QY/jVU4oTlOgOpRcsK2Ullhgxtwf0B1Cz2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MraY1mW0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MraY1mW0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e39ec6e05so1380258b3a.2
        for <damon@lists.linux.dev>; Fri, 15 Aug 2025 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755309172; x=1755913972; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLKG6jNvVUsekFiiFHIYl022cHqokzDGITdYQJ2LTYk=;
        b=MraY1mW0jhKeRl/aQcfCdhkjGXNqb4OHf2bCzq/e/ytc0zXVcpdG1R6V+bA9fTVoAm
         hoIWx0GECDX7ZYi+ucYfReZXOwMRjAK6mlR/WlDr2/6Ylo9kMqcF2BrB37lDIfxGM+zv
         XCZE4lJC5Na94dT7Q8LsWp1EUdm0jJz/eyti3FLQt4LEuj9xQSeAqSJzXHhMJ6CNaPtt
         256wmIYDKJOjvGjMT5mE3HuOsEeHsXua1UY4kJWSYIPAXWYMPyihmXsEIumx7jYkBdJR
         o0088IGzBchqmHCxUlXFYKGvEo7l3O00Wl9TT9eFGusuUB2wEnnBhl053KRa2b+D4j8X
         QvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755309172; x=1755913972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLKG6jNvVUsekFiiFHIYl022cHqokzDGITdYQJ2LTYk=;
        b=dQ0erHyoCIbvNk+qihZACa6fQztCqclpiEj77rvyhuSLhH3nkU+4CFU8dYbLxgule4
         jM0YIGJrXDWa+9aCI69gseUNRZmbSbbe0RFPvYlmw7kb3c9NHDntfVWD7A/CkZnNBxTm
         UsPS7RjYM1/eoxizrceGQ3yFy9fi7gHAOeTQ5A6b7/wbEwglyB8s9R9sqpIQdYoWmPvl
         QsKhtSKXFTeyJ4L9ZdKRGvmjsEi0f5easeIwaVOXzbAcrWsTE2WHGagBcCwTFR/Y+AhY
         JnlOyBSacHo/sEB6PV4Y6eWgkWkjgl5lG4iOm73ki4mjMRSOEdDc4uRNGm4uVxwipeO9
         bE1Q==
X-Gm-Message-State: AOJu0YzhYXxTnCXVYc2kg1ri7yd90/TEheMDzK4sfg/NTqoLNtYi/ydQ
	JNSjCD/Yn0Oa2Zqn+rRi5SDeVzBFwhOTOmUloX46YsDpOkD9UTHxbKO2
X-Gm-Gg: ASbGnctCws1XFmROptvZSiMERVNs/x4R8uYsLWs9fD78Y+mYYTED+rw9NS5wYpKou8Y
	/FHLEYMzRxdWGSufZyH7Tkj5ODffW37q6SEJYjkWiDO74Re0YUXEN+sJvRGxpsJPL82CpV6lGv9
	qulJg8/uDupkU1CqW1iNXR+Xdw2ER1H2pkpJA73lSdBlX4UUWgxVIz8+Y9hiCIyETi8lQdJs+X5
	ofpzPsWZspYxD+1yfpA5pUYec6JQQ8FSMqh31kg+7+4TZx8w4AM77un9bHUZGfpnfN2P4dWtRLy
	qFE7hBGh09uRcUKo7bAlQo1mj/FlGMXdo1M9drA5f6P9hOHGDXEBkndv8nunOIlUhTr+SQPg+he
	bYZAPBNcEDUwJ9xsx
X-Google-Smtp-Source: AGHT+IF9A2Kqr68he/7eryBtdSIV/oxea5NzcQp/EEPSEaGXhlmWWl1RqA4Rfv6eTN56d7YYgkaoMQ==
X-Received: by 2002:a05:6a00:238c:b0:73d:fa54:afb9 with SMTP id d2e1a72fcca58-76e446fcdcbmr6372130b3a.7.1755309172232;
        Fri, 15 Aug 2025 18:52:52 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45293ddbsm2076609b3a.49.2025.08.15.18.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:52:51 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix damos_commit_filter not changing allow
Date: Sat, 16 Aug 2025 10:51:16 +0900
Message-ID: <20250816015116.194589-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current damos_commit_filter() not persist allow value of filter. As a
result, changing allow value of filter and commit doesn't change
allow value.

Add the missing allow value update, so commit filter now persist changing
allow value well.

Fixes: fe6d7fdd6249 ("mm/damon/core: add damos_filter->allow field")
Cc: stable@vger.kernel.org # 6.14.x
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
- Fix wrong fixes section commit
- Add cc section for backporting

[1] https://lore.kernel.org/damon/20250815094059.133769-1-ekffu200098@gmail.com/

---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 19c8f01fc81a..cb41fddca78c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -900,6 +900,7 @@ static void damos_commit_filter(
 {
 	dst->type = src->type;
 	dst->matching = src->matching;
+	dst->allow = src->allow;
 	damos_commit_filter_arg(dst, src);
 }
 
-- 
2.43.0

