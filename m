Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93713E1713
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405944; cv=none; b=OoobMU4NyqMVwSNsHxQyMv33VNee9tnqvex9rijz4U0kVxjRpVNreXVYplAPnUADPd1zoh1gvYTMuqhhh0nAZa7PnDfvRTTKPbe17bbjY7o7mdsXY8ixP7d0gcE2R/fb6LU9NzzjQcZ4cLRiZL5Zbsh7TVFNPkn+C/Mx2j1WH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405944; c=relaxed/simple;
	bh=lvc7mybribNI0qKM6N5/FmJL7igj+yb2/P4ASaICf40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSuj/JcbKIlOl47PwALAlC41mOSTYatYfb7M9q4yIJ0Y3pQ7CI8TgQbupflcWL7r+9+q/za4hZGtH2FNjfyV8UtbGUckUK+oMaFHWDikNPMjmJqa3GGii/LdppAV7cxRXEnCQiewSr/bHlO5dJx4SdhFeBIWkzRM+pM3DukfrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqzOCXH3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqzOCXH3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49050bfe053so83219135e9.3
        for <damon@lists.linux.dev>; Tue, 02 Jun 2026 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405941; x=1781010741; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xufbH6/LW8nomXQ4PybUK63N3KgJQEA2McZ4fEZ1QJw=;
        b=KqzOCXH3X6y0PWHtH/gOq9ZKUeA4ea7mUJEcYkTtRiH8NZezs4+G8m0MBDJkwoEoaz
         hWKXen0IR8I0kVU4JxXsZnHEln95MhclzdC9/m21orZlHbEMYc0P0jwBx0k9cvPYCnOf
         hsm9JuDqwiJZ/lsuEfB11hT5oLwT+TMFDMV31lRbLqj6ySDEHfAskF/njd8R2siAdzXU
         WHL3CEpsqbZ/dG0uVFBdWT7/ICIZSP5PUqjjr89OAyK3bV7/Yda9QflhWuLAqivnQyVQ
         ECXL/FKghkIlCcM8+USyKWA6lIFfZuUXpUKU1FINz8RLoH1zEPpU7zmvAcf+tyB7wwhu
         Ib8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405941; x=1781010741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xufbH6/LW8nomXQ4PybUK63N3KgJQEA2McZ4fEZ1QJw=;
        b=UWhKnVOstwvXEuGVUYZm4zzlO72Jt6vcS+a7LbCUT1msOYPwXDMk8LGAuKMTr/kyzo
         FZBUMGk4r9cpxEA23TRl3XyW5luWkk12p0YZ24jm+3fuWaUpxz9K1NiGIl/Lle39hfWq
         ydZgoJm/kmMvO1o8Q8MZDZOrAVq/oOVX5l0msWh15tVeQuMno3saCaoJNxNtMfd5vrS8
         lBLi6Yxck/tJoXRRQBLN/4VYDg2oqukaJP3T6bBdrNJG30Ce1X6JTMPL4VQoH5RnveAr
         +xpOb+jgds5TdIyznfh+kL6/2DyaYXmLMerAAcC7nl838dl4YJirY5VNbt28zs5ZHEvV
         0d2w==
X-Forwarded-Encrypted: i=1; AFNElJ9uVxfwhV7zYFUGRnC+oaUcGHZFps8hVWfxN0TkFS0QpxRtM7XIXpLjSh+K3a238GH0QoY+4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhrC9nPW6OZyIucsLsGZ0OUIY4x6Mw7S5kC56WS2EriR8FtDQj
	KOVatYKm5Fn63Bc6vu9F+Gj4oWVnL9PvBAYGSbdUGfLZx0bUelVPqzeOG303LyEsuwLlkg==
X-Gm-Gg: Acq92OGITM6SrhFoGkZkVtGFSZWeCeH8zJ/DCBt2ZQRh2LurqlyzQ5UtXQXpjLeDTlg
	MIC3Rsx1KByzPEV2c2ZIJ9qahl8R8naB5L7qf+CKJ3Ymr+M/Mng0j4HKUSINCM9oXbE+TWoaZe5
	QytkSTt5mZWrOG7E0qW3pIE1V8o0rtByhIAYztsvEcg0g562pMnmeyBlCemYPyZnfAQSy7dHe45
	K6WhAyYgL5PswT+jDgJqbvOgzG1e3QdmqloMHnukrw2lPdGZDrbOi7ueXEM+pQy3ahBpcwVx2CO
	q6ujI0hZOlgUV8gruQah70tjBDAR5dri6Jc7+r2pSzQDaDYJAUl13ri6K+52k8ny26qAyVPL/zQ
	FyMKKviF0VSB4jazQe0BUdERtgeM5Ct2LZIK1uBWjegpZjQs1HiCvjeW4EP3M7nAb/GqWKREL1H
	gMMTq6nOY+tqPDpOxQXJ9AfMtZCa+aRQQmSFtqr26LXg==
X-Received: by 2002:a05:600c:5915:b0:490:958f:2a5e with SMTP id 5b1f17b1804b1-490b071aa9dmr56258675e9.13.1780405940691;
        Tue, 02 Jun 2026 06:12:20 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c3081sm33234665f8f.15.2026.06.02.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:12:20 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxoid@gmail.com
Subject: [PATCH 2/2] selftests/damon/sysfs_refresh: test kdamond refresh_ms
Date: Tue,  2 Jun 2026 15:12:17 +0200
Message-ID: <20260602131217.2210912-3-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602131217.2210912-1-linuxoid@gmail.com>
References: <20260602131217.2210912-1-linuxoid@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing a non-zero value to a kdamond's 'refresh_ms' sysfs file should
make DAMON periodically update the read-only sysfs files on its own,
without the user writing update keywords such as 'update_schemes_stats'
to the 'state' file.  This behavior has no test coverage.

Add a test that starts a kdamond with refresh_ms set and a 'stat' scheme
whose default access pattern matches every monitored region, then polls
the scheme's 'nr_tried' stats file directly, without requesting an
update.  The value can become non-zero only via the periodic refresh, so
the test confirms refresh_ms works; with refresh_ms disabled the stat
stays zero and the test fails.

Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../testing/selftests/damon/sysfs_refresh.py  | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_refresh.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 2180c328a8252..ece244e5c5b95 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS += sysfs.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
 TEST_PROGS += damos_tried_regions.py damon_nr_regions.py
+TEST_PROGS += sysfs_refresh.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 # regression tests (reproducers of previously found bugs)
diff --git a/tools/testing/selftests/damon/sysfs_refresh.py b/tools/testing/selftests/damon/sysfs_refresh.py
new file mode 100755
index 0000000000000..012b7e8f509f5
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_refresh.py
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+import subprocess
+import time
+
+import _damon_sysfs
+
+def main():
+    # Continuously access a memory region for far longer than the test needs,
+    # so the kdamond always has a live target to monitor while we poll.
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(
+            ['./access_memory', '1', '%d' % sz_region, '60000', 'repeat'])
+
+    # A 'stat' scheme with the default (maximally wide) access pattern matches
+    # every monitored region, so its 'nr_tried' stat increases as the kdamond
+    # runs.  refresh_ms should make DAMON update the schemes' stats files under
+    # sysfs on its own, without a manual 'update_schemes_stats' request.
+    kdamond = _damon_sysfs.Kdamond(
+            refresh_ms=100,
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(action='stat')],
+                )])
+    kdamonds = _damon_sysfs.Kdamonds([kdamond])
+
+    err = kdamonds.start()
+    if err is not None:
+        # Kernels older than the refresh_ms feature have no such file; treat
+        # that as unsupported rather than a failure.
+        if not os.path.exists(os.path.join(kdamond.sysfs_dir(), 'refresh_ms')):
+            proc.terminate()
+            proc.wait()
+            print('kdamond has no refresh_ms file; skipping')
+            exit(_damon_sysfs.ksft_skip)
+        proc.terminate()
+        proc.wait()
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    scheme = kdamond.contexts[0].schemes[0]
+    nr_tried_path = os.path.join(scheme.sysfs_dir(), 'stats', 'nr_tried')
+
+    try:
+        # Poll the stat file directly.  We never request an update (e.g.
+        # 'update_schemes_stats'), so 'nr_tried' can become non-zero only
+        # through the periodic refresh that refresh_ms enables.
+        nr_tried = 0
+        deadline = time.monotonic() + 10
+        while time.monotonic() < deadline:
+            if proc.poll() is not None:
+                print('the access_memory target exited unexpectedly')
+                exit(1)
+            content, err = _damon_sysfs.read_file(nr_tried_path)
+            if err is not None:
+                print('reading %s failed: %s' % (nr_tried_path, err))
+                exit(1)
+            nr_tried = int(content)
+            if nr_tried > 0:
+                break
+            time.sleep(0.1)
+    finally:
+        kdamonds.stop()
+        proc.terminate()
+        proc.wait()
+
+    if nr_tried == 0:
+        print('refresh_ms did not auto-update the schemes stats')
+        exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.43.0

