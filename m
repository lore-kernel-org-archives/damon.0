Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751B298CD7
	for <damon@lists.linux.dev>; Sat,  9 Aug 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754744893; cv=none; b=IVFS6DDSxZphsA8JzBz3HtOHeSKr9tKzGVNxNL6UBYtagBCGgX1wwqg9C4HVp+AfvlWERqP17Boiw9FwfowoGPompaDK/LlynT6ORnbF8Sm2udOtu6PNfLpvvH1lr/wotKsi5l4QujPkDwud/2KFcqtyeapWCqJCXuiqyS+A+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754744893; c=relaxed/simple;
	bh=HQNmj4ADGnraIrHVGpp30wYTtxeRcrQVoc0KRyjgRkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geNkhuZYbx6yywsguYIXOKYqkurMTEEsQ/yc/++F3DrrC9l5CLSZLP3emfup3Ov4bTmn+yyQLmd26PnLR6XzvAus2hFvujcWEtINW6Gu/nkn4/vbj5Ikif7l6/yVqaPfBYLR8h1fIVoWP1Yu1ac1idEmB7Une93RucFfUJqMC1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQMEd0Gb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQMEd0Gb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so3230356b3a.2
        for <damon@lists.linux.dev>; Sat, 09 Aug 2025 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754744891; x=1755349691; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5iH9iV5VsYBnBlg9QnKRLf9bBCyT3yBhK5kP+dnWFA=;
        b=XQMEd0GbK81N6IM7duxOFM/HTtfgsFXoPpkgtikMNHKL76839xxAuyfKZrNHy7BL6x
         IjeM30wRRLGfP978KjVTUKudNxn4kH13M/cFH+KKwgtg5Z2hfDujOkNjhZF39NMURPWE
         qPKLlKyvUCUNCEDlJ1HKBbgotf78FQzMffdNlTxnc/BSigUT6tqhZFm+u29aoMA3GxGo
         +1gj1LjfywDFRJ9VAE+DPaB64cBuwrOLeVrF6tpU4Xknszfoaz/intyAP3lVzl/HvT13
         XHDeMlBg5L7hQ8Oqm7yuyLLJmApwNF5AJhDZWf3wSjj045WCk9LykCMbMyyTfshOVyWD
         ilJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754744891; x=1755349691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5iH9iV5VsYBnBlg9QnKRLf9bBCyT3yBhK5kP+dnWFA=;
        b=wv3K1MUqpt8jSeAJ+MX5XRfSL7djz5YwuarsNxDTGAiV7q6YGHoDLvPxi3vQszJxEs
         ivRhJVfpc4NSbNJ5XS5RjCD8ukgn3R3Av5WKiRwVqewmVKTmUs7dWqNRYYQPCcIH6yjP
         z0n7OH6S3tLDdTyGQTjIjKIRrF782AESdxKOqeOTEmaNgtTSVYGbz8i8Wr3mXnR7LSn7
         485NTOevWjPfwpRH0C08z6v1RYMyv9X4qIK0kGGg7hPn+JunUZuz/grcLMvbv4vYaqT3
         u1qn4S658h6awSOxdeXayx4tVqi++kukx/VzSGv1izgm8/ahtCIw38W2vAokuhezgsB/
         1kSw==
X-Gm-Message-State: AOJu0YxhfqthuNnn+Whu+EgDqzvdroShmtCKjDcv+x5jBAAuD53NxDaG
	vIKKTiex6EKEa2zAH4XJT/29g42bg0tJHlj5D8rZSrxn+uyIlqdtIc0b
X-Gm-Gg: ASbGncvI9PP/pURHxTMZk/kzttVU6a3spZHHmVX3pwBXJZAzs1I2yk4PNeXkckvgiwa
	z28VEF23M8USUfCdDtnwXa7OcRKQpglRkZT0bUlWs8d9hcvxlsWZeg6nEVlfVyBOLb5OYaozzWf
	manQDly2tQdaGkahnlTYH01oWjug7OQid+tSnlRQ+3iFtGoZJ9iGG9vjoQRhfl/w3d0nVO4yfLw
	jFeGlcS8mZd0XOsWGV+Z2u8nByRfUdFum9IeAm5A60t/nohO1ef/wvvRcY17w2V+Wlci9T2Ynkp
	0Hu77XGGJZEXg1RMj3dnVQc5u2bLFv6uVySC312UTVL2Lm2w2CRj+kwlkEu7b8aklv7mFfP4mnu
	+IKjC2jZ7eOs2GU0hgl6/+yBh9Z0=
X-Google-Smtp-Source: AGHT+IH1ZRbmHfcbnjxqSE/cWx/E98HxIo+TMBcEPKIJ/oKES8p1wHfnek7BsNybm9elxKdvynFtTA==
X-Received: by 2002:a05:6a00:1389:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-76c46111288mr9692926b3a.15.1754744891501;
        Sat, 09 Aug 2025 06:08:11 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8d70sm22567165b3a.105.2025.08.09.06.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:08:11 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/core: fix commit_ops_filters by using correct nth function
Date: Sat,  9 Aug 2025 22:07:56 +0900
Message-ID: <20250809130756.637304-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
iterates core_filters. As a result, performing a commit unintentionally
corrupts ops_filters.

Add damos_nth_ops_filter() which iterates ops_filters. Use this function
to fix issues caused by wrong iteration.

Also, add test to verify that modification is right way.

Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
Changes from v1 [1]:
1. Fix code and commit message style.
2. Merge patch set into one patch.
3. Add fixes and cc section for backporting.

[1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@gmail.com/

---
I tried to fix your all comments, but maybe i miss something. Then
please let me know; I'll fix it as soon as possible.

---
 mm/damon/core.c                               | 14 +++-
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/sysfs_no_op_commit_break.py         | 72 +++++++++++++++++++
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_break.py

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 883d791a10e5..19c8f01fc81a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, struct damos *s)
 	return NULL;
 }
 
+static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
+{
+	struct damos_filter *filter;
+	int i = 0;
+
+	damos_for_each_ops_filter(filter, s) {
+		if (i++ == n)
+			return filter;
+	}
+	return NULL;
+}
+
 static void damos_commit_filter_arg(
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst, struct damos *src)
 	int i = 0, j = 0;
 
 	damos_for_each_ops_filter_safe(dst_filter, next, dst) {
-		src_filter = damos_nth_filter(i++, src);
+		src_filter = damos_nth_ops_filter(i++, src);
 		if (src_filter)
 			damos_commit_filter(dst_filter, src_filter);
 		else
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
index 000000000000..fbefb1c83045
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
+        print(err)
+        exit(1)
+
+    kdamonds.kdamonds[0].commit()
+
+    after_commit_status, err = \
+        dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
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

