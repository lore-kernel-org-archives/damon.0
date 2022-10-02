Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3813D8A
	for <damon@lists.linux.dev>; Sun,  2 Oct 2022 22:55:24 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id n7so8267544plp.1
        for <damon@lists.linux.dev>; Sun, 02 Oct 2022 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=b/cqXABwEkVImEJzZr0tX/Uc5PPjefuHaywOkawSlcY=;
        b=e3IO949lN/8sVUNjQ+f64Hso5GFXmlyB0SjpN3tte03IMJnjrXpYn6C/otRd6N+yoz
         kLupU+EtDt2MyMhd2hzAWVDyKRF0UfKV0FkvffC7P+c9sfirldy6/TUKJTIKVO1Qm5dP
         5XivOUXdhYxW1Cd85uhVKCkDnFxNlSIu1kT7qsNdgyAwWtFuExbXtf1kde0pRj5GgEQu
         REgTVX8nZSKd4FODAwVV99LnmdHD9eUgSf91YkWrih5Nr9qj6ZEDKWEcxXS+rRKRkGYL
         StSnspO1mf+BZjp5hEpFCYPLfWVSuHk3f+yLbcHc9hJp3yH9lOER6aDp1Y/i5BAQ2CyO
         1tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=b/cqXABwEkVImEJzZr0tX/Uc5PPjefuHaywOkawSlcY=;
        b=7ngEeOAxHqi1T38IPkCdzznfBJIIMV8NsAPd4+tXETSYbj+CyOoG85wTEcfryDK4Ed
         dVYJ4UkWBnGgyQqW45lLysSkcBtM3ljzTkbjhkEwm9KhJpuu0Z6qDpQ17sjrglz8fO6W
         OTrpWK2iNwIB+trzZqx33nHtONQlfEqGkxWBJX4TFl7WYP0gz7SlILkICvJiLXBnXwDw
         DiB7TNEwxeIKf7VZ5wiH5o3W6rH2dXZtn8EanWx40m/G2NpONTaXP0rg3p3v+Ucrs6nB
         E6encmW+GoOMnuV6CU4nmnxHhJYtie1RYx/MrTccxeXw+T1vxvzTlGzxQO7xNfTJwCNb
         PdAA==
X-Gm-Message-State: ACrzQf1Nr7W3rY2UrQXd/wYZtxEj/bn0jD86NQ2hO59NLINiQ2zDCXZt
	RhI5h1YJ8NNxx67QqLzSrNk=
X-Google-Smtp-Source: AMsMyM4hRvMaReSshv6hmGDBn+Lt+0ll8ylRSELdGJqX1tqjcjkgEoHMUa4emdmB/MBQav7x0XZzpA==
X-Received: by 2002:a17:90b:4c03:b0:20a:919d:44a3 with SMTP id na3-20020a17090b4c0300b0020a919d44a3mr4070665pjb.146.1664751323871;
        Sun, 02 Oct 2022 15:55:23 -0700 (PDT)
Received: from localhost.localdomain ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a86c200b001f5513f6fb9sm5297022pjv.14.2022.10.02.15.55.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 02 Oct 2022 15:55:23 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH for-stable-5.19.y] fix possible memleak on damon_sysfs_add_target
Date: Mon,  3 Oct 2022 07:54:45 +0900
Message-Id: <20221002225444.70464-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 1c8e2349f2d0 ("damon/sysfs: fix possible memleak on damon_sysfs_add_target") upstream.

When damon_sysfs_add_target couldn't find proper task,
New allocated damon_target structure isn't registered yet,
So, it's impossible to free new allocated one by damon_sysfs_destroy_targets.

By calling damon_add_target as soon as allocating new target,
Fix this possible memory leak.

Link: https://lkml.kernel.org/r/20220926160611.48536-1-sj@kernel.org
Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 09f9e8ca3d1f..5b5ee3308d71 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2181,13 +2181,13 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,

 	if (!t)
 		return -ENOMEM;
+	damon_add_target(ctx, t);
 	if (ctx->ops.id == DAMON_OPS_VADDR ||
 			ctx->ops.id == DAMON_OPS_FVADDR) {
 		t->pid = find_get_pid(sys_target->pid);
 		if (!t->pid)
 			goto destroy_targets_out;
 	}
-	damon_add_target(ctx, t);
 	err = damon_sysfs_set_regions(t, sys_target->regions);
 	if (err)
 		goto destroy_targets_out;
--
2.35.1
