Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C2239567
	for <damon@lists.linux.dev>; Fri, 29 May 2026 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024528; cv=none; b=ix2K/CVRh6msGVPggpGVjgQoaw62DCcyUCO3UUpD99aqwP3/rE1wkiedRzQGdPwDaxRgiV/aEApnhoePjqDZVzbVt/v8Nm18QQrZBGnjzSOJ5qz5oEODHq2Bx8akyxxM9CGmg4xdCjFFAAh+8j7ZsO7WRl106bAvA4vX+lCwl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024528; c=relaxed/simple;
	bh=7C+kEFqILvut36qbuX/W3KJQNvUqBgHFoEpdrFMIn9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4rOLOd6pioeBUbKOJt60PO8UpX+0DFx92OoGX9fB0TEz9AeRrfRA+ZrFX85No/NYTb03Lo8RYyIWxCXQLjwDI66+gJo2lNZgRMw6h6ha7k7asiD06YCZUoWA3qHD7qrDjIhTAG1A74KzxuXtPOTyxAlXYwKACMmvPNpUaiIHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8sfLtal; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8sfLtal"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914b5f85129so624706885a.3
        for <damon@lists.linux.dev>; Thu, 28 May 2026 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780024527; x=1780629327; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7VQKUmle+s6m6lEZBFzOZjbbNDmhgzc3MV2Qh5axEj8=;
        b=X8sfLtalcpUjNujrfI9R/dXCOWbebhKPRRR8e26YLc2gRDr1sYvOO1c4ntdWJ5TKmT
         w0//OJfBDW/ViVkz0s31nSERu1MwPnnPxno+QyofGaB+VXpYMCVJAH1YzgjGd/+VbyfH
         3D/BnRWcEKUrxM8HwDyVrmDoqdXBYDqhOt8kkoOKSBqS8y30umAjJV9zO2jG8L+uVReC
         zgNnFpiJF8akRJO6HCgU7Lxv0iuhUH3YZdDW4SrbqxcVryFAmXZrcvADScdzutSENKwr
         FHXpWyA2ez2QZdD0sss4IGZbuN3P4+KerTvyrN//6Z7zwRs9Z8d3MCn4PO2Xts/6LreB
         3ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024527; x=1780629327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VQKUmle+s6m6lEZBFzOZjbbNDmhgzc3MV2Qh5axEj8=;
        b=OkjfnsrCsjGhEb4fDQuQ6DyW/uVuYXDvzVB+RCIpMl7h0dnCGb7c0CKvrFCtTqFruR
         2j7jlvv+kcaFmsTEyEQW3baA6ib8JSIhRU777bvg/tune3bRmFuT1beTG/A64Bj8aNcx
         mH23JljglD9dwiDEZb5RHUEv1ooEjZKMR0WYxebaEo3Q5eMn5poFGRzDkeAMdPzGjuZV
         jdAfDajvGuetgsdvsSPaxPDwiXjHmAJTUtFjPAWw0EVaI3jKmPyWijyLEXKYpn04hh8E
         Xau2PzLeVsGhbbidESvR2nxBgeutYKIRqcdhkUywjyWMCQ8WaFCV4o4QqgXf0vBVWQ7B
         q3Jw==
X-Gm-Message-State: AOJu0YwOFoFAFwZ3MXxO49/NpVSQOrDdGgUq+D8K+7kUGBzh/tAKrGfS
	ASTDiMHpptEpFsGDUaRqqhHSMXOyv8M1XCkVaYVREKtncT00Op5vfDoi
X-Gm-Gg: Acq92OHIDIn2pJuRECyRDvBOVZUQqvmYnlCIYpc0IW/SwKu6h4E24o0QjU0xXYZ0Rle
	VFwnO36X2FLUU8cmU7EQ50Ec6UjFp0Gz85zL5xU3zisotYkMaQPL3cBgK8oUED/fdglousHAYsv
	3ABgpdOUHdkE4ebJhtsYaxHJFejpY3bicOJtOcc/5oWxWjF0dzlZcyvzCQypFrCiopf9KI5eWTr
	llZf0HEby0OZ1WbOrJwBjT6tD4/H+H6BbcmldMTatBLdnGv0e8l6ivtRTmxCmFrvh+qBjDOhxQ1
	nX0V/NnfGp30LRCFLKBPsWs+146HG8CRAUiTiEAm7nkhuCWkCN9+z4Fb2EqafNospL7r2yGMc/7
	UyGxb3PRxCgPXptpbt37UbV885S/ziUpuOovaDp7WrP0pQ5LOHoMTlW7Ei28CYGOH629gYBSk7z
	P9brBK6hqjgrxz53BoDpPL5cYm7XiuBSMkwbbRC1dbUNazgIPM0Lo=
X-Received: by 2002:a05:620a:319f:b0:914:c0e8:22e with SMTP id af79cd13be357-9152ff5f1aamr139261485a.58.1780024526592;
        Thu, 28 May 2026 20:15:26 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532626961sm37414885a.32.2026.05.28.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:15:26 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] mm/damon/stat: roll back context on damon_call() failure
Date: Thu, 28 May 2026 23:15:19 -0400
Message-ID: <20260529031519.1617000-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stat_start() allocates and starts damon_stat_context before
registering the repeated damon_call() callback.  If damon_call() fails,
the function currently returns the error while leaving the context
allocated and stored in the global pointer.

The retry-time cleanup added for this path only runs if users try to
enable DAMON_STAT again.  If no retry happens, the failed start leaves
the context allocated indefinitely.

Roll back the failed start by stopping the kdamond before destroying
the context and clearing the global pointer.  damon_stop() waits for a
live kdamond via kthread_stop_put(); if the worker has already completed
teardown, there is no kdamond left to wait on and the context can be
destroyed.

Fixes: 405f61996d9d ("mm/damon/stat: use damon_call() repeat mode instead of damon_callback")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 mm/damon/stat.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 3951b762cbdd..7f222b5b7193 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -266,7 +266,14 @@ static int damon_stat_start(void)
 
 	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
-	return damon_call(damon_stat_context, &call_control);
+	err = damon_call(damon_stat_context, &call_control);
+	if (err) {
+		damon_stop(&damon_stat_context, 1);
+		damon_destroy_ctx(damon_stat_context);
+		damon_stat_context = NULL;
+		return err;
+	}
+	return 0;
 }
 
 static void damon_stat_stop(void)
-- 
2.43.0

