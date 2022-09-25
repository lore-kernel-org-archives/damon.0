Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA64682
	for <damon@lists.linux.dev>; Sun, 25 Sep 2022 23:41:10 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id l65so5062674pfl.8
        for <damon@lists.linux.dev>; Sun, 25 Sep 2022 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=EJWUlJuWSVweYYTQ+dItlLI+eSuI7yW2uCV4qAeh0kU=;
        b=fvq4fpbn3ex+gwHX+Is+B+dE0MRJelLSlfgQAPd1J5zp31ufQE9hhklVsXrBbCLY5l
         iA3+XPDSiAKcJ6mJeXLXyntX+a3+kqJYl8aAmVIymy4Dv2DZ5+GrQKPHigkntjj+0GW+
         7DFbLi6GhVE7UUghq0oNPoEpRytFv2SUMgVFAWXshdfMfm8W9+/uuSLJlPq5cqGWDO6s
         gAhV5YunS46z+xHoT+RJYi4H4fzhRhf3GsRTLWF5jqQyPVStjpxitrUGj6tPqy1kSLWi
         zU1Y9Ik6jA5ejRuJB5xB16Za7okYXKPeQaZASMSq2N0yMtiwOmjXdc07zetVZ278HdJL
         CkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EJWUlJuWSVweYYTQ+dItlLI+eSuI7yW2uCV4qAeh0kU=;
        b=EitxT/5bwcmo7jTqJMGZBJyNTgmup7S6WwdRArezXbRqdp6YXZCA0IrY98jAOti/Ti
         7/Nq+s2vFNVec8kE4PM08cz0rA6qQ3fMTPD+bEb3is5IUlBvI/Wmwv5/aH3FTuGasuzy
         M5YftIQwuF48HyE6Qk/JlKjsf6E8iVwur+wiYbKsC8dDOzztUhPhCisT7kXiJSvLTGFW
         0QGvo2K1QVYzkFJXcsA7RS8cX40SsU34D+iDuIWOklX50RsJxhWZ5upaIztDqkfzQlar
         BzcFle1S72m6pVOecH40fJuViJbc8vgiSmik1FAF1mojfICJONsrM54TNfgHjIUCi6wz
         u67Q==
X-Gm-Message-State: ACrzQf2FSwnAt3175cfLpWxG59Rp3Q54EHlznRVjsKOP1Q76Vn8nXDO6
	KCaYgITQ1D8XcDaA+epSRckkn8DKUDThag==
X-Google-Smtp-Source: AMsMyM40BIFfZsnDm1JHPvOt0jtCuwgk+xHwkawWyFYYWJ9W7tiXOIg8/mipSMShx2tnhDGtpXUJ8g==
X-Received: by 2002:a65:40c8:0:b0:434:dfee:8dc1 with SMTP id u8-20020a6540c8000000b00434dfee8dc1mr18072970pgp.156.1664149269775;
        Sun, 25 Sep 2022 16:41:09 -0700 (PDT)
Received: from localhost.localdomain ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b0052d417039c2sm10584739pfr.133.2022.09.25.16.41.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Sep 2022 16:41:09 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH v2] damon/sysfs: Fix possible memleak on damon_sysfs_add_target.
Date: Mon, 26 Sep 2022 08:40:53 +0900
Message-Id: <20220925234053.26090-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
Reply-To: <20220925140257.23431-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When damon_sysfs_add_target couldn't find proper task,
New allocated damon_target structure isn't registered yet,
So, it's impossible to free new allocated one by
damon_sysfs_destroy_targets.

By calling damon_add_target first as soon as allocate new one,
Fix possible memory leak.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7488e27c87c3..bdef9682d0a0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2182,12 +2182,12 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,

 	if (!t)
 		return -ENOMEM;
+	damon_add_target(ctx, t);
 	if (damon_target_has_pid(ctx)) {
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
