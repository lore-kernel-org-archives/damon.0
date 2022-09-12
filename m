Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36D2F2A
	for <damon@lists.linux.dev>; Mon, 12 Sep 2022 15:12:45 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id u22so8869497plq.12
        for <damon@lists.linux.dev>; Mon, 12 Sep 2022 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J2EfS61ET44TCc+3QSfNlPKs8G07uWPFuZhCKqF9mNg=;
        b=lvadD5K3rHg41vyguPIZs3SAs0qNEImqL8auN87u0WS8Do2g67gHhkQT80c2u4gJxA
         RGJOtB8EtMOgz2k4rYvmUvKTGV/3ZnNJse0pcxuUIzu/N0bjKvNPvvyQrk8r6lBIM/Vc
         /BYK8ItrmRLwSa0fnHA5ys3gKpncm5G+gS1pLgs3lBe6c/qMWSFhc9HHeTqDt5crXB58
         dMCmFTlzaspQrnhNv34zGiay22wWatvIt5YpeYR7QmL1bM9UD08RGB/0P0ZxQhU0SQB9
         ht62eIr0wA4e+6jHqXf2Iz80usBeX4hXAurB18Zq4qrO8te4W6M3cFsXgDuoywwHSDvN
         h2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J2EfS61ET44TCc+3QSfNlPKs8G07uWPFuZhCKqF9mNg=;
        b=tgJ4Xu43WUi8HxJ+9eUYCr2Rg46cQpVOEhthMobo3LK8xh+hWUo6dKhdCMSAjQQkv2
         DpketrgAs49g6KoDRMbaG1bLiXq05F0hxQg7IoXKVbeAm+/0ij1PAl+0vM6Ml9SyYPWM
         p+4i08//ZQFt+Wb3F2hYoxoNYAroqO9Cqb5Y7zSdXR33WWwVpHZPzQ3lwUAfjNMFElcs
         b9DfDqPmd4fNtnCmY7BNAoU9yGoDAo7QHSE51JeoYqBsdqy26hmqmPVwmF5rTDBBfpcV
         wrAMA4K5l7G2GkitgQdGDnPIWmD+8+jc0YVj8ogWO/ZraUPxiIuR84gRd3JYJDM07c0G
         QLzQ==
X-Gm-Message-State: ACgBeo0iUZzrUAzaidX2D173RPy5A/DyUGP2NlwpwfBV1cd8SfVDnCfy
	rQglEMClCYME5jnQToFHzQ==
X-Google-Smtp-Source: AA6agR6mScOPPWtchxpH7T2XGJUOb+bGqVrhg7PQocFGMCm7j1FNyLGp4fCFo47zYN9F8iYQZqsj5A==
X-Received: by 2002:a17:902:e14c:b0:177:e7be:2ab6 with SMTP id d12-20020a170902e14c00b00177e7be2ab6mr23975827pla.25.1662995564687;
        Mon, 12 Sep 2022 08:12:44 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090a0c5000b00200b2894648sm5311046pje.52.2022.09.12.08.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2022 08:12:43 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/sysfs: use the wrapper directly to check if the kdamond is running
Date: Mon, 12 Sep 2022 23:11:53 +0800
Message-Id: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

We can use the 'damon_sysfs_kdamond_running()' wrapper directly to
check if the kdamond is running in 'damon_sysfs_turn_damon_on()'.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7488e27c87c3..84861c4085a5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2455,8 +2455,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	struct damon_ctx *ctx;
 	int err;
 
-	if (kdamond->damon_ctx &&
-			damon_sysfs_ctx_running(kdamond->damon_ctx))
+	if (damon_sysfs_kdamond_running(kdamond))
 		return -EBUSY;
 	if (damon_sysfs_cmd_request.kdamond == kdamond)
 		return -EBUSY;
-- 
2.27.0

