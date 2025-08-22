Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2621E0BE
	for <damon@lists.linux.dev>; Fri, 22 Aug 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831103; cv=none; b=JANJRgqYKBSvl594VW2JgdazU7lqWo/V6ioKhJuFbRNPRPmGriPxUjbMDlPQtBF1wEwUgUVf+Lo+xeiy9DD25nFvqtUBVLgYkzI4HfXS+PORCKMcrdIoUJN2CZIgTPWvjAGsFFoaKbqt8j/gAmFzFt8rPWhvOJ+CzXtGGgL1rho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831103; c=relaxed/simple;
	bh=rmFbI1Ko1ZvQYMn0Edy34iPghIS2cFWVRm2XsY2P8bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW044V20Uv6CW+xrhLdmd1K838kpkit2HPUfEzpm06UzD1el97E9RBlrosaxXFiAA7blJ49ZA/OrHpT8aJa30qdmadcsEmO5XPgJSgE7cIh5bzbthYhCpnlcNdXhIwJ9HyCrUvJRz5+n7rrQQWzDhVqLY1eEJxn+dk4Mno/QQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/IyYwh/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/IyYwh/"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49bc4e76b9so418781a12.2
        for <damon@lists.linux.dev>; Thu, 21 Aug 2025 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755831101; x=1756435901; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y1fBCXfKiFD4O4AUiF2Q1s/sYVAdN3oCGBndILrhJI=;
        b=B/IyYwh/ckfujD+hfAuJR71YdQmYUo0cWjxzKYqKq058+fdvrL9H4doRTOPsLLNtCQ
         k2L44ioIQE61sa5//+Ms09WK/DoC7vCxsS7n4tuxaqbIjlIsbLlegMK6JJY4UcHM4dqo
         jv5dKo1yq1tucaEtTUQbyf3CRf9dyYRjBLfAsBgSy74xLRW8n59ojYdcysJoVVdUPcsQ
         vDTFt4LId7greZcWiKDJkDZTGEzXNCuBOtz5K5QwbqmzG52em9jC0Lcql8BGNm1SNAlG
         DH2K5n1dhL29Z+HEpmblyjwMyYPqvJFXAmqBWpW2yOsRkAz6o88y870CfsbtvbfW6Q/l
         VVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755831101; x=1756435901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y1fBCXfKiFD4O4AUiF2Q1s/sYVAdN3oCGBndILrhJI=;
        b=WLFOMsu6yUx/wmWsZvgdnhVEfutjiuaTovnT2UJoRIjRI+wPZdRAz3wmj7TtP4h61u
         O9AxkBFGSqZn+mT3PCoLPDClsbff7I15VhJnetg0hv1Qo2GW4weMHjHimvV3QsPuMIAv
         bj2hfcSox8QxrF5lMxa5unt0XU9UBYDV/B/gjmSF00hB1nAyQTWULatrqZcErbbMXDa8
         C26FEnSx/WM6ywYEFz3qu8UuD2NH05JbWJDgwTUr3RM4nCDI4osNJIrGOUsA5zTbL0V7
         CJmXQIVDmnJ0OoCWM5J0zFhh6+i2wPj74FsSWdin/fLrOF7i/7nDIpjsu3iE5xFZxg4y
         cqIQ==
X-Gm-Message-State: AOJu0YzxMi/zSYTTJcoLWZ2Zi+gfbalVGNcV+VYk3kRAHyKKdcnCvyHQ
	FOci2DyDDo9wvxAxYCEgWu92+QV6i4WobrTssJeFPF+jJbKFREU19O9U
X-Gm-Gg: ASbGncv/R2B9lf+0m9JviRfrvA0gI2hiAR96I2uJBF7zIhjIFXal+HHFg974ALDFqW4
	Jzzt7xdSk2I29rxmPI0MPefuUzYV2jFlOXTrkTmN9SV7kQXdht/KHDygRHoVYwDTRbmmCBOESY7
	2X73qY8k4gtuH7KvG8lIKhtO7gyn1sv2RBdCe8acttKBhiTEpQYTHnbyYOQeVT/AgvkxTQpxFUw
	L5Lq7PdGRk+ZaApfrT1TpF5aQMp8uCMt1wXZCPzXecsYcf51aYQSx7e0nkQS6itqSU/erRwjY5s
	2s7ygHrVcaqtVtNlqUQttJcBPf5UC4mdMscodxIiKEa/SMjz7fWC7e0ar/YIeLKcMhkrjLr72DH
	u7hJnZVmVqveLRkN3
X-Google-Smtp-Source: AGHT+IG6EHV8ZRai6TgzlWPeLJW94eI6szB0VIDlvVy7DY/ryr2+cLBvv/1oIXijaDK6rW2eCMhxtw==
X-Received: by 2002:a17:903:1a2b:b0:242:9d61:2b60 with SMTP id d9443c01a7336-2462edac937mr23760035ad.6.1755831101073;
        Thu, 21 Aug 2025 19:51:41 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24614a8e166sm27790215ad.75.2025.08.21.19.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 19:51:40 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Fri, 22 Aug 2025 11:50:57 +0900
Message-ID: <20250822025057.1740854-1-ekffu200098@gmail.com>
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

And jiffies comparison help functions cast unsigned value to signed to
cover wraparound

 #define time_after_eq(a,b) \
  (typecheck(unsigned long, a) && \
  typecheck(unsigned long, b) && \
  ((long)((a) - (b)) >= 0))

When quota->charged_from is initialized to 0, time_after_eq() can 
incorrectly return FALSE even after reset_interval has elapsed.
This occurs when (jiffies - reset_interval) produces a value with MSB=1, 
which is interpreted as negative in signed arithmetic.

This issue primarily affects 32-bit systems because:
On 64-bit systems: MSB=1 values occur after ~292 million years from boot
(assuming HZ=1000), almost impossible.

On 32-bit systems: MSB=1 values occur during the first 5 minutes after 
boot, and the second half of every jiffies wraparound cycle, starting
from day 25 (assuming HZ=1000)

When above unexpected FALSE return from time_after_eq() occurs, the
charging window will not reset. The user impact depends on esz value
at that time.

If esz is 0, scheme ignores configured quotas and runs without any
limits.

If esz is not 0, scheme stops working once the quota is exhausted. It
remains until the charging window finally resets.

So, change quota->charged_from to jiffies at damos_adjust_quota() when
it is considered as the first charge window. By this change, we can avoid
unexpected FALSE return from time_after_eq()

Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes application speed control") # 5.16
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v3 [3]
- fix checkpatch script errors

Changes from v2 [2]
- remove unnecessary example about time_after_eq()
- remove description of unexpected reset of quota->charged_from
- clarify user impacts and when bug happens

Changes from v1 [1]
- not change current default value of quota->charged_from
- set quota->charged_from when it is consider first charge below
- add more description of jiffies and wraparound example to commit
  messages

[1] https://lore.kernel.org/damon/20250818183803.1450539-1-ekffu200098@gmail.com/
[2] https://lore.kernel.org/damon/20250819150123.1532458-1-ekffu200098@gmail.com/
[3] https://lore.kernel.org/damon/20250821163346.1690784-1-ekffu200098@gmail.com/
---
I checked patch by checkpatch.pl script, just leave result for reference.

./scripts/checkpatch.pl ../patch/250822/v4-0001-mm-damon-core-set-quota-charged_from-to-jiffies-at-f.patch
total: 0 errors, 0 warnings, 10 lines checked

../patch/250822/v4-0001-mm-damon-core-set-quota-charged_from-to-jiffies-at-f.patch has no obvious style 
problems and is ready for submission.
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

