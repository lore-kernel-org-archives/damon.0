Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2162224AFA
	for <damon@lists.linux.dev>; Sun, 24 May 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617010; cv=none; b=pUuPf3ZqeqFmbffCITnmkhKnpLITDNIKD/cYC2HJus1vg+QD1Z7kEwswhmnK8tYHHQGmnojmNTN3jvsXDZbbEaZ1uVmBVtYOzmD6j5CU4Ek/Tx81C/iKOQXsMQH+r1uK+pGBT3zyzEebc6AHzkWndIDkLBjluAeN5Wi+SlArB0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617010; c=relaxed/simple;
	bh=8/v42twDQCmIHyF6EGLKUMLW9TV8CTEejmHUQEe3vXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jujg2YlSsPinTAC+jJ+sntngOrb1JT03MfbW9s6UT8NSFFZzKiY8Kq2U6m78t2h27CwOnJrGltsHAVPVdQszthh9ugjTnm5v4rPJZbFB2hSiNPHMnZbV3DxmC+8hfur/TdexCqMjgHuC+Eu9Ljp+o4Fh7HFvWYfP/0vNBq1CxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsDgiOIb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsDgiOIb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bd5b3f8a98so17020955ad.2
        for <damon@lists.linux.dev>; Sun, 24 May 2026 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779617008; x=1780221808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EXBfuqbAyMEZ9CUfrSMvnKn8IB4mQp9S1TVPfOw1Hnw=;
        b=VsDgiOIblXUcadPOACf4m3gFgd8pLDCAg7jgcFs+0Yi6xIluOrK4I427uPH6O78LEl
         PMzcB5YgtBVo3CNESwmFJ3b9ataqroo0frtRJavJwPqbtOe2o0md6nSk5bgvlSDnrDHV
         CnSBITwA63eYnAEdMnb2uqRfUPksVyx3qSRwcN7O4wsIk1Tzi+nZfK2OOvwjn8bJpMzB
         edArCPGa3blh2QvOJkk/stxUnazndFRdvb2oNi4uE/wNvk9R0OpW1e3NGbEUtEccs+4c
         GG+gLUNShX6pT5y4k+jXrsGTRb/JXgNWLK+Tsa1Zou1H4hR0SOXXKWDrZxJDySKjP9DX
         Ganw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779617008; x=1780221808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXBfuqbAyMEZ9CUfrSMvnKn8IB4mQp9S1TVPfOw1Hnw=;
        b=byXwD7NY7N8KnXU06+ZWIh0Q1jIBcf2GN8XYpv7krfxpcCteAfbDoHNOhfy0uJ5U0A
         fqSfujhXl1JlL7OLFKRXlB990jkJ95kpq8c65i/YX8n4d5zxCHeRjcKXOqx/RGs/FJTl
         neNp7Hx/sePL5DjEbxPZGckfuAthWLhgmA/GXnFJYFZbj0oBAYSm6spwuGBYtippRRPR
         7+vchIk+3TISq9pF2SNan7InW5mSGvj4iKJ/FQv9E75BGcXxb2pKEUeLkIrqr1flnvI6
         ait6bhOwW+vSxCf0qP8zL+p+Ipo+3kdchkVnEKBDAvJKeuSV66F/7lDlPXWiIaQm/jBH
         d8Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+Py9dgxZ4DGqVOjQZM2KySU9VXQVpTK19uFWQcRCdj1SIeix+0wl8+QxBtlhygXD9mBiZ+Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTiUBk2ZvGQSWeK3TemFJB04CyOzPFCjFc7hNHnwXfZVjsz2xy
	g7SKP4SXUtvc1yyNwTXtu5EtSLYdlpa00Y+r0BMXC1BLLD611W4mN1zO
X-Gm-Gg: Acq92OFRQ9J77r7zXAjgXhhoG7CBs/GRqieKpXX64/awaRINJvpQ5gujjS8WGXMoa9h
	tCsAnx1PxH4RqsAZx405++QvT4R1izN5IoUuCKhR4cEChv3JJPR4xDTohR4QFdA+7N6kkb7Dvy8
	fVL+3T3cUQ04v6Vx2hQIUYBrja9RGRfZr95pd2LelvRuJtU5dxc/vir3yai5mlncJDmCWXPoksA
	wkcdNPp4QAyLAfEdVwRcyMtkVJsBlSX3+F4k3iq6SDiOXxSzdlL5D27GW3pchVXvLepDuYU/3yl
	CWgN4XSa3ge2g20zhsVWNkuiqn3UDR16Y2VsZDHPH/rCqqHRSffR4N6ns5owkN+HS39Jb7hhvNk
	wVsaqIABv9LNJm1Z0YW7Rqx8+4Hkf0Ms8KrCjkgk7G8ejpta5XAj0+qAwLLyobYuUUJoF3y2TOk
	f2BME+XaB8XBp8IpJmmo99vc2YW/IDZNKF5YAnUDy1k+s0KD+X8DFKUGUHGh4=
X-Received: by 2002:a05:6a21:4a8c:b0:39b:b6d2:1f24 with SMTP id adf61e73a8af0-3b3285caaf4mr5506279637.0.1779617008111;
        Sun, 24 May 2026 03:03:28 -0700 (PDT)
Received: from localhost.localdomain ([60.243.191.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm7630123b3a.60.2026.05.24.03.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:03:27 -0700 (PDT)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: sj@kernel.org
Cc: shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Subject: [PATCH v2] selftests/damon: add regression test for damos_walk() vs kdamond exit race
Date: Sun, 24 May 2026 15:32:58 +0530
Message-Id: <20260524100258.36819-1-saileshnandanavanam@gmail.com>
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
rapidly calls update_schemes_tried_regions in a separate thread to
hit the race window. Using a thread with join timeout ensures the
test can detect kernel-level deadlocks where the system call blocks
in uninterruptible state.

The sysfs state path is resolved dynamically via the kdamonds object
instead of being hardcoded, and exceptions are handled specifically
as OSError rather than using a bare except block.

Fixes: 33c3f6c2b48c ("mm/damon/core: fix damos_walk() vs kdamond_fn() exit race")
Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../sysfs_damos_walk_kdamond_exit_race.py     | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py

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
new file mode 100755
index 000000000000..8e8006d63926
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_damos_walk_kdamond_exit_race.py
@@ -0,0 +1,82 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Regression test for damos_walk() vs kdamond_fn() exit race.
+#
+# When kdamond_fn() finishes its main loop, it cancels remaining damos_walk()
+# requests and unsets damon_ctx->kdamond. If damos_walk() is called right
+# after cancellation but before kdamond pointer unset, it could wait forever
+# for handling that never comes, causing a deadlock.
+#
+# This test verifies the fix by rapidly calling update_schemes_tried_regions
+# while kdamond is naturally terminating (monitored process exits).
+# Without the fix (commit 33c3f6c2b48c), this would hang indefinitely.
+
+import os
+import subprocess
+import threading
+import time
+import _damon_sysfs
+
+def call_update(kdamond, result):
+    err = kdamond.update_schemes_tried_regions()
+    result['err'] = err
+    result['done'] = True
+
+def main():
+    proc = subprocess.Popen(['sleep', '0.3'])
+
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
+
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    # Wait for monitored process to die naturally
+    proc.wait()
+
+    # Rapidly call damos_walk() while kdamond is exiting
+    # Use a thread with real timeout to detect kernel-level deadlock
+    deadline = time.time() + 5
+    while time.time() < deadline:
+        result = {'done': False, 'err': None}
+        t = threading.Thread(target=call_update,
+                             args=(kdamonds.kdamonds[0], result))
+        t.daemon = True
+        t.start()
+        t.join(timeout=5)
+
+        if not result['done']:
+            print('FAIL: update_schemes_tried_regions hung - '
+                  'possible damos_walk/kdamond exit race deadlock')
+            exit(1)
+
+        if result['err'] is not None:
+            # kdamond stopped cleanly - expected
+            break
+
+        # Check kdamond state via sysfs using dynamic path
+        state_path = os.path.join(
+                kdamonds.kdamonds[0].sysfs_dir(), 'state')
+        try:
+            with open(state_path) as f:
+                if f.read().strip() == 'off':
+                    break
+        except OSError as e:
+            print('failed to read kdamond state: %s' % e)
+            exit(1)
+
+    print('PASS: damos_walk() vs kdamond exit race not triggered')
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1

