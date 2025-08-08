Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB2285CA1
	for <damon@lists.linux.dev>; Fri,  8 Aug 2025 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682955; cv=none; b=oWI0FAtjaO06OiUSJUnx4liyamyPUqNDZcYm2M+TbP05s0gwRY6ulUkbU6/YfV19jx4cXc2i8Olavzfx1Mevn8eebbmcqTMZLA2yEGZf9loCgxWasOw2P/Sj95GOqvVV8QXxJlpMkqSRIt1rRbpnbFwGSjXY6TyvzpRfXvxsDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682955; c=relaxed/simple;
	bh=q2HxuRnziCS/KCAne4WTFZGZzWx1yh6nzn7+29FXJJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA6TDiAntQNPywswMXQPGTxgcLIP3qXrhfXbJV/2ItOe3vN9Nb9SrZgxPHWjRoTuBYptJ+oJ4km4n5ibf+TibNe7LXQvGjBAoNWnKTre/ZbixCZZK4wNrgjn7YmvRX7ZCov7nVpDy3CQYfI5Qm3VVWOBzie+c21Mnpr8/Nd9ZOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf3HdauU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf3HdauU"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bf3dafaa5so3598139b3a.0
        for <damon@lists.linux.dev>; Fri, 08 Aug 2025 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754682953; x=1755287753; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7vLxCVUxl0MmGqdQtyLA8BfN4dqum9VMza52NtDYMw=;
        b=Sf3HdauU9Hpzn6NoTfPCNMxk/U3O8Hbya4aXt87hqlu0JMsl3CkBmtrXhxFNVunyM/
         jOLSjJfePLH4ELp9wL4DafpYg0s0e5D0go5zFG9XQ04ml0qMAOo7JXF239hJhq8WJZyW
         h3e9X4OL9gI4RjvUFZfQZ2kwOaHNsFbPiNeLJv5o6MgYz+NpAA2nqLUGMs1bSGTXLLRC
         CeMJH8X8kZyRdHqEMd8hOzgPR7g4KsgCxRTL73xAW/YrDGGg2/7mqxfUlMkviynLCZyA
         o+k5rBFoOBwown7QWPsAze+QfI7NwK9kP1v8cO4OQFpIWkOHPHqdbY+puyy/S/BEwDfA
         P2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682953; x=1755287753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7vLxCVUxl0MmGqdQtyLA8BfN4dqum9VMza52NtDYMw=;
        b=TR9i9KAz4zu6uCgNIe5mAJgqJYlJAs5UEedxkbpHdpBtI2Cg0/LFu8gFhodXS7YDgc
         Ilu0O2yDQdzquj/faVYSxBJGsZPblns44tG8tfwA1diLBDjH+pjsEC57czck4XVw5rMc
         jvC18Ut91P71PLUocaR4mSyaq2w61aXdPx8suPVOUgOwakxPpoSVV0fBWkefycVF3BVc
         4ThcsFgChyL4MkVMmIvT2ARTT941GqIFGuVLffBK8faEwpM69xzZE8XWQcLqVPdcOOWZ
         u/qRTJfGTXUCGVvdoaSwUocmqFzDBGfFBY4eNvdietO246uC03HgKq4fsji4f8qpjk8o
         tXdw==
X-Gm-Message-State: AOJu0YydGT/+YUCygRiewjzPCDq9MDl4syVZ2DkAt9FInWYjFJNXY3zx
	Bv7I4NLhSCkaqQb7U40oslnZmX8meGLklpyc8dkxFKHC0LlyCiW/bkLL
X-Gm-Gg: ASbGncv8tkgChe/EsTW1EUkFDNkyMa9Yz+nLNI02HEbO6L1vkGJVUCOlkdh6shseKA+
	FgAVpmsfc1/ruV300h2ye3guZx34qUcqLebLKXLeliR4fAQozEaTf0BRfB7TxzkqEJvVStzUzxH
	YOjqOcUyIra61pgekfdnnWg1P0drnMLJY17RU+GyQOYpi+lyKM3qjzwbr5irEFgnCPCFuiVY7QD
	e6saOVqbgRXxDc8u3DnBUQnIqJkKLleUtpco0Lnnzjbv707uJ1zF/PNtXFMQCs3uYjcW5oxJQhm
	GHFWgj6UJQGYwILTINnXOOXqCst1lmRpi4Pq0OJY+P9U/JN+Q75gRsIccjqABgYKh7tLMyMHqlI
	/gEhNQrg4VtCi1YRQ
X-Google-Smtp-Source: AGHT+IFvgJAy77kGnbT3cdwDVClhvfLI833n7irAibiQmz4OyK+ScQ5l1PmRRVtI6B/sOkH/p7c6MA==
X-Received: by 2002:a05:6a20:5491:b0:222:ca3f:199 with SMTP id adf61e73a8af0-240556ba06dmr7025722637.18.1754682953116;
        Fri, 08 Aug 2025 12:55:53 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm21201103b3a.47.2025.08.08.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:55:52 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 1/2] selftests/damon: test no-op commit broke DAMON status
Date: Sat,  9 Aug 2025 04:55:17 +0900
Message-ID: <20250808195518.563053-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808195518.563053-1-ekffu200098@gmail.com>
References: <20250808195518.563053-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to verify that DAMON status is not changed after a no-op
commit. Currently, it is failing. but after fix the bug it should be
success.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/sysfs_no_op_commit_break.py         | 78 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_break.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 5b230deb19e8..44a4a819df55 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -17,6 +17,7 @@ TEST_PROGS += reclaim.sh lru_sort.sh
 TEST_PROGS += sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_memcg_path_leak.sh
+TEST_PROGS += sysfs_no_op_commit_break.py
 
 EXTRA_CLEAN = __pycache__
 
diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
new file mode 100755
index 000000000000..300cdbaa7eda
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -0,0 +1,78 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import json
+import os
+import subprocess
+import sys
+
+import _damon_sysfs
+
+def dump_damon_status_dict(pid):
+    try:
+        subprocess.check_output(['which', 'drgn'], stderr=subprocess.DEVNULL)
+    except:
+        return None, 'drgn not found'
+    file_dir = os.path.dirname(os.path.abspath(__file__))
+    dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
+    rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
+        stderr=subprocess.DEVNULL)
+
+    if rc != 0:
+        return None, f'drgn fail : return code({rc})'
+    try:
+        with open('damon_dump_output', 'r') as f:
+            return json.load(f), None
+    except Exception as e:
+        return None, 'json.load fail (%s)' % e
+
+def main():
+    # We can extend this test to change only the Given and reuse the When/Then.
+
+    # Given : setup filter with allow = True
+    proc = subprocess.Popen(['sleep', '10'])
+    kdamonds = _damon_sysfs.Kdamonds(
+        [_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    ops_filters=[
+                        _damon_sysfs.DamosFilter(type_='anon', matching=True, allow=True)
+                    ]
+                )],
+            )])]
+    )
+
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    before_commit_status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    # When : No-op commit, it should not break anything
+    kdamonds.kdamonds[0].commit()
+
+    # Then : Check value with drgn
+    after_commit_status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    before_commit_dump = json.dumps(before_commit_status, sort_keys=True, indent=2)
+    after_commit_dump = json.dumps(after_commit_status, sort_keys=True, indent=2)
+    if before_commit_dump != after_commit_dump:
+        print("[TEST FAILED] : no-op commit break damon status")
+        print("===== before_commit =====")
+        print(before_commit_dump)
+        print("===== after_commit =====")
+        print(after_commit_dump)
+        exit(1)
+
+    kdamonds.stop()
+
+if __name__ == '__main__':
+    main()
-- 
2.43.0

