Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C63E284696
	for <damon@lists.linux.dev>; Tue, 19 Aug 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615709; cv=none; b=mdnWeCgoaBe4qNa/eMjBhe55nTOBbWyWN2pj22d/hHJGTsMuTMdSGoytudk/EUNKhGePQHj4bljXlLBsGkE4uq0skgrDZfy7eTCsF0oywKId3CN1UYCB0vo3ckWilfGrmGIlzBBG5EEPQ+bA592N2CeiBUj6hM3a/3T4CNJs2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615709; c=relaxed/simple;
	bh=5ZFrovl/wgxzmU7ZQUlUDz3e2Ux59O7lFGlqcOh6oUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxUx0PQ6SuWxBCtyHlFtHu+TCzMLQ2/dkMByP1aukCmGyR9ZszJKzD8E5cXC+16npAImKKrZliaKgHkHPJzMiIQP7slzhecKnrRCLZeAtYOcXXvVo9R3SmXL/QILp8PxaOUOyO2sl9kkNOWgCGJNA/m72hIeFltKF4io3Cu6rFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+xw70bX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+xw70bX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445827be70so59753055ad.3
        for <damon@lists.linux.dev>; Tue, 19 Aug 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615707; x=1756220507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JmL8IAOx+wIVBxooeoV7bygpyZ9jyJFn3rB73ucFgc=;
        b=T+xw70bXUN3N2tepE9q136ZfVoi+bPOl647aPBqLS1wmvVfxNpq+e7TuS/O/2bZkys
         vN7009w5zY50tZZQR4csqiwwvHjTYrd5QIW3hN2CCJXYoGLoUfxXHo6P/xxk0ZJ42vqW
         Bes3b6jloqCJRjUE3eh2ilLHxiuo529NHgZx4BjTHR7Cgf04IH252vxMhb/HhrbI+BSw
         3ywAu74dBf/4IiaXS106XCq9x/EYMrMaeZmQF/eIR4v6WhvNshgiQVSo0Fgq24kVkm2b
         gAea+InxYYIlX/DzkSEbEbAeKBP1lNXZHmEIieLhNTUXzMBAkMcFfzU+7dIQvtSU5x+s
         h/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615707; x=1756220507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JmL8IAOx+wIVBxooeoV7bygpyZ9jyJFn3rB73ucFgc=;
        b=aifRpQQkny+bG7Zg0Z1l8lGD3qmswxhbRo9bWTB/ZgiGdBA4CZsqshEEYPho7mYyuP
         32r1eLIYfZidyadVAZwKRieyt4K3CiA42BLUuloRFiwnvgsnD6I+iBsgJsg040B0Ewdg
         GZ42QfMS5p44OmEMLKeSQ6pjf5B+D3KZWKYXSEC//B1bJp4Pwl3FMmfJL5fHxMSPKJc4
         lCVowUQYJbHwtZw47w7HZjfv81lya/Lze4b3Wi3tH260JbtVjMcnyaW2YpDHcoJXD8ew
         8oEvRt1droGmROmDaYQ/8h7fR3N88gdpCTi48kL+Am0LWQN0fDPj1dqsE2i5Z2t9eQQY
         c6Fw==
X-Gm-Message-State: AOJu0YweX2E0x5mw0uRWaKpsAHWO2cvAk8SaIKfcurxZL63ONv1/Lcu+
	x66VNVWeJJvXx8WkdIiGPECsR332yf8aSSkDq6AqRJ7Nh6ApJo1boUJV
X-Gm-Gg: ASbGncuM5sAI6yZPr9bw9jY9alI6U/Q9+shLEtdItdTSco0ieldX8Z32Nkktk/f3DdO
	4U7qhkLXKghRUnM243EiSVd/Wmkxz2S7TqZKhNBlLgGLHoHBV82/irExml7J3FOEEtvJkgPIVQb
	h/rIPLDznT3/gtkwgfzswjx3lX3aYF5ZaNhAkpGTvzDXphJG+7UM20sHgmbKF1JkD27GQ9jm6FY
	vDy0RwmkAVQgaQ/gFpZ0UmOT484Bizj1Bj+On3llVqZxD1eiuddHclYF7pyiO010snuut3iyJoW
	phxSAIwvTeZ98vtrKu75nvpq3bi38JVY7xCMSuPvUO5liIfVc26GdrA1uLajdgflHKCNeT0cK9+
	QA1CKUs25HaggRtMu
X-Google-Smtp-Source: AGHT+IEgp3hx06AeX/BhzhG30RJ+DaVX+u/IGmamucRk1iT/x14SlB07vl2cBagw0A+feOfOTWzbuw==
X-Received: by 2002:a17:903:98c:b0:242:9d61:2b60 with SMTP id d9443c01a7336-245e02a22edmr32444735ad.6.1755615706534;
        Tue, 19 Aug 2025 08:01:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d551493sm2724147b3a.112.2025.08.19.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:01:45 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Wed, 20 Aug 2025 00:01:23 +0900
Message-ID: <20250819150123.1532458-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
include/linux/jiffies.h

/*
 * Have the 32 bit jiffies value wrap 5 minutes after boot
 * so jiffies wrap bugs show up earlier.
 */
 #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

And they cast unsigned value to signed to cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >= 0))

In 64bit system, these might not be a problem because wrapround occurs
300 million years after the boot, assuming HZ value is 1000.

With same assuming, In 32bit system, wraparound occurs 5 minutues after
the initial boot and every 49 days after the first wraparound. And about
25 days after first wraparound, it continues quota charging window up to
next 25 days.

Example 1: initial boot
jiffies=0xFFFB6C20, charged_from+interval=0x000003E8
time_after_eq(jiffies, charged_from+interval)=(long)0xFFFB6838; In
signed values, it is considered negative so it is false.

Example 2: after about 25 days first wraparound
jiffies=0x800004E8, charged_from+interval=0x000003E8
time_after_eq(jiffies, charged_from+interval)=(long)0x80000100; In
signed values, it is considered negative so it is false

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is consider first charge window.

In theory; but almost impossible; quota->total_charged_sz and
qutoa->charged_from should be both zero even if it is not in first
charge window. But It will only delay one reset_interval, So it is not
big problem.

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]
- not change current default value of quota->charged_from
- set quota->charged_from when it is consider first charge below
- add more description of jiffies and wraparound example to commit
  messages

SeongJae, please re-check Fixes commit is valid. Thank you.

[1] https://lore.kernel.org/damon/20250818183803.1450539-1-ekffu200098@gmail.com/
---
 mm/damon/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cb41fddca78c..93bad6d0da5b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2130,6 +2130,10 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
 		return;
 
+	/* First charge window */
+	if (!quota->total_charged_sz && !quota->charged_from)
+		quota->charged_from = jiffies;
+
 	/* New charge window starts */
 	if (time_after_eq(jiffies, quota->charged_from +
 				msecs_to_jiffies(quota->reset_interval))) {
-- 
2.43.0

