Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150B79FE
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829874; cv=none; b=u9COB5LUgA1+TZdBIMM+UO2PNBErYgYkOhQgYwUtZ7u3vyxJalmBnnrOPLjRLXUxD+FnBEd1Ap8sX4u0J006plOiQXMqD0waBnBd4S3ydpJ2TbMqVFg2k7HRpX5RzEKeMv/Pjg68hbIebB5uw2UmKJ4v1/VPbvjJwJSx6ubUa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829874; c=relaxed/simple;
	bh=wgaWyQQ2K7tee24HIVlgvI0TYkaBncBEZ2WQCov1j4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzcJz+kET4l56grF2jAncl4yLCAND+uWIJ22Q+VHxcJc2ZhIY4Ny+I+DAo745fJyGajFC2tB68Wt8NwXBZ+9/JjUhIFX0V6fHI/m0leiO7EAc01RRpEYDa0fxf8uoOQUzk8sYDYVw7SAEDMG5+hCHlacLaBu1tt5f203zPxXAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBTpVj2P; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBTpVj2P"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2403c13cac3so32053515ad.0
        for <damon@lists.linux.dev>; Sun, 10 Aug 2025 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754829872; x=1755434672; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FfOrnWM3dz1xxRzfbBuR+it2dfZAAWRE207h/Loxxew=;
        b=VBTpVj2P5Esfo7b2sbrBc9krxx1pdOfusTQHrFiCH71JhEHWfXltuL5jJcwkrnslKz
         2bRFVxvVKX4vndZQDiSIyD2Zpg7u65uZ8esSNc4PPFjanreDj85dspQ2ok8xkqjlIn1Q
         q9n1mFTurxgFlQu16udZp8WZHrUOBYaV+FUxLGC3U5Be6gwphBT3pAz9Gdf0Mn3EnKbI
         INLTZAuKzkoWneSp9yTcPofBqIKHjvLF/Oau7cF3ak5Ge1ReqNDMMUcMutLhDJQdLisT
         xPt6dkna7C8Ajpedsrp4PeCAEOSZOJS+EhO8yzT90ZXfRGXD01s4cdqB6lr4cHNtHgP3
         g4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829872; x=1755434672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfOrnWM3dz1xxRzfbBuR+it2dfZAAWRE207h/Loxxew=;
        b=FiQgh2+66npfwL+PxyCYCnV80M/zRjSznRwBGP627DLzqcPPixd65m0A4UoPi3kDkK
         lJHb5rPovn0FW/DpqbSR2uRVXt6g1IQBK5gpauSnM10bib17tvyJGFXsGQ5ph6KLFiGa
         egzdBTOWz0zZKiNmNGPQQJHmcIlNjBPqrtGM0fPt00s64/+dd4Wrtis2PsfV3UUCLWsB
         KQkce8ccr/2miK7/hkrIe0g6a1eHCtxhjFUZU+nuggoVuL+xSx9mu6AhDqik6rZcsAXA
         QAh7qDinvp6BS7ETBH/0dyKXEVagBcmEERLkBYqhRgAV2iRIg4PAoPqyZW1Y0gbCLxqh
         ZP/w==
X-Gm-Message-State: AOJu0Yy90CdqebNjWinxdJl0rmPgRTO2uxG0jmwn/XIjdkKGOtiFf+bE
	SrjYtjhoCR6CV4T/D7WMQPU2oWrKhq1iVY0+yzuy9Tq6oaIKMlICP8i3827QhuZ1qMQ=
X-Gm-Gg: ASbGnctGowm5ukRnHqqUEPmYUNqa+iUiJpHSRoTyWsgiMI29q4h5YqkMhMmVkKj9Z9+
	M7KgwWxt0ZnkszhE2zFn0OaZZrK1fkhq2FBDgQc0LVuj4uN2gl44iszen6XRffU42HFSOd6vh2q
	FB14GZqqp13SaGyYtJImuiVpCQhQviT3YaUFvuwcBGs+jfXpW7ZsaTtEbDTE73CgKaGUe4G/pFO
	rXm2XzENiFJ1eVIzFD90PtLrCbymJ5SApjjmxiJHs5h/25hI9q8HcpN9VvNJrDyP+bXtWWexr2G
	SPox2qBgae4/EOQe8wIv2VFxGCDqblgBTL5c0VGufjauk7mzLP9VVG9sQzSejc3giQjEPQDkDpx
	2ynmAfxVOFLA9NfoimwqtuF3zLDg=
X-Google-Smtp-Source: AGHT+IHlnrDzNUlEjaspG6Ocwq4Tq6JJYSITlJZZRbXdmm5CCglSMHWLfgj2UX0ke4KZ9xBvqmGShQ==
X-Received: by 2002:a17:903:2ec4:b0:23f:c760:fe02 with SMTP id d9443c01a7336-242b0620e7amr206206465ad.9.1754829871651;
        Sun, 10 Aug 2025 05:44:31 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f101e1sm248908915ad.58.2025.08.10.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:44:31 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v3] selftests/damon: test no-op commit broke DAMON status
Date: Sun, 10 Aug 2025 21:43:54 +0900
Message-ID: <20250810124354.16456-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to verify that DAMON status is not changed after a no-op
commit.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/sysfs_no_op_commit_break.py         | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
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
index 000000000000..f557587ebc81
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -0,0 +1,72 @@
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
+        return None, f'drgn fail: return code({rc})'
+    try:
+        with open('damon_dump_output', 'r') as f:
+            return json.load(f), None
+    except Exception as e:
+        return None, 'json.load fail (%s)' % e
+
+def main():
+    kdamonds = _damon_sysfs.Kdamonds(
+        [_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                schemes=[_damon_sysfs.Damos(
+                    ops_filters=[
+                        _damon_sysfs.DamosFilter(
+                            type_='anon',
+                            matching=True,
+                            allow=True,
+                        )
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
+    before_commit_status, err = \
+        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print('before-commit status dump failed: %s' % err)
+        exit(1)
+
+    kdamonds.kdamonds[0].commit()
+
+    after_commit_status, err = \
+        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print('after-commit status dump failed: %s' % err)
+        exit(1)
+
+    if before_commit_status != after_commit_status:
+        print(f'before: {json.dump(before_commit_status, indent=2)}')
+        print(f'after: {json.dump(after_commit_status, indent=2)}')
+        exit(1)
+
+    kdamonds.stop()
+
+if __name__ == '__main__':
+    main()
-- 
2.43.0

