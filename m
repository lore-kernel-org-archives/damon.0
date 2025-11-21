Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428134C990
	for <damon@lists.linux.dev>; Fri, 21 Nov 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732205; cv=none; b=vBOqb4w/kIdT5RJMMbcMbj8dferf3TVRZww5TkIiGHN+7U9tk+knxI2iC5VZYcr72L6QZrtX4cF4hVUX3zK1QSU0JDWu2Uu+44a9gyUmz0cyfg6WRrwnDTaRmjZ6EBSyvBCRzcooT2a8Dz6wG5bPnB0KjsmOB39Iyih8FvksKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732205; c=relaxed/simple;
	bh=uE4HXHI9Mc6ljZxrgmkbsKbCZ4Sosf3M2ARYwEUQLlg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lj6h0jSEq3OEUv5dxXP2QYyBY7V5CV8SeNZp32ErwHrZpx4jLwPdkHHCqCiNvrZ31lLuWcYfkmY0LT24RJCqysiGFpZRwjeYjpXPtedfqcd3mFGmtbDvSMmhgsxVlyaL2khCljE6AXHqa3GWfRilRp1B/s234Hxp1fb7GZpZjwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P5h5ndm0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5h5ndm0"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477a1c28778so23254935e9.3
        for <damon@lists.linux.dev>; Fri, 21 Nov 2025 05:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763732202; x=1764337002; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzEyBCas7IooWk+MKSQXAh7ZMi3I77yN3jnhiz/DdHY=;
        b=P5h5ndm0+UfA/MbL7iVeGZVA/9C1GzMbai9NSN9BQvFTy5ZPbKjj+mPG3qxpLTK6oG
         swXxjgFtRIPngOHcqu9Dvfkin12Dljz8W+2uETjMi3QO+psTSUEhTNxHns1T0rX5X7V4
         j6Yg3TPO4ySYZ64RVqxcGcYte71lc4g6ZEgMNDSkt9imva3FXuPzOgUgukcUaoDRBCUh
         3IGE7qEVngGbGHUVgBnk8KRljVzE73cFptL3NOol5HAtKuFhs3mvdGgpxf588kIro4Ss
         0V7Wo7RvX9I4yMGuHyqqgbPRngHPfMq0x9aR9VWQYVEfMWYe8YfpxAD2t7oeaCYXy49A
         FGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732202; x=1764337002;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzEyBCas7IooWk+MKSQXAh7ZMi3I77yN3jnhiz/DdHY=;
        b=s/qEh4quAus5Xgr6BJvyyff1Q0yXASmT/y3nar56xN8Ni7/r0OoZniaHRv7VxJ7BcG
         mC7RrDy0chyXCphp4qOHBv7balzgHijgj0QSsfp9eGtzf/RbxC+hT2YiYjfV2zkC9nKk
         yvWu1wlwRJenpuKo15PzrnzqttgL4dd9anViboJhBOVvJZ1ZCcdzCHQ+ZG+50ORYuUYj
         C/qDHqsRidZa7LyILFeNMoozlN0ATSTnmyB7veK/bMdnINNT2YpRrwFjEx96oat8rluz
         Tpzbx9FX7Siwo21TOYBIIPl1iGerSFiRHYLscz3fuN0vWgWPGS0/lBBOg1EyBgkXMCZb
         Lbpg==
X-Forwarded-Encrypted: i=1; AJvYcCUL8bfyixvx7qgqhbteqrNXJ/pAvsHy6mPJsunqYUcyWecHU2o/dPKZqRb5yra0bWPhHTxYaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHvuK6gIxKTXYZ7ecbldwwMGlT2NamIwmFhcycVWhWTDkfh+hc
	cvX3nIWaWGVJvcuMdWftAty74b7QEq+s/dyZTVqpEuw/cP1pCyxCIO5FoeGbVW0K4jY=
X-Gm-Gg: ASbGncuDdL5dXXwG8n6nJKXKWsmrnXBym/pLXQW/KW7p1cPdvmSheJ3HpuJfO5OXcR/
	cfMhj4A5TgTFCPudcegHhZ3sKdm+exyziGCsW3v3+cmWg7mChGw2w4atEeeHYM1aXC0Q7pnJAF7
	K0TxaZugTdfKo63oP96watwJGdHq6LzoG94a72iKnuEWJult74sJ1vEycz4llNCe7A/mQUJOgAi
	Zdgqdy08DqTlbY4noO7u0/NMddbIEYO1TZu9zClHFd4VfHQmHwteKDgvDe7WybJkit4zB5j8Ee0
	pdxSOrRTu7VSXlnl/l6XuaIFkzSSxPw9ryZtyYxrQkzZwRzJXMOOxPK2jm/uBrr7EOIVcqrK8Ce
	LrDAo8VWVSBL9Uk4PPzZLVCLKKPhrbmZdbBK/iCzCozE3tGLKeEIY57q1A9PT37vPf3diwuhHGi
	rX8DZs5CFj8VcKfafU
X-Google-Smtp-Source: AGHT+IHn72BgHYyXBAFrHrkEPwDLpmHZJhWH76OVXgjki7oj4pfilEmGcsYHhJxsG+r/JbIMusA7sA==
X-Received: by 2002:a05:600c:470d:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-477c01f4f4emr28632935e9.31.1763732202028;
        Fri, 21 Nov 2025 05:36:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf3558d5sm43686925e9.1.2025.11.21.05.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:36:41 -0800 (PST)
Date: Fri, 21 Nov 2025 16:36:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] mm/damon/tests/sysfs-kunit: fix use after free on error
 path
Message-ID: <aSBq5uSPIqsqH8zO@stanley.mountain>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Re-order these frees to avoid dereferencing "sysfs_target" after it has
been freed.

Fixes: ee131696794c ("mm/damon/tests/sysfs-kunit: handle alloc failures on damon_sysfs_test_add_targets()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 mm/damon/tests/sysfs-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index ce7218469f20..0c665ed255a3 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -76,8 +76,8 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 	if (!ctx) {
 		kfree(sysfs_targets->targets_arr);
 		kfree(sysfs_targets);
-		kfree(sysfs_target);
 		kfree(sysfs_target->regions);
+		kfree(sysfs_target);
 		kunit_skip(test, "ctx alloc fail");
 	}
 
-- 
2.51.0

