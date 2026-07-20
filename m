Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0D388E43
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516643; cv=none; b=J/+h/e6b5e8UUXMU61EYTe4Qoa5KrfG4+WyETib5Y8gYU2CnorglPA7sfGUHMc3mmvV9tnafDWNxIhqkxAh40ML8b/GbTn72+JeaBevedAMHLYgKER23gnF2KncNEYccfUxLTT4wXASev+drCJUtH8bdkepGdSw6aFr+11EkxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516643; c=relaxed/simple;
	bh=YLKc+POCNITKfz5Zq68JdFxIzpDDqljeDs2WwwuKzhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqR09iR05CY43XC169xN2jkY5LSczDXw2nwxfYHj9oTDu3h/Lv9ZqcYypyNGgwJ9ztyCO7c5vTg2N6nW+ZhO/ZI2bTRgPcofqvc38g0j14e/G86HzKkiXiIaecAfBwhoR74HgVaI+D2IVk0N5UY58Dnw+Afy7IwQ1nNeOKYrQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrgrXUe/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrgrXUe/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cea3004256so111243505ad.0
        for <damon@lists.linux.dev>; Sun, 19 Jul 2026 20:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516641; x=1785121441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zbv8c6XPjklVCkXRSa81M3HIzY/Ff3msBnn5ibeFm/4=;
        b=VrgrXUe/VhW8oemmXphS3h6dbJS6O0W9Fdhc05xz1DadW4tSoTltzQaKzLactLorr/
         ifliMc2RYlG0N4wViRy73NaNU7EpA3Ngp4VdjdGUpnwjeSWu4nW4VjB86JZcDw3viJGg
         QiCPDhMDwzNrMsNrsVlI90fEsKV2plXdaCM7PdPoLhoU5oPqbl3F6NMBygTOkrsmAU4z
         EgvcxK8Nv9c5deBvt3I5TIf+Cx2cjsP7td1r7k8dB7mgsxxGpepecebCmUK6xR0kNDtI
         sRWjyHl+abN9icNpnYlVYFUr/Ep9BraM3lgjosLZGAcfCYXAckErSqklkLcAD0KY4kbQ
         YzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516641; x=1785121441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zbv8c6XPjklVCkXRSa81M3HIzY/Ff3msBnn5ibeFm/4=;
        b=Mqw7S9SWH89wisGo0gLUrq7djQVHkTSTvLBdk9/sTYwKHlekDsHE5AML99SiEEbId9
         JqA2hkZ6WK1qtG/TQN2Q8pwMv6GYEpfb0acQBFd0rFfAFkcAcBV4vTZjZYCKq/TFQXKj
         4wrbakRYCs51//E+/OIkqXwOXP+yTb9pdgqL0ktOQRST5cBjQL0SEfPJ0kVvmHLkPtBU
         Y4PkSzuc3sqFiz1e9O/niAVZt/DdC/Px9/153GHDNb/uE4+vanwKUkYdOOkKbG2NnKsg
         kZi9dT6iCfwrf4TRrWuFE89/cjaLx+K7hMEnCMkkKVyj35W7r4ALabTPCsE8Vl6cs2Tv
         KEjQ==
X-Gm-Message-State: AOJu0Yy4bFd84b6RLxcUx3FlKzSB6YxiUkhqYgY/E0gkxkjmTMEEzGJ/
	AW6h+jakW5NXMyu4svrYbIdl2W3dilkiANV/alk1ZjTR8cXZCb/ulliQt6aRhvUH
X-Gm-Gg: AfdE7ckHTQGapX6BxuXLPCnx5zDoem/0nFWQBjmkGHmraSr2u1oIc9s4vrHePXgT9Ia
	F1XIkrH6+hZ82E0koTrzqxESDAXjjwSDoI4Y6vsPKjuG/HQMlFtSA4hCjK2cc1nngTRAIqIjeQ6
	UlBT+b2/phsm0npTssH0x+oi+wi2p0YuM4tirCZd4DPezCk2DSFvmWbgwBOGN1htr+M4pg08n/E
	/6EoqQ444tik0PI3cgCJyXN+VLQ6iktDoEhMI6sMBvTlpRg2S0plqjP0uXuQ6Jc3yFnc+IGt7hX
	y2jvtX3LCUR1vzDBYNO2PatBtWI7NsrPhg0tnS1FMn49t/95qbpPgbH6YO3bgpObYGQv9cL0aTL
	kGjk+sfsuJbibBrUtITLbaEkZdatLOHo7VZtdu1qlqaXGpXvl2L331hqJEv0yKEdNY37NAwnRen
	Lsc4GtocVBoxfsfhVroQsbXdc15Xs=
X-Received: by 2002:a17:902:d4cc:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2cf348193f5mr133308615ad.7.1784516641437;
        Sun, 19 Jul 2026 20:04:01 -0700 (PDT)
Received: from localhost.localdomain ([112.65.87.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344d80e6sm47783065ad.29.2026.07.19.20.03.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 20:04:01 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	daichaobing@sangfor.com.cn,
	wangkefeng.wang@huawei.com,
	gutierrez.asier@huawei-partners.com,
	zengheng4@huawei.com,
	kasong@tencent.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lianux.mm@gmail.com,
	lianux.wang@processmission.com,
	kunwu.chan@linux.dev
Subject: [RFC PATCH v3 3/3] selftests/damon: add functional test for DAMOS_SPLIT
Date: Mon, 20 Jul 2026 11:03:27 +0800
Message-ID: <20260720030327.80153-4-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720030327.80153-1-lianux.mm@gmail.com>
References: <20260720030327.80153-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add damos_split.py, which allocates a MADV_HUGEPAGE-backed region in a
child process and runs a DAMON/DAMOS scheme with action 'split' and
target_order 0 against it, then verifies the huge pages are split into
base pages (the child's AnonHugePages drops).

Extend the _damon_sysfs.py Damos helper with the target_order parameter
so a scheme's split target can be expressed.



Co-developed-by: Kunwu Chan <kunwu.chan@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@linux.dev>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |   1 +
 tools/testing/selftests/damon/_damon_sysfs.py |   9 +-
 tools/testing/selftests/damon/damos_split.py  | 125 ++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/damon/damos_split.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index ece244e5c5b9..a623c271355f 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS += sysfs.sh
 TEST_PROGS += sysfs.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
+TEST_PROGS += damos_split.py
 TEST_PROGS += damos_tried_regions.py damon_nr_regions.py
 TEST_PROGS += sysfs_refresh.py
 TEST_PROGS += reclaim.sh lru_sort.sh
diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index e6a2265d721e..5a01f31ad9f2 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -419,6 +419,7 @@ class Damos:
     filters = None
     apply_interval_us = None
     target_nid = None
+    target_order = None
     dests = None
     idx = None
     context = None
@@ -429,7 +430,7 @@ class Damos:
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
                  quota=DamosQuota(), watermarks=DamosWatermarks(),
                  core_filters=[], ops_filters=[], filters=[], target_nid=0,
-                 dests=DamosDests(), apply_interval_us=0):
+                 target_order=0, dests=DamosDests(), apply_interval_us=0):
         self.action = action
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
@@ -448,6 +449,7 @@ class Damos:
         self.filters.scheme = self
 
         self.target_nid = target_nid
+        self.target_order = target_order
         self.dests = dests
         self.dests.scheme = self
 
@@ -492,6 +494,11 @@ class Damos:
         if err is not None:
             return err
 
+        err = write_file(os.path.join(self.sysfs_dir(), 'target_order'), '%d' %
+                         self.target_order)
+        if err is not None:
+            return err
+
         err = self.dests.stage()
         if err is not None:
             return err
diff --git a/tools/testing/selftests/damon/damos_split.py b/tools/testing/selftests/damon/damos_split.py
new file mode 100644
index 000000000000..089fbe0f0d4d
--- /dev/null
+++ b/tools/testing/selftests/damon/damos_split.py
@@ -0,0 +1,125 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Functional test for the DAMOS_SPLIT action.
+#
+# A child process allocates a MADV_HUGEPAGE-backed anonymous region and
+# faults it in so that it is backed by (m)THPs.  The parent then runs a
+# DAMON/DAMOS scheme with action 'split' and target_order 0 against the
+# child and checks that the huge pages are split into base pages, i.e. the
+# child's AnonHugePages (as reported by /proc/<pid>/smaps) drops.
+
+import ctypes
+import os
+import signal
+import sys
+import time
+
+import _damon_sysfs
+
+PMD_SIZE = 2 * 1024 * 1024
+MADV_HUGEPAGE = 14
+PROT_READ_WRITE = 0x1 | 0x2
+MAP_PRIVATE_ANON = 0x2 | 0x20
+REGION_SIZE = 32 * PMD_SIZE
+
+def child_workload():
+    '''Allocate a PMD-aligned, THP-backed region, fault it in, then idle.'''
+    libc = ctypes.CDLL('libc.so.6', use_errno=True)
+    libc.mmap.restype = ctypes.c_void_p
+    libc.mmap.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int,
+                          ctypes.c_int, ctypes.c_int, ctypes.c_long]
+    libc.madvise.argtypes = [ctypes.c_void_p, ctypes.c_size_t, ctypes.c_int]
+
+    # Over-allocate so that a PMD-aligned window is available.
+    raw = libc.mmap(None, REGION_SIZE + PMD_SIZE, PROT_READ_WRITE,
+                    MAP_PRIVATE_ANON, -1, 0)
+    if raw is None or raw == ctypes.c_void_p(-1).value:
+        os._exit(2)
+    base = (raw + PMD_SIZE - 1) & ~(PMD_SIZE - 1)
+    libc.madvise(ctypes.c_void_p(base), REGION_SIZE, MADV_HUGEPAGE)
+
+    buf = (ctypes.c_char * REGION_SIZE).from_address(base)
+    for off in range(0, REGION_SIZE, 4096):
+        buf[off] = 1
+
+    # Ready; idle until the parent tears us down.
+    signal.pause()
+
+def anon_huge_kb(pid):
+    total = 0
+    try:
+        with open('/proc/%d/smaps' % pid) as f:
+            for line in f:
+                if line.startswith('AnonHugePages:'):
+                    total += int(line.split()[1])
+    except FileNotFoundError:
+        return -1
+    return total
+
+def main():
+    if not os.path.exists('/sys/kernel/mm/transparent_hugepage/enabled'):
+        print('SKIP: transparent hugepage is not available')
+        exit(0)
+
+    pid = os.fork()
+    if pid == 0:
+        child_workload()
+        os._exit(0)
+
+    try:
+        # Give the child time to fault in its huge pages.
+        time.sleep(2)
+        before = anon_huge_kb(pid)
+        if before <= 0:
+            print('SKIP: workload did not get any THP (AnonHugePages=%d)'
+                  % before)
+            os.kill(pid, signal.SIGKILL)
+            exit(0)
+
+        # Split every large folio in the target down to order-0 base pages.
+        kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=pid)],
+                schemes=[_damon_sysfs.Damos(
+                    action='split',
+                    target_order=0,
+                    # match every region regardless of access/age/size, so
+                    # the ARM64 stale-TLB blind spot cannot mask the target
+                    access_pattern=_damon_sysfs.DamosAccessPattern(
+                        size=[0, 2**64 - 1],
+                        nr_accesses=[0, 2**64 - 1],
+                        age=[0, 2**64 - 1]),
+                    apply_interval_us=0)])])])
+        err = kdamonds.start()
+        if err is not None:
+            print('kdamonds start failed: %s' % err)
+            os.kill(pid, signal.SIGKILL)
+            exit(1)
+
+        # Let the scheme find and split the regions.
+        after = before
+        for _ in range(50):
+            time.sleep(0.2)
+            after = anon_huge_kb(pid)
+            if after == 0:
+                break
+
+        kdamonds.stop()
+        os.kill(pid, signal.SIGKILL)
+
+        if after >= before:
+            print('FAIL: AnonHugePages did not shrink: before=%d KiB '
+                  'after=%d KiB' % (before, after))
+            exit(1)
+        print('PASS: AnonHugePages %d KiB -> %d KiB after DAMOS_SPLIT'
+              % (before, after))
+    finally:
+        try:
+            os.kill(pid, signal.SIGKILL)
+        except ProcessLookupError:
+            pass
+
+if __name__ == '__main__':
+    main()
