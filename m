Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6938B157
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106369; cv=none; b=hvXYAcvrVUlI4LsMFOs1FGmiMaEurmOlAY7WquzKR4JITuZlSsBy8nm4pL3DF157DRU9E0uYvR7zDtB67If8wY9Ptikb5fxCHi1j7xlGfKxGEbTbmR8giU+PtJrgCiW+WB82rh+FbNOv7E5WReYvivrZAVS8euV9sWL3VD8jCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106369; c=relaxed/simple;
	bh=85yA/eQ7kN+1GiUCygjUKr4XnYUFz/BwlivZLhMefkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn2LyOjQMxWar6N9ye+te7E8s+KXL+6qYSH0OV1AVpu/xmM0mR/rnsALP8QhOdg9bzYWrfFVQwxkupVuy67JaGcj8sTHVa/6lTuvoIDE66FOfxiyowO8K+SEf1YGq59RRb5Zk3vZnm/MJLhtaG3X3O8xmsUwLREiJSil6N3CGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/SmrTLw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/SmrTLw"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76ffd06593so3258419a12.0
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106367; x=1776711167; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEitzkayqqpN7xkxJtZIQKvaOlaMuUzOnVvJxJq+UQo=;
        b=P/SmrTLw/vvHuJZ5V07sxTOD1r/wUueeX4XaI8REoUFNn0eTr4Azam5BngQVgKoQvv
         8Dbaov5KFv3Rir/mjcIVesTcMPN5RKzg9IDDTsImPValR6pwPZokgC/Bm4FkK2dVL95v
         Bv5IFhw11k6R3Ad0WC1c4BC19/IgQfGrKG9mMbeepG/Z/WSS4qii8/eaLlbKgwI4zeet
         kcLHZKaNAXk9oncX6FAqT8ObMurJFwOwTwFEwKUZ+ZUPkwQskrIve8m5bMm6F+e5HuZf
         H+abhMqusqjwyjgUQka5yi4RBpiU1QlXqOUu08b9u0O8ZjP0M1QmOYea+t/DE3stdKbY
         DddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106367; x=1776711167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEitzkayqqpN7xkxJtZIQKvaOlaMuUzOnVvJxJq+UQo=;
        b=E2Me1eydyvhvWAWGVxK/F2yAjLanRBZjMxMufyTbwUqvpYUvBkuhvtx4BKxHTtFjr6
         jJobCX9FavtkzBZY4muZUBRFckmFRfmjuPCtSkAjmldpr/LBhILZ4TfRuemuFekn4Ppw
         0D3+Val9SgkkQ5EUDGsGAiXTmemGKCsHjtnvnpYXqCGKLJiUeNxkSWspnQzJZdbg9aej
         EIGq68gvWoA6CzM2EtnrhBkgbkGIb3f4doYKBmiehdN161BLzD/O16ozZ8Rc7ONWrKTz
         TUQBQYxUK3evFHkYIOtlD1/tlMW6dYWwoZUVtNTyZK6KegZYczj86dAgWD1MdIw6CcHa
         FrZA==
X-Gm-Message-State: AOJu0Yzumrw3b5IFOWha2yhD9GWwEJnTpJcUJ9m6hvIaIBSJ2GrYIxCE
	qcbWkzF4OHLklpZic5cneFq79MHsuuzAgzeueM6VpKV/95XfXZXc68bK7ZlDpw==
X-Gm-Gg: AeBDies3r28l1kv9NwZRLAmt0C0S18a8+lod4VlB52C80RmiNxVo9CeJIKyQhaQyxH5
	IGV5IvEyd0/3bT+/Non2MlD6aou0ARBtQZVLCv+XAJdaWUjvYuIAFPreQhRlLd8KGIY+AXgxH15
	1NNTCrTDaRQohWCh2PY/+H/6oeccKCMKeUhf/3nTymnM+8z+71NuFVPvQGDO13bHLXNduEynhYN
	ftc63kyV4zfwDB10PvMd7Ubes2VCrZ54kio0zlkj+F3hdg7XbDAJjPd/TsJW6HTNf9fybXOJ7Tt
	EXLjcPzo0AudJurMGb7YslAw76rLOvR1YeYg2HcXPdKU2U8baA3NDT2bEA+o/kWP5vONTt/OZgl
	RAq4OAN1tZ5MtED8qu2g299MxXix/2+fveR8Q+W+ypa9Y4xrhrt2AEyQDdoiX7kkmb05C7KcEzv
	0giOQZSpydwMiL/aHkDqNDcKuVi9w8jBmNv7EaOJyKZ3co9T9YGmLRT0kfakLgnw==
X-Received: by 2002:a17:90b:3d48:b0:35d:93ff:284f with SMTP id 98e67ed59e1d1-35e4282bdabmr14803992a91.15.1776106367321;
        Mon, 13 Apr 2026 11:52:47 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc2adae0dsm1225435a91.3.2026.04.13.11.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:52:47 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2 1/2] mm/damon/lru_sort: reset thread status parameters upon kdamond termination
Date: Tue, 14 Apr 2026 02:52:48 +0800
Message-ID: <20260413185249.5921-2-aethernet65535@gmail.com>
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

1. DAMON_LRU_SORT is built into the kernel, so it cannot be unloaded and
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
1. In damon_lru_sort_turn(): Add fallback logic to reset
   parameters when damon_stop() fails but kdamond is not running.
2. In damon_lru_sort_apply_parameters(): Reset parameters
   when damon_commit_ctx() fails, as kdamond will terminate due to
   maybe_corrupted mechanism.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/lru_sort.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..96c8d0dfcafd 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -344,6 +344,10 @@ static int damon_lru_sort_apply_parameters(void)
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
@@ -388,8 +392,13 @@ static int damon_lru_sort_turn(bool on)
 
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

