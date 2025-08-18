Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51983314D5
	for <damon@lists.linux.dev>; Mon, 18 Aug 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542294; cv=none; b=d9q4rXwMlv2L0uCrQYm85Y5KNiumsURvzPI/M5YWiT2LvbVoV59Y/fNvqeGOyfROMUd1lYEbht3ICO8lqsy2qbK+rYDeWgqT79XVWeKQEN8cZHfN9Gh+J745xMv4Rnjo/WUstsr3fn3HCN9wV/BKOayDjJ/0IeoAzCW3CbfTwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542294; c=relaxed/simple;
	bh=XhVnX9FeI9+jd/3N91/c1ozpUunDIScfUrNUPoLjm2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMLeUxbA70xi84UUvSPjRJGtEE6MqJGvrYxVlX8derBQWnsIMwTUoflJxTm0fIZUBZrGoSpu62BJmTtJIHWKw6NU64okeaYCbjtYpJHT2+zeStT7h7k5ZRw/ZajZespu3Z0t/cz/sHnQP1pnbQ/tadCtion4i8IuAT2kloP28F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpJ+Id6G; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpJ+Id6G"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e7af160f1so384708b3a.1
        for <damon@lists.linux.dev>; Mon, 18 Aug 2025 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755542292; x=1756147092; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxwqBJkCYrqlcIrilSVqc8pbG8LIOmyCmMOU0LIr8Ms=;
        b=lpJ+Id6GD4Og9engoADPQ2S8SSNWHthdQNiysDENO3x6nlGy2vef+uQtEpnd1uCe/P
         QM/rzdyvdQxLzFxghw57P4IQrUxn4Ihl8MoPiPCv6/zjjqKrHoqRzK8trzRa+cPpKzFM
         PAmpvQcPi+NTE/cCMValND6woL7U80QxcyOLBPWfHTz3PYoDTurDvgN0zp7AC+PZPjfA
         7TnpxydpVfyKFvPOaJYyrOXKmSG0pUKv50HS3c4hOn3fMCA3mPWtcx5Crman4oHF1Wm3
         jgqPRygwkq1jk+qs4GL4tzVYvKPiy7WLDCxgZEf6VeF6FmUBl0gnU0kwztCazpFrjn26
         xuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755542292; x=1756147092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxwqBJkCYrqlcIrilSVqc8pbG8LIOmyCmMOU0LIr8Ms=;
        b=vAbTmSfeiAT2seFkycwStV9mXZrStRf6cPRZyveNe2da3QRFL6bBLo3AYcCs8o84bZ
         tFYWh5Nb7exhIMZH9mdi2LkEv/Awb2xXBDORRAHdR+Fdk1TBFSIqiCMnnxmm7Ds/IYiP
         MaRe+0v4a/VsP47eQhfKWUr60L8eqc7vHiqzMPs4JExfH+ZEsX+PfN4NzgvG6TgcCbzL
         JpWstybTUWBUOzlQlyADcoTVTva0tpXovX1vngO5McU2SwEh7iALzCthOym1DMusvOWD
         pg+9e/LSYtuiZWF2Qyu2whPAKzcCHziye8HQKCxhQM5g/Rfz7aZa/f826u+PWXicZv2m
         5GZg==
X-Gm-Message-State: AOJu0YyF6WSn/oPik1/Sl802IDcV/lPLL8OypAp00yOJOYU4CCiAT3Lb
	jhmVfHoPfBbzYBvheqHf32R8gKRYxKplXuZEBCXK7BQ64F12joodFocP+y700oUV
X-Gm-Gg: ASbGncuR0OLfcFCcELXqI1TCXWXnJ0viGU63ClL3xJ3mFUYqchTx4szaa5mT67RfNWD
	JnZ+4nXHuT1GPmRM08s6oUSvmOcPtkre5ybgZf2k3CrClwCZSzw+0RVWpZFiiytCYcoCCRoOFM8
	8RcwF8e1YoDunkzjO7er3RSs0FyS26ZGuJ18x6omwtmiK61SZly+BlOaHCJrsvgS5ZxTp1wlvpY
	p88k55ZBBRdaMUlnpDkk3x0HQgwff2xjh1liHBlUnW6Mor5e++yc1PMMS1XvydN0EVUu0em5XMX
	u7OjMINL8kQ3m9p0HLa3itM9v51WuPQEoCC3FQwGz6T4McLepJGF0g4Pg9OTxHXUsm8rpdKKZgc
	Cu0mx5vYTDLUsKO8M
X-Google-Smtp-Source: AGHT+IF21jrPOmeVtvFP4xBgTBNfDa+e87BFfHyEAdLZp40Ly+ufee667RTgqihPyTvRbODt7k8r2A==
X-Received: by 2002:a05:6a00:2288:b0:76b:ef8f:c292 with SMTP id d2e1a72fcca58-76e7ee01fe8mr369879b3a.16.1755542291913;
        Mon, 18 Aug 2025 11:38:11 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f76b5sm269201b3a.59.2025.08.18.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:38:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH] mm/damon/core: set initial quota->charged_from to INITIAL_JIFFIES
Date: Tue, 19 Aug 2025 03:38:03 +0900
Message-ID: <20250818183803.1450539-1-ekffu200098@gmail.com>
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

In 32bit system, if quota->charged_from is initialized to 0 as it now,
it will not adjust event if reset_interval_ms passes for the first 5
minutes.

So change initialize value of quota->charged_from to INITIAL_JIFFIES.
This soultion has already been applied in commit 7d70e15480c0 ("writeback:
add missing INITIAL_JIFFIES init in global_update_bandwidth()") or else.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
I think it would be good to add selftest of below senario. 

1. Set DAMON with quota.
2. Wait and check esz is updated well.
3. If esz is not updated after quite long time, set test to fail.

but I'm not sure that selftest can support environment handling; jiffies
with INITIAL_JIFFIES or near there.

If there is another method that i don't know. Could you please let me
know? Or any better idea?

---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cb41fddca78c..90317a3bcf78 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -366,7 +366,7 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 	quota->total_charged_sz = 0;
 	quota->total_charged_ns = 0;
 	quota->charged_sz = 0;
-	quota->charged_from = 0;
+	quota->charged_from = INITIAL_JIFFIES;
 	quota->charge_target_from = NULL;
 	quota->charge_addr_from = 0;
 	quota->esz_bp = 0;
-- 
2.43.0

