Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABA4682
	for <damon@lists.linux.dev>; Sun, 25 Sep 2022 23:43:55 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id t190so5092846pgd.9
        for <damon@lists.linux.dev>; Sun, 25 Sep 2022 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=8l9SZEXeOGAHPaBYKpiKd2zRj1VQl6STNmYmUqvRW6o=;
        b=EyhErhjnZzbiLOtmYu3OzBfUaJ+feqdxAletymaonCXsf+pm1aB2w/8bIpcfolRMxH
         yl4MqdZEeWSJK5ecwsBqwQ1GSb+NJe3L1xK/y3A/+Gxe45ksPFkfOvjCfQJsg13cAX1l
         3dnDDAtXAkww1in6A5oXz3v+vizcKoIN5KyM8bDxf5Pk3sd/b2OQy+ZHyt5rc0O2iXDU
         JVyK8PfhGNlIHf4SPLVqQNk0lsm7qz8RMw+PrVY2iB05gKj+iu7y3i5/BR+XUc/DO9Ol
         yDmZA77oCNugezpHy+BoyOLqltTFYj9dfrD03uqaC+NczdzL7R9rAGgNWjYbF4HsR7z1
         zk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8l9SZEXeOGAHPaBYKpiKd2zRj1VQl6STNmYmUqvRW6o=;
        b=UAD1CZ7gNhnj4SvYYiah0sGsLVCW+JnMrL5E6NIlYA2onvBlQ+osMtSt8WV4lARv/U
         0VSs5pVLAmTSm00nho++nmsgmwkCkDezfV8L8Z6d1++UBhhVagqNWAFpkDfDaHjZWEQb
         AivOTRmaq4gzVW79SsCqPc6BqyDaYmB8BaGwTrF+yM78+HjI0nbQvGmLYanfkYL2olMV
         iR6quEvyf3Sd8HnipNWWOAyQSONBPIJEuZWHY9w10gp+BBlAwwFsBVt82N35Jb2N10br
         zewLiysjFk38GKLET+AiB3rIaiBluEf0EraKnIp4Wm4QbmTY1a3U295prcOsGZujbOh3
         VslQ==
X-Gm-Message-State: ACrzQf2JIlbWW9FRPWRjIzc7RouUCy0fzR4kO2qXgyg5fAiA0DMFYFD4
	gAHLPODxGeAIFPAumeTELT4=
X-Google-Smtp-Source: AMsMyM6uzBRZ15WrJyfwa20zTjvFCI+XZgR3GbQDEivislkxCI8uEecVmp+gG/ojWfaydxhxOTL3Xw==
X-Received: by 2002:a63:8b42:0:b0:43c:ab46:7963 with SMTP id j63-20020a638b42000000b0043cab467963mr3360140pge.385.1664149434662;
        Sun, 25 Sep 2022 16:43:54 -0700 (PDT)
Received: from localhost.localdomain ([211.226.85.205])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b00178650510f9sm9814238plg.160.2022.09.25.16.43.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Sep 2022 16:43:54 -0700 (PDT)
From: Levi Yun <ppbuk5246@gmail.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Levi Yun <ppbuk5246@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] damon/sysfs: Fix possible memleak on damon_sysfs_add_target.
Date: Mon, 26 Sep 2022 08:43:27 +0900
Message-Id: <20220925234327.26345-1-ppbuk5246@gmail.com>
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

By calling daemon_add_target as soon as allocating new target, Fix this
possible memory leak.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Fixes:74bd8b7d2f8e7
Cc: <stable@vger.kernel.org>
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

