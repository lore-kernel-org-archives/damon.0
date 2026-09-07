Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D7481643
	for <damon@lists.linux.dev>; Mon,  7 Sep 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784543; cv=none; b=c7jICcSkuQRYcoc8cW4RikHEvz35K62RzrexzTvB8DYCh4O1AX4PBYNKpLw4waEr+9FhiStbLkJdN1TbfxYFDn598ozpcQSypxoXEuSgboA2PKM6MXUP+Lpc8ccrXEf8CZC3jsfJiZgkDxi3SxPR/Bp+6CjFjgd8mG0vG7cpnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784543; c=relaxed/simple;
	bh=9Vrwldiu86hCVdvrUFji2IlPOad8eDYhb/cvDGNbV4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFExSl0eaAV1+vvI+9/pHZGMzMqWEHWgZPa2mgXHSYjOVmFXqbNezdMAwgtC8qLrgItWt3urWrgOVn5UmB57JeYGGqXKL7qx7048CroZUsXTW64Fba8IMHcEF5zWJaf9C2FtWZ+i8pi1SPqyJZ0srHSaB/ukbBrR2wzEJCZf24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lcJ83g4z; arc=none smtp.client-ip=91.218.175.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lcJ83g4z"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=9Vrwldiu86hCVdvrUFji2IlPOad8eDYhb/cvDGNbV4A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788784539; v=1; x=1789389339;
 b=lcJ83g4zbHvajjG1A5pCCisB4R1piB2l8oeV+jSZU24z6V/MRqUe/aeRM9hX+0p8eCV1ssEC
 Sj8+4VYhMjb7ziRqjKVFDCZW1yLGKpIl4q5IUCLyydVVvGzp2dC8rQHDO1RkGu/Kvx9TIlXA8Yr
 LDYY1oU26//hrbTyvyZ8iZG4=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 83939cb49fa7006e;
	Mon, 07 Sep 2026 12:35:31 +0000
X-Mizu-Trace-ID: 83939cb49fa7006e
X-Migadu-Flow: FLOW_OUT
From: Zenghui Yu <zenghui.yu@linux.dev>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	ekffu200098@gmail.com,
	"Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: [PATCH] selftests/damon: stop kdamond on error exits of no-op commit test
Date: Mon,  7 Sep 2026 20:34:55 +0800
Message-ID: <20260907123455.67246-1-zenghui.yu@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

The sysfs_no_op_commit_break test starts a kdamond via sysfs, but its error
paths (e.g., drgn not installed) exit without stopping it.  The leaked
kdamond then makes subsequent tests, e.g. lru_sort.sh and reclaim.sh, skip
with "Another kdamond is running".

Wrap the post-start logic in try-finally so that kdamonds.stop() is
executed on every exit path.

Fixes: 10725cd2b09a ("selftests/damon: test no-op commit broke DAMON status")
Assisted-by: GLM-5.3 OpenCode
Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
---
 .../damon/sysfs_no_op_commit_break.py         | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
index 2c65cffe6b54..81774ddc55ac 100755
--- a/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
+++ b/tools/testing/selftests/damon/sysfs_no_op_commit_break.py
@@ -47,26 +47,27 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
 
-    before_commit_status, err = \
-        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print('before-commit status dump failed: %s' % err)
-        exit(1)
+    try:
+        before_commit_status, err = \
+            dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+        if err is not None:
+            print('before-commit status dump failed: %s' % err)
+            exit(1)
 
-    kdamonds.kdamonds[0].commit()
+        kdamonds.kdamonds[0].commit()
 
-    after_commit_status, err = \
-        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print('after-commit status dump failed: %s' % err)
-        exit(1)
-
-    if before_commit_status != after_commit_status:
-        print(f'before: {json.dumps(before_commit_status, indent=2)}')
-        print(f'after: {json.dumps(after_commit_status, indent=2)}')
-        exit(1)
+        after_commit_status, err = \
+            dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+        if err is not None:
+            print('after-commit status dump failed: %s' % err)
+            exit(1)
 
-    kdamonds.stop()
+        if before_commit_status != after_commit_status:
+            print(f'before: {json.dumps(before_commit_status, indent=2)}')
+            print(f'after: {json.dumps(after_commit_status, indent=2)}')
+            exit(1)
+    finally:
+        kdamonds.stop()
 
 if __name__ == '__main__':
     main()
-- 
2.53.0

