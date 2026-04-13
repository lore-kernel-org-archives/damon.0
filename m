Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC13101A7
	for <damon@lists.linux.dev>; Mon, 13 Apr 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106366; cv=none; b=eVL4sLbtNCUWZqOttefnyrz6JjGju6AMjaed490Ul0/z6h7evepICn+zqef35WhLYJ54+h/mfDtfpg4horrweCjRh4IWkzrn30CKsvKY3TRjIfl/IQ9FFb7ZzcjoeUwMm2/p6eDMMTMERqepN1kzVMlyyN60djbfY0FzktzMOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106366; c=relaxed/simple;
	bh=E7CGhx7zgJ90f2x7uSQxgs8hXFDCGYAsRsGf7S4DETc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGsRdU41sD4BADycxwDIFeNkBStO990AW2dVkD1HcgG/Yk+P7/qf9l5VztixXqNSAVQO4pesQ4ZEQkTbj60Fl/uqRltRYjPwEZT0ECLFcC+f5FmNbMnv4MP40NpsnWKisXlN92rHxlgoVSKkhfA/LwKn8X9ZpxTJ7DmEg3k+Zi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvs1PZZq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvs1PZZq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so731099a91.0
        for <damon@lists.linux.dev>; Mon, 13 Apr 2026 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106365; x=1776711165; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmdIWRECgQvWI5XNgsDoZsRZtmlBed1efnAUPIgyp8Q=;
        b=Rvs1PZZqUYpGSYeqBFa1wck5kIuTH125z6HIi7Jxqr022YMX2mTbEE1LYMxr6JA5g1
         yDKNA2BQWjvFrcJfa/Tqw0+bZM1lgLUWcwCrb+E9QuBT8tS46cKPl6eMV8Izy7nDy6km
         9sF4Nhz5MqUTqHbKpFo4wtHR5oqNUWtGI6117vw3HwhRCtDmAjJRMpRX88uLxt74kh15
         zuBePl43Poi6Fx6DUEWuQfIYyN8rD3/8z/0qU/LtP4lQDL6QBlLlZ+iRohRDUziPyriZ
         83TrHnZWpiyj5Hyb28KeP68N5uJhujZVzlRkrqpChA5C5gby0h6B8InroOoAQSwrkSv2
         YdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106365; x=1776711165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmdIWRECgQvWI5XNgsDoZsRZtmlBed1efnAUPIgyp8Q=;
        b=PCohG9xcjbtODIVep+ceZDyrPSzfp9s0V917jkCnEavBUYRHK/j1NFCM6oF1dyaTPR
         3awDny9FDgsybTjOKKf2Gs3am0p6yVcj43tDGon60VYyjLSdJ3qB+rrRvkfjxZEzLi7k
         pfzPINzsHQ5TxX67Uw60V0EeAc7KyanzGAjkhCGBIcYX8I+tkJN3xphBse5a8VpjTqQ/
         lrQGD3yqdD5irvTs+9pxnYuzpQODU/KO9BshxTJOVyBTjc+c0qPtuOR7j3IJNYwELxB9
         oPYwzjTPBMD+9DiVuKi5kq9JgNblDG2f1zTjB+Wnbi9F1hQbNgp4odJ5AXZ9LISHN62I
         s2dA==
X-Gm-Message-State: AOJu0YxLMBPPRe62k3HOvWUclEYdd2WlbYMaZ/Gq+/bGDVrqqrIHZe5T
	I+wLuB/6CjAt5OHihvb6iV6NeCDe5DH8icJEjI0RFkNhgaeFNa8B+Y68
X-Gm-Gg: AeBDieunLanPLnOfan2v7jPZhut83ztzTGMB69vMrP7xJpmNiw4Bi0xOscFTI3Av1z4
	Of7NYt0qXFlNWn/dMCHxCjS5xuBnb7erFWZHPcNPDMBmmpwKGiIxQ2v2wpO4DAE5+z52KvODddi
	T+DoQ8eB/tXuAYkQhO61lqYpfedKTGO4FHnpjrLd6PTvlnDk3/AklRKhYPhP+SF07YzPyWTjqCD
	bcSqWYZ4jZ4tZCMfROwAxRv3IbZN+W/XObB0EETzG/ge70T95Mv32UbHlrahKv4He7AZjIaX9rW
	IBHUVQb0BPCWXfcmup6yR3A6nEA/QOKH8SIe+iqTxZYRz0L7PX38N9BtnnMDkWA93AnYOuUO/J/
	nUMx1cvyBOa+xOg8ui1MSX1OprB5M+xrjIWd25LNgHEQTWQQJ/qyUnUVfoeED7EdQr3KygQA7kG
	+Sxlvdr/NL2o0gzKmFzgUtHJSDB7KvAVof9h/UInz1AR64B9Em7JQ=
X-Received: by 2002:a17:90b:4e88:b0:35f:b230:5889 with SMTP id 98e67ed59e1d1-35fb2305a05mr4561961a91.6.1776106364836;
        Mon, 13 Apr 2026 11:52:44 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc2adae0dsm1225435a91.3.2026.04.13.11.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 11:52:44 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v2 0/2] mm/damon: reset thread status parameters upon kdamond termination
Date: Tue, 14 Apr 2026 02:52:47 +0800
Message-ID: <20260413185249.5921-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
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

1. DAMON_LRU_SORT/DAMON_RECLAIM is built into the kernel, so it cannot
   be unloaded and reloaded at runtime.
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
1. In damon_{lru_sort, reclaim}_turn(): Add fallback logic to reset
   parameters when damon_stop() fails but kdamond is not running.
2. In damon_{lru_sort, reclaim}_apply_parameters(): Reset parameters
   when damon_commit_ctx() fails, as kdamond will terminate due to
   maybe_corrupted mechanism.

Changes from RFC-v1
(https://lore.kernel.org/20260330164347.12772-1-aethernet65535@gmail.com)
- Remove RFC tag.
- Remove 'damon_thread_status' structure and damon_update_thread_status()
  (SJ pointed out this was too much extension of core API for a problem
  that can be fixed more simply).
- Add a fallback in damon_{lru_sort, reclaim}_turn() 'N' path. If
  damon_stop() fails but kdamond is not running, forcefully reset the
  parameters.
- Reset 'enabled' and 'kdamond_pid' when damon_commit_ctx() fails in
  damon_{lru_sort, reclaim}_apply_parameters() (kdamond will terminate
  eventually in this case).

Liew Rui Yan (2):
  mm/damon/lru_sort: reset thread status parameters upon kdamond
    termination
  mm/damon/reclaim: reset thread status parameters upon kdamond
    termination

 mm/damon/lru_sort.c | 13 +++++++++++--
 mm/damon/reclaim.c  | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.53.0

