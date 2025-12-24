Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B330AACB
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569464; cv=none; b=lWutIcdEmHS8FaLmxUGQP9b81IF8xoFo7kWyeQXjqWWrovOhipEFL7xjq7Kmt9Q73oDP/3caS9zdvCMnx/CnIKfSkWIJKSOx0B3tDYPtetwZNKWf19tR8+KqZE2lKNP9v1dHqUN4q1jezinTkskfLCrr1lk/ZxjGi8oaamsNaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569464; c=relaxed/simple;
	bh=eSa+LnEcSNmBxjkewpfTdUhYGlkKthsp7ctwSLameTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARjHQbcuN6qL8TtLy7xIIemJrzcahrD/0mdtIM3H5/HHqyNs+BzDp7TGred6ouekCfzpcF6bo9qbY5HSixLWkkFXDq/3sApF1lHg7/5wNt1z5J2cT8gZ/5KGvDENmmYJ5/lghBlpW9Hy27Ii0/TLLaCCcqtJHxmj3GhEkg+dtTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5C6FBW2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5C6FBW2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34aa62f9e74so7523687a91.1
        for <damon@lists.linux.dev>; Wed, 24 Dec 2025 01:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766569462; x=1767174262; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XwW3zGmoJido1NdKRDHBQzXTcMBYtO3Qi5hrufVJ6PM=;
        b=X5C6FBW2cW+zZsz7OSyL+S++acyov+VJr15au5ewhcTk/n5kG4Znb336XYKv9ZidZ7
         LuuSi2MrddlMD0Xn3oQ0z41FfRYxIl4NsGB5sMESg/kP6HvFMkuBHFR7L/YfYpznL/So
         nrUHoy9N1Dd4ptlqqBboTTvoup5ncHzr0g08TimcrQo914A0t62pxOb3KxJRuOuxjw4A
         phQAMfgTyiLtksdmN+SLyLtDZlpoX/qK7cKWyf4Zhacph+h3A5feWNwPJgcBwGhJ4Sod
         oJQVKnkaaf9HCj71kyjS5HY7AtxDQ69/wS9UMdF4scJn30OY68+Gpf/0LLCUlEKR4DmC
         payQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766569462; x=1767174262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwW3zGmoJido1NdKRDHBQzXTcMBYtO3Qi5hrufVJ6PM=;
        b=HrwUvGJKVkMHFIxl7qfqEzpvx8u4pV7BMpKiWA+sQkQxoj3i0ewrELTRV+5cXakiMZ
         5T7uaS1VdU3ETyB+bih2wW83MUq544UkN1C5UAjKa1Zx6kGGBN5WGNb8geh7O1IyAr6v
         h7Eh2EHDJD8f5boU7cPAxqE1bLvP13x8jS5fiSpsEcpDJTCQ/GMKwqTwRvuGfzlGNhMT
         xG6gRjENb2HQCg2Bv88rVDl5u9amlGz1a9ZAnJsfi9H4JUn6h+7ZRWILo24va3u1TV9h
         MZFy1tRiyu+F5ws9RFcyO4yNTjuXbvNOGq/WTBCsz7K2hKBagpoHSo2osAR01YJhnNfj
         zh8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXix9nMG5S+mT3W+mubHcPPpzKUG0tP4UWy6LFGMHSbzuT0YTWPKoAIrG3qdBHGvU2oWLFOHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDssprHOyz5kDUxPfYv5teq1cFzj+71z8VDjVFBB1oiQ+K4vYo
	QZ/a2eMIMH21lYN507nrrsuERQiyDGfY4+M/N2OFtFnRGN0M/qIkDGKm5rRDXiZL
X-Gm-Gg: AY/fxX7hvlPD6m5hsHZNDx8GznMPYXSLR2rQnDIPQrIMy5f+BcTPjxnkk0afxNHlUiC
	iroGOBmgtgNsZSAgJ2U4+pLvmA+Ku/peh9GvUcTdcn4EaZY8Ci/0m+T+UlhnKXtt2smQjoRjvD5
	s/5GDtWC+A3joU4xahvj+xt3UegkVSb2RHpRJMGOTa0hCMJz9cYKlUM1Ry97Z/ssKOS6Zs7YVcz
	FWpWOgFOUiAS6iKKQrEY5ZWP0TNzTCZZbXUrNx60eUbJStcxJQg0hiCecwgc1kjipAi3Xy5Epex
	62X0chQ6tKBVZKqHT5KHbg2/2nQiHxSsFP9GaKm1YND6CcFf+xZ74awrF1WnoHGKV1Ztda8Jrnr
	nozYhL9HAGrMSEXr/aHyCK1wTneFJjFYnvqw+0zujkyYlMrq6ZQfuIVGb8fl6YKQFuULvcshamM
	qi2FXb46dkq+sdCM0NL+UJoKM=
X-Google-Smtp-Source: AGHT+IHN3ECYoL38/RYPhmxeue2NFAbQYQ2jKvyiV63B5EXhu7w16jAwi+WKbmwwD5y99B9uIOUvaA==
X-Received: by 2002:a17:90a:d406:b0:32d:a0f7:fa19 with SMTP id 98e67ed59e1d1-34e921b05d9mr18120936a91.17.1766569461679;
        Wed, 24 Dec 2025 01:44:21 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34e76de1e41sm8869208a91.2.2025.12.24.01.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:44:21 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	rgbi3307@nate.com
Subject: [PATCH] mm/damon/sysfs: preventing duplicated list_add_tail() at the damon_call()
Date: Wed, 24 Dec 2025 18:43:58 +0900
Message-ID: <20251224094401.20384-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 cd /sys/kernel/mm/damon/admin
 echo "off" > kdamonds/0/state

 echo "commit" > kdamonds/0/state
 echo "commit" > kdamonds/0/state

If you repeat "commit" twice with the kdamonds/0/state set to "off"
with the above command, list_add corruption error occurs as follows:

4-page vmalloc region starting at 0xffffffc600a38000 allocated at
kernel_clone+0x44/0x41e
------------[ cut here ]------------
list_add corruption. prev->next should be next (ffffffd6c7c5a6a8),
         but was ffffffc600a3bcc8. (prev=ffffffc600a3bcc8).
WARNING: lib/list_debug.c:32 at __list_add_valid_or_report+
0xd8/0xe2, CPU#0: bash/466
Modules linked in: dwmac_starfive stmmac_platform stmmac pcs_xpcs phylink
CPU: 0 UID: 0 PID: 466 Comm: bash Tainted: G W 6.19.0-rc2+ #1 PREEMPTLAZY
Tainted: [W]=WARN
Hardware name: StarFive VisionFive 2 v1.3B (DT)
 epc : __list_add_valid_or_report+0xd8/0xe2
 ra : __list_add_valid_or_report+0xd8/0xe2
 epc : ffffffff80540bce ra : ffffffff80540bce sp : ffffffc600a3bc00
 gp : ffffffff81caec40 tp : ffffffd6c036f080 t0 : 0000000000000000
 t1 : 0000000000006000 t2 : 0000000000000002 s0 : ffffffc600a3bc30
 s1 : ffffffc600a3bcc8 a0 : ffffffd6fbf49a40 a1 : ffffffd6c036f080
 a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
 a5 : 0000000000000000 a6 : 0000000020000000 a7 : 0000000000000001
 s2 : ffffffd6c7c5a6a8 s3 : ffffffc600a3bcc8 s4 : ffffffc600a3bcc8
 s5 : ffffffd6c7c5a6b8 s6 : ffffffd6c7c5a6a8 s7 : 0000003ff3f32794
 s8 : 0000002ab38c9118 s9 : 0000000000000065 s10: 0000003f823a5cb8
 s11: 0000003f823264e8 t3 : 0000000000000001 t4 : 0000000000000000
 t5 : 00000000fa83b2da t6 : 000000000051df90
status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff80540bce>] __list_add_valid_or_report+0xd8/0xe2
[<ffffffff80255c86>] damon_call+0x52/0xe8
[<ffffffff8025c9a8>] damon_sysfs_damon_call+0x60/0x8a
[<ffffffff8025daf4>] state_store+0xfc/0x294
[<ffffffff80dbf1fa>] kobj_attr_store+0xe/0x1a
[<ffffffff802f070c>] sysfs_kf_write+0x42/0x56
[<ffffffff802eef4e>] kernfs_fop_write_iter+0xf4/0x178
[<ffffffff8026545c>] vfs_write+0x1b6/0x3b2
[<ffffffff80265782>] ksys_write+0x52/0xbc
[<ffffffff80265800>] __riscv_sys_write+0x14/0x1c
[<ffffffff80ddf124>] do_trap_ecall_u+0x19c/0x26e
[<ffffffff80deaa38>] handle_exception+0x150/0x15c
---[ end trace 0000000000000000 ]---
-bash: echo: write error: Invalid argument

The cause of the above error is that list_add_tail() is executed
repeatedly while executing damon_call(ctx, control)
in damon_sysfs_damon_call().  The execution flow is summarized below:

damon_sysfs_damon_call()
        --> damon_call(ctx, control)
                list_add_tail(control, ctx->call_contols);
                        --> /* list_add corruption error */
                if (!damon_is_running)
                        return -EINVAL;

If you execute damon_call() when damon_sysfs_kdamond_running() is true,
you can prevent the error of duplicate execution of list_add_tail().

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e2bd2d7becdd..835703c65c12 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1686,7 +1686,7 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
 	struct damon_call_control call_control = {};
 	int err;

-	if (!kdamond->damon_ctx)
+	if (!damon_sysfs_kdamond_running(kdamond))
 		return -EINVAL;
 	call_control.fn = fn;
 	call_control.data = kdamond;
--
2.43.0

