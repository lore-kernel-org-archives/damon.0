Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D14249F6
	for <damon@lists.linux.dev>; Mon,  6 Nov 2023 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGk6ifjb"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9c603e235d1so660175166b.3
        for <damon@lists.linux.dev>; Mon, 06 Nov 2023 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699279664; x=1699884464; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jgVbQBMI5zlzuMwMovjOCtuCkKuAbIOmNERMV3iGn8=;
        b=AGk6ifjbqopNEaGD0Iio2MgzqXyfgePNwoniZMWEeWiWoLXiiuQseY8fvH/SRs9RUr
         TotdYku9/JTXwX1GrfnCeCz8ZzfMgFhvbBJl64qTdB+kVlfxMsJnZZPHvh1YEisJNGjD
         n8B80hTXd189AfBLpq2C/gS36LCWKivM5UKHqxOxW28lWxog/7GIPx3fV7vHb7Yk08RU
         K8waua9I6Zoj95r7QISYXFW22PWu5ftV3yjQ9cOfutauGH5FYxHHXBtmABGeVzhX6Wr0
         EErzG5s/ngY6/rcMTG+tUrGVJOZpQPxvd/rwmz0D/zo4LQ6fnGy7DP4Ic1s47Q12Sy6g
         vt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699279664; x=1699884464;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jgVbQBMI5zlzuMwMovjOCtuCkKuAbIOmNERMV3iGn8=;
        b=sOgiMS5leSSgULkZbWcow2dcK1FYQADvkNdW/rx1sTwsP35j98h4kC6hC0xGQVHqmb
         luUOCyQUAhSzj51hMvUul8CScAYnkbRNkPj8TwaWntJ+cTYrjSQQQ9AAzd/NWzoEH9La
         34flQaaVDAh7xguAJumEKhOaSG5iB6skye5GyKjXW76M3Sf5Fg24QRoTjcrbJuyMvTJy
         vwgQDa9IVUc/fYFJqCQ7ScXcc2shp+71hDPI50zw9QjBl3LBKBtDm6lcv5U/bQTSXNqg
         +e2I/J58Dm9n4SkS1QVoTsapF688FM5rqPbNZdAzUcBgfc6e4cNAzeU+NVvrfawI8Yrz
         ZAaw==
X-Gm-Message-State: AOJu0YzWEzcIplJa5ef8Clcq1PQhEmIPjgaGPTZ5uhx2qog+J2RQjkRx
	0qI+rpvtpy2BondKe2/JQnm2Tg==
X-Google-Smtp-Source: AGHT+IEijAt6Ah4VQuBzxP5KzJ7RXy+VDCSC0/AOkIK58u2UR5ihryIsP11l3ucRzoRTNGBW+qK6/g==
X-Received: by 2002:a17:906:db01:b0:9d5:9ff5:ce with SMTP id xj1-20020a170906db0100b009d59ff500cemr12398157ejb.34.1699279663769;
        Mon, 06 Nov 2023 06:07:43 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id kj26-20020a170907765a00b00988f168811bsm4164464ejc.135.2023.11.06.06.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:07:43 -0800 (PST)
Date: Mon, 6 Nov 2023 17:07:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm/damon/sysfs: eliminate potential uninitialized variable
 warning
Message-ID: <739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "err" variable is not initialized if damon_target_has_pid(ctx) is
false and sys_target->regions->nr is zero.

Fixes: 0bcd216c4741 ("mm/damon/sysfs: update monitoring target regions for online input commit")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e27846708b5a..1dfa96d4de99 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1172,7 +1172,7 @@ static int damon_sysfs_update_target(struct damon_target *target,
 		struct damon_ctx *ctx,
 		struct damon_sysfs_target *sys_target)
 {
-	int err;
+	int err = 0;
 
 	if (damon_target_has_pid(ctx)) {
 		err = damon_sysfs_update_target_pid(target, sys_target->pid);
-- 
2.42.0

