Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEA2580C7;
	Sat, 28 Jun 2025 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126678; cv=none; b=TcCBq0MkXamWzzh2Gs2+3SmeYBA57K+s7i2TXtE99zUL5YzAJk0nE/mgMrYdpLB1xIGFzvOavJQvo2j8v414euKSEh0TNdWdfLSTzTsnP61pwVk8dj9yvra47bZ3fMqvJOJUNs/JO+Wg2iwn2tNgnAc+TNV9UKOiWkg3wNGgAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126678; c=relaxed/simple;
	bh=CR4mzDVLH9lzs9or4TF7dOJ0izoFCJ1YoukXbycwrC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXDku1Zzrf9LQap7KJ6mgl/271Irjbai8YhpIfUfPtNv15GCw8SkU5CnVJOGPVyT6cyRI7tydWWGKkjI2DnzMO1SDt0Pye9f5rInAdTPyGoh9f8tTDzxsKVEwJnxBCFIjnt2YbJhy4GLkCH0IqGMZ+FTVJfi9ZH9sVKaBfkKH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6oAy2GB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6oAy2GB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B283C4CEF0;
	Sat, 28 Jun 2025 16:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126678;
	bh=CR4mzDVLH9lzs9or4TF7dOJ0izoFCJ1YoukXbycwrC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6oAy2GBVbt4l+KFZyXRM8kh35N4U8lVQGix7E1seh2aEqJWlJnZKqAT1/hKE6Fx6
	 6pKD9W5+k1YYTdaN3DtWzS+tLrS/itSXxtF9SMV0Dui13mWa9hDvjiJP/xdfltRrt5
	 uTZk3Gqgbw03Fsedi5/hL1Qpf+q0ULC8pPBhHEzSw2fsI+Coz9r8Ig5VsNDFVmQcK1
	 PzozoYQ8DBmTx5Mnc/15svxPZWDwvxI0xGcsLrLYVpNvtC//zGtDu1cSxBzHtl053D
	 BYST/3m3APnENUjq2cdRbZd/O2NaN9kJ0bA1yr1Cheox4+em/UK5KkEu0Rq5MlLpYb
	 Z+n8MXWtNKIgQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] selftests/damon/sysfs.py: test DAMOS schemes parameters setup
Date: Sat, 28 Jun 2025 09:04:28 -0700
Message-Id: <20250628160428.53115-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628160428.53115-1-sj@kernel.org>
References: <20250628160428.53115-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMON sysfs interface functionality tests for basic DAMOS schemes
parameters setup.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 46 ++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3b085268f342..e67008fd055d 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -29,7 +29,9 @@ def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
                 contexts=[_damon_sysfs.DamonCtx(
-                    targets=[_damon_sysfs.DamonTarget(pid=-1)])])])
+                    targets=[_damon_sysfs.DamonTarget(pid=-1)],
+                    schemes=[_damon_sysfs.Damos()],
+                    )])])
     err = kdamonds.start()
     if err is not None:
         print('kdamond start failed: %s' % err)
@@ -66,8 +68,46 @@ def main():
             { 'pid': 0, 'nr_regions': 0, 'regions_list': []}]:
         fail('adaptive targets', status)
 
-    if ctx['schemes'] != []:
-        fail('schemes')
+    if len(ctx['schemes']) != 1:
+        fail('number of schemes', status)
+
+    scheme = ctx['schemes'][0]
+    if scheme['pattern'] != {
+            'min_sz_region': 0,
+            'max_sz_region': 2**64 - 1,
+            'min_nr_accesses': 0,
+            'max_nr_accesses': 2**32 - 1,
+            'min_age_region': 0,
+            'max_age_region': 2**32 - 1,
+            }:
+        fail('damos pattern', status)
+    if scheme['action'] != 9:   # stat
+        fail('damos action', status)
+    if scheme['apply_interval_us'] != 0:
+        fail('damos apply interval', status)
+    if scheme['target_nid'] != -1:
+        fail('damos target nid', status)
+
+    if scheme['quota'] != {
+            'reset_interval': 0,
+            'ms': 0,
+            'sz': 0,
+            'goals': [],
+            'esz': 0,
+            'weight_sz': 0,
+            'weight_nr_accesses': 0,
+            'weight_age': 0,
+            }:
+        fail('damos quota', status)
+
+    if scheme['wmarks'] != {
+            'metric': 0,
+            'interval': 0,
+            'high': 0,
+            'mid': 0,
+            'low': 0,
+            }:
+        fail('damos wmarks', status)
 
     kdamonds.stop()
 
-- 
2.39.5
