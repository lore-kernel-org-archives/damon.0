Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1E26B2C8
	for <damon@lists.linux.dev>; Thu, 21 Aug 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794107; cv=none; b=h7uXNE5pgLqiFJuaXPpIo1d+BAI03OEgaihOc0iA+e2CeTfvtp0ycsrUi2lApZQZwqMfUFdzXrP7FjuqLvTa8ZRletC6rYzfh542Wv+1SIY0gUJBfvdgTce/7aVLv2XoUohpCTJhBpy/f5oKZTiCGFHm5T/EYXh8WyT28uewC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794107; c=relaxed/simple;
	bh=ER20uN3ophbDodXA0V2P/El1StgLE1H9mf8h2Z2UIMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUywd03HiOHdxR0+BppJ79GW/r2e6uo3foe+AgyORoun+7EmMBNoWFL0EcfIhbZWkgsMPF+SK4GkqrTEGLhJnwx1E4Ow7f/TdSgGQQ/hD5cHiHERXo+7ZkcufYor+weeb4DLjsuO2TBtf7nclowOukhXMBynj8trGey84RqOCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaVitSLu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaVitSLu"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-245f19aab6aso8625395ad.0
        for <damon@lists.linux.dev>; Thu, 21 Aug 2025 09:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755794105; x=1756398905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flb2E4kjGcDlTRu530Vt8i5Q+Cs64zRzjln/3+D2F4k=;
        b=DaVitSLu7ne4iBvNKPr4RbHHES8ebxOQjuTqRUr+7evVry0BQnEPu/fj/6Dg9U9Pen
         6tw4RepuQSIYs3oe3bsavQjsCLxBVTn7UMwJAmj0pp5Y06rTJGGhnWATmfYKs8emrfdo
         etFR0luiSxxnPMmz4wII3zkf1SQ3vuQdHppBVs2KCLbAjeyPQzlvPtUKGnSoTSxgkLco
         Rn2UR7Twjd1LntVaros4VbbZ3bf/8Q4VM9nZ9nUDcBFiVOcfllFT4SG4Aqjzzh6bGQFn
         0jVyFhfLlsFefhBQNlBAAx/6VnsG5J4oAlFh9WVEVG8vrj0gV6zQflLVXvCEbdrLi50N
         m5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794105; x=1756398905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flb2E4kjGcDlTRu530Vt8i5Q+Cs64zRzjln/3+D2F4k=;
        b=h1XazyQebx6knDmmg5aNfUED5qxZXZko5kBopyOez8VOFGoPRqS/n6ZL6QbV0PbR2+
         D14FmP8jxtFKV79JWe2qGZlEk1uehFh/uYOCi+0U7RSdWvb5NjUxCFBLpjgMsy66LTjc
         ynXajpoIWf4peMZUa/KPhaoJX7TdQTmDr1/OXQmnzacRB2rlco8ZO+hl/kq+S3ySkaaQ
         +FxKO8NTrNuyzr/V22kKy7AistWRUlkChmOTWErdeHpxWFaNLd37JUv7EPJhqWTUBtIr
         UaSedj0aiKhpU5nSCdEvR5LXwd+2XzbTJdy6NmWLIJcoH+CZjkw8kyXlPYXQ9UppbTYD
         Apug==
X-Gm-Message-State: AOJu0Yw4Q9ZN3d+Dfjx2aPiOd+3uE4kt21i4yt4yI4X7K1mwyl8vttVp
	plLHXu9symwU9cy6rhOcp0XK0vMI+vwoMUdT7dXcaHYw9Jpa1wZnvOLEojWHcNrz
X-Gm-Gg: ASbGncugfO/T/75D9fQ0Sy223iX0Nl3QpPIrel8OZlT3+0C7+1ZBDRbEdk2cVbyTuTN
	6OPcaVf3cyKKh+QsOrULpOvWen7oHG1YAfrAN1AVuoP6Qpiy0mVQyh0RdNnVckITj7wK5n6Xcez
	ZiCajYIbbmm2b76QcF9YbpuayT+2ovgd2F1Ks646VG755xBdXMpRhEAbGl3TXwsXd32/uRnmDVw
	Ef1na2VEMGhoePyHtxNGZKK3b3Oore5zhf4vJzinkTHWjNb3z46MOttKIoKC6rf21NvrsaTBCrm
	fLjCfxk5Txfnl26c5TW2E5NKT0HHfv/ZGqzPwHhYfZ2lLJ6ptS/QGvQTG751M7YcGvq0+QblqLC
	iy2nY6/jXlIOvPFrF
X-Google-Smtp-Source: AGHT+IEoK20LGwps1UI3qxtBzFuC2UZywh32woD/WzTb07rAX67EwMDZ7TmGCqkdLFk9tfZL3IepkA==
X-Received: by 2002:a17:903:120e:b0:246:1c6a:7026 with SMTP id d9443c01a7336-2461c6a7131mr22258645ad.40.1755794104962;
        Thu, 21 Aug 2025 09:35:04 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d5242dasm8704422b3a.77.2025.08.21.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:35:04 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Fri, 22 Aug 2025 01:33:46 +0900
Message-ID: <20250821163346.1690784-1-ekffu200098@gmail.com>
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

When quota->charged_from is initialized to 0, time_after_eq() can incorrectly
return FALSE even after reset_interval has elapsed. This occurs when 
(jiffies - reset_interval) produces a value with MSB=1, which is interpreted
as negative in signed arithmetic.

This issue primarily affects 32-bit systems because:
On 64-bit systems: MSB=1 values occur after ~292 million years from boot
(assuming HZ=1000), almost impossible.

On 32-bit systems: MSB=1 values occur during the first 5 minutes after boot,
and the second half of every jiffies wraparound cycle, starting from day 25
(assuming HZ=1000)

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

