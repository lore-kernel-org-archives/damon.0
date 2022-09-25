Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA42F5E
	for <damon@lists.linux.dev>; Sun, 25 Sep 2022 14:03:04 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id go6so4135419pjb.2
        for <damon@lists.linux.dev>; Sun, 25 Sep 2022 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ZY6szQTTBj1JZww6rWA//iUNJ4Y5SgYIaS44EEkivk4=;
        b=gwy/HfIEjYLB4athSXtLm7SUDpvDUKckf7T8h5/+Xk1FvixltE5tdsVcfWJxIh7lU7
         9mxTEGYZEj6wOZsZFe0eEwFWAY+c6+24pGqQ60VENOovQfrOGiAtigc9mHg++YJpp1Zk
         nZqbGhkHaxY+yMyQavcuakYzWSMDr9a2Kgo33yakIUPsw1WAd2Tr6DwVh9dIiA/kMse7
         neIanKhqTKcMbhnbTvDrTVjIYYzTYz6dZCEvFpOFS0hZKkFVSZwMOnNRAs7ru11eft0S
         fjAKQURuyqAT5+4WbtR0cg75wTsAYDeFfIeKyiaqB0DpwdHlPIfN6ELUChhJa1C5zyWk
         1J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ZY6szQTTBj1JZww6rWA//iUNJ4Y5SgYIaS44EEkivk4=;
        b=lmMJM88qTSltrvuJSlmQuPDWRI13TfSI81m9POgY5NNXG+6MHNbeMDCGtZvdVEIAgq
         /GNx0eQrJFs/pL6Nj8Y7k6EutlyfVM1zfWSIvsKdTzdnqV8zIh0DyXkCxsuGUdjL8hqq
         gy5jmI4I5oxrKOdZUxDJVFpZf0kLyQT2MA7GtSi7IkUeS0YefpqHAO88QbdGQ/iNIJ+8
         i8WwRrHutd0m0p2+SERYFmZLNXbwkTCgPtTccPJk2R5f8XVgzk7HLo60nFJRhGcjPYYe
         2iQBh8Ni7mRu2yCvrmFNe8p64Qr/iKfpNyrRfbO2PSKd882Ve4lv/SXjudl8VFrgREKL
         4y5A==
X-Gm-Message-State: ACrzQf3RCLPPnj5DGRdtu96ULodWXniltSEbo6RGLxwrQjOFELdqygKf
	npG8lxUY6FqCUZipdwm7TR4=
X-Google-Smtp-Source: AMsMyM5T24MKt8sY10ZEUsv/5F27+2RK1dT2EGJZzZvLyuLxB4Tty1CteU1VvJx5p4BoGNRI7qkiFA==
X-Received: by 2002:a17:902:dad2:b0:178:401c:f672 with SMTP id q18-20020a170902dad200b00178401cf672mr17046159plx.168.1664114583879;
        Sun, 25 Sep 2022 07:03:03 -0700 (PDT)
Received: from localhost.localdomain ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b00174f7d107c8sm1529910plk.293.2022.09.25.07.03.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Sep 2022 07:03:03 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] damon/sysfs: Fix possible memleak on damon_sysfs_add_target.
Date: Sun, 25 Sep 2022 23:02:57 +0900
Message-Id: <20220925140257.23431-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
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

By calling additional damon_free_target when find_get_pid function,
Fix possible memory leak.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 mm/damon/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7488e27c87c3..28ed07d26d55 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2184,8 +2184,11 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 		return -ENOMEM;
 	if (damon_target_has_pid(ctx)) {
 		t->pid = find_get_pid(sys_target->pid);
-		if (!t->pid)
+		if (!t->pid) {
+			damon_free_target(t);
+
 			goto destroy_targets_out;
+		}
 	}
 	damon_add_target(ctx, t);
 	err = damon_sysfs_set_regions(t, sys_target->regions);
-- 
2.35.1

