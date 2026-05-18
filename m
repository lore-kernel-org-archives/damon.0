Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAC38F255
	for <damon@lists.linux.dev>; Mon, 18 May 2026 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131556; cv=none; b=gScjbvT/6A3402fYx5Ucyr4Qs68jzsFrb2TTn1MOLareAcRiXZ4eYxVEkzWsbGjynFXWTx707zA9qxGL+WQ5meJmebAAOHc3de9dBTOIzwa56BHUhixqXFAwNtNtZ4+Q2NZ0PnN9BwltGNsnq6+JXwW4NPtAP5yfVZ3W75b6k98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131556; c=relaxed/simple;
	bh=RljyayX1PyhhLkcz/gwwb9ZSAUXbtpbGzWUaxpfKHrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3khvWe/5xHMYWCiN9VA8TgrWp5q0N+XouUjwaE559VV+eyjTqfFSOFJNhMeFYlW51wNGIflEELgjM2p8Bpn8w4yGH/C0UbZ2C00T/y6GqrE03WNdYBTbhk626fWGHZsPUBaZ34kgBCRkOyKwicxXCZh+C3mWxLjmjhRjWXphnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKSmj5BR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKSmj5BR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso1408827f8f.0
        for <damon@lists.linux.dev>; Mon, 18 May 2026 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131550; x=1779736350; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8rvqbbv4pCegDpTmp8AOnsZ/Yo8hHTCvqhnXp9eK9A=;
        b=cKSmj5BRGvJT30FewfpSnoekKg9UWEwO7PiIlUhge61msDQxbJxt/GkV2YcNulIQZ4
         gzQIQ0wHvNfciykur2lQnHB3qcq9Njek3RB+Ai6Sy3pSeMeS0TiZ3Q0zvvDDkblJgs5n
         vXT7Y8ifT4ZckI5z7kgl5yGfZGTbh5sgQSBoJtcIo40UF4mPtN3gQePr/AuSaFGRb+Yj
         ejekIX2Ts5FY3cl/fBgYL2rhend3RotaEKkyZDBpg37VwZZQ+aP8H+jYGyyxbwVifNV3
         q31rBC2dRqLRG/3Oiu1nZc05MvSjBiP2itNL16Au0bz0SU6FiPfzfBhIDdL0KP0/uGad
         7M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131550; x=1779736350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8rvqbbv4pCegDpTmp8AOnsZ/Yo8hHTCvqhnXp9eK9A=;
        b=gIXp+6u/8HepN1F79d0m2jZ0J3hhHBiVg9nHWK/1wXN5p/WJI0zwKQkxznncWVvv4R
         c+39HoEZpFaOGH13FEpPLk/b7KxVLnf5x/1Zf4YSKRhfITYwck/d+g/PzAtHYVX8HUSH
         i+9OOiVRhzEsp1ObubmRyEkpE2MoNk7vw+U7z/b+DwRboYewZKFulJYkOZTFNPnnXec7
         l4USL9/l5AftRDZGdW4j/xPwDX4yRtGA/XMbN1vcMwRuCk/tpnpdfNzRSfCrRbmOiz2Y
         GOLdOMp8GPrKRivMITVRcSoZ8dBigXOjL8KaQ0HVLuYx9tciNIHfqRo8f7zX/WpMUCv+
         NNIA==
X-Forwarded-Encrypted: i=1; AFNElJ/ff2FNv9fX338/8ptcp79d42iR+oktsFZcEY4Otr8JRdidmZASO4OmTmd+f+wdDRzp5If56Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxroroAycdwis9uo1aKpdaLJKJc01Zak8zkzbm27FEL5aBoZ/gL
	PLOIBgqV3lprIHczjEqtKmXE0gkqN6bjh0OGsRxNVwkUz3NBbA4Zrq4m
X-Gm-Gg: Acq92OHEMdR+BENSpSo1YHViTGDW7rEALtmVBT+JeBSkcA3V90kvvsjbWxOQBPJcwQ5
	YFJ0tCIvCSxPz10XJAFC0fKcB+G3MB/OtspOxPfNGGt45vTm5JEeX2cxYM/+5HX3L4WiCCw4Gnu
	U1nlcbOvv1vfNZ+KSSaarcgso65Svm0hvrJceCWVAKBXuGyMsHsUsKknEwd+qLHzr8IEP570LUw
	h22cfu5BLTvPpjAkwJgL2OkcHoKQSppTz4osq97QFbtA+dKNlsH2QXMPrG/+34nS6q0axezIO8L
	05ZMgfLLS/PdIrocDwNCllHNJ8bo2PrmhUyXNc06MGwhoPsm261+y3b6d+4CDARKOPWbOUIsRX7
	B5fqoabN6aQDADhtnf83JrF3LmtDhkPeyOwES771C4qIFZfUBCJa3Ev9JZEzL3j5cp4/v1PbWA3
	DzUSQDSt4nZ0Gcj92l8Os8AxuoKwg9fGtNk+l2H3PIVP2DIinUK3zHc312tMi93g==
X-Received: by 2002:a05:6000:1247:b0:45e:6518:3299 with SMTP id ffacd0b85a97d-45e651832f5mr15730841f8f.5.1779131549508;
        Mon, 18 May 2026 12:12:29 -0700 (PDT)
Received: from mshcherba-RedmiBook-16.. ([188.163.115.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm40043167f8f.34.2026.05.18.12.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:12:29 -0700 (PDT)
From: Maksym Shcherba <mshcherba2000@gmail.com>
X-Google-Original-From: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
Subject: [PATCH 6/6] selftests/damon: add a test for update_schemes_quota_goals
Date: Mon, 18 May 2026 22:09:32 +0300
Message-Id: <20260518190932.42270-6-maksym.shcherba@lnu.edu.ua>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
References: <20260518190932.42270-1-maksym.shcherba@lnu.edu.ua>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new update_schemes_quota_goals sysfs command allows users to manually
update the current_value of quota goals.

Add a selftest for the command. The test writes a dummy value to
current_value, executes the update command, and verifies that the dummy
value is successfully overwritten by the kernel.

Assisted-by: Antigravity:Gemini-3.1-Pro
Signed-off-by: Maksym Shcherba <maksym.shcherba@lnu.edu.ua>
---
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/sysfs_update_schemes_quota_goals.py | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs_update_schemes_quota_goals.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 2180c328a825..a692ebaa6c8a 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS += sysfs.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
 TEST_PROGS += damos_tried_regions.py damon_nr_regions.py
+TEST_PROGS += sysfs_update_schemes_quota_goals.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 # regression tests (reproducers of previously found bugs)
diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_quota_goals.py b/tools/testing/selftests/damon/sysfs_update_schemes_quota_goals.py
new file mode 100755
index 000000000000..745b97f75bc2
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_quota_goals.py
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Test the update_schemes_quota_goals sysfs command.
+
+Start DAMON with a scheme that has a some_mem_psi_us quota goal.  Write a
+physically impossible dummy value to the goal's current_value sysfs file.
+Wait for a while, ensure the dummy value is not overwritten asynchronously,
+then write 'update_schemes_quota_goals' to the state file and verify that
+the dummy value is overwritten by the kernel.
+"""
+
+import os
+import time
+
+import _damon_sysfs
+
+
+def main():
+    goal = _damon_sysfs.DamosQuotaGoal(
+            metric=_damon_sysfs.qgoal_metric_some_mem_psi_us,
+            target_value=1000)
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='paddr',
+                schemes=[_damon_sysfs.Damos(
+                    action='stat',
+                    quota=_damon_sysfs.DamosQuota(
+                        goals=[goal], reset_interval_ms=100),
+                    )]  # schemes
+                )]  # contexts
+            )])  # kdamonds
+
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    # Write a dummy value to current_value to ensure the command actually
+    # overwrites it. We use 2x the quota reset interval in microseconds,
+    # which is a physically impossible value for the kernel to measure.
+    impossible_value = goal.quota.reset_interval_ms * 2000
+    err = _damon_sysfs.write_file(
+            os.path.join(goal.sysfs_dir(), 'current_value'),
+            '%d' % impossible_value)
+    if err is not None:
+        kdamonds.stop()
+        print('Writing dummy current_value failed: %s' % err)
+        exit(1)
+
+    # wait a couple of aggregation intervals so that the kernel has a chance
+    # to compute the first current_value measurement
+    time.sleep(0.5)
+
+    content, err = _damon_sysfs.read_file(
+            os.path.join(goal.sysfs_dir(), 'current_value'))
+    if err is not None:
+        kdamonds.stop()
+        print('Reading current_value before update failed: %s' % err)
+        exit(1)
+    if int(content) != impossible_value:
+        kdamonds.stop()
+        print('current_value changed before update (%s)' % content)
+        exit(1)
+
+    err = kdamonds.kdamonds[0].update_schemes_quota_goals()
+    if err is not None:
+        kdamonds.stop()
+        print('update_schemes_quota_goals failed: %s' % err)
+        exit(1)
+
+    # current_value must be updated and different from our dummy value
+    if goal.current_value is None or goal.current_value == impossible_value:
+        kdamonds.stop()
+        print('update_schemes_quota_goals failed to update current_value')
+        exit(1)
+
+    print('current_value after update_schemes_quota_goals: %d' %
+          goal.current_value)
+
+    kdamonds.stop()
+
+
+if __name__ == '__main__':
+    main()
-- 
2.43.0

