Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA633D51A
	for <damon@lists.linux.dev>; Sun, 24 May 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779614376; cv=none; b=Q4LDMtkjINTUJr0T/y26yL9qiU0L6dj+rSpmEJ1nYTbF5zNX7FHShaN7VOSLi3EYQsW96S/2jR9BId6bF5Yxk90399vt6tuQz/KZN+83a67j5fqzcS5OpohM4JaaKbhzp9vflUQOQTuR1S2+pF+BMPVUNbxXjK92kg8m0NhTaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779614376; c=relaxed/simple;
	bh=ojS7YMq9ny+6I7+wp1Uy03uzolXMYk7P5/Iw5lgboC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkXCauuSjWBvvwRh9zEwNzg+jCyk+sSml4U+H/0PfXcf8rVhBdPJA51ls+vTkiEjolNaaSQxQOtpsWwmsQMu61cD+DqOok5dP68FL0FNqjosb1Wp0m5DH4pCLgHsvwiDtd3ng4QXSft9DfT9ZHgVfK7SaYLzigEIBqiaewzdS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnRdK+3h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnRdK+3h"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b9a1896db5so15234155ad.3
        for <damon@lists.linux.dev>; Sun, 24 May 2026 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779614374; x=1780219174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzFLSXviPLq0I/Xz70YuBFZ/FEtYhu4eVtx71crsM3c=;
        b=qnRdK+3hFGFwIDRUsfGQMDzJAi5r1uAsTpQ8sy304FOjyqxeXtPEztIP0Y9vghhTX0
         gRL5vQSxNVj7MIyc2+x1om62TaazpC75XXi9r2AoeE4UkxaMggydWQYM++c1Av7OhbNu
         eMEyCit6jv1fWxGaYCDgeh5joUXzqSJcFF1hRVRn0e2CXK3yZSN0AQlPwBSeoG6BJCLP
         gf6UfnpKauJw/SVcMiRrfhR1bqGgBFXBexMSbpwnwdRTukYe+IgNTwHpfxe5bkqrUoLF
         ec7nOFjdAGQhUavXdvlcfLkYUANhqp4MGjL/EZsKB3kdocs1uKUt91naLWHzx0dUKRns
         lFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779614374; x=1780219174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzFLSXviPLq0I/Xz70YuBFZ/FEtYhu4eVtx71crsM3c=;
        b=R5EcuLU9ahlI5thW9XXaeNHJmbHZFlYev3L4AVLmKnNhUSoKprVuRKuuir8f2qWWXK
         hX4/lacsQ/GTJDQE5PeydDJN/878v6tVXptYO9O7pw3lXna605cJSj0uA/RyPrIaxhTQ
         ePkVNUgZYxC9yfA9avQK+RxINU2G9/To9BAwxkDuTmsddwubF9haQh6Gi5xNFdqIdkxp
         qPg3G8bS/27WFoV7aEGc6DF2qN3FKMQs/t8fSL0gSuUkdmeCdNLgh53x0FTKJlEmyw0p
         A2gIXKa4wRsvu+2n7J+X0F1TpJxbiZ8/4mV/H774hlLmod/p19q9mTJz2V+9G/T5ZHMp
         oKCA==
X-Forwarded-Encrypted: i=1; AFNElJ/jLwm/bX/h5fbnfIKT7dMHgHc2FwEMj/1i9rNd5jhjyJ7ephY5VSOhKdsP5LjOKfAFGXAbpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgSZQ0fiWohBmtYlPb7bpzNC+fmkfwIE92Rp6aSd4cGYsueBBu
	vwK402VIzV9DxsTQJ1b7RfSSgpwcm7F6mbVZJn2YmCW2dm6C/c+Hj9Jz
X-Gm-Gg: Acq92OGZku0dgoujwycYC8BX3av5V06PBGThMurKAQkPc9dzvZJdC31DMkF8dTbqjHO
	qcqi19ZY1+542wSI7FNtsGAJdeg5VYdjV1GytDrYecNH0B45Bt3McoopKLOpaPmlJvOiD9dpcIh
	3nSLcVJquitLx2+eh2IIQy+Pmg4IvDUREi+irDNkEwokdeXCW29tOuCM4LJWtGjWT0XpwnTqOIW
	i2HwIi6PC4C0aVmwXHHs4Z2rcHbue/xVm6y2yWIqSgmONdXeQNhe66fbus2dHEClF1mNyltfNRO
	OjXWWCNXGojwwfxHA78B8o3L9AztnMS1kjbIRdZAQTwwQUH8IhCZ7GeuozDietaYc67JonEmlbG
	gCM0a1/yabytdrl/khaXmW9sdIs3dmvQfTLWCiAALuaEQ+vFZhCjjfM1w3304Y2LrpII4r3hDgH
	WuVaG2KIyOmFH7xCbj6cerMebD/PoYEHBz0vQwHEKEyrV/wprY1qTvRgoef8w=
X-Received: by 2002:a17:902:ea01:b0:2bc:f1da:4c09 with SMTP id d9443c01a7336-2beb037fb81mr59515795ad.2.1779614373960;
        Sun, 24 May 2026 02:19:33 -0700 (PDT)
Received: from localhost.localdomain ([60.243.191.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm62023705ad.59.2026.05.24.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 02:19:33 -0700 (PDT)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: [PATCH] selftests/damon: add regression test for damos_walk() vs kdamond exit race
Date: Sun, 24 May 2026 14:48:12 +0530
Message-Id: <20260524091812.35283-1-saileshnandanavanam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test that verifies damos_walk() does not deadlock
when racing with kdamond_fn() exit.

When kdamond_fn() finishes its main loop, it cancels remaining
damos_walk() requests and unsets damon_ctx->kdamond. Without the fix
in commit 33c3f6c2b48c, damos_walk() could be called right after
cancellation but before kdamond pointer unset, causing it to wait
forever for handling that never comes.

The test starts kdamond monitoring a short-lived process, waits for
the process to exit naturally triggering kdamond termination, then
rapidly calls update_schemes_tried_regions to hit the race window.
Without the fix this would hang indefinitely.

Fixes: 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race")
Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../sysfs_damos_walk_kdamond_exit_race.py     | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 2180c328a825..60c83d6c318e 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -20,6 +20,7 @@ TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_memcg_path_leak.sh
 TEST_PROGS += sysfs_no_op_commit_break.py
+TEST_PROGS += sysfs_damos_walk_kdamond_exit_race.py
 
 EXTRA_CLEAN = __pycache__
 
diff --git a/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py
new file mode 100644
index 000000000000..9b9d66a23f51
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py
@@ -0,0 +1,47 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Regression test for damos_walk() vs kdamond_fn() exit race.
+import subprocess
+import time
+import _damon_sysfs
+def main():
+    proc = subprocess.Popen(['sleep', '0.3'])
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    action='stat',
+                    access_pattern=_damon_sysfs.DamosAccessPattern(
+                        nr_accesses=[0, 200]))]
+                )]
+            )])
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+    proc.wait()
+    completed = False
+    timeout = time.time() + 5
+    while time.time() < timeout:
+        err = kdamonds.kdamonds[0].update_schemes_tried_regions()
+        if err is not None:
+            completed = True
+            break
+        try:
+            with open('/sys/kernel/mm/damon/admin/kdamonds/0/state') as f:
+                state = f.read().strip()
+            if state == 'off':
+                completed = True
+                break
+        except:
+            completed = True
+            break
+    if not completed:
+        print('FAIL: test timed out - possible damos_walk/kdamond exit race deadlock')
+        kdamonds.stop()
+        exit(1)
+    print('PASS: damos_walk() vs kdamond exit race not triggered')
+if __name__ == '__main__':
+    main()
-- 
2.34.1

