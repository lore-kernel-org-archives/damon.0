Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348B42885A;
	Mon, 29 Jun 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744579; cv=none; b=qeO7J0dg7dRfXjE2IoccxPhy1ICriPhh2C2XX8+ysYJh0AoD6QsmVfkJfrjInmw3rbMcFjmNCo2VO2Xd9IAOXqTRq+2yVi+NbimP89DXSV0XxkzZe7Sf1UutqnqdAlZW+tacFCRmyXUhgx5ESEfWGHUAr9DiyiuLX5wIZK6pOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744579; c=relaxed/simple;
	bh=ZaOKcFEgM2Ja04T+mFLDag/PCMCGRR9Ia/djkv3OPRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqRZzcuq+7nJVSRKXxVvwzaQXxzyAYjYChWDwgwRsYy62cxxmsEOZLzzsqcuxdypixzvJhx8aqZ729T5VTmC9A7h7ufcRY0ktgtLdBBwpRVvge7fT/nAJ5KqbjSXkfzM8EtqERB1Qe0z+ypcdUGW2U1C7QUJIZ0w4kIKr5MU4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9NuB6Qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9NuB6Qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354511F00A3A;
	Mon, 29 Jun 2026 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744576;
	bh=jf02Ij8O80K2A7ATECAqkrfhafLEEQ+h7n6pFX7YXCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9NuB6Qwn+GuWe+S0bSEWS5lP/9JluIjXtyezwZmrVqdJhpwrre577CuWhH9pIF5I
	 EgTUy/7NXimwhPPyophout9wNiSvN4ZjuVBRizCk/ELTPd9cEMYABojmHBrvesQ3HE
	 KpCKaVFZkhX2gCNcaEfYqJQhhQQ2ZGKNEsZW/odAUP2tFyEVUOYC/8Bp2usDJVuTI1
	 1k3RkNx1fyrcXd4VJvpGfr5hyDxcn3GUwqDZtcmhxjqRZm0qypctwOLRCSUSuSuqDG
	 1DWdkOXAEMm2nCaJw+ozaPahHX2cvbFa8YtKDxIuh8Bt94xCQuP3O30wvu5tWyb0zX
	 VZaSNd0x9zb7g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ruslan Valiyev <linuxoid@gmail.com>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/2] selftests/damon/sysfs_refresh: test kdamond refresh_ms
Date: Mon, 29 Jun 2026 07:49:26 -0700
Message-ID: <20260629144927.134237-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629144927.134237-1-sj@kernel.org>
References: <20260629144927.134237-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruslan Valiyev <linuxoid@gmail.com>

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

Link: https://lore.kernel.org/20260602131217.2210912-3-linuxoid@gmail.com
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
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
2.47.3
