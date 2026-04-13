Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DE3101A7
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106372; cv=none; b=qxaRUP/Cy4lX3gsthei2HDR0u5xu0qsq+MNhEyKK/fqk3vQox7g+sLeIfsbjmu7awwtSBjvuf5sJarv3Mm9eElqzVU1I8b3tXGbRJX9uar035fotylhISP5yEGpn7k8W7TWJNukW2TyaMQKYNunFfKq1IGYFbykIXZLe0a9eXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106372; c=relaxed/simple;
	bh=+5yfTtAweKZ7MmDppORX7QwHvqoPEJcCkfWNSkP1BhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGF53A8zm2MuYV6nklfmCDYy8x8w/83hRg+zRV8MUtSa/N78tlEaijuAILokLbary+AOFxblyHfeVAS0RgyyKB30FtsbveWkT3I04mSQ14dHgXdf965u3vGycBuG+OdoxxhVc94ic/N3zpbwUsM/wyRz2GE+V9ZJ66KPRmtkiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efdhBQn6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efdhBQn6"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3107649a91.3
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106370; x=1776711170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irVM8cutLTY8eeIFuQG4pJxfVBZ0vjFm1lARbRd9vcM=;
        b=efdhBQn6BLy3n7ytqgv3aQrJO2wOQr/h4LNlbtW3M/cWIu7wWl0eW3M6Y10NB4zUGe
         2+Fweu1O1XtkWl5d1eDRwI3m8UBCqp6SYYqgy/y2DZ90AbWXebxjmiI0bRVUcBo6W7Pm
         M78TQaV1mGZKqmCzhnB7+/k8HX2Rn3Bz8kIVIVdpRVCYxARI5yzpiPJ8he50ghkKyvhB
         YrmeBRHZ1+KjoNyzxwC8lSBTQ9mN5co/GE5atUHV5CAW4IWjpSMW93BgzfqlPZN37IMb
         MR8onpd5De/Iz1QHTq4NO1CeFZozwUCSiedHlmTsNfLARDmztOktegpX2HdUv9V5rL5J
         /qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106370; x=1776711170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irVM8cutLTY8eeIFuQG4pJxfVBZ0vjFm1lARbRd9vcM=;
        b=CvrYN0Ln/9KZIJil/P5YJlcPnXuymQ/oT3CgAAe4EQxb6lPDtzh0o4igEIS4pQA5Qy
         I0qx3J1Y151mMaJojEZlzUrEmZ7eOxbxe7T0ta61WjCdUX04H5ZI6NSV91gidDkbFAjI
         BknoWDJVNoGFeirUKlOy4frj01U1ch/i2635t/V0yZvlzFgkYvfBAnb/6vaw5CDrln0f
         qtMleZzaA3wRxmPaVJE+o0Hhbyxb9jJPxTrI4dOVXoOEanwdxIAipcDh7E6aEH5w/8XN
         V9g6Rz+yswxafRkOvFR6XI99kvBEgtiDcBk1l87nh2p4vyPTGUCaSQyOE0pOJBIzXecm
         a75A==
X-Gm-Message-State: AOJu0Yw55mAf1lIM7lSP47InKuYniEXlsgfG7rJSYQYVNPBAzNIk8U5v
	/3n/smz3k4f+pqTyCfZardlE+4NPshcRwzh85uX3Xi2yHhqE4Ymti5/pvIp2uQ==
X-Gm-Gg: AeBDieugA906emsfdyzgBLPEBCIBvohGids/451887CD2ivR0GLuV84l0Kk/CWuEmm4
	oYIdfk4bU/G2tZmLiFtDojPd9j8XSNkrvK886tFGk4llXxeG0JusmHnCP2v1+Aqm7t7fKlKO4rS
	xW9XIbinNVJMN6J1hQYXEcWGKRw4MpAVNNVAPJhqDdRnxk4A3n7i7S9xKv30e/YC/ZLSObak6wM
	bSlxnrslWT1DMKPzM3mIlYdWcSDonjKoS87iV/HD+P/xYZg/IfA4+sC7KcCvLf6nj2kgjd9DIef
	qGTMQw1aZlBH4YH7X6dM6M48zNA1QVXTr8DJuedQQW/JuFwmNRCNFXKaZOyFfpgdqa8SjEmeevw
	HAelyEYd+H0Cn2zTZjDxWMykwCfUWLoALE+KmieRQF6qkrBqBJRRb60jSoA95EJo46jzDw5TXsJ
	MmPw6oiwokFDjrdx+2+PWOT67j8U6DfIcBAvCqE6dBmGQ2XhlcEds=
X-Received: by 2002:a17:90b:3fc5:b0:356:22ef:57ba with SMTP id 98e67ed59e1d1-35e42759e2amr12885903a91.7.1776106370251;
        Mon, 13 Apr 2026 11:52:50 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc2adae0dsm1225435a91.3.2026.04.13.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:52:49 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2 2/2] mm/damon/reclaim: reset thread status parameters upon kdamond termination
Date: Tue, 14 Apr 2026 02:52:49 +0800
Message-ID: <20260413185249.5921-3-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413185249.5921-1-aethernet65535@gmail.com>
References: <20260413185249.5921-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
========
When kdamond terminates unexpectedly, 'enabled' remains 'Y' and
'kdamond_pid' remains stale. This prevents user from restarting DAMON
because both writing 'Y' and 'N' to 'enabled' will fail.

"Unexpected termination" here means the kdamond exits without any user
request (e.g., not by writing 'N' to 'enabled').

User Impact
===========
Once kdamond terminates this way, it cannot be restarted via sysfs
because:

1. DAMON_RECLAIM is built into the kernel, so it cannot be unloaded and
   reloaded at runtime.
2. Writing 'N' to 'enabled' fails because kdamond no longer exists;
   Writing 'Y' does nothing, as 'enabled' is already Y.

As a result, the only way to restore DAMON functionality is a full
system reboot.

Solution
========
damon_commit_ctx() sets 'maybe_corrupted=true' at the beginning and only
sets it to false upon successful completion. When 'maybe_corrupted'
remains true, kdamond will terminate eventually.

Therefore:
1. In damon_reclaim_turn(): Add fallback logic to reset parameters when
   damon_stop() fails but kdamond is not running.
2. In damon_reclaim_apply_parameters(): Reset parameters when
   damon_commit_ctx() fails, as kdamond will terminate due to
   maybe_corrupted mechanism.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/reclaim.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..e3e148fd80f9 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -250,6 +250,10 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
+	if (err) {
+		enabled = false;
+		kdamond_pid = -1;
+	}
 out:
 	damon_destroy_ctx(param_ctx);
 	return err;
@@ -290,8 +294,13 @@ static int damon_reclaim_turn(bool on)
 
 	if (!on) {
 		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
+		if (err) {
+			if (!damon_is_running(ctx))
+				err = 0;
+			else
+				return err;
+		}
+		kdamond_pid = -1;
 		return err;
 	}
 
-- 
2.53.0

